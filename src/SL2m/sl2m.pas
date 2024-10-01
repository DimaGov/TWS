unit sl2m;

interface

type sl2m_ = class (TObject)
    private
      soundDir:    String;

      PrevKeyTAB:  Byte;
    protected

    public
      procedure step();

    published

    constructor Create(soundDir_: String);

   end;

implementation

uses Bass,SoundManager,UnitMain,Windows, SysUtils;

   // ----------------------------------------------------
   // Конструктор скоростемера 3СЛ2м
   // ----------------------------------------------------
   constructor sl2m_.Create(soundDir_: String);
   begin
      soundDir := soundDir_;
   end;

   // ----------------------------------------------------
   // Один "шаг" скоростемера 3СЛ2м
   // ----------------------------------------------------
   procedure sl2m_.step();
   begin
      // Звук тиканья часового механизма 3СЛ2м на стоянке
      //if ((Speed<=0) and (PrevSpeed_Fakt>0)) or ((Speed>2) and (PrevSpeed_Fakt<=2)) then Timer3SL2m_3Sec.Enabled := True;
      //if BASS_ChannelIsActive(ClockChannel)=0 then isPlayClock:=False;
      //if (PrevConMem=True) and (isConnectedMemory=False) then begin BASS_ChannelStop(ClockChannel); BASS_StreamFree(ClockChannel); end;

      if Speed > 2 then begin
         if (PrevSpeed_Fakt <= 2) Or (BASS_ChannelIsActive(ClockChannel)+BASS_ChannelIsActive(ClockCycleChannel) = 0) then begin
            ClockF := StrNew(PChar(soundDir + 'sl2m_start.wav'));
            ClockCycleF := StrNew(PChar(soundDir + 'sl2m_loop.wav'));
            isPlayClock := False;
         end;
      end;
      if Speed <= 2 then begin
         if (PrevSpeed_Fakt > 2) Or (BASS_ChannelIsActive(ClockChannel)+BASS_ChannelIsActive(ClockCycleChannel) = 0) then begin
            if PrevSpeed_Fakt > 2 then begin
               ClockF := StrNew(PChar(soundDir + 'sl2m_stop.wav'));
               isPlayClock := False;
            end else
               isPlayCycleClock := False;
            ClockCycleF := StrNew(PChar(soundDir + 'sl2m_clock.wav'));
         end;
      end;

      ClockRemaindTimeCheck();

      // Звук протяжки ленты по нажатию кл. <TAB>
      if getasynckeystate(9)<>0 then begin
         if (PrevKeyTAB=0) and (GetAsyncKeyState(56)=0) then begin
            isPlayBeltPool:=False;
            PrevKeyTAB := 1;
         end;
      end else begin
         PrevKeyTAB:=0;
         BASS_SampleStop(BeltPool_Channel); BASS_StreamFree(BeltPool_Channel);
      end;
   end;

end.
