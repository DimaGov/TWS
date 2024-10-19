unit ES5K;

interface

   uses VR242;

type es5k_ = class (TObject)
    private
      soundDir: String;

      vr242__: vr242_;

      procedure mk_step();
      procedure vent_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, SysUtils, soundManager, Windows, Bass;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor ES5K_.Create;
   begin
      soundDir := 'TWS\2ES5K\';

      vr242__ := vr242_.Create(False);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ES5K_.step();
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
   procedure ES5K_.mk_step();
   begin
      ComprRemaindTimeCheck();

      if Compressor<>Prev_Compressor then begin
         if Compressor<>0 then begin
            CompressorF      := StrNew(PChar(SoundDir + 'mk-start.wav'));
            CompressorCycleF := StrNew(PChar(SoundDir + 'mk-loop.wav'));
            isPlayCompressor := False;
         end else begin
            CompressorF  := StrNew(PChar(soundDir + 'mk-stop.wav'));
            CompressorCycleF := PChar('');
            isPlayCompressor := False;
         end;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ES5K_.vent_step();
   begin
      VentRemaindTimeCheck();

      if (GetAsyncKeyState(16) <> 0) then begin
         if GetAsyncKeyState(70)<>0 then begin Vent := 1; VentVolume:=100;end;
         if GetAsyncKeyState(82)<>0 then begin Vent2:= 1; VentVolume:=50; end;
      end else begin
         if GetAsyncKeyState(70)<>0 then begin Vent := 0; VentVolume:=100;end;
         if GetAsyncKeyState(82)<>0 then begin Vent2:= 0; VentVolume:=50; end;
      end;
      if (Vent + Vent2 > 0) and (BV = 1)then begin
         if ((BASS_ChannelIsActive(Vent_Channel_FX) = 0) And (BASS_ChannelIsActive(VentCycle_Channel_FX) = 0)) Or
            ((Vent = 1) and (Prev_Vent = 0)) Or ((Vent2 = 1) and (Prev_Vent2 = 0)) then begin
               isPlayVent := False; StopVent := False;
         end;

         if Vent2=1 then CycleVentVolume:=50 else begin
            if Vent=1 then CycleVentVolume:=100 else CycleVentVolume:=0;
         end;
      end;

      if (BV = 1) And (Vent+Vent2+Vent3 = -3) then begin
         Vent := 1; Vent2 := 1; Vent3 := 1;
      end;

      if BV = 0 then begin
         Vent := -1; Vent2 := -1;
      end; //else begin
         if (Vent + Vent2 <= 0) Or (Vent + Vent2 < Prev_Vent + Prev_Vent2) then begin
            if ((Vent <= 0) and (Prev_Vent = 1)) Or
               ((Vent2 <= 0) and (Prev_Vent2 = 1)) Or
               ((Vent + Vent2 <= 0) AND (BASS_ChannelIsActive(VentCycle_Channel_FX) <> 0))
            then begin
               if Vent2<>Prev_Vent2 then VentVolume:=50;
               if Vent <> Prev_Vent then VentVolume:=100;
               if BASS_ChannelIsActive(VentCycle_Channel_FX) <> 0 then begin
                  isPlayVent := False; StopVent := True;
               end;
            end;
         end;
      //end;
   end;

end.

