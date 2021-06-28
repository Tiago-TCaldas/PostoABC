unit uArquivoConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TFormArquivoConexao = class(TFormBase)
    EdtServidor: TLabeledEdit;
    edtBaseDados: TLabeledEdit;
    EdtLogin: TLabeledEdit;
    EdtSenha: TLabeledEdit;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    procedure BtnSalvarClick(Sender: TObject);
  private
    function ValidaCampos: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormArquivoConexao: TFormArquivoConexao;

implementation

{$R *.dfm}

uses uUtils;

procedure TFormArquivoConexao.BtnSalvarClick(Sender: TObject);
var
  DadosConexao: TDadosConexao;
begin
  inherited;
  if not(ValidaCampos) then
  begin
    Exit;
  end;

  DadosConexao.Servidor := Trim(EdtServidor.Text);
  DadosConexao.Basededados := Trim(EdtBaseDados.Text);
  DadosConexao.Login := Trim(EdtLogin.Text);
  DadosConexao.Senha := Trim(EdtSenha.Text);

  try
    CriarArquivoConexao(DadosConexao);
  finally
    FormArquivoConexao.Close;
  end;
end;

function TFormArquivoConexao.ValidaCampos(): Boolean;
begin
  result := true;
  If (Trim(EdtServidor.Text) = '') or (Trim(EdtBaseDados.Text) = '') or
     (Trim(EdtLogin.Text) = '') or (Trim(EdtSenha.Text) = '') then
  begin
    mensagemAviso('Informe todos os campos!');
    result := false;
  end;
end;

end.
