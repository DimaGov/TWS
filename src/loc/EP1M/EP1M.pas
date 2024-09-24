unit EP1M;

interface

type ep1m_ = class (TObject)
    private
      soundDir: String;

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
   constructor EP1M_.Create;
   begin
      soundDir := 'TWS\EP1M\';
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure EP1M_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         mk_step();
         vent_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure EP1M_.mk_step();
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
   procedure EP1M_.vent_step();
   begin
      VentRemaindTimeCheck();

      if (GetAsyncKeyState(16) <> 0) then begin
         if GetAsyncKeyState(70)<>0 then begin Vent := 1; VentVolume:=60; end;
         if GetAsyncKeyState(82)<>0 then begin Vent2:= 1; VentVolume:=75; end;
         if GetAsyncKeyState(55)<>0 then begin Vent3:= 1; VentVolume:=100;end;
      end else begin
         if GetAsyncKeyState(70)<>0 then begin Vent := 0; VentVolume:=60; end;
         if GetAsyncKeyState(82)<>0 then begin Vent2:= 0; VentVolume:=75; end;
         if GetAsyncKeyState(55)<>0 then begin Vent3:= 0; VentVolume:=100;end;
      end;

      if (Vent + Vent2 + Vent3 > 0) and (Voltage > 20) then begin
         if ((BASS_ChannelIsActive(Vent_Channel_FX) = 0) And (BASS_ChannelIsActive(VentCycle_Channel_FX) = 0)) Or
            ((Vent = 1) and (Prev_Vent = 0)) Or ((Vent2 = 1) and (Prev_Vent2 = 0)) Or ((Vent3 = 1) and (Prev_Vent3 = 0))
         then begin
            isPlayVent := False; StopVent := False;
         end;

         if Vent3=1 then CycleVentVolume:=100 else begin
            if Vent2=1 then CycleVentVolume:=75 else begin
               if Vent=1 then CycleVentVolume:=60 else CycleVentVolume:=0;
            end;
         end;
      end;

      if (Voltage < 20) then begin
         Vent := 0; Vent2 := 0; Vent3 := 0;
      end else begin
         if (Vent + Vent2 + Vent3 = 0) Or (Vent + Vent2 + Vent3 < Prev_Vent + Prev_Vent2 + Prev_Vent3) then begin
            if ((Vent = 0) and (Prev_Vent = 1)) Or
               ((Vent2 = 0) and (Prev_Vent2 = 1)) Or
               ((Vent3 = 0) and (Prev_Vent3 = 1)) Or
               ((Vent + Vent2 + Vent3 = 0) AND (BASS_ChannelIsActive(VentCycle_Channel_FX) <> 0))
            then begin
               if Vent3<>Prev_Vent3 then VentVolume:=100;
               if Vent2<>Prev_Vent2 then VentVolume:=75;
               if Vent <> Prev_Vent then VentVolume:=60;

               isPlayVent := False; StopVent := True;
            end;
         end;
      end;
   end;

end.
