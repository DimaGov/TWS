unit KR21;

interface

type kr21_ = class (TObject)
    private
      soundDir: String;

      // Переменные для контроллера KR21
      prevKeyA: Byte;
      prevKeyD: Byte;
      prevKeyQ: Byte;
      prevKeyE: Byte;
      KMPrevKey: String;
    protected

    public
      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, Windows, SysUtils;

   // ----------------------------------------------------
   // Конструктор 21KR
   // ----------------------------------------------------
   constructor KR21_.Create;
   begin
      soundDir := 'TWS\Devices\21KR\';
   end;

   // ----------------------------------------------------
   // Цикл 21KR
   // ----------------------------------------------------
   procedure KR21_.step();
   begin
      if KM_OP + getasynckeystate(16) = 0 then begin
         // -/- A -/- //
         if (getasynckeystate(65) <> 0) and (PrevKeyA = 0) then begin
            if KMPrevKey <> 'E' then
               CabinClicksF := StrNew(PChar(soundDir + '21KR_0_+.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '21KR_-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyA := 1;
         end;

         // -/- A [РћРўРџ] -/- //
         if (getasynckeystate(65) = 0) and (PrevKeyA <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '21KR_+_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'A';
         end;

         // -/- D -/- //
         if (getasynckeystate(68) <> 0) and (PrevKeyD = 0) then begin
            if KMPrevKey<>'E' then
               CabinClicksF := StrNew(PChar(soundDir + '21KR_0_-.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '21KR_-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyD := 1;
         end;

         // -/- D [РћРўРџ] -/- //
         if (getasynckeystate(68) = 0) and (PrevKeyD <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '21KR_-_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'D';
         end;

         // -/- E -/- //
         if (getasynckeystate(69) <> 0) and (PrevKeyE = 0) then begin
            if KMPrevKey <> 'E' then
               SoundManager.CabinClicksF := StrNew(PChar(soundDir + '21KR_0_-A.wav'));
            isPlayCabinClicks := False;
            PrevKeyE := 1; KMPrevKey := 'E';
         end;

         // -/- Q -/- //
         if (getasynckeystate(81) <> 0) and (PrevKeyQ = 0) then begin
            if KMPrevKey<>'E' then
               CabinClicksF := StrNew(PChar(soundDir + '21KR_0_+A.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '21KR_-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyQ := 1;
         end;

         // -/- Q [РћРўРџ] -/- //
         if (getasynckeystate(81) = 0) and (PrevKeyQ <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '21KR_+A_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'Q';
         end;
      end;
      if getasynckeystate(65)=0 then PrevKeyA := 0; if getasynckeystate(68)=0 then PrevKeyD := 0;
      if getasynckeystate(69)=0 then PrevKeyE := 0; if getasynckeystate(81)=0 then PrevKeyQ := 0;
   end;

end.
