inherited FRMERPConfTipodoc: TFRMERPConfTipodoc
  Width = 484
  Caption = 'Tipo de documento/Conta ERP'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TAdvPanel
    Width = 379
    FullHeight = 0
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 4
      Height = 13
    end
    object Label2: TLabel
      Left = 0
      Top = 17
      Width = 54
      Height = 13
      Caption = 'Tipo Doc.'
    end
    object Label3: TLabel
      Left = 2
      Top = 48
      Width = 60
      Height = 13
      Caption = 'Conta ERP'
    end
    object Edit1: TEdit
      Left = 57
      Top = 15
      Width = 73
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object Edit3: TEdit
      Left = 71
      Top = 42
      Width = 96
      Height = 21
      TabOrder = 1
      Text = 'Edit2'
    end
    object AdvPanel1: TAdvPanel
      Left = 0
      Top = 0
      Width = 379
      Height = 151
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UseDockManager = True
      Version = '2.0.2.0'
      AutoHideChildren = False
      BorderColor = clGray
      BorderShadow = True
      Caption.Color = clHighlight
      Caption.ColorTo = clBlue
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clHighlightText
      Caption.Font.Height = -11
      Caption.Font.Name = 'Verdana'
      Caption.Font.Style = []
      Caption.Indent = 2
      CollapsColor = clBtnFace
      CollapsDelay = 0
      ColorTo = 14938354
      HoverColor = clBlack
      HoverFontColor = clBlack
      ShadowColor = clBlack
      ShadowOffset = 0
      StatusBar.BorderColor = clGray
      StatusBar.BorderStyle = bsSingle
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWindowText
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      StatusBar.Color = 14938354
      StatusBar.ColorTo = clWhite
      Styler = AdvPanelStyler1
      FullHeight = 0
      object Label4: TLabel
        Left = 24
        Top = 16
        Width = 4
        Height = 13
      end
      object Label5: TLabel
        Left = 4
        Top = 14
        Width = 54
        Height = 13
        Caption = 'Tipo Doc.'
        Transparent = True
      end
      object Label6: TLabel
        Left = 4
        Top = 58
        Width = 60
        Height = 13
        Caption = 'Conta ERP'
        Transparent = True
      end
      object edAbreviatura: TEdit
        Left = 70
        Top = 13
        Width = 73
        Height = 21
        TabOrder = 0
      end
      object EdcontaERP: TEdit
        Left = 71
        Top = 56
        Width = 70
        Height = 21
        TabOrder = 1
      end
      object edtDescricao: TSBEditProcura
        Left = 146
        Top = 13
        Width = 231
        Height = 21
        Enabled = True
        TabOrder = 2
        FormatoAntigo = False
        Obrigatorio = False
        ReadOnly = True
        OnBtListaClick = edtDescricaoBtListaClick
        BtListaVisivel = True
        OnBtEliminarClick = edtDescricaoBtEliminarClick
      end
    end
  end
  inherited AdvDockPanel2: TAdvDockPanel
    Left = 379
  end
  inherited AdvPanelStyler1: TAdvPanelStyler
    Left = 272
    Top = 8
  end
end
