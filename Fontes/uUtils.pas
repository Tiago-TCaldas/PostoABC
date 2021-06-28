unit uUtils;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, inifiles;

type
  TDadosConexao = record
    Servidor : String;
    Basededados : String;
    Login : String;
    Senha : String;
  end;

  TAbastecimento = record
    idTanque : Integer;
    idBomba : Integer;
    valorAbastecido : Currency;
    quantidadeLitros : Currency;
    ValorImposto: Currency
  end;

  function DiretorioSistema: String;
  function ExisteArquivoConexao(): Boolean;
  procedure CriarArquivoConexao(DadosConexao: TDadosConexao);
  procedure LerArquivoConexao(out DadosConexao: TDadosConexao);

  Function RemoverAspas(texto : String) : String;
  Function StrZero(texto : String ;  tamanho : Integer) : String;

  procedure mensagemAviso(const Msg: string);
  procedure mensagemSucesso(const Msg: string);
  procedure mensagemErro(const Msg: string);    
  procedure mensagemInformacao(const Msg: string);

  Function ProximoCodigo(tabela : String; campo : String) : Integer;
  function VerificarStatusLoteTrabalho() : Boolean;
  Function SelecionarCampo(tabela : String; campo : String ; condicao : String) : String;

  procedure LancarAbastecimento(Abastecimento: TAbastecimento);

  implementation

uses StrUtils, uDataModule, DB;

Const
  NOME_ARQUIVO_CONEXAO = 'ConfConexao';

Function RemoverAspas(texto : String) : String;
begin
  texto := StringReplace(texto,'"','',[rfReplaceAll]);
  texto := StringReplace(texto,'''','',[rfReplaceAll]);
  texto := StringReplace(texto,'(','',[rfReplaceAll]);
  texto := StringReplace(texto,')','',[rfReplaceAll]);
  Result := texto;
end;

Function StrZero(texto : String ;  tamanho : Integer) : String;
begin
  while ( Length(texto) < tamanho ) do
  begin
    texto := '0' + texto;
  end;

  Result := Texto;
end;

function DiretorioSistema: String;
begin
  result := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
end;

procedure mensagemAviso(const Msg: string);
begin
  Application.MessageBox(PChar(Msg), 'Aviso', mb_Ok+MB_ICONWARNING);
end;

procedure mensagemSucesso(const Msg: string);
begin
  Application.MessageBox(PChar(Msg), 'Sucesso', mb_Ok+MB_ICONINFORMATION);
end;

procedure mensagemErro(const Msg: string);
begin
  Application.MessageBox(PChar(Msg), 'Erro', mb_Ok+MB_ICONERROR);
end;

procedure mensagemInformacao(const Msg: string);
begin
  Application.MessageBox(PChar(Msg), 'Informação', mb_Ok+MB_ICONINFORMATION);
end;

procedure CriarArquivoConexao(DadosConexao: TDadosConexao);
var
  ArquivoConfiguracao: TIniFile;
begin
  ArquivoConfiguracao := TIniFile.Create(DiretorioSistema + NOME_ARQUIVO_CONEXAO + '.ini');
  try
    ArquivoConfiguracao.WriteString('Dados', 'servidor', DadosConexao.Servidor);
    ArquivoConfiguracao.WriteString('Dados', 'database', DadosConexao.Basededados);
    ArquivoConfiguracao.WriteString('Dados', 'login', DadosConexao.Login);
    ArquivoConfiguracao.WriteString('Dados', 'password', DadosConexao.Senha);
  finally
    ArquivoConfiguracao.Free;
    mensagemSucesso('Arquivo criado com sucesso!');
  end;
end;

procedure LerArquivoConexao(out DadosConexao: TDadosConexao);
var
  ArquivoConfiguracao: TIniFile;
begin
  ArquivoConfiguracao := TIniFile.Create(DiretorioSistema + NOME_ARQUIVO_CONEXAO + '.ini');

  try
    DadosConexao.Servidor := ArquivoConfiguracao.ReadString('Dados', 'servidor', DadosConexao.Servidor);
    DadosConexao.Basededados := ArquivoConfiguracao.ReadString('Dados', 'database', DadosConexao.Basededados);
    DadosConexao.Login := ArquivoConfiguracao.ReadString('Dados', 'login', DadosConexao.Login);
    DadosConexao.Senha := ArquivoConfiguracao.ReadString('Dados', 'password', DadosConexao.Senha);
  finally
    ArquivoConfiguracao.Free;
  end;
end;

Function ProximoCodigo(tabela : String; campo : String) : Integer;
begin
  DataModu.query.sql.Clear;
  DataModu.query.SQL.Add('SELECT max(' + campo +') as proximo');
  DataModu.query.SQL.Add('  FROM '+ tabela + ';            ');
  DataModu.query.Open;

  Result := DataModu.query.FieldByName('proximo').AsInteger + 1;

  DataModu.query.Close();
end;

function VerificarStatusLoteTrabalho() : Boolean;
begin
  DataModu.query.SQL.Clear();

  DataModu.query.SQL.Add('SELECT count(*) as loteAberto   ');
  DataModu.query.SQL.Add('  FROM loteTrabalho             ');
  DataModu.query.SQL.Add(' WHERE dataAbertura is not null ');
  DataModu.query.SQL.Add('   AND dataFechamento is null   ');
  DataModu.query.Open();

  Result := (DataModu.query.FieldByName('loteAberto').AsInteger <> 0);

  DataModu.query.Close;
end;


Function SelecionarCampo(tabela : String; campo : String ; condicao : String) : String;
begin
  DataModu.query.sql.Clear;
  DataModu.query.SQL.Add('SELECT ' + campo +' as valor');
  DataModu.query.SQL.Add('  FROM '+ tabela + ' ' + condicao + ';  ');
  DataModu.query.Open;

  Result := DataModu.query.FieldByName('valor').AsString;

  DataModu.query.Close();
end;

procedure LancarAbastecimento(Abastecimento: TAbastecimento);
var
  proximo : Integer;
begin
  try
    proximo := ProximoCodigo('abastecimento', 'idabastecimento');

    DataModu.query.sql.Clear;
    DataModu.query.SQL.Add('INSERT INTO abastecimento       ');
    DataModu.query.SQL.Add('            (idabastecimento    ');
    DataModu.query.SQL.Add('            ,idTanque           ');
    DataModu.query.SQL.Add('            ,idBomba            ');
    DataModu.query.SQL.Add('            ,valorAbastecido    ');
    DataModu.query.SQL.Add('            ,quantidadeLitros   ');
    DataModu.query.SQL.Add('            ,valorImposto       ');
    DataModu.query.SQL.Add('            ,dataAbastecimento) ');
    DataModu.query.SQL.Add('     VALUES (:idProximo         ');
    DataModu.query.SQL.Add('            ,:idTanque          ');
    DataModu.query.SQL.Add('            ,:idBomba           ');
    DataModu.query.SQL.Add('            ,:valorAbastecido   ');
    DataModu.query.SQL.Add('            ,:quantidadeLitros  ');
    DataModu.query.SQL.Add('            ,:valorImposto      ');
    DataModu.query.SQL.Add('            ,:dataAbastecimento)');

    DataModu.query.ParamByName('idProximo').AsInteger := proximo;  
    DataModu.query.ParamByName('idTanque').AsInteger := Abastecimento.idTanque;
    DataModu.query.ParamByName('idBomba').AsInteger := Abastecimento.idBomba;
    DataModu.query.ParamByName('valorAbastecido').AsCurrency := Abastecimento.valorAbastecido;
    DataModu.query.ParamByName('quantidadeLitros').AsCurrency := Abastecimento.quantidadeLitros;
    DataModu.query.ParamByName('valorImposto').AsCurrency := Abastecimento.valorImposto;
    DataModu.query.ParamByName('dataAbastecimento').AsDateTime := Date();

    DataModu.query.ExecSQL;

    DataModu.query.Close;
  Except
    mensagemErro('Ocorreu erro ao realizar abastecimento!');
  end;
end;

function ExisteArquivoConexao(): Boolean;
var
  DiretorioArquivo: String;
begin
   DiretorioArquivo := DiretorioSistema + NOME_ARQUIVO_CONEXAO + '.ini';
   result := FileExists(DiretorioArquivo);
end;

end.

