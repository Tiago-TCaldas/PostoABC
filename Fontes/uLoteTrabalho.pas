unit uLoteTrabalho;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, uFormBase;

type
  TfrmLoteTrabalho = class(TFormBase)
    dataAbertura: TDateTimePicker;
    dataFechamento: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    btnAbrirLoteTrabalho: TBitBtn;
    btnFecharLoteTrabalho: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btnAbrirLoteTrabalhoClick(Sender: TObject); 
    procedure StatusBotoes();
    procedure btnFecharLoteTrabalhoClick(Sender: TObject);
  private
  
  public
  end;

var
  frmLoteTrabalho: TfrmLoteTrabalho;
  LoteAberto : Boolean;

implementation

uses uUtils, uDataModule;

{$R *.dfm}

procedure TfrmLoteTrabalho.FormShow(Sender: TObject);
begin
  dataAbertura.DateTime := Date();
  dataFechamento.DateTime := Date();

  StatusBotoes()
end;

procedure TfrmLoteTrabalho.btnAbrirLoteTrabalhoClick(Sender: TObject);
var
  proximo : Integer;
begin
  try
    proximo := ProximoCodigo('lotetrabalho', 'id');

    DataModu.query.sql.Clear;
    DataModu.query.SQL.Add('INSERT INTO loteTrabalho (id, dataAbertura, dataFechamento) ');
    DataModu.query.SQL.Add('     VALUES (:idProximo, :dataAbertura, NULL); ');

    DataModu.query.ParamByName('idProximo').AsInteger := proximo;
    DataModu.query.ParamByName('dataAbertura').AsDateTime := dataAbertura.Date;

    DataModu.query.ExecSQL;

    mensagemInformacao('Lote de trabalho aberto corretamente!');
    Close;
  Except
    mensagemErro('Não foi possível abrir lote de trabalho');
  end;
end;

procedure TfrmLoteTrabalho.StatusBotoes();
begin
  If not(VerificarStatusLoteTrabalho()) then
  begin
    btnAbrirLoteTrabalho.Enabled := True;
    btnFecharLoteTrabalho.Enabled := false;
  end
  else
  begin
    btnAbrirLoteTrabalho.Enabled := false ;
    btnFecharLoteTrabalho.Enabled := true ;
  end;
end;

procedure TfrmLoteTrabalho.btnFecharLoteTrabalhoClick(Sender: TObject);
begin
  try
    DataModu.query.sql.Clear;
    DataModu.query.SQL.Add('UPDATE loteTrabalho                       ');
    DataModu.query.SQL.Add('   SET dataFechamento = :dataFechamento   ');
    DataModu.query.SQL.Add(' WHERE dataAbertura IS NOT NULL');
    DataModu.query.SQL.Add('   AND dataFechamento IS NULL');

    DataModu.query.ParamByName('dataFechamento').AsDateTime := dataFechamento.DateTime;

    DataModu.query.ExecSQL;

    mensagemInformacao('Lote de trabalho fechado corretamente!');
    Close;
  Except
    mensagemErro('Não foi possível fechar lote de trabalho');
  end;
end;

end.
