unit uAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, uFormBase, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.StrUtils;

type
  TFormAbastecimento = class(TFormBase)
    pntq1Bb1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    btnFechar: TBitBtn;
    btnAbastecer: TBitBtn;
    edtValorAbastecer: TEdit;
    edtLitros: TEdit;
    pgAbastecimento: TProgressBar;
    gbStatusBomba: TGroupBox;
    GroupBox1: TGroupBox;
    gbBomba: TGroupBox;
    Panel1: TPanel;
    qrConsulta: TFDQuery;
    dsConsulta: TDataSource;
    dbDescCombustivel: TDBText;
    edtBomba: TDBText;
    edtValorporLitro: TDBEdit;
    stStatusBomba: TDBText;
    procedure btnAbastecerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtValorAbastecerExit(Sender: TObject);
    procedure edtValorAbastecerEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
  private
    FIdCombustivel: integer;
    FIdBomba: integer;
    FIdTanque: integer;
    procedure AjustarValoresLitro;
    procedure SetIdCombustivel(const Value: integer);
    procedure SetIdBomba(const Value: integer);
    procedure SetIdTanque(const Value: integer);
    function ValidarValorAbastecer: Boolean;
    procedure SimularDemoraAbastecimento();
  public
    property IdTanque: integer read FIdTanque write SetIdTanque;
    property IdCombustivel: integer read FIdCombustivel write SetIdCombustivel;
    property IdBomba: integer read FIdBomba write SetIdBomba;
    procedure AjustaStatusBomba(Livre: Boolean);
  end;

var
  FormAbastecimento: TFormAbastecimento;

Const
  status_Livre = 'LIVRE';
  status_Ocupado = 'OCUPADO';

implementation

{$R *.dfm}

uses uUtils;

procedure TFormAbastecimento.AjustaStatusBomba(Livre: Boolean);
begin
  if (Livre) then
  begin
    stStatusBomba.Caption := status_Livre;
    stStatusBomba.Font.Color := clGreen;
  end
  else
  begin
    stStatusBomba.Caption := status_Ocupado;
    stStatusBomba.Font.Color := clRed;
  end;

  stStatusBomba.Refresh;
end;

function TFormAbastecimento.ValidarValorAbastecer(): Boolean;
begin
  result := true;
  if StrToCurrDef(edtValorAbastecer.text, 0) = 0 then
  begin
    mensagemInformacao('Informe o valor para abastecimento.');
    result := false;
    Exit;
  end;
end;

procedure TFormAbastecimento.btnAbastecerClick(Sender: TObject);
var
  ValorImposto: Currency;
  Abastecimento: TAbastecimento;
begin
  if not(ValidarValorAbastecer) then
  begin
    Exit;
  end;

  AjustaStatusBomba(false);
  ValorImposto := StrToCurr(edtValorAbastecer.Text) * (qrConsulta.FieldByName('PercentualImposto').AsCurrency / 100);

  Abastecimento.IdTanque := qrConsulta.FieldByName('IdTanque').AsInteger;
  Abastecimento.IdBomba := qrConsulta.FieldByName('IdBomba').AsInteger;
  Abastecimento.ValorAbastecido := StrToCurr(edtValorAbastecer.Text);
  Abastecimento.QuantidadeLitros := StrToCurr(edtLitros.Text);
  Abastecimento.ValorImposto := ValorImposto;

  LancarAbastecimento(Abastecimento);

  SimularDemoraAbastecimento();

  mensagemSucesso('Abastecimento Concluído!');
  AjustaStatusBomba(true);
end;

procedure TFormAbastecimento.btnFecharClick(Sender: TObject);
begin
  inherited;
  FormAbastecimento.Close;
end;

procedure TFormAbastecimento.edtValorAbastecerEnter(Sender: TObject);
begin
  inherited;
  edtValorAbastecerExit(Sender);
end;

procedure TFormAbastecimento.SimularDemoraAbastecimento();
Var
  quantidade : integer;
begin
  quantidade := Round(StrToCurr(edtLitros.Text));
  quantidade := quantidade * 100000;    // deixar o processo mais lentro para possibilitar animação

  pgAbastecimento.Max := quantidade;
  pgAbastecimento.Position := 0;

  While quantidade > 0 do
  begin
    pgAbastecimento.position := pgAbastecimento.position + 1;
    quantidade := quantidade -1;
  end;
end;

procedure TFormAbastecimento.edtValorAbastecerExit(Sender: TObject);
begin
  inherited;
  AjustarValoresLitro();
end;

procedure TFormAbastecimento.SetIdBomba(const Value: integer);
begin
  FIdBomba := Value;
end;

procedure TFormAbastecimento.SetIdCombustivel(const Value: integer);
begin
  FIdCombustivel := Value;
end;

procedure TFormAbastecimento.SetIdTanque(const Value: integer);
begin
  FIdTanque := Value;
end;

procedure TFormAbastecimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FormAbastecimento);
end;

procedure TFormAbastecimento.FormShow(Sender: TObject);
begin
  inherited;
  qrConsulta.ParamByName('IdTanque').AsInteger := FIdTanque;
  qrConsulta.ParamByName('IdBomba').AsInteger := FIdBomba;
  qrConsulta.ParamByName('IdCombustivel').AsInteger := FIdCombustivel;
  qrConsulta.Open;
end;

procedure TFormAbastecimento.AjustarValoresLitro();
var
  valorAbastecido : Currency;
  valorporLitro : Currency;
begin
  if Trim(edtValorAbastecer.text) = '' then
  begin
    edtValorAbastecer.text := '0,00';
  end;

  if StrToCurr(edtValorAbastecer.text) > 0 then
  begin
    edtValorAbastecer.Text := FormatFloat('#0.00', StrToCurr(edtValorAbastecer.text));

    valorAbastecido := StrToCurr(edtValorAbastecer.Text);
    valorporLitro := StrToCurr(edtValorporLitro.Text);
    edtLitros.Text := FormatFloat('#0.00', valorAbastecido / valorporLitro);
  end;
end;



end.
