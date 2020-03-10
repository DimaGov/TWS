//------------------------------------------------------------------------------//
//                                                                              //
//      Модуль речевых информаторов (САВП)         //
//      (c) DimaGVRH, Dnepr city, 2019                                          //
//                                                                              //
//------------------------------------------------------------------------------//
unit SAVP;

interface

   uses Classes;

   procedure SAVPTick();
   procedure Load_TWS_SAVP_EK();
   procedure InitializeSAVP;
   procedure GetLocalEKFromScenery(sceneryDir: String);
   procedure RefreshMVPSType();
   procedure LoadSOVI_EK(fileDir: String);
   procedure LoadSAVPE_EK(fileDir: String);
   procedure SAVPE_DoorCloseTimerTick();

var
     isUPU:                       Boolean;	     // Флаг для определения САВПЭ, или УПУ(перекраска > 400)
     SAVPEEnabled:                Boolean;      // Статус САВПЭ
     SAVPName:                    String;	   // Имя системы автоведения поезда (имя папки где звуки САВП)
     scSAVPOverrideRouteEK:       Boolean;

implementation

uses UnitMain, SysUtils, Math, Windows, Bass, inifiles, UnitDebug, ExtraUtils, SoundManager, Dialogs, Debug, bass_fx;

var
     AutoInformIndx:              Byte;	     // Текущая дорожка авто-информатора
     InformIndx:                  Integer;      // Текущая дорожка программы информатора
     TotalInfoFiles:              Integer;      // Всего дорожек программы информатора
     TotalAutoInfoFiles:          Integer;
     TotalServiceFiles:           Integer;
     AutoInformDoorFlag:          Boolean;      // Флаг который переключает на закрытеи дверей при V=0
     SAVPBaseObjectsCount:        Integer;
     BaseInfoTrack:               Array[0..500] of Integer;
     SAVPBaseInfoName1:           Array[0..500] of String; // Первый столбец файла ЭК [САУТ, УСАВПП, САВПЭ]
     SAVPBaseInfoName2:           Array[0..500] of String; // Второй столбец файла ЭК [САУТ, УСАВПП, САВПЭ]
     SAVPBaseInfoName3:           Array[0..500] of String; // Третий столбец файла ЭК [САВПЭ]
     SAVPEBaseObjectsCount:       Integer;
     SAVPEBaseInfoTrack:          Array[0..500] of Integer;
     SAVPEBaseInfoName1:          Array[0..500] of String; // Первый столбец файла ЭК [САУТ, УСАВПП, САВПЭ]
     SAVPEBaseInfoName2:          Array[0..500] of String; // Второй столбец файла ЭК [САУТ, УСАВПП, САВПЭ]
     SAVPEBaseInfoName3:          Array[0..500] of String; // Третий столбец файла ЭК [САВПЭ]
     ThirdColumnAval:             Boolean;
     scBaseInfoCount:             Integer;
     scBaseInfoTrack:             Array[0..500] of Integer;
     scSAVPBaseInfoName:          Array[0..500] of String;
     SAVP_EK_NewSystem:           Boolean;      // Переменная для определения, новая-ли система ЭК маршрута (*.TWS, *.txt)
     BaseAutoInfoTrack:           Array[0..500] of Integer;
     BaseAutoInfoName:            Array[0..500] of String;
     BaseServiceInfoTrack:        Array[0..500] of Integer;
     BaseServiceInfoName:         Array[0..500] of String;
     SAVPEInformatorMessages:     TStringList;
     SAVPEMessageIndex:           Byte;
     SAVPEFilePrefiks:            String;       // Префикс для имён файлов ("SAVPE_", "UPU_")
     isOn150mOnSvetofor:          Integer;
     isOn250mOnSvetofor:          Integer;
     LocomotiveBreaked:           Boolean = True; // Для УСАВПП, локомотива заторможен
     ZvonOrdinats:                Array[0..500] of Integer;
     ZvonTracks:                  Array[0..500] of Integer;
     ZvonBaseName:                Array[0..500] of String;
     ZvonObjectsCount:            Integer;
     NatureOrdinats1:             Array[0..500] of Integer;
     NatureOrdinats2:             Array[0..500] of Integer;
     NatureTracks1:               Array[0..500] of Integer;
     NatureTracks2:               Array[0..500] of Integer;
     NatureBaseName:              Array[0..500] of String;
     NatureObjectsCount:          Integer;
     NatureZone:                  Boolean;
     NatureVolume:                Single;
     NatureVolumeDest:            Single;
     NaturePitch:                 Single;

//------------------------------------------------------------------------------//
//    Подпрограмма срабатывания таймера САВПЭ на стоянке для закрытия дверей    //
//------------------------------------------------------------------------------//
procedure SAVPE_DoorCloseTimerTick();
begin
     With FormMain do begin
        SAVPEMessageIndex := 0;
        SAVPEInformatorMessages := ExtractWord(SAVPBaseInfoName2[InformIndx], ';');
        DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Info/'+ComboBox1.Items[ComboBox1.ItemIndex]+'/'+SAVPEInformatorMessages[0],
                         isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
        Inc(InformIndx);
        Label46.Caption:=IntToStr(InformIndx)+' / '+IntToStr(TotalInfoFiles);
        timerDoorCloseDelay.Enabled := False;
        AutoInformDoorFlag:=False;
     end;
end;

//------------------------------------------------------------------------------//
//                  Подпрограмма для очистки базы данных САВП                   //
//------------------------------------------------------------------------------//
procedure clearSAVPBaseData();
var
     I: Integer;
begin
     for I:=0 to 500 do begin
        BaseInfoTrack[I]:=0; SAVPBaseInfoName1[I]:=''; SAVPBaseInfoName2[I]:='';
        if Trim(SAVPBaseInfoName1[I+1])='' then break;
     end;
     SAVPBaseObjectsCount := 0;
     //FormDebug.Memo1.Clear();
end;

//------------------------------------------------------------------------------//
//                  Подпрограмма для очистки базы данных САВП                   //
//------------------------------------------------------------------------------//
procedure clearSAVPEBaseData();
var
     I: Integer;
begin
     for I:=0 to 500 do begin
        SAVPEBaseInfoTrack[I]:=0; SAVPEBaseInfoName1[I]:=''; SAVPEBaseInfoName2[I]:='';
        SAVPEBaseInfoName3[I]:='';
        if Trim(SAVPEBaseInfoName1[I+1])='' then break;
     end;
     SAVPEBaseObjectsCount := 0;
     //FormDebug.Memo1.Clear();
end;

//------------------------------------------------------------------------------//
//       Подпрограмма для очистки базы данных САВП локальной из сценария        //
//------------------------------------------------------------------------------//
procedure clearscSAVPBaseData();
var
     I: Integer;
begin
     for I:=0 to 500 do begin
        scBaseInfoTrack[I]:=0; scSAVPBaseInfoName[I]:='';
        if Trim(scSAVPBaseInfoName[I+1])='' then break;
     end;
     scBaseInfoCount := 0;
     FormDebug.Memo2.Clear();
end;

//------------------------------------------------------------------------------//
//           Подпрограмма для очистки базы данных звонков на переездах          //
//------------------------------------------------------------------------------//
procedure clearZvonBaseData();
var
   I:Integer;
begin
     for I:=0 to 500 do begin
        ZvonOrdinats[I]:=0; ZvonBaseName[I]:='';
        ZvonTracks[I] :=0;
        if Trim(ZvonBaseName[I+1])='' then break;
     end;
     ZvonObjectsCount := 0;
end;

//------------------------------------------------------------------------------//
//            Подпрограмма для очистки базы данных звуков окружения             //
//------------------------------------------------------------------------------//
procedure clearNatureBaseData();
var
   I:Integer;
begin
     for I:=0 to 500 do begin
        NatureOrdinats1[I]:=0; NatureBaseName[I]:='';
        NatureTracks1[I] :=0; NatureOrdinats2[I]:=0;
        NatureTracks2[I] :=0;
        if Trim(NatureBaseName[I+1])='' then break;
     end;
     NatureObjectsCount := 0;
end;

//------------------------------------------------------------------------------//
//               Подпрограмма для показа БД САВП в окне отладки                 //
//------------------------------------------------------------------------------//
procedure displaySAVPBaseDataToDebugWindow();
var
     I: Integer;
begin
     FormDebug.Memo1.Clear;
     for I := 0 to SAVPBaseObjectsCount do begin
        FormDebug.Memo1.Lines.Add(IntToStr(BaseInfoTrack[I]) + #9 + SAVPBaseInfoName1[I] + #9 + SAVPBaseInfoName2[I]);
     end;
     for I := 0 to ZvonObjectsCount do begin
        FormDebug.Memo3.Lines.Add(IntToStr(ZvonOrdinats[I]) + #9 + ZvonBaseName[I]);
     end;
end;

//------------------------------------------------------------------------------//
//         Подпрограмма для показа БД САВП из сценария в окне отладки           //
//------------------------------------------------------------------------------//
procedure displayscSAVPBaseDataToDebugWindow();
var
     I: Integer;
begin
     FormDebug.Memo2.Clear;
     for I := 0 to scBaseInfoCount - 1 do begin
        FormDebug.Memo2.Lines.Add(IntToStr(scBaseInfoTrack[I]) + #9 + scSAVPBaseInfoName[I]);
     end;
end;

//------------------------------------------------------------------------------//
//                       Подпрограмма для загрузки ЭК СОВИ                      //
//------------------------------------------------------------------------------//
procedure LoadSOVI_EK(fileDir: String);
var
   wIni: TIniFile;
   I:Integer;
   FileLinesList: TStringList;
   FileText: String;
   FS: TFileStream;
   FOO: Boolean;
begin
   //try
      With FormMain do begin
         wIni := TIniFile.Create(fileDir);
         Memo4.Text := wIni.ReadString('DESCRIPTION', 'Text', 'У данной ЭК описание отсутствует! Обратитесь к автору!');
         wIni.Free;

         // Очищаем базу ЭК САВП
         clearSAVPBaseData();
         TotalInfoFiles := 0;
         InformIndx     := 0;

         // Загружаем ЭК
         FS := TFileStream.Create(fileDir, fmShareDenyNone);
         FileText := GetStringFromFileStream(FS);
         FS.Free();
         FileLinesList := ExtractWord(FileText, #13);
         for I := 0 to FileLinesList.Count-1 do begin
            FileLinesList[I] := StringReplace(StringReplace(FileLinesList[I], #13, '', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
            if FOO = True then begin
               SAVPBaseInfoName1[TotalInfoFiles] := Trim(FileLinesList[I]);
               Inc(TotalInfoFiles);
            end;
            if Pos('[DATA]', FileLinesList[I]) > 0 then FOO:=True;
         end;
      end;
   //except end;
end;

//------------------------------------------------------------------------------//
//                      Подпрограмма для загрузки ЭК САВПЭ                      //
//------------------------------------------------------------------------------//
procedure LoadSAVPE_EK(fileDir: String);
var
     wIni: TIniFile;
     I: Integer;
     st: String;
     FS: TFileStream;
     FileText: String;
     FileLinesList: TStringList;
     FileLineColumn: TStringList;
     FOO, BAR, ZOO: Boolean;
begin
     if FileExists(fileDir) then begin
        With FormMain do begin
           // Задаем расположение файла ЭК
           wIni := TIniFile.Create(fileDir);
	   Memo7.Lines.Clear;
           if ComboBox2.ItemIndex<>0 then
              Memo7.Text := wIni.ReadString('DESCRIPTION', 'Text', 'У данной ЭК описание отсутствует! Обратитесь к автору!')
           else Memo7.Text := 'Рэжим - без ЭК';
           wIni.Free;
           // Очищаем базу ЭК САВП
           clearSAVPEBaseData();

           // Загружаем ЭК
           FS := TFileStream.Create(fileDir, fmShareDenyNone);
           FileText := GetStringFromFileStream(FS);
           FS.Free();
           FileLinesList := ExtractWord(FileText, #13);
           timerDoorCloseDelay.Enabled:=False; AutoInformDoorFlag:=False; AutoInformIndx:=0; InformIndx:=0;
           TotalInfoFiles:=0; TotalAutoInfoFiles:=0; TotalServiceFiles:=0; FOO:=False; BAR:=False; ZOO:=False;
           ThirdColumnAval := False;
           for I := 0 to FileLinesList.Count - 1 do begin
              FileLinesList[I] := StringReplace(StringReplace(FileLinesList[I], #13, '', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
              if (FOO=True) or (BAR=True) or (ZOO=True) then begin
                 if FOO=True then begin
                    if Trim(FileLinesList[I])='[MARKETING]' then begin BAR:=True; FOO:=False; ZOO:=False; end else begin
                    FileLineColumn := ExtractWord(FileLinesList[I], #9);
                    if FileLineColumn.Count >= 3 then begin
                       if Trim(FileLineColumn[0]) <> 'start' then
                          SAVPEBaseInfoTrack[TotalInfoFiles] := StrToInt(FileLineColumn[0])
                       else
                          SAVPEBaseInfoTrack[TotalInfoFiles] := 0;
                       SAVPEBaseInfoName1[TotalInfoFiles] := FileLineColumn[1];
                       SAVPEBaseInfoName2[TotalInfoFiles] := FileLineColumn[2];
                       if FileLineColumn.Count >= 4 then begin
                          if Trim(FileLineColumn[3]) <> '' then begin
                             SAVPEBaseInfoName3[TotalInfoFiles] := FileLineColumn[3];
                             ThirdColumnAval := True;
                          end;
                       end;
                       Inc(TotalInfoFiles);
                    end;
                    end;
                 end;
                 if BAR=True then begin
                    if Trim(FileLinesList[I])='[SERVICE]' then begin ZOO:=True; FOO:=False; BAR:=False; end;
                    FileLineColumn := ExtractWord(FileLinesList[I], #9);
                    if FileLineColumn.Count >= 2 then begin
                       BaseAutoInfoTrack[TotalAutoInfoFiles] := StrToInt(FileLineColumn[0]);
                       BaseAutoInfoName[TotalAutoInfoFiles] := FileLineColumn[1];
                       Inc(TotalAutoInfoFiles);
                    end;
                 end;
                 if ZOO=True then begin
                    FileLineColumn := ExtractWord(FileLinesList[I], #9);
                    if FileLineColumn.Count >= 2 then begin
                       BaseServiceInfoTrack[TotalServiceFiles] := StrToInt(FileLineColumn[0]);
                       BaseServiceInfoName[TotalServiceFiles] := FileLineColumn[1];
                       Inc(TotalServiceFiles);
                    end;
                 end;
              end else begin
                 if Trim(FileLinesList[I]) = '[DATA]' then begin FOO:=True; BAR:=False; ZOO:=False; end;
              end;
           end;
           Label124.Caption := IntToStr(TotalAutoInfoFiles);
        end;

        displaySAVPBaseDataToDebugWindow();
     end;
end;

//------------------------------------------------------------------------------//
//           Подпрограмма для инициализации начальных переменных САВП           //
//------------------------------------------------------------------------------//
procedure InitializeSAVP;
begin
  SAVPEInformatorMessages := TStringList.Create();
  SAVPEMessageIndex       := 0;
  isUPU                   := False;	  // Стандарт - САВПЭ при запуске
  AutoInformIndx          := RandomRange(0, 15);
  InformIndx              := 0;
end;

//------------------------------------------------------------------------------//
//     Подпрограмма для определения типа САВП на эл-поезде (САВПЭ или УПУ)      //
//------------------------------------------------------------------------------//
procedure RefreshMVPSType();
begin
     if FormMain.cbSAVPESounds.Checked = True then begin
        SAVPEFilePrefiks := 'SAVPE_'; isUPU := False;
        if LocoGlobal = 'ED4M' then begin
           if LocoNum >= 301 then begin
              if LocoNum = 422 then SAVPEFilePrefiks := 'UPU_0422' else SAVPEFilePrefiks := 'UPU_';
              isUPU := True;
           end;
        end;
        if (LocoGlobal = 'ED9M') and (LocoNum = 222) then SAVPEFilePrefiks := 'SAVPE_0222';
     end;
end;

//------------------------------------------------------------------------------//
//      Подпрограмма для парсигна файла сценария для прогрузки локальной ЭК     //
//------------------------------------------------------------------------------//
procedure GetLocalEKFromScenery(sceneryDir: String);
var
   FS: TFileStream;
   FileText: String;
   FileLinesList: TStringList;
   I, J: Integer;
   ObjectsList: TStringList;
begin
   J := -1;
   if FileExists(sceneryDir) then begin
      FS := TFileStream.Create(sceneryDir, fmShareDenyNone);
      FileText := GetStringFromFileStream(FS);
      FS.Free();
      FileLinesList := ExtractWord(FileText, #13);
      scBaseInfoCount := FileLinesList.Count;
      for I := 0 to scBaseInfoCount - 1 do begin
         if Pos('[TWS-EK]', FileLinesList[I]) > 0 then begin
            J := I; Break;
         end;
      end;
      if J <> -1 then begin
         for I := J + 1 to scBaseInfoCount - 1 do begin
            FileLinesList[I] := StringReplace(StringReplace(FileLinesList[I], #13, '', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
            ObjectsList := ExtractWord(FileLinesList[I], #9);
            if ObjectsList.Count >= 2 then begin
               if Pos('overrideRouteEK', ObjectsList[0]) > 0 then begin
                  if ObjectsList[1] = '0' then scSAVPOverrideRouteEK := False;
                  if ObjectsList[1] = '1' then begin scSAVPOverrideRouteEK := True; clearSAVPBaseData(); end;
               end else begin
                  try scBaseInfoTrack[I - J - 1] := StrToInt(ObjectsList[0]); except scBaseInfoTrack[I - J - 1] := 0;  end;
                  scSAVPBaseInfoName[I - J - 1] := ObjectsList[1];
               end;
            end;
         end;
      end;
      scBaseInfoCount := scBaseInfoCount - J - 1;
      displayscSAVPBaseDataToDebugWindow();
      ObjectsList.Free;
      FileLinesList.Free;
   end;
end;

//------------------------------------------------------------------------------//
// Подпрограмма для конвертирования старого имя сэмпла УСАВПП новое(закодиров.) //
//------------------------------------------------------------------------------//
function ConvertOldUSAVPNameToNewResName(Str: String) : String;
begin
     Str := LowerCase(Str);
     Result := '0';
     if Str = 'ogranichenie.mp3' then Result := '552';
     if Str = 'pereezd.mp3' then Result := '553';
     if Str = 'proba.mp3' then Result := '554';
     if Str = 'neyt_vstavka.mp3' then Result := '555~';
     if Str = 'tokorazdel.mp3' then Result := '555-';
     if Str = 'uksps.mp3' then Result := '556';
     if Str = 'disk.mp3' then Result := '557d';
     if Str = 'ktsm.mp3' then Result := '557k';
     if Str = 'ponab.mp3' then Result := '557p';
     if Str = 'vos.mp3' then Result := '559';
     if Str = 'ostanovka.mp3' then Result := '561';
     if Str = 'most.mp3' then Result := '572';
     if Str = 'tonnel.mp3' then Result := '573';
     if Str = 'op_mesto.mp3' then Result := '574';
     if Str = 'puteprovod.mp3' then Result := '577';
     if Str = 'signal.mp3' then Result := '578';
     if Str = 'perehod.mp3' then Result := '579';
     if Str = 'platform.mp3' then Result := '580';
     if Str = 'station.mp3' then Result := '585';
     if Str = 'signal.mp3' then Result := '578';
     if Str = 'gazoprovod.mp3' then Result := '604';
end;

//------------------------------------------------------------------------------//
//       Подпрограмма для парсигна файла ЭК (Получение ординат переездов)       //
//------------------------------------------------------------------------------//
procedure GetSAVPPereezdOrdinats(filename: String);
var
   FS: TFileStream;
   FileText: String;
   FileLinesList: TStringList;
   ObjectsList: TStringList;
   I, X, Y: Integer;
begin
   FS := TFileStream.Create(fileName, fmShareDenyNone);
   FileText := GetStringFromFileStream(FS);
   FS.Free();
   FileLinesList := ExtractWord(FileText, #13);
   clearZvonBaseData();
   for I := 0 to FileLinesList.Count - 1 do begin
      FileLinesList[I] := StringReplace(StringReplace(FileLinesList[I], #13, '', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
      ObjectsList := ExtractWord(FileLinesList[I], #9);
      if Pos('Zvon', ObjectsList[1]) > 0 then begin
         if (Pos('o', ObjectsList[0]) = 0) then begin
            ZvonTracks[ZvonObjectsCount] := StrToInt(ObjectsList[0]);
         end else begin
            ZvonOrdinats[ZvonObjectsCount] := StrToInt(StringReplace(ObjectsList[0], 'o', '', [rfReplaceAll]));
         end;
         ZvonBaseName[ZvonObjectsCount] := StringReplace(ObjectsList[1], '.mp3', '.wav', [rfReplaceAll]);
         Inc(ZvonObjectsCount);
      end;
   end;
   ObjectsList.Free;
   FileLinesList.Free;
end;

//------------------------------------------------------------------------------//
//    Подпрограмма для парсигна файла ЭК (Получение ординат звуков окружения)   //
//------------------------------------------------------------------------------//
procedure GetSAVPNatureObjectsOrdinats(filename: String);
var
   FS: TFileStream;
   FileText: String;
   FileLinesList: TStringList;
   ObjectsList: TStringList;
   I, X, Y: Integer;
begin
   FS := TFileStream.Create(fileName, fmShareDenyNone);
   FileText := GetStringFromFileStream(FS);
   FS.Free();
   FileLinesList := ExtractWord(FileText, #13);
   clearNatureBaseData();
   for I := 0 to FileLinesList.Count - 1 do begin
      FileLinesList[I] := StringReplace(StringReplace(FileLinesList[I], #13, '', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
      ObjectsList := ExtractWord(FileLinesList[I], #9);
      if Pos('nature', ObjectsList[0]) > 0 then begin
         if (Pos('o', ObjectsList[1]) > 0) then begin
            NatureOrdinats1[NatureObjectsCount] := StrToInt(StringReplace(ObjectsList[1], 'o', '', [rfReplaceAll]));
            NatureOrdinats2[NatureObjectsCount] := StrToInt(StringReplace(ObjectsList[2], 'o', '', [rfReplaceAll]));
         end else begin
            NatureTracks1[NatureObjectsCount] := StrToInt(ObjectsList[1]);
            NatureTracks2[NatureObjectsCount] := StrToInt(ObjectsList[2]);
         end;
         NatureBaseName[NatureObjectsCount] := StringReplace(ObjectsList[3], '.mp3', '.wav', [rfReplaceAll]);
         Inc(NatureObjectsCount);
      end;
   end;
   ObjectsList.Free;
   FileLinesList.Free;
end;

//------------------------------------------------------------------------------//
//                      Подпрограмма для парсигна файла ЭК                      //
//------------------------------------------------------------------------------//
procedure GetSAVPObjectsBaseFromFile(filename: String; newSystem: Boolean);
var
     FS: TFileStream;
     FileText: String;
     FileLinesList: TStringList;
     ObjectsList: TStringList;
     I, J: Integer;
begin
     SAVP_EK_NewSystem := newSystem;
     FS := TFileStream.Create(fileName, fmShareDenyNone);
     FileText := GetStringFromFileStream(FS);
     FS.Free();
     FileLinesList := ExtractWord(FileText, #13);
     SAVPBaseObjectsCount := 0;
     for I := 0 to FileLinesList.Count - 1 do begin
        FileLinesList[I] := StringReplace(StringReplace(FileLinesList[I], #13, '', [rfReplaceAll]), #10, ' ', [rfReplaceAll]);
        ObjectsList := ExtractWord(FileLinesList[I], #9);
        if ObjectsList.Count >= 2 then begin
           if (Pos('Zvon', ObjectsList[1]) = 0) and (Pos('nature', ObjectsList[0]) = 0) then begin
              BaseInfoTrack[SAVPBaseObjectsCount] := StrToInt(ObjectsList[0]);
              if newSystem = True then begin
                 SAVPBaseInfoName1[SAVPBaseObjectsCount] := ObjectsList[1];
                 SAVPBaseInfoName2[SAVPBaseObjectsCount] := ObjectsList[2];
              end else begin
                 SAVPBaseInfoName1[SAVPBaseObjectsCount] := StringReplace(ObjectsList[1], '.mp3', '', [rfReplaceAll]);
                 SAVPBaseInfoName2[SAVPBaseObjectsCount] := ConvertOldUSAVPNameToNewResName(ObjectsList[1]);
              end;
              Inc(SAVPBaseObjectsCount);
           end;
        end;
     end;
     ObjectsList.Free;
     FileLinesList.Free;
     try displaySAVPBaseDataToDebugWindow(); except end;
end;

//------------------------------------------------------------------------------//
//                     Подпрограмма цикла САВП (Для переездов)                  //
//------------------------------------------------------------------------------//
procedure PereezdCycle();
var
   I: Integer;
begin
   PereezdZone := False;
              for I := 0 to ZvonObjectsCount do begin
                 if (Abs(OrdinataEstimate-ZvonOrdinats[I]) <= 30) And (ZvonOrdinats[I] <> 0) then begin
                    ZvonokVolume := (( exp(1 - Abs(OrdinataEstimate-ZvonOrdinats[I])/36) - 1 ) / 2) * FormMain.trcBarNatureVol.Position/100;
                    ZvonokVolumeDest := ZvonokVolume;
                    PereezdZone := True;
                 end;
                 if (Abs(Track-ZvonTracks[I]) <= 1) then begin
                    ZvonokVolumeDest := ((2 - Abs(Track-ZvonTracks[I])) * 2) * FormMain.trcBarNatureVol.Position/100;
                    PereezdZone := True;
                 end;
                 if PereezdZone = True then begin
                    if BASS_ChannelIsActive(SAUTChannelZvonok) = 0 then begin
                       SAUTF := StrNew(PChar('TWS/SAVP/Other/' + ZvonBaseName[I]));
                       if Ordinata <> 0 then isPlaySAUTZvonok := True;
                    end;
                    Break;
                 end;
              end;

              if BASS_ChannelIsActive(SAUTChannelZvonok) <> 0 then begin
                 if ZvonokVolume < ZvonokVolumeDest then ZvonokVolume := ZvonokVolume + 0.001 * MainCycleFreq;
                 if ZvonokVolume > ZvonokVolumeDest then ZvonokVolume := ZvonokVolume - 0.001 * MainCycleFreq;
                 if ZvonokVolume > 1 then ZvonokVolume := 1;
                 ZvonokFreq := 44100 + Speed * 20;
                 BASS_ChannelSetAttribute(SAUTChannelZvonok, BASS_ATTRIB_VOL, ZvonokVolume);
                 BASS_ChannelSetAttribute(SAUTChannelZvonok, BASS_ATTRIB_FREQ, ZvonokFreq);
              end;

              if PereezdZone = False then begin
                 if (BASS_ChannelIsActive(SAUTChannelZvonok) <> 0) then begin
                    ZvonokVolumeDest := 0.0;
                    if ZvonokVolume < 0.05 then begin
                       BASS_ChannelStop(SAUTChannelZvonok); BASS_StreamFree(SAUTChannelZvonok);
                    end;
                 end;
              end;
end;

//------------------------------------------------------------------------------//
//                    Подпрограмма цикла звуков окружения                       //
//------------------------------------------------------------------------------//
procedure NatureCycle();
var
   I: Integer;
begin
   NatureZone := False;
              for I := 0 to NatureObjectsCount do begin
                 if (OrdinataEstimate>NatureOrdinats1[I]) And (OrdinataEstimate<NatureOrdinats2[I]) then begin
                    NatureVolume := (Speed / 65) * FormMain.trcBarNatureVol.Position / 100;
                    NatureVolumeDest := NatureVolume;
                    NatureZone := True;
                 end;
                 if ((Track>NatureTracks1[I])And(Track<NatureTracks2[I])And(Naprav='Tuda'))
                    Or((Track<NatureTracks1[I])And(Track>NatureTracks2[I])And(Naprav='Obratno'))
                    then begin
                    NatureVolume := (Speed / 65) * FormMain.trcBarNatureVol.Position/100;
                    NatureVolumeDest := NatureVolume;
                    NatureZone := True;
                 end;
                 if NatureZone = True then begin
                    if BASS_ChannelIsActive(NatureChannel_FX) = 0 then begin
                       NatureF := StrNew(PChar('TWS/SAVP/Other/' + NatureBaseName[I]));
                       if Ordinata <> 0 then isPlayNature := True;
                    end;
                    Break;
                 end;
              end;

              if BASS_ChannelIsActive(NatureChannel_FX) <> 0 then begin
                 if NatureVolume < NatureVolumeDest then NatureVolume := NatureVolume + 0.001 * MainCycleFreq;
                 if NatureVolume > NatureVolumeDest then NatureVolume := NatureVolume - 0.001 * MainCycleFreq;
                 if NatureVolume > 1 then NatureVolume := 1;
                 NaturePitch := -1.5 + Speed / 30;
                 BASS_ChannelSetAttribute(NatureChannel_FX, BASS_ATTRIB_VOL, NatureVolume);
                 BASS_ChannelSetAttribute(NatureChannel_FX, BASS_ATTRIB_TEMPO_PITCH, NaturePitch);
              end;

              if NatureZone = False then begin
                 if (BASS_ChannelIsActive(NatureChannel_FX) <> 0) then begin
                    NatureVolumeDest := 0.0;
                    if NatureVolume < 0.05 then begin
                       BASS_ChannelStop(NatureChannel_FX); BASS_StreamFree(NatureChannel_FX);
                    end;
                 end;
              end;
end;

//------------------------------------------------------------------------------//
//                            Подпрограмма цикла САВП                           //
//------------------------------------------------------------------------------//
procedure SAVPCycle();
var
     I, J: Integer;
     st: String;
begin
     With FormMain do begin
        //------------------------------------------------------------------------------//
        //  Воспроизведение речевого информатора о сигнале светофора при смене сигнала  //
        //------------------------------------------------------------------------------//
        if Svetofor<>PrevSvetofor then begin
           // ------- САУТ -------- //
           if cbSAUTSounds.Checked=True then begin
              if Svetofor=1 then begin
                 SAUTF := 'TWS/SAVP/SAUT/White.mp3';
                 isPlaySAUTObjects := False;
              end;
              if Svetofor=2 then begin
                 SAUTF := 'TWS/SAVP/SAUT/Red.mp3';
                 isPlaySAUTObjects := False;
              end;
              if Svetofor=3 then begin
                 SAUTF := 'TWS/SAVP/SAUT/Red.mp3';
                 isPlaySAUTObjects := False;
              end;
              if Svetofor=4 then begin
                 SAUTF := 'TWS/SAVP/SAUT/Yellow.mp3';
                 isPlaySAUTObjects := False;
              end;
              if Svetofor=5 then begin
                 SAUTF := 'TWS/SAVP/SAUT/Green.mp3';
                 isPlaySAUTObjects := False;
              end;
              PlayRESFlag := False;
           end;
           // ------- УСАВП ------- //
           if cbUSAVPSounds.Checked = True then begin
              if Svetofor=1 then
                 DecodeResAndPlay(PChar('TWS/SAVP/USAVP/560.res'), isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
              if Svetofor=2 then
                 DecodeResAndPlay(PChar('TWS/SAVP/USAVP/550.res'), isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
              if Svetofor=3 then
                 DecodeResAndPlay(PChar('TWS/SAVP/USAVP/550.res'), isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
              if Svetofor=4 then
                 DecodeResAndPlay(PChar('TWS/SAVP/USAVP/551.res'), isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
              if Svetofor=5 then
                 DecodeResAndPlay(PChar('TWS/SAVP/USAVP/582.res'), isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
           end;
           // --- Грузовой САУТ --- //
           if cbGSAUTSounds.Checked=True then begin
              if Svetofor=1 then begin
                 SAUTF:='TWS/SAVP/SAUT_G/White.mp3';
                 isPlaySAUTObjects:=False;
              end;
              if Svetofor=2 then begin
                 SAUTF:='TWS/SAVP/SAUT_G/Red.mp3';
                 isPlaySAUTObjects:=False;
              end;
              if Svetofor=3 then begin
                 SAUTF:='TWS/SAVP/SAUT_G/Red.mp3';
                 isPlaySAUTObjects:=False;
              end;
              if Svetofor=4 then begin
                 SAUTF:='TWS/SAVP/SAUT_G/Yellow.mp3';
                 isPlaySAUTObjects:=False;
              end;
              if Svetofor=5 then begin
                 SAUTF:='TWS/SAVP/SAUT_G/Green.mp3';
                 isPlaySAUTObjects:=False;
              end;
           end;
           // ---- САВПЭ(УПУ) ----- //
           if cbSAVPESounds.Checked = True then begin
              if (Svetofor=1) and (Speed<>0) then
                 DecodeResAndPlay(PChar('TWS/SAVP/' + SAVPEFilePrefiks + '/nk.res'), isPlaySAUTObjects,
                                  SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
              if Svetofor=2 then
                 DecodeResAndPlay(PChar('TWS/SAVP/' + SAVPEFilePrefiks + '/Red.res'), isPlaySAUTObjects,
                                  SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
              if Svetofor=3 then
                 DecodeResAndPlay(PChar('TWS/SAVP/' + SAVPEFilePrefiks + '/Red.res'), isPlaySAUTObjects,
                                  SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
              if (Svetofor=4) and (Speed>=60) then
                 DecodeResAndPlay(PChar('TWS/SAVP/' + SAVPEFilePrefiks + '/Yellow.res'), isPlaySAUTObjects,
                                  SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
           end;
        end;

        //------------------------------------------------------------------------------//
        //                  Обработка и воспроизведение дорожек из ЭК                   //
        //------------------------------------------------------------------------------//
        if (SAVPBaseObjectsCount > 0) AND (scSAVPOverrideRouteEK = False) then begin
           if (cbSAUTSounds.Checked = True) Or (cbUSAVPSounds.Checked = True) Or
              (cbGSAUTSounds.Checked = True) then begin
              if Track <> PrevTrack then begin
                 for I := 0 to SAVPBaseObjectsCount do begin
                    if Track = BaseInfoTrack[I] then begin
                       //if Pos('Zvon', SAVPBaseInfoName1[I]) > 0 then begin
                       //   SAUTF := 'TWS/SAVP/Other/Zvon.mp3';
                          // PlayRESFlag := False;
                          // isPlaySAUTZvonok := False;
                       //end else begin
                          if cbSAUTSounds.Checked = True then begin
                             DecodeResAndPlay('TWS/SAVP/SAUT/' + SAVPBaseInfoName1[I] + '.mp3',
                             		      isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);

                          end;
                          if cbGSAUTSounds.Checked = True then begin
                             DecodeResAndPlay('TWS/SAVP/SAUT_G/' + SAVPBaseInfoName1[I] + '.mp3',
                             		      isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
                          end;
                          if cbUSAVPSounds.Checked = True then begin
                             DecodeResAndPlay('TWS/SAVP/USAVP/' + SAVPBaseInfoName2[I] + '.res',
                                              isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
                          end;
                       //end;

                       if (Track-ZvonTrack>1) or (Track-ZvonTrack<1) then begin PereezdZatuh:=True; end;
                    end;
                 end;
              end;
           end;
        end;

        //------------------------------------------------------------------------------//
        //  Обработка и воспроизведение дорожек из локальной ЭК написанной в сценарии   //
        //------------------------------------------------------------------------------//
        if scBaseInfoCount > 0 then begin
           if Track <> PrevTrack then begin
              for I := 0 to scBaseInfoCount - 1 do begin
                 if Track = scBaseInfoTrack[I] then begin
                    DecodeResAndPlay('TWS\SAVP\' + scSAVPBaseInfoName[I], isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
                    (*if Pos('.res', scSAVPBaseInfoName[I]) > 0 then begin
                       DecodeResAndPlay('TWS\SAVP\' + scSAVPBaseInfoName[I], isPlaySAUTObjects, SAUTF, SAUTChannelObjects);
                    end;
                    if Pos('.mp3', scSAVPBaseInfoName[I]) > 0 then begin
                       BASS_ChannelStop(SAUTChannelObjects); BASS_StreamFree(SAUTChannelObjects);
                       BASS_ChannelStop(SAUTChannelObjects2); BASS_StreamFree(SAUTChannelObjects2);
                       SAUTF := PChar('TWS\SAVP\' + scSAVPBaseInfoName[I]);
                       DebugWriteErrorToErrorList('TWS\SAVP\' + scSAVPBaseInfoName[I]);
                       PlayRESFlag := False;
                       isPlaySAUTObjects := False;
                    end;*)
                 end;
              end;
           end;
        end;

        (*if FileExists('routes/'+Route+'/Info_Obj_'+naprav+'.txt')=True then begin
           try Memo2.Lines.LoadFromFile('routes/'+Route+'/Info_Obj_'+naprav+'.txt'); except end;
           for I := 0 to Memo2.Lines.Count do begin
              try st := GetStrToSep(Memo2.Lines[I],#9,1); except end;
              try
                 if (StrToInt(st)=Track) and (Track<>PrevTrack) then begin
                    st := Copy(Memo2.Lines[I], Length(st)+2, Length(Memo2.Lines[I]));
                    if cbSAUTSounds.Checked=True then SAUTF:=PChar('TWS/SAVP/SAUT/'+st);
                    if USAVPEnabled = True then SAUTF:=PChar('TWS/SAVP/USAVP/'+st);
                    if cbGSAUTSounds.Checked=True then SAUTF:=PChar('TWS/SAVP/SAUT_G/'+st);
                    if cbSAVPESounds.Checked=False then begin
                       if st<>'Zvon.mp3' then
                          isPlaySAUTObjects:=False else
                          isPlaySAUTZvonok:=False;
                    end;
                 end;
              except end;
           end;
           if (Track-ZvonTrack>1) or (Track-ZvonTrack<1) then begin PereezdZatuh:=True; end;
        end;*)

        //------------------------------------------------------------------------------//
        //                           Речевые оповещения САУТ                            //
        //------------------------------------------------------------------------------//
        if cbSAUTSounds.Checked=True then begin
           // --- Прекрещение зарядки АБ на ВЛ80т и ВЛ82м --- //
           if ((LocoGlobal='VL80t') or (LocoGlobal='VL82m')) and ((FrontTP<>0) or (BackTP<>0)) then begin
              if AB_ZB_1<>PrevAB_ZB_1 then
                 if AB_ZB_1 = 192 then begin
                    SAUTF := PChar('TWS\SAVP\SAUT\AB_1.mp3'); isPlaySAUTObjects := False;
                 end;
              if AB_ZB_2<>PrevAB_ZB_2 then
                 if AB_ZB_2 = 192 then begin
                    SAUTF := PChar('TWS\SAVP\SAUT\AB_2.mp3'); isPlaySAUTObjects := False;
                 end;
           end;

           if Speed<>0 then begin
           // ----------------- Боксование ------------------ //
              if PrevBoks_Stat<>Boks_Stat then
                 if Boks_Stat<>0 then begin
                    Randomize; Randomize;
                    J := RandomRange(1, 4);
                    SAUTF := PChar('TWS\SAVP\SAUT\boks_'+IntToStr(J)+'1.mp3');
                    isPlaySAUTObjects := False;
                 end;
           end;

           // ---------------- Перегрузка ТЭД --------------- //
           if (TEDAmperage>UltimateTEDAmperage) and (PrevTEDAmperage<=UltimateTEDAmperage) then begin
              SAUTF := PChar('TWS\SAVP\SAUT\overloadTED_1.mp3');
              isPlaySAUTObjects := False;
           end;

           if (Speed > 0) and (PrevSpeed_Fakt = 0) then begin
           // --------------- Начало движения --------------- //
              if (Floor(TEDAmperage) = 0) and (Acceleretion > 0) then begin
                 SAUTF := PChar('TWS\SAVP\SAUT\nac_dvj.mp3');
                 PlayRESFlag := False;
                 isPlaySAUTObjects := False;
              end;

              // --------------- Движение назад ---------------- //
              if Acceleretion < 0 then begin
                 SAUTF := PChar('TWS\SAVP\SAUT\backwardMove.mp3');
                 PlayRESFlag := False;
                 isPlaySAUTObjects := False;
              end;
           end;
        end;

        //------------------------------------------------------------------------------//
        //                          Речевые оповещения УСАВП                            //
        //------------------------------------------------------------------------------//
        if cbUSAVPSounds.Checked = True then begin
           if Speed > 0 then begin
              // --------- Начало движения --------- //
              if ((Floor(TEDAmperage) = 0) and (PrevSpeed_Fakt = 0)) and
                 ((Loco <> 'ED4M')) then
                 DecodeResAndPlay('TWS/SAVP/USAVP/581.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);

              // --- Система переходит на ЭПТ/ПТ --- //
              if EPT <> PrevEPT then begin
                 if EPT <> 0 then
                    DecodeResAndPlay('TWS/SAVP/USAVP/621.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);

                 if EPT = 0 then
                    DecodeResAndPlay('TWS/SAVP/USAVP/620.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
              end;
           end;

           if (LocoPowerVoltage = 3) and (Speed > 10) and (PrevSpeed_Fakt <= 10) then begin
              if (FrontTP = 63) and (BackTP = 63) then
                 DecodeResAndPlay('TWS/SAVP/USAVP/663.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
           end;

           // ----- Локомотив заторможен ----- //
           if (Speed > 0) and (LocomotiveBreaked = True) then
              LocomotiveBreaked := False;

           if LocomotiveBreaked = False then begin
              if (KM_294 <> 0) and (Speed = 0) and (BrakeCylinders > 30) then begin
                 if (PrevBrkCyl < 30) Or (PrevSpeed_Fakt > 0) then begin
                    DecodeResAndPlay('TWS/SAVP/USAVP/570.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
                    LocomotiveBreaked := True;
                 end;
              end;
           end;

           // ---- Превышение макс. тока ----- //
           if (TEDAmperage>UltimateTEDAmperage) and (PrevTEDAmperage<=UltimateTEDAmperage) then
              DecodeResAndPlay('TWS\SAVP\USAVP\599.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);

           // --- Подтвердите бдительность --- //
           if (VCheck <> 0) and (PrevVCheck = 0) then
              TimerVigilanceUSAVPDelay.Enabled := True;
        end;

        //------------------------------------------------------------------------------//
        //   Сообщение "Отключи тягу", при подъезде к запр. сигналу светофора (<150м.)  //
        //------------------------------------------------------------------------------//
        if (SvetoforDist < 150) and (Svetofor = 3) and (isOn150mOnSvetofor = 0) then
           isOn150mOnSvetofor := 1;

        if (SvetoforDist < 250) and (Svetofor = 3) and (isOn250mOnSvetofor = 0) then
           isOn250mOnSvetofor := 1;

        if ((SvetoforDist >= 150) and (isOn150mOnSvetofor = -1)) or (Svetofor <> 3) then
           isOn150mOnSvetofor := 0;

        if ((SvetoforDist >= 250) and (isOn250mOnSvetofor = -1) or (Svetofor <> 3)) then
           isOn250mOnSvetofor := 0;

        if (isOn150mOnSvetofor = 1) and (Speed > 0) then begin
           // ------- САУТ -------- //
           if cbSAUTSounds.Checked=True then begin
              SAUTF := PChar('TWS/SAVP/SAUT/tjaga_off.mp3');
              isPlaySAUTObjects:=False;
              PlayRESFlag := False;
           end;

           // ------- УСАВП ------- //
           if cbUSAVPSounds.Checked = True then
              DecodeResAndPlay('TWS/SAVP/USAVP/608.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);

           isOn150mOnSvetofor := -1;
        end;

        if (isOn250mOnSvetofor = 1) and (Speed > 0) then begin
           if cbUSAVPSounds.Checked = True then
              DecodeResAndPlay('TWS/SAVP/USAVP/584.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);

           isOn250mOnSvetofor := -1;
        end;

        if cbEPL2TBlock.Checked = True then begin
           if GetAsyncKeyState(17) = 0 then begin
              // --- NUM0 --- [ОСТОРОЖНО ДВЕРИ ЗАКРЫВАЮТСЯ] //
              if (GetAsyncKeyState(96) = 0) and (PrevKeyNum0 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Num0.res2', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM. --- [УСКОРИТЬ ПОСАДКУ ПАССАЖИРОВ] //
              if (GetAsyncKeyState(110) = 0) and (PrevKeyNumPoint <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Num_point.res2', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM1 --- [ПОЕЗД ПО СОСЕДНЕМУ ПУТИ] //
              if (GetAsyncKeyState(97) = 0) and (PrevKeyNum1 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Num1.res2', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM2 --- [ЗАПРЕЩАЕТСЯ В ЭЛЕКТРОПОЕЗДАХ] //
              if (GetAsyncKeyState(98) = 0) and (PrevKeyNum2 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Num2.res2', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM3 --- [ЖД - ОПАСНАЯ ЗОНА] //
              if (GetAsyncKeyState(99) = 0) and (PrevKeyNum3 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Num3.res2', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM7 --- [ТРЕБОВАНИЯ К ПАССАЖИРАМ] //
              if (GetAsyncKeyState(103) = 0) and (PrevKeyNum7 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Num7.res2', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM8 --- [САНИТАРНАЯ ЗОНА] //
              if (GetAsyncKeyState(104) = 0) and (PrevKeyNum8 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Num8.res2', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM9 --- [ПРО БИЛЕТЫ] //
              if (GetAsyncKeyState(105) = 0) and (PrevKeyNum9 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Num9.res2', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM4 --- //
              if (GetAsyncKeyState(100) = 0) and (PrevKeyNum4 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 Dec(InformIndx);
              end;
              // --- NUM6 --- //
              if (GetAsyncKeyState(102) = 0) and (PrevKeyNum6 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 Inc(InformIndx);
              end;
              // --- NUM5 --- //
              if (GetAsyncKeyState(101) = 0) and (PrevKeyNum5 <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 SAVPEInformatorMessages := ExtractWord(SAVPBaseInfoName1[InformIndx], ';');
                 SAVPEMessageIndex := 0;
                 DecodeResAndPlay('TWS/SOVI_INFORMATOR/Info/'+ComboBox3.Items[ComboBox3.ItemIndex]+'/'+SAVPEInformatorMessages[0],
                    isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                 Inc(InformIndx);
              end;
              // --- NUM* --- [ПРЕКРАТИТЬ ВОСПРОИЗВЕДЕНИЕ В САЛОН] //
              if (GetAsyncKeyState(106) = 0) and (PrevKeyNumZvezda <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 if BASS_ChannelIsActive(SAVPE_INFO_Channel) <> 0 then begin
                    BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                 end;
              end;

              If InformIndx < 0 then InformIndx := TotalInfoFiles - 1;
              If InformIndx + 1 > TotalInfoFiles then InformIndx := 0;
              lblSOVImessagesCounter.Caption := IntToStr(InformIndx) + '/' + IntToStr(TotalInfoFiles);
              PrevKeyNum0 := GetAsyncKeyState(96);
              PrevKeyNum1 := GetAsyncKeyState(97);
              PrevKeyNum2 := GetAsyncKeyState(98);
              PrevKeyNum3 := GetAsyncKeyState(99);
              PrevKeyNum4 := GetAsyncKeyState(100);
              PrevKeyNum5 := GetAsyncKeyState(101);
              PrevKeyNum6 := GetAsyncKeyState(102);
              PrevKeyNum7 := GetAsyncKeyState(103);
              PrevKeyNum8 := GetAsyncKeyState(104);
              PrevKeyNum9 := GetAsyncKeyState(105);
              PrevKeyNumZvezda := GetAsyncKeyState(106);
              PrevKeyNumPoint := GetAsyncKeyState(110);
           end;
        end;

        //------------------------------------------------------------------------------//
        //                  Речевой информатор САВПЕ на электропоездах                  //
        //------------------------------------------------------------------------------//
        if cbSAVPESounds.Checked = True then begin
           // --- СООБЩЕНИЕ О ОТКРЫТЫХ ДВЕРЯХ ПРИ НАЧАЛЕ ДВИЖЕНИЯ (ТОЛЬКО САВПЭ) ---
           if (LDOOR = 0) OR (RDOOR = 0) then begin
              if (Speed > 0) and (PrevSpeed_Fakt = 0) then
                 DecodeResAndPlay('TWS/SAVP/' + SAVPEFilePrefiks + '/doors.res',
                 isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
           end;
           // --- SHIFT + N --- //
           if (GetAsyncKeyState(16)+GetAsyncKeyState(78)=0) then
              PrevKeyEPKS:=0; // Обнуляем состояние клавиш "Shift" и "N"
           // ------ NUM1 ----- //
           if (GetAsyncKeyState(97) = 0) and (PrevKeyNum1 <> 0) and (GetAsyncKeyState(17)=0) then begin
              isPlaySAVPEPeek:=False;
              if SAVPEEnabled=False then begin
                 if Speed=0 then begin
                    BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                    SAVPEInformatorMessages.Clear;
                    SAVPEMessageIndex := 0;
                    DecodeResAndPlay('TWS/SAVPE_INFORMATOR/'+SAVPEFilePrefiks+'ob_b.res', isPlaySAVPEInfo,
                                     SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                 end;
                 Image2.Visible:=False; Image1.Visible:=True;
              end;
              if SAVPEEnabled=True then begin
                 Image2.Visible:=True; Image1.Visible:=False;
                 BASS_ChannelStop(SAVPE_Peek_Channel); BASS_StreamFree(SAVPE_Peek_Channel);
                 BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                 BASS_ChannelStop(SAVPE_ZVONOK); BASS_StreamFree(SAVPE_ZVONOK);
              end;
              SAVPEEnabled := Not(SAVPEEnabled);
           end;

           if SAVPEEnabled=True then begin
              if SAVPENextMessage = True then begin
                 try
                    if SAVPEMessageIndex < SAVPEInformatorMessages.Count - 1 then begin
                       Inc(SAVPEMessageIndex);
                       DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Info/'+FormMain.ComboBox1.Items[FormMain.ComboBox1.ItemIndex]+'/'+SAVPEInformatorMessages[SAVPEMessageIndex],
            	       	                isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                    end;
                 except end;
                 SAVPENextMessage := False;
              end;
           end;

           // --- NUM0 --- //
           if (GetAsyncKeyState(96) <> 0) and (PrevKeyNum0 = 0) and (GetAsyncKeyState(17)=0) then
              isPlaySAVPEZvonok:=False;

           if (GetAsyncKeyState(17)=0) and (SAVPEEnabled = True) then begin
              // --- NUM4 --- //
              if (ComboBox2.ItemIndex <> 0) and (GetAsyncKeyState(100) = 0) and (PrevKeyNum4 <> 0) and (RB_HandEKMode.Checked=True) then begin
                 isPlaySAVPEPeek:=False;
                 if AutoInformDoorFlag=False then begin
                    Dec(InformIndx); AutoInformDoorFlag:=True;
                 end else begin
                    AutoInformDoorFlag:=False;
                 end;
                 if InformIndx<0 then
                    InformIndx:=TotalInfoFiles-1;
              end;
              // --- NUM3 --- //
              if (GetAsyncKeyState(99) = 0) and (PrevKeyNum3 <> 0) and (Speed = 0) and (ComboBox2.ItemIndex <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                 SAVPEInformatorMessages.Clear;
                 SAVPEMessageIndex := 0;
                 if ThirdColumnAval = True then begin
                    if (InformIndx >= 0) AND (Trim(SAVPEBaseInfoName3[InformIndx]) <> '') then
                       SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName3[InformIndx], ';')
                 end else begin
                    SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName1[0], ';');
                 end;
                 if (SAVPEInformatorMessages.Count = 0) Or (Trim(SAVPEInformatorMessages[0]) = '') then
                    SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName1[0], ';');
                    DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Info/'+ComboBox1.Items[ComboBox1.ItemIndex]+'/'+SAVPEInformatorMessages[0],
                                     isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM5 --- //
              if (GetAsyncKeyState(101) = 0) and (PrevKeyNum5 <> 0) then begin
                 // --- РУЧНОЙ РЕЖИМ --- //
                 if ComboBox2.ItemIndex <> 0 then begin
                    isPlaySAVPEPeek:=False;
                    if RB_HandEKMode.Checked=True then begin
                       if AutoInformDoorFlag = False then begin
                          BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                          SAVPEMessageIndex := 0;
                          SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName1[InformIndx], ';');
                          DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Info/'+ComboBox1.Items[ComboBox1.ItemIndex]+'/'+SAVPEInformatorMessages[0],
                                           isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                          AutoInformDoorFlag:=True;
                       end else begin
                          BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                          SAVPEMessageIndex := 0;
                          SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName2[InformIndx], ';');
                          DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Info/'+ComboBox1.Items[ComboBox1.ItemIndex]+'/'+SAVPEInformatorMessages[0],
                                           isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                          AutoInformDoorFlag:=False;
                          Inc(InformIndx);
                       end;
                       if InformIndx+1>TotalInfoFiles then InformIndx:=0;
                    end else begin
                       // --- АВТОМАТИЧЕСКИЙ РЕЖИМ --- //
                       if timerDoorCloseDelay.Enabled=True then begin
                          if Speed=0 then timerDoorCloseDelay.Enabled := False;
                       end else begin
                          if InformIndx=0 then begin
                             BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                             if AutoInformDoorFlag = False then begin
                                SAVPEMessageIndex := 0;
                                //AutoInformDoorFlag := True;
                                SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName1[InformIndx], ';');
                             end else begin
                                SAVPEMessageIndex := 0;
                                //AutoInformDoorFlag := False;
                                SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName2[InformIndx], ';');
                                Inc(InformIndx);
                             end;
                             AutoInformDoorFlag := Not(AutoInformDoorFlag);
                             DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Info/'+ComboBox1.Items[ComboBox1.ItemIndex]+'/'+SAVPEInformatorMessages[0],
                                              isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                          end else begin
                             if AutoInformDoorFlag=True then begin
                                SAVPEMessageIndex := 0;
                                SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName2[InformIndx], ';');
                                DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Info/'+ComboBox1.Items[ComboBox1.ItemIndex]+'/'+SAVPEInformatorMessages[0],
                                                 isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                                Inc(InformIndx);
                                AutoInformDoorFlag:=False;
                             end;
                          end;
                       end;
                    end;
                 end;
              end;
              // --- NUM6 --- //
              if (GetAsyncKeyState(102) = 0) and (PrevKeyNum6 <> 0) and (RB_HandEKMode.Checked=True) and (ComboBox2.ItemIndex <> 0) then begin
                 isPlaySAVPEPeek:=False;
                 if InformIndx+1>TotalInfoFiles then InformIndx:=0;
                 if AutoInformDoorFlag=True then begin
                    Inc(InformIndx); AutoInformDoorFlag:=False;
                 end else begin
                    AutoInformDoorFlag:=True;
                 end;
              end;
              // -/- NUM7 -/- //
              if (GetAsyncKeyState(103) = 0) and (PrevKeyNum7 <> 0) and (RB_HandEKMode.Checked=True) then begin
                 if AutoInformIndx+1>TotalAutoInfoFiles then AutoInformIndx:=0;
                 BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                 isPlaySAVPEPeek:=False;
                 SAVPEInformatorMessages.Clear;
                 SAVPEMessageIndex := 0;
                 DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Informator/'+BaseAutoInfoName[AutoInformIndx],
                                  isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                 Inc(AutoInformIndx);
              end;
              // -/- NUM8 -/- //
              if (GetAsyncKeyState(104) = 0) and (PrevKeyNum8 <> 0) and (RB_HandEKMode.Checked = True) then begin
                 BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                 isPlaySAVPEPeek:=False;
                 BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                 SAVPEInformatorMessages.Clear;
                 SAVPEMessageIndex := 0;
                 DecodeResAndPlay('TWS/SAVPE_INFORMATOR/ob.wav', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
              // --- NUM9 --- //
              if (GetAsyncKeyState(105) = 0) and (PrevKeyNum9 <> 0) and (ComboBox2.ItemIndex=0) then begin
                 BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                 isPlaySAVPEPeek:=False;
                 BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                 SAVPEInformatorMessages.Clear;
                 SAVPEMessageIndex := 0;
                 DecodeResAndPlay('TWS/SAVPE_INFORMATOR/ob_kon.wav', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
              end;
           end;

           if RB_AutoEKMode.Checked=True then begin
              // Читаем и если нужно воспроизводим объявление станции по треку
              if Track<>PrevTrack then begin
                 for I:=0 to TotalInfoFiles do begin
                    if (SAVPEBaseInfoTrack[I]<>0) and (SAVPEBaseInfoTrack[I+1]<>0) then begin
                       if (SAVPEBaseInfoTrack[I]>=Track) and (SAVPEBaseInfoTrack[I+1]<=Track) and (Naprav='Tuda') then
                          InformIndx:=I;
                       if (SAVPEBaseInfoTrack[I]<=Track) and (SAVPEBaseInfoTrack[I+1]>=Track) and (Naprav='Obratno') then
                          InformIndx:=I;
                    end;
                    if SAVPEBaseInfoTrack[I]=Track then begin
                       BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                       SAVPEMessageIndex := 0;
                       SAVPEInformatorMessages := ExtractWord(SAVPEBaseInfoName1[I], ';');
                       DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Info/'+ComboBox1.Items[ComboBox1.ItemIndex]+'/'+SAVPEInformatorMessages[0],
                                         isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                       InformIndx:=I;
                       AutoInformDoorFlag := True;
                    end;
                 end;
                 // САВПЭ маркетинг, воспроизведение по карте
                 if cbSAVPE_Marketing.Checked=True then begin
                    for I:=0 to TotalAutoInfoFiles do begin
                       if BaseAutoInfoTrack[I]=Track then begin
                          BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                          SAVPEInformatorMessages.Clear;
                          SAVPEMessageIndex := 0;
                          BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                          DecodeResAndPlay('TWS/SAVPE_INFORMATOR/Informator/'+BaseAutoInfoName[I],
                                           isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                       end;
                    end;
                 end;
              end;

              // Воспроизводим служебные объявления из карты САВПЭ
              for I:=0 to TotalServiceFiles do begin
                 if BaseServiceInfoTrack[I]=Track then begin
                    BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                    SAVPEInformatorMessages.Clear;
                    SAVPEMessageIndex := 0;
                    if Pos('Zvon', BaseServiceInfoName[I])=0 then
                       BaseServiceInfoName[I] := StringReplace(BaseServiceInfoName[I], '.mp3', '.res', [rfReplaceAll]);
                    if Pos('.res', BaseServiceInfoName[I]) = 0 then begin
                       SAVPEInfoF:=PChar('TWS/SAVP/'+SAVPEFilePrefiks+'/'+BaseServiceInfoName[I]); isPlaySAVPEInfo:=False;
                    end else begin
                       DecodeResAndPlay('TWS/SAVP/'+SAVPEFilePrefiks+'/'+BaseServiceInfoName[I],
                                        isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                    end;
                 end;
              end;
              // Запуск таймера на воспроизведения объявления следующей остановки, при условии что скорость=0
              if (AutoInformDoorFlag=True) and (Speed<>PrevSpeed_Fakt) then begin
                 if Speed=0 then begin
                    if timerDoorCloseDelay.Enabled=False then begin
                       timerDoorCloseDelay.Interval := StrToInt(Edit1.Text)*1000;
                       timerDoorCloseDelay.Enabled := True;
                    end;
                 end;
                 if (Speed <= 4) and (PrevSpeed_Fakt > 4) and (InformIndx = TotalInfoFiles) and (isUPU = False) then begin
                    BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
                    SAVPEInformatorMessages.Clear;
                    SAVPEMessageIndex := 0;
                    DecodeResAndPlay('TWS/SAVPE_INFORMATOR/ob_pod_b.res', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
                 end;
              end;
           end;

           if AutoInformDoorFlag = False then
              Label46.Caption:=IntToStr(InformIndx*2+1)+' / '+IntToStr(TotalInfoFiles*2) else
              Label46.Caption:=IntToStr(InformIndx*2+2)+' / '+IntToStr(TotalInfoFiles*2);

           PrevKeyNum0 := GetAsyncKeyState(96);
           PrevKeyNum1 := GetAsyncKeyState(97);
           PrevKeyNum3 := GetAsyncKeyState(99);
           PrevKeyNum4 := GetAsyncKeyState(100);
           PrevKeyNum5 := GetAsyncKeyState(101);
           PrevKeyNum6 := GetAsyncKeyState(102);
           PrevKeyNum7 := GetAsyncKeyState(103);
           PrevKeyNum8 := GetAsyncKeyState(104);
           PrevKeyNum9 := GetAsyncKeyState(105);
        end;
     end;
end;

//------------------------------------------------------------------------------//
//                     Подпрограмма для "прохода" цикла САВП                    //
//------------------------------------------------------------------------------//
procedure SAVPTick();
begin
     if SAVPName<>'' then
        SAVPCycle;
     if FormMain.cbNatureSounds.Checked = True then begin
        PereezdCycle;
        NatureCycle;
     end else begin
        if BASS_ChannelIsActive(SAUTChannelZvonok) <> 0 then begin
           BASS_ChannelStop(SAUTChannelZvonok); BASS_StreamFree(SAUTChannelZvonok);
        end;
        if BASS_ChannelIsActive(NatureChannel_FX) <> 0 then begin
        BASS_ChannelStop(NatureChannel); BASS_StreamFree(NatureChannel);
           BASS_ChannelStop(NatureChannel_FX); BASS_StreamFree(NatureChannel_FX);
        end;
     end;
end;

//------------------------------------------------------------------------------//
//                   Подпрограмма для загрузки ЭК TWS формата                   //
//------------------------------------------------------------------------------//
procedure Load_TWS_SAVP_EK();
begin
     if (FormMain.cbEPL2TBlock.Checked = False)
        and (SAVPName <> '') then begin
        if naprav = 'Tuda' then begin
           try
              if FileExists('routes/' + Route + '/EK_1.TWS') then
                 GetSAVPObjectsBaseFromFile('routes/' + Route + '/EK_1.TWS', True)
              else
                 GetSAVPObjectsBaseFromFile('routes/' + Route + '/Info_Obj_Tuda.txt', False);
           except end;
        end else begin
           try
              if FileExists('routes/' + Route + '/EK_2.TWS') then
                 GetSAVPObjectsBaseFromFile('routes/' + Route + '/EK_2.TWS', True)
              else
                 GetSAVPObjectsBaseFromFile('routes/' + Route + '/Info_Obj_Obratno.txt', False);
           except end;
        end;
     end;
     try
        if naprav = 'Tuda' then
           GetSAVPPereezdOrdinats('routes/' + Route + '/Info_Obj_Tuda.txt')
        else
           GetSAVPPereezdOrdinats('routes/' + Route + '/Info_Obj_Obratno.txt');
     except end;
     try
        if naprav = 'Tuda' then
           GetSAVPNatureObjectsOrdinats('routes/' + Route + '/Info_Obj_Tuda.txt')
        else
           GetSAVPNatureObjectsOrdinats('routes/' + Route + '/Info_Obj_Obratno.txt');
     except end;
end;

end.
