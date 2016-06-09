unit fFamHistEdit;

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fPage, StdCtrls, Menus, ORCtrls, ORFn, ExtCtrls, ComCtrls, uConst,
  ORNet, uPCE, uCore, rCore, fFrame, fBase508Form, VA508AccessibilityManager,
  Vcl.ImgList, uFamHistoryGlobals;

type

  TfrmFamHistEdit = class(TfrmBase508Form)

    pnlMain: TPanel;
    Label9: TLabel;
    Label4: TLabel;
    memComment: TCaptionMemo;
    btnCancel: TButton;
    btnOK: TButton;
    GroupBox2: TGroupBox;
    rbNotThisVisit: TRadioButton;
    rbFHDeclines: TRadioButton;
    rbFHLimitedFife: TRadioButton;
    tvDiseases: TTreeView;
    Label10: TLabel;
    grpbxJewAnc: TGroupBox;
    rbJewAncYes: TRadioButton;
    rbJewAncNo: TRadioButton;
    rbJewAncUnknown: TRadioButton;
    Label7: TLabel;
    ORcmbEthnicity: TORComboBox;
    Label6: TLabel;
    ORcmbxRace: TORComboBox;
    GroupBox3: TGroupBox;
    Label13: TLabel;
    rbStatusUnknown: TRadioButton;
    rbStatusNo: TRadioButton;
    rbStatusYes: TRadioButton;
    lblAgeRelative: TLabel;
    lblAgeDeath: TLabel;
    cmbxAgeDeceased: TORComboBox;
    lblTypeRelat: TLabel;
    ORcmbTypeRelat: TORComboBox;
    Label2: TLabel;
    ORcmbAgeDX: TORComboBox;
    Label5: TLabel;
    edFHName: TEdit;
    Label1: TLabel;
    rbJewishDeclined: TRadioButton;
    rbAdopted: TRadioButton;
    rbLimitedTime: TRadioButton;
    Memo1: TMemo;
    btnVerifySelect: TButton;
    sbMessages: TStatusBar;
    edCurrAge: TEdit;
    Label3: TLabel;

    procedure rbStatusYesClick(Sender: TObject);

    procedure rbStatusNoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvDiseasesAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
     procedure btnOKClick(Sender: TObject);
    procedure GroupBox2DblClick(Sender: TObject);
    procedure rbFHLimitedFifeClick(Sender: TObject);
    procedure rbFHDeclinesClick(Sender: TObject);
    procedure rbNotThisVisitClick(Sender: TObject);
    procedure edFHNameChange(Sender: TObject);
    procedure ORcmbTypeRelatChange(Sender: TObject);
    procedure ORcmbAgeDXChange(Sender: TObject);
    procedure ORcmbEthnicityChange(Sender: TObject);
    procedure ORcmbxRaceChange(Sender: TObject);
    procedure rbJewAncYesClick(Sender: TObject);
    procedure rbJewAncNoClick(Sender: TObject);
    procedure rbJewAncUnknownClick(Sender: TObject);
    procedure memCommentChange(Sender: TObject);
    procedure rbStatusUnknownClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure rbJewishDeclinedClick(Sender: TObject);
    procedure rbAdoptedClick(Sender: TObject);
    procedure rbLimitedTimeClick(Sender: TObject);
    procedure btnVerifySelectClick(Sender: TObject);
    procedure edCurrAgeChange(Sender: TObject);
    procedure cmbxAgeDeceasedChange(Sender: TObject);
    procedure rbFHDeclinesDblClick(Sender: TObject);
    procedure rbNotThisVisitDblClick(Sender: TObject);
    procedure rbFHLimitedFifeDblClick(Sender: TObject);
    procedure rbAdoptedDblClick(Sender: TObject);
    procedure rbLimitedTimeDblClick(Sender: TObject);


  private

    { Private declarations }

    function GetFHOutput: TStringList;
    function GetSelectedDiseases: TStringList;

    procedure VerifyOkToSave;
    procedure SetVitalCondUnknown(bsw: Boolean);
    procedure SetVitalLivingNo;
    procedure SetVitalLivingYes;
    procedure BuildLists;
    procedure ClearFormListBoxes;
    procedure BuildDiseaseTreeView;
    procedure Disable_Enable_All(Absw: Boolean);
    procedure BuildProviderInfo;
    procedure BuildPatientInfo;

    procedure BuildFHOutput;
    procedure BuildGroupsSubGroupsOfSelectedDiseases;
    procedure TestFindSelected;
    function GetDiseaseGroupAndTypeIENs: TStringList;
    function BuildFHOutPatientRecord: String;
    function BuildFHOutRelativeRecord: String;
    function BuildFHOutDiseaseRecord(aList: TStringList): TStringList;
    procedure ResetFHEntryForm;
    procedure ResetAllRadiobtns(aValue: Boolean);
    procedure PrepareForNextentry;
    procedure ProcessFamHistEdits;

    function SaveFHPatientSegment: Boolean;
    function SaveFHRelativeSegment: Boolean;
    function SaveFHDiseaseSegment(aDiseaseList: TStringList): Boolean;
    function SaveFHNote(var aDFN, aDUZ: String): String;

  protected

    procedure SetError(const x: string);

  public

    procedure LoadFromSelectedHistory;
    procedure SetComCtlStyle(Ctl: TWinControl; Value: Integer;
      UseStyle: Boolean);
    { Public declarations }

    procedure Init_FamHistEdit;
    function Enter:Boolean;

  end;

var

  frmFamHistEdit: TfrmFamHistEdit;
  AGroups: TStringList;
  AMasterDetail: TStringList;
  ASelectedDiseases: TStringList;
  AMatchedFromTView: TStringList; // contains the diseases nodes^Children
  AMasterDetailIENs: TStringList;
  ASelectedGrpCondIEN: TStringList;
  AStRbReply: String;

  FHNoReply: Boolean;
  FCanSaveSW: Boolean;

const
  FH_SAVE_ERROR1 =
    'An error was encountered while trying to save the Family History(Patient Record) you are editing.'
    + CRLF + CRLF;
  FH_SAVE_ERROR2 = CRLF + CRLF +
    'File (#500003) maybe corrupt, the call to RPC (KNR FH CREATE PATIENT ENTRY) ROUTINE'
    + 'KNRFHU - has failed.  Please review the last broker call for more information';
  FH_SAVE_ERROR3 =
    'An error was encountered while trying to save the Family History(Relative Record) you are editing.'
    + CRLF + CRLF;
  FH_SAVE_ERROR4 = CRLF + CRLF +
    'File (#500003) maybe corrupt, the call to RPC (KNR ADD RELATIVE) ROUTINE' +
    'KNRFHU- has failed.  Please review the last broker call for more information';
  TX_NO_FNAME = 'A Relatives First Name must be entered.';
  TX_NO_RELATIVE = 'A Relationship must be selected from the provided list.';
  TX_NO_AGEATDX =
    'An Age at Diagnosis must be selected if a Diagnosis has been selected';
  TX_NO_DX_SELECTED =
    'You have not selected an appropriate Diagnosis/Condition, please make a selected to continue';

implementation

uses rFamHistory, rMisc, VA508AccessibilityRouter;

{$R *.dfm}

procedure TfrmFamHistEdit.SetComCtlStyle(Ctl: TWinControl; Value: Integer;
  UseStyle: Boolean);
var
  Style: Integer;
begin
  if Ctl.HandleAllocated then
  begin
    Style := GetWindowLong(Ctl.Handle, GWL_STYLE);
    if not UseStyle then
      Style := Style and not Value
    else
      Style := Style or Value;
    SetWindowLong(Ctl.Handle, GWL_STYLE, Style);
  end;
end;

function TfrmFamHistEdit.Enter:Boolean;
begin
  frmFamHistEdit := TfrmFamHistEdit.Create(Application);
  Init_Global_Recs; // uFamHistoryGlobals
  SetAddedHistoryRec(FALSE);
  try
    with frmFamHistEdit do
    begin
      if GetFHReloadedSW then
      begin
        SetFHReloadedSW(FALSE);
      end
      else
      begin
        Init_FamHistEdit;
        Disable_Enable_All(True); // enable all
      end;
      ShowModal;
      Result := True;
    end;
  finally
    frmFamHistEdit.Release;
  end;

end;

procedure TfrmFamHistEdit.Init_FamHistEdit;
begin

  ASelectedGrpCondIEN := TStringList.Create;
  ASelectedGrpCondIEN.Clear;
 // SetComCtlStyle(tvDiseases, 0, True);
  SetAddedHistoryRec(FALSE);
  FRelativeSaveStat := 'Entry "217", already exists.';;
  ClearFormListBoxes; // clear all listboxex on fFamHistory form.
  BuildLists; // build lists for user to select provided values
end;

procedure TfrmFamHistEdit.ResetFHEntryForm;
begin

  memComment.Clear;
  ASelectedGrpCondIEN.Free;
  ASelectedDiseases.Free;
  ResetAllRadiobtns(FALSE);
  ASelectedGrpCondIEN := TStringList.Create;
  ASelectedGrpCondIEN.Clear;
  FRelativeSaveStat := 'Entry "217", already exists.';;
end;

procedure TfrmFamHistEdit.BuildFHOutput;
begin

  BuildProviderInfo;

end;

procedure TfrmFamHistEdit.BuildProviderInfo;
var
  PrvIEN: string;
begin
  PrvIEN := IntToStr(User.DUZ);
  SetLastEditedByID(PrvIEN);
end;

procedure TfrmFamHistEdit.BuildPatientInfo;
begin
  SetPatientDFN(Patient.DFN);
  SetPatientICN(Patient.ICN);
end;
//////// load values from history record selected from History Record list
procedure TfrmFamHistEdit.LoadFromSelectedHistory;
var
  holdIt: string;
begin

  Init_FamHistEdit;
//  Init_Global_Recs;
  SetAddedHistoryRec(FALSE);
  SetEditedHistoryRec(FALSE);
  frmFamHistEdit.edFHName.Text := GetFirstName;
  edFHName.Text := GetFirstName;
  ORcmbEthnicity.clear;
  ORcmbEthnicity.Items.Add(GetEthnicity);
  ORcmbEthnicity.ItemIndex := 0;
  ORcmbxRace.Items.Add(GetRace);
  ORcmbxRace.ItemIndex := 0;
  holdIt := GetJewishAncestor;
  rbJewishDeclined.Checked := FALSE;
  rbJewAncUnknown.Checked := FALSE;
  rbJewAncNo.Checked := FALSE;
  rbJewAncYes.Checked := FALSE;
  if holdIt <> '' then
  begin
    if holdIt = 'D' then
      rbJewishDeclined.Checked := True;
    if holdIt = 'U' then
      rbJewAncUnknown.Checked := True;
    if holdIt = 'N' then
      rbJewAncNo.Checked := True;
    if holdIt = 'Y' then
      rbJewAncYes.Checked := True;
  end;
  memComment.Text := GetComments;
  holdIt := '';
  holdIt := GetVitalStatus;
  rbStatusYes.Checked := FALSE;
  rbStatusNo.Checked := FALSE;
  rbStatusNo.Checked := FALSE;
  if holdIt = 'LIVING' then
    rbStatusYes.Checked := True;
  if holdIt = 'DECEASED' then
    rbStatusNo.Checked := True;
  if holdIt = 'UNKNOWN' then
    rbStatusUnknown.Checked := True;
  edCurrAge.Text := GetCurrentAge;
  if rbStatusNo.Checked then
  begin
    cmbxAgeDeceased.Items.Add(GetAgeDeceased);
    cmbxAgeDeceased.ItemIndex := 0;
  end;
  if Length(GetAgeAtDX) > 0 then
  begin
    ORcmbAgeDX.Items.Add(GetAgeAtDX);
    ORcmbAgeDX.ItemIndex := 0;
  end;
  if Length(GetRelationship) > 0 then
  begin
    ORcmbTypeRelat.Items.Add(GetRelationship);
    ORcmbTypeRelat.ItemIndex := 0;
  end;
  if Length(GetCondName) > 0 then
  begin

  end;
  SetFHReloadedSW(True); // bypass onchange actions.
  SetEditedHistoryRec(True);
  ShowModal;
end;

procedure TfrmFamHistEdit.ORcmbAgeDXChange(Sender: TObject);
begin
  inherited;
  if Length(ORcmbAgeDX.Text) > 0 then
    SetAgeAtDx(ORcmbAgeDX.Text);
end;

procedure TfrmFamHistEdit.ORcmbEthnicityChange(Sender: TObject);
begin
  inherited;
  if Length(ORcmbEthnicity.Text) > 0 then
  begin
    SetEthnicity(ORcmbEthnicity.Text);
    // memo1.Lines.Add('ethnicity 2   '+  FHAncestorRec.EthnicityIEN);
  end;
end;

procedure TfrmFamHistEdit.ORcmbTypeRelatChange(Sender: TObject);
begin
  inherited;
  if Length(ORcmbTypeRelat.Text) > 0 then
  begin
    SetRelationship(ORcmbTypeRelat.Text);
    // memo1.Lines.Add('relative2   ' +FHRelativeRec.RelationshipIEN);
  end;
end;

procedure TfrmFamHistEdit.ORcmbxRaceChange(Sender: TObject);
begin
  inherited;

  if Length(ORcmbxRace.Text) > 0 then
  begin
    SetRace(ORcmbxRace.Text);
    // memo1.Lines.Add('race2   ' + ORcmbxRace.Text);
  end;
end;

procedure TfrmFamHistEdit.rbAdoptedClick(Sender: TObject);
begin
  inherited;
  if rbAdopted.Checked then
  begin
    Disable_Enable_All(FALSE); // disable all
    AStRbReply := 'A';
    SetNoReply('A');
    FHNoReply := True;
  end;
end;

procedure TfrmFamHistEdit.rbAdoptedDblClick(Sender: TObject);
begin
  inherited;
  if rbAdopted.Checked then
  begin
    rbAdopted.Checked := False;
    SetNoReply('');
    FHNoReply := False;
  end;
end;

procedure TfrmFamHistEdit.tvDiseasesAdvancedCustomDrawItem
  (Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
begin
  inherited;
  with tvDiseases.Canvas do
  begin // use the canvas of the treeview and not the form's canvas
    if Node.Level = 0 then // root nodes have a level of 0
      Font.Style := [fsBold, fsItalic]
    else // all other have higher level properties
      Font.Style := [];
    DefaultDraw := True;
    // let the treeview do the drawing with your selected properties
  end;

end;

procedure TfrmFamHistEdit.TestFindSelected;
var
  CurrentItem: TTreeNode;
  TreeString: string;
  selectedLst: TStringList;
begin
  inherited;
  selectedLst := TStringList.Create;
  selectedLst.Clear;
  if tvDiseases.Selected.HasChildren = FALSE then // Last child in tree
  Begin
    CurrentItem := tvDiseases.Selected;
    while not((CurrentItem.IsFirstNode = True) and (CurrentItem <> nil)) do
    // add all parents
    Begin
      TreeString := CurrentItem.Text + '\' + TreeString;
      CurrentItem := CurrentItem.Parent;
    End;
    // TreeString := CurrentItem.Text + '\' + TreeString;  // add root
    selectedLst.Add(TreeString);
    // memo1.lines.add(TreeString);
  End;

end;

procedure TfrmFamHistEdit.BuildGroupsSubGroupsOfSelectedDiseases;
// process selected Groups and conditions, build list to send as output grp^cond
var
  I: Integer;
  lkat, stGrp, stHoldGrp: string;
  dgrp, cgrp: TStringList;
begin
  dgrp := TStringList.Create;
  cgrp := TStringList.Create;
  dgrp.Clear;
  cgrp.Clear;
  stHoldGrp := '';
  for I := 0 to ASelectedDiseases.Count - 1 do
  begin
    stGrp := Piece(ASelectedDiseases.Strings[I], '^', 1);
    if (stGrp <> stHoldGrp) then
    begin
      dgrp.Add(stGrp); // disease grp name - add 1 per group
      stHoldGrp := stGrp; // disease grp name
      lkat := ASelectedDiseases.Strings[I];
  //    Memo1.lines.Add(lkat);
      cgrp.Add(ASelectedDiseases.Strings[I]); // group^condition
    end
    else
    begin
      cgrp.Add(ASelectedDiseases.Strings[I]);
      lkat := ASelectedDiseases.Strings[I];
      Memo1.lines.Add(lkat);
    end;
  end;
  AMatchedFromTView.Assign(cgrp);
  cgrp.Free;
  dgrp.Free;
end;

procedure TfrmFamHistEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  PrepareForNextentry;
  Close;
end;

/// O k    B u t t o n   P r e s s e d   H e r e /////////////////////////

procedure TfrmFamHistEdit.btnOKClick(Sender: TObject);
// process data entered, save to server
var
  I: Integer;
  s, aDFN, aDUZ, aNoteIEN: string;
  ASelectedDiseaseIENs: TStringList;
begin
  inherited;
  try
    begin
      ASelectedDiseases := TStringList.Create;
      ASelectedDiseaseIENs := TStringList.Create;
      ASelectedDiseaseIENs.Clear;
      BuildProviderInfo;
      BuildPatientInfo;
      aDFN := Patient.DFN;
      aDUZ := IntToStr(User.DUZ);
      ASelectedDiseases.Assign(GetSelectedDiseases); // selected from treeview
      if ASelectedDiseases.Count > 0 then
      begin
        BuildGroupsSubGroupsOfSelectedDiseases;
        // creates stringList(AMatchedFromTView)match groups with conditions
        ASelectedDiseaseIENs.Assign(GetDiseaseGroupAndTypeIENs);
        // creates list of selected disease groups and conditions as IENs
      end;

      VerifyOkToSave;

      if not GetCanSaveFHRec then
      begin
        sbMessages.SimpleText := 'No Entries to Save!';
        exit;
      end;
      if GetFHReloadedData then
        ProcessFamHistEdits; // carry on from Ok Button.

      // if true all required fields have data
      // BuildFHOut and Save Patient Segment rc=1 success, rc=0 no message, record already exists,
      if SaveFHPatientSegment then // save patient segment
        sbMessages.SimpleText := 'Family History - Patient Segment Saved!';
        if GetNoReply <> '' then     // patieint not providing family history
          exit;   // don't attempt to save any more of the history file segments.

      if SaveFHRelativeSegment then // save relative segment
        sbMessages.SimpleText := 'Family History - Relative Segment Saved !';
      // ASelectedGrpCondIEN created in GetDiseaseGroupAndTypeIENs
      if SaveFHDiseaseSegment(ASelectedDiseaseIENs) then
        sbMessages.SimpleText := 'Family History - Disease Segment Saved!';
      aNoteIEN := SaveFHNote(aDFN, aDUZ);
      if aNoteIEN <> '' then
      begin
        sbMessages.SimpleText := 'Family History - TIU Note Saved!';
        PrepareForNextentry; // save disease segment
        SetAddedHistoryRec(True);
      end
      else
      begin
        sbMessages.SimpleText := 'Error saving Family History files';
        SetAddedHistoryRec(FALSE);
      end;
    end;
  finally
    ASelectedDiseaseIENs.Free;
    ResetFHEntryForm;
    Init_FamHistEdit;
  end;
end;

// build family history output record to be saved.
function TfrmFamHistEdit.BuildFHOutPatientRecord: String;
var
  aDFN, aJewish, aNoReply, aProvID, aComments, aRaceIEN, aEthIEN: String;
  ancestorStr: String;
begin
  aNoReply := GetNoReply; // code to do
  aDFN := GetPatientDFN;
  aJewish := GetJewishAncestor;
  aProvID := GetLastEditedByID;
  aComments := GetComments;
  aRaceIEN := GetConvertRaceIEN(GetRace); // returns Race^IEN
  aEthIEN := GetConvertEthnicityIEN(GetEthnicity); // returns IEN piece 2
  ancestorStr := aDFN + '^' + aJewish + '^' + aNoReply + '^' + aProvID + '^' +
    aComments + '^' + aRaceIEN + '^' + aEthIEN;
  result := ancestorStr;
end;

{
  DFN=100047,KNRFNAM="JIM",KNRREL=8,KNRVS="L",KNRAAD="",KNRCOMM="COMMENT",KNRDUZ="1",KNRRACE="3",KNRETH="2"
}
function TfrmFamHistEdit.BuildFHOutRelativeRecord: String;
var
  astr: string;
  aPatDFN, aPatIEN, aFName, aRelationIEN, aVSCode, aDecAge, aComments,
    aLastEditedBy, aRaceIEN, aEthIEN, aCurrAge: String;
begin
  aPatDFN := GetPatientDFN;
  aFName := GetFirstName;
  aRelationIEN := GetConvertRelativeIEN(GetRelationship);
  aVSCode := GetVitalStatus;
  aDecAge := GetConvertAgeIEN(GetAgeDeceased);
  aComments := GetComments;
  aLastEditedBy := GetLastEditedByID; // DUZ
  aRaceIEN := GetConvertRaceIEN(GetRace);
  aEthIEN := GetConvertEthnicityIEN(GetEthnicity); // returns IEN piece 2
  aCurrAge := GetCurrentAge;
  result := aPatDFN + '^' + aFName + '^' + aRelationIEN + '^' + aVSCode + '^' +
    aDecAge + '^' + aComments + '^' + aLastEditedBy + '^' + aRaceIEN + '^' +
    aEthIEN + '^' + aCurrAge;
end;

{
  relative   age@DX      DiseaseIEN            comment         user.duz
  Disease Segment CPRS30 4d1>S KNRREL="3",KNRAADI="14",KNRDIS="45",KNRCOMM="DISEASECOMMENT",KNRDUZ="1"

}
function TfrmFamHistEdit.BuildFHOutDiseaseRecord(aList: TStringList): TStringList;
var // returns list of disease records to be saved.
  astr: string;
  I: Integer;
  aCondList, aDiseaseRecOut: TStringList;
  aDateLastUpd: TFMDateTime;
  aRelatSegmentIEN, aAgeAtDX, aCondIEN, aComment, aLastUpdBy: String;
begin
  try
    aCondList := TStringList.Create; // conditions IEN /input
    aDiseaseRecOut := TStringList.Create; // output
    aDiseaseRecOut.Clear;
    aCondList.Clear;
    aCondList.Assign(aList);
    for I := 0 to aCondList.Count - 1 do
    begin
      aRelatSegmentIEN := GetRelatSegmentIEN;
      aAgeAtDX := GetConvertAgeIEN(GetAgeAtDX);
      aCondIEN := Piece(aCondList.Strings[I], '^', 2);
      aComment := GetComments;
      aLastUpdBy := GetLastEditedByID;

      astr := aRelatSegmentIEN + '^' + aAgeAtDX + '^' + aCondIEN + '^' +
        aComment + '^' + aLastUpdBy;
      aDiseaseRecOut.Add(astr)
    end;
    result := aDiseaseRecOut;
  finally
    aCondList.Free;
    // aDiseaseRecOut.Free;
  end;
end;

procedure TfrmFamHistEdit.SetError(const x: string);
var
  AnErrMsg: String;
begin
  AnErrMsg := x;
  if Length(AnErrMsg) > 0 then
    AnErrMsg := AnErrMsg + CRLF;
  AnErrMsg := AnErrMsg + x;
end;

/// //////////////////////////////////// save segments   /////////////////////////////////
///
procedure TfrmFamHistEdit.PrepareForNextentry;
begin
  edFHName.Text := '';
  ORcmbEthnicity.Text := '';
  ORcmbxRace.Text := '';
  ResetAllRadiobtns(FALSE);
//  memComment.lines.Add('');
  edCurrAge.Text := '';
  cmbxAgeDeceased.Text := '';
  ORcmbTypeRelat.Text := '';
  ORcmbAgeDX.Text := '';
  tvDiseases.Selected := nil;
  if ASelectedGrpCondIEN = nil then ASelectedGrpCondIEN.Free;
  ASelectedGrpCondIEN := TStringList.Create;
  ASelectedGrpCondIEN.Clear;
  SetComCtlStyle(tvDiseases, 0, True);
  SetAddedHistoryRec(FALSE);
  FRelativeSaveStat := 'Entry "217", already exists.';;
  ClearFormListBoxes; // clear all listboxex on fFamHistory form.
  BuildLists; // build lists for user to select provided values

end;

function TfrmFamHistEdit.SaveFHPatientSegment: Boolean;
var
  I: Integer;
  PatRecStr, x, y: String;
  strSaveRslt: TStrings;
begin
  try
    strSaveRslt := TStringList.Create;
    PatRecStr := BuildFHOutPatientRecord;
    if Length(PatRecStr) > 0 then
    begin
      FastAssign(SaveFHPatientRecord(GetPatientDFN, GetJewishAncestor,
        GetNoReply, GetLastEditedByID, GetComments, GetConvertRaceIEN(GetRace),
        GetConvertEthnicityIEN(GetEthnicity)), strSaveRslt);

      for I := 0 to strSaveRslt.Count - 1 do
      begin
        x := strSaveRslt.Strings[I];
        if (Piece(strSaveRslt.Strings[I], '^', 1) > '0') then
        // '1'=new rec added, '2'=dup rec attempted ok
        begin
          result := True;
          break;
        end
        else if (Piece(strSaveRslt.Strings[I], '^', 1) = '0') then
        begin
          InfoBox(FH_SAVE_ERROR1 + 'Family History File', FH_SAVE_ERROR2,
            MB_OK or MB_ICONWARNING);
          result := FALSE;
        end;
      end;
    end;
  finally
    strSaveRslt.Free;
  end;
end;

{
  DFN=100047,KNRFNAM="JIM",KNRREL=8,KNRVS="L",KNRAAD="",KNRCOMM="COMMENT",KNRDUZ="1",KNRRACE="3",KNRETH="2"c
}

function TfrmFamHistEdit.SaveFHRelativeSegment: Boolean;
var
  I: Integer;
  aRelativeStr, x: String;
  aPatDFN, aFName, aRelationIEN, aVSCode, aDecAge, aComments, aLastEditedBy,
    aRaceIEN, aEthIEN, aCurrAge: String;
  strSaveRslt: TStrings;
begin
  try
    result := FALSE;
    SetRelatRecSavedSW(FALSE);

    aRelativeStr := BuildFHOutRelativeRecord;
    strSaveRslt := TStringList.Create;
    if Length(aRelativeStr) > 0 then
    begin
      // call rpc to save segment
      aPatDFN := Piece(aRelativeStr, '^', 1);
      aFName := Piece(aRelativeStr, '^', 2);
      aRelationIEN := Piece(aRelativeStr, '^', 3);
      aVSCode := Piece(aRelativeStr, '^', 4);
      aDecAge := Piece(aRelativeStr, '^', 5);
      aComments := Piece(aRelativeStr, '^', 6);
      aLastEditedBy := Piece(aRelativeStr, '^', 7);
      aRaceIEN := Piece(aRelativeStr, '^', 8);
      aEthIEN := Piece(aRelativeStr, '^', 9);
      aCurrAge := Piece(aRelativeStr, '^', 10);

      strSaveRslt.Assign(SaveFHRelativeRecord(aPatDFN, aFName, aRelationIEN,
        aVSCode, aDecAge, aComments, aLastEditedBy, aRaceIEN, aEthIEN,
        aCurrAge));

      for I := 0 to strSaveRslt.Count - 1 do
      begin
        if (Piece(strSaveRslt.Strings[I], '^', 1) = '1') then
        begin
          SetRelatRecSavedSW(True);
          result := True;
          x := Piece(strSaveRslt[I], '^', 2);
          SetRelatSegmentIEN(Piece(strSaveRslt[I], '^', 2));
          // needed to save Disease segment
          break;
        end
        else
        begin
          InfoBox(FH_SAVE_ERROR3 + 'Family History Relative File',
            FH_SAVE_ERROR4, MB_OK or MB_ICONWARNING);
          SetPatRecSavedSW(FALSE);
        end
      end;
    end;
  finally
    strSaveRslt.Free;
  end;

end;

{ relaRecIEN   age@DX      DiseaseIEN            comment         user.duz
  Disease Segment CPRS30 4d1>S KNRREL="3",KNRAADI="14",KNRDIS="45",KNRCOMM="DISEASECOMMENT",KNRDUZ="1"

}

function TfrmFamHistEdit.SaveFHDiseaseSegment(aDiseaseList
  : TStringList): Boolean;
var
  I: Integer;
  aDiseaseSegmentsToSave: TStringList;
  strSaveRPCRslt: TStrings;
  aRelatSegmentIEN, aAgeAtDX, aCondIEN, aComment, aDateLastUpd,
    aLastUpdBy: String;
  aDiseaseStr, x: String;

begin
  try
    result := FALSE;
    aDiseaseSegmentsToSave := TStringList.Create;
    strSaveRPCRslt := TStringList.Create; // hold result from rpc save call
    aDiseaseSegmentsToSave.Clear;
    strSaveRPCRslt.Clear;
    FastAssign(BuildFHOutDiseaseRecord(aDiseaseList), aDiseaseSegmentsToSave);
    SetDiseaseRecSavedSW(FALSE);

    // list of disease groups and condtions IENs

    if aDiseaseSegmentsToSave.Count > 0 then
    begin
      for I := 0 to aDiseaseSegmentsToSave.Count - 1 do
      begin
        aRelatSegmentIEN := Piece(aDiseaseSegmentsToSave.Strings[I], '^', 1);
        aAgeAtDX := Piece(aDiseaseSegmentsToSave.Strings[I], '^', 2);
        aCondIEN := Piece(aDiseaseSegmentsToSave.Strings[I], '^', 3);
        aComment := Piece(aDiseaseSegmentsToSave.Strings[I], '^', 4);
        aLastUpdBy := Piece(aDiseaseSegmentsToSave.Strings[I], '^', 5);
        FastAssign(SaveFHDiseaseRecord(aRelatSegmentIEN, aAgeAtDX, aCondIEN,
          aComment, aLastUpdBy), strSaveRPCRslt);
      end;
      if GetDiseaseRecSavedSW then
      begin
        result := True;
      end
      else
      begin
        result := FALSE;
        InfoBox(FH_SAVE_ERROR3 + 'Family History Relative File', FH_SAVE_ERROR4,
          MB_OK or MB_ICONWARNING);
      end;
    end;
  finally
    aDiseaseSegmentsToSave.Free;
  end;
end;

function TfrmFamHistEdit.SaveFHNote(var aDFN, aDUZ: String): string;
var
  myRetCode: TStrings;
  I: Integer;
  x: string;
begin
  result := '';
  myRetCode := TStringList.Create;
  myRetCode.Clear;
  FastAssign(CreateFHNote(aDFN, aDUZ), myRetCode);
  // check results determine status -boolean based on return value
  begin
    for I := 0 to myRetCode.Count - 1 do
    begin
      x := myRetCode.Strings[I];
      if (Piece(x, '^', 2) = 'DOCUMENT CREATED SIGN IN CPRS') then
        result := Piece(x, '^', 1);
    end;
  end;
end;

procedure TfrmFamHistEdit.btnVerifySelectClick(Sender: TObject);
var
  myList: TStringList;
  I: Integer;
begin
  inherited;
  Memo1.Clear;
  myList := TStringList.Create;
  myList.Clear;
  myList.Assign(GetSelectedDiseases);
  for I := 0 to myList.Count - 1 do
  begin
    Memo1.Enabled := True;
    Memo1.Visible := True;
    Memo1.lines.Add('my disease selections' + myList.Strings[I])
  end;
end;

procedure TfrmFamHistEdit.rbFHDeclinesClick(Sender: TObject);
begin
  inherited;
  if rbFHDeclines.Checked then
  begin
    Disable_Enable_All(FALSE); // disable all
    SetNoReply('D');
    AStRbReply := 'D';
    FHNoReply := True;
  end;
end;

procedure TfrmFamHistEdit.rbFHDeclinesDblClick(Sender: TObject);
begin
  inherited;
  if rbFHDeclines.Checked then
  begin
    rbFHDeclines.Checked := FALSE;
    SetNoReply('');
    FHNoReply := FALSE;
    Disable_Enable_All(TRUE); // enable/disable all
  end;
end;

procedure TfrmFamHistEdit.rbFHLimitedFifeClick(Sender: TObject);
begin
  inherited;
  if rbFHLimitedFife.Checked then
  begin
    Disable_Enable_All(FALSE); // disable all
    AStRbReply := 'L';
    SetNoReply('L');
    FHNoReply := True;
  end;
end;

procedure TfrmFamHistEdit.rbFHLimitedFifeDblClick(Sender: TObject);
begin
  inherited;
  if rbFHLimitedFife.Checked then
  begin
    rbFHLimitedFife.Checked := FALSE;
    Disable_Enable_All(FALSE); // disable all
    SetNoReply('');
    FHNoReply := FALSE;
  end;
end;

procedure TfrmFamHistEdit.rbJewAncNoClick(Sender: TObject);
begin
  inherited;
  if FHRecReloadedSW then
    exit;
  if rbJewAncNo.Checked then
    SetJewishAncestor('N');
end;

procedure TfrmFamHistEdit.rbJewAncUnknownClick(Sender: TObject);
begin
  inherited;
  if FHRecReloadedSW then
    exit;
  if rbJewAncUnknown.Checked then
    SetJewishAncestor('U');
end;

procedure TfrmFamHistEdit.rbJewAncYesClick(Sender: TObject);
begin
  inherited;
  if FHRecReloadedSW then
    exit;
  if rbJewAncYes.Checked then
    SetJewishAncestor('Y');
end;

procedure TfrmFamHistEdit.GroupBox2DblClick(Sender: TObject);
begin
  inherited;
  if rbFHDeclines.Checked then
    rbFHDeclines.Checked := FALSE
  else if rbFHLimitedFife.Checked then
    rbFHLimitedFife.Checked := FALSE
  else if rbNotThisVisit.Checked then
    rbNotThisVisit.Checked := FALSE;
end;

procedure TfrmFamHistEdit.rbJewishDeclinedClick(Sender: TObject);
begin
  inherited;
  if FHRecReloadedSW then
    exit;
  if rbJewishDeclined.Checked then
    SetJewishAncestor('D');
end;

procedure TfrmFamHistEdit.rbLimitedTimeClick(Sender: TObject);
begin
  inherited;
  if rbLimitedTime.Checked then
  begin
    Disable_Enable_All(FALSE); // disable all
    AStRbReply := 'T';
    SetNoReply('T');
    FHNoReply := True;
  end;
end;

procedure TfrmFamHistEdit.rbLimitedTimeDblClick(Sender: TObject);
begin
  inherited;
  if rbLimitedTime.Checked then
  begin
    rbLimitedTime.Checked := False;
    SetNoReply('');
    FHNoReply := False;
  end;
end;

procedure TfrmFamHistEdit.rbNotThisVisitClick(Sender: TObject);
begin
  inherited;
  if rbNotThisVisit.Checked then
  begin
    Disable_Enable_All(FALSE); // disable all
    AStRbReply := 'U';
    SetNoReply('U');
    FHNoReply := True;
  end;
end;

procedure TfrmFamHistEdit.rbNotThisVisitDblClick(Sender: TObject);
begin
  inherited;
  if rbNotThisVisit.Checked then
  begin
    rbNotThisVisit.Checked := FALSE;
    SetNoReply('');
    FHNoReply := FALSE;
  end;
end;


procedure TfrmFamHistEdit.rbStatusNoClick(Sender: TObject);

begin
  SetVitalLivingNo; // set other radio buttons and date boxes appropriatley
  SetVitalStatus('D');
end;

procedure TfrmFamHistEdit.rbStatusUnknownClick(Sender: TObject);
begin
  inherited;
  SetVitalCondUnknown(FALSE);
  // set other radio buttons and date boxes appropriatley
  SetVitalStatus('U');
end;

procedure TfrmFamHistEdit.rbStatusYesClick(Sender: TObject);
begin
  SetVitalLivingYes; // set other radio buttons and date boxes appropriatley
  SetVitalStatus('L');
end;

procedure TfrmFamHistEdit.VerifyOkToSave;
begin
  SetCanSaveFHRec(True);
  if FHNoReply then
  begin
    SetCanSaveFHRec(True);
    exit;
  end;
  /// may need to add more checks here
  if Length(GetFirstName) = 0 then
  begin
    SetError(TX_NO_FNAME);
    SetCanSaveFHRec(FALSE);
    edFHName.SetFocus;
  end;
  if Length(GetRelationship) = 0 then
  begin
    SetError(TX_NO_RELATIVE);
    SetCanSaveFHRec(FALSE);
    ORcmbTypeRelat.SetFocus;
  end;
  if ASelectedGrpCondIEN.Count = 0 then
    SetError(TX_NO_DX_SELECTED);
  if ((Length(GetAgeAtDX) = 0) and (ASelectedGrpCondIEN.Count > 0)) then
    SetError(TX_NO_AGEATDX);
end;

procedure TfrmFamHistEdit.BuildDiseaseTreeView; // build the treeview
var
  I, ii, y: Integer;
  disGrp, disType, GrpType, GrpIEN, TypeIEN: string;
  newLst: TStrings;
  ListItems: TListItem;
  FTreeNode1, FTreeNode2: TTreeNode;
begin
  AGroups := TStringList.Create;
  newLst := TStringList.Create;
  AGroups.Clear;
  newLst.Clear;
  try
    with tvDiseases.Items do
    begin
      Clear; // Clear Items
      FTreeNode1 := Add(nil, 'Diseases'); // Add a root node (Users)
      FastAssign(GetFHDiseaseGrps, AGroups);
      for I := 0 to AGroups.Count - 1 do
      begin
        disGrp := AGroups[I];
        FTreeNode2 := Add(FTreeNode1, Piece(disGrp, '^', 1));
        if Length(disGrp) > 0 then
        begin // get items for that group and add to list
          FastAssign(GetFHCDiseaseConditions(Piece(disGrp, '^', 2)), newLst);
          for ii := 0 to newLst.Count - 1 do
          begin
            disType := newLst[ii];
            AMasterDetail.Add(disGrp + ':' + disType);
            // memo1.Lines.Add(disGrp + ':' + disType);
            AddChild(FTreeNode2, Piece(disType, '^', 2));
          end;
        end;
      end;
    end;
  finally
    AGroups.Clear;
    newLst.Clear;
    AGroups.Free;
    newLst.Free;
  end;
end;

function TfrmFamHistEdit.GetSelectedDiseases: TStringList;
var
  theList: TStringList;
  I: Integer;
begin
  theList := TStringList.Create;
  theList.Clear;

  // loop thru treeview add selected nodes to a list, use seleted names to get IEN's
  for I := 0 to tvDiseases.Items.Count - 1 do
    with tvDiseases.Items[I] do
      if (Level = 1) and (Selected or Parent.Selected) then
      begin
        // Memo1.Lines.Add(Parent.Text + '^' + text);
        theList.Add(Parent.Text + '^' + Text);
      end;
  result := theList;
end;

function TfrmFamHistEdit.GetDiseaseGroupAndTypeIENs: TStringList;
var
  s1, s2, g2, c2, allofit, allofit2: string;
  // lookup and convert disease group and condtion names to IEN's
  I, j: Integer; // to be sent as ouput.
  tmpSelectedList: TStringList;
  tmpMstrDtl: TStringList;
begin
  tmpSelectedList := TStringList.Create;
  tmpMstrDtl := TStringList.Create;

  tmpMstrDtl.Clear;
  tmpSelectedList.Clear;
  tmpMstrDtl.Assign(AMasterDetail); // all diseases that are in treeview
  tmpSelectedList.Assign(AMatchedFromTView);
  // items from treeview that have been selected
  with tmpSelectedList do // records selected from treeview
  begin
    for I := 0 to Count - 1 do
    begin
      allofit := tmpSelectedList.Strings[I];
      s1 := Piece(tmpSelectedList.Strings[I], '^', 1);
      s2 := Piece(tmpSelectedList.Strings[I], '^', 2);
      if Length(s1) > 0 then
      begin
        for j := 0 to tmpMstrDtl.Count - 1 do
        begin
          allofit2 := tmpMstrDtl.Strings[j];
          g2 := Piece(allofit2, '^', 1);
          c2 := Piece(allofit2, '^', 3);
          if ((s1 = g2) and (c2 = s2)) then
          begin
            allofit := Piece(tmpMstrDtl.Strings[j], '^', 2); // fix
            g2 := Piece(allofit, ':', 1);
            c2 := Piece(tmpMstrDtl.Strings[j], '^', 4);
            break;
          end;
        end;
      end;
      // memo1.Lines.Add('g2 ien =  ' + g2 +'c2 ien =  ' +c2);
      ASelectedGrpCondIEN.Add(g2 + '^' + c2); // iens group^Condtions
    end;
  end;
  result := ASelectedGrpCondIEN;
end;

procedure TfrmFamHistEdit.BuildLists;
begin
  ClearFormListBoxes;
  FastAssign(GetFHAgeRanges, cmbxAgeDeceased.Items);
  FastAssign(GetFHAgeRanges, ORcmbAgeDX.Items);
  FastAssign(GetFHRaces, ORcmbxRace.Items);
  FastAssign(GetFHEthnicityTypes, ORcmbEthnicity.Items);
  FastAssign(GetFHRelationships, ORcmbTypeRelat.Items);
  BuildDiseaseTreeView;
  BuildConvertToIENLists; // race,age,ethnicity,relatives
end;

function TfrmFamHistEdit.GetFHOutput: TStringList;
var
  thisList: TStringList;
begin
  // build the
  thisList := TStringList.Create;
  thisList.Clear;

  // gary  to do  build output
  result := thisList;
end;


procedure TfrmFamHistEdit.memCommentChange(Sender: TObject);
begin
  inherited;
  if FHRecReloadedSW then
    exit;
  if Length(memComment.Text) > 0 then
    SetComments(memComment.Text);

end;

procedure TfrmFamHistEdit.ResetAllRadiobtns(aValue: Boolean);
var
  aStat: Boolean;
begin
  aStat := aValue;

  rbFHDeclines.Checked := aStat;
  rbNotThisVisit.Checked := aStat;
  rbFHLimitedFife.Checked := aStat;
  rbAdopted.Checked := aStat;
  rbLimitedTime.Checked := aStat;
  rbJewAncYes.Checked := aStat;
  rbJewAncNo.Checked := aStat;
  rbJewAncUnknown.Checked := aStat;
  rbJewishDeclined.Checked := aStat;
  rbStatusYes.Checked := aStat;
  rbStatusNo.Checked := aStat;
  rbStatusUnknown.Checked := aStat;
end;

procedure TfrmFamHistEdit.ClearFormListBoxes;
begin
//  cmbxAgeDeceased.Clear;
  edCurrAge.Clear;
 // ORcmbTypeRelat.Clear;
 // ORcmbAgeDX.Clear;
 // ORcmbEthnicity.Clear;
  tvDiseases.Items.Clear;
//  ORcmbxRace.Clear;
  edFHName.Text := '';

end;

procedure TfrmFamHistEdit.cmbxAgeDeceasedChange(Sender: TObject);
begin
  inherited;
  if FHRecReloadedSW then
    exit;
  if Length(cmbxAgeDeceased.Text) > 0 then
    SetAgeDeceased(cmbxAgeDeceased.Text);
end;

procedure TfrmFamHistEdit.FormShow(Sender: TObject);
begin
  SetFormPosition(Self);
end;

procedure TfrmFamHistEdit.SetVitalCondUnknown(bsw: Boolean);
begin
  lblAgeRelative.Enabled := bsw;
  lblAgeDeath.Enabled := bsw;
  edCurrAge.Enabled := bsw;
  cmbxAgeDeceased.Enabled := bsw;
end;

procedure TfrmFamHistEdit.SetVitalLivingNo;
begin
  edCurrAge.Enabled := FALSE;
  edCurrAge.TabStop := FALSE;
  lblAgeRelative.Enabled := FALSE;
  lblAgeDeath.Enabled := True;
  cmbxAgeDeceased.Enabled := True;
  cmbxAgeDeceased.TabStop := True;

end;

procedure TfrmFamHistEdit.SetVitalLivingYes;
begin
  lblAgeRelative.Enabled := True;
  edCurrAge.Enabled := True;
  edCurrAge.TabStop := True;
  lblAgeDeath.Enabled := FALSE;
  cmbxAgeDeceased.Enabled := FALSE;
  cmbxAgeDeceased.TabStop := FALSE;
  cmbxAgeDeceased.ItemIndex := -1;
end;

procedure TfrmFamHistEdit.Disable_Enable_All(Absw: Boolean);
begin
  // False = disable all, True= enable all
  rbStatusYes.Enabled := Absw;
  rbStatusNo.Enabled := Absw;
  rbStatusUnknown.Enabled := Absw;
  edCurrAge.Enabled := Absw;
  cmbxAgeDeceased.Enabled := Absw;
  edFHName.Enabled := Absw;
  ORcmbTypeRelat.Enabled := Absw;
  ORcmbAgeDX.Enabled := Absw;
  ORcmbEthnicity.Enabled := Absw;
  ORcmbxRace.Enabled := Absw;
  rbJewAncYes.Enabled := Absw;
  rbJewAncNo.Enabled := Absw;
  rbJewAncUnknown.Enabled := Absw;
  tvDiseases.Enabled := Absw;
end;

procedure TfrmFamHistEdit.edCurrAgeChange(Sender: TObject);
begin
  inherited;
  if FHRecReloadedSW then
    exit;
  if Length(edCurrAge.Text) > 0 then
  begin
    SetCurrentAge(edCurrAge.Text);
  end;
end;

procedure TfrmFamHistEdit.edFHNameChange(Sender: TObject);
begin
  inherited;
  if FHRecReloadedSW then
    exit;
  if Length(edFHName.Text) > 0 then
  begin
    SetFirstName(edFHName.Text);
    // memo1.Lines.Add('First name2  ' + FHRelativeRec.FirstName);
  end;
end;

/// //   s a v e   E d i t s   //////////////////////

procedure TfrmFamHistEdit.ProcessFamHistEdits;
var
  I: Integer;
  s, aDFN, aDUZ, aNoteIEN: string;
  ASelectedDiseaseIENs: TStringList;
begin
  try
    begin
      ASelectedDiseases := TStringList.Create;
      ASelectedDiseaseIENs := TStringList.Create;
      ASelectedDiseaseIENs.Clear;
      BuildProviderInfo;
      BuildPatientInfo;
      aDFN := Patient.DFN;
      aDUZ := IntToStr(User.DUZ);
      ASelectedDiseases.Assign(GetSelectedDiseases); // selected from treeview
      if ASelectedDiseases.Count > 0 then
      begin
        BuildGroupsSubGroupsOfSelectedDiseases;
        // creates stringList(AMatchedFromTView)match groups with conditions
        ASelectedDiseaseIENs.Assign(GetDiseaseGroupAndTypeIENs);
        // creates list of selected disease groups and conditions as IENs
      end;

      VerifyOkToSave;

      if not GetCanSaveFHRec then
      begin
        sbMessages.SimpleText := 'No Entries to Save!';
        exit;
      end;
      if GetFHReloadedData then
        ProcessFamHistEdits; // carry on from Ok Button.

      // if true all required fields have data
      // BuildFHOut and Save Patient Segment rc=1 success, rc=0 no message, record already exists,
      if SaveFHPatientSegment then // save patient segment
        sbMessages.SimpleText := 'Family History - Patient Segment Saved!';
      if SaveFHRelativeSegment then // save relative segment
        sbMessages.SimpleText := 'Family History - Relative Segment Saved !';
      // ASelectedGrpCondIEN created in GetDiseaseGroupAndTypeIENs
      if SaveFHDiseaseSegment(ASelectedDiseaseIENs) then
        sbMessages.SimpleText := 'Family History - Disease Segment Saved!';
      aNoteIEN := SaveFHNote(aDFN, aDUZ);
      if aNoteIEN <> '' then
      begin
        sbMessages.SimpleText := 'Family History - TIU Note Saved!';
        PrepareForNextentry; // save disease segment
        SetAddedHistoryRec(True);
      end
      else
      begin
        sbMessages.SimpleText := 'Error saving Family History files';
        SetAddedHistoryRec(FALSE);
      end;
    end;
  finally
    ASelectedDiseaseIENs.Free;
    // tvDiseases.ClearSelection(false);
    ResetFHEntryForm;
    Init_FamHistEdit;
  end;
end;

initialization

SpecifyFormIsNotADialog(TfrmFamHistEdit);
AMasterDetail := TStringList.Create;
AMasterDetailIENs := TStringList.Create;
AMatchedFromTView := TStringList.Create;

AMatchedFromTView.Clear;
AMasterDetail.Clear;
AMasterDetailIENs.Clear;
FHNoReply := FALSE;

finalization

ReleaseIENLists; // release stringlists used to convert to IENs in uFamHistory
frmFamHistEdit.Release;
AMatchedFromTView.Free;

end.
