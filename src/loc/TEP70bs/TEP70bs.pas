unit TEP70bs;

interface

uses VR242;

type tep70bs_ = class (TObject)
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
   constructor TEP70bs_.Create;
   begin
      soundDir := 'TWS\TEP70bs\';

      vr242__ := vr242_.Create(False);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure TEP70bs_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         vr242__.step();
      end;
   end;

end.

