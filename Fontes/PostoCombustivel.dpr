program PostoCombustivel;

uses
  Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uUtils in 'uUtils.pas',
  uLoteTrabalho in 'uLoteTrabalho.pas' {frmLoteTrabalho},
  uDataModule in 'uDataModule.pas' {DataModu: TDataModule},
  uTelaRelatorio in 'uTelaRelatorio.pas' {FormTelaRelatorio},
  uFormBase in 'uFormBase.pas' {FormBase},
  uAbastecimento in 'uAbastecimento.pas' {FormAbastecimento},
  uArquivoConexao in 'uArquivoConexao.pas' {FormArquivoConexao},
  uImpRelatorio in 'uImpRelatorio.pas' {frmImpRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDataModu, DataModu);
  Application.CreateForm(TFormTelaRelatorio, FormTelaRelatorio);
  Application.CreateForm(TFormBase, FormBase);
  Application.CreateForm(TFormAbastecimento, FormAbastecimento);
  Application.CreateForm(TFormArquivoConexao, FormArquivoConexao);
  Application.CreateForm(TfrmImpRelatorio, frmImpRelatorio);
  Application.Run;
end.
