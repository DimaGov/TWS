[Setup]
AppName=TWS
AppVerName=2.8
DefaultDirName={reg:HKLM\SOFTWARE\ZDSimulator,InstallPath}
OutputDir=Output
OutputBaseFilename=ZDSsoft_TWS_v2.8
Compression=lzma
WizardImageFile=Images\wizardImage.bmp
WizardSmallImageFile=Images\twslogo.bmp
EnableDirDoesntExistWarning=yes
DirExistsWarning=no
AppendDefaultDirName=false
Uninstallable=true
UsePreviousAppDir=false
UsePreviousSetupType=false
UsePreviousTasks=false
UsePreviousGroup=false
DisableProgramGroupPage=true
DisableWelcomePage=no
SetupIconFile=Images\twslogo.ico

[Languages]
Name: rus; MessagesFile: compiler:Languages\Russian.isl; LicenseFile: docs\License.rtf; InfoBeforeFile: docs\TWS_readme.rtf
Name: ua; MessagesFile: compiler:Languages\Ukrainian.isl; LicenseFile: docs\License(UA).rtf; InfoBeforeFile: docs\TWS_readme(UA).rtf
Name: en; MessagesFile: compiler:Default.isl; LicenseFile: docs\License(ENG).rtf; InfoBeforeFile: docs\TWS_readme(ENG).rtf

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}";

[Files]
Source: "TWS_MainFiles\*"; DestDir: {app}; Flags: recursesubdirs ignoreversion createallsubdirs
Source: "TWS_OtherFiles\TWS_Temp.bat"; DestDir: "{app}\TWS\"; Flags: ignoreversion; Components: gg/installtype
Source: "TWS_OtherFiles\e.wav"; DestDir: "{app}\TWS\"; Flags: ignoreversion; Components: gg/installtype
//Source: "D:\Data\InnoSetup\TWS_Data\TWS_OtherFiles\sound_temp\*.*"; DestDir: "{app}\TWS\sound_temp\"; Flags: ignoreversion recursesubdirs;

[Icons]
Name: "{commondesktop}\TWS"; Filename: "{app}\TWS.exe"; IconFilename: "{app}\TWS.exe"; Tasks: desktopicon

[InstallDelete]
// ��������������� ��������, ����� ����������
Type: filesandordirs; Name: "{app}\TWS\*.wav"
Type: filesandordirs; Name: "{app}\TWS\*.mp3"
Type: filesandordirs; Name: "{app}\TWS\*.ini"
Type: filesandordirs; Name: "{app}\TWS\*.sfk"
Type: filesandordirs; Name: "{app}\TWS\*.doc"
Type: filesandordirs; Name: "{app}\TWS\*.docx"
Type: filesandordirs; Name: "{app}\TWS\2ES4K"
Type: filesandordirs; Name: "{app}\TWS\2ES5K"
Type: filesandordirs; Name: "{app}\TWS\2TE10U"
Type: filesandordirs; Name: "{app}\TWS\CHS_TED"
Type: filesandordirs; Name: "{app}\TWS\CHS2K"
Type: filesandordirs; Name: "{app}\TWS\CHS4KVR"
Type: filesandordirs; Name: "{app}\TWS\CHS4t"
Type: filesandordirs; Name: "{app}\TWS\CHS7_8"
Type: filesandordirs; Name: "{app}\TWS\CHS7"
Type: filesandordirs; Name: "{app}\TWS\CHS8"
Type: filesandordirs; Name: "{app}\TWS\Devices"
Type: filesandordirs; Name: "{app}\TWS\ED4m"
Type: filesandordirs; Name: "{app}\TWS\EP_TED"
Type: filesandordirs; Name: "{app}\TWS\EP1m"
Type: filesandordirs; Name: "{app}\TWS\Freight"
Type: filesandordirs; Name: "{app}\TWS\M62"
Type: filesandordirs; Name: "{app}\TWS\Pass"
Type: filesandordirs; Name: "{app}\TWS\PRS"
Type: filesandordirs; Name: "{app}\TWS\SAVP"
Type: filesandordirs; Name: "{app}\TWS\SAVPE_INFORMATOR\*.wav"
Type: filesandordirs; Name: "{app}\TWS\SAVPE_INFORMATOR\*.res"
Type: filesandordirs; Name: "{app}\TWS\TEP70"
Type: filesandordirs; Name: "{app}\TWS\TEP70bs"
Type: filesandordirs; Name: "{app}\TWS\VL_TED"
Type: filesandordirs; Name: "{app}\TWS\VL11m"
Type: filesandordirs; Name: "{app}\TWS\VL80t"
Type: filesandordirs; Name: "{app}\TWS\VL82m"
Type: filesandordirs; Name: "{app}\TWS\VL85"
Type: filesandordirs; Name: "{app}\TWS\�������"
Type: filesandordirs; Name: "{app}\TWS\BAT_FILES"
Type: filesandordirs; Name: "{app}\TWS_Uninstall.exe"
Type: filesandordirs; Name: "{app}\TWS_Uninstall.exe"
Type: filesandordirs; Name: "{app}\TWS.exe"
Type: filesandordirs; Name: "{app}\TWS.exe.manifest"
Type: filesandordirs; Name: "{app}\TWS_readme.rtf"
Type: filesandordirs; Name: "{app}\TWS_log.txt"

[Run]
Filename: "{app}\TWS\TWS_Temp.bat"; Flags: nowait skipifsilent; Components: gg/installtype

[Types]
Name: "a"; Description: "����������� ���������"; Languages: rus
Name: "a"; Description: "Standard installation"; Languages: en
Name: "a"; Description: "���������� ���������"; Languages: ua
Name: "b"; Description: "������������� ��������� ����������� ����� ���������� (������ ���������)"; Flags: iscustom; Languages: rus
Name: "b"; Description: "Automatically mute the standard simulator sounds (full installation)"; Languages: en
Name: "b"; Description: "����������� ��������� ��������� ����� ���������� (����� ���������)"; Languages: ua

[Code]
// ������ �������� �������� � ������� ���������� ���������
procedure CurPageChanged(CurPageID: Integer);
begin
   if CurPageID = 7 then begin
      WizardForm.TypesCombo.Visible:=False;
      WizardForm.ComponentsList.Visible:=True;
      WizardForm.ComponentsList.Height:=150;
      WizardForm.ComponentsList.Top:=50;
      WizardForm.ComponentsDiskSpaceLabel.Visible:=True;
   end;
end;

[UninstallRun]
Filename: {cmd}; Parameters: "/C xcopy /E /H /R /Y {app}\sound_backup\*.* {app}\sound\*.*"; Flags: RunHidden WaitUntilTerminated
Filename: {cmd}; Parameters: "/C rd /S /Q {app}\sound_backup"; Flags: RunHidden WaitUntilTerminated
Filename: {cmd}; Parameters: "/C rd /S /Q {app}\TWS"; Flags: RunHidden WaitUntilTerminated

[Components]
Name: "gg"; Description: "����������� ����� sound"; Flags:disablenouninstallwarning exclusive; Languages: rus
Name: "gg"; Description: "����������� ����� sound"; Flags:disablenouninstallwarning exclusive; Languages: ua
Name: "gg"; Description: "Modificate sound directory"; Flags:disablenouninstallwarning exclusive; Languages: en
Name: "gg/installtype"; Description: "������� ������������� ����� ���������� + ����� ����������� ������"; Flags:disablenouninstallwarning exclusive; Types: a b; Languages: rus
Name: "gg/installtype"; Description: "��������� ����������� ����� ���������� + ������� �������� ���� ���������� �����"; Flags:disablenouninstallwarning exclusive; Types: a b; Languages: ua
Name: "gg/installtype"; Description: "Deactivate the sounds of the simulator automatically + make backup the deactivated sounds"; Flags:disablenouninstallwarning exclusive; Types: a b; Languages: en

[Messages]
rus.BeveledLabel=�������
ua.BeveledLabel=���������
en.BeveledLabel=English
rus.WelcomeLabel1=��� ������������ ������ ��������� ���������� ��� ZDSimulator
rus.WelcomeLabel2=��������� ��������� �������� ������ TWS (������ 2.8)
rus.SelectDirBrowseLabel=������� ���� � ZDSimulator. ���� ���������� �� ��������� ���� �������������, �� ������ ������� ��� ��������������, ����� ������.
rus.FinishedHeadingLabel=���������� ���������
rus.FinishedLabelNoIcons=�������� ������ TWS ������� ����������.
ua.WelcomeLabel1=��� ��� ������� ������������ ������� ��� ZDSimulator
ua.WelcomeLabel2=�������� ���������� �������� ������ TWS (����� 2.8)
ua.SelectDirBrowseLabel=������ ���� �� ZDSimulator. ���� ���������� �� �������� ���� �����������, �� ������ �� ������� ���������, ���������� ������.
ua.FinishedHeadingLabel=���������� ������������
ua.FinishedLabelNoIcons=�������� ������ TWS ������ ������������.
en.WelcomeLabel1=Welcome to the Add-ons Wizard for ZDSimulator
en.WelcomeLabel2=The program will install the sound script TWS (version 2.8)
en.SelectDirBrowseLabel=Specify the path to ZDSimulator. If the installer has not defined the path automatically, you can do it yourself by clicking on "Browse".
en.FinishedHeadingLabel=Installation Complete
en.FinishedLabelNoIcons=The TWS sound script has been successfully installed.

[UninstallDelete]
Type: files; Name: "{app}\TWS.exe"
Type: files; Name: "{app}\TWS_log.txt"
Type: files; Name: "{app}\TWS_readme.rtf"
Type: files; Name: "{app}\TWS.exe.manifest"
Type: files; Name: "{app}\bass.dll"
Type: files; Name: "{app}\bass_fx.dll"
Type: files; Name: "{app}\dg2020.dll"