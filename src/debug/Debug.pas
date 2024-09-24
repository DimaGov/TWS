unit Debug;

interface

uses ExtCtrls, Classes;

type
   log = class(TObject)
private
   procedure DebugCreateFile();
   procedure DebugLogTick(Sender: TObject);
public
   procedure DebugLogStart(Sender: TComponent);
   procedure DebugWriteErrorToErrorList(ErrorString: String);
   procedure DebugFreeLog();
end;

var
   mainTimer: TTimer;

implementation

uses UnitMain, SysUtils, Forms, ExtraUtils;

var
   LOG_FILE_PATH: String = 'tws_log.log';
   LOG_CREATED: Boolean = False;
   ErrorList: TStringList;
   logFile: TextFile;

(*
 0x00 0x01 0x02 0x03 0x04 0x05
*)
//------------------------------------------------------------------------------//
//                    ������������ ��� ������ ������ � ������                   //
//------------------------------------------------------------------------------//
procedure log.DebugWriteErrorToErrorList(ErrorString: String);
var
    SearchErr: TStringList;
    I: Integer;
    Match: Boolean;
begin
    Match := False;
    for I := 0 to ErrorList.Count-1 do begin
       if ErrorList[I] = ErrorString then begin Match := True; Break; end;
    end;
    if Match = False then
       ErrorList.Add(ErrorString);
end;

//------------------------------------------------------------------------------//
//                       ������������ �������� ����� ����                       //
//------------------------------------------------------------------------------//
procedure log.DebugCreateFile();
begin
   AssignFile(logFile, LOG_FILE_PATH);
   Rewrite(logFile);
   ErrorList := TStringList.Create();
   DebugWriteErrorToErrorList('Session Started');
   if FileExists(LOG_FILE_PATH) then
      LOG_CREATED := True;
end;

//------------------------------------------------------------------------------//
//                  ������������ ��� ������ ����� ������������                  //
//------------------------------------------------------------------------------//
procedure log.DebugLogStart(Sender: TComponent);
begin
   DebugCreateFile();
   mainTimer          := TTimer.Create(Sender);
   mainTimer.Interval := 1000;
   mainTimer.OnTimer  := DebugLogTick;
   mainTimer.Enabled  := True;
end;

//------------------------------------------------------------------------------//
//                      ������������ - ����� ������������                       //
//------------------------------------------------------------------------------//
procedure log.DebugLogTick(Sender: TObject);
var
     today : TDateTime;
     header: String;
     I: Integer;
begin
     if LOG_CREATED = True then begin
        today := Time;
        header := '[' + TimeToStr(today) + '] ';
        for I := 0 to ErrorList.Count-1 do begin
           Writeln(logFile, header + ErrorList[I]);
        end;
        Flush(logFile);
        ErrorList.Clear();
     end;
end;

//------------------------------------------------------------------------------//
//                    ������������ - �������� ������������                      //
//------------------------------------------------------------------------------//
procedure log.DebugFreeLog();
begin
     mainTimer.Enabled := False;
     CloseFile(logFile);
end;

end.
