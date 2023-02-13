object FrmCBLSeltipodoc: TFrmCBLSeltipodoc
  Left = 213
  Top = 132
  Width = 696
  Height = 480
  Caption = 'Selecione os Tipos de Documento:'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object a: TAdvDockPanel
    Left = 591
    Top = 0
    Width = 97
    Height = 446
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
      Height = 440
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
      object btSair: TAdvToolBarButton
        Left = 2
        Top = 65
        Width = 79
        Height = 56
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'MS Sans Serif'
        Appearance.CaptionFont.Style = []
        GlyphPosition = gpTop
        Caption = 'Sair'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Position = daBottom
        ShowCaption = True
        Version = '5.0.4.6'
        OnClick = btSairClick
      end
      object btConfirmar: TAdvToolBarButton
        Left = 2
        Top = 9
        Width = 79
        Height = 56
        AutoSize = False
        Appearance.CaptionFont.Charset = DEFAULT_CHARSET
        Appearance.CaptionFont.Color = clWindowText
        Appearance.CaptionFont.Height = -11
        Appearance.CaptionFont.Name = 'MS Sans Serif'
        Appearance.CaptionFont.Style = []
        GlyphPosition = gpTop
        Caption = 'Confirmar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Position = daBottom
        ShowCaption = True
        Version = '5.0.4.6'
        OnClick = btConfirmarClick
      end
    end
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 591
    Height = 446
    Align = alClient
    BevelOuter = bvNone
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
    object AdvPanel2: TAdvPanel
      Left = 0
      Top = 0
      Width = 591
      Height = 97
      Align = alTop
      TabOrder = 0
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
      object Label2: TLabel
        Left = 24
        Top = 56
        Width = 3
        Height = 13
      end
      object LDOC1: TLabel
        Left = 7
        Top = 3
        Width = 360
        Height = 24
        Caption = 'Copiar Configura'#231#227'o do Tipo Documento:  '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object lpara: TLabel
        Left = 9
        Top = 63
        Width = 5
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object LDOC: TLabel
        Left = 7
        Top = 30
        Width = 5
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    object chLstTiposDocsPMs: TCheckListBox
      Left = 0
      Top = 97
      Width = 591
      Height = 349
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 20
      ParentFont = False
      TabOrder = 1
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 160
    object SelecionarTodos1: TMenuItem
      Caption = 'Selecionar Todos'
      OnClick = SelecionarTodos1Click
    end
    object Removerseleo1: TMenuItem
      Caption = 'Remover sele'#231#227'o'
      OnClick = Removerseleo1Click
    end
  end
end
