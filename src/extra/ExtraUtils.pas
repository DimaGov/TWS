//------------------------------------------------------------------------------//
//                                                                              //
//      Модуль для различного рода прикладных подпрограмм                       //
//      (c) DimaGVRH, Dnepr city, 2019                                          //
//                                                                              //
//------------------------------------------------------------------------------//
unit ExtraUtils;

interface

   uses Classes;

   function StrToPChar(string_: String) : PChar;
   function GetStrToSep(St1:string;Sym1,Sym2:char;Var Pos:integer):string;overload;
   function GetStrToSep(St1:string;Sym:char;Var Pos:integer):string;overload;
   function GetStrToSep(St1:string;Sym:char;Pos:smallint):string;overload;
   function GetStrToSep(St1:string;Sym:char):string;overload;
   function GetSymPos(St1:string;Sym:char;StartI:integer=0):smallint;
   function ExtractWord(const AString: string; const ADelimiter: Char): TStringList;
   function base64Decode(const Text : ansiString): ansiString;
   function DecodeBase64(Value: String): String;
   function GetStringFromFileStream(FileStream: TFileStream) : String;
   function BoolToStr(const value : boolean) : string;
   function FindTask(ExeFileName: string): Boolean;
   function OneInstance: boolean;
   function GetFileCount(Dir: string):integer;

implementation

uses IdCoder3to4, IdCoderMIME, SysUtils, Windows, TlHelp32, Forms;

function OneInstance: boolean;
var g_hAppCritSecMutex: THandle;
    dw: Longint;
    g_hAppMutex: THandle;
begin
     g_hAppCritSecMutex := CreateMutex( nil, true, PChar(Application.Title + '.OneInstance32.CriticalSection') );
     g_hAppMutex := CreateMutex( nil, false, PChar(Application.Title + 'OneInstance32.Default') );
     dw := WaitForSingleObject( g_hAppMutex, 0 );
     Result :=  (dw <> WAIT_TIMEOUT);
     ReleaseMutex( g_hAppCritSecMutex );
     CloseHandle( g_hAppCritSecMutex );
end;

//------------------------------------------------------------------------------//
//                Подпрограмма для преобразования String в PChar                //
//------------------------------------------------------------------------------//
function StrToPChar(string_: String) : PChar;
begin
  string_ := string_ + #0;
  result  := StrPCopy(@string_[1], string_) ;
end;

//------------------------------------------------------------------------------//
//               Подпрограмма для получения строки из TFileStream               //
//------------------------------------------------------------------------------//
function GetStringFromFileStream(FileStream: TFileStream) : String;
var
   Str: String;
begin
   FileStream.Position := 0;
   SetLength(Str, FileStream.Size);
   FileStream.Read(Str[1], FileStream.Size);
   Result := Str;
end;

//------------------------------------------------------------------------------//
//                 Подпрограмма для декодирования строки BASE64                 //
//------------------------------------------------------------------------------//
function base64Decode(const Text : ansiString): ansiString;
var
  Decoder : TIdDecoderMime;
begin
  Decoder := TIdDecoderMime.Create(nil);
  try
    Result := Decoder.DecodeString(Text);
  finally
    FreeAndNil(Decoder)
  end
end;

//------------------------------------------------------------------------------//
//                 Подпрограмма кодирования строки в BASE64                 //
//------------------------------------------------------------------------------//
function DecodeBase64(Value: String): String;
const b64alphabet: PChar = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  function DecodeChunk(const Chunk: String): String;
  var
    W: LongWord;
    i: Byte;
  begin
    W := 0; Result := '';
    for i := 1 to 4 do
      if Pos(Chunk[i], b64alphabet) <> 0 then
        W := W + Word((Pos(Chunk[i], b64alphabet) - 1)) shl ((4 - i) * 6);
    for i := 1 to 3 do
      Result := Result + Chr(W shr ((3 - i) * 8) and $ff);
  end;
begin
  Result := '';
  if Length(Value) mod 4 <> 0 then Exit;
  while Length(Value) > 0 do
  begin
    Result := Result + DecodeChunk(Copy(Value, 0, 4));
    Delete(Value, 1, 4);
  end;
end;

//------------------------------------------------------------------------------//
//       Подпрограмма преобразования типа данных Bool в тип данных String       //
//------------------------------------------------------------------------------//
function BoolToStr(const value : boolean) : string;
const Values : array [ boolean ] of string = ( 'False', 'True' ) ;
begin
   Result := Values [ value ] ;
end;

//------------------------------------------------------------------------------//
// Подпрограмма для получения списка строк, которые отделены в ориг. разделитм. //
//------------------------------------------------------------------------------//
function ExtractWord(const AString: string; const ADelimiter: Char): TStringList;
var
  I, K: integer;
  AStringList: TStringList;
begin
   AStringList := TStringList.Create();
   I := 1;
   for K := 1 to Length(AString) do begin
      if (AString[K] = ADelimiter) then begin
         AStringList.Add(Copy(AString, I, K - I));
         I := K + 1;
      end;
      if (K = Length(AString)) then begin
         AStringList.Add(Copy(AString, I, K - I + 1));
      end;
   end;
   Result := AStringList;
end;

//------------------------------------------------------------------------------//
//              Подпрограмма для получения позиции символа в строке             //
//------------------------------------------------------------------------------//
function GetSymPos(St1:string;Sym:char;StartI:integer=0):smallint;
var
  i:smallint;
begin
  Result:=0;
  i:=StartI;
  while (i<=Length(St1)) AND (Result=0) do
  begin
    if (i>0) AND (St1[i]=Sym) then Result:=i;
    i:=i+1;
  end;
end;

//------------------------------------------------------------------------------//
//               Подпрограмма для получения слова до разделителя                //
//------------------------------------------------------------------------------//
function GetStrToSep(St1:string;Sym1,Sym2:char;Var Pos:integer):string;
var
  St2:string;
begin
  St2:='';
  while (Pos<=Length(St1)) AND (St1[Pos]<>Sym1) AND (St1[Pos]<>Sym2) do
  begin
    St2:=St2+St1[Pos];
    Pos:=Pos+1;
  end;
  Pos:=Pos+1;
  Result:=St2;
end;

//------------------------------------------------------------------------------//
//               Подпрограмма для получения слова до разделителя                //
//------------------------------------------------------------------------------//
function GetStrToSep(St1:string;Sym:char;Var Pos:integer):string;
var
  St2:string;
begin
  St2:='';
  while (Pos<=Length(St1)) AND (St1[Pos]<>Sym) do
  begin
    St2:=St2+St1[Pos];
    Pos:=Pos+1;
  end;
  Pos:=Pos+1;
  Result:=St2;
end;

//------------------------------------------------------------------------------//
//               Подпрограмма для получения слова до разделителя                //
//------------------------------------------------------------------------------//
function GetStrToSep(St1:string;Sym:char;Pos:smallint):string;
var
  St2:string;
  _pos:smallint;
begin
  St2:='';
  _pos:=Pos;
  while (_pos<=Length(St1)) AND (St1[_pos]<>Sym) do
  begin
    St2:=St2+St1[_pos];
    _pos:=_pos+1;
  end;
  Result:=St2;
end;

//------------------------------------------------------------------------------//
//               Подпрограмма для получения слова до разделителя                //
//------------------------------------------------------------------------------//
function GetStrToSep(St1:string;Sym:char):string;
var
  St2:string;
  i:integer;
begin
  St2:='';
  i:=1;
  while (i<=Length(St1)) AND (St1[i]<>Sym) do
  begin
    St2:=St2+St1[i];
    i:=i+1;
  end;
  Result:=St2;
end;

//------------------------------------------------------------------------------//
//      ������������ ��� ������ ���������� ������ *.res � �������� �����        //
//------------------------------------------------------------------------------//
function GetFileCount(Dir: string):integer;
var
  fs: TSearchRec;
  pics: integer;
begin
  pics:=0;
  if FindFirst(Dir+'/*.res', faAnyFile, fs) = 0
    then
    repeat
      inc(pics);
    until
      FindNext(fs) <> 0;
  //FindClose(fs);

Result := Pics-1;
end;

function FindTask(ExeFileName: string): Boolean;
var
  FSnapshotHandle: HWND;
  ContinueLoop: BOOL;
  FProcessEntry32: TProcessEntry32;
begin
  Result := False;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while integer(ContinueLoop) <> 0 do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName))
     or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName)))
      then Result := True;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

end.
