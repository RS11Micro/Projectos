object FRMERP_ConfGeral: TFRMERP_ConfGeral
  Left = 258
  Top = 222
  Width = 498
  Height = 325
  Caption = 'Configura'#231#227'o geral'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object AdvDockPanel2: TAdvDockPanel
    Left = 393
    Top = 0
    Width = 97
    Height = 291
    Align = daRight
    MinimumSize = 3
    LockHeight = False
    Persistence.Location = plRegistry
    Persistence.Enabled = False
    UseRunTimeHeight = False
    Version = '5.0.4.6'
    object sbPanelLateral: TAdvToolBar
      Left = 1
      Top = 3
      Width = 81
      Height = 285
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
      object btCancelar: TAdvToolBarButton
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Position = daBottom
        ShowCaption = True
        Version = '5.0.4.6'
        OnClick = btCancelarClick
      end
    end
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 393
    Height = 291
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
    object AdvGroupBox1: TAdvGroupBox
      Left = 1
      Top = 1
      Width = 391
      Height = 289
      Align = alClient
      TabOrder = 0
      object Label3: TLabel
        Left = 3
        Top = 40
        Width = 233
        Height = 13
        Caption = 'Temporizador para processamento da informa'#231#227'o'
        Transparent = True
      end
      object Label4: TLabel
        Left = 5
        Top = 78
        Width = 162
        Height = 13
        Caption = 'Reiniciar Automaticamente a cada'
        Transparent = True
      end
      object Label1: TLabel
        Left = 317
        Top = 43
        Width = 52
        Height = 13
        Caption = '(segundos)'
        Transparent = True
      end
      object Label2: TLabel
        Left = 317
        Top = 75
        Width = 32
        Height = 13
        Caption = '(horas)'
        Transparent = True
      end
      object spinreinicioHoras: TAdvSpinEdit
        Left = 240
        Top = 72
        Width = 73
        Height = 22
        Value = 0
        DateValue = 43777.7540822106
        HexValue = 0
        Ctl3D = True
        Enabled = True
        IncrementFloat = 0.1
        IncrementFloatPage = 1
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        MaxValue = 150000
        ParentCtl3D = False
        TabOrder = 0
        Visible = True
        Version = '1.4.8.0'
      end
      object spintemporizador: TAdvSpinEdit
        Left = 240
        Top = 40
        Width = 73
        Height = 22
        Value = 10
        FloatValue = 10
        HexValue = 0
        Ctl3D = True
        Enabled = True
        IncrementFloat = 0.1
        IncrementFloatPage = 1
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        MaxValue = 150000
        MinValue = 10
        ParentCtl3D = False
        TabOrder = 1
        Visible = True
        Version = '1.4.8.0'
      end
      object cbexportacaoautomatica: TAdvOfficeCheckBox
        Left = 0
        Top = 0
        Width = 257
        Height = 20
        TabOrder = 2
        Alignment = taLeftJustify
        Caption = 'Exporta'#231#227'o Autom'#225'tica'
        ReturnIsTab = False
        Version = '1.3.1.0'
      end
      object AdvGroupBox2: TAdvGroupBox
        Left = 8
        Top = 104
        Width = 329
        Height = 105
        TabOrder = 3
        object lbsbHoraInicio: TLabel
          Left = 12
          Top = 32
          Width = 53
          Height = 13
          Caption = 'Hora In'#237'cio'
          Transparent = True
        end
        object lbsbHoraFim: TLabel
          Left = 13
          Top = 64
          Width = 42
          Height = 13
          Caption = 'Hora Fim'
          Transparent = True
        end
        object edHoraInicio: TAdvSpinEdit
          Left = 86
          Top = 31
          Width = 65
          Height = 22
          SpinType = sptTime
          Value = 0
          HexValue = 0
          Ctl3D = True
          EditAlign = eaRight
          Enabled = True
          FocusColor = clNone
          IncrementFloat = 0.1
          IncrementFloatPage = 1
          IncrementMinutes = 5
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          ParentCtl3D = False
          ShowSeconds = False
          TabOrder = 0
          Visible = True
          Version = '1.4.8.0'
        end
        object edHoraFim: TAdvSpinEdit
          Left = 86
          Top = 59
          Width = 65
          Height = 22
          SpinType = sptTime
          Value = 0
          HexValue = 0
          Ctl3D = True
          EditAlign = eaRight
          Enabled = True
          FocusColor = clNone
          IncrementFloat = 0.1
          IncrementFloatPage = 1
          IncrementMinutes = 5
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          ParentCtl3D = False
          ShowSeconds = False
          TabOrder = 1
          Visible = True
          Version = '1.4.8.0'
        end
        object cbIntegracaoEntreHoras: TAdvOfficeCheckBox
          Left = 8
          Top = 4
          Width = 257
          Height = 20
          TabOrder = 2
          Alignment = taLeftJustify
          Caption = 'Integra'#231#227'o entre horas'
          ReturnIsTab = False
          Version = '1.3.1.0'
        end
      end
      object gbmodulo: TAdvOfficeRadioGroup
        Left = 8
        Top = 216
        Width = 209
        Height = 65
        Version = '1.3.1.0'
        Caption = 'M'#243'dulo'
        TabOrder = 4
        ItemIndex = 0
        Items.Strings = (
          'Gest'#227'o Primavera'
          'Contabilidade Primavera')
        Ellipsis = False
      end
    end
  end
end
