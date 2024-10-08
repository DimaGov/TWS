unit TEP70;

interface

uses VR242;

type tep70_ = class (TObject)
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
   constructor TEP70_.Create;
   begin
      soundDir := 'TWS\TEP70\';

      vr242__ := vr242_.Create(False);
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure TEP70_.step();
   begin
      if FormMain.cbCabinClicks.Checked = True then begin
         vr242__.step();
      end;
   end;

end.

