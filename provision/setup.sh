#!/bin/bash -xi

# set username
myusername=$USER
# set up base box through vagrant file with these commands
cacheInstallerPath=/vagrant/provision/cache 
cacheInstaller=cache-2014.1.3.775.14809-lnxrhx64.tar.gz
parametersIsc=parameters.isc 
cacheInstallTargetPath=/srv 
# configure selinux ###################
#
echo configuring ipv4 firewall
echo -----------------------
sudo service iptables stop
sudo cp /vagrant/provision/iptables /etc/sysconfig/
sudo service iptables start 

# install EPEL and REMI Repos ##################
#
echo installing epel-release and remi for CentOS/RHEL 6
echo --------------------------------------------------
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
# sed -i s'/enabled=1/enabled=0/' /etc/yum.repos.d/remi.repo
sudo cp /vagrant/provision/remi.repo /etc/yum.repos.d/

# Install Apache, PHP, and other tidbits ##############
#
echo installing basic common tidbits
sudo yum -y install parted vim zip unzip wget 

# install Nodejs and Development Tools such as gcc & make
sudo yum -y groupinstall 'Development Tools'

sudo groupadd cacheserver

# get cache installer
if [ -e "$cacheInstallerPath/$cacheInstaller" ]; then
  echo "Cache installer is already in present..."
else
  echo "downloading Cache installer..."
  wget -P $cacheInstallerPath/ http://vaftl.us/vagrant/cache-2014.1.3.775.14809-lnxrhx64.tar.gz
fi

if [ -e "$cacheInstallerPath/$cacheInstaller" ]; then
  echo "Installing Cache from: $cacheInstaller"
  # install from tar.gz 
  sudo mkdir -p $cacheInstallTargetPath/tmp
  cd $cacheInstallTargetPath/tmp
  sudo cp $cacheInstallerPath/$cacheInstaller .
  sudo tar -xzvf $cacheInstaller   

  # set user in parameters file to match $myusername
  #sed -i -e `s/ vagrant/$myusername/` $cacheInstallerPath/parameters.isc

  # install from parameters file
  sudo $cacheInstallTargetPath/tmp/package/installFromParametersFile $cacheInstallerPath/parameters.isc
else
  echo "You are missing: $cacheInstaller"
  echo "You cannot provision this system until you have downloaded Intersystems Cache"
  echo "in 64-bit tar.gz format and placed it under the provision/cache folder."
  exit
fi

# add vista and vagrant to cacheusr group
sudo usermod -a -G cacheusr vagrant

## add disk to store CACHE.DAT was sdb 
#parted /dev/sdb mklabel msdos
#parted /dev/sdb mkpart primary 0 100%
#mkfs.xfs /dev/sdb1
#mkdir /srv
#echo `blkid /dev/sdb1 | awk '{print$2}' | sed -e 's/"//g'` /srv   xfs   noatime,nobarrier   0   0 >> /etc/fstab
#mount /srv

# stop cache
sudo ccontrol stop cache quietly

if [ -e "$cacheInstallerPath/CACHE.DAT" ]; then
  echo "CACHE.DAT is already present... copying to /srv/mgr/"
  echo "This will take a while... Get some coffee or a cup of tea..."
  sudo mkdir -p $cacheInstallTargetPath/mgr/VISTA
  sudo cp -R $cacheInstallerPath/CACHE.DAT /srv/mgr/VISTA/
else
  echo "$cacheinstallerpath/CACHE.DAT not found... downloading..."
  sudo mkdir -p $cacheInstallTargetPath/mgr/VISTA 
  sudo chown -R $myusername:cacheusr $cacheInstallTargetPath/mgr/VISTA
  echo "This will take a while... Get some coffee or a cup of tea..."
  wget -P $cacheInstallTargetPath/mgr/VISTA/ http://vaftl.us/vagrant/CACHE.DAT 
fi

echo "Setting permissions on database."
sudo chown -R vagrant:cacheusr /srv
sudo chmod g+wx /srv/bin
sudo chmod 775 /srv/mgr/VISTA 
sudo chmod 660 /srv/mgr/VISTA/CACHE.DAT
sudo chown -R vagrant:cacheusr /srv/mgr/VISTA 

# copy cache configuration
echo "Copying cache.cpf configuration file..."
sudo cp $cacheInstallerPath/cache.cpf $cacheInstallTargetPath/

# start cache 
sudo ccontrol start cache

# enable cache' os authentication and %Service_CallIn required by EWD.js 
csession CACHE -U%SYS <<EOE
vagrant
innovate
s rc=##class(Security.System).Get("SYSTEM",.SP),d=SP("AutheEnabled") f i=1:1:4 s d=d\2 i i=4 s r=+d#2
i 'r s NP("AutheEnabled")=SP("AutheEnabled")+16,rc=##class(Security.System).Modify("SYSTEM",.NP)

n p
s p("Enabled")=1
D ##class(Security.Services).Modify("%Service_CallIn",.p)

h
EOE

# install XXXXXXXX ~KNR FAMILY HISTORY 1.0 KIDS into VistA
# todo: this doesn't work because it doesn't see device(0) ~something with c-vt320? vt320 doesn't 
# work either...
cp /vagrant/OtherComponents/VistAConfig/VEFB_1_2.KID /srv/mgr/
csession CACHE -UVISTA "^ZU" <<EOI
cprs1234
cprs4321$
^^load a distribution
/srv/mgr/VEFB_1_2.KID
yes
^^install package
VEFB 1.2
no
no

^
^
h
EOI

# user notifications 
echo VistA is now installed.  

echo CSP is here: http://192.168.33.11:57772/csp/sys/UtilHome.csp
echo username: cache password: innovate 
echo See Readme.md from root level of this repository... 
echo CPRS with Family History KIDS is now installed
echo Compile the source and create a shortcut pointing to the
echo VistA system.  RPC is listening on 192.168.33.11 port 9250 
