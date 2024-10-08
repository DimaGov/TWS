unit ED9M;

interface

   uses VR242;

type ed9m_ = class (TObject)
    private
      soundDir: String;

      vr242__: vr242_;

      PrevKeyKKR:      Byte;

      // Тумблера
      procedure bv_step();
      procedure ept_step();
      procedure hLights_step();
      procedure trolleyClick_step();
      procedure reversor_step();
      // Комбинированый кран
      procedure combCrane_step();
      // Вспом. машины
      procedure mk_step();
      procedure trans_step();
      procedure trolley_step();
      procedure door_step();
      // Звуки прибытия-отправления
      procedure prib_step();
      procedure trog_step();
      // ТЭД - ЭДТ
      procedure ted_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, SysUtils, soundManager, Bass, Windows, Math, bass_fx;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor ed9m_.Create;
   begin
      soundDir := 'TWS\ED4m\';

      vr242__ := vr242_.Create(False);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         mk_step();
         trans_step();
         trolley_step();
         door_step();
      end;

      if FormMain.cbCabinClicks.Checked = True then begin
         bv_step();
         ept_step();
         hLights_step();
         trolleyClick_step();
         combCrane_step();
         reversor_step();
         vr242__.step();
      end;

      if FormMain.cbLocPerestuk.Checked = True then begin
         trog_step();
         prib_step();
      end;

      if FormMain.cbTEDs.Checked = True then begin
         ted_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.trog_step();
   var
      J: Integer;
   begin
      if (Acceleretion>0) and (PrevAcceleretion=0) and (Speed<1) then begin
         J:=Random(9);
         TrogF := StrNew(PChar(soundDir + 'Stuk-Trog/Stuk-Trog-I-'+IntToStr(J)+'.wav'));
         isPlayTrog:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.prib_step();
   begin
      if (Speed=0) and (PrevSpeed_Fakt<>0) and (Acceleretion<=-0.6) then begin
         TrogF := StrNew(PChar(soundDir + 'prib.wav'));
         isPlayTrog:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.door_step();
   begin
      if LDOOR<>PrevLDOOR then begin
         if LDOOR =0 then TWS_PlayLDOOR(PChar(soundDir + 'doors_open.wav'));
         if LDOOR<>0 then TWS_PlayLDOOR(PChar(soundDir + 'doors_close.wav'));
      end;
      if RDOOR<>PrevRDOOR then begin
         if RDOOR =0 then TWS_PlayRDOOR(PChar(soundDir + 'doors_open.wav'));
         if RDOOR<>0 then TWS_PlayRDOOR(PChar(soundDir + 'doors_close.wav'));
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.combCrane_step();
   begin
      if PrevKeyKKR = 0 then begin
         if GetAsyncKeyState(76) <> 0 then begin
            IMRZashelka:=PChar('TWS/TM_Kran.wav'); isPlayIMRZachelka:=False; PrevKeyKKR:=1;
         end;
      end else begin
         if (GetAsyncKeyState(16)=0) and (GetAsyncKeyState(76)=0) then PrevKeyKKR:=0;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.bv_step();
   begin
      if BV <> PrevBV then begin
         LocoPowerEquipmentF := StrNew(PChar(soundDir + 'tumbler.wav'));
         isPlayLocoPowerEquipment:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.trolley_step();
   begin
      if FrontTP<>PrevFrontTP then begin
         if FrontTP=1 then FTPF := StrNew(PChar(soundDir + 'TPUp.wav'));
         if FrontTP=0 then FTPF := StrNew(PChar(soundDir + 'TPDown.wav'));
         isPlayFTP:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.trolleyClick_step();
   begin
      if FrontTP <> PrevFrontTP then begin
         LocoPowerEquipmentF := StrNew(PChar(soundDir + 'tumbler.wav'));
         isPlayLocoPowerEquipment:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.ept_step();
   begin
      if EPT <> PrevEPT then begin
         LocoPowerEquipmentF := StrNew(PChar(soundDir + 'tumbler.wav'));
         isPlayLocoPowerEquipment:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.hLights_step();
   begin
      if Highlights<>PrevHighLights then begin
         LocoPowerEquipmentF := StrNew(PChar(soundDir + 'vkl.wav'));
         isPlayLocoPowerEquipment := False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.mk_step();
   begin
      if BV+FrontTP+Compressor>2 then Compressor:=1 else Compressor:=0;

      ComprRemaindTimeCheck();

      if Compressor<>Prev_Compressor then begin
         if Compressor<>0 then begin
            CompressorF      := StrNew(PChar(SoundDir + 'compr_start.wav'));
            CompressorCycleF := StrNew(PChar(SoundDir + 'compr_loop.wav'));
            isPlayCompressor := False;
         end else begin
            CompressorF  := StrNew(PChar(soundDir + 'compr_stop.wav'));
            CompressorCycleF := PChar('');
            isPlayCompressor := False;
         end;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.trans_step();
   begin
      if BV+FrontTP>1 then Vent:=1 else Vent:=0;

      VentRemaindTimeCheck();

      if (Vent<>0) and (Prev_Vent=0) then begin
         if (BASS_ChannelIsActive(Vent_Channel_FX)<>0) and (StopVent = True) then begin
            BASS_ChannelStop(Vent_Channel_FX); BASS_StreamFree(Vent_Channel_FX);
            BASS_ChannelStop(XVent_Channel_FX); BASS_StreamFree(XVent_Channel_FX);
            isPlayCycleVent := False; isPlayCycleVentX := False;
         end;
         StopVent:=False;
         isPlayVent:=False; isPlayVentX:=False;
      end;
      if (Vent=0) and (Prev_Vent<>0) then begin
         StopVent:=True;
         isPlayVent:=False; isPlayVentX:=False; VentPitchDest := 0;
      end;
   end;

   // ----------------------------------------------------
   //  PEBEPCOPbl
   // ----------------------------------------------------
   procedure ed9m_.reversor_step();
   var
      local_str: String;
   begin
      if ReversorPos <> PrevReversorPos then begin
         CabinClicksF := StrNew(PChar(soundDir + 'CPPK_revers.wav'));
         isPlayCabinClicks:=False;
      end;
   end;

   // ----------------------------------------------------
   //  Motor
   // ----------------------------------------------------
   procedure ed9m_.ted_step();
   var
      VolumeLimit: Single;
   begin
      VolumeLimit := FormMain.trcBarTedsVol.Position / 100;

      if BASS_ChannelIsActive(ReduktorChannel_FX)=0 then begin
         ReduktorF := PChar(soundDir + 'ted_vibeg.wav');
         isPlayReduktor:=False;
      end;

      if Speed>0 then begin
         if KM_Pos_1 >= 1 then begin

            TEDVlmDest := SimpleRoundTo(abs(Acceleretion)*1.5, -2);

            if TEDVlmDest > VolumeLimit then TEDVlmDest := VolumeLimit;

            if isCameraInCabin = True then TEDVlmDest := TEDVlmDest * 0.6;

            if (KM_Pos_1>0) and (KM_Pos_1<32768) then begin
               BASS_ChannelSetAttribute(TEDChannel_FX, BASS_ATTRIB_REVERSE_DIR, 1);  // Motor-accelerating
            end;
            if KM_Pos_1>32768 then begin
               BASS_ChannelSetAttribute(TEDChannel_FX, BASS_ATTRIB_REVERSE_DIR, -1); // Motor-braking
            end;

         end else TEDVlmDest := 0.0;

         if isCameraInCabin = False then begin
            ReduktorVolume := Speed / 80;
            //ReduktorPitch := (Tanh(Speed/70)*21) - 23;
            ReduktorPitch := (Tanh(Speed/70)*21) - 19.5;
            if ReduktorVolume > VolumeLimit then ReduktorVolume := VolumeLimit;
         end;
         if (PrevisCameraInCabin = False) And (isCameraInCabin = True) then begin
            if MVPSTedInCabin = True then TEDVlm := TEDVlmDest;
            ReduktorVolume := 0.0;
         end;
         if (PrevisCameraInCabin = True) And (isCameraInCabin = False) And (MVPSTedInCabin = False) then begin
            TEDVlm := TEDVlmDest;
         end;
         if (isCameraInCabin = True) And (MVPSTedInCabin = False) then begin
            TEDVlm := 0.0;
         end;
      end else begin TEDVlm := 0.0; TEDVlmDest := 0.0; end;

      TEDPitchDest := (Tanh(Speed/70)*21) - 23; //(tanh(x/35)*10)-8
      if TEDVlm < TEDVlmDest then TEDVlm := TEDVlm + 0.01;
      if TEDVlm > TEDVlmDest then TEDVlm := TEDVlm - 0.01;
      if TEDVlm < 0 then TEDVlm := 0.0;
   end;

end.

