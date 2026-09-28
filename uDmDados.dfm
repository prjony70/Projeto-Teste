object dmDados: TdmDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 270
  Width = 499
  object SQLConnection1: TSQLConnection
    ConnectionName = 'Petroshow'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver230.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=23.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver230.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=23.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'Database=C:\Base de dados\BANCO.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet=ISO8859_1'
      'Trim Char=False')
    Left = 32
    Top = 8
  end
  object qryVendas: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'COD_VENDA'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT * FROM VENDAS WHERE COD_VENDA = :COD_VENDA')
    SQLConnection = SQLConnection1
    Left = 160
    Top = 8
  end
  object qryVendasItens: TSQLQuery
    DataSource = dsLinkMestre
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'COD_VENDA'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT * FROM VENDAS_ITENS WHERE COD_VENDA = :COD_VENDA')
    SQLConnection = SQLConnection1
    Left = 32
    Top = 64
  end
  object dspVendas: TDataSetProvider
    DataSet = qryVendas
    Options = [poCascadeDeletes, poCascadeUpdates, poPropogateChanges, poUseQuoteChar]
    Left = 104
    Top = 8
  end
  object cdsVendas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVendas'
    OnNewRecord = cdsVendasNewRecord
    Left = 216
    Top = 8
    object cdsVendasCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
      Required = True
    end
    object cdsVendasDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
      Required = True
    end
    object cdsVendasNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Required = True
      Size = 400
    end
    object cdsVendasCEP: TStringField
      FieldName = 'CEP'
      EditMask = '99999-999;0;_'
      Size = 9
    end
    object cdsVendasLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 400
    end
    object cdsVendasNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 80
    end
    object cdsVendasBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 200
    end
    object cdsVendasCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 200
    end
    object cdsVendasESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 8
    end
    object cdsVendasVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
    object cdsVendasqryVendasItens: TDataSetField
      FieldName = 'qryVendasItens'
    end
  end
  object dsLinkMestre: TDataSource
    DataSet = qryVendas
    Left = 336
    Top = 8
  end
  object cdsVendasItens: TClientDataSet
    Aggregates = <>
    DataSetField = cdsVendasqryVendasItens
    Params = <>
    AfterInsert = cdsVendasItensAfterInsert
    Left = 112
    Top = 64
    object cdsVendasItensCOD_ITEM: TIntegerField
      FieldName = 'COD_ITEM'
      Required = True
    end
    object cdsVendasItensCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
      Required = True
    end
    object cdsVendasItensCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
      Required = True
    end
    object cdsVendasItensQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Required = True
      Precision = 18
      Size = 3
    end
    object cdsVendasItensPRECO_UNITARIO: TFMTBCDField
      FieldName = 'PRECO_UNITARIO'
      Required = True
      Precision = 18
      Size = 2
    end
    object cdsVendasItensVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Required = True
      Precision = 18
      Size = 2
    end
  end
  object dsVendas: TDataSource
    DataSet = cdsVendas
    OnStateChange = dsVendasStateChange
    Left = 272
    Top = 8
  end
  object dsVendasItens: TDataSource
    DataSet = cdsVendasItens
    OnStateChange = dsVendasItensStateChange
    Left = 192
    Top = 64
  end
  object qryProdutos: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM PRODUTOS ORDER BY DESCRICAO')
    SQLConnection = SQLConnection1
    Left = 32
    Top = 128
  end
  object dspProdutos: TDataSetProvider
    DataSet = qryProdutos
    Options = [poCascadeDeletes, poCascadeUpdates, poPropogateChanges, poUseQuoteChar]
    Left = 112
    Top = 128
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProdutos'
    AfterInsert = cdsProdutosAfterInsert
    Left = 184
    Top = 128
    object cdsProdutosCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object cdsProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Required = True
      Size = 400
    end
    object cdsProdutosPRECO: TFMTBCDField
      FieldName = 'PRECO'
      Required = True
      Precision = 18
      Size = 2
    end
  end
  object dsProduto: TDataSource
    DataSet = cdsProdutos
    OnStateChange = dsProdutoStateChange
    Left = 256
    Top = 128
  end
  object qryRelatorio: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'DATA_INICIO'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATA_FIM'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'SELECT * FROM VENDAS '
      'WHERE DATA_VENDA BETWEEN :DATA_INICIO AND :DATA_FIM'
      'ORDER BY DATA_VENDA')
    SQLConnection = SQLConnection1
    Left = 32
    Top = 192
  end
  object dspRelatorio: TDataSetProvider
    DataSet = qryRelatorio
    Options = [poCascadeDeletes, poCascadeUpdates, poPropogateChanges, poUseQuoteChar]
    Left = 112
    Top = 192
  end
  object cdsRelatorio: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspRelatorio'
    Left = 184
    Top = 192
    object cdsRelatorioCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
      Required = True
    end
    object cdsRelatorioDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
      Required = True
    end
    object cdsRelatorioNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Required = True
      Size = 400
    end
    object cdsRelatorioCEP: TStringField
      FieldName = 'CEP'
      Size = 36
    end
    object cdsRelatorioLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Size = 400
    end
    object cdsRelatorioNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 80
    end
    object cdsRelatorioBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 200
    end
    object cdsRelatorioCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 200
    end
    object cdsRelatorioESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 8
    end
    object cdsRelatorioVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 18
      Size = 2
    end
  end
  object dtsRelatorio: TDataSource
    DataSet = cdsRelatorio
    Left = 256
    Top = 192
  end
  object dsCarregaProdutos: TDataSource
    DataSet = qryProdutos
    OnStateChange = dsProdutoStateChange
    Left = 344
    Top = 128
  end
  object qryAuxiliar: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnection1
    Left = 384
    Top = 56
  end
end
