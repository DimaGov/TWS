unit CHS4T;

interface

uses KR21;

type chs4t_ = class (TObject)
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
   constructor CHS4T_.Create;
   begin
      soundDir := 'TWS\CHS4t\';

      kr21__ := kr21_.Create();
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4T_.step();
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
   procedure CHS4T_.em_latch_step();
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
   procedure CHS4T_.mk_step();
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
   procedure CHS4T_.vent_step();
   begin
      VentTDVol := FormMain.trcBarVspomMahVol.Position/100;

      if (Vent<>0) and (Prev_Vent=0) then begin
         VentTDF       := StrNew(PChar(soundDir + 'ventTD-start.wav'));
         VentCycleTDF  := StrNew(PChar(soundDir + 'ventTD-loop.wav'));
         XVentTDF      := StrNew(PChar(soundDir + 'x_ventTD-start.wav'));
         XVentCycleTDF := StrNew(PChar(soundDir + 'x_ventTD-loop.wav'));
         isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=False;
      end;
      if (Vent=0) and (Prev_Vent<>0) then begin
         VentTDF  := StrNew(PChar(soundDir + 'ventTD-stop.wav'));
         XVentTDF := StrNew(PChar(soundDir + 'x_ventTD-stop.wav'));
         VentCycleTDF:=PChar(''); XVentCycleTDF:=PChar('');
         isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=True;
      end;
      if TEDAmperage<700 then
         VentTDPitchDest := 0
      else
         if (LocoNum >= 608) Or (CHS4tVentNewSystemOnAllLocos = True) then
            VentTDPitchDest := 3
         else
            VentTDPitchDest := 0;
   end;

end.
 