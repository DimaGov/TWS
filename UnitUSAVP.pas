unit UnitUSAVP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SAVP;

type
  TFormUSAVP = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Timer1: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUSAVP: TFormUSAVP;
  PrevKeyNum1: Byte;

implementation

uses UnitMain;

{$R *.dfm}

procedure TFormUSAVP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FormMain.cbUSAVPSounds.Checked := False;
end;

procedure TFormUSAVP.Timer1Timer(Sender: TObject);
begin
	//USAVPEnabled := FormUSAVP.Showing;

        //if USAVPEnabled = True then begin
           Label1.Font.Color := clGreen;
           Label1.Caption := '—»—“≈Ã¿ ¿ “»¬Õ¿!';
        //end else begin
        //   Label1.Font.Color := clRed;
        //   Label1.Caption := '—»—“≈Ã¿ Õ≈ ¿ “»¬Õ¿ ¬ —»Ã”Àﬂ“Œ–≈ Õ¿∆Ã»“≈ "NUM1"';
        //end;

        PrevKeyNum1 := GetAsyncKeyState(97);
end;

end.
