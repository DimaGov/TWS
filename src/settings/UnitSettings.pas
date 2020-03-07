unit UnitSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormSettings = class(TForm)
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    cbTEDNewSystem: TCheckBox;
    CheckBox3: TCheckBox;
    cbCHS4tNewMVSystemOnAllLocoNum: TCheckBox;
    procedure CheckBox1Click(Sender: TObject);
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
{$R src/settings/UnitSettings.dfm}

procedure TFormSettings.CheckBox1Click(Sender: TObject);
begin
	if CheckBox1.Checked=True then FormMain.Timer1.Interval := 100 else FormMain.Timer1.Interval := 20;
        UnitMain.MainCycleFreq := FormMain.Timer1.Interval;
end;

procedure TFormSettings.cbTEDNewSystemClick(Sender: TObject);
begin
	UnitMain.TEDNewSystem := cbTEDNewSystem.Checked;
end;

procedure TFormSettings.cbCHS4tNewMVSystemOnAllLocoNumClick(
  Sender: TObject);
begin
        UnitMain.CHS4tVentNewSystemOnAllLocos := cbCHS4tNewMVSystemOnAllLocoNum.Checked;
end;

end.
