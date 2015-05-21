unit uFamHistGlobals;

interface
uses
  SysUtils, Windows, Messages, Controls, Classes, StdCtrls, ORfn,
  ORCtrls, Dialogs, Forms, Grids, graphics, ORNet, uConst,
  uGlobalVar, rCore, uCore, System.Types, rMisc;

  type
   TFamilyHistoryPatientRec = class // one record per patient
  public
    PatientDFN: String;
    // INTERNAL ENTRY NUMBER OF PATIENT IN THE KNR FAMILY HISTORY FILE
    JewishAncestor: String;
    // CODES Y=YES, N=NO, U=UNKNOWN,D=DECLINED TO ANSWER.
    NoReply: String; // D=DECLINED TO PARTICIPATE, U=UNKNOWN FAMILY
    // HISTORY, L=LIMITED LIFE EXPECTANCY, A=ADOPTED FAMILY HISTORY UNKNOWN, T=INSUFFICIENT TIME DEFERRED to next visit
    ProviderID: String; // Provider IEN
    Comments: String;
    // FREE TEXT COMMENT ON THIS PATIENT.  MAXIMUM OF 80 CHARACTERS.
    RaceIEN: String; // Race IEN
    EthnicityIEN: String;
    // NUMBER/POINTER (IEN) TO KNR FH ETHNICITY FILE (#500007).
  end;

  TFamilyHistoryRelativeRec = Class
    PatientDFN: String;
    PatientICN: String;
    FirstName: String;
    RelationshipIEN: String;
    // INTERNAL ENTRY NUMBER/POINTER TO KNR FH RELATIONSHIP FILE #500013.
    VitalStatCode: String; // L=LIVING, D=DECEASED, U=UNKNOWN
    DeceasedAge: String; // AGE AT DEATH, POINTER TO KNR FH AGE FILE.
    CurrentAge: String;
    // current age of relative - not sure if we need to track this..
    Comments: String; // FREE TEXT COMMENT FOR THIS RELATIVE.
    ProviderID: String; // DUZ.
    CondName: String;

  end;

  TFamilyHistoryDiseaseRec = Class
    RelatSegmentIEN: String;
    // ADDS DISEASE ENTRY FOR A RELATIVE TO FILE 500017.  RELATIVE ENTRY IN FILE
    AgeAtDXIEN: String;
    ConditionIEN: String;
    // KNR DISEASE FILE POINTER, INTERNAL ENTRY NUMBER. - disease condition, sec
    Comments: String; // COMMENT FOR THIS DISEASE FILE ENTRY.  FREE TEXT.
    ProviderID: String; // DUZ.
    TIUNoteIEN: String; // Note IEN
  End;

implementation

end.
