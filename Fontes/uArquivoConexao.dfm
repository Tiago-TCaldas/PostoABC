inherited FormArquivoConexao: TFormArquivoConexao
  Caption = 'Arquivo de Conex'#227'o'
  ClientHeight = 215
  ClientWidth = 395
  ExplicitWidth = 411
  ExplicitHeight = 254
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel: TPanel
    Width = 395
    Height = 215
    TabOrder = 4
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 395
    ExplicitHeight = 215
    object BtnSalvar: TBitBtn
      Left = 221
      Top = 174
      Width = 75
      Height = 25
      Caption = 'Salvar'
      ModalResult = 1
      TabOrder = 0
      OnClick = BtnSalvarClick
    end
    object BtnCancelar: TBitBtn
      Left = 302
      Top = 174
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object EdtServidor: TLabeledEdit
    Left = 16
    Top = 24
    Width = 361
    Height = 21
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'Servidor'
    TabOrder = 0
  end
  object edtBaseDados: TLabeledEdit
    Left = 16
    Top = 64
    Width = 361
    Height = 21
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'Base de Dados'
    TabOrder = 1
  end
  object EdtLogin: TLabeledEdit
    Left = 16
    Top = 104
    Width = 361
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Login'
    TabOrder = 2
  end
  object EdtSenha: TLabeledEdit
    Left = 16
    Top = 147
    Width = 361
    Height = 21
    EditLabel.Width = 30
    EditLabel.Height = 13
    EditLabel.Caption = 'Senha'
    PasswordChar = '*'
    TabOrder = 3
  end
end
