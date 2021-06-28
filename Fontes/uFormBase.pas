unit uFormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Mask;

type
  TFormBase = class(TForm)
    Panel: TPanel;
    procedure PermiteNumeros(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}

procedure TFormBase.PermiteNumeros(Sender: TObject;
  var Key: Char);
begin
  if not (CharInSet(Key,['0'..'9',#8])) then
    key := #0;
end;

end.
