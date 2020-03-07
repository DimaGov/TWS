unit UnitSOVIHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TFormSOVIHelp = class(TForm)
    RichEdit1: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSOVIHelp: TFormSOVIHelp;

implementation

{$R src/savp/UnitSOVIHelp.dfm}

end.
