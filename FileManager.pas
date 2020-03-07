//------------------------------------------------------------------------------//
//                                                                              //
//      Модуль для работы с файлами                                             //
//      (c) DimaGVRH, Dnepr city, 2019                                          //
//                                                                              //
//------------------------------------------------------------------------------//
unit FileManager;

interface

   procedure LoadTWSParams(FileName: String);
   procedure SaveTWSParams(FileName: String);

implementation

uses UnitMain, inifiles, SysUtils, UnitSettings;

//------------------------------------------------------------------------------//
//                Подпрограмма для загрузки настроек TWS из файла               //
//------------------------------------------------------------------------------//
procedure LoadTWSParams(FileName: String);
var
     Temp: Integer;
begin
     With FormMain do begin
     Ini:=TiniFile.Create(FileName);
     trcBarLocoPerestukVol.Position:=StrToInt(Ini.ReadString('settings', 'loco_volume', '80'));
     trcBarWagsVol.Position:=StrToint(Ini.ReadString('settings', 'pass_volume', '40'));
     trcBarPRSVol.Position:=StrToint(Ini.ReadString('settings', 'prs_volume', '100'));
     trcBarSAVPVol.Position:=StrToint(Ini.ReadString('settings', 'saut_volume', '100'));
     trcBarTedsVol.Position:=StrToint(Ini.ReadString('settings', 'ted_volume', '100'));
     trcBarLocoClicksVol.Position:=StrToint(Ini.ReadString('settings', 'stuk_volume', '100'));
     trcBarNatureVol.Position:=StrToint(Ini.ReadString('settings', 'nature_volume', '100'));
     trcBarVspomMahVol.Position:=StrToint(Ini.ReadString('settings', 'vspom_volume', '100'));
     trcBarDieselVol.Position:=StrToint(Ini.ReadString('settings', 'dizel_volume', '100'));
     trcBarSignalsVol.Position:=StrToint(Ini.ReadString('settings', 'signals_volume', '100'));
     VersionID:=StrToInt(Ini.ReadString('settings', 'version_id', '0'));
     Temp:=StrToInt(Ini.ReadString('settings', 'CB1', '1'));
     if Temp=1 then cbLocPerestuk.Checked:=True else cbLocPerestuk.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB2', '1'));
     if Temp=1 then begin cbWagPerestuk.Checked:=True; Panel1.Enabled:=True; end;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB3', '1'));
     if Temp=1 then cbSAUTSounds.Checked:=True else cbSAUTSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB4', '1'));
     if Temp=1 then cbUSAVPSounds.Checked:=True else cbUSAVPSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB5', '1'));
     if Temp=1 then cbGSAUTSounds.Checked:=True else cbGSAUTSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB6', '1'));
     if Temp=1 then cbPRS_RZD.Checked:=True else cbPRS_RZD.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB7', '1'));
     if Temp=1 then cbPRS_UZ.Checked:=True else cbPRS_UZ.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB8', '1'));
     if Temp=1 then cbTEDs.Checked:=True else cbTEDs.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB9', '1'));
     if Temp=1 then cbHeadTrainSound.Checked:=True else cbHeadTrainSound.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB10', '1'));
     if Temp=1 then cbCabinClicks.Checked:=True else cbCabinClicks.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB11', '1'));
     if Temp=1 then cbKLUBSounds.Checked:=True else cbKLUBSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB12', '1'));
     if Temp=1 then cb3SL2mSounds.Checked:=True else cb3SL2mSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB13', '1'));
     if Temp=1 then cbTPSounds.Checked:=True else cbTPSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB14', '1'));
     if Temp=1 then cbNatureSounds.Checked:=True else cbNatureSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB15', '1'));
     if Temp=1 then cbSignalsSounds.Checked:=True else cbSignalsSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB16', '1'));
     if Temp=1 then cbVspomMash.Checked:=True else cbVspomMash.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB17', '1'));
     if Temp=1 then cbBrakingSounds.Checked:=True else cbBrakingSounds.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB18', '1'));
     if Temp=1 then cbSAVPESounds.Checked:=True;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB19', '0'));
     if Temp=1 then FormSettings.CheckBox1.Checked:=True;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB20', '0'));
     if Temp=1 then cbSAVPE_Marketing.Checked:=True;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB21', '0'));
     if Temp=1 then cbExtIntSounds.Checked:=True;
     Temp:=StrToInt(Ini.ReadString('settings', 'CB22', '0'));
     if Temp=1 then cbEPL2TBlock.Checked:=True;
     Temp:=StrToInt(Ini.ReadString('settings', 'RB1', '1'));
     if Temp=1 then begin RadioButton1.Checked:=True; end else RadioButton1.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'RB2', '1'));
     if Temp=1 then begin RadioButton2.Checked:=True; end else RadioButton2.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'RB3', '1'));
     if Temp=1 then begin RB_HandEKMode.Checked:=True; end else RB_HandEKMode.Checked:=False;
     Temp:=StrToInt(Ini.ReadString('settings', 'RB4', '0'));
     if Temp=1 then begin RB_AutoEKMode.Checked:=True; end else RB_AutoEKMode.Checked:=False;
     Edit1.Text:=Ini.ReadString('settings', 'TimerSAVPEDoorDelay', '7');
     Timer1.Interval:=StrToInt(Ini.ReadString('settings', 'Timer1FREQ', '20'));
     Timer4.Interval:=StrToInt(Ini.ReadString('settings', 'TimerRefresherFREQ', '500'));
     Ini.Free();
     end;
end;

//------------------------------------------------------------------------------//
//                Подпрограмма для сохранения настроек TWS в файл               //
//------------------------------------------------------------------------------//
procedure SaveTWSParams(FileName: String);
var
     Temp: Integer;
begin
     With FormMain do begin
     Ini:=TiniFile.Create(FileName);
     Ini.WriteString('settings', 'loco_volume', IntToStr(trcBarLocoPerestukVol.Position));
     Ini.WriteString('settings', 'pass_volume', IntToStr(trcBarWagsVol.Position));
     Ini.WriteString('settings', 'prs_volume', IntToStr(trcBarPRSVol.Position));
     Ini.WriteString('settings', 'saut_volume', IntToStr(trcBarSAVPVol.Position));
     Ini.WriteString('settings', 'ted_volume', IntToStr(trcBarTedsVol.Position));
     Ini.WriteString('settings', 'stuk_volume', IntToStr(trcBarLocoClicksVol.Position));
     Ini.WriteString('settings', 'nature_volume', IntToStr(trcBarNatureVol.Position));
     Ini.WriteString('settings', 'vspom_volume', IntToStr(trcBarVspomMahVol.Position));
     Ini.WriteString('settings', 'dizel_volume', IntToStr(trcBarDieselVol.Position));
     Ini.WriteString('settings', 'signals_volume', IntToStr(trcBarSignalsVol.Position));
     Ini.WriteString('settings', 'version_id', IntToStr(VersionID));
     if cbLocPerestuk.Checked=True then Temp:=1 else Temp:=0;      // Записываем состояние перестука локомотива
     Ini.WriteString('settings', 'CB1', IntToStr(Temp));
     if cbWagPerestuk.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB2', IntToStr(Temp));       // Записываем состояние перестука вагонов
     if cbSAUTSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB3', IntToStr(Temp));       // Записываем состояние САУТ
     if cbUSAVPSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB4', IntToStr(Temp));       // Записываем состояние УСАВП
     if cbGSAUTSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB5', IntToStr(Temp));       // Записываем состояние Грузового САУТ
     if cbPRS_RZD.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB6', IntToStr(Temp));       // Записываем состояние ПРС РЖД
     if cbPRS_UZ.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB7', IntToStr(Temp));       // Записываем состояние ПРС УЗ
     if cbTEDs.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB8', IntToStr(Temp));       // Записываем состояние звуков ТЭД-ов
     if cbHeadTrainSound.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB9', IntToStr(Temp)); 	    // Записываем состояние звуков встречного поезда
     if cbCabinClicks.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB10', IntToStr(Temp));      // Записываем состояние звуков щелчка КМ на ЧС-ах
     if cbKLUBSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB11', IntToStr(Temp));
     if cb3SL2mSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB12', IntToStr(Temp));
     if cbTPSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB13', IntToStr(Temp));
     if cbNatureSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB14', IntToStr(Temp));
     if cbSignalsSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB15', IntToStr(Temp));
     if cbVspomMash.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB16', IntToStr(Temp));
     if cbBrakingSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB17', IntToStr(Temp));
     if cbSAVPESounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB18', IntToStr(Temp));
     if FormSettings.CheckBox1.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB19', IntToStr(Temp));
     if cbSAVPE_Marketing.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB20', IntToStr(Temp));
     if cbExtIntSounds.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB21', IntToStr(Temp));
     if cbEPL2TBlock.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'CB22', IntToStr(Temp));
     if RadioButton1.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'RB1', IntToStr(Temp));
     if RadioButton2.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'RB2', IntToStr(Temp));
     if RB_HandEKMode.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'RB3', IntToStr(Temp));
     if RB_AutoEKMode.Checked=True then Temp:=1 else Temp:=0;
     Ini.WriteString('settings', 'RB4', IntToStr(Temp));
     Ini.WriteString('settings', 'TimerSAVPEDoorDelay', Edit1.Text);
     Ini.WriteString('settings', 'Timer1FREQ', IntToStr(Timer1.Interval));
     Ini.WriteString('settings', 'TimerRefresherFREQ', IntToStr(Timer4.Interval));
     Ini.Free();
     end;
end;

end.
