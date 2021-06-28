object frmImpRelatorio: TfrmImpRelatorio
  Left = 323
  Top = 205
  Caption = 'Impress'#227'o de Relat'#243'rio'
  ClientHeight = 552
  ClientWidth = 816
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object Relatorio: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dsImpr
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 50
      BandType = btTitle
      BeforePrint = CabecalhoBeforePrint
      object RLDraw1: TRLDraw
        Left = 1
        Top = 0
        Width = 716
        Height = 47
      end
      object lbTituloRelatorio: TRLLabel
        Left = 3
        Top = 4
        Width = 712
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Relat'#243'rio de Abastecimentos'
      end
      object lbParamConsulta: TRLLabel
        Left = 3
        Top = 26
        Width = 334
        Height = 16
        AutoSize = False
        Caption = 'Relat'#243'rio de Abastecimentos'
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 656
        Top = 26
        Width = 59
        Height = 16
        AutoSize = False
        Info = itPageNumber
        Text = ''
      end
      object RLLabel1: TRLLabel
        Left = 608
        Top = 26
        Width = 45
        Height = 16
        AutoSize = False
        Caption = 'P'#225'gina:'
      end
    end
    object grData: TRLGroup
      Left = 38
      Top = 88
      Width = 718
      Height = 76
      DataFields = 'DATAABASTECIMENTO'
      object RLDetailGrid1: TRLDetailGrid
        Left = 0
        Top = 37
        Width = 718
        Height = 18
        BeforePrint = RLDetailGrid1BeforePrint
        object RLDBText2: TRLDBText
          Left = 6
          Top = 1
          Width = 81
          Height = 16
          Alignment = taCenter
          AutoSize = False
          DataField = 'IDTANQUE'
          DataSource = dsImpr
          Text = ''
        end
        object RLDBText3: TRLDBText
          Left = 95
          Top = 1
          Width = 81
          Height = 16
          Alignment = taCenter
          AutoSize = False
          DataField = 'IDBOMBA'
          DataSource = dsImpr
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 182
          Top = 1
          Width = 388
          Height = 16
          AutoSize = False
          DataField = 'DESCRICAO'
          DataSource = dsImpr
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 576
          Top = 1
          Width = 139
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALORABASTECIDO'
          DataSource = dsImpr
          DisplayMask = 'R$ #,0.00'
          Text = ''
        end
      end
      object RLBand1: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 37
        BandType = btHeader
        object RLDraw3: TRLDraw
          Left = 2
          Top = 18
          Width = 716
          Height = 19
        end
        object RLLabel2: TRLLabel
          Left = 6
          Top = 2
          Width = 33
          Height = 16
          Caption = 'Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText1: TRLDBText
          Left = 43
          Top = 1
          Width = 148
          Height = 16
          DataField = 'DATAABASTECIMENTO'
          DataSource = dsImpr
          Text = ''
        end
        object RLLabel3: TRLLabel
          Left = 6
          Top = 20
          Width = 81
          Height = 16
          AutoSize = False
          Caption = 'Tanque'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel4: TRLLabel
          Left = 95
          Top = 20
          Width = 81
          Height = 16
          AutoSize = False
          Caption = 'Bomba'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel5: TRLLabel
          Left = 182
          Top = 20
          Width = 388
          Height = 16
          AutoSize = False
          Caption = 'Combust'#237'vel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel6: TRLLabel
          Left = 576
          Top = 20
          Width = 139
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 55
        Width = 718
        Height = 20
        BandType = btFooter
        BeforePrint = RLBand2BeforePrint
        object RLDraw2: TRLDraw
          Left = 1
          Top = 0
          Width = 716
          Height = 19
        end
        object RLLabel7: TRLLabel
          Left = 429
          Top = 2
          Width = 139
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbTotalGrupo: TRLLabel
          Left = 638
          Top = 2
          Width = 77
          Height = 16
          Alignment = taRightJustify
        end
      end
    end
  end
  object qrConsulta: TFDQuery
    Connection = DataModu.ConexaoBD
    SQL.Strings = (
      'SELECT A.IDABASTECIMENTO'
      '      ,A.DATAABASTECIMENTO'
      '      ,A.IDTANQUE'
      '      ,A.IDBOMBA'
      '      ,A.VALORABASTECIDO'
      '      ,C.DESCRICAO'
      '  FROM ABASTECIMENTO A'
      ' INNER JOIN BOMBACOMBUSTIVEL B'
      '    ON A.IDTANQUE = B.IDTANQUE  '
      '   AND A.IDBOMBA = B.IDBOMBA'
      ' INNER JOIN COMBUSTIVEL C'
      '    ON B.IDCOMBUSTIVEL = C.IDCOMBUSTIVEL'
      ' WHERE A.DATAABASTECIMENTO >= :DATAINICIAL'
      '   AND A.DATAABASTECIMENTO <= :DATAFINAL  '
      ' GROUP BY A.IDABASTECIMENTO'
      '       ,A.DATAABASTECIMENTO'
      '       ,A.IDTANQUE'
      '       ,A.IDBOMBA     '
      '      ,A.VALORABASTECIDO'
      '       ,B.IDCOMBUSTIVEL'
      '       ,C.DESCRICAO'
      ' ORDER BY A.DATAABASTECIMENTO')
    Left = 106
    Top = 8
    ParamData = <
      item
        Name = 'DATAINICIAL'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'DATAFINAL'
        DataType = ftDate
        ParamType = ptInput
      end>
  end
  object dsImpr: TDataSource
    DataSet = qrConsulta
    Left = 152
    Top = 13
  end
end
