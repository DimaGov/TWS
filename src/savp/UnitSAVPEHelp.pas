unit UnitSAVPEHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormSAVPEHelp = class(TForm)
    HelpLabel: TLabel;
    HelpText: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSAVPEHelp: TFormSAVPEHelp;

implementation

{$R *.dfm}

end.
