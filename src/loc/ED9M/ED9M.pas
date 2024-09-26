unit ED9M;

interface

type ed9m_ = class (TObject)
    private
      soundDir: String;

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
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, SysUtils, soundManager, Bass, Windows;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor ed9m_.Create;
   begin
      soundDir := 'TWS\ED4m\';
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
      end;

      if FormMain.cbLocPerestuk.Checked = True then begin
         trog_step();
         prib_step();
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

end.

