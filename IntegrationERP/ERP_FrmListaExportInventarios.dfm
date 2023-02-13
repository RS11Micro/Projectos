object FrmERPListaExportInventarios: TFrmERPListaExportInventarios
  Left = 110
  Top = 165
  Width = 855
  Height = 540
  Caption = 'Listas de Invent'#225'rios exportados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object AdvDockPanel1: TAdvDockPanel
    Left = 750
    Top = 0
    Width = 97
    Height = 506
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
      Height = 500
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
        Top = 133
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
        Top = 123
        Width = 77
        Height = 10
        SeparatorStyle = ssBlank
        LineColor = clBtnShadow
      end
      object BtActualizar: TAdvToolBarButton
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
        OnClick = BtActualizarClick
      end
      object AdvToolBarSeparator1: TAdvToolBarSeparator
        Left = 2
        Top = 121
        Width = 77
        Height = 2
        LineColor = clBtnShadow
      end
      object btLimpar: TAdvToolBarButton
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
      end
    end
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 750
    Height = 506
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
    object panelFiltros: TAdvPanel
      Left = 0
      Top = 0
      Width = 750
      Height = 70
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
      object AdvGroupBox1: TAdvGroupBox
        Left = 8
        Top = 0
        Width = 309
        Height = 54
        Caption = 'Filtro Datas'
        TabOrder = 0
        object Inicio: TLabel
          Left = 9
          Top = 20
          Width = 25
          Height = 13
          Caption = 'Inicio'
          Transparent = True
        end
        object TLabel
          Left = 169
          Top = 20
          Width = 16
          Height = 13
          Caption = 'Fim'
          Transparent = True
        end
        object dtdataInicio: TPlannerMaskDatePicker
          Left = 56
          Top = 18
          Width = 103
          Height = 21
          Color = clWindow
          Ctl3D = True
          Enabled = True
          EditMask = '!99-99-9999;1;_'
          MaxLength = 10
          ParentCtl3D = False
          TabOrder = 0
          Text = '  -  -    '
          Visible = True
          AutoFocus = False
          Flat = False
          FlatLineColor = clBlack
          FlatParentColor = True
          ShowModified = False
          FocusColor = clWindow
          FocusBorder = False
          FocusFontColor = clBlack
          LabelAlwaysEnabled = False
          LabelPosition = lpLeftTop
          LabelMargin = 4
          LabelTransparent = False
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          ModifiedColor = clRed
          SelectFirstChar = False
          Version = '1.5.0.7'
          ButtonStyle = bsButton
          ButtonWidth = 16
          Etched = False
          Glyph.Data = {
            76020000424D760200000000000036000000280000000C0000000C0000000100
            2000000000004002000000000000000000000000000000000000C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D40000000000C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400000000000000
            000000000000C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D4000000000000000000000000000000000000000000C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D4000000000000000000000000000000
            0000000000000000000000000000C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400}
          HideCalendarAfterSelection = True
          object TPlannerCalendar
            Left = 0
            Top = 0
            Width = 180
            Height = 180
            EventDayColor = clBlack
            EventMarkerColor = clYellow
            EventMarkerShape = evsCircle
            BackgroundPosition = bpTiled
            BevelOuter = bvNone
            BorderWidth = 1
            Look = lookFlat
            DateDownColor = clNone
            DateHoverColor = clNone
            DayFont.Charset = DEFAULT_CHARSET
            DayFont.Color = clWindowText
            DayFont.Height = -11
            DayFont.Name = 'MS Sans Serif'
            DayFont.Style = []
            WeekFont.Charset = DEFAULT_CHARSET
            WeekFont.Color = clWindowText
            WeekFont.Height = -11
            WeekFont.Name = 'MS Sans Serif'
            WeekFont.Style = []
            WeekName = 'Wk'
            TextColor = clBlack
            SelectColor = clTeal
            SelectFontColor = clWhite
            InActiveColor = clGray
            HeaderColor = clNone
            FocusColor = clHighlight
            InversColor = clTeal
            WeekendColor = clRed
            NameOfDays.Monday = 'seg'
            NameOfDays.Tuesday = 'ter'
            NameOfDays.Wednesday = 'qua'
            NameOfDays.Thursday = 'qui'
            NameOfDays.Friday = 'sex'
            NameOfDays.Saturday = 's'#225'b'
            NameOfDays.Sunday = 'dom'
            NameOfMonths.January = 'Jan'
            NameOfMonths.February = 'Fev'
            NameOfMonths.March = 'Mar'
            NameOfMonths.April = 'Abr'
            NameOfMonths.May = 'Mai'
            NameOfMonths.June = 'Jun'
            NameOfMonths.July = 'Jul'
            NameOfMonths.August = 'Ago'
            NameOfMonths.September = 'Set'
            NameOfMonths.October = 'Out'
            NameOfMonths.November = 'Nov'
            NameOfMonths.December = 'Dez'
            NameOfMonths.UseIntlNames = True
            StartDay = 7
            TodayFormat = '"Today" DDD/mm, YYYY'
            Day = 26
            Month = 6
            Year = 2009
            TabOrder = 0
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            CaptionColor = clNone
            CaptionTextColor = clBlack
            LineColor = clGray
            Line3D = True
            GradientStartColor = clWhite
            GradientEndColor = clBtnFace
            GradientDirection = gdVertical
            MonthGradientStartColor = clNone
            MonthGradientEndColor = clNone
            MonthGradientDirection = gdHorizontal
            HintPrevYear = 'Previous Year'
            HintPrevMonth = 'Previous Month'
            HintNextMonth = 'Next Month'
            HintNextYear = 'Next Year'
            Version = '1.9.1.0'
          end
        end
        object dtdataFim: TPlannerMaskDatePicker
          Left = 200
          Top = 16
          Width = 103
          Height = 21
          Color = clWindow
          Ctl3D = True
          Enabled = True
          EditMask = '!99-99-9999;1;_'
          MaxLength = 10
          ParentCtl3D = False
          TabOrder = 1
          Text = '  -  -    '
          Visible = True
          AutoFocus = False
          Flat = False
          FlatLineColor = clBlack
          FlatParentColor = True
          ShowModified = False
          FocusColor = clWindow
          FocusBorder = False
          FocusFontColor = clBlack
          LabelAlwaysEnabled = False
          LabelPosition = lpLeftTop
          LabelMargin = 4
          LabelTransparent = False
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = clWindowText
          LabelFont.Height = -11
          LabelFont.Name = 'MS Sans Serif'
          LabelFont.Style = []
          ModifiedColor = clRed
          SelectFirstChar = False
          Version = '1.5.0.7'
          ButtonStyle = bsButton
          ButtonWidth = 16
          Etched = False
          Glyph.Data = {
            76020000424D760200000000000036000000280000000C0000000C0000000100
            2000000000004002000000000000000000000000000000000000C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D40000000000C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400000000000000
            000000000000C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D4000000000000000000000000000000000000000000C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D4000000000000000000000000000000
            0000000000000000000000000000C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0
            D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400C8D0D400}
          HideCalendarAfterSelection = True
          object TPlannerCalendar
            Left = 0
            Top = 0
            Width = 180
            Height = 180
            EventDayColor = clBlack
            EventMarkerColor = clYellow
            EventMarkerShape = evsCircle
            BackgroundPosition = bpTiled
            BevelOuter = bvNone
            BorderWidth = 1
            Look = lookFlat
            DateDownColor = clNone
            DateHoverColor = clNone
            DayFont.Charset = DEFAULT_CHARSET
            DayFont.Color = clWindowText
            DayFont.Height = -11
            DayFont.Name = 'MS Sans Serif'
            DayFont.Style = []
            WeekFont.Charset = DEFAULT_CHARSET
            WeekFont.Color = clWindowText
            WeekFont.Height = -11
            WeekFont.Name = 'MS Sans Serif'
            WeekFont.Style = []
            WeekName = 'Wk'
            TextColor = clBlack
            SelectColor = clTeal
            SelectFontColor = clWhite
            InActiveColor = clGray
            HeaderColor = clNone
            FocusColor = clHighlight
            InversColor = clTeal
            WeekendColor = clRed
            NameOfDays.Monday = 'seg'
            NameOfDays.Tuesday = 'ter'
            NameOfDays.Wednesday = 'qua'
            NameOfDays.Thursday = 'qui'
            NameOfDays.Friday = 'sex'
            NameOfDays.Saturday = 's'#225'b'
            NameOfDays.Sunday = 'dom'
            NameOfMonths.January = 'Jan'
            NameOfMonths.February = 'Fev'
            NameOfMonths.March = 'Mar'
            NameOfMonths.April = 'Abr'
            NameOfMonths.May = 'Mai'
            NameOfMonths.June = 'Jun'
            NameOfMonths.July = 'Jul'
            NameOfMonths.August = 'Ago'
            NameOfMonths.September = 'Set'
            NameOfMonths.October = 'Out'
            NameOfMonths.November = 'Nov'
            NameOfMonths.December = 'Dez'
            NameOfMonths.UseIntlNames = True
            StartDay = 7
            TodayFormat = '"Today" DDD/mm, YYYY'
            Day = 26
            Month = 6
            Year = 2009
            TabOrder = 0
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            CaptionColor = clNone
            CaptionTextColor = clBlack
            LineColor = clGray
            Line3D = True
            GradientStartColor = clWhite
            GradientEndColor = clBtnFace
            GradientDirection = gdVertical
            MonthGradientStartColor = clNone
            MonthGradientEndColor = clNone
            MonthGradientDirection = gdHorizontal
            HintPrevYear = 'Previous Year'
            HintPrevMonth = 'Previous Month'
            HintNextMonth = 'Next Month'
            HintNextYear = 'Next Year'
            Version = '1.9.1.0'
          end
        end
      end
      object RbIntegracao: TAdvOfficeRadioGroup
        Left = 622
        Top = -1
        Width = 118
        Height = 67
        Version = '1.3.1.0'
        Caption = 'Integra'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        ItemIndex = 2
        Items.Strings = (
          'Por Integrar'
          'Integrados'
          'Todos')
        Ellipsis = False
      end
    end
    object PanelCabecalhos: TAdvPanel
      Left = 0
      Top = 70
      Width = 750
      Height = 154
      Align = alTop
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
      object GridERPCAb: TDBAdvGrid
        Left = 1
        Top = 1
        Width = 748
        Height = 152
        Cursor = crDefault
        Align = alClient
        ColCount = 2
        RowCount = 2
        FixedRows = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
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
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'MS Sans Serif'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FixedColWidth = 20
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
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
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'MS Sans Serif'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SelectionRectangle = True
        SelectionTextColor = 4227072
        Version = '2.3.0.2'
        AutoCreateColumns = True
        AutoRemoveColumns = True
        Columns = <
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 20
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'Tahoma'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'Tahoma'
            PrintFont.Style = []
            Width = 40
          end>
        DataSource = Ds_ErpCab
        InvalidPicture.Data = {
          055449636F6E0000010001002020040000000000E80200001600000028000000
          2000000040000000010004000000000000020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000000000000000000000000000000001111111100000
          0000000000000000011111111111100000000000000000011111111111111110
          0000000000000111111111111111111110000000000011111111111111111111
          1100000000011111111111111111111111100000001111117711111111117111
          1110000000111111FF7111111117FF111111000001111118FFF91111117FFFF1
          1111100001111178FFFF711117FFFFF711111000911111178FFFF9117FFFF871
          111110001111199178FFFF97FFFF87111111110011119999178FFFFFFFFF7191
          11111100111999999178FFFFFFF7199911111100119999999997FFFFFF899999
          91111100199999999997FFFFFF9999999911110099999999999FFFFFFFF99999
          999111009999999999FFFFFFFFFF999999911100999999999FFFFF778FFFF999
          99911100999999998FFF879978FFFF999999910099999978FFF87999978FFFF7
          9999910009999978FF8799999978FF8799999000099999978879999999978879
          9999100000999999779999999999779999990000009999977799999999999999
          9991000000099997888879999999999999100000000099978888888888779999
          9900000000000999788888888887999990000000000000999788888888799991
          0000000000000000999788888799991000000000000000000099999999999000
          00000000FF8000FFFF00007FFE00001FF800000FF0000007F0000007E0000003
          C0000001C0000001800000018000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000180000001
          80000003C0000003C0000007E000000FF000001FF800003FFC0000FFFF0001FF
          FFC007FF}
        ShowUnicode = False
        ColWidths = (
          20
          40)
      end
    end
    object PanelLinhas: TAdvPanel
      Left = 0
      Top = 224
      Width = 750
      Height = 282
      Align = alClient
      TabOrder = 2
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
        Left = 1
        Top = 1
        Width = 748
        Height = 16
        Align = alTop
        BevelOuter = bvNone
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
      end
      object GridErpDetalhes: TDBAdvGrid
        Left = 1
        Top = 17
        Width = 748
        Height = 264
        Cursor = crDefault
        Align = alClient
        ColCount = 19
        RowCount = 2
        FixedRows = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
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
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'MS Sans Serif'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FixedColWidth = 20
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.4f'
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
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'MS Sans Serif'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        Version = '2.3.0.2'
        AutoCreateColumns = True
        AutoRemoveColumns = True
        Columns = <
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 20
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 115
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end
          item
            Borders = []
            BorderPen.Color = clSilver
            CheckFalse = 'N'
            CheckTrue = 'Y'
            Color = clWindow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = []
            PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
            PrintFont.Charset = DEFAULT_CHARSET
            PrintFont.Color = clWindowText
            PrintFont.Height = -11
            PrintFont.Name = 'MS Sans Serif'
            PrintFont.Style = []
            Width = 64
          end>
        DataSource = DS_ERPDetalhes
        InvalidPicture.Data = {
          055449636F6E0000010001002020040000000000E80200001600000028000000
          2000000040000000010004000000000000020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000000000000000000000000000000001111111100000
          0000000000000000011111111111100000000000000000011111111111111110
          0000000000000111111111111111111110000000000011111111111111111111
          1100000000011111111111111111111111100000001111117711111111117111
          1110000000111111FF7111111117FF111111000001111118FFF91111117FFFF1
          1111100001111178FFFF711117FFFFF711111000911111178FFFF9117FFFF871
          111110001111199178FFFF97FFFF87111111110011119999178FFFFFFFFF7191
          11111100111999999178FFFFFFF7199911111100119999999997FFFFFF899999
          91111100199999999997FFFFFF9999999911110099999999999FFFFFFFF99999
          999111009999999999FFFFFFFFFF999999911100999999999FFFFF778FFFF999
          99911100999999998FFF879978FFFF999999910099999978FFF87999978FFFF7
          9999910009999978FF8799999978FF8799999000099999978879999999978879
          9999100000999999779999999999779999990000009999977799999999999999
          9991000000099997888879999999999999100000000099978888888888779999
          9900000000000999788888888887999990000000000000999788888888799991
          0000000000000000999788888799991000000000000000000099999999999000
          00000000FF8000FFFF00007FFE00001FF800000FF0000007F0000007E0000003
          C0000001C0000001800000018000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000180000001
          80000003C0000003C0000007E000000FF000001FF800003FFC0000FFFF0001FF
          FFC007FF}
        ShowUnicode = False
        ColWidths = (
          20
          64
          115
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64
          64)
      end
    end
  end
  object TB_ERPCaB: TADOTable
    CursorType = ctStatic
    TableName = 'ERP_CabInventario'
    Left = 224
    Top = 64
  end
  object Ds_ErpCab: TDataSource
    DataSet = TB_ERPCaB
    Left = 360
    Top = 128
  end
  object DS_ERPDetalhes: TDataSource
    DataSet = Tb_ErpDetalhes
    Left = 200
    Top = 208
  end
  object Tb_ErpDetalhes: TADOTable
    CursorType = ctStatic
    LockType = ltReadOnly
    IndexFieldNames = 'id_inventario'
    MasterFields = 'id_inventario'
    MasterSource = Ds_ErpCab
    TableName = 'Erp_LinhasInventario'
    Left = 160
    Top = 256
  end
  object ActionList1: TActionList
    Left = 480
    Top = 24
    object acRemover: TAction
      Caption = 'Remover-Invent'#225'rio'
      OnExecute = acRemoverExecute
    end
  end
  object MensagemInformacao: TAdvSmoothMessageDialog
    FormStyle = fsStayOnTop
    ButtonAreaFill.Color = clWhite
    ButtonAreaFill.ColorTo = clWhite
    ButtonAreaFill.ColorMirror = clNone
    ButtonAreaFill.ColorMirrorTo = clNone
    ButtonAreaFill.GradientType = gtNone
    ButtonAreaFill.PictureWidth = 75
    ButtonAreaFill.PictureHeight = 75
    ButtonAreaFill.Opacity = 0
    ButtonAreaFill.OpacityTo = 100
    ButtonAreaFill.BorderColor = clNone
    ButtonAreaFill.Rounding = 0
    ButtonAreaFill.RoundingType = rtBottom
    ButtonAreaFill.ShadowOffset = 0
    Buttons = <
      item
        Spacing = 0
        Caption = 'OK'
        Color = 14862279
        ColorDown = 10966614
        BorderColor = clWhite
        Opacity = 200
      end>
    ButtonSpacing = 10
    Caption = 'MensagemInformacao'
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = 15066597
    CaptionFont.Height = -21
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = [fsBold]
    ButtonFont.Charset = DEFAULT_CHARSET
    ButtonFont.Color = clWhite
    ButtonFont.Height = -32
    ButtonFont.Name = 'Tahoma'
    ButtonFont.Style = [fsBold]
    CaptionFill.Color = clWhite
    CaptionFill.ColorTo = 6702148
    CaptionFill.ColorMirror = clNone
    CaptionFill.ColorMirrorTo = clNone
    CaptionFill.HatchStyle = HatchStyleForwardDiagonal
    CaptionFill.PicturePosition = ppCustom
    CaptionFill.PictureLeft = 10
    CaptionFill.PictureTop = 10
    CaptionFill.PictureSize = psCustom
    CaptionFill.PictureWidth = 70
    CaptionFill.PictureHeight = 70
    CaptionFill.Opacity = 88
    CaptionFill.OpacityTo = 0
    CaptionFill.BorderColor = clNone
    CaptionFill.Rounding = 6
    CaptionFill.RoundingType = rtTop
    CaptionFill.ShadowOffset = 0
    CaptionLocation = hlTopCenter
    CaptionHeight = 0
    Fill.Color = 6702148
    Fill.ColorTo = 7688015
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.HatchStyle = HatchStyleForwardDiagonal
    Fill.BackGroundPicture.Data = {
      89504E470D0A1A0A0000000D4948445200000040000000400806000000AA6971
      DE000009AB4944415478DAED9B097414451AC7BFAAEA9E9E9E994C66215C8695
      FB9498800464518E051F82082AA724E150765D70770165D75D39DE5B41F6EDA2
      A0BE278A2B2E7209AB2C2E0BECA25CE11248C8414248389E2C9010128E5C33D3
      33DD55B53D09204DAE19322107FEDFCB7BDD3555D55FFDAAFAFBEAE82078C085
      EADA80BAD68F00EAF2E12CF165091427E027367A1E28003C739E1D446125D8F0
      587EFC000597B219B03403BFB0BBE8C10090F4EAB7D0ACCD50104C0067D200B2
      D38133BA0BC7243ED5E801B0B4B99311E39F83100E40959B440840C676E0984D
      C1130EAE69B40058E6421B70CF2944435B83EA32FEA852E027B65E0247AB6E78
      ECAE92C609E0DC5B8B4013E683D3D7787E9725BA29FFCB0028BEB818C7252C68
      7400D8F9A5ED00B30C28D0CCA03A2BCEE47B1512372BE068D61D4F8CFFBE7101
      B8BCFC4B709BC6C2F58B5567CCCB06C849FA0A4F3F39AED10060391F0E4282BC
      87E75C46A05613E9901E1992B773B0CA43F0A4437B1B3C0076690501513B0E6E
      4724E4A5FB57A8A4580F8FBB5321B4D563FAAB401B36800BCB5E01F3431FC305
      DDC151B79F56E9BEE0CC51FDC2FD2B1C7364658305C0CEFEC5A18FE82CAE8435
      876B198115F6F57BC6B63C7D1474C113F615344C00590B9681B9CD1C9E734AF7
      F03CE0F228EFBC1E16CF2FC77149AF3538002CF5F75D419252B95336812BEFDE
      2AC122A033DF78C1E288C4E3E3331B1680A499DBB9103E82175CA99981EE4240
      579276E0C969CF341800ECD04B2340B26D638A8880D670A58B4D80B31338203A
      124F38BCA3DE03A07B634D08A927B8F47017AEB82ACCC33883422F0126B728F5
      0D44C9058754B9298851403987B2B8DCEC5132768FB75E0360DF3C3F07CC61CB
      2895F4C6B10AF3384D0F81ADCF1CC0825C06CD530CAE637F050BBD5189950470
      E13940CAF5D7F0C423CBEB2D00BA637418E2CA191AD2DD016AE5315F6D330AE4
      0EC38D5032368194BBAFF2CA890948767C01979A742263F75EAD9700D896819F
      707BFB5F3066AA329FD669821E1D071BD2DC595B40BCB8B3CA72D87B0350E1D9
      BFE14949BFAC7700E8E64151FA8A364173F4104053AACEDB5107D06EA811803E
      0284EC5D553F844820E427681C9BA2C9F88329F50A00DBD0731F6B1A3990715C
      3DAC0E63C0DC718421CD757203889776575B168306F85A6A3C8E491D546F00D0
      8D7DC721D1FA0FD5D65127A1569FBFFD7320771E650490BE16844B7E2CFE745F
      20166501D7DCE3C9C4A35FD63900BAE94933520B4F6961D16D39D5FC2AA3B51F
      0D96AECF1BD2DCA99FE94E6EBF7F461302C2D584F3CCD4A49B303E5EF1AB506D
      01601B7ACFE396968B55A169A561AF1CB4F6CF82A5BB71BFC39DFC893EE139E8
      A7D51844550F04EE2BF3C9A4C4B7EB0C00DDD83F1C315796EAE865E5AAFF1D41
      DB0D074B448C1140D24AC0970EF86FB828837823D1C984902EC28403D9750280
      ADEFB98EDADAC768DC145039DAF669B0464E36A4B91257F83F026E4A401E2025
      DFAFC731C9B1F71D00FDA26F3F84F0418FA533AE2EEC952BDB4E071035D590E6
      3CFA01909CC38119219841726532C6D113C28B47BEBB6F00B42F7E86312DF94E
      0BE9DE47D302DFB1E26D8682E531E35CC6A9CF70714EE06D1004DD2116671C63
      C4DE4F78F1A07F4EA8A600E886E8A920DAFEEEC1FA6286561FF6CA0168FB73B0
      44CF34A4951C5AAA8F80A3811B43449068AEDE2BCE696452C2EA5A07A06DE817
      8299F394D71A114E3DAE408B97C907A0EFAF8D00E21701CE4DBEA7EA882483C9
      999ECDB0AD9B30E97071AD02A0EB7A2E61E6567FF4AA3EC717F836974FBCED60
      B03E3ECB9056BC672190BC13F7549FAF1926D10358C9FD33894D7EB3D60068EB
      FB76C0484D57844E66EEBDC7DE2F053008ACFDEFD8E6E31C8A772DA80100DF71
      8205CCEA698581D443883972AE5600B075919B35A9ED0B5E77E0EFBD01409B01
      601BF0860140D1CE3780E49FAC51BDA24C40F45CF8278E4D1D137400DABAE821
      4810BF75D3162890494F8500DA0E8090817F300028DC3E1BC8B53335AAD73739
      92F165AE4FC99F126213AA5F59F90B405DD7570F36CE248FD8314273DDFBD0BF
      25F6D3FE601FB2F08EF6EB23E0DFBF0172BD66007C122C1690D4736914ACBDC4
      D823D52E4EFC02A0ADED35034CA12BDC4E49B7DEBF054F95005A47837DD81223
      802DAF00B91184036122802CBBF55E2B9929C41DFFA8C600D4B57D7E429092E5
      86F6CDA82B389FF0B0168F80FDD9F7012174130083A24D71808B7383523FB1D8
      418673F9945BBA8871476F5495B75A00746DE4FB546CF95B7761F03EE4E2820C
      B671AB8084B42ABDF7E66781F2F54CBF5793FE480E9580A8B91F90B8D45955E5
      AB1280BAA6777742784A89A7B9C83D4E08AA243B909611FA70A0402FA7EAEF99
      9F07A77E0A4936B049B92AA5244A9C9C50E9C1649500D8DA88FF7A50F8304FC1
      7DFB6427A8921C369078F64E1C97F674C000B4353D4782206F2D299050A0AB3D
      7FC56E1E9862544B27747A58B485BA39573DA3C42949DBFC06A07EDEDB44B092
      EED25A77520B837F32ED7BD3958E8341EA3CA4F4DE737A3798CFEE85EAB753EF
      814168285884EC331A35F7304D4D2C77AA5421006D4DD4EB8C38DE71E6E93DCF
      83FF8186DA7302840D980D0893D27BAEFB81ABFBDF03317953F0096001AC6122
      605A34579892F26EB500D4D5BD9A13819E2E2E69164A4B6AA1F71106DBF4AF75
      1FD8CA90EED14360C9A7A301B3E045825B12421C60B3E6156AAAD0D9342DC970
      565F0E005DF3E8A72A0F7BD9957BC3FF270402409FA884BEBA0B04B3DD90AE29
      C550F8E150BDA76AB6CEA84C96960E10D1B55564F289E995025057F7EC854572
      AC285F224CA93DCF2F3FB318E41E230D69EE933BC0BD2DA0956C40C2E610B087
      B92855791FD3B4E4A40A01B0B53DE25D9E66033C79413B7BAC5892152CC3E683
      D4A5EC78CC93B50B5C3B17EB17419E6BDC2573F330904DF9FBF1E4F481E50078
      56453D8925797FD14545F77B413D82AF5C379DA06F32743F840409ECE126601E
      6580343DE5800140D147117339752C55AFD572EFD7B1C4A64D0191C2DFD967A4
      BD6300706C618F37DB61FA766D84BD7A253D2C9EA7785EF45BE94B6E03F8D3C8
      96FAC28CCD9911657FB766B5370C7D9C52F4BA5D1296CFFA2A87970218131982
      4EE57BA3F6BED4FA08E210D8314F0393DE62EFE0CF2E3DDEA7B53965F5B1C232
      0091E112CABCE26DF2DC23D699EF0D0F5B401088756D686D88725067FFE7EAA2
      7F9D74AEE8D55ABA7EF8BCC26FFB80263296AFBB59F8C30E216A5457EB936601
      85D49A25A8DC45D93F4CDC9986EEFAFDD6163CBFF39A57F27B79291A2FDE9AE9
      3C70A1404B696E25D979CEB20F976F3FC12C00D618C8FA9FAFE126B80F1F52DF
      67F9D078450CC59280DC25DEB2DD97BB1BE9BB278DB0F1B721A0D237E18771D2
      581BEAB77E0450D706D4B51E7800FF07F6DFCA6E0C64B9380000000049454E44
      AE426082}
    Fill.BackGroundPictureLeft = 22
    Fill.BackGroundPictureTop = 2
    Fill.PicturePosition = ppCustom
    Fill.PictureLeft = 85
    Fill.PictureTop = 120
    Fill.PictureWidth = 150
    Fill.PictureHeight = 150
    Fill.Opacity = 240
    Fill.OpacityTo = 252
    Fill.BorderColor = clNavy
    Fill.BorderWidth = 2
    Fill.Rounding = 6
    Fill.ShadowOffset = 0
    HTMLText.Location = hlCenterCenter
    HTMLText.URLColor = clWhite
    HTMLText.Font.Charset = DEFAULT_CHARSET
    HTMLText.Font.Color = 15066597
    HTMLText.Font.Height = -24
    HTMLText.Font.Name = 'Tahoma'
    HTMLText.Font.Style = []
    Position = poMainFormCenter
    Version = '1.0.6.3'
    ProgressMaximum = 100
    ProgressWidth = 200
    ProgressAppearance.BackGroundFill.Color = 16765615
    ProgressAppearance.BackGroundFill.ColorTo = 16765615
    ProgressAppearance.BackGroundFill.ColorMirror = clNone
    ProgressAppearance.BackGroundFill.ColorMirrorTo = clNone
    ProgressAppearance.BackGroundFill.BorderColor = clNone
    ProgressAppearance.BackGroundFill.Rounding = 0
    ProgressAppearance.BackGroundFill.ShadowOffset = 0
    ProgressAppearance.ProgressFill.Color = 11196927
    ProgressAppearance.ProgressFill.ColorTo = 7257087
    ProgressAppearance.ProgressFill.ColorMirror = clNone
    ProgressAppearance.ProgressFill.ColorMirrorTo = clNone
    ProgressAppearance.ProgressFill.GradientMirrorType = gtVertical
    ProgressAppearance.ProgressFill.BorderColor = clNone
    ProgressAppearance.ProgressFill.Rounding = 0
    ProgressAppearance.ProgressFill.ShadowOffset = 0
    ProgressAppearance.Font.Charset = DEFAULT_CHARSET
    ProgressAppearance.Font.Color = clWindowText
    ProgressAppearance.Font.Height = -11
    ProgressAppearance.Font.Name = 'Tahoma'
    ProgressAppearance.Font.Style = []
    ProgressAppearance.ProgressFont.Charset = DEFAULT_CHARSET
    ProgressAppearance.ProgressFont.Color = clWindowText
    ProgressAppearance.ProgressFont.Height = -11
    ProgressAppearance.ProgressFont.Name = 'Tahoma'
    ProgressAppearance.ProgressFont.Style = []
    ProgressAppearance.ValueFormat = '%.0f%%'
    Left = 360
    Top = 208
  end
  object MessageDialogQueston: TAdvSmoothMessageDialog
    FormStyle = fsStayOnTop
    ButtonAreaFill.Color = clWhite
    ButtonAreaFill.ColorTo = clWhite
    ButtonAreaFill.ColorMirror = clNone
    ButtonAreaFill.ColorMirrorTo = clNone
    ButtonAreaFill.GradientType = gtNone
    ButtonAreaFill.PictureWidth = 75
    ButtonAreaFill.PictureHeight = 75
    ButtonAreaFill.Opacity = 0
    ButtonAreaFill.OpacityTo = 100
    ButtonAreaFill.BorderColor = clNone
    ButtonAreaFill.Rounding = 0
    ButtonAreaFill.RoundingType = rtBottom
    ButtonAreaFill.ShadowOffset = 0
    Buttons = <
      item
        Spacing = 0
        Caption = 'Confirmar'
        Color = 14862279
        ColorDown = 10966614
        BorderColor = clWhite
        Opacity = 200
      end
      item
        Spacing = 0
        Caption = 'Cancelar'
        ButtonResult = 2
      end>
    ButtonSpacing = 10
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = 15066597
    CaptionFont.Height = -19
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = [fsBold]
    ButtonFont.Charset = DEFAULT_CHARSET
    ButtonFont.Color = clWhite
    ButtonFont.Height = -24
    ButtonFont.Name = 'Tahoma'
    ButtonFont.Style = [fsBold]
    CaptionFill.Color = clWhite
    CaptionFill.ColorTo = 6702148
    CaptionFill.ColorMirror = clNone
    CaptionFill.ColorMirrorTo = clNone
    CaptionFill.HatchStyle = HatchStyleForwardDiagonal
    CaptionFill.BackGroundPicture.Data = {
      89504E470D0A1A0A0000000D4948445200000040000000400806000000AA6971
      DE000009AB4944415478DAED9B097414451AC7BFAAEA9E9E9E994C66215C8695
      FB9498800464518E051F82082AA724E150765D70770165D75D39DE5B41F6EDA2
      A0BE278A2B2E7209AB2C2E0BECA25CE11248C8414248389E2C9010128E5C33D3
      33DD55B53D09204DAE19322107FEDFCB7BDD3555D55FFDAAFAFBEAE82078C085
      EADA80BAD68F00EAF2E12CF165091427E027367A1E28003C739E1D446125D8F0
      587EFC000597B219B03403BFB0BBE8C10090F4EAB7D0ACCD50104C0067D200B2
      D38133BA0BC7243ED5E801B0B4B99311E39F83100E40959B440840C676E0984D
      C1130EAE69B40058E6421B70CF2944435B83EA32FEA852E027B65E0247AB6E78
      ECAE92C609E0DC5B8B4013E683D3D7787E9725BA29FFCB0028BEB818C7252C68
      7400D8F9A5ED00B30C28D0CCA03A2BCEE47B1512372BE068D61D4F8CFFBE7101
      B8BCFC4B709BC6C2F58B5567CCCB06C849FA0A4F3F39AED10060391F0E4282BC
      87E75C46A05613E9901E1992B773B0CA43F0A4437B1B3C0076690501513B0E6E
      4724E4A5FB57A8A4580F8FBB5321B4D563FAAB401B36800BCB5E01F3431FC305
      DDC151B79F56E9BEE0CC51FDC2FD2B1C7364658305C0CEFEC5A18FE82CAE8435
      876B198115F6F57BC6B63C7D1474C113F615344C00590B9681B9CD1C9E734AF7
      F03CE0F228EFBC1E16CF2FC77149AF3538002CF5F75D419252B95336812BEFDE
      2AC122A033DF78C1E288C4E3E3331B1680A499DBB9103E82175CA99981EE4240
      579276E0C969CF341800ECD04B2340B26D638A8880D670A58B4D80B31338203A
      124F38BCA3DE03A07B634D08A927B8F47017AEB82ACCC33883422F0126B728F5
      0D44C9058754B9298851403987B2B8DCEC5132768FB75E0360DF3C3F07CC61CB
      2895F4C6B10AF3384D0F81ADCF1CC0825C06CD530CAE637F050BBD5189950470
      E13940CAF5D7F0C423CBEB2D00BA637418E2CA191AD2DD016AE5315F6D330AE4
      0EC38D5032368194BBAFF2CA890948767C01979A742263F75EAD9700D896819F
      707BFB5F3066AA329FD669821E1D071BD2DC595B40BCB8B3CA72D87B0350E1D9
      BFE14949BFAC7700E8E64151FA8A364173F4104053AACEDB5107D06EA811803E
      0284EC5D553F844820E427681C9BA2C9F88329F50A00DBD0731F6B1A3990715C
      3DAC0E63C0DC718421CD757203889776575B168306F85A6A3C8E491D546F00D0
      8D7DC721D1FA0FD5D65127A1569FBFFD7320771E650490BE16844B7E2CFE745F
      20166501D7DCE3C9C4A35FD63900BAE94933520B4F6961D16D39D5FC2AA3B51F
      0D96AECF1BD2DCA99FE94E6EBF7F461302C2D584F3CCD4A49B303E5EF1AB506D
      01601B7ACFE396968B55A169A561AF1CB4F6CF82A5BB71BFC39DFC893EE139E8
      A7D51844550F04EE2BF3C9A4C4B7EB0C00DDD83F1C315796EAE865E5AAFF1D41
      DB0D074B448C1140D24AC0970EF86FB828837823D1C984902EC28403D9750280
      ADEFB98EDADAC768DC145039DAF669B0464E36A4B91257F83F026E4A401E2025
      DFAFC731C9B1F71D00FDA26F3F84F0418FA533AE2EEC952BDB4E071035D590E6
      3CFA01909CC38119219841726532C6D113C28B47BEBB6F00B42F7E86312DF94E
      0BE9DE47D302DFB1E26D8682E531E35CC6A9CF70714EE06D1004DD2116671C63
      C4DE4F78F1A07F4EA8A600E886E8A920DAFEEEC1FA6286561FF6CA0168FB73B0
      44CF34A4951C5AAA8F80A3811B43449068AEDE2BCE696452C2EA5A07A06DE817
      8299F394D71A114E3DAE408B97C907A0EFAF8D00E21701CE4DBEA7EA882483C9
      999ECDB0AD9B30E97071AD02A0EB7A2E61E6567FF4AA3EC717F836974FBCED60
      B03E3ECB9056BC672190BC13F7549FAF1926D10358C9FD33894D7EB3D60068EB
      FB76C0484D57844E66EEBDC7DE2F053008ACFDEFD8E6E31C8A772DA80100DF71
      8205CCEA698581D443883972AE5600B075919B35A9ED0B5E77E0EFBD01409B01
      601BF0860140D1CE3780E49FAC51BDA24C40F45CF8278E4D1D137400DABAE821
      4810BF75D3162890494F8500DA0E8090817F300028DC3E1BC8B53335AAD73739
      92F165AE4FC99F126213AA5F59F90B405DD7570F36CE248FD8314273DDFBD0BF
      25F6D3FE601FB2F08EF6EB23E0DFBF0172BD66007C122C1690D4736914ACBDC4
      D823D52E4EFC02A0ADED35034CA12BDC4E49B7DEBF054F95005A47837DD81223
      802DAF00B91184036122802CBBF55E2B9929C41DFFA8C600D4B57D7E429092E5
      86F6CDA82B389FF0B0168F80FDD9F7012174130083A24D71808B7383523FB1D8
      418673F9945BBA8871476F5495B75A00746DE4FB546CF95B7761F03EE4E2820C
      B671AB8084B42ABDF7E66781F2F54CBF5793FE480E9580A8B91F90B8D45955E5
      AB1280BAA6777742784A89A7B9C83D4E08AA243B909611FA70A0402FA7EAEF99
      9F07A77E0A4936B049B92AA5244A9C9C50E9C1649500D8DA88FF7A50F8304FC1
      7DFB6427A8921C369078F64E1C97F674C000B4353D4782206F2D299050A0AB3D
      7FC56E1E9862544B27747A58B485BA39573DA3C42949DBFC06A07EDEDB44B092
      EED25A77520B837F32ED7BD3958E8341EA3CA4F4DE737A3798CFEE85EAB753EF
      814168285884EC331A35F7304D4D2C77AA5421006D4DD4EB8C38DE71E6E93DCF
      83FF8186DA7302840D980D0893D27BAEFB81ABFBDF03317953F0096001AC6122
      605A34579892F26EB500D4D5BD9A13819E2E2E69164A4B6AA1F71106DBF4AF75
      1FD8CA90EED14360C9A7A301B3E045825B12421C60B3E6156AAAD0D9342DC970
      565F0E005DF3E8A72A0F7BD9957BC3FF270402409FA884BEBA0B04B3DD90AE29
      C550F8E150BDA76AB6CEA84C96960E10D1B55564F289E995025057F7EC854572
      AC285F224CA93DCF2F3FB318E41E230D69EE933BC0BD2DA0956C40C2E610B087
      B92855791FD3B4E4A40A01B0B53DE25D9E66033C79413B7BAC5892152CC3E683
      D4A5EC78CC93B50B5C3B17EB17419E6BDC2573F330904DF9FBF1E4F481E50078
      56453D8925797FD14545F77B413D82AF5C379DA06F32743F840409ECE126601E
      6580343DE5800140D147117339752C55AFD572EFD7B1C4A64D0191C2DFD967A4
      BD6300706C618F37DB61FA766D84BD7A253D2C9EA7785EF45BE94B6E03F8D3C8
      96FAC28CCD9911657FB766B5370C7D9C52F4BA5D1296CFFA2A87970218131982
      4EE57BA3F6BED4FA08E210D8314F0393DE62EFE0CF2E3DDEA7B53965F5B1C232
      0091E112CABCE26DF2DC23D699EF0D0F5B401088756D686D88725067FFE7EAA2
      7F9D74AEE8D55ABA7EF8BCC26FFB80263296AFBB59F8C30E216A5457EB936601
      85D49A25A8DC45D93F4CDC9986EEFAFDD6163CBFF39A57F27B79291A2FDE9AE9
      3C70A1404B696E25D979CEB20F976F3FC12C00D618C8FA9FAFE126B80F1F52DF
      67F9D078450CC59280DC25DEB2DD97BB1BE9BB278DB0F1B721A0D237E18771D2
      581BEAB77E0450D706D4B51E7800FF07F6DFCA6E0C64B9380000000049454E44
      AE426082}
    CaptionFill.PicturePosition = ppCustom
    CaptionFill.PictureLeft = 10
    CaptionFill.PictureTop = 10
    CaptionFill.PictureSize = psCustom
    CaptionFill.PictureWidth = 70
    CaptionFill.PictureHeight = 70
    CaptionFill.Opacity = 88
    CaptionFill.OpacityTo = 0
    CaptionFill.BorderColor = clNone
    CaptionFill.Rounding = 6
    CaptionFill.RoundingType = rtTop
    CaptionFill.ShadowOffset = 0
    CaptionLocation = hlTopCenter
    CaptionHeight = 0
    Fill.Color = 6702148
    Fill.ColorTo = 7688015
    Fill.ColorMirror = clNone
    Fill.ColorMirrorTo = clNone
    Fill.HatchStyle = HatchStyleForwardDiagonal
    Fill.BackGroundPicture.Data = {
      89504E470D0A1A0A0000000D4948445200000040000000400806000000AA6971
      DE000009AB4944415478DAED9B097414451AC7BFAAEA9E9E9E994C66215C8695
      FB9498800464518E051F82082AA724E150765D70770165D75D39DE5B41F6EDA2
      A0BE278A2B2E7209AB2C2E0BECA25CE11248C8414248389E2C9010128E5C33D3
      33DD55B53D09204DAE19322107FEDFCB7BDD3555D55FFDAAFAFBEAE82078C085
      EADA80BAD68F00EAF2E12CF165091427E027367A1E28003C739E1D446125D8F0
      587EFC000597B219B03403BFB0BBE8C10090F4EAB7D0ACCD50104C0067D200B2
      D38133BA0BC7243ED5E801B0B4B99311E39F83100E40959B440840C676E0984D
      C1130EAE69B40058E6421B70CF2944435B83EA32FEA852E027B65E0247AB6E78
      ECAE92C609E0DC5B8B4013E683D3D7787E9725BA29FFCB0028BEB818C7252C68
      7400D8F9A5ED00B30C28D0CCA03A2BCEE47B1512372BE068D61D4F8CFFBE7101
      B8BCFC4B709BC6C2F58B5567CCCB06C849FA0A4F3F39AED10060391F0E4282BC
      87E75C46A05613E9901E1992B773B0CA43F0A4437B1B3C0076690501513B0E6E
      4724E4A5FB57A8A4580F8FBB5321B4D563FAAB401B36800BCB5E01F3431FC305
      DDC151B79F56E9BEE0CC51FDC2FD2B1C7364658305C0CEFEC5A18FE82CAE8435
      876B198115F6F57BC6B63C7D1474C113F615344C00590B9681B9CD1C9E734AF7
      F03CE0F228EFBC1E16CF2FC77149AF3538002CF5F75D419252B95336812BEFDE
      2AC122A033DF78C1E288C4E3E3331B1680A499DBB9103E82175CA99981EE4240
      579276E0C969CF341800ECD04B2340B26D638A8880D670A58B4D80B31338203A
      124F38BCA3DE03A07B634D08A927B8F47017AEB82ACCC33883422F0126B728F5
      0D44C9058754B9298851403987B2B8DCEC5132768FB75E0360DF3C3F07CC61CB
      2895F4C6B10AF3384D0F81ADCF1CC0825C06CD530CAE637F050BBD5189950470
      E13940CAF5D7F0C423CBEB2D00BA637418E2CA191AD2DD016AE5315F6D330AE4
      0EC38D5032368194BBAFF2CA890948767C01979A742263F75EAD9700D896819F
      707BFB5F3066AA329FD669821E1D071BD2DC595B40BCB8B3CA72D87B0350E1D9
      BFE14949BFAC7700E8E64151FA8A364173F4104053AACEDB5107D06EA811803E
      0284EC5D553F844820E427681C9BA2C9F88329F50A00DBD0731F6B1A3990715C
      3DAC0E63C0DC718421CD757203889776575B168306F85A6A3C8E491D546F00D0
      8D7DC721D1FA0FD5D65127A1569FBFFD7320771E650490BE16844B7E2CFE745F
      20166501D7DCE3C9C4A35FD63900BAE94933520B4F6961D16D39D5FC2AA3B51F
      0D96AECF1BD2DCA99FE94E6EBF7F461302C2D584F3CCD4A49B303E5EF1AB506D
      01601B7ACFE396968B55A169A561AF1CB4F6CF82A5BB71BFC39DFC893EE139E8
      A7D51844550F04EE2BF3C9A4C4B7EB0C00DDD83F1C315796EAE865E5AAFF1D41
      DB0D074B448C1140D24AC0970EF86FB828837823D1C984902EC28403D9750280
      ADEFB98EDADAC768DC145039DAF669B0464E36A4B91257F83F026E4A401E2025
      DFAFC731C9B1F71D00FDA26F3F84F0418FA533AE2EEC952BDB4E071035D590E6
      3CFA01909CC38119219841726532C6D113C28B47BEBB6F00B42F7E86312DF94E
      0BE9DE47D302DFB1E26D8682E531E35CC6A9CF70714EE06D1004DD2116671C63
      C4DE4F78F1A07F4EA8A600E886E8A920DAFEEEC1FA6286561FF6CA0168FB73B0
      44CF34A4951C5AAA8F80A3811B43449068AEDE2BCE696452C2EA5A07A06DE817
      8299F394D71A114E3DAE408B97C907A0EFAF8D00E21701CE4DBEA7EA882483C9
      999ECDB0AD9B30E97071AD02A0EB7A2E61E6567FF4AA3EC717F836974FBCED60
      B03E3ECB9056BC672190BC13F7549FAF1926D10358C9FD33894D7EB3D60068EB
      FB76C0484D57844E66EEBDC7DE2F053008ACFDEFD8E6E31C8A772DA80100DF71
      8205CCEA698581D443883972AE5600B075919B35A9ED0B5E77E0EFBD01409B01
      601BF0860140D1CE3780E49FAC51BDA24C40F45CF8278E4D1D137400DABAE821
      4810BF75D3162890494F8500DA0E8090817F300028DC3E1BC8B53335AAD73739
      92F165AE4FC99F126213AA5F59F90B405DD7570F36CE248FD8314273DDFBD0BF
      25F6D3FE601FB2F08EF6EB23E0DFBF0172BD66007C122C1690D4736914ACBDC4
      D823D52E4EFC02A0ADED35034CA12BDC4E49B7DEBF054F95005A47837DD81223
      802DAF00B91184036122802CBBF55E2B9929C41DFFA8C600D4B57D7E429092E5
      86F6CDA82B389FF0B0168F80FDD9F7012174130083A24D71808B7383523FB1D8
      418673F9945BBA8871476F5495B75A00746DE4FB546CF95B7761F03EE4E2820C
      B671AB8084B42ABDF7E66781F2F54CBF5793FE480E9580A8B91F90B8D45955E5
      AB1280BAA6777742784A89A7B9C83D4E08AA243B909611FA70A0402FA7EAEF99
      9F07A77E0A4936B049B92AA5244A9C9C50E9C1649500D8DA88FF7A50F8304FC1
      7DFB6427A8921C369078F64E1C97F674C000B4353D4782206F2D299050A0AB3D
      7FC56E1E9862544B27747A58B485BA39573DA3C42949DBFC06A07EDEDB44B092
      EED25A77520B837F32ED7BD3958E8341EA3CA4F4DE737A3798CFEE85EAB753EF
      814168285884EC331A35F7304D4D2C77AA5421006D4DD4EB8C38DE71E6E93DCF
      83FF8186DA7302840D980D0893D27BAEFB81ABFBDF03317953F0096001AC6122
      605A34579892F26EB500D4D5BD9A13819E2E2E69164A4B6AA1F71106DBF4AF75
      1FD8CA90EED14360C9A7A301B3E045825B12421C60B3E6156AAAD0D9342DC970
      565F0E005DF3E8A72A0F7BD9957BC3FF270402409FA884BEBA0B04B3DD90AE29
      C550F8E150BDA76AB6CEA84C96960E10D1B55564F289E995025057F7EC854572
      AC285F224CA93DCF2F3FB318E41E230D69EE933BC0BD2DA0956C40C2E610B087
      B92855791FD3B4E4A40A01B0B53DE25D9E66033C79413B7BAC5892152CC3E683
      D4A5EC78CC93B50B5C3B17EB17419E6BDC2573F330904DF9FBF1E4F481E50078
      56453D8925797FD14545F77B413D82AF5C379DA06F32743F840409ECE126601E
      6580343DE5800140D147117339752C55AFD572EFD7B1C4A64D0191C2DFD967A4
      BD6300706C618F37DB61FA766D84BD7A253D2C9EA7785EF45BE94B6E03F8D3C8
      96FAC28CCD9911657FB766B5370C7D9C52F4BA5D1296CFFA2A87970218131982
      4EE57BA3F6BED4FA08E210D8314F0393DE62EFE0CF2E3DDEA7B53965F5B1C232
      0091E112CABCE26DF2DC23D699EF0D0F5B401088756D686D88725067FFE7EAA2
      7F9D74AEE8D55ABA7EF8BCC26FFB80263296AFBB59F8C30E216A5457EB936601
      85D49A25A8DC45D93F4CDC9986EEFAFDD6163CBFF39A57F27B79291A2FDE9AE9
      3C70A1404B696E25D979CEB20F976F3FC12C00D618C8FA9FAFE126B80F1F52DF
      67F9D078450CC59280DC25DEB2DD97BB1BE9BB278DB0F1B721A0D237E18771D2
      581BEAB77E0450D706D4B51E7800FF07F6DFCA6E0C64B9380000000049454E44
      AE426082}
    Fill.BackGroundPictureLeft = 22
    Fill.BackGroundPictureTop = 2
    Fill.PicturePosition = ppCustom
    Fill.PictureLeft = 75
    Fill.PictureTop = 138
    Fill.PictureWidth = 150
    Fill.PictureHeight = 150
    Fill.Opacity = 240
    Fill.OpacityTo = 252
    Fill.BorderColor = clNavy
    Fill.BorderWidth = 2
    Fill.Rounding = 6
    Fill.ShadowOffset = 0
    HTMLText.Location = hlCenterCenter
    HTMLText.URLColor = clWhite
    HTMLText.Font.Charset = DEFAULT_CHARSET
    HTMLText.Font.Color = 15066597
    HTMLText.Font.Height = -19
    HTMLText.Font.Name = 'Tahoma'
    HTMLText.Font.Style = []
    Position = poMainFormCenter
    Version = '1.0.6.3'
    ProgressMaximum = 100
    ProgressWidth = 200
    ProgressAppearance.BackGroundFill.Color = 16765615
    ProgressAppearance.BackGroundFill.ColorTo = 16765615
    ProgressAppearance.BackGroundFill.ColorMirror = clNone
    ProgressAppearance.BackGroundFill.ColorMirrorTo = clNone
    ProgressAppearance.BackGroundFill.BorderColor = clNone
    ProgressAppearance.BackGroundFill.Rounding = 0
    ProgressAppearance.BackGroundFill.ShadowOffset = 0
    ProgressAppearance.ProgressFill.Color = 11196927
    ProgressAppearance.ProgressFill.ColorTo = 7257087
    ProgressAppearance.ProgressFill.ColorMirror = clNone
    ProgressAppearance.ProgressFill.ColorMirrorTo = clNone
    ProgressAppearance.ProgressFill.GradientMirrorType = gtVertical
    ProgressAppearance.ProgressFill.BorderColor = clNone
    ProgressAppearance.ProgressFill.Rounding = 0
    ProgressAppearance.ProgressFill.ShadowOffset = 0
    ProgressAppearance.Font.Charset = DEFAULT_CHARSET
    ProgressAppearance.Font.Color = clWindowText
    ProgressAppearance.Font.Height = -11
    ProgressAppearance.Font.Name = 'Tahoma'
    ProgressAppearance.Font.Style = []
    ProgressAppearance.ProgressFont.Charset = DEFAULT_CHARSET
    ProgressAppearance.ProgressFont.Color = clWindowText
    ProgressAppearance.ProgressFont.Height = -11
    ProgressAppearance.ProgressFont.Name = 'Tahoma'
    ProgressAppearance.ProgressFont.Style = []
    ProgressAppearance.ValueFormat = '%.0f%%'
    Left = 344
    Top = 232
  end
end
