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

    constructor Create(soundDir_: String);

   end;

implementation

   uses UnitMain, soundManager, Windows, SysUtils;

   // ----------------------------------------------------
   // Конструктор 21KR
   // ----------------------------------------------------
   constructor KR21_.Create(soundDir_: String);
   begin
      soundDir := soundDir_;
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
               CabinClicksF := StrNew(PChar(soundDir + '0_+1.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyA := 1;
         end;

         // -/- A [РћРўРџ] -/- //
         if (getasynckeystate(65) = 0) and (PrevKeyA <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '+1_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'A';
         end;

         // -/- D -/- //
         if (getasynckeystate(68) <> 0) and (PrevKeyD = 0) then begin
            if KMPrevKey<>'E' then
               CabinClicksF := StrNew(PChar(soundDir + '0_-1.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyD := 1;
         end;

         // -/- D [РћРўРџ] -/- //
         if (getasynckeystate(68) = 0) and (PrevKeyD <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '-1_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'D';
         end;

         // -/- E -/- //
         if (getasynckeystate(69) <> 0) and (PrevKeyE = 0) then begin
            if KMPrevKey <> 'E' then
               SoundManager.CabinClicksF := StrNew(PChar(soundDir + '0_-A.wav'));
            isPlayCabinClicks := False;
            PrevKeyE := 1; KMPrevKey := 'E';
         end;

         // -/- Q -/- //
         if (getasynckeystate(81) <> 0) and (PrevKeyQ = 0) then begin
            if KMPrevKey<>'E' then
               CabinClicksF := StrNew(PChar(soundDir + '0_+A.wav'))
            else
               CabinClicksF := StrNew(PChar(soundDir + '-A_0.wav'));
            isPlayCabinClicks := False;
            PrevKeyQ := 1;
         end;

         // -/- Q [РћРўРџ] -/- //
         if (getasynckeystate(81) = 0) and (PrevKeyQ <> 0) then begin
            if KMPrevKey <> 'E' then begin
               CabinClicksF := StrNew(PChar(soundDir + '+A_0.wav'));
               isPlayCabinClicks := False;
            end;
            KMPrevKey := 'Q';
         end;
      end;

      if KM_OP <> Prev_KM_OP then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op.wav'));
         isPlayCabinClicks := False;
      end;

      (*if (KM_OP = 1) and (Prev_KM_OP = 0) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_0_1.wav'));
         isPlayCabinClicks := False;
      end;
      if (KM_OP = 2) and (Prev_KM_OP = 1) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_1_2.wav'));
         isPlayCabinClicks := False;
      end;
      if (KM_OP = 3) and (Prev_KM_OP = 2) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_2_3.wav'));
         isPlayCabinClicks := False;
      end;
      if (KM_OP = 4) and (Prev_KM_OP = 3) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_3_4.wav'));
         isPlayCabinClicks := False;
      end;
      if (KM_OP = 5) and (Prev_KM_OP = 4) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_4_5.wav'));
         isPlayCabinClicks := False;
      end;

      if (KM_OP = 0) and (Prev_KM_OP = 1) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_1_0.wav'));
         isPlayCabinClicks := False;
      end;
      if (KM_OP = 1) and (Prev_KM_OP = 2) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_2_1.wav'));
         isPlayCabinClicks := False;
      end;
      if (KM_OP = 2) and (Prev_KM_OP = 3) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_3_2.wav'));
         isPlayCabinClicks := False;
      end;
      if (KM_OP = 3) and (Prev_KM_OP = 4) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_4_3.wav'));
         isPlayCabinClicks := False;
      end;
      if (KM_OP = 4) and (Prev_KM_OP = 5) then begin
         CabinClicksF := StrNew(PChar(soundDir + 'op_5_4.wav'));
         isPlayCabinClicks := False;
      end;*)

      if getasynckeystate(65)=0 then PrevKeyA := 0; if getasynckeystate(68)=0 then PrevKeyD := 0;
      if getasynckeystate(69)=0 then PrevKeyE := 0; if getasynckeystate(81)=0 then PrevKeyQ := 0;
   end;

end.
