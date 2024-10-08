unit CHS4T;

interface

uses KR21, VR242, ExtCtrls;

type TTimerEvents = class
    public

      procedure OnTimer(Sender: TObject);
      
    end;

type chs4t_ = class (TObject)
    private
      soundDir: String;

      GRIncrementer: Byte;

      CompressorDifferenceTimer: TTimer;
      CompressorDifferenceTimerEvents: TTimerEvents;

      PrevGR_chs4t: Double;

      kr21__: kr21_;
      vr242__: vr242_;

      procedure np22_step();
      procedure vent_step();
      procedure mk_step();
      procedure em_latch_step();
      procedure reversor_step();
    protected

    public

      CompressorGRDifference: Double;
      
      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, Bass, SysUtils, Math, Windows;

   // ----------------------------------------------------
   //  Процедура создания класса CHS4T
   // ----------------------------------------------------
   constructor CHS4T_.Create;
   begin
      soundDir := 'TWS\CHS4t\';

      // Создаем таймер для проверки разницы показаний давления ГР в промежутке времени
      CompressorDifferenceTimer := TTimer.Create(UnitMain.FormMain);
      CompressorDifferenceTimer.Interval := 600;
      CompressorDifferenceTimer.OnTimer := CompressorDifferenceTimerEvents.OnTimer;
      CompressorDifferenceTimer.Enabled := True;

      kr21__ := kr21_.Create('TWS\Devices\21KR\');
      vr242__ := vr242_.Create(True);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4T_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         vent_step();
         mk_step();
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
   procedure CHS4T_.em_latch_step();
   begin
      if ((Prev_KMAbs=0) and (KM_Pos_1>0)) or ((KM_Pos_1>0) and (Prev_KMAbs=0)) Or ((KM_Pos_1 = 0) And ((Reostat>0) And (PrevReostat=0))) then begin
         IMRZashelka:=PChar('TWS\Devices\21KR\EM_zashelka_ON.wav'); isPlayIMRZachelka:=False;
      end;
      if ((Prev_KMAbs>0) and (KM_Pos_1=0)) or ((KM_Pos_1=0) and (Prev_KMAbs>0)) Or ((KM_Pos_1 = 0) And ((Reostat=0) And (PrevReostat>0))) then begin
         IMRZashelka:=PChar('TWS\Devices\21KR\EM_zashelka_OFF.wav'); isPlayIMRZachelka:=False;
      end;
      if (BV_Paketnik = 0) and (PrevBV_Paketnik = 1) then begin
         IMRZashelka:=PChar('TWS\Devices\21KR\EM_zashelka_OFF.wav'); isPlayIMRZachelka:=False;
      end;
      if (BV_Paketnik = 1) and (PrevBV_Paketnik = 0) then begin
         IMRZashelka:=PChar('TWS\Devices\21KR\EM_zashelka_ON.wav'); isPlayIMRZachelka:=False;
      end;
   end;

   procedure CHS4T_.np22_step();
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
      CHS4T__.CompressorGRDifference := GR-CHS4T__.PrevGR_chs4t;
      if CHS4T__.CompressorGRDifference >= 0.015 then begin
         Compressor := 1;
      end;

      if CHS4T__.CompressorGRDifference <= 0 then begin
         if GRIncrementer > 2 then begin
            Compressor := 0;
            GRIncrementer := 0;
         end;

         Inc(GRIncrementer);
      end;

      CHS4T__.PrevGR_chs4t := GR;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS4T_.mk_step();
   var
     temp: Double;
   begin

      if Voltage < 1.0 then Compressor := 0;

      ComprRemaindTimeCheck();

      if Compressor <> Prev_Compressor then begin
         if Compressor <> 0 then begin
            CompressorF       := StrNew(PChar(soundDir + 'mk_start.wav'));
            CompressorCycleF  := StrNew(PChar(soundDir + 'mk_loop.wav'));
            XCompressorF      := StrNew(PChar(soundDir + 'x_mk_start.wav'));
            XCompressorCycleF := StrNew(PChar(soundDir + 'x_mk_loop.wav'));
            isPlayCompressor := False; isPlayXCompressor := False;
         end;
         if Compressor = 0 then begin
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

      VentTDRemaindTimeCheck();

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

      if (LocoNum >= 608) Or (CHS4tVentNewSystemOnAllLocos = True) then begin
         if TEDAmperage < 700 then
            VentTDPitchDest := -3
         else
            VentTDPitchDest := 0;
      end else begin VentTDPitchDest := 0; end;

      (*if TEDAmperage<700 then
         VentTDPitchDest := 0
      else
         if (LocoNum >= 608) Or (CHS4tVentNewSystemOnAllLocos = True) then
            VentTDPitchDest := 3
         else
            VentTDPitchDest := 0;*)
   end;

   // ----------------------------------------------------
   //  PEBEPCOPbl
   // ----------------------------------------------------
   procedure CHS4T_.reversor_step();
   begin
      if KM_Pos_1=0 then begin
         if (PrevKeyW=0) and (GetAsyncKeyState(87)<>0) then begin
            CabinClicksF := StrNew(PChar(soundDir + 'revers.wav'));
            isPlayCabinClicks:=False; PrevKeyW:=1;
         end;

         if (PrevKeyS=0) and (GetAsyncKeyState(83)<>0) then begin
            CabinClicksF := StrNew(PChar(soundDir + 'revers.wav'));
            isPlayCabinClicks:=False; PrevKeyS:=1;
         end;
      end;

      if GetAsyncKeyState(83)=0 then PrevKeyS:=0; if GetAsyncKeyState(87)=0 then PrevKeyW:=0;
   end;

end.
 