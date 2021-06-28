unit uDataModule;

interface

uses
  SysUtils, Classes, DB, DBTables, SqlExpr, ExtCtrls, IniFiles,
  Windows, Messages, Variants, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, Buttons,
  FMTBcd, ADODB, DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI;

type
  TDataModu = class(TDataModule)
    ConexaoBD: TFDConnection;
    FDConnectionFirebird: TFDPhysFBDriverLink;
    query: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure ConectarBanco();
  private
    { Private declarations }
  public

  end;

var
  DataModu: TDataModu;

implementation

uses uUtils;

{$R *.dfm}

procedure TDataModu.ConectarBanco();
var
  Dados: TDadosConexao;
begin
  LerArquivoConexao(Dados);

  ConexaoBD.Params.Values['DriverID'] := 'FB';
  ConexaoBD.Params.Values['Server'] := Dados.Servidor;
  ConexaoBD.Params.Values['Database'] := Dados.Basededados;
  ConexaoBD.Params.Values['User_name'] := UPPERCASE(Dados.Login);
  ConexaoBD.Params.Values['Passoword'] := LOWERCASE(Dados.Senha);
  ConexaoBD.Params.Values['VendorLib'] := DiretorioSistema + 'fbclient.dll';

  ConexaoBD.Connected := true;
end;

end.
