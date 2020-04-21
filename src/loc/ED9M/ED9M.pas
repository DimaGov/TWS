unit ED9M;

interface

type ed9m_ = class (TObject)
    private
      soundDir: String;

      procedure bv_step();
      procedure ept_step();
      procedure mk_step();
      procedure vent_step();
      procedure door_step();
    protected

    public

      procedure step();

    published

    constructor Create;

   end;

implementation

   uses UnitMain, SysUtils, soundManager, ED4M;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor ed9m_.Create;
   begin
      soundDir := 'TWS\ED4M\';
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.step();
   begin
      if FormMain.cbVspomMash.Checked = True then begin
         mk_step();
         vent_step();
         door_step();
      end;

      if FormMain.cbCabinClicks.Checked = True then begin
         bv_step();
         ept_step();
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.door_step();
   begin
      if LDOOR<>PrevLDOOR then begin
         if LDOOR =0 then TWS_PlayLDOOR(PChar(soundDir + 'doors_open.wav'));
         if LDOOR<>0 then TWS_PlayLDOOR(PChar(soundDir + 'doors_close.wav'));
      end;
      if RDOOR<>PrevRDOOR then begin
         if RDOOR =0 then TWS_PlayRDOOR(PChar(soundDir + 'doors_open.wav'));
         if RDOOR<>0 then TWS_PlayRDOOR(PChar(soundDir + 'doors_close.wav'));
      end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.bv_step();
   begin
      ;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.ept_step();
   begin
      ;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.mk_step();
   begin
      ;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure ed9m_.vent_step();
   begin
      ;
   end;

end.

