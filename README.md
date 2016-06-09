Family History in CPRS
======================

Family Hostory in CPRS is an enhancement to CPRS that adds Family Historical Data to CPRS/VistA.

Dependencies
------------
- Delphi
- Microsoft Windows 7 / 10 
- Intersystems Caché 
- VistA
    - Family History specific KIDs build

Prerequisites
-------------
- Install Vagrant (see: https://www.vagrantup.com/docs/installation/ )
- Install VirtualBox (see: https://www.virtualbox.org/wiki/Downloads )
- Install Git (see: operating system specific instructions ) 

Installation
------------
This automated installation process will create a VistA system on a Linux-based virtual machine.

- Open your terminal application such as a shell under Linux, Command Prompt under Windows, or Terminal.app on Mac.
- Clone this repository: git clone https://github.com/VHAINNOVATIONS/FamilyHistoryCPRS.git
- Use the cd command to go to the root folder of the repository
- Type the following command to build the VistA system:
```
vagrant up
```
To provision in AWS adjust your environment variables or modify the 'aws' section of the Vagrantfile and execute:

To provision with AWS as your provider you will need to adjust line 25 of provision/cache/parameters.isc
to contain the username you are using in AWS:
```
security_settings.manager_user: vagrant
```
~By default the username is set to 'vagrant'

If you change this, you need to understand that everywhere in this document where the username
'vagrant' is used, your new username would be used instead. 

To change the name you will need to run the following where 'ec2-user' is your preferred username:

NOTE: The space before vagrant and ec2-user in the example is not a typo.
```
sed -i -e 's/ vagrant/ ec2-user/' /vagrant/provision/cache/parameters.isc
```

Afterwards, you can build the machine in AWS as follows:
```
vagrant up --provider=aws
```

To connect to roll and scroll VistA to install Family History KIDS build for RAPTOR
```
vagrant ssh
csession cache
```
at prompt enter credentials with username: vagrant and password: innovate
```
D ^%CD
```
at namespace prompt enter:
```
VISTA
```
Type the following to get a prompt for access/verify code:
```
D ^ZU
```
Enter access/verify code pair: CPRS1234/CPRS4321$
```
Select Systems Manager Menu <TEST ACCOUNT> Option: ^^load a distribution
Enter a Host File: /srv/mgr/XXXXXXXXX.KID

Select Installation <TEST ACCOUNT> Option: INSTALL Package(s)
Select INSTALL NAME: KNR FAMILY HISTORY 1.0      9/9/15@23:32:19
     => KNR FAMILY HISTORY BUILD 9-9-15

This Distribution was loaded on Sep 09, 2015@23:32:19 with header of 
   KNR FAMILY HISTORY BUILD 9-9-15
   It consisted of the following Install(s):
KNR FAMILY HISTORY 1.0
Checking Install for Package KNR FAMILY HISTORY 1.0

Install Questions for KNR FAMILY HISTORY 1.0

Incoming Files:


   500003    KNR FAMILY HISTORY
Note:  You already have the 'KNR FAMILY HISTORY' File.


   500005    KNR FH RACE  (including data)
Note:  You already have the 'KNR FH RACE' File.
I will OVERWRITE your data with mine.


   500007    KNR FH ETHNICITY  (including data)
Note:  You already have the 'KNR FH ETHNICITY' File.
I will OVERWRITE your data with mine.


   500009    KNR FH DISEASE GROUP  (including data)
Note:  You already have the 'KNR FH DISEASE GROUP' File.
I will OVERWRITE your data with mine.


   500011    KNR FH HERITABLE DISEASES/CONDITIONS  (including data)
Note:  You already have the 'KNR FH HERITABLE DISEASES/CONDITIONS' File.
I will OVERWRITE your data with mine.


   500013    KNR FH RELATIONSHIP  (including data)
Note:  You already have the 'KNR FH RELATIONSHIP' File.
I will OVERWRITE your data with mine.


   500015    KNR RELATIVE
Note:  You already have the 'KNR RELATIVE' File.


   500017    KNR RELATIVE DISEASES/CONDITIONS
Note:  You already have the 'KNR RELATIVE DISEASES/CONDITIONS' File.


   500019    KNR FH AGE  (including data)
Note:  You already have the 'KNR FH AGE' File.
Want my data to overwrite yours? YES// YES


Want KIDS to INHIBIT LOGONs during the install? NO// ^
 
KNR FAMILY HISTORY 1.0 Build will not be installed
               Sep 09, 2015@23:35:06

```

Credentials
-----------

Resident access/verify: 1radiologist/cprs1234$
Radiologist access/verify: radio1234/Rad12345!
Scheduler access/verify: cprs1234/cprs4321$

VistA Terminal Session
----------------------
```
csession cache -U VISTA "^ZU"
```
username: vagrant 
password: innovate 

Troubleshooting
---------------
Cache
-----
ERROR MESSAGE:

Crash on D ^ZU

> VistA logon (the ZU program) displays
>         "** TROUBLE ** - ** CALL IRM NOW! **"
> if the number of available jobs drops below 3. For those of us with
> small Cache licenses, this is a permanent condition, so you may decide
> to edit the ZU program to change the threshold.

Caused by not having a valid license key with enough seats.

ref: https://www.mail-archive.com/hardhats-members@lists.sourceforge.net/msg01755.html 

