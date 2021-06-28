unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Mask, Vcl.Grids, Vcl.DBGrids, uFormBase,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmPrincipal = class(TFormBase)
    gbFerramentas: TGroupBox;
    StatusBar1: TStatusBar;
    btnAbrirLoteTrabalho: TBitBtn;
    btnFecharLoteTrabalho: TBitBtn;
    bpRelatorio: TGroupBox;
    btnRelatorio: TBitBtn;
    dbBombas: TDBGrid;
    btnAbastecer: TButton;
    dsConsulta: TDataSource;
    qrConsulta: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure btnAbrirLoteTrabalhoClick(Sender: TObject);
    procedure btnFecharLoteTrabalhoClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure btnAbastecerClick(Sender: TObject);
    procedure dbBombasCellClick(Column: TColumn);
  private
    procedure ConfigurarConexao;
    procedure ExibirBombas;
    { Private declarations }
  public
    NaoHaSelecionado: Boolean;
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uLoteTrabalho, uDataModule, uUtils,
  uTelaRelatorio, uAbastecimento, uArquivoConexao;

{$R *.dfm}

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  if not ExisteArquivoConexao() then
  begin
    ConfigurarConexao();
  end;

  try
    DataModu.ConectarBanco();
  except
    mensagemErro('Ocorreu erro ao tentar conexão com base de dados, favor recrie seu arquivo de configuração!');
  end;

  ExibirBombas();
end;

procedure TfrmPrincipal.btnAbastecerClick(Sender: TObject);
begin
  if not(VerificarStatusLoteTrabalho()) then
  begin
    mensagemInformacao('Não existe lote de trabalho aberto, favor abra lote para efetuar abastecimento');
    Exit;
  end;

  if (NaoHaSelecionado) then
  begin
    mensagemInformacao('Selecione uma bomba para abastecimento.');
    Exit;
  end;

  if (formAbastecimento = nil) then
  begin
    formAbastecimento := TFormAbastecimento.Create(Self);
  end;

  formAbastecimento.IdTanque := qrConsulta.FieldByName('IdTanque').AsInteger;
  formAbastecimento.IdBomba := qrConsulta.FieldByName('IdBomba').AsInteger;
  formAbastecimento.IdCombustivel := qrConsulta.FieldByName('IdCombustivel').AsInteger;
  formAbastecimento.AjustaStatusBomba(true);

  formAbastecimento.Show;

  ExibirBombas();
end;

procedure TfrmPrincipal.btnAbrirLoteTrabalhoClick(Sender: TObject);
begin
  if (VerificarStatusLoteTrabalho()) then
  begin
    mensagemInformacao('Já existe lote de trabalho aberto!');
    Exit;
  end;

  if (frmLoteTrabalho = nil) then
  begin
    frmLoteTrabalho := TfrmLoteTrabalho.Create(Self);
  end;
  frmLoteTrabalho.ShowModal;
end;

procedure TfrmPrincipal.btnFecharLoteTrabalhoClick(Sender: TObject);
begin
  if not(VerificarStatusLoteTrabalho()) then
  begin
    mensagemInformacao('Não existe lote de trabalho aberto!');
    Abort;
  end;

  if (frmLoteTrabalho = nil) then
  begin
    frmLoteTrabalho := TfrmLoteTrabalho.Create(Self);
  end;
  frmLoteTrabalho.ShowModal;
end;

procedure TfrmPrincipal.btnRelatorioClick(Sender: TObject);
begin
  if (FormTelaRelatorio = nil) then
  begin
    FormTelaRelatorio := TFormTelaRelatorio.Create(Self);
  end;

  FormTelaRelatorio.ShowModal;
end;

procedure TfrmPrincipal.ConfigurarConexao;
begin
  if (FormArquivoConexao = nil) then
  begin
    FormArquivoConexao := TFormArquivoConexao.Create(Self);
  end;

  if FormArquivoConexao.ShowModal <> mrOk then
  begin
    Application.Terminate;
    Exit;
  end;

  DataModu.ConectarBanco();
end;

procedure TfrmPrincipal.dbBombasCellClick(Column: TColumn);
begin
  inherited;
  NaoHaSelecionado := false;
end;

procedure TfrmPrincipal.ExibirBombas();
begin
  qrConsulta.SQL.Clear;
  qrConsulta.SQL.Add('SELECT B.IDTANQUE                        ');
  qrConsulta.SQL.Add('      ,B.IDBOMBA                         ');
  qrConsulta.SQL.Add('      ,B.IDCOMBUSTIVEL                   ');
  qrConsulta.SQL.Add('      ,C.DESCRICAO                       ');
  qrConsulta.SQL.Add('      ,C.VALOR                           ');
  qrConsulta.SQL.Add('  FROM bombacombustivel B                ');
  qrConsulta.SQL.Add(' INNER JOIN COMBUSTIVEL C                ');
  qrConsulta.SQL.Add('    ON B.IDCOMBUSTIVEL = C.IDCOMBUSTIVEL ');
  qrConsulta.Open();

  NaoHaSelecionado := true;
end;

end.
