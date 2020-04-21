unit CHS4KVR;

interface

uses KR21;

type chs4kvr_ = class (TObject)
    private
      soundDir: String;

      GRIncrementer: Byte;

      kr21__: kr21_;

      procedure vent_step();
      procedure mk_step();
      procedure em_latch_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, Bass, SysUtils;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor CHS4KVR_.Create;
   begin
      soundDir := 'TWS\CHS4KVR\';

      kr21__ := kr21_.Create();
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4KVR_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         vent_step();
         mk_step();
      end;

      if FormMain.cbCabinClicks.Checked = True then begin
         kr21__.step();
         em_latch_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4KVR_.em_latch_step();
   begin
      if ((Prev_KMAbs=0) and (KM_Pos_1>0)) or ((KM_Pos_1=0) and (Prev_KMAbs>0)) then begin
         IMRZashelka:=PChar('TWS/EM_zashelka.wav'); isPlayIMRZachelka:=False;
      end;
      if PrevReostat + Reostat = 1 then begin
         IMRZashelka:=PChar('TWS/EM_zashelka.wav'); isPlayIMRZachelka:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4KVR_.mk_step();
   begin
      if GR > PrevGR then begin
         GRIncrementer := 0;
         Compressor := 1;
      end else begin
         Inc(GRIncrementer);
         if GRIncrementer > 2 then Compressor := 0;
      end;

      if AnsiCompareStr(CompressorCycleF, '') <> 0 then begin
          if (GetChannelRemaindPlayTime2Sec(Compressor_Channel) <= 0.8) and
             (BASS_ChannelIsActive(CompressorCycleChannel)=0)
          then isPlayCompressorCycle:=False;
      end;
      if AnsiCompareStr(XCompressorCycleF, '')<> 0 then begin
          if (GetChannelRemaindPlayTime2Sec(XCompressor_Channel) <= 0.8) and
             (BASS_ChannelIsActive(XCompressorCycleChannel)=0)
          then isPlayXCompressorCycle:=False;
      end;

      if Compressor<>Prev_Compressor then begin
         if Compressor<>0 then begin
            CompressorF       := StrNew(PChar(soundDir + 'mk_start.wav'));
            CompressorCycleF  := StrNew(PChar(soundDir + 'mk_loop.wav'));
            XCompressorF      := StrNew(PChar(soundDir + 'x_mk_start.wav'));
            XCompressorCycleF := StrNew(PChar(soundDir + 'x_mk_loop.wav'));
            isPlayCompressor := False; isPlayXCompressor := False;
         end else begin
            CompressorF  := StrNew(PChar(soundDir + 'mk_stop.wav'));
            XCompressorF := StrNew(PChar(soundDir + 'x_mk_stop.wav'));
            CompressorCycleF := PChar(''); XCompressorCycleF := PChar('');
            isPlayCompressor := False; isPlayXCompressor := False;
         end;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4KVR_.vent_step();
   begin
      if (Vent<>Prev_Vent) and (Vent=Prev_VentLocal) then begin
         VentTDVol := FormMain.trcBarVspomMahVol.Position / 100;
         if (Vent=4113039) and (Prev_Vent=0) then begin // Запуск ВУ
            StopVent:=False; VentPitchDest:=0; isPlayVent:=False; isPlayVentX:=False; end;
         if (Vent=4126146) and (Prev_Vent=0) then begin // Запуск ВУ и ТД (2-ая позиция)
            StopVent:=False; isPlayVent:=False; isPlayVentX:=False; VentPitchDest:=-1.5;
            VentTDF       := StrNew(PChar(soundDir + 'ventTD-start.wav'));
            VentCycleTDF  := StrNew(PChar(soundDir + 'ventTD.wav'));
            XVentTDF      := StrNew(PChar(soundDir + 'x_ventTD-start.wav'));
            XVentCycleTDF := StrNew(PChar(soundDir + 'x_ventTD.wav'));
            isPlayVentTD:=False;	// Звук в кабине
            isPlayVentTDX:=False;
         end;
         if (Vent=4050124) and (Prev_Vent=0) then begin // Запуск ТД (1->2 позиция)
            VentTDF       := StrNew(PChar(soundDir + 'ventTD-start.wav'));
            VentCycleTDF  := StrNew(PChar(soundDir + 'ventTD.wav'));
            XVentTDF      := StrNew(PChar(soundDir + 'x_ventTD-start.wav'));
            XVentCycleTDF := StrNew(PChar(soundDir + 'x_ventTD.wav'));
            isPlayVentTD:=False;	// Звук в кабине
            isPlayVentTDX:=False;
            if KM_Pos_1 >= 2 then VentPitchDest:=-1.5 else VentPitchDest:=0;
         end;
         if Vent=0 then begin // ВЫКЛ
            if (BASS_ChannelIsActive(Vent_Channel_FX)<>0) or (BASS_ChannelIsActive(VentCycle_Channel_FX)<>0) then begin
               StopVent:=True; isPlayVent:=False; isPlayVentX:=False; VentPitchDest:=0;
            end;
            if (BASS_ChannelIsActive(VentTD_Channel)<>0) or (BASS_ChannelIsActive(VentCycleTD_Channel)<>0) then begin
               VentTDF  := StrNew(PChar(soundDir + 'ventTD-stop.wav'));
               VentCycleTDF:=PChar(''); isPlayVentTD:=False;	// Звук в кабине
               XVentTDF := StrNew(PChar(soundDir + 'x_ventTD-stop.wav'));
               XVentCycleTDF:=PChar(''); isPlayVentTDX:=False; end;
            end;
         if (Vent=4113039) and (Prev_Vent=4126146) then begin // Остановка ТД
            VentTDF  := StrNew(PChar(soundDir + 'ventTD-stop.wav'));
            VentCycleTDF:=PChar(''); isPlayVentTD:=False;    // Звук в кабине
            XVentTDF := StrNew(PChar(soundDir + 'x_ventTD-stop.wav'));
            XVentCycleTDF:=PChar(''); isPlayVentTDX:=False; end;
         if (Vent=4113039) and (Prev_Vent=4050124) then begin // Запуск ВУ, остановка ТД
            StopVent:=False; isPlayVent:=False; isPlayVentX:=False; VentPitchDest:=0;
            VentTDF  := StrNew(PChar(soundDir + 'ventTD-stop.wav'));
            VentCycleTDF:=PChar(''); isPlayVentTD:=False;
            XVentTDF := StrNew(PChar(soundDir + 'x_ventTD-stop.wav'));
            XVentCycleTDF:=PChar(''); isPlayVentTDX:=False;
         end;
         if (Vent=4126146) and (Prev_Vent=4113039) then begin // Запуск ТД, после запуска ВУ
            VentTDF       := StrNew(PChar(soundDir + 'ventTD-start.wav'));
            VentCycleTDF  := StrNew(PChar(soundDir + 'ventTD.wav'));
            XVentTDF      := StrNew(PChar(soundDir + 'x_ventTD-start.wav'));
            XVentCycleTDF := StrNew(PChar(soundDir + 'x_ventTD.wav'));
            isPlayVentTD:=False;
            isPlayVentTDX:=False;
            VentPitchDest:=-1.5;
         end;
         if (Vent=4126146) and (Prev_Vent=4050124) then begin // Запуск ВУ (2-ая позиция)
            StopVent:=False; VentPitchDest:=-1.5; isPlayVent:=False; isPlayVentX:=False;
         end;
         if (Vent=4050124) and (Prev_Vent=4113039) then begin // Остановка ВУ, запуск ТД
            StopVent:=True; ventPitchDest:=0; isPlayVent:=False; isPlayVentX:=False;
            VentTDF       := StrNew(PChar(soundDir + 'ventTD-start.wav'));
            VentCycleTDF  := StrNew(PChar(soundDir + 'ventTD.wav'));
            XVentTDF      := StrNew(PChar(soundDir + 'x_ventTD-start.wav'));
            XVentCycleTDF := StrNew(PChar(soundDir + 'x_ventTD.wav'));
            isPlayVentTD:=False;
            isPlayVentTDX:=False;
         end;
         if (Vent=4050124) and (Prev_Vent=4126146) then begin // Остановка ВУ
            StopVent:=True; VentPitchDest:=0; isPlayVent:=False; isPlayVentX:=False;
         end;
      end;
   end;

end.
 