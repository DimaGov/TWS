unit VL82M;

interface

type vl82m_ = class (TObject)
    private
      soundDir: String;

      procedure mk_step();
      procedure mv_step();
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
   constructor VL82M_.Create;
   begin
      soundDir := 'TWS\VL82m\';
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure VL82M_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         mk_step();
         mv_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure VL82M_.mk_step();
   begin
      ComprRemaindTimeCheck();

      if Compressor<>Prev_Compressor then begin
         if Compressor<>0 then begin
            CompressorF       := StrNew(PChar(soundDir + 'MK-start.wav'));
            CompressorCycleF  := StrNew(PChar(soundDir + 'MK-loop.wav'));
            isPlayCompressor:=False;
         end else begin
            CompressorF      := StrNew(PChar(soundDir + 'MK-stop.wav'));
            CompressorCycleF := PChar('');
            isPlayCompressor:=False;
         end;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure VL82M_.mv_step();
   begin
      VentRemaindTimeCheck();

      if (Vent<>0) and (Prev_Vent=0) then begin
         if (BASS_ChannelIsActive(Vent_Channel_FX)<>0) and (StopVent = True) then begin
            BASS_ChannelStop(Vent_Channel_FX); BASS_StreamFree(Vent_Channel_FX);
            isPlayCycleVent := False;
         end;

         StopVent:=False;
         isPlayVent:=False;
      end;
      if (Vent=0) and (Prev_Vent<>0) then begin
         StopVent:=True;
         isPlayVent:=False; VentPitchDest := 0;
      end;
   end;

end.

