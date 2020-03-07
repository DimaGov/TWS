//------------------------------------------------------------------------------//
//                                                                              //
//      Модуль для работы с ОЗУ                                                 //
//      (c) DimaGVRH, Dnepr city, 2019                                          //
//                                                                              //
//------------------------------------------------------------------------------//
unit RAMMemModule;

interface

   procedure GetStartSettingParamsFromRAM();
   procedure InitializeStartParams(VersionID: Integer);
   function ReadKeyFromMemoryString(readAddr: PByte; Key: String; SearchRadius: Integer) : String;
   function ReadStringFromMemory(readAddr: PByte; Len: Byte) : String;
   procedure ReadVarsFromRAM();
   procedure ReadDataMemory2TE10U();
   procedure ReadDataMemoryM62();
   procedure ReadDataMemoryTEP70();
   procedure ReadDataMemoryTEP70BS();
   procedure ReadDataMemoryTEM18dm();
   procedure ReadDataMemoryVL11m();
   procedure ReadDataMemoryVL80t();
   procedure ReadDataMemoryVL82m();
   procedure ReadDataMemoryVL85();
   procedure ReadDataMemoryCHS2k();
   procedure ReadDataMemoryCHS4();
   procedure ReadDataMemoryCHS4t();
   procedure ReadDataMemoryCHS4kvr();
   procedure ReadDataMemoryCHS7();
   procedure ReadDataMemoryCHS8();
   procedure ReadDataMemoryEP1m();
   procedure ReadDataMemory2ES5k();
   procedure ReadDataMemoryED4M();
   procedure ReadDataMemoryED9M();
var
   ADDR_ZDS_EXE_LABEL:                      PByte;

implementation

uses UnitMain, Windows, SysUtils, SoundManager, Math, UnitSettings;

var
   ProcReadDataMemoryAddr: ProcReadDataMemoryType;

   ADDR_Speed, ADDR_Svetofor:  		    Pointer;
   ADDR_Track, ADDR_KLUB_OPEN:    	    Pointer;
   ADDR_TRACK_TAIL:                         Pointer;
   ADDR_COUPLE_STATUS:                      Pointer;
   ADDR_RB, ADDR_RBS:                       Pointer;
   ADDR_KM_POS, ADDR_OP_POS, ADDR_REVERSOR: Pointer;
   ADDR_KM_POS_2:                           Pointer;
   ADDR_395, ADDR_254, ADDR_ACCLRT:    	    Pointer;
   ADDR_VSTR_TRACK, ADDR_VSTR_NW:           Pointer;
   ADDR_SVETOFOR_DISTANCE:                  Pointer;
   ADDR_TP_ED4M, ADDR_TP_ED9M:              Pointer;
   ADDR_BV_ED4M, ADDR_BV_ED9M:              Pointer;
   ADDR_KME_ED4M, ADDR_KME_ED9M:            Pointer;
   ADDR_VIGILANCE_CHECK:                    Pointer; // Адрес состояния проверки бдительности (нужно для КЛУБ-а)
   ADDR_SPEED_VSTRECHA:                     Pointer; // Адрес скорости встречки в МП
   ADDR_VSTRECH_STATUS:                     Pointer;
   ADDR_OGRANICH:                           Pointer;
   ADDR_NEXT_OGRANICH:                      Pointer;
   ADDR_CAMERA:                             Pointer;
   ADDR_CAMERA_X:                           Pointer; // Адрес значения положения головы по оси Х в кабине машиниста
   ADDR_AMPERAGE1:                          Pointer; // Адрес значения ТЭД ток 1
   ADDR_AMPERAGE2:                          Pointer; // Адрес значения ТЭД ток 2
   ADDR_AMPERAGE3:                          Pointer; // Адрес значения ТЭД ток 3
   ADDR_AMPERAGE4:                          Pointer; // Адрес значения ТЭД ток 4
   ADDR_BOKSOVANIE:                         Pointer;
   ADDR_AB_ZB_1:                            Pointer;
   ADDR_AB_ZB_2:                            Pointer;
   ADDR_RAIN:                               Pointer;
   ADDR_STOCHIST:                           Pointer; // Адрес состояния дворников
   ADDR_STCHSTDGR:                          Pointer; // Адрес для угла поворота дворников
   ADDR_CHS7_COMPRESSOR:                    Pointer; // Адрес состояния компрессоров на ЧС7
   ADDR_CHS7_VENT:                          Pointer; // Адрес состояния вентиляторов на ЧС7 (Тумблер, положение)
   ADDR_CHS7_VOLTAGE:                       Pointer; // Адрес напряжения на ЧС7
   ADDR_CHS7_BV:                            Pointer; // Адрес состояния БВ на ЧС7
   ADDR_CHS7_REVERSOR:                      Pointer;
   ADDR_CHS7_FTP:                           Pointer;
   ADDR_CHS7_BTP:                           Pointer;
   ADDR_CHS7_ZHALUZI:                       Pointer;
   ADDR_CHS8_FTP:                           Pointer;
   ADDR_CHS8_BTP:                           Pointer;
   ADDR_CHS8_REOSTAT:                       Pointer;
   ADDR_CHS8_VENT_VOLUME:                   Pointer;
   ADDR_CHS8_VENT_VOLUME_INCREMENTER:       Pointer;
   ADDR_CHS8_COMPRESSOR:                    Pointer; // Адрес состояния компрессоров на ЧС8
   ADDR_CHS8_GV_1:                          Pointer;
   ADDR_CHS8_GV_2:                          Pointer;
   ADDR_CHS4T_VENT:                         Pointer; // Адрес состояния вентиляторов на ЧС4т
   ADDR_CHS4T_COMPRESSOR:                   Pointer;
   ADDR_CHS4T_FTP:                          Pointer;
   ADDR_CHS4T_BTP:                          Pointer;
   ADDR_CHS4KVR_FTP:                        Pointer;
   ADDR_CHS4KVR_BTP:                        Pointer;
   ADDR_CHS4KVR_REVERSOR:                   Pointer;
   ADDR_CHS2K_COMPRESSOR:                   Pointer;
   ADDR_CHS2K_BV:                           Pointer;
   ADDR_CHS2K_VENT:                         Pointer;
   ADDR_CHS2K_FTP:                          Pointer;
   ADDR_CHS2K_BTP:                          Pointer;
   ADDR_EP1M_COMPRESSOR:                    Pointer;
   ADDR_EP1M_FTP:                           Pointer;
   ADDR_EP1M_BTP:                           Pointer;
   ADDR_KVR_VENTS:                          Pointer;
   ADDR_ED4M_COMPRESSOR:                    Pointer;
   ADDR_ED4M_REVERSOR:                      Pointer;
   ADDR_HIGHLIGHTS:                         Pointer;
   ADDR_ED9M_COMPRESSOR:                    Pointer;
   ADDR_ED9M_REVERS:                        Pointer;
   ADDR_EDT_AMPERAGE:                       Pointer; // Адрес значения тока ЭДТ (ЧС8)
   ADDR_NM:                                 Pointer; // Адрес значения показания Напорной Магистрали
   ADDR_BRAKE_CYLINDERS:                    Pointer; // Адрес значения давления в Тормозных Цилиндрах
   ADDR_2TE10U_DIESEL1:                     Pointer; // Адрес состояния дизеля на 2ТЭ10У
   ADDR_2TE10U_DIESEL2:                     Pointer; // Адрес состояния дизеля на 2ТЭ10У
   ADDR_TEP70_RPM:                          Pointer; // Адрес числа оборотов в минуту дизеля на ТЭП70
   ADDR_TEP70BS_RPM:                        Pointer;
   ADDR_TEP70BS_KMPOS:                      Pointer;
   ADDR_M62_RPM_1:                          Pointer; // Адрес числа оборотов в минуту для дизеля на М62
   ADDR_M62_RPM_2:                          Pointer; // Адрес числа оборотов в минуту для дизеля на М62
   ADDR_M62_KMPOS_1:                        Pointer;
   ADDR_M62_KMPOS_2:                        Pointer;
   ADDR_EPT:                                Pointer;
   ADDR_VL11M_FTP, ADDR_VL11M_BTP:          Pointer;
   ADDR_VL11M_COMPRESSOR:                   Pointer;
   ADDR_VL80TVent1:                         Pointer;
   ADDR_VL80TVent2:                         Pointer;
   ADDR_VL80TVent3:                         Pointer;
   ADDR_VL80TVent4:                         Pointer;
   ADDR_VL80TComp:                          Pointer;
   ADDR_VL80TFazan:                         Pointer;
   ADDR_VL82_COMPRESSOR:                    Pointer;
   ADDR_VL85_FTP, ADDR_VL85_BTP:            Pointer;
   ADDR_2ES5K_FTP, ADDR_2ES5K_BTP:          Pointer;
   ADDR_LDOORED4M:                          Pointer;
   ADDR_RDOORED4M:                          Pointer;
   ADDR_SVISTOK:                            Pointer;
   ADDR_TIFON:                              Pointer;
   ADDR_VSTRECHA_WAGON_DLINA:               PDouble;
   ADDR_VSTRECHA_WAG_ORDINATA:	            PDouble;
   ADDR_SETTINGS_INI_POINTER:               Pointer;
   ADDR_ED4M_KONTROLLER:                    Pointer;
   ADDR_ED9M_KONTROLLER:                    Pointer;
   ADDR_VL11m_VENT:                         Pointer;
   ADDR_ORDINATA:                           Pointer;
   ADDR_OUTSIDE_LOCO_STATUS:                Pointer;
   ADDR_2ES5K_BV:                           Pointer;
   ADDR_CHS8_UNIPULS_AVARIA:                Pointer;

   CHS8VentVolumePrev:                      Single;
   CHS8VentTempCounter:                     Byte;

//------------------------------------------------------------------------------//
//            Подпрограмма для чтения указателя по указанному адресу            //
//------------------------------------------------------------------------------//
function ReadPointer(Addr: Pointer): PByte;
var
    tempAddr: PByte;
    b: Byte;
    i: Integer;
    str: String;
begin
    tempAddr := Addr;
    Inc(tempAddr, 3);
    for i:=4 downto 1 do begin
       ReadProcessMemory(UnitMain.pHandle, tempAddr, @b, 1, temp);
       str := str + IntToHex(b, 2);
       Dec(tempAddr);
    end;
    Result := ptr(StrToInt('$'+str));
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
//          Подпрограмма для чтения из ОЗУ строки до указанного символа         //
//------------------------------------------------------------------------------//
function ReadKeyFromMemoryString(readAddr: PByte; Key: String; SearchRadius: Integer) : String;
var
   strKey: String;
   retStr, str: String;
   readByte: Byte;
   keyFound, firstDataByte: Boolean;
   i: Integer;
begin
   KeyFound := False; firstDataByte := False;
   i := 0;
   while True do begin
      if i > SearchRadius then Break;

      ReadProcessMemory(UnitMain.pHandle, readAddr, @readByte, 1, temp);

      if readByte <> 0 then begin
         SetString(str, PChar(@readByte), 1);
         if firstDataByte = False then
            strKey := strKey + str
         else
            firstDataByte := False;
      end else begin
         if strKey <> '' then begin
            if KeyFound = False then begin
               if Pos(Key, strKey) <> 0 then begin
                  keyFound := True; firstDataByte := True; strKey := '';
               end else begin
                  strKey := '';
               end;
            end else begin
               retStr := strKey; Break;
            end;
         end;
      end;

      Inc(readAddr); Inc(i);
   end;
   Result := retStr;
end;

//------------------------------------------------------------------------------//
//  Подпрограмма для чтения стартовых параметров из виртуального 'settings.ini' //
//------------------------------------------------------------------------------//
procedure GetStartSettingParamsFromRAM();
var
    addr_settings_ini: PByte;
begin
     With FormMain do begin
        // Получаем адрес процесса ZDSimulator
        UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
        UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

        addr_settings_ini := ReadPointer(ADDR_SETTINGS_INI_POINTER);

        WagsNum := StrToInt(ReadKeyFromMemoryString(addr_settings_ini, 'WagonsAmount', 6666));
        LocoGlobal := ReadKeyFromMemoryString(addr_settings_ini, 'LocomotiveType',6666);
        naprav:= ReadKeyFromMemoryString(addr_settings_ini, 'Route', 6666);
        try Route := ReadKeyFromMemoryString(addr_settings_ini, 'RoutePath', 6666); except Route:='error'; end;
        try LocoNum := StrToInt(ReadKeyFromMemoryString(addr_settings_ini, 'LocNum', 6666)); except LocoNum:=-1; end;
        MP := StrToInt(ReadKeyFromMemoryString(addr_settings_ini, 'MultiPlayer', 6666));
        try ConName := ReadKeyFromMemoryString(addr_settings_ini, 'WagsName', 6666); except ConName:='error'; end;
        Winter := StrToInt(ReadKeyFromMemoryString(addr_settings_ini, 'Winter', 6666));
        Freight := StrToInt(ReadKeyFromMemoryString(addr_settings_ini, 'Freight', 6666));
        try SceneryName:=ReadKeyFromMemoryString(addr_settings_ini, 'SceneryName', 6666); except SceneryName:='error'; end;

        try CloseHandle(UnitMain.pHandle); except end;
     end;
end;

//------------------------------------------------------------------------------//
//        Подпрограмма для чтения локальных переменных локомотива 2ТЭ10у        //
//------------------------------------------------------------------------------//
procedure ReadDataMemory2TE10U();
var
    wDisel:    Single;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_2TE10U_DIESEL1, @wDisel, 4, temp); BV:=Trunc(wDisel);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_2TE10U_DIESEL2, @diesel2, 4, temp);  except end;
end;

//------------------------------------------------------------------------------//
//         Подпрограмма для чтения локальных переменных локомотива М62          //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryM62();
var
    wDisel:    Single;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_M62_RPM_1, @wDisel, 4, temp); if wDisel<400 then BV:=0 else BV:=1;  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_M62_RPM_2, @diesel2, 4, temp); if diesel2<400 then diesel2:=0 else diesel2:=1;  except end;
    if VersionID<1 then begin
       try ReadProcessMemory(UnitMain.pHandle, ADDR_M62_KMPOS_1, @KM_POS_1, 2, temp); except end;
       try ReadProcessMemory(UnitMain.pHandle, ADDR_M62_KMPOS_2, @KM_POS_2, 2, temp); except end;
    end;
end;

//------------------------------------------------------------------------------//
//        Подпрограмма для чтения локальных переменных локомотива ТЭП70         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryTEP70();
var
    wDisel:    Single;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_TEP70_RPM, @wDisel, 4, temp); if wDisel<350 then BV:=0 else BV:=1;  except end;
end;

//------------------------------------------------------------------------------//
//       Подпрограмма для чтения локальных переменных локомотива ТЭП70бс        //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryTEP70BS();
var
TempKM: Byte;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_TEP70BS_RPM, @BV, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_TEP70BS_KMPOS, @TempKM, 1, temp); KM_Pos_1:=TempKM; except end;
end;

//------------------------------------------------------------------------------//
//       Подпрограмма для чтения локальных переменных локомотива ТЭМ18дм        //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryTEM18dm();
begin
    ;
end;

//------------------------------------------------------------------------------//
//        Подпрограмма для чтения локальных переменных локомотива ВЛ11м         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryVL11m();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL11M_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL11M_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL11M_COMPRESSOR, @Compressor, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL11m_VENT, @Vent, 1, temp);  except end;
end;

//------------------------------------------------------------------------------//
//        Подпрограмма для чтения локальных переменных локомотива ВЛ80т         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryVL80t();
var
    wDisel:    Single;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_REOSTAT, @Reostat, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL80TVent1, @wDisel, 4, temp); Vent:=Trunc(wDisel); except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL80TVent2, @Vent2, 4, temp); Vent2:=Trunc(Vent2); except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL80TVent3, @Vent3, 4, temp); Vent3:=Trunc(Vent3); except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL80TVent4, @Vent4, 4, temp); Vent4:=Trunc(Vent4); except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL80TComp,  @Compressor, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL80TFazan, @Fazan, 1, temp);  except end;
end;

//------------------------------------------------------------------------------//
//        Подпрограмма для чтения локальных переменных локомотива ВЛ82м         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryVL82m();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_REOSTAT, @Reostat, 1, temp);  except end;
end;

//------------------------------------------------------------------------------//
//         Подпрограмма для чтения локальных переменных локомотива ВЛ85         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryVL85();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL85_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_VL85_BTP, @BackTP, 1, temp);  except end;
end;

//------------------------------------------------------------------------------//
//         Подпрограмма для чтения локальных переменных локомотива ЧС2к         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryCHS2k();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS2K_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS2K_COMPRESSOR, @Compressor, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS2K_VENT, @Vent, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS2K_BV, @BV, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS2K_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_VOLTAGE, @Voltage, 4, temp);  except end;
    if ((BV=0) Or (Voltage<1.5)) and (Vent<>0) then Vent := 0 else Vent := Vent;
end;

//------------------------------------------------------------------------------//
//          Подпрограмма для чтения локальных переменных локомотива ЧС4         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryCHS4();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4T_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4T_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ptr($0536FA2F), @ReversorPos, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4T_VENT, @Vent, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4T_COMPRESSOR, @Compressor, 4, temp);  except end;
end;

//------------------------------------------------------------------------------//
//          Подпрограмма для чтения локальных переменных локомотива ЧС4т        //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryCHS4t();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4T_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4T_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ptr($0536FA2F), @ReversorPos, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4T_VENT, @Vent, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4T_COMPRESSOR, @Compressor, 4, temp);  except end;
end;

//------------------------------------------------------------------------------//
//         Подпрограмма для чтения локальных переменных локомотива ЧС4квр       //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryCHS4kvr();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4KVR_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4KVR_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS4KVR_REVERSOR, @ReversorPos, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_KVR_VENTS, @Vent, 4, temp); except end;
end;

//------------------------------------------------------------------------------//
//          Подпрограмма для чтения локальных переменных локомотива ЧС7         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryCHS7();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_FTP, @FrontTP, 1, temp);  except end; 	    // Передний ТП
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_BTP, @BackTP, 1, temp);  except end;              // Задний ТП
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_REVERSOR, @ReversorPos, 1, temp);  except end;         // Реверсор
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_COMPRESSOR, @Compressor, 4, temp);  except end;    // Компрессор
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_VOLTAGE, @Voltage, 4, temp);  except end;          // Напряжение на эл-возе
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_BV, @BV, 1, temp);  except end;		    // БВ
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_VENT, @Vent, 1, temp);  except end;                // Вентилятор (положение тумблера)
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_ZHALUZI, @Zhaluzi, 1, temp); except end;       // Жалюзи
    if ((BV=0) Or (Voltage<1.5)) and (Vent<>0) then Vent := 0 else Vent := Vent;
end;

//------------------------------------------------------------------------------//
//          Подпрограмма для чтения локальных переменных локомотива ЧС8         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryCHS8();
var
    VentSingleVolumeIncrementerTemp: Single;
    VentUnipulsAvaria: Byte;
    BV_temp: double;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_REOSTAT, @Reostat, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_VOLTAGE, @Voltage, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_COMPRESSOR, @Compressor, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_VENT_VOLUME, @VentSingleVolume, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_VENT_VOLUME_INCREMENTER, @VentSingleVolumeIncrementerTemp, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_UNIPULS_AVARIA, @VentUnipulsAvaria, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS8_GV_1, @BV_temp, 8, temp);  except end;

    if (BV_temp > 0) then BV := Trunc(BV_temp) else BV := 0;
    VentSingleVolumeIncrementer := RoundTo(VentSingleVolumeIncrementerTemp, -2) * 100;

    if ((Trunc(VentSingleVolumeIncrementer) = 33) and (VentSingleVolume > 0.1) and (VentSingleVolume < 0.34))
       and ((CHS8VentVolumePrev < VentSingleVolume) Or (CHS8VentTempCounter > 30))
       then Vent := 2;
    if ((Trunc(VentSingleVolumeIncrementer) = 33) and (VentSingleVolume > 0.34) and (VentSingleVolume < 0.68))
       and ((CHS8VentVolumePrev < VentSingleVolume) Or (CHS8VentTempCounter > 30))
       then Vent := 3;
    if ((Trunc(VentSingleVolumeIncrementer) = 33) and (VentSingleVolume > 0.68) and (VentSingleVolume <= 1))
       and ((CHS8VentVolumePrev < VentSingleVolume) Or (CHS8VentTempCounter > 30))
       then Vent := 4;

    if ((Trunc(VentSingleVolumeIncrementer) = 33) and (VentSingleVolume > 0) and (VentSingleVolume < 0.32))
       and ((CHS8VentVolumePrev > VentSingleVolume) Or (CHS8VentTempCounter > 30)) then Vent := 0;
    if ((Trunc(VentSingleVolumeIncrementer) = 33) and (VentSingleVolume > 0.34) and (VentSingleVolume < 0.66))
       and ((CHS8VentVolumePrev > VentSingleVolume) Or (CHS8VentTempCounter > 30)) then Vent := 2;
    if ((Trunc(VentSingleVolumeIncrementer) = 33) and (VentSingleVolume > 0.68) and (VentSingleVolume < 0.95))
       and ((CHS8VentVolumePrev > VentSingleVolume) Or (CHS8VentTempCounter > 30)) then Vent := 3;

    if ((VentSingleVolumeIncrementer < 33) and (VentSingleVolumeIncrementer > 0)) Or (EDTAmperage > 0) then Vent := 1;
    //if (VentSingleVolumeIncrementer = 0) and (VentSingleVolume = 1) and (KM_Pos_1 = 0) then Vent := 5;
    if (VentUnipulsAvaria = 0) then Vent := 5;
    if ((VentSingleVolumeIncrementer = 33) and (VentSingleVolume < 0.1)) Or (Voltage < 15)
       Or (((TEDAmperage=0)And(EDTAmperage=0))And(Vent=1)) then Vent := 0;

    if (CHS8VentVolumePrev = VentSingleVolume) and (CHS8VentTempCounter < 100) then Inc(CHS8VentTempCounter) else CHS8VentTempCounter := 0;
    CHS8VentVolumePrev := VentSingleVolume;
end;

//------------------------------------------------------------------------------//
//         Подпрограмма для чтения локальных переменных локомотива ЭП1м         //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryEP1m();
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_EP1M_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_EP1M_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_EP1M_COMPRESSOR, @Compressor, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_VOLTAGE, @Voltage, 4, temp);  except end;
end;

//------------------------------------------------------------------------------//
//         Подпрограмма для чтения локальных переменных локомотива 2ЭС5к        //
//------------------------------------------------------------------------------//
procedure ReadDataMemory2ES5k();
var
    SingleTemp: Single;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_2ES5K_FTP, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_2ES5K_BTP, @BackTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_EP1M_COMPRESSOR, @Compressor, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_CHS7_VOLTAGE, @Voltage, 4, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_2ES5K_BV, @SingleTemp, 4, temp);  except end;
    BV := Trunc(SingleTemp);
end;

//------------------------------------------------------------------------------//
//       Подпрограмма для чтения локальных переменных электропоезда ЭД4м        //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryED4M();
var
    wCompEd4m: Byte;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_TP_ED4M, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_BV_ED4M, @BV, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_KME_ED4M, @KME_ED, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_ED4M_REVERSOR, @ReversorPos, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_LDOORED4M, @LDOOR, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_RDOORED4M, @RDOOR, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_ED4M_COMPRESSOR, @wCompEd4m, 1, temp); Compressor:=wCompEd4m;  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_ED4M_KONTROLLER, @KM_Pos_1, 2, temp); except end;
    Vent:=FrontTP; if BV+Vent=2 then Vent:=1 else Vent:=0;
end;

//------------------------------------------------------------------------------//
//       Подпрограмма для чтения локальных переменных электропоезда ЭД9м        //
//------------------------------------------------------------------------------//
procedure ReadDataMemoryED9M();
var
    wCompEd4m: Byte;
begin
    try ReadProcessMemory(UnitMain.pHandle, ADDR_TP_ED9M, @FrontTP, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_BV_ED9M, @BV, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_KME_ED9M, @KME_ED, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_ED9M_REVERS, @ReversorPos, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_LDOORED4M, @LDOOR, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_RDOORED4M, @RDOOR, 1, temp);  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_ED9M_COMPRESSOR, @wCompEd4m, 1, temp); Compressor:=wCompEd4m;  except end;
    try ReadProcessMemory(UnitMain.pHandle, ADDR_ED9M_KONTROLLER, @KM_Pos_1, 1, temp);  except end;
    Vent:=FrontTP; if BV+Vent=2 then Vent:=1 else Vent:=0;
end;

//------------------------------------------------------------------------------//
//             Подпрограмма для чтения переменных ZDSimulator в ОЗУ             //
//------------------------------------------------------------------------------//
procedure ReadVarsFromRAM;
var
     wSpeed:         Double;
     wVstrDl:        Double;
     wPos_1:         Single;
     wVstrSpeed:     Single; // [м/c]
     addr_waglength: PDouble;
     I:              Integer;
begin
   With FormMain do begin
     // Получаем адрес процесса ZDSimulator
     UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
     UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

     // --- Задаем указатель на длину первого вагона встречки --- //
     addr_waglength := ADDR_VSTRECHA_WAGON_DLINA;
     Vstrecha_dlina:=0;

     // ----- Читаем основные(общие) переменные ZDSimulator ----- //
     try ReadProcessMemory(UnitMain.pHandle, ADDR_Track, @Track, 4, temp); except end;          // Получаем номер трэка
     try ReadProcessMemory(UnitMain.pHandle, ADDR_TRACK_TAIL, @TrackTail, 4, temp); except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_Speed, @wSpeed, 8, temp); except end;         // Получаем скорость 32CB38
     try ReadProcessMemory(UnitMain.pHandle, ADDR_Svetofor, @Svetofor, 1, temp); except end;   // Получаем показания светофора
     try ReadProcessMemory(UnitMain.pHandle, ADDR_KM_POS, @wPos_1, 4, temp); except end;	    // Получаем позиции 1-ой секции
     try ReadProcessMemory(UnitMain.pHandle, ADDR_KM_POS_2, @KM_Pos_2, 1, temp); except end;	    // Получаем позиции 2-ой секции
     try ReadProcessMemory(UnitMain.pHandle, ADDR_OP_POS, @KM_OP, 4, temp); except end;           // Получаем позицию шунтов
     try ReadProcessMemory(UnitMain.pHandle, ADDR_395, @KM_395, 1, temp); except end;         // Получаем позицию 394(395) крана
     try ReadProcessMemory(UnitMain.pHandle, ADDR_254, @KM_294, 4, temp); except end;         // Получаем позицию лок. крана
     try ReadProcessMemory(UnitMain.pHandle, ADDR_VSTR_NW, @WagNum_Vstr, 1, temp);  except end;     // Получаем количество вагонов встречки
     //try ReadProcessMemory(UnitMain.pHandle, ADDR_VSTR_TRACK, @wTrVstr, 2, temp);  except end;  // Получаем трэк встречки
     try ReadProcessMemory(UnitMain.pHandle, ADDR_KLUB_OPEN, @KLUBOpen, 1, temp);  except end; // Получаем байт открытия клавиатуры КЛУБ-а
     try ReadProcessMemory(UnitMain.pHandle, ADDR_ACCLRT, @Acceleretion, 8, temp);  except end;// Получаем ускорение
     try ReadProcessMemory(UnitMain.pHandle, ADDR_VSTRECHA_WAG_ORDINATA, @VstrTrack, 2, temp);  except end;// Получаем ускорение
     try ReadProcessMemory(UnitMain.pHandle, ADDR_OGRANICH, @OgrSpeed, 2, temp);  except end; // Получаем ограничение скорости с КЛУБ-а
     try ReadProcessMemory(UnitMain.pHandle, ADDR_NEXT_OGRANICH, @NextOgrSpeed, 1, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_SVETOFOR_DISTANCE, @SvetoforDist, 2, temp);  except end; // Получаем расстояние до свотофора
     try ReadProcessMemory(UnitMain.pHandle, ADDR_RAIN, @Rain, 1, temp);  except end;     // Получаем интенсивность дождя
     try ReadProcessMemory(UnitMain.pHandle, ADDR_CAMERA, @Camera, 1, temp);  except end;   // Получаем положение камеры
     try ReadProcessMemory(UnitMain.pHandle, ADDR_VIGILANCE_CHECK, @VCheck, 1, temp);  except end;   // Получаем состояние проверки бдительности
     try ReadProcessMemory(UnitMain.pHandle, ADDR_SPEED_VSTRECHA, @wVstrSpeed, 4, temp);  except end;   // Получаем состояние проверки бдительности
     try ReadProcessMemory(UnitMain.pHandle, ADDR_CAMERA_X, @CameraX, 2, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_AMPERAGE1, @TEDAmperage, 4, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_EDT_AMPERAGE, @EDTAmperage, 4, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_BRAKE_CYLINDERS, @BrakeCylinders, 4, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_RB, @RB, 1, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_RBS, @RBS, 1, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_STOCHIST, @Stochist, 4, temp); Stochist := ABS(Stochist);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_STCHSTDGR, @StochistDGR, 8, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_BOKSOVANIE, @Boks_Stat, 1, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_AB_ZB_1, @AB_ZB_1, 1, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_AB_ZB_2, @AB_ZB_2, 1, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_COUPLE_STATUS, @CoupleStat, 1, temp); except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_HIGHLIGHTS, @HighLights, 1, temp); except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_SVISTOK, @Svistok, 1, temp); except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_TIFON, @Tifon, 1, temp); except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_VSTRECH_STATUS, @VstrechStatus, 1, temp); except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_EPT, @EPT, 1, temp);  except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_ORDINATA, @Ordinata, 8, temp); except end;
     try ReadProcessMemory(UnitMain.pHandle, ADDR_OUTSIDE_LOCO_STATUS, @OutsideLocoStatus, 2, temp); except end;

     if FormSettings.cbHornClick.Checked = True then begin
        if GetAsyncKeyState(32) <> 0 then Svistok := 1 else Svistok := 0;
        if GetAsyncKeyState(66) <> 0 then Tifon := 1 else Tifon := 0;
     end;

     if Ordinata<>PrevOrdinata then OrdinataEstimate := Ordinata;

     try
        if VersionID>=1 then begin
           try
              KM_Pos_1 := Trunc(wPos_1);
           except end;
        end else begin
           if (LocoGlobal<>'M62') and (LocoGlobal<>'TEP70bs') then
              wPos_1 := wPos_1 + 0.25;
              KM_Pos_1 := Trunc(wPos_1);
        end;
      except end;

     // --- Вычисляем длину встречного поеда в метрах ---- //
     try
        ReadProcessMemory(UnitMain.pHandle, addr_waglength, @wVstrDl, 8, temp); // Получаем длину первого вагона
        Vstrecha_dlina := Vstrecha_dlina + Trunc(wVstrDl);
        Inc(addr_waglength, 18);
        for I:=1 to WagNum_Vstr do begin
           try
              ReadProcessMemory(UnitMain.pHandle, addr_waglength, @wVstrDl, 8, temp); // Получаем длину встречки в цикле
              Vstrecha_dlina := Vstrecha_dlina + Trunc(wVstrDl);
              Inc(addr_waglength, 18);
           except end;
        end;
     except end;

     // --- Вычисляем приблизительную длину трека в м. --- //
     if CoupleStat = 1 then begin
        try TrackLength := ConsistLength/(abs(Track-TrackTail)); except TrackLength := 100; end;
     end else begin
        TrackLength := 100;
     end;

     // ------ Читаем переменные локомотива из ОЗУ ------- //
     if LocoGlobal <> '' then
         try ProcReadDataMemoryAddr(); except end;

     // --- Перевод локальных переменных в глобальные ---- //
     try Speed      := Trunc(wSpeed);         except end;
     try Vstr_Speed := Trunc(wVstrSpeed * 4); except end;

     try CloseHandle(UnitMain.pHandle); except end;
   end;
end;

//------------------------------------------------------------------------------//
//   Подпрограмма для задания начальных адресов в ОЗУ и параметров локомотива   //
//------------------------------------------------------------------------------//
procedure InitializeStartParams(VersionID: Integer);
begin
    With FormMain do begin
       if versionID = 0 then begin
          ADDR_254   :=   ptr($007499E4);     ADDR_395        :=     ptr($090043A0); ADDR_Speed      :=   ptr($00749958);
          ADDR_ACCLRT:=   ptr($007498B8);     ADDR_Track      :=     ptr($00749A0C); ADDR_KM_POS     :=   ptr($0911072C);
          ADDR_OP_POS:=   ptr($0911081C);     ADDR_Svetofor   :=     ptr($09007ECC); ADDR_AMPERAGE1  :=   ptr($0538BFDC);
          ADDR_KLUB_OPEN:=ptr($0538D915);     ADDR_CAMERA     :=     ptr($09008024); ADDR_CAMERA_X   :=   ptr($007499EE);
          ADDR_RB    :=   ptr($00749914);  ADDR_CHS7_REVERSOR :=     ptr($0538BFD6); ADDR_RBS        :=   ptr($00749910);
          ADDR_OGRANICH:= ptr($0074987C); ADDR_SVETOFOR_DISTANCE:=   ptr($09007EB8);ADDR_VIGILANCE_CHECK:=ptr($007499D0);
          ADDR_CHS7_BV := ptr($091D5B9E); ADDR_BRAKE_CYLINDERS:=     ptr($0538C268); ADDR_CHS7_VOLTAGE:=  ptr($091106B8);
          ADDR_CHS7_VENT:=ptr($091D5BA0); ADDR_CHS7_COMPRESSOR:=     ptr($091D48C8); ADDR_CHS7_FTP   :=   ptr($091D5BAF);
          ADDR_CHS7_BTP:= ptr($091D5BB3);       ADDR_STOCHIST :=     ptr($007497CC); ADDR_STCHSTDGR  :=   ptr($007497BC);
          ADDR_RAIN  :=   ptr($00803D56);       ADDR_CHS8_FTP :=     ptr($09110707); ADDR_CHS8_BTP   :=   ptr($091108B7);
          ADDR_KVR_VENTS:=ptr($091D48BD);    ADDR_CHS4KVR_BTP :=     ptr($0911070F); ADDR_CHS4KVR_FTP:=   ptr($09110707);
          ADDR_VL80TComp:=ptr($091D48B8);ADDR_CHS4KVR_REVERSOR:=     ptr($0538BFD7); ADDR_CHS8_REOSTAT:=  ptr($0538BFD8);
          ADDR_AB_ZB_1:=  ptr($091106D7);     ADDR_VL80TFazan :=     ptr($091D48D3); ADDR_VL80TVent1 :=   ptr($091D506C);
          ADDR_AB_ZB_2:=  ptr($09110887);  ADDR_VL80TVent2    :=     ptr($091D5074); ADDR_VL80TVent3 :=   ptr($091D507C);
          ADDR_BV_ED4M:=  ptr($091D5B06);ADDR_VSTRECHA_WAG_ORDINATA:=ptr($09005FE4); ADDR_TEP70BS_RPM:=   ptr($091D5C9A);
          ADDR_BV_ED9M:=  ptr($091D5B16);     ADDR_VL80TVent4 :=     ptr($091D5084); ADDR_TEP70BS_KMPOS:= ptr($091D5C7D);
          ADDR_TP_ED4M:=  ptr($091D5B07);        ADDR_TP_ED9M :=     ptr($091D5B17);ADDR_CHS8_COMPRESSOR:=ptr($091D48DC);
          ADDR_VL85_FTP:= ptr($091D5C47); ADDR_ED4M_COMPRESSOR:=     ptr($091D48C6); ADDR_ED9M_COMPRESSOR:=ADDR_ED4M_COMPRESSOR;
          ADDR_CHS4T_FTP:=ptr($09110707);  ADDR_ED4M_REVERSOR :=     ptr($0538BFD6); ADDR_ED9M_REVERS:=ADDR_ED4M_REVERSOR;
          ADDR_CHS4T_BTP:=ptr($0911070F); ADDR_VL85_BTP       :=     ptr($091D5C4B); ADDR_TEP70_RPM  :=   ptr($091D5BDC);
          ADDR_CHS2K_FTP:=ptr($091D5BEF); ADDR_CHS2K_COMPRESSOR:=    ptr($091D48C8); ADDR_CHS4T_VENT :=   ptr($091D48BB);
          ADDR_CHS2K_BTP:=ptr($091D5BF3); ADDR_EP1M_COMPRESSOR:=     ptr($091D48B8); ADDR_2ES5K_FTP  :=   ptr($091D5B5F);
          ADDR_EP1M_FTP:= ptr($091D5C17); ADDR_2ES5K_BTP      :=     ptr($091D5B63); ADDR_KM_POS_2   :=   ptr($091D5AA9);
          ADDR_EP1M_BTP:= ptr($091D5C1B); ADDR_2TE10U_DIESEL2 :=     ptr($091D5AB0); ADDR_M62_RPM_1  :=   ptr($091D5A00);
          ADDR_VL11M_FTP:=ptr($091D5C2F); ADDR_2TE10U_DIESEL1 :=     ptr($091D5AAC); ADDR_M62_RPM_2  :=   ptr($091D5A24);
          ADDR_VL11M_BTP:=ptr($091D5C33); ADDR_M62_KMPOS_1    :=     ptr($091D5A14); ADDR_M62_KMPOS_2:= ADDR_M62_KMPOS_1;
          ADDR_VSTR_NW  :=ptr($09005FE0); ADDR_VSTRECHA_WAGON_DLINA:=ptr($090043D0); ADDR_BOKSOVANIE :=   ptr($0538C29C);
          ADDR_LDOORED4M:=ptr($090043B0); ADDR_VL11M_COMPRESSOR:=    ptr($091D48C8); ADDR_SPEED_VSTRECHA:=ptr($00791FB8);
          ADDR_RDOORED4M:=ptr($090043B1); ADDR_EDT_AMPERAGE   :=     ptr($0538C274); ADDR_CHS7_ZHALUZI:=  ptr($091D5BA7);
          ADDR_EPT      :=ptr($09007C59); ADDR_COUPLE_STATUS  :=     ptr($00749788); ADDR_CHS2K_VENT :=   ptr($091D5BE3);
          ADDR_CHS2K_BV :=ptr($091D5BE2); ADDR_HIGHLIGHTS     :=     ptr($09007C7A); ADDR_TRACK_TAIL :=   ptr($09008054);
          ADDR_SVISTOK  :=ptr($007499D8); ADDR_TIFON          :=     ptr($007499DC); ADDR_NEXT_OGRANICH:= ptr($00749880);
          ADDR_ED9M_KONTROLLER:=ptr($091D5B15); ADDR_VSTRECH_STATUS:=ptr($090043F8); ADDR_SETTINGS_INI_POINTER:=ptr($00803F48);
          ADDR_ED4M_KONTROLLER:=ptr($091D5B04); ADDR_VL11m_VENT:=    ptr($091D5C25); ADDR_ORDINATA   :=   ptr($00803F50);
          ADDR_OUTSIDE_LOCO_STATUS:=ptr($00749865);ADDR_CHS8_VENT_VOLUME:=ptr($091D48BC); ADDR_CHS8_VENT_VOLUME_INCREMENTER:=ptr($091D48CC);
          ADDR_2ES5K_BV :=ptr($091D48CC); ADDR_CHS8_UNIPULS_AVARIA:= ptr($091D5024); ADDR_CHS8_GV_1  :=   ptr($09007FB4);
       end;
       if versionID = 1 then begin
          ADDR_Speed :=   ptr($0072CB38);       ADDR_Track    :=     ptr($0072CBFC); ADDR_KM_POS     :=   ptr($090F3F9C);
          ADDR_KM_POS_2 :=ptr($091B9251);
          ADDR_OP_POS:=   ptr($090F408C);             ADDR_REVERSOR:=ptr($0536FA2E);ADDR_KLUB_OPEN   :=   ptr($0537118D);
          ADDR_395  :=    ptr($08FE7C18);              ADDR_254  :=  ptr($0072CBD4); ADDR_Svetofor   :=   ptr($08FEB744);
          ADDR_VSTR_NW := ptr($08FE9858);           ADDR_VSTR_TRACK:=ptr($08FE985C); ADDR_ACCLRT     :=   ptr($0072CAAC);
          ADDR_TP_ED4M := ptr($091B92AF);       ADDR_SPEED_VSTRECHA:=ptr($007759C0); ADDR_BV_ED4M    :=   ptr($091B92AE);
          ADDR_BV_ED9M := ptr($091B92BE);ADDR_VSTRECHA_WAG_ORDINATA:=ptr($08FE985C); ADDR_KME_ED4M   :=   ptr($091B92AD);
          ADDR_KME_ED9M:= ptr($091B92AD);      ADDR_VIGILANCE_CHECK:=ptr($0072CBC0);  ADDR_TP_ED9M   :=   ptr($091B92BF);
          ADDR_CAMERA_X:= ptr($0072CBDE);         ADDR_EDT_AMPERAGE:=ptr($0536FA3C);ADDR_AMPERAGE1   :=   ptr($0536FA34);
          ADDR_AMPERAGE2:=ptr($0536FA54);      ADDR_CHS7_COMPRESSOR:=ptr($091B8120);ADDR_BRAKE_CYLINDERS:=ptr($0536FD18);
          ADDR_CHS7_VENT:=ptr($091B934C);      ADDR_CHS8_COMPRESSOR:=ptr($091B8134);ADDR_CHS4T_VENT  :=   ptr($091B8113);
          ADDR_NM   :=    ptr($0072CA6C);     ADDR_CHS4T_COMPRESSOR:=ptr($091B9208);ADDR_ED4M_COMPRESSOR:=ptr($091B92AC);
          ADDR_KVR_VENTS:=ptr($091B8115);     ADDR_CHS2K_COMPRESSOR:=ptr($091B8120);ADDR_ED9M_COMPRESSOR:=ptr($091B811F);
          ADDR_CHS7_BV := ptr($08FEB779);         ADDR_CHS7_VOLTAGE:=ptr($090F3F30);ADDR_2TE10U_DIESEL1:= ptr($091B9254);
          ADDR_TEP70_RPM:=ptr($091B9388);		   ADDR_EPT:=ptr($08FEB4D1);ADDR_2TE10U_DIESEL2:= ptr($091B9258);
          ADDR_VL80TVent1  :=   ptr($091B8860);
          ADDR_VL80TVent2:=ptr($091B8868);          ADDR_VL80TVent4:=ptr($091B8870);ADDR_VL80TVent3  :=   ptr($091B8878);
          ADDR_VL80TComp:=ptr($091B8110);            ADDR_M62_RPM_1:= ptr($091B91E4);ADDR_STOCHIST    :=   ptr($0072C9C8);
          ADDR_STCHSTDGR:=ptr($0072C9C0);      ADDR_EP1M_COMPRESSOR:=ptr($091B8110);ADDR_CHS7_REVERSOR:=  ptr($0536FA2E);
          ADDR_CAMERA   :=ptr($08FEB89C);      ADDR_ED4M_REVERSOR := ptr($0536FA2E); ADDR_RB         :=   ptr($0072CB08);
          ADDR_RBS      :=ptr($0072CB04);    ADDR_SVETOFOR_DISTANCE:=ptr($08FEB730);ADDR_OGRANICH    :=   ptr($0072CA78);
          ADDR_CHS7_FTP :=ptr($091B935B);             ADDR_CHS7_BTP:=ptr($091B935F);ADDR_CHS8_FTP    :=   ptr($090F3F77);
          ADDR_CHS8_BTP :=ptr($090F411F);         ADDR_CHS8_REOSTAT:=ptr($0536FA30);ADDR_CHS4KVR_FTP :=   ptr($090F3F77);
          ADDR_VL80TFazan:=ptr($091B812A);         ADDR_CHS4KVR_BTP:=ptr($090F3F7F);ADDR_CHS4KVR_REVERSOR:=ptr($0536FA2F);
          ADDR_ED9M_REVERS:=ptr($0536FA2E);          ADDR_CHS2K_FTP:=ptr($091B939F);ADDR_CHS2K_BTP   :=   ptr($091B939B);
          ADDR_CHS4T_FTP:=ptr($090F3F77);            ADDR_CHS4T_BTP:=ptr($090F3F7F);ADDR_EP1M_FTP    :=   ptr($091B93C3);
          ADDR_EP1M_BTP :=ptr($091B93C7);                 ADDR_RAIN:=ptr($007E77AC);ADDR_2ES5K_BTP   :=   ptr($091B930B);
          ADDR_2ES5K_FTP:=ptr($091B9307); ADDR_VSTRECHA_WAGON_DLINA:=ptr($08FE7C48);ADDR_VL11M_FTP   :=   ptr($091B93D7);
          ADDR_VL11M_BTP:=ptr($091B93DB);             ADDR_VL85_FTP:=ptr($091B93F3);ADDR_VL85_BTP    :=   ptr($091B93F7);
          ADDR_AB_ZB_1  :=ptr($090F3F4F);           ADDR_BOKSOVANIE:=ptr($0536FDF8);ADDR_AB_ZB_2     :=   ptr($090F40F7);
          ADDR_LDOORED4M  := ptr($08FE7C28);      ADDR_RDOORED4M  := ptr($08FE7C29);ADDR_M62_RPM_2   :=   ptr($00000000);
          ADDR_COUPLE_STATUS:=ptr($0072C984);     ADDR_CHS7_ZHALUZI:=ptr($091B9353); ADDR_CHS2K_VENT :=   ptr($091B938F);
          ADDR_CHS2K_BV :=ptr($091B938E);           ADDR_HIGHLIGHTS:=ptr($08FEB4F2);ADDR_TRACK_TAIL  :=   ptr($08FEB8CC);
          ADDR_SVISTOK  :=ptr($0072CBC8);                ADDR_TIFON:=ptr($0072CBCC);ADDR_VL11m_VENT  :=   ptr($091B93D1);
          ADDR_VSTRECH_STATUS:=ptr($08FE7C70); ADDR_SETTINGS_INI_POINTER:=ptr($007E79A0); ADDR_ORDINATA:= ptr($007E79A8);
          ADDR_ED4M_KONTROLLER:=ptr($091B92AC);ADDR_OUTSIDE_LOCO_STATUS:=ptr($0072CA62);
          ADDR_ED9M_KONTROLLER:=ptr($091B92BD);ADDR_CHS8_VENT_VOLUME:=ptr($091B8114);ADDR_CHS8_VENT_VOLUME_INCREMENTER:=ptr($091B8124);
          ADDR_2ES5K_BV :=ptr($091B8124); ADDR_CHS8_UNIPULS_AVARIA:= ptr($091B8818);
       end;

        // -/- ВЛ80т (VL80t) -/- //
        if LocoGlobal='VL80t' then begin
           LocoWorkDir         := 'TWS/VL80t/';
           UltimateTEDAmperage := 1000;		// Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 2;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 25;           // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentStartF          := PChar('TWS/VL80t/MV-start.wav');
           VentCycleF          := PChar('TWS/VL80t/MV-loop.wav');
           VentStopF           := PChar('TWS/VL80t/MV-stop.wav');
           XVentStartF         := PChar('TWS/VL80t/x_MV-start.wav');
           XVentCycleF         := PChar('TWS/VL80t/x_MV-loop.wav');
           XVentStopF          := PChar('TWS/VL80t/x_MV-stop.wav');
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryVL80t;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ВЛ85 (VL85) -/- //
        if LocoGlobal='VL85' then begin
           LocoWorkDir         := 'TWS/VL85/';
           UltimateTEDAmperage := 1000;		// Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 2;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 25;           // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryVL85;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ВЛ82м (VL82m) -/- //
        if LocoGlobal='VL82m' then begin
           LocoWorkDir         := 'TWS/VL82m/';
           UltimateTEDAmperage := 650;          // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 2;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 3;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryVL82m;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ВЛ11м (VL11m) -/- //
        if LocoGlobal='VL11m' then begin
           LocoWorkDir         := 'TWS/VL11m/';
           UltimateTEDAmperage := 650;          // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 2;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 3;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           VentStartF          := PChar('TWS/VL11m/MV-start.wav');
           VentCycleF          := PChar('TWS/VL11m/MV-loop.wav');
           VentStopF           := PChar('TWS/VL11m/MV-stop.wav');
           XVentStartF         := PChar('TWS/VL11m/x_MV-start.wav');
           XVentCycleF         := PChar('TWS/VL11m/x_MV-loop.wav');
           XVentStopF          := PChar('TWS/VL11m/x_MV-stop.wav');
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryVL11m;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- 2ЭС5К (2ES5K) -/- //
        if LocoGlobal='2ES5K' then begin
           LocoWorkDir         := 'TWS/2ES5K/';
           UltimateTEDAmperage := 1000;         // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 2;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 25;           // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentStartF          := PChar('TWS/EP1m/MV-start.wav');
           VentCycleF          := PChar('TWS/EP1m/MV-loop.wav');
           VentStopF           := PChar('TWS/EP1m/MV-stop.wav');
           XVentStartF         := PChar('TWS/EP1m/MV-start.wav');
           XVentCycleF         := PChar('TWS/EP1m/MV-loop.wav');
           XVentStopF          := PChar('TWS/EP1m/MV-stop.wav');
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemory2ES5k;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЭП1м (EP1m) -/- //
        if LocoGlobal='EP1m' then begin
           LocoWorkDir         := 'TWS/EP1m/';
           UltimateTEDAmperage := 1500;
           LocoSectionsNum     := 1;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 25;           // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := True;         // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentStartF          := PChar('TWS/EP1m/MV-start.wav');
           VentCycleF          := PChar('TWS/EP1m/MV-loop.wav');
           VentStopF           := PChar('TWS/EP1m/MV-stop.wav');
           XVentStartF         := PChar('TWS/EP1m/MV-start.wav');
           XVentCycleF         := PChar('TWS/EP1m/MV-loop.wav');
           XVentStopF          := PChar('TWS/EP1m/MV-stop.wav');
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'EP_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := 'EP_TED'; // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryEP1m;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЧС2к (CHS2K) -/- //
        if LocoGlobal='CHS2K' then begin
           LocoWorkDir         := 'TWS/CHS2K/';
           UltimateTEDAmperage := 600;          // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 3;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := True;         // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentStartF          := PChar('TWS/CHS2K/vent-start.wav');
           VentCycleF          := PChar('TWS/CHS2K/vent.wav');
           VentStopF           := PChar('TWS/CHS2K/vent-stop.wav');
           XVentStartF         := PChar('TWS/CHS2K/vent-start.wav');
           XVentCycleF         := PChar('TWS/CHS2K/vent.wav');
           XVentStopF          := PChar('TWS/CHS2K/vent-stop.wav');
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0.001;        // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'CHS_TED';    // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryCHS2k;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЧС4 (CHS4) -/- //
        if LocoGlobal='CHS4' then begin
           LocoWorkDir         := 'TWS/CHS4t/';
           UltimateTEDAmperage := 1500;         // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 25;           // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := True;         // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := True;         // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := True;         // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'CHS_TED';    // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar(
                      'TWS/revers-CHS.wav');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 0;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryCHS4;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЧС4квр (CHS4 KVR) -/- //
        if LocoGlobal='CHS4 KVR' then begin
           LocoWorkDir         := 'TWS/CHS4KVR/';
           UltimateTEDAmperage := 1500;         // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 25;           // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := True;         // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := True;         // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := True;         // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := True;         // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentStartF          := PChar('TWS/CHS4KVR/ventVU-start.wav');
           VentCycleF          := PChar('TWS/CHS4KVR/ventVU.wav');
           VentStopF           := PChar('TWS/CHS4KVR/ventVU-stop.wav');
           XVentStartF         := PChar('TWS/CHS4KVR/x_ventVU-start.wav');
           XVentCycleF         := PChar('TWS/CHS4KVR/x_ventVU.wav');
           XVentStopF          := PChar('TWS/CHS4KVR/x_ventVU-stop.wav');
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0.004;        // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'CHS_TED';    // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar(
                      'TWS/revers-CHS.wav');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 0;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryCHS4kvr;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЧС4т (CHS4t) -/- //
        if LocoGlobal='CHS4t' then begin
           LocoWorkDir         := 'TWS/CHS4t/';
           UltimateTEDAmperage := 1500;         // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 25;           // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := True;         // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := True;         // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := True;         // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := True;         // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0.0025;      // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'CHS_TED';    // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar(
                      'TWS/revers-CHS.wav');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryCHS4t;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЧС8 (CHS8) -/- //
        if LocoGlobal='CHS8' then begin
           LocoWorkDir         := 'TWS/CHS8/';
           UltimateTEDAmperage := 1500;         // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 2;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 25;           // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := True;         // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := True;         // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := True;         // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := True;         // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0.002;       // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'CHS_TED';    // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           if (LocoNum > 2) and (LocoNum < 33) then
              RevPosF             := PChar(
                         'TWS/CHS8/E1/revers.wav') // Задаем имя файла реверсора
           else
              RevPosF             := PChar(
                         'TWS/CHS8/E2/revers.wav');// Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryCHS8;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЧС7 (CHS7) -/- //
        if LocoGlobal='CHS7' then begin
           LocoWorkDir         := 'TWS/CHS7/';
           UltimateTEDAmperage := 800;          // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 2;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 3;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := True;         // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := True;         // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := True;         // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := True;         // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := True;         // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := True;         // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentStartF          := PChar('TWS/CHS7/mv-start.wav');
           VentCycleF          := PChar('TWS/CHS7/mv-loop.wav');
           VentStopF           := PChar('TWS/CHS7/mv-stop.wav');
           XVentStartF         := PChar('TWS/CHS7/x_mv-start.wav');
           XVentCycleF         := PChar('TWS/CHS7/x_mv-loop.wav');
           XVentStopF          := Pchar('TWS/CHS7/x_mv-stop.wav');
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0.001;        // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'CHS_TED';    // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar(
                      'TWS/revers-CHS.wav');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 0;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryCHS7;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ТЭП70 (TEP70) -/- //
        if LocoGlobal='TEP70' then begin
           LocoWorkDir         := 'TWS/TEP70/';
           UltimateTEDAmperage := 800;          // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 0;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := True;         // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := False;        // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := 'TEP70';      // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryTEP70;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ТЭП70бс (TEP70bs) -/- //
        if LocoGlobal='TEP70bs' then begin
           LocoWorkDir         := 'TWS/TEP70bs/';
           UltimateTEDAmperage := 800;          // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 0;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := True;         // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := False;        // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := 'TEP70bs';    // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryTEP70BS;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- М62 (M62) -/- //
        if LocoGlobal='M62' then begin
           LocoWorkDir         := 'TWS/M62/';
           UltimateTEDAmperage := 800;          // Задаем предельный ток нагрузки ТЭД
           if VersionID = 1 then
              LocoSectionsNum     := 1		// Задаем количество секций для текущего локомотива
           else
              LocoSectionsNum     := 2;
           LocoPowerVoltage    := 0;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := True;         // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := True;         // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := True;         // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := False;        // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := 'M62';        // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar(
                      'TWS/M62/reverser.wav');  // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryM62;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ТЭМ18дм (TEM18dm) -/- //
        if LocoGlobal='TEM18dm' then begin
           LocoWorkDir         := 'TWS/TEM18dm/';
           //UltimateTEDAmperage := 800;        // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 0;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := False;        // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := False;        // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryTEM18dm;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- 2ТЭ10у (2TE10U) -/- //
        if LocoGlobal='2TE10U' then begin
           LocoWorkDir         := 'TWS/2TE10U/';
           UltimateTEDAmperage := 800;          // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 2;		// Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 0;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := True;         // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := False;        // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := False;        // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := False;        // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'VL_TED';     // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '2TE10U';     // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar('');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 1;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemory2TE10U;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЭД4м (ED4M) -/- //
        if LocoGlobal='ED4M' then begin
           LocoWorkDir         := 'TWS/ED4m/';
           //UltimateTEDAmperage := 800;        // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;	        // Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 0;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := True;         // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := True;         // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentStartF          := PChar('TWS/ED4m/sinxrom_start.wav');
           VentCycleF          := PChar('TWS/ED4m/sinxrom_loop.wav');
           VentStopF           := PChar('TWS/ED4m/sinxrom_stop.wav');
           XVentStartF         := PChar('TWS/ED4m/sinxrom_start.wav');
           XVentCycleF         := PChar('TWS/ED4m/sinxrom_loop.wav');
           XVentStopF          := PChar('TWS/ED4m/sinxrom_stop.wav');
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'ED4m';           // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           if LocoNum < 160 then
              RevPosF             := PChar(
                         'TWS/ED4m/revers.wav')    // Задаем имя файла реверсора
           else
              RevPosF             := PChar(
                         'TWS/ED4m/CPPK_revers.wav');
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 0;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryED4M;		// Задаем указатель на функцию чтения памяти
        end;
        // -/- ЭД9м (ED9M) -/- //
        if LocoGlobal='ED9M' then begin
           LocoWorkDir         := 'TWS/ED4m/';
           //UltimateTEDAmperage := 800;        // Задаем предельный ток нагрузки ТЭД
           LocoSectionsNum     := 1;	        // Задаем количество секций для текущего локомотива
           LocoPowerVoltage    := 0;            // Тип электрофикации локомотива [0, -, ~]
           LocoWithTED         := True;         // Задаем состояние наличия на данном локомотиве звука ТЭД-ов
           LocoWithReductor    := False;        // Задаем состояние наличия на данном локомотиве звука редуктора
           LocoWithDIZ         := False;        // Задаем состояние наличия на данном локомотиве звуков дизеля
           LocoWithSndReversor := True;         // Задаем состояние надичия на данном локомотиве звуков реверсора
           LocoWithSndKM       := True;         // Задаем состояние наличия на данном локомотиве звуков контроллера
           LocoWithSndKM_OP    := False;        // Задаем состояние наличия на данном локомотиве звука постановки ОП
           LocoWithSndTP       := True;         // Задаем состояние наличия на данном локомотиве звука ТП
           LocoWithExtMVSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МВ
           LocoWithExtMKSound  := False;        // Задаем состояние наличия на данном локомотиве внешних звуков МК
           LocoWithMVPitch     := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ
           LocoWithMVTDPitch   := False;        // Задаем состояние наличия на данном локомотиве тонального регулирования МВ ТД
           VentStartF          := PChar('TWS/ED4m/trans_start.wav');
           VentCycleF          := PChar('TWS/ED4m/trans_loop.wav');
           VentStopF           := PChar('TWS/ED4m/trans_stop.wav');
           XVentStartF         := PChar('TWS/ED4m/trans_start.wav');
           XVentCycleF         := PChar('TWS/ED4m/trans_loop.wav');
           XVentStopF          := PChar('TWS/ED4m/trans_stop.wav');
           VentTDPitchIncrementer:=0;           // Задаем значение для инкрементера тональности МВ ТД
           VentPitchIncrementer:= 0;            // Задаем значение для инкрементера тональности МВ
           LocoTEDNamePrefiks  := 'ED4m';           // Задаем префикс названия папки с звуками ТЭД
           LocoReductorNamePrefiks := '';       // Задаем префикс названия папки со звуками редуктора
           LocoDIZNamePrefiks  := '';           // Задаем префикс названия папки с звуками работы дизеля
           RevPosF             := PChar(
                      'TWS/ED4m/CPPK_revers.wav');    // Задаем имя файла реверсора
           LocoSvistokF        := 'svistok';
           LocoHornF           := 'tifon';
           LocoSndReversorType := 0;            // Задаем тип воспроизведения звука реверсора (0-данные с памяти, 1-по нажатию клавиши)
           @ProcReadDataMemoryAddr :=
              @ReadDataMemoryED9M;		// Задаем указатель на функцию чтения памяти
        end;
     end;
end;

end.
