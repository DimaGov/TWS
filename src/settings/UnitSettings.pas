unit UnitSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst;

type
  TFormSettings = class(TForm)
    groupBoxSettings: TGroupBox;
    cbSlowComputer: TCheckBox;
    cbTEDNewSystem: TCheckBox;
    cbHornClick: TCheckBox;
    cbCHS4tNewMVSystemOnAllLocoNum: TCheckBox;
    cbMVPSZvonok5secDoorClose: TCheckBox;
    cbVR242Allow: TCheckBox;
    procedure cbSlowComputerClick(Sender: TObject);
    procedure cbTEDNewSystemClick(Sender: TObject);
    procedure cbCHS4tNewMVSystemOnAllLocoNumClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbMVPSZvonok5secDoorCloseClick(Sender: TObject);
    procedure cbVR242AllowClick(Sender: TObject);
    procedure cbHornClickClick(Sender: TObject);
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
// ON FORM ACTIVATION
// -------------------------------------------------
procedure TFormSettings.FormActivate(Sender: TObject);
begin
    cbSlowComputer.Checked := SlowComputer;
    cbMVPSZvonok5secDoorClose.Checked := MVPS5secZvonok;
    cbVR242Allow.Checked := VR242Allow;
end;

// -------------------------------------------------
// Slow computer checkbox click in settings
// -------------------------------------------------
procedure TFormSettings.cbSlowComputerClick(Sender: TObject);
begin
  SlowComputer := cbSlowComputer.Checked;
  
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

// -------------------------------------------------
// Проигрывание звонка помощника машиниста на МВПС после 5секунд после закрытия дверей
// -------------------------------------------------
procedure TFormSettings.cbMVPSZvonok5secDoorCloseClick(Sender: TObject);
begin
   MVPS5secZvonok := cbMVPSZvonok5secDoorClose.Checked;
end;

// -------------------------------------------------
// Звуки 242-го воздухана
// -------------------------------------------------
procedure TFormSettings.cbVR242AllowClick(Sender: TObject);
begin
   VR242Allow := cbVR242Allow.Checked;
end;

// -------------------------------------------------
// Свистки и тифоны без проверки электрических цепей
// -------------------------------------------------
procedure TFormSettings.cbHornClickClick(Sender: TObject);
begin
   SimpleHorn := cbHornClick.Checked;
end;

end.
