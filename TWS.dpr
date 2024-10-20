program TWS;

uses
  Forms,
  UnitMain in 'src\main\UnitMain.pas' {FormMain},
  UnitAuthors in 'src\main\UnitAuthors.pas' {FormAuthors},
  UnitSAVPEHelp in 'src\savp\UnitSAVPEHelp.pas' {FormSAVPEHelp},
  UnitSettings in 'src\settings\UnitSettings.pas' {FormSettings},
  UnitDebug in 'src\debug\UnitDebug.pas' {FormDebug},
  UnitUSAVP in 'src\savp\UnitUSAVP.pas' {FormUSAVP},
  SAVP in 'src\savp\SAVP.pas',
  RAMMemModule in 'src\ramMemoryModule\RAMMemModule.pas',
  FileManager in 'src\fileManager\FileManager.pas',
  ExtraUtils in 'src\extra\ExtraUtils.pas',
  SoundManager in 'src\soundManager\SoundManager.pas',
  Debug in 'src\debug\Debug.pas',
  UnitSOVIHelp in 'src\savp\UnitSOVIHelp.pas' {FormSOVIHelp},
  UnitSoundRRS in 'src\rrs\UnitSoundRRS.pas',
  CHS8 in 'src\loc\CHS8\CHS8.pas',
  Bass in 'src\bass\BASS.pas',
  bass_fx in 'src\bass\bass_fx.pas',
  CHS4KVR in 'src\loc\CHS4KVR\CHS4KVR.pas',
  KR21 in 'src\kr21\KR21.pas',
  CHS7 in 'src\loc\CHS7\CHS7.pas',
  CHS4T in 'src\loc\CHS4T\CHS4T.pas',
  VL80T in 'src\loc\VL80T\VL80T.pas',
  EP1M in 'src\loc\EP1M\EP1M.pas',
  ES5K in 'src\loc\2ES5K\ES5K.pas',
  ED4M in 'src\loc\ED4M\ED4M.pas',
  ED9M in 'src\loc\ED9M\ED9M.pas',
  KVT254 in 'src\kvt254\KVT254.pas',
  VR242 in 'src\vr242\VR242.pas',
  CHS2K in 'src\loc\CHS2K\CHS2K.pas',
  VL11M in 'src\loc\VL11M\VL11M.pas',
  sl2m in 'src\SL2m\sl2m.pas',
  VL82M in 'src\loc\VL82m\VL82M.pas',
  CHS4 in 'src\loc\CHS4\CHS4.pas',
  TE10U in 'src\loc\2TE10U\TE10U.pas',
  M62 in 'src\loc\M62\M62.pas',
  VL85 in 'src\loc\VL85\VL85.pas',
  TEM18dm in 'src\loc\TEM18dm\TEM18dm.pas',
  TEP70 in 'src\loc\TEP70\TEP70.pas',
  TEP70bs in 'src\loc\TEP70bs\TEP70bs.pas',
  Camera in 'src\camera\Camera.pas';

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
