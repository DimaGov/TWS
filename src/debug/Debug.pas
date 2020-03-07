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

//------------------------------------------------------------------------------//
//                    Подпрограмма для записи ошибки в список                   //
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
//                       Подпрограмма создания файла лога                       //
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
//                  Подпрограмма для старта цикла логгирования                  //
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
//                      Подпрограмма - цикла логгирования                       //
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
//                    Подпрограмма - закрытия логгирования                      //
//------------------------------------------------------------------------------//
procedure log.DebugFreeLog();
begin
     mainTimer.Enabled := False;
     CloseFile(logFile);
end;

end.
