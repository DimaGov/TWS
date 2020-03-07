program TWS;

uses
  Forms,
  UnitMain in 'src/main/UnitMain.pas' {FormMain},
  UnitAuthors in 'src/main/UnitAuthors.pas' {FormAuthors},
  UnitSAVPEHelp in 'src/savp/UnitSAVPEHelp.pas' {FormSAVPEHelp},
  UnitSettings in 'src/settings/UnitSettings.pas' {FormSettings},
  UnitDebug in 'src/debug/UnitDebug.pas' {FormDebug},
  UnitUSAVP in 'src/savp/UnitUSAVP.pas' {FormUSAVP},
  SAVP in 'src/savp/SAVP.pas',
  RAMMemModule in 'src/ramMemoryModule/RAMMemModule.pas',
  FileManager in 'src/fileManager/FileManager.pas',
  ExtraUtils in 'src/extra/ExtraUtils.pas',
  SoundManager in 'src/soundManager/SoundManager.pas',
  Debug in 'src/debug/Debug.pas',
  UnitSOVIHelp in 'src/savp/UnitSOVIHelp.pas' {FormSOVIHelp},
  UnitSoundRRS in 'src/rrs/UnitSoundRRS.pas',
  CHS8 in 'src/loc/CHS8/CHS8.pas',
  Bass in 'src/bass/BASS.pas',
  bass_fx in 'src/bass/bass_fx.pas';

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
