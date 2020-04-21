unit ED4M;

interface

type ed4m_ = class (TObject)
    private
      soundDir: String;

      procedure bv_step();
      procedure ept_step();
      procedure mk_step();
      procedure sinxrom_step();
      procedure door_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, SysUtils, soundManager, Bass;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor ed4m_.Create;
   begin
      soundDir := 'TWS\ED4M\';
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed4m_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         mk_step();
         sinxrom_step();
         door_step();
      end;

      if FormMain.cbCabinClicks.Checked = True then begin
         bv_step();
         ept_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed4m_.door_step();
   var
      St: String;
   begin
      if LocoNum >= 400 then St := 'CPPK_' else St:='';
      if LDOOR<>PrevLDOOR then begin
         if LDOOR =0 then TWS_PlayLDOOR(PChar(soundDir + St + 'doors_open.wav'));
         if LDOOR<>0 then TWS_PlayLDOOR(PChar(soundDir + St + 'doors_close.wav'));
      end;
      if RDOOR<>PrevRDOOR then begin
         if RDOOR =0 then TWS_PlayRDOOR(PChar(soundDir + St + 'doors_open.wav'));
         if RDOOR<>0 then TWS_PlayRDOOR(PChar(soundDir + St + 'doors_close.wav'));
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed4m_.bv_step();
   begin
      ;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed4m_.ept_step();
   begin
      ;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed4m_.mk_step();
   begin
      if AnsiCompareStr(CompressorCycleF, '') <> 0 then begin
          if (GetChannelRemaindPlayTime2Sec(Compressor_Channel) <= 0.8) and
             (BASS_ChannelIsActive(CompressorCycleChannel)=0)
          then isPlayCompressorCycle:=False;
      end;

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
   procedure ed4m_.sinxrom_step();
   begin
      ;
   end;

end.
 