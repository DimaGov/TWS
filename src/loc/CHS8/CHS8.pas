unit CHS8;

interface

   uses KR21;

   type chs8_ = class (TObject)
    private
      soundDir: String;
      unipulsDir: String;

      // Переменные для контроллера KR21
      prevKeyA: Byte;
      prevKeyD: Byte;
      prevKeyQ: Byte;
      prevKeyE: Byte;
      KMPrevKey: String;

      VentStarted: Boolean;

      // Переменные для корректной работы унипульса //
      isLaunchedUnipuls:           Boolean; // Запущен ли унипульс?

      kr21__: kr21_;

      procedure np22_step();
      procedure unipuls_step();
      procedure bv_step();
      procedure vent_step();
      procedure mk_step();
      procedure em_latch_step();
    protected

    public
      UnipulsChanNum:              Byte;
      UnipulsFaktVol:              Byte;
      UnipulsTargetVol:            Byte;
      isStartUnipuls:              Boolean; // Флаг для плавного запуска Унипульса
      isStopUnipuls:               Boolean; // Флаг для плавной остановки Унипульса
      UnipulsFaktPos:              Integer;
      UnipulsTargetPos:            Byte;
      UnipulsVol1:                 Integer;

      procedure step();

    published

    constructor Create;

   end;

implementation

uses UnitMain, SoundManager, Windows, Bass, SysUtils, Math;

   // ----------------------------------------------------
   // Конструктор класса ЧС8
   // ----------------------------------------------------
   constructor CHS8_.Create;
   begin
      soundDir := 'TWS\CHS8\';
      unipulsDir := soundDir + 'Unipuls\';

      kr21__ := kr21_.Create();
   end;

   // ----------------------------------------------------
   // 
   // ----------------------------------------------------
   procedure CHS8_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         kr21__.step();
         em_latch_step();
      end;

      if FormMain.cbVspomMash.Checked = True then begin
         np22_step();
         bv_step();
         mk_step();
         vent_step();

         if Vent <> 5 then
            unipuls_step();
      end;
   end;

   // ----------------------------------------------------
   // Пневмодвигатель 22NP
   // ----------------------------------------------------
   procedure CHS8_.np22_step();
   begin
      if KM_Pos_1 > Prev_KMAbs then begin
         if (LocoNum > 2) And (LocoNum < 33) then
            if KM_Pos_1 mod 2 = 0 then
               LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E1/22NP_nabor_2.wav'))
            else
               LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E1/22NP_nabor_1.wav'))
         else
            if KM_pos_1 mod 2 = 0 then
               LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E2/22NP_nabor_2.wav'))
            else
               LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E2/22NP_nabor_1.wav'));
         isPlayLocoPowerEquipment := False;
      end;
      if KM_Pos_1 < Prev_KMAbs then begin
         if (LocoNum > 2) And (LocoNum < 33) then
            if KM_Pos_1 mod 2 = 0 then
               LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E1/22NP_sbros_2.wav'))
            else
               LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E1/22NP_sbros_1.wav'))
         else
            if KM_Pos_1 mod 2 = 0 then
               LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E2/22NP_sbros_2.wav'))
            else
               LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E2/22NP_sbros_1.wav'));
         isPlayLocoPowerEquipment := False;
      end;
      if KM_OP > Prev_KM_OP then begin
         if (LocoNum > 2) And (LocoNum < 33) then
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E1/22NP_op_plus.wav'))
         else
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E2/22NP_op_plus.wav'));
         isPlayLocoPowerEquipment := False;
         if Prev_KM_OP > 0 then
            CabinClicksF := StrNew(PChar(soundDir + '21KR_op+.wav'))
         else
            CabinClicksF := StrNew(PChar(soundDir + '21KR_vvod_op.wav'));
         isPlayCabinClicks := False;
      end;
      if KM_OP < Prev_KM_OP then begin
         if (LocoNum > 2) And (LocoNum < 33) then
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E1/22NP_op_minus.wav'))
         else
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E2/22NP_op_minus.wav'));
         isPlayLocoPowerEquipment := False;
         if KM_OP > 0 then
            CabinClicksF := StrNew(PChar(soundDir + '21KR_op-.wav'))
         else
            CabinClicksF := StrNew(PChar(soundDir + '21KR_vivod_op.wav'));
         isPlayCabinClicks := False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS8_.bv_step();
   begin
      // ГВ на ЧС8
      if (BV<>0) and (PrevBV=0) then begin
         if (LocoNum > 2) And (LocoNum < 33) then
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E1/gv_on.wav'))
         else
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E2/gv_on.wav'));
         isPlayLocoPowerEquipment := False;
      end;
      if (BV=0) and (PrevBV<>0) then begin
         if (LocoNum > 2) And (LocoNum < 33) then
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E1/gv_off.wav'))
         else
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'E2/gv_off.wav'));
         isPlayLocoPowerEquipment := False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS8_.mk_step();
   begin
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
            CompressorF       := StrNew(PChar(soundDir + 'mk-start.wav'));
            CompressorCycleF  := StrNew(PChar(soundDir + 'mk-loop.wav'));
            XCompressorF      := StrNew(PChar(soundDir + 'x_mk-start.wav'));
            XCompressorCycleF := StrNew(PChar(soundDir + 'x_mk-loop.wav'));
            isPlayCompressor := False; isPlayXCompressor := False;
         end else begin
            CompressorF  := StrNew(PChar(soundDir + 'mk-stop.wav'));
            XCompressorF := StrNew(PChar(soundDir + 'x_mk-stop.wav'));
            CompressorCycleF := PChar(''); XCompressorCycleF := PChar('');
            isPlayCompressor := False; isPlayXCompressor := False;
         end;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS8_.em_latch_step();
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
   procedure CHS8_.vent_step();
   begin
      if VentStarted = False then begin
         VentTDF := StrNew(PChar(soundDir + 'vent.wav')); VentCycleTDF := StrNew(PChar(soundDir + 'vent.wav'));
         XVentTDF := StrNew(PChar(soundDir + 'x_vent.wav'));XVentCycleTDF:=StrNew(PChar(soundDir + 'x_vent.wav'));
         isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=False; VentStarted := True;
      end;

      if Vent = 5 then begin VentTDPitchDest := 0; end;
      if Vent = 4 then begin VentTDPitchDest := 0; end;
      if Vent = 3 then begin VentTDPitchDest := -7; end;
      if Vent = 2 then begin VentTDPitchDest := -15; end;
      if Vent = 1 then begin
         if TEDAmperage>0 then VentTDPitchDest := power(TEDAmperage * 200 / UltimateTEDAmperage,0.6) - 20;
         if EDTAmperage>0 then VentTDPitchDest := power(EDTAmperage * 200 / UltimateTEDAmperage,0.6) - 20;
      end;
      if Vent = 0 then begin VentTDPitchDest := -20; end;
      VentTDVolDest := power((VentTDPitch+20)/20, 0.5) * (FormMain.trcBarVspomMahVol.Position/100);
      if VentTDVol > VentTDVolDest then VentTDVol := VentTDVol - 0.001 * MainCycleFreq;
      if VentTDVol < VentTDVolDest then VentTDVol := VentTDVol + 0.001 * MainCycleFreq;
   end;

   // ----------------------------------------------------
   // Унипульс
   // ----------------------------------------------------
   procedure CHS8_.unipuls_step();
   begin
      if ((PrevTEDAmperage=0) and (TEDAmperage>0)) or
         ((PrevEDTAmperage=0) and (EDTAmperage>0)) then begin
         TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '50-300 A.wav')), True);
         UnipulsFaktPos:=0;
      end;
      if ((TEDAmperage>0)and(TEDAmperage<300)) or ((EDTAmperage>0)and(EDTAmperage<300)) then begin
         if (PrevTEDAmperage=0)or(PrevTEDAmperage>=300)or(PrevEDTAmperage=0)or(PrevEDTAmperage>=300) then begin
            UnipulsTargetPos:=0;
         end;
      end;
      if ((TEDAmperage>=300)and(TEDAmperage<400)) or ((EDTAmperage>=300)and(EDTAmperage<400)) then begin
         if (PrevTEDAmperage<300)or(PrevTEDAmperage>=400)or(PrevEDTAmperage<300)or(PrevEDTAmperage>=400) then begin
            UnipulsTargetPos:=1;
         end;
      end;
      if ((TEDAmperage>=400)and(TEDAmperage<500)) or ((EDTAmperage>=400)and(EDTAmperage<500)) then begin
         if (PrevTEDAmperage<400)or(PrevTEDAmperage>=500)or(PrevEDTAmperage<400)or(PrevEDTAmperage>=500) then begin
            UnipulsTargetPos:=2;
         end;
      end;
      if ((TEDAmperage>=500)and(TEDAmperage<600)) or ((EDTAmperage>=500)and(EDTAmperage<600)) then begin
         if (PrevTEDAmperage<500)or(PrevTEDAmperage>=600)or(PrevEDTAmperage<500)or(PrevEDTAmperage>=600) then begin
            UnipulsTargetPos:=3;
         end;
      end;
      if ((TEDAmperage>=600)and(TEDAmperage<700)) or ((EDTAmperage>=600)and(EDTAmperage<700)) then begin
         if (PrevTEDAmperage<600)or(PrevTEDAmperage>=700)or(PrevEDTAmperage<600)or(PrevEDTAmperage>=700) then begin
            UnipulsTargetPos:=4;
         end;
      end;
      if ((TEDAmperage>=700)and(TEDAmperage<800)) or ((EDTAmperage>=700)and(EDTAmperage<800)) then begin
         if (PrevTEDAmperage<700)or(PrevTEDAmperage>=800)or(PrevEDTAmperage<700)or(PrevEDTAmperage>=800) then begin
            UnipulsTargetPos:=5;
         end;
      end;
      if ((TEDAmperage>=800)and(TEDAmperage<900)) or ((EDTAmperage>=800) and (EDTAmperage<900)) then begin
         if (PrevTEDAmperage<800)or(PrevTEDAmperage>=900)or(PrevEDTAmperage<800)or(PrevEDTAmperage>=900) then begin
            UnipulsTargetPos:=6;
         end;
      end;
      if ((TEDAmperage>=900)and(TEDAmperage<1000)) or ((EDTAmperage>=900) and (EDTAmperage<1000)) then begin
         if (PrevTEDAmperage<900)or(PrevTEDAmperage>=1000)or(PrevEDTAmperage<900)or(PrevEDTAmperage>=1000) then begin
            UnipulsTargetPos:=7;
         end;
      end;
      if ((TEDAmperage>=1000)and(TEDAmperage<1200)) or ((EDTAmperage>=1000) and (EDTAmperage<1200)) then begin
         if (PrevTEDAmperage<1000)or(PrevTEDAmperage>=1200)or(PrevEDTAmperage<1000)or(PrevEDTAmperage>=1200) then begin
            UnipulsTargetPos:=8;
         end;
      end;
      if ((PrevTEDAmperage<1200) and (TEDAmperage>=1200)) or
         ((PrevEDTAmperage<1200) and (EDTAmperage>=1200)) then begin
         UnipulsTargetPos:=10;
      end;
      if ((PrevTEDAmperage>0) and (TEDAmperage=0) and (EDTAmperage=0)) then begin
         UnipulsFaktVol := FormMain.trcBarVspomMahVol.Position; UnipulsTargetVol:=0; isStopUnipuls:=True;
      end;
      if ((TEDAmperage=0) and (FormMain.TimerPerehodUnipulsSwitch.Enabled = False) and (isStopUnipuls=False) and (EDTAmperage=0)) then begin
         BASS_ChannelStop(Unipuls_Channel[0]); BASS_StreamFree(Unipuls_Channel[0]);
         BASS_ChannelStop(Unipuls_Channel[1]); BASS_StreamFree(Unipuls_Channel[1]);
         BASS_ChannelRemoveSync(Unipuls_Channel[0], BASS_SYNC_END);
         BASS_ChannelRemoveSync(Unipuls_Channel[1], BASS_SYNC_END);
         UnipulsChanNum:=0; UnipulsFaktPos:=0; UnipulsTargetPos:=0;
      end;

      if (FormMain.TimerPerehodUnipulsSwitch.Enabled = False) and (UnipulsFaktPos<>UnipulsTargetPos) then begin
         if UnipulsFaktPos < UnipulsTargetPos then begin Inc(UnipulsFaktPos); end;
         if UnipulsFaktPos > UnipulsTargetPos then begin Dec(UnipulsFaktPos); end;

         If UnipulsFaktPos = 0 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '50-300 A.wav')), True); end;
         If UnipulsFaktPos = 1 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '300-400 A.wav')), True); end;
         If UnipulsFaktPos = 2 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '400-500 A.wav')), True); end;
         If UnipulsFaktPos = 3 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '500-600 A.wav')), True); end;
         If UnipulsFaktPos = 4 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '600-700 A.wav')), True); end;
         If UnipulsFaktPos = 5 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '700-800 A.wav')), True); end;
         If UnipulsFaktPos = 6 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '800-900 A.wav')), True); end;
         If UnipulsFaktPos = 7 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '900-1000 A.wav')), True); end;
         If UnipulsFaktPos = 8 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '1000-1200 A.wav')), True); end;
         If UnipulsFaktPos = 10 then begin
            TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '1200-~.wav')), True); end;
      end;
   end;

end.
