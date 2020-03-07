program TWS;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitAuthors in 'UnitAuthors.pas' {FormAuthors},
  UnitSAVPEHelp in 'UnitSAVPEHelp.pas' {FormSAVPEHelp},
  UnitSettings in 'UnitSettings.pas' {FormSettings},
  UnitDebug in 'UnitDebug.pas' {FormDebug},
  UnitUSAVP in 'UnitUSAVP.pas' {FormUSAVP},
  SAVP in 'SAVP.pas',
  RAMMemModule in 'RAMMemModule.pas',
  FileManager in 'FileManager.pas',
  ExtraUtils in 'ExtraUtils.pas',
  SoundManager in 'SoundManager.pas',
  Debug in 'Debug.pas',
  UnitSOVIHelp in 'UnitSOVIHelp.pas' {FormSOVIHelp},
  UnitSoundRRS in 'UnitSoundRRS.pas',
  CHS8 in 'CHS8.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAuthors, FormAuthors);
  Application.CreateForm(TFormSAVPEHelp, FormSAVPEHelp);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.CreateForm(TFormDebug, FormDebug);
  Application.CreateForm(TFormUSAVP, FormUSAVP);
  Application.CreateForm(TFormSOVIHelp, FormSOVIHelp);
  Application.Run;
 end.
