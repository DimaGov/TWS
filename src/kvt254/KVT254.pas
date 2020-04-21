unit KVT254;

interface

type kvt254_ = class (TObject)
    private
      soundDir: String;

      TCIncrementer:               Byte;
      TCIncrementer2:              Byte;
      StopBrake254:                Boolean;

    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses Bass, soundManager, unitMain, SysUtils;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor kvt254_.Create;
   begin
      soundDir := 'TWS\Devices\kvt254\';
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure kvt254_.step();
   var
      Brake254TimeLeft: Single;
      singleTemp1: Single;
      singleTemp2: Single;
   begin
      if StopBrake254 = False then begin
         if BASS_ChannelIsActive(Brake254_Channel_FX[0]) <> 0 then begin
            Brake254TimeLeft := BASS_ChannelBytes2Seconds(Brake254_Channel_FX[0], BASS_ChannelGetLength(Brake254_Channel_FX[0], BASS_POS_BYTE) - BASS_ChannelGetPosition(Brake254_Channel_FX[0], BASS_POS_BYTE));
            if (Brake254TimeLeft <= 0.2) and (BASS_ChannelIsActive(Brake254_Channel_FX[1])=0) then isPlayCycleBrake254:=False;
         end;
      end;

      Inc(TCIncrementer2);
      if (TCIncrementer2 > Trunc(300/MainCycleFreq)) then begin
         singleTemp1 := TC - PrevTC;
         singleTemp2 := Abs(singleTemp1) * 4000;
         FormMain.Label1.Caption := FloatToStr(singleTemp2);
         TCIncrementer2 := 0;
      end;
      if Abs(singleTemp2) > 10 then begin
         TCIncrementer := 0;
         if (singleTemp1) < 0 then begin
            Brake254F := StrNew(PChar(soundDir + '254_vypusk_start.wav'));
            CycleBrake254F := StrNew(PChar(soundDir + '254_vypusk_loop.wav'));
         end else begin
            Brake254F := StrNew(PChar(soundDir + '254_vpusk_start.wav'));
            CycleBrake254F := StrNew(PChar(soundDir + '254_vpusk_loop.wav'));
         end;

         if (BASS_ChannelIsActive(Brake254_Channel_FX[1]) = 0) then begin
            if (BASS_ChannelIsActive(Brake254_Channel_FX[0]) = 0) Or
               ((BASS_ChannelIsActive(Brake254_Channel_FX[0])<> 0)And(StopBrake254=True)) then
            begin
               isPlayBrake254 := False;
               StopBrake254 := False;
            end;
         end;

         BASS_ChannelSetAttribute(Brake254_Channel_FX[0], BASS_ATTRIB_VOL, 0.3);
         BASS_ChannelSetAttribute(Brake254_Channel_FX[1], BASS_ATTRIB_VOL, 0.3);
      end else begin
         BASS_ChannelSetAttribute(Brake254_Channel_FX[0], BASS_ATTRIB_VOL, 0.3);
         Inc(TCIncrementer);
         if (TCIncrementer > Trunc(300/MainCycleFreq)) and (StopBrake254=False) then begin
            if (singleTemp1) < 0 then begin
               Brake254F := StrNew(PChar(soundDir + '254_vypusk_stop.wav'));
               CycleBrake254F := PChar('');
            end else begin
               Brake254F := StrNew(PChar(soundDir + '254_vpusk_stop'));
               CycleBrake254F := PChar('');
            end;
            isPlayBrake254 := False;
            StopBrake254 := True;
         end;
      end;
   end;

end.
 