object FRMERPIntegracaoAutomatica: TFRMERPIntegracaoAutomatica
  Left = 176
  Top = 174
  Width = 696
  Height = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvDockPanel1: TAdvDockPanel
    Left = 591
    Top = 0
    Width = 97
    Height = 249
    Align = daRight
    MinimumSize = 3
    LockHeight = False
    Persistence.Location = plRegistry
    Persistence.Enabled = False
    UseRunTimeHeight = False
    Version = '5.0.4.6'
    object AdvToolBar1: TAdvToolBar
      Left = 1
      Top = 3
      Width = 81
      Height = 243
      AllowFloating = True
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'MS Sans Serif'
      CaptionFont.Style = []
      CompactImageIndex = -1
      FullSize = True
      TextAutoOptionMenu = 'Add or Remove Buttons'
      TextOptionMenu = 'Options'
      ParentOptionPicture = True
      ToolBarIndex = -1
      object Btsair: TAdvToolBarButton
        Left = 2
        Top = 77
        Width = 79
        Height = 56
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'MS Sans Serif'
        Appearance.CaptionFont.Style = []
        GlyphPosition = gpTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Position = daBottom
        ShowCaption = True
        Version = '5.0.4.6'
        OnClick = BtsairClick
      end
      object tbSepIcons: TAdvToolBarSeparator
        Left = 2
        Top = 67
        Width = 77
        Height = 10
        SeparatorStyle = ssBlank
        LineColor = clBtnShadow
      end
      object BtAtivar: TAdvToolBarButton
        Left = 2
        Top = 9
        Width = 79
        Height = 56
        Action = AcexportarAutomatico
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'MS Sans Serif'
        Appearance.CaptionFont.Style = []
        GlyphPosition = gpTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 2
        ParentFont = False
        Position = daBottom
        ShowCaption = True
        Version = '5.0.4.6'
        Visible = False
      end
      object AdvToolBarSeparator1: TAdvToolBarSeparator
        Left = 2
        Top = 65
        Width = 77
        Height = 2
        LineColor = clBtnShadow
      end
    end
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 591
    Height = 249
    Align = alClient
    TabOrder = 1
    UseDockManager = True
    Version = '2.0.2.0'
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    FullHeight = 0
    object AdvPicture1: TAdvPicture
      Left = 168
      Top = 48
      Width = 100
      Height = 100
      Animate = True
      Picture.Stretch = False
      Picture.Frame = 0
      Picture.Data = {
        47494638396110001000A2FF00FFFFFF6B6B6B9C9C9CC0C0C0EF8484EF5A5A6B
        101000000021F90401000003002C000000001000100000034138BADC1E2E8229
        629BD4AE3926D45E101895852942190518405A85D11A4554DC444EDC35C3FF40
        46E066281A6F9FC55086A12585CC89E179690D542B9108AB4800003B}
      PicturePosition = bpTopLeft
      Version = '1.4.0.0'
    end
  end
  object ActionList1: TActionList
    Left = 480
    Top = 184
    object AcexportarAutomatico: TAction
      Caption = 'Ativar'
      ImageIndex = 2
      OnExecute = AcexportarAutomaticoExecute
    end
    object acsair: TAction
      Caption = 'Sair'
    end
  end
  object TprocessaVendas: TTimer
    Enabled = False
    OnTimer = TprocessaVendasTimer
    Left = 304
    Top = 144
  end
end
