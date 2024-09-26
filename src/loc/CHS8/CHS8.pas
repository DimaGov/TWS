unit CHS8;

interface

   uses KR21;

   type chs8_ = class (TObject)
    private
      soundDir: String;
      unipulsDir: String;

      VentStarted: Boolean;
      Vent2SecIncrementer: Integer;

      Unipuls2SecIncrementer: Integer;

      // ÐŸÐµÑ€ÐµÐ¼ÐµÐ½Ð½Ñ‹Ðµ Ð´Ð»Ñ ÐºÐ¾Ñ€Ñ€ÐµÐºÑ‚Ð½Ð¾Ð¹ Ñ€Ð°Ð±Ð¾Ñ‚Ñ‹ ÑƒÐ½Ð¸Ð¿ÑƒÐ»ÑŒÑÐ° //
      isLaunchedUnipuls:           Boolean; // Ð—Ð°Ð¿ÑƒÑ‰ÐµÐ½ Ð»Ð¸ ÑƒÐ½Ð¸Ð¿ÑƒÐ»ÑŒÑ?

      kr21__: kr21_;

      procedure np22_step();
      procedure unipuls_step();
      procedure bv_step();
      procedure vent_step();
      procedure mk_step();
      procedure em_latch_step();
      procedure reversor_step();
    protected

    public
      UnipulsChanNum:              Byte;
      UnipulsFaktVol:              Byte;
      UnipulsTargetVol:            Byte;
      isStartUnipuls:              Boolean; // Ð¤Ð»Ð°Ð³ Ð´Ð»Ñ Ð¿Ð»Ð°Ð²Ð½Ð¾Ð³Ð¾ Ð·Ð°Ð¿ÑƒÑÐºÐ° Ð£Ð½Ð¸Ð¿ÑƒÐ»ÑŒÑÐ°
      isStopUnipuls:               Boolean; // Ð¤Ð»Ð°Ð³ Ð´Ð»Ñ Ð¿Ð»Ð°Ð²Ð½Ð¾Ð¹ Ð¾ÑÑ‚Ð°Ð½Ð¾Ð²ÐºÐ¸ Ð£Ð½Ð¸Ð¿ÑƒÐ»ÑŒÑÐ°
      UnipulsFaktPos:              Integer;
      UnipulsTargetPos:            Integer;
      UnipulsVol1:                 Integer;
      Unipuls2SecWait: Boolean; //True - æäåì 2ñåêóíäû äî çàïóñêà óíèïóë
      Vent2SecWait: Boolean; //True - æäåì 2ñåêóíäû äî çàïóñêà âåíòèëÿòîðîâ

      procedure step();

    published

    constructor Create;

   end;

implementation

uses UnitMain, SoundManager, Windows, Bass, SysUtils, Math;

   // ----------------------------------------------------
   // ÐšÐ¾Ð½ÑÑ‚Ñ€ÑƒÐºÑ‚Ð¾Ñ€ ÐºÐ»Ð°ÑÑÐ° Ð§Ð¡8
   // ----------------------------------------------------
   constructor CHS8_.Create;
   begin
      soundDir := 'TWS\CHS8\';

      Vent2SecWait := True;
      Unipuls2SecWait := True;
      UnipulsTargetPos := -1;

      kr21__ := kr21_.Create('TWS\Devices\21KR\');
   end;

   // ----------------------------------------------------
   // 
   // ----------------------------------------------------
   procedure CHS8_.step();
   begin
      if (LocoNum > 0) And (LocoNum < 33) then unipulsDir := soundDir + 'E1/Unipuls/';
      if LocoNum >= 33 then unipulsDir := soundDir + 'E2/Unipuls/';

      if FormMain.cbCabinClicks.Checked = True then begin
         kr21__.step();
         em_latch_step();
         reversor_step();
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
   // ÐŸÐ½ÐµÐ²Ð¼Ð¾Ð´Ð²Ð¸Ð³Ð°Ñ‚ÐµÐ»ÑŒ 22NP
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
      // Ð“Ð’ Ð½Ð° Ð§Ð¡8
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
      ComprRemaindTimeCheck();

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
      if ((Prev_KMAbs=0) and (KM_Pos_1>0)) or ((KM_Pos_1>0) and (Prev_KMAbs=0)) Or ((KM_Pos_1 = 0) And ((Reostat>0) And (PrevReostat=0))) then begin
         IMRZashelka:=PChar('TWS\Devices\21KR\EM_zashelka_ON.wav'); isPlayIMRZachelka:=False;
      end;
      if ((Prev_KMAbs>0) and (KM_Pos_1=0)) or ((KM_Pos_1=0) and (Prev_KMAbs>0)) Or ((KM_Pos_1 = 0) And ((Reostat=0) And (PrevReostat>0))) then begin
         IMRZashelka:=PChar('TWS\Devices\21KR\EM_zashelka_OFF.wav'); isPlayIMRZachelka:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS8_.vent_step();
   begin
      VentTDRemaindTimeCheck();
      
      if VentStarted = False then begin
         VentTDF := StrNew(PChar(soundDir + 'vent.wav')); VentCycleTDF := StrNew(PChar(soundDir + 'vent.wav'));
         XVentTDF := StrNew(PChar(soundDir + 'x_vent.wav'));XVentCycleTDF:=StrNew(PChar(soundDir + 'x_vent.wav'));
         isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=False; VentStarted := True;
      end;

      if (KM_Pos_1 = 0) and (Prev_KMAbs > 0) then begin
         Vent2SecWait := True;
      end;

      //if KM_Pos_1 <> Prev_KMAbs then begin
      //   Vent2SecWait := True;
      //end;

      if (KM_Pos_1 > 0) and (Prev_KMAbs = 0) then begin
         Vent2SecWait := True;
      end;

      if Vent = 5 then begin VentTDPitchDest := -3; end;
      if Vent = 4 then begin VentTDPitchDest := 0; end;
      if Vent = 3 then begin VentTDPitchDest := -8; end;
      if Vent = 2 then begin VentTDPitchDest := -8; end;
      if Vent = 1 then begin
         if Vent2SecWait = True then begin
            Inc(Vent2SecIncrementer);
            //LocoWithMVTDPitch := False;
            if Vent2SecIncrementer > 4000/MainCycleFreq then begin
               Vent2SecWait := False;
               Vent2SecIncrementer := 0;
               //LocoWithMVTDPitch := True;
            end;
         end;
         if (Vent2SecWait = False) then begin
            if TEDAmperage>0 then VentTDPitchDest := (Tanh(TEDAmperage/450)*20)-20;
            if EDTAmperage>0 then VentTDPitchDest := (Tanh(EDTAmperage/450)*20)-20;
         end;
      end;
      VentTDVolDest := power((VentTDPitch+20)/20, 0.5) * (FormMain.trcBarVspomMahVol.Position/100);
      if VentTDVol > VentTDVolDest then VentTDVol := VentTDVol - 0.01 * MainCycleFreq;
      if VentTDVol < VentTDVolDest then VentTDVol := VentTDVol + 0.01 * MainCycleFreq;
      if Vent = 0 then begin
         VentTDPitchDest := -20;
         if VentTDPitch < -19 then VentTDVol := 0.0; // Ïîëíàÿ îñòàíîâêà âåíòèëÿòîðîâ
      end;
   end;

   // ----------------------------------------------------
   // Ð£Ð½Ð¸Ð¿ÑƒÐ»ÑŒÑ
   // ----------------------------------------------------
   procedure CHS8_.unipuls_step();
   begin
      if (Vent <> 2) And (Vent <> 3) And (Vent <> 4) then begin
      if ((PrevTEDAmperage<>0) and (TEDAmperage=0)) or
         ((PrevEDTAmperage<>0) and (EDTAmperage=0)) then begin
         UnipulsTargetPos:=-1; //UnipulsFaktPos:=-1;
      end;
      if ((PrevTEDAmperage=0) and (TEDAmperage>0)) or
         ((PrevEDTAmperage=0) and (EDTAmperage>0)) then begin
         //TWS_PlayUnipuls(StrNew(PChar(unipulsDir + '50-300 A.wav')), True);
         UnipulsTargetPos:=0;
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
         //UnipulsTargetPos:=10;
      end;
      if ((PrevTEDAmperage>0) and (TEDAmperage=0) and (EDTAmperage=0)) then begin
         UnipulsFaktVol := FormMain.trcBarVspomMahVol.Position; UnipulsTargetVol:=0; isStopUnipuls:=True;
      end;
      if ((TEDAmperage=0) and (FormMain.TimerPerehodUnipulsSwitch.Enabled = False) and (isStopUnipuls=False) and (EDTAmperage=0) and (UnipulsFaktPos = -1)) then begin
      //if ((TEDAmperage=0) and (FormMain.TimerPerehodUnipulsSwitch.Enabled = False) and (EDTAmperage=0)) then begin
         BASS_ChannelStop(Unipuls_Channel[0]); BASS_StreamFree(Unipuls_Channel[0]);
         BASS_ChannelStop(Unipuls_Channel[1]); BASS_StreamFree(Unipuls_Channel[1]);
         BASS_ChannelRemoveSync(Unipuls_Channel[0], BASS_SYNC_END);
         BASS_ChannelRemoveSync(Unipuls_Channel[1], BASS_SYNC_END);
         UnipulsChanNum:=0; //UnipulsFaktPos:=-1;
         UnipulsTargetPos:=-1;
      end;

      if (KM_Pos_1 = 0) and (Prev_KMAbs > 0) then begin
         Unipuls2SecWait := True;
      end;
      if (KM_Pos_1 > 0) and (Prev_KMAbs = 0) then begin
         Unipuls2SecWait := True;
      end;
      end;

      if Vent = 0 then begin
         if UnipulsTargetPos <> -1 then UnipulsTargetPos := -1;
         if UnipulsFaktPos = -1 then Unipuls2SecWait := True;
      end;
      if (Vent = 2) And (UnipulsFaktPos <> 3) then begin (*UnipulsFaktPos := 2;*) UnipulsTargetPos := 3; Unipuls2SecWait := False; end;
      if (Vent = 3) And (UnipulsFaktPos <> 3) then begin (*UnipulsFaktPos := 2;*) UnipulsTargetPos := 3; Unipuls2SecWait := False; end;
      if (Vent = 4) And (UnipulsFaktPos <> 8) then begin (*UnipulsFaktPos := 7;*) UnipulsTargetPos := 8; Unipuls2SecWait := False; end;

      if Unipuls2SecWait = True then begin
         if (TEDAmperage+EDTAmperage>0) Or (Vent = 2) Or (Vent = 3) Or (Vent = 4) then begin
            Inc(Unipuls2SecIncrementer);
            if Unipuls2SecIncrementer > 2000/MainCycleFreq then begin
               Unipuls2SecWait := False;
               Unipuls2SecIncrementer := 0;
            end;
         end;
      end;

      if (FormMain.TimerPerehodUnipulsSwitch.Enabled = False) and (UnipulsFaktPos<>UnipulsTargetPos) And (Unipuls2SecWait = False) then begin
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

   // ----------------------------------------------------
   //  PEBEPCOPbl
   // ----------------------------------------------------
   procedure CHS8_.reversor_step();
   var
      local_str: string;
   begin
      if (LocoNum > 0) and (LocoNum < 33) then local_str := 'E1';
      if LocoNum >= 33 then local_str := 'E2';

      if KM_Pos_1=0 then begin
         if (PrevKeyW=0) and (GetAsyncKeyState(87)<>0) then begin
            CabinClicksF := StrNew(PChar(soundDir + local_str + '\revers.wav'));
            isPlayCabinClicks:=False; PrevKeyW:=1;
         end;

         if (PrevKeyS=0) and (GetAsyncKeyState(83)<>0) then begin
            CabinClicksF := StrNew(PChar(soundDir + local_str + '\revers.wav'));
            isPlayCabinClicks:=False; PrevKeyS:=1;
         end;
      end;

      if GetAsyncKeyState(83)=0 then PrevKeyS:=0; if GetAsyncKeyState(87)=0 then PrevKeyW:=0;
   end;

end.
