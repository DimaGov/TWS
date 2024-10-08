unit TEM18dm;

interface

uses VR242;

type tem18dm_ = class (TObject)
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
   constructor TEM18dm_.Create;
   begin
      soundDir := 'TWS\TEM18dm\';

      vr242__ := vr242_.Create(False);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure TEM18dm_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         vr242__.step();
      end;
   end;

end.

