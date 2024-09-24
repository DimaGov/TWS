unit CHS2K;

interface

uses VR242;

type chs2k_ = class (TObject)
    private
      soundDir: String;

      vr242__: vr242_;

      procedure bv_step();
      procedure mk_step();
      procedure ept_step();
      procedure vent_step();
      procedure hLights_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, SysUtils, Bass;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor CHS2K_.Create;
   begin
      soundDir := 'TWS\CHS2K\';

      vr242__ := vr242_.Create();
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS2K_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         ept_step();
         hLights_step();
         vr242__.step();
      end;

      if FormMain.cbVspomMash.Checked = True then begin
         bv_step();
         mk_step();
         vent_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS2K_.bv_step();
   begin
      ;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS2K_.ept_step();
   begin
      if EPT <> PrevEPT then begin
         LocoPowerEquipmentF := PChar('sound/chs7/tumbler.wav');
         isPlayLocoPowerEquipment := False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS2K_.hLights_step();
   begin
      if Highlights<>PrevHighLights then begin
         LocoPowerEquipmentF := PChar('sound/chs7/tumbler.wav');
         isPlayLocoPowerEquipment := False;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS2K_.mk_step();
   begin
      ComprRemaindTimeCheck();

      if Compressor<>Prev_Compressor then begin
         if Compressor<>0 then begin
            CompressorF      := StrNew(PChar(soundDir + 'mk-start.wav'));
            CompressorCycleF := StrNew(PChar(soundDir + 'mk-loop.wav'));
            isPlayCompressor := False;
         end else begin
            CompressorF := StrNew(PChar(soundDir + 'mk-stop.wav'));
            CompressorCycleF := PChar('');
            isPlayCompressor := False;
         end;
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure CHS2K_.vent_step();
   begin
      VentRemaindTimeCheck();

      if (Vent<>0) and (Prev_Vent=0) then begin
         if (BASS_ChannelIsActive(Vent_Channel_FX)<>0) and (StopVent = True) then begin
            BASS_ChannelStop(Vent_Channel_FX); BASS_StreamFree(Vent_Channel_FX);
            BASS_ChannelStop(XVent_Channel_FX); BASS_StreamFree(XVent_Channel_FX);
            isPlayCycleVent := False; isPlayCycleVentX := False;
         end;
         if Vent = 255 then VentPitchDest := 5 else VentPitchDest := 0;
         StopVent:=False;
         isPlayVent:=False; isPlayVentX:=False;
      end;
      if (Vent=0) and (Prev_Vent<>0) then begin
         StopVent:=True;
         isPlayVent:=False; isPlayVentX:=False; VentPitchDest := 0;
      end;
   end;

end.
 