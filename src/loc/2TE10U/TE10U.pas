unit TE10U;

interface

uses VR242, ExtCtrls;

type te10u_ = class (TObject)
    private
      soundDir: String;

      vr242__: vr242_;

      procedure pc_step(); // Поездные контактора
      procedure dizel_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, Bass, SysUtils, Math;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor TE10U_.Create;
   begin
      soundDir := 'TWS\2TE10U\';

      vr242__ := vr242_.Create(True);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure TE10U_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         vr242__.step();
         pc_step();
      end;

      if FormMain.cbTEDs.Checked = True then begin
         dizel_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure TE10U_.pc_step();
   begin
      if (KM_Pos_1 > 0) and (Prev_KMAbs = 0) then begin
         LocoPowerEquipmentF := StrNew(PChar(soundDir + 'pc_set.wav'));
         isPlayLocoPowerEquipment:=False;
      end;
      if (KM_Pos_1 = 0) and (Prev_KMAbs > 0) then begin
         LocoPowerEquipmentF := StrNew(PChar(soundDir + 'pc_reset.wav'));
         isPlayLocoPowerEquipment:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure TE10U_.dizel_step();
   begin
      // Условие проверки запуска дизеля
            if (BV<>0) or ((diesel2<>0) and (LocoSectionsNum=2)) then begin
               if PerehodDIZ = False then begin
                  if ((BV<>0) and (PrevBV=0)) or ((diesel2<>0) and (PrevDiesel2=0)) then Prev_Diz:=-1;	// Запуск дизеля
                  if (BV<>0) and (diesel2=0) then begin
                     if DizNow>KM_Pos_1 then Dec(DizNow);
                     if DizNow<KM_Pos_1 then Inc(DizNow);
                     //if DizNow <> KM_Pos_1 then DizNow := KM_Pos_1;
                  end else begin
                     if diesel2<>0 then begin
                        if DizNow>KM_Pos_2 then Dec(DizNow);
                        if DizNow<KM_Pos_2 then Inc(DizNow);
                        //if DizNow <> KM_Pos_2 then DizNow := KM_Pos_2;
                     end;
                  end;
                  dizF := PChar('TWS/'+LocoDIZNamePrefiks+'/diesel/x'+IntToStr(DizNow)+'.wav');
                  // Условие запуска нового/первого звука дизеля
                  if (DizNow<>Prev_Diz) or
                     ((BV+diesel2<>0) and (BASS_ChannelIsActive(DizChannel)+BASS_ChannelIsActive(DizChannel2) = 0))
                  then begin
                     isPlayDiz:=False; Prev_Diz:=DizNow; FormMain.TimerPerehodDizSwitch.Enabled:=True;
                  end;
               end;
            end;

            // Остановка звуков дизеля, если он заглушен в симуляторе
            if BV+diesel2=0 then begin
               if BASS_ChannelIsActive(TEDChannel_FX)<>0 then begin
                  BASS_ChannelStop(TEDChannel);  BASS_StreamFree(TEDChannel);
                  BASS_ChannelStop(TEDChannel_FX);  BASS_StreamFree(TEDChannel_FX);
               end;
               if BASS_ChannelIsActive(TEDChannel2)<>0 then begin
                  BASS_ChannelStop(TEDChannel2); BASS_StreamFree(TEDChannel2);
               end;
               if BASS_ChannelIsActive(DizChannel)<>0 then begin
                  BASS_ChannelStop(DizChannel);  BASS_StreamFree(DizChannel);
               end;
               if BASS_ChannelIsActive(DizChannel2)<>0 then begin
                  BASS_ChannelStop(DizChannel2); BASS_StreamFree(DizChannel2);
               end;
            end;
   end;

end.

