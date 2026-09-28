object frmCadastroProdutos: TfrmCadastroProdutos
  Left = 0
  Top = 0
  Caption = 'Cadastro de Produtos'
  ClientHeight = 249
  ClientWidth = 518
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
  object Panel1: TPanel
    Left = 0
    Top = 89
    Width = 518
    Height = 119
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object dbgProdutos: TDBGrid
      Left = 0
      Top = 0
      Width = 518
      Height = 119
      Align = alClient
      DataSource = dmDados.dsProduto
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
          Title.Caption = 'C'#243'd.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 320
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO'
          Title.Caption = 'Pre'#231'o'
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 208
    Width = 518
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 183
    ExplicitWidth = 185
    object btnNovo: TButton
      Left = 115
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnAlterar: TButton
      Left = 196
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnCancelar: TButton
      Left = 277
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnGravar: TButton
      Left = 439
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Gravar'
      TabOrder = 3
      OnClick = btnGravarClick
    end
    object btnExcluir: TButton
      Left = 358
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 4
      OnClick = btnExcluirClick
    end
  end
  object pnlCampos: TPanel
    Left = 0
    Top = 0
    Width = 518
    Height = 83
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 8
      Top = 38
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label3: TLabel
      Left = 8
      Top = 65
      Width = 27
      Height = 13
      Caption = 'Pre'#231'o'
    end
    object edCodigo: TDBEdit
      Left = 63
      Top = 8
      Width = 121
      Height = 21
      DataField = 'COD_PRODUTO'
      DataSource = dmDados.dsProduto
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object edDescricao: TDBEdit
      Left = 63
      Top = 35
      Width = 354
      Height = 21
      DataField = 'DESCRICAO'
      DataSource = dmDados.dsProduto
      TabOrder = 1
    end
    object edPreco: TDBEdit
      Left = 63
      Top = 62
      Width = 121
      Height = 21
      DataField = 'PRECO'
      DataSource = dmDados.dsProduto
      TabOrder = 2
    end
  end
end
