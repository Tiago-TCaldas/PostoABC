unit uImpRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmImpRelatorio = class(TForm)
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    lbTituloRelatorio: TRLLabel;
    lbParamConsulta: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    grData: TRLGroup;
    RLDetailGrid1: TRLDetailGrid;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLBand1: TRLBand;
    RLLabel2: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLBand2: TRLBand;
    RLLabel7: TRLLabel;
    qrConsulta: TFDQuery;
    dsImpr: TDataSource;
    lbTotalGrupo: TRLLabel;
    RLDraw2: TRLDraw;
    RLDraw3: TRLDraw;
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure CabecalhoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDetailGrid1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);

  private
    FDataFinal: TDate;
    FDataInicial: TDate;

    { Private declarations }
  public
    { Public declarations }
    property DataInicial: TDate read FDataInicial write FDataInicial;
    property DataFinal: TDate read FDataFinal write FDataFinal;
  end;

var
  totalValorAbastecido : Currency;

var
  frmImpRelatorio: TfrmImpRelatorio;

implementation

uses uDataModule, uTelaRelatorio, uUtils;

{$R *.dfm}

procedure TfrmImpRelatorio.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  totalValorAbastecido := 0;
end;

procedure TfrmImpRelatorio.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
   lbTotalGrupo.Caption := 'R$ ' + FormatFloat('#.0,00', totalValorAbastecido);
   totalValorAbastecido := 0;
end;

procedure TfrmImpRelatorio.RLDetailGrid1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  totalValorAbastecido := totalValorAbastecido + Relatorio.DataSource.DataSet.FieldByName('valorAbastecido').AsCurrency;
end;

procedure TfrmImpRelatorio.CabecalhoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  lbParamConsulta.Caption := 'Período de ' + FormatDateTime('dd/mm/yyyy', FDataInicial) +
                             ' à ' + FormatDateTime('dd/mm/yyyy', FDataFinal)
end;

end.
