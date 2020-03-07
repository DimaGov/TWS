unit UnitSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormSettings = class(TForm)
    groupBoxSettings: TGroupBox;
    cbSlowComputer: TCheckBox;
    cbTEDNewSystem: TCheckBox;
    cbHornClick: TCheckBox;
    cbCHS4tNewMVSystemOnAllLocoNum: TCheckBox;
    procedure cbSlowComputerClick(Sender: TObject);
    procedure cbTEDNewSystemClick(Sender: TObject);
    procedure cbCHS4tNewMVSystemOnAllLocoNumClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;

implementation

uses UnitMain;
{$R *.dfm}

// -------------------------------------------------
// Slow computer checkbox click in settings
// -------------------------------------------------
procedure TFormSettings.cbSlowComputerClick(Sender: TObject);
begin
	if cbSlowComputer.Checked=True then
           FormMain.ClockMain.Interval := 100
        else
           FormMain.ClockMain.Interval := 20;

        UnitMain.MainCycleFreq := FormMain.ClockMain.Interval;
end;

// -------------------------------------------------
// New TED system checkbox click (Tempo-Pitch)
// -------------------------------------------------
procedure TFormSettings.cbTEDNewSystemClick(Sender: TObject);
begin
	UnitMain.TEDNewSystem := cbTEDNewSystem.Checked;
end;

// -------------------------------------------------
// CHS4t new motor-fans system (Tempo-Pitch)
// -------------------------------------------------
procedure TFormSettings.cbCHS4tNewMVSystemOnAllLocoNumClick(
  Sender: TObject);
begin
        UnitMain.CHS4tVentNewSystemOnAllLocos := cbCHS4tNewMVSystemOnAllLocoNum.Checked;
end;

end.
