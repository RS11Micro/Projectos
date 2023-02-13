object FRMCBLPaisMercado: TFRMCBLPaisMercado
  Left = 192
  Top = 133
  Width = 696
  Height = 480
  Caption = 'Pais-Mercado'
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
  object epimagem: TSBEditProcura
    Left = 2
    Top = 73
    Width = 0
    Height = 21
    Enabled = True
    TabOrder = 0
    FormatoAntigo = False
    Obrigatorio = False
    ReadOnly = False
    BtListaVisivel = True
  end
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
        Action = acSair
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
      end
      object btConfirmar: TAdvToolBarButton
        Left = 2
        Top = 9
        Width = 79
        Height = 56
        Action = AcConfirmar
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
      end
    end
  end
  object Grelha: TAdvStringGrid
    Left = 0
    Top = 0
    Width = 591
    Height = 446
    Cursor = crDefault
    Align = alClient
    DefaultRowHeight = 21
    RowCount = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect]
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 2
    OnCanEditCell = GrelhaCanEditCell
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'MS Sans Serif'
    ActiveCellFont.Style = [fsBold]
    CellNode.TreeColor = clSilver
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'MS Sans Serif'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    EnhRowColMove = False
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'MS Sans Serif'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FixedRowHeight = 40
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    Navigation.AllowClipboardAlways = True
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    ScrollWidth = 16
    SearchFooter.FindNextCaption = 'Find next'
    SearchFooter.FindPrevCaption = 'Find previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SortSettings.IgnoreBlanks = True
    SortSettings.BlankPos = blLast
    Version = '5.6.2.0'
    ColWidths = (
      64
      64
      64
      64
      64)
    RowHeights = (
      40
      21
      21
      21
      21)
  end
  object ActionList1: TActionList
    Left = 400
    Top = 96
    object acSair: TAction
      Caption = 'Sair'
      OnExecute = acSairExecute
    end
    object AcConfirmar: TAction
      Caption = 'Confirmar'
      OnExecute = AcConfirmarExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 168
    Top = 168
    object RemoveSeleo1: TMenuItem
      Caption = 'Remove Sele'#231#227'o'
      OnClick = RemoveSeleo1Click
    end
    object SelecionaTodos1: TMenuItem
      Caption = 'Seleciona Todos'
      OnClick = SelecionaTodos1Click
    end
    object AtribuiMercado1: TMenuItem
      Caption = 'Atribui Mercado(Linhas Selecionadas)'
      object Nacional1: TMenuItem
        Tag = 1
        Caption = 'Nacional'
        OnClick = Nacional1Click
      end
      object InterComunitario1: TMenuItem
        Tag = 2
        Caption = 'InterComunit'#225'rio'
        OnClick = InterComunitario1Click
      end
      object ExtraComunitrio1: TMenuItem
        Tag = 3
        Caption = 'ExtraComunit'#225'rio'
        OnClick = ExtraComunitrio1Click
      end
    end
    object AtribuiMercadoSugAutomtica1: TMenuItem
      Caption = 'Atribui Mercado(Sugest'#227'o.Autom'#225'tica) '
      OnClick = AtribuiMercadoSugAutomtica1Click
    end
  end
end
