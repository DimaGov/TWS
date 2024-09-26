unit TE10U;

interface

uses VR242, ExtCtrls;

type te10u_ = class (TObject)
    private
      soundDir: String;

      vr242__: vr242_;
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

      vr242__ := vr242_.Create();
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure TE10U_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         vr242__.step();
      end;
   end;

end.

