unit CHS4;

// CHS4 - AKVARIUM

interface

uses KR21, KVT254, VR242, ExtCtrls;

type TTimerEvents = class
    public

      procedure OnTimer(Sender: TObject);
      
    end;

type chs4_ = class (TObject)
    private
      soundDir: String;

      CompressorDifferenceTimer: TTimer;
      CompressorDifferenceTimerEvents: TTimerEvents;

      PrevGR_chs4: Double;

      kr21__: kr21_;
      kvt254__: kvt254_;
      vr242__: vr242_;

      procedure vent_step();
      procedure mk_step();
      procedure em_latch_step();
      procedure reversor_step();
      procedure np22_step();
    protected

    public

      CompressorGRDifference: Double;

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, Bass, SysUtils, Math;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor CHS4_.Create;
   begin
      soundDir := 'TWS\CHS4KVR\';

      // Создаем таймер для проверки разницы показаний давления ГР в промежутке времени
      CompressorDifferenceTimer := TTimer.Create(UnitMain.FormMain);
      CompressorDifferenceTimer.Interval := 600;
      CompressorDifferenceTimer.OnTimer := CompressorDifferenceTimerEvents.OnTimer;
      CompressorDifferenceTimer.Enabled := True;

      kr21__ := kr21_.Create('TWS\Devices\21KR\');
      kvt254__ := kvt254_.Create();
      vr242__ := vr242_.Create();
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         vent_step();
         mk_step();
         //kvt254__.step();
         np22_step();
      end;

      if FormMain.cbCabinClicks.Checked = True then begin
         kr21__.step();
         em_latch_step();
         vr242__.step();
         reversor_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4_.em_latch_step();
   begin
      if ((Prev_KMAbs=0) and (KM_Pos_1>0)) or ((KM_Pos_1>0) and (Prev_KMAbs=0)) then begin
         IMRZashelka:=PChar('TWS\Devices\21KR\EM_zashelka_ON.wav'); isPlayIMRZachelka:=False;
      end;
      if ((Prev_KMAbs>0) and (KM_Pos_1=0)) or ((KM_Pos_1=0) and (Prev_KMAbs>0)) then begin
         IMRZashelka:=PChar('TWS\Devices\21KR\EM_zashelka_OFF.wav'); isPlayIMRZachelka:=False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4_.np22_step();
   begin
      if KM_Pos_1 > Prev_KMAbs then begin
         if KM_pos_1 mod 2 = 0 then
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'np22/22NP_nabor_2.wav'))
         else
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'np22/22NP_nabor_1.wav'));
         isPlayLocoPowerEquipment := False;
      end;
      if KM_Pos_1 < Prev_KMAbs then begin
         if KM_Pos_1 mod 2 = 0 then
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'np22/22NP_sbros_2.wav'))
         else
            LocoPowerEquipmentF := StrNew(PChar(soundDir + 'np22/22NP_sbros_1.wav'));
         isPlayLocoPowerEquipment := False;
      end;
      if KM_OP > Prev_KM_OP then begin
         LocoPowerEquipmentF := StrNew(PChar(soundDir + 'np22/22NP_op_plus.wav'));
         isPlayLocoPowerEquipment := False;
      end;
      if KM_OP < Prev_KM_OP then begin
         LocoPowerEquipmentF := StrNew(PChar(soundDir + 'np22/22NP_op_minus.wav'));
         isPlayLocoPowerEquipment := False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure TTimerEvents.OnTimer(Sender: TObject);
   begin
      CHS4__.CompressorGRDifference := GR-CHS4__.PrevGR_chs4;
      if CHS4__.CompressorGRDifference >= 0.015 then begin
         Compressor := 1;
      end;

      if CHS4__.CompressorGRDifference <= 0 then begin
         if GRIncrementer > 2 then begin
            Compressor := 0;
            GRIncrementer := 0;
         end;

         Inc(GRIncrementer);
      end;

      CHS4__.PrevGR_chs4 := GR;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4_.mk_step();
   begin
      if Voltage < 1.0 then Compressor := 0;

      ComprRemaindTimeCheck();

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
   procedure CHS4_.vent_step();
   begin
      VentRemaindTimeCheck();
      VentTDRemaindTimeCheck();

      if Vent<>Prev_Vent then begin
      
         VentTDVol := FormMain.trcBarVspomMahVol.Position / 100;

         if Vent=62 then begin
            VentTDF       := StrNew(PChar(soundDir + 'ventTD-start.wav'));
            VentCycleTDF  := StrNew(PChar(soundDir + 'ventTD.wav'));
            XVentTDF      := StrNew(PChar(soundDir + 'x_ventTD-start.wav'));
            XVentCycleTDF := StrNew(PChar(soundDir + 'x_ventTD.wav'));
            isPlayVentTD:=False;
            isPlayVentTDX:=False;
            StopVent:=False; isPlayVent:=False; isPlayVentX:=False;

            if KM_Pos_1 >= 2 then begin
               VentPitchDest:=-0.75;
            end else begin
               VentPitchDest:=0;
            end;
         end;

         if Vent=0 then begin
            if (BASS_ChannelIsActive(Vent_Channel_FX)<>0) or (BASS_ChannelIsActive(VentCycle_Channel_FX)<>0) then begin
               StopVent:=True; isPlayVent:=False; isPlayVentX:=False; VentPitchDest:=0;
            end;
            if (BASS_ChannelIsActive(VentTD_Channel)<>0) or (BASS_ChannelIsActive(VentCycleTD_Channel)<>0) then begin
               VentTDF  := StrNew(PChar(soundDir + 'ventTD-stop.wav'));
               VentCycleTDF:=PChar(''); isPlayVentTD:=False;
               XVentTDF := StrNew(PChar(soundDir + 'x_ventTD-stop.wav'));
               XVentCycleTDF:=PChar(''); isPlayVentTDX:=False; end;
         end;
      end;
   end;

   // ----------------------------------------------------
   //  PEBEPCOPbl
   // ----------------------------------------------------
   procedure CHS4_.reversor_step();
   begin
      if ReversorPos <> PrevReversorPos then begin
         if ReversorPos = 1 then
            CabinClicksF := StrNew(PChar(soundDir + 'revers_0-1.wav'));
         if ReversorPos = 0 then
            CabinClicksF := StrNew(PChar(soundDir + 'revers_1-0.wav'));
            
         isPlayCabinClicks:=False;
      end;
   end;

end.

