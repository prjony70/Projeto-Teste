object frmFiltroRelatorio: TfrmFiltroRelatorio
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Vendas'
  ClientHeight = 135
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 13
    Width = 43
    Height = 23
    Caption = 'Dt. In'#237'cio'
  end
  object Label2: TLabel
    Left = 16
    Top = 42
    Width = 34
    Height = 13
    Caption = 'Dt. Fim'
  end
  object dtpInicio: TDateTimePicker
    Left = 120
    Top = 13
    Width = 137
    Height = 21
    Date = 46216.971195069450000000
    Time = 46216.971195069450000000
    TabOrder = 0
  end
  object dtpFim: TDateTimePicker
    Left = 120
    Top = 40
    Width = 137
    Height = 21
    Date = 46216.971195069450000000
    Time = 46216.971195069450000000
    TabOrder = 1
  end
  object btnVisualizar: TBitBtn
    Left = 158
    Top = 88
    Width = 99
    Height = 25
    Caption = 'Relat'#243'rio'
    TabOrder = 2
    OnClick = btnVisualizarClick
  end
end
