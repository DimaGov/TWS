unit VL85;

interface

uses VR242;

type vl85_ = class (TObject)
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
   constructor VL85_.Create;
   begin
      soundDir := 'TWS\VL85\';

      vr242__ := vr242_.Create(False);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure VL85_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         vr242__.step();
      end;
   end;

end.

