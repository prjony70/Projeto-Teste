object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  Caption = 'Registro de Vendas'
  ClientHeight = 405
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 336
    Width = 590
    Height = 15
    Align = alBottom
    Shape = bsBottomLine
    ExplicitTop = 344
  end
  object Bevel1: TBevel
    Left = 0
    Top = 209
    Width = 590
    Height = 20
    Align = alTop
    Shape = bsTopLine
  end
  object gpClientes: TGroupBox
    Left = 0
    Top = 0
    Width = 590
    Height = 121
    Align = alTop
    TabOrder = 1
    ExplicitLeft = -24
    ExplicitTop = 72
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object Label2: TLabel
      Left = 8
      Top = 67
      Width = 45
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object Label3: TLabel
      Left = 416
      Top = 67
      Width = 28
      Height = 13
      Caption = 'Bairro'
    end
    object Label4: TLabel
      Left = 343
      Top = 67
      Width = 12
      Height = 13
      Caption = 'N'#186
    end
    object Label5: TLabel
      Left = 8
      Top = 94
      Width = 33
      Height = 13
      Caption = 'Cidade'
    end
    object Label6: TLabel
      Left = 342
      Top = 94
      Width = 13
      Height = 13
      Caption = 'UF'
    end
    object Label7: TLabel
      Left = 188
      Top = 40
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object Label12: TLabel
      Left = 342
      Top = 40
      Width = 23
      Height = 13
      Caption = 'Data'
    end
    object Label13: TLabel
      Left = 8
      Top = 13
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object edNome_Cliente: TDBEdit
      Left = 57
      Top = 37
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      DataField = 'NOME_CLIENTE'
      DataSource = dmDados.dsVendas
      TabOrder = 0
      OnKeyUp = edNome_ClienteKeyUp
    end
    object edLogradouro: TDBEdit
      Left = 57
      Top = 64
      Width = 277
      Height = 21
      DataField = 'LOGRADOURO'
      DataSource = dmDados.dsVendas
      TabOrder = 2
    end
    object edBairro: TDBEdit
      Left = 450
      Top = 64
      Width = 107
      Height = 21
      DataField = 'BAIRRO'
      DataSource = dmDados.dsVendas
      TabOrder = 3
    end
    object edNumero: TDBEdit
      Left = 371
      Top = 64
      Width = 41
      Height = 21
      DataField = 'NUMERO'
      DataSource = dmDados.dsVendas
      TabOrder = 4
    end
    object edCidade: TDBEdit
      Left = 57
      Top = 91
      Width = 277
      Height = 21
      DataField = 'CIDADE'
      DataSource = dmDados.dsVendas
      TabOrder = 5
    end
    object edEstado: TDBEdit
      Left = 371
      Top = 91
      Width = 41
      Height = 21
      DataField = 'ESTADO'
      DataSource = dmDados.dsVendas
      TabOrder = 6
    end
    object edCEP: TDBEdit
      Left = 213
      Top = 37
      Width = 121
      Height = 21
      DataField = 'CEP'
      DataSource = dmDados.dsVendas
      TabOrder = 1
      OnExit = edCEPExit
    end
    object edData: TDBEdit
      Left = 371
      Top = 37
      Width = 107
      Height = 21
      DataField = 'DATA_VENDA'
      DataSource = dmDados.dsVendas
      ReadOnly = True
      TabOrder = 7
    end
    object edCodigo: TDBEdit
      Left = 57
      Top = 10
      Width = 121
      Height = 21
      DataField = 'COD_VENDA'
      DataSource = dmDados.dsVendas
      ReadOnly = True
      TabOrder = 8
    end
  end
  object gpItens: TGroupBox
    Left = 0
    Top = 231
    Width = 590
    Height = 105
    Align = alBottom
    Caption = 'Inclus'#227'o dos itens'
    TabOrder = 0
    ExplicitTop = 240
    object Label8: TLabel
      Left = 8
      Top = 22
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label9: TLabel
      Left = 242
      Top = 22
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label10: TLabel
      Left = 361
      Top = 22
      Width = 53
      Height = 13
      Caption = 'Pre'#231'o Unit.'
    end
    object Label11: TLabel
      Left = 8
      Top = 70
      Width = 43
      Height = 13
      Caption = 'Vlr. Total'
    end
    object lcbProdutos: TDBLookupComboBox
      Left = 57
      Top = 19
      Width = 168
      Height = 21
      DataField = 'COD_PRODUTO'
      DataSource = dmDados.dsVendasItens
      KeyField = 'COD_PRODUTO'
      ListField = 'DESCRICAO'
      ListSource = dmDados.dsCarregaProdutos
      TabOrder = 0
      OnClick = lcbProdutosClick
    end
    object edQuantidade: TDBEdit
      Left = 304
      Top = 19
      Width = 41
      Height = 21
      DataField = 'QUANTIDADE'
      DataSource = dmDados.dsVendasItens
      TabOrder = 1
    end
    object edPrecoUnit: TDBEdit
      Left = 420
      Top = 19
      Width = 69
      Height = 21
      DataField = 'PRECO_UNITARIO'
      DataSource = dmDados.dsVendasItens
      TabOrder = 2
    end
    object btnIncluirItem: TButton
      Left = 186
      Top = 68
      Width = 75
      Height = 25
      Caption = 'Incluir item'
      TabOrder = 3
      OnClick = btnIncluirItemClick
    end
    object btnAlterarItem: TButton
      Left = 267
      Top = 68
      Width = 75
      Height = 25
      Caption = 'Alterar item'
      TabOrder = 4
      OnClick = btnAlterarItemClick
    end
    object btnExcluirItem: TButton
      Left = 429
      Top = 68
      Width = 75
      Height = 25
      Caption = 'Excluir item'
      TabOrder = 5
      OnClick = btnExcluirItemClick
    end
    object btnCancelarItem: TButton
      Left = 348
      Top = 68
      Width = 75
      Height = 25
      Caption = 'Cancelar item'
      TabOrder = 6
      OnClick = btnCancelarItemClick
    end
    object btnGravarItem: TButton
      Left = 510
      Top = 68
      Width = 75
      Height = 25
      Caption = 'Gravar item'
      TabOrder = 7
      OnClick = btnGravarItemClick
    end
    object edValorTotal: TDBEdit
      Left = 57
      Top = 67
      Width = 69
      Height = 21
      DataField = 'VALOR_TOTAL'
      DataSource = dmDados.dsVendasItens
      TabOrder = 8
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 121
    Width = 590
    Height = 88
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object dbgItemVenda: TDBGrid
      Left = 0
      Top = 0
      Width = 590
      Height = 88
      Align = alClient
      DataSource = dmDados.dsVendasItens
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_PRODUTO'
          Title.Caption = 'C'#243'd. Prod.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Caption = 'Quantidade'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO_UNITARIO'
          Title.Caption = 'Vlr. Unit'#225'rio'
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Caption = 'Total'
          Width = 120
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 351
    Width = 590
    Height = 54
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitLeft = -8
    object btnNovo: TButton
      Left = 186
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnGravar: TButton
      Left = 510
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 1
      OnClick = btnGravarClick
    end
    object btnCancelar: TButton
      Left = 348
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnAlterar: TButton
      Left = 267
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 3
      OnClick = btnAlterarClick
    end
    object btnExcluir: TButton
      Left = 429
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
  end
  object ACBrCEP1: TACBrCEP
    ProxyPort = '8080'
    ContentsEncodingCompress = []
    NivelLog = 0
    PesquisarIBGE = True
    Left = 504
    Top = 72
  end
end
