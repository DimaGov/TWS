unit CHS8;

interface

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

      // Переменные для корректной работы унипульса //
      isLaunchedUnipuls:           Boolean; // Запущен ли унипульс?
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

      procedure kr21_step();
      procedure np22_step();
      procedure unipuls_step();

    published

    constructor Create;

   end;

implementation

uses UnitMain, SoundManager, Windows, Bass, SysUtils;

   // ----------------------------------------------------
   // Конструктор класса ЧС8
   // ----------------------------------------------------
   constructor CHS8_.Create;
   begin
      soundDir := 'TWS\CHS8\';
      unipulsDir := soundDir + 'Unipuls\';
   end;

   // ----------------------------------------------------
   // Контроллер 21KR
   // ----------------------------------------------------
   procedure chs8_.kr21_step();
   begin
      if KM_OP + getasynckeystate(16) = 0 then begin
         // -/- A -/- //
         if (getasynckeystate(65) <> 0) and (PrevKeyA = 0) then begin
            if KMPrevKey <> 'E' then
               CabinClicksF := StrNew(PChar(soundDir + '21KR_0_+.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '21KR_-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyA := 1;
         end;

         // -/- A [ОТП] -/- //
         if (getasynckeystate(65) = 0) and (PrevKeyA <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '21KR_+_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'A';
         end;

         // -/- D -/- //
         if (getasynckeystate(68) <> 0) and (PrevKeyD = 0) then begin
            if KMPrevKey<>'E' then
               CabinClicksF := StrNew(PChar(soundDir + '21KR_0_-.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '21KR_-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyD := 1;
         end;

         // -/- D [ОТП] -/- //
         if (getasynckeystate(68) = 0) and (PrevKeyD <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '21KR_-_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'D';
         end;

         // -/- E -/- //
         if (getasynckeystate(69) <> 0) and (PrevKeyE = 0) then begin
            if KMPrevKey <> 'E' then
               SoundManager.CabinClicksF := StrNew(PChar(soundDir + '21KR_0_-A.wav'));
            isPlayCabinClicks := False;
            PrevKeyE := 1; KMPrevKey := 'E';
         end;

         // -/- Q -/- //
         if (getasynckeystate(81) <> 0) and (PrevKeyQ = 0) then begin
            if KMPrevKey<>'E' then
               CabinClicksF := StrNew(PChar(soundDir + '21KR_0_+A.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '21KR_-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyQ := 1;
         end;

         // -/- Q [ОТП] -/- //
         if (getasynckeystate(81) = 0) and (PrevKeyQ <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '21KR_+A_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'Q';
         end;
      end;
      if getasynckeystate(65)=0 then PrevKeyA := 0; if getasynckeystate(68)=0 then PrevKeyD := 0;
      if getasynckeystate(69)=0 then PrevKeyE := 0; if getasynckeystate(81)=0 then PrevKeyQ := 0;
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
