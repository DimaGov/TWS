unit VL11M;

interface

   uses VR242;

type vl11m_ = class (TObject)
    private
      soundDir: String;

      vr242__: vr242_;

      procedure bv_step();
      procedure mk_step();
      procedure vent_step();
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
   constructor vl11m_.Create;
   begin
      soundDir := 'TWS\VL11m\';

      vr242__ := vr242_.Create(False);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure vl11m_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         mk_step();
         vent_step();
      end;

      if FormMain.cbCabinClicks.Checked = True then begin
         vr242__.step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure vl11m_.bv_step();
   begin
      ;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure vl11m_.mk_step();
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
   procedure vl11m_.vent_step();
   begin
      VentRemaindTimeCheck();

      if Voltage < 1 then Vent := 0;
      if Vent = 2 then VentPitchDest := 3 else VentPitchDest := 0;

      if (Vent<>0) and (Prev_Vent=0) then begin
         if (BASS_ChannelIsActive(Vent_Channel_FX)<>0) and (StopVent = True) then begin
            BASS_ChannelStop(Vent_Channel_FX); BASS_StreamFree(Vent_Channel_FX);
            BASS_ChannelStop(XVent_Channel_FX); BASS_StreamFree(XVent_Channel_FX);
            //isPlayCycleVent := False; isPlayCycleVentX := False;
         end;
         if BASS_ChannelIsActive(VentCycle_Channel) = 0 then begin
            isPlayVent:=False; isPlayVentX:=False;
         end;
         StopVent:=False;
      end;
      if (Vent=0) and (Prev_Vent<>0) then begin
         StopVent:=True;
         isPlayVent:=False; isPlayVentX:=False; VentPitchDest := 0;
      end;
   end;

end.
 