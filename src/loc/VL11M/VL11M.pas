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
      ;
   end;

end.
 