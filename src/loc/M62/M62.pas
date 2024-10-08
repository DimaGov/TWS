unit M62;

interface

uses ExtCtrls, VR242;

type m62_ = class (TObject)
    private
      soundDir: String;

      vr242__: vr242_;

      procedure reversor_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, soundManager, Bass, SysUtils, Math, Windows;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor M62_.Create;
   begin
      soundDir := 'TWS\M62\';

      vr242__ := vr242_.Create(False);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure M62_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         reversor_step();
         vr242__.step();
      end;
   end;

   // ----------------------------------------------------
   //  PEBEPCOPbl
   // ----------------------------------------------------
   procedure M62_.reversor_step();
   begin
      if KM_Pos_1<=1 then begin
         if (PrevKeyW=0) and (GetAsyncKeyState(87)<>0) then begin
            CabinClicksF := StrNew(PChar(soundDir + 'reverser.wav'));
            isPlayCabinClicks:=False; PrevKeyW:=1;
         end;

         if (PrevKeyS=0) and (GetAsyncKeyState(83)<>0) then begin
            CabinClicksF := StrNew(PChar(soundDir + 'reverser.wav'));
            isPlayCabinClicks:=False; PrevKeyS:=1;
         end;
      end;

      if GetAsyncKeyState(83)=0 then PrevKeyS:=0; if GetAsyncKeyState(87)=0 then PrevKeyW:=0;
   end;

end.

