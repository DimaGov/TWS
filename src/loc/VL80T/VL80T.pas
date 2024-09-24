unit VL80T;

interface

type vl80t_ = class (TObject)
    private
      soundDir: String;

      procedure mk_step();
      procedure vent_step();
      procedure fr_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, SysUtils, Bass;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor VL80T_.Create;
   begin
      soundDir := 'TWS\VL80t\';
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure VL80T_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         mk_step();
         fr_step();
         vent_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure VL80T_.mk_step();
   begin
      ComprRemaindTimeCheck();

      if Compressor<>Prev_Compressor then begin
         if Compressor<>0 then begin
            CompressorF       := StrNew(PChar(soundDir + 'MK-start.wav'));
            CompressorCycleF  := StrNew(PChar(soundDir + 'MK-loop.wav'));
            XCompressorF      := StrNew(PChar(soundDir + 'x_MK-start.wav'));
            XCompressorCycleF := StrNew(PChar(soundDir + 'x_MK-loop.wav'));
            isPlayCompressor:=False; isPlayXCompressor := False;
         end else begin
            CompressorF      := StrNew(PChar(soundDir + 'MK-stop.wav'));
            XCompressorF     := StrNew(PChar(soundDir + 'x_MK-stop.wav'));
            CompressorCycleF := PChar(''); XCompressorCycleF := PChar('');
            isPlayCompressor:=False; isPlayXCompressor:=False;
         end;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure VL80T_.fr_step();
   begin
      if Fazan <> PrevFazan then begin
         if Fazan = 0 then
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'FR-stop.wav'))
         else
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'FR-pusk.wav'));
         isPlayLocoPowerEquipment:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure VL80T_.vent_step();
   begin
      VentRemaindTimeCheck();

      // ЗАПУСК
      if Vent+Vent2+Vent3+Vent4 > Prev_Vent+Prev_Vent2+Prev_Vent3+Prev_Vent4 then begin
         if Vent<>Prev_Vent then VentVolume:=100;
         if Vent2<>Prev_Vent2 then VentVolume:=70;
         if Vent3<>Prev_Vent3 then VentVolume:=25;
         if Vent4<>Prev_Vent4 then VentVolume:=25;
         StopVent := False; isPlayVent := False; isPlayVentX := False;
      end;
      // ОСТАНОВКА
      if Vent+Vent2+Vent3+Vent4 < Prev_Vent+Prev_Vent2+Prev_Vent3+Prev_Vent4 then begin
         if Vent<>Prev_Vent then VentVolume:=100;
         if Vent2<>Prev_Vent2 then VentVolume:=70;
         if Vent3<>Prev_Vent3 then VentVolume:=25;
         if Vent4<>Prev_Vent4 then VentVolume:=25;
         StopVent := True; isPlayVent := False; isPlayVentX := False;
      end;
      // ЗАДАЕМ ГРОМКОСТЬ РАБОТЫ ЗВУКА ЦИКЛА ВЕНТИЛЯТОРОВ ВЛ80т
      if Vent=1 then CycleVentVolume:=100 else begin
         if Vent2=1 then CycleVentVolume:=70 else begin
            if Vent3=1 then CycleVentVolume:=25 else begin
               if Vent4=1 then CycleVentVolume:=25 else CycleVentVolume:=0;
            end;
         end;
      end;

      if Vent + Vent2 + Vent3 + Vent4 = 0
      then begin
         BASS_ChannelStop(VentCycleTD_Channel); BASS_StreamFree(VentCycleTD_Channel);
         BASS_ChannelStop(VentCycleTD_Channel_FX); BASS_StreamFree(VentCycleTD_Channel_FX);
         BASS_ChannelStop(VentCycle_Channel); BASS_StreamFree(VentCycle_Channel);
         BASS_ChannelStop(VentCycle_Channel_FX); BASS_StreamFree(VentCycle_Channel_FX);
         BASS_ChannelStop(XVentCycleTD_Channel); BASS_StreamFree(XVentCycleTD_Channel);
         BASS_ChannelStop(XVentCycleTD_Channel_FX); BASS_StreamFree(XVentCycleTD_Channel_FX);
         BASS_ChannelStop(XVentCycle_Channel); BASS_StreamFree(XVentCycle_Channel);
         BASS_ChannelStop(XVentCycle_Channel_FX); BASS_StreamFree(XVentCycle_Channel_FX);
      end;
   end;

end.
 