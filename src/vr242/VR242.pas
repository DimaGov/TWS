unit VR242;

interface

type vr242_ = class (TObject)
    private
      soundDir: String;

      vol, pitch: single;
      destVol, destPitch: Single;

    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, Bass, SysUtils, Bass_FX;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor vr242_.Create;
   begin
      soundDir := 'TWS\';
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure vr242_.step();
   begin
      if VR242Allow = True then begin
         if (UnitMain.VR242 > 0) and (PrevVR242 = 0) then begin
            VR242F := StrNew(PChar(soundDir + 'vr242.wav'));
            isPlayVR242 := False;
            vol := 0.0; pitch := 0.0;
            destVol := 0.0; destPitch := 0.0;
         end;

         if BASS_ChannelIsActive(VR242Channel_FX) <> 0 then begin
            if vol < destVol then vol := vol + 0.05;
            if vol > destVol then vol := vol - 0.05;

            if vol < 0 then vol := 0.0;

            if pitch < destPitch then pitch := pitch + 0.1;
            if pitch > destPitch then pitch := pitch - 0.05;

            if UnitMain.VR242 > 0 then begin
               destVol := UnitMain.VR242 / 2;
               destPitch := UnitMain.VR242;
            end else begin
               destPitch := -15;
               if Pitch < -7 then destVol := 0.0;
            end;

            BASS_ChannelSetAttribute(VR242Channel_FX, BASS_ATTRIB_VOL, vol);
            BASS_ChannelSetAttribute(VR242Channel_FX, BASS_ATTRIB_TEMPO_PITCH, pitch);
         end;
      end;
   end;

end.
 