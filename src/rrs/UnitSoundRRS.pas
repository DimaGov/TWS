//------------------------------------------------------------------------------//
//                                                                              //
//      Модуль для работы звуковой программы в симуляторе RRS                   //
//      (c) DimaGVRH, Dnepr city, 2019                                          //
//                                                                              //
//------------------------------------------------------------------------------//
unit UnitSoundRRS;

interface

uses
   Windows, Messages, SysUtils, Graphics, Forms, Dialogs, StdCtrls, ComCtrls, inifiles,
   ExtCtrls, UnitAuthors, Controls, UnitSAVPEHelp, Classes, TlHelp32;

type
   soundrrs = class(TObject)
   procedure tick(Sender: TObject);
   procedure createSoundRRSManager(Sender: TComponent);
end;

var
   mainTimer: TTimer;

   JOURNAL_LOG_PATH: String = 'logs/journal.log';
   VIEWER_LOG_PATH: String = 'logs/viewer.log';

   RRS_SOUND_MANAGER_TRIGGER:      Boolean = False;
   RRS_MODEL_OBJECT_TRIGGER:       Boolean = True;
   RRS_CAMERA_MANIPULATOR_TRIGGER: Boolean = True;

   modelObjectAdress: PByte;
   viewerCameraManipulatorAdress: PByte;

   RRS_SPEED_ADDR: PByte;
   RRS_CAMERA_MANIPULATOR_ADDR: PByte;

   RRS_OFFSET_SPEED: Integer = 208;
   RRS_OFFSET_CAMERA_MANIPULATOR: Integer = 890;

   cameraManipulatorView: String;
   PrevcameraManipulatorView: String;
   CamManInc: Integer;

   speed: Single;

   pHandle: Cardinal;

implementation

uses UnitMain, ExtraUtils, SoundManager, Bass;

function GetModuleFileNameEx(hProcess: Cardinal; hModule: Cardinal;
  lpFilename: PChar; nSize: Cardinal): Cardinal; stdcall external 'psapi.dll' name 'GetModuleFileNameExA';

// Get ProcessID By ProgramName (Include Path or Not Include)
function GetPIDByProgramName(const APName: string): Cardinal;
var
   isFound: boolean;
   AHandle, AhProcess: Cardinal;
   ProcessEntry32: TProcessEntry32;
   APath: array[0..MAX_PATH] of char;
begin
   Result := 0;
   AHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
   try
      ProcessEntry32.dwSize := Sizeof(ProcessEntry32);
      isFound := Process32First(AHandle, ProcessEntry32);
      while isFound do
      begin
         AhProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,
            false, ProcessEntry32.th32ProcessID);
         GetModuleFileNameEx(AhProcess, 0, @APath[0], sizeof(APath));
         if (UpperCase(StrPas(APath)) = UpperCase(APName)) or
            (UpperCase(StrPas(ProcessEntry32.szExeFile)) = UpperCase(APName)) then
         begin
            Result := ProcessEntry32.th32ProcessID;
            break;
         end;
         isFound := Process32Next(AHandle, ProcessEntry32);
         CloseHandle(AhProcess);
      end;
   finally
      CloseHandle(AHandle);
   end;
end;

//------------------------------------------------------------------------------//
//      Подпрограмма - получения адреса ModelAdress процесса simulator.exe      //
//------------------------------------------------------------------------------//
function getObjectModelAdress(fileDir: String) : PByte;
var
   FS: TFileStream;
   FileText: String;
   FileLinesList: TStringList;
   LineList: TStringList;
   I: Integer;
begin
   FS := TFileStream.Create(fileDir, fmShareDenyNone);
   FileText := GetStringFromFileStream(FS);
   FS.Free();
   FileLinesList := ExtractWord(FileText, #10);
   Result := $0;
   for I := FileLinesList.Count-1 downto 0 do begin
      if Pos('Created Model object at address:', FileLinesList[I])>0 then begin
         LineList := ExtractWord(FileLinesList[I], ' ');
         Result := ptr(StrToInt('$' + StringReplace(LineList[LineList.Count-1], '0x', '', [rfReplaceAll])));
         Break;
      end;
   end;
end;

//------------------------------------------------------------------------------//
//                     Подпрограмма - получения вида камеры                     //
//------------------------------------------------------------------------------//
function getCameraManipulatorAdress(fileDir: String) : PByte;
var
   FS: TFileStream;
   FileText: String;
   FileLinesList: TStringList;
   LineList: TStringList;
   I: Integer;
begin
   FS := TFileStream.Create(fileDir, fmShareDenyNone);
   FileText := GetStringFromFileStream(FS);
   FS.Free();
   FileLinesList := ExtractWord(FileText, #13);
   Result := $0;
   for I := FileLinesList.Count-1 downto 0 do begin
      FileLinesList[I] := StringReplace(StringReplace(FileLinesList[I], #13, '', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
      if Pos('RenderStage::runCameraSetUp(osg::RenderInfo& renderInfo)', FileLinesList[I])>0 then begin
         LineList := ExtractWord(FileLinesList[I], ' ');
         Result := ptr(StrToInt('$' + StringReplace(LineList[LineList.Count-1], '0x', '', [rfReplaceAll])));
         LineList.Destroy;
         Break;
      end;
   end;
   FileLinesList.Destroy;
end;

//------------------------------------------------------------------------------//
//      Подпрограмма - получение pHandle процесса по имени окна программы       //
//------------------------------------------------------------------------------//
function getWindowPHandle(windowTitle: String) : Cardinal;
var
   wHandle:            Integer;
   tHandle, ProcessID: Cardinal;
begin
   //wHandle := FindWindow(nil, PChar(windowTitle));
   //tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
   //CloseHandle(wHandle); CloseHandle(tHandle);
   Result  := OpenProcess(PROCESS_ALL_ACCESS, FALSE, GetPIDByProgramName(windowTitle));
end;

//------------------------------------------------------------------------------//
//          Подпрограмма для чтения из ОЗУ строки фиксированной длинны          //
//------------------------------------------------------------------------------//
function ReadStringFromMemory(readAddr: PByte; Len: Byte) : String;
var
   I: Byte;
   readByte: Byte;
   resStr: String;
   str: String;
begin
   for I := 0 to Len do begin
      ReadProcessMemory(UnitMain.pHandle, readAddr, @readByte, 1, temp);
      SetString(str, PChar(@readByte), 1);
      resStr := resStr + str;
      Inc(readAddr);
   end;
   Result := resStr;
end;

//------------------------------------------------------------------------------//
//       Подпрограмма - тик работы звуковой программы для симулятора RRS        //
//------------------------------------------------------------------------------//
procedure soundrrs.tick(Sender: TObject);
begin
   if BASS_IsStarted = False then BASS_Start();
   if (RRS_MODEL_OBJECT_TRIGGER = True) AND (FileExists(JOURNAL_LOG_PATH)) then begin
      modelObjectAdress := getObjectModelAdress(JOURNAL_LOG_PATH);
      if integer(modelObjectAdress) <> 0 then begin
         RRS_MODEL_OBJECT_TRIGGER := False;
         Log_.DebugWriteErrorToErrorList('RRS model object simulator.exe adress: ' + IntToStr(integer(modelObjectAdress)));
      end;
   end;
   if (RRS_CAMERA_MANIPULATOR_TRIGGER = True) AND (FileExists(VIEWER_LOG_PATH)) then begin
      viewerCameraManipulatorAdress := getCameraManipulatorAdress(VIEWER_LOG_PATH);
      if integer(viewerCameraManipulatorAdress) <> 0 then begin
         RRS_CAMERA_MANIPULATOR_TRIGGER := False;
         Log_.DebugWriteErrorToErrorList('RRS camera manipulator adress: ' + IntToStr(integer(viewerCameraManipulatorAdress)));
      end;
   end;

   //Log_.DebugWriteErrorToErrorList('Camera manipulator switch: ' + cameraManipulatorView);

   pHandle := getWindowPHandle('simulator.exe');

   RRS_SPEED_ADDR := modelObjectAdress;
   Inc(RRS_SPEED_ADDR, RRS_OFFSET_SPEED);
   ReadProcessMemory(pHandle, RRS_SPEED_ADDR, @speed, 4, temp);
   Speed := Trunc(Speed * 3.6);

   CloseHandle(pHandle);

   pHandle := getWindowPHandle('viewer.exe');

   RRS_CAMERA_MANIPULATOR_ADDR := viewerCameraManipulatorAdress;
   Inc(RRS_CAMERA_MANIPULATOR_ADDR, RRS_OFFSET_CAMERA_MANIPULATOR);
   cameraManipulatorView := Trim(ReadStringFromMemory(RRS_CAMERA_MANIPULATOR_ADDR, 11));

   CloseHandle(pHandle);

   // Блок проверки изменений скорости локомотива для перестука пассажирских вагонов
       if FormMain.RadioButton1.Checked = True then begin
          if (Speed >= 5) and (Speed <= 10) and (StrComp(WagF, PChar('TWS/Pass/5-10.wav')) <> 0) then begin
                WagF:= PChar('TWS/Pass/5-10.wav'); isPlayWag:=False; end;
          if (Speed >= 11) and (Speed <= 15) and (StrComp(WagF, PChar('TWS/Pass/10-15.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/10-15.wav'); isPlayWag:=False; end;
          if (Speed >= 16) and (Speed <= 20) and (StrComp(WagF, PChar('TWS/Pass/15-20.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/15-20.wav'); isPlayWag:=False; end;
          if (Speed >= 21) and (Speed <= 30) and (StrComp(WagF, PChar('TWS/Pass/20-30.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/20-30.wav'); isPlayWag:=False; end;
          if (Speed >= 31) and (Speed <= 40) and (StrComp(WagF, PChar('TWS/Pass/30-40.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/30-40.wav'); isPlayWag:=False; end;
          if (Speed >= 41) and (Speed <= 50) and (StrComp(WagF, PChar('TWS/Pass/40-50.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/40-50.wav'); isPlayWag:=False; end;
          if (Speed >= 51) and (Speed <= 60) and (StrComp(WagF, PChar('TWS/Pass/50-60.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/50-60.wav'); isPlayWag:=False; end;
          if (Speed >= 61) and (Speed <= 70) and (StrComp(WagF, PChar('TWS/Pass/60-70.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/60-70.wav'); isPlayWag:=False; end;
          if (Speed >= 71) and (Speed <= 80) and (StrComp(WagF, PChar('TWS/Pass/70-80.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/70-80.wav'); isPlayWag:=False; end;
          if (Speed >= 81) and (Speed <= 90) and (StrComp(WagF, PChar('TWS/Pass/80-90.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/80-90.wav'); isPlayWag:=False; end;
          if (Speed >= 91) and (Speed <= 100)and (StrComp(WagF, PChar('TWS/Pass/90-100.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/90-100.wav'); isPlayWag:=False;end;
          if (Speed >=101) and (Speed <= 120)and (StrComp(WagF, PChar('TWS/Pass/100-120.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/100-120.wav');isPlayWag:=False;end;
          if (Speed>120) and (StrComp(WagF, PChar('TWS/Pass/120-140.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/120-140.wav');isPlayWag:=False;end;

          if Speed<5 then begin WagF:=''; BASS_ChannelStop(WagChannel); BASS_StreamFree(WagChannel); end;
       end;

       if cameraManipulatorView = 'cabine_view' then
          BASS_ChannelSetAttribute(WagChannel, BASS_ATTRIB_VOL, 0)
       else
          BASS_ChannelSetAttribute(WagChannel, BASS_ATTRIB_VOL, FormMain.trcBarWagsVol.Position / 100);

       if (cameraManipulatorView = PrevcameraManipulatorView) then
          Inc(CamManInc)
       else
          CamManInc := 0;
       if CamManInc > 20 then cameraManipulatorView := PrevcameraManipulatorView;

       PrevcameraManipulatorView := cameraManipulatorView;

       SoundManagerTick();

end;

//------------------------------------------------------------------------------//
//  Подпрограмма для запуска звуковой программы, для работы с симулятором RRS   //
//------------------------------------------------------------------------------//
procedure soundrrs.createSoundRRSManager(Sender: TComponent);
begin
   if RRS_SOUND_MANAGER_TRIGGER = False then begin
      RRS_SOUND_MANAGER_TRIGGER := True;
      mainTimer          := TTimer.Create(Sender);
      mainTimer.Interval := 100;
      mainTimer.OnTimer  := tick;
      mainTimer.Enabled  := True;
   end;
end;

end.
 