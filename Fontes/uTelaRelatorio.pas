unit uTelaRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, uFormBase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormTelaRelatorio = class(TFormBase)
    btnImprimir: TBitBtn;
    GroupBox1: TGroupBox;
    dataInicial: TDateTimePicker;
    dataFinal: TDateTimePicker;
    Label1: TLabel;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTelaRelatorio: TFormTelaRelatorio;

implementation

uses uDataModule, uUtils, uImpRelatorio;

{$R *.dfm}

procedure TFormTelaRelatorio.btnImprimirClick(Sender: TObject);
begin

  if dataInicial.DateTime > dataFinal.DateTime then
  begin
    mensagemAviso('Data inicial maior que data final.');
    Abort;
  end;

  try
    frmImpRelatorio := TfrmImpRelatorio.Create(Self);

    frmImpRelatorio.qrConsulta.ParamByName('DATAINICIAL').AsDateTime := dataInicial.DateTime;
    frmImpRelatorio.qrConsulta.ParamByName('DATAFINAL').AsDateTime := dataFinal.DateTime;
    frmImpRelatorio.qrConsulta.Open();

    if not(frmImpRelatorio.qrConsulta.Eof) then
    begin
      frmImpRelatorio.Relatorio.Title := 'Relatório de Abastecimento';
      frmImpRelatorio.DataInicial := dataInicial.Date;
      frmImpRelatorio.DataFinal := dataFinal.Date;

      frmImpRelatorio.Relatorio.Preview();
    end
    else
    begin
      mensagemInformacao('Não existem abastecimentos no período');
    end;
  finally
    FreeAndNil(frmImpRelatorio);
  end;
end;

procedure TFormTelaRelatorio.FormShow(Sender: TObject);
begin
  inherited;
  dataInicial.Date := date;
  dataFinal.Date := date;
end;

end.
