object DataModu: TDataModu
  OldCreateOrder = False
  Height = 198
  Width = 520
  object ConexaoBD: TFDConnection
    Params.Strings = (
      'Database=C:\PostoCombustivel\DBPOSTO.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Server=localhost'
      'DriverID=FB')
    Left = 160
    Top = 16
  end
  object FDConnectionFirebird: TFDPhysFBDriverLink
    Left = 248
    Top = 16
  end
  object query: TFDQuery
    Connection = ConexaoBD
    Left = 16
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 16
  end
end
