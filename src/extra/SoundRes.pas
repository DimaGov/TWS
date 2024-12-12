Unit SoundRes;

interface

uses SysUtils, Classes, Forms, Windows, IdCoderMIME;

procedure DecodeResAndPlay(FileName: String;
                           var FlagName: Boolean;
                           var PCharName: PChar;
                           var ChannelName: Cardinal;
                           var ResPotok: TMemoryStream;
                           var PlayResFlag: Boolean);

implementation

//------------------------------------------------------------------------------//
//     Подпрограмма, для воспроизведения зашифрованых звуков *.res формата      //
//------------------------------------------------------------------------------//
procedure DecodeResAndPlay(FileName: String;
                           var FlagName: Boolean;
                           var PCharName: PChar;
                           var ChannelName: Cardinal;
                           var ResPotok: TMemoryStream;
                           var PlayResFlag: Boolean);
var
	FS: TFileStream;
        J,K,codeAdder: Integer;
        sDecodeString: String;
        Len: Integer;
        decoderMIME1: TIdDecoderMIME;
begin
     if FileExists(FileName)=True then begin
	try
           ResPotok.Free();
           ResPotok := TMemoryStream.Create;
	   FS := TFileStream.Create(FileName, fmOpenRead);
           FS.Position := 0;
           SetLength(sDecodeString, fs.Size);
           FS.Read(sDecodeString[1], fs.Size);
           FS.Free;
           K := 0;
           if(Pos('.mp3',FileName)=0)And(Pos('.wav',FileName)=0)then begin
              Len:=Length(sDecodeString);
              if(Pos('.res2',FileName)>0)then Len:=Trunc(Len/32);
              for J:=1 to Length(sDecodeString) do begin
                 if (J mod 6=0) then begin Inc(K); end else
                    if (J mod 4=0) then codeAdder := 3 else
                       if (J mod 3=0) then codeAdder := 1 else
                          if (J mod 2=0) then codeAdder := 4 else
                             codeAdder := 2;
                 sDecodeString[J] := Chr(ord(sDecodeString[J]) - K * codeAdder);
                 if K > 32 then K := 0;
              end;
           end;
           decoderMIME1 := TIdDecoderMIME.Create(nil);
           if (Pos('.mp3', FileName) = 0) and (Pos('.wav', FileName) = 0) then
              sDecodeString := decoderMIME1.DecodeString(sDecodeString);
           ResPotok.Write(sDecodeString[1], Length(sDecodeString));
           ResPotok.Position := 0;

           FlagName:=False;
           PlayRESFlag := True;
        except end;
     end;
end;

end.
