object FrmERP_ContaMail: TFrmERP_ContaMail
  Left = 171
  Top = 123
  Caption = 'Conta de E-mail (para envio de erros do interface)'
  ClientHeight = 401
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 13
  object AdvDockPanel2: TAdvDockPanel
    Left = 415
    Top = 0
    Width = 99
    Height = 401
    Align = daRight
    MinimumSize = 3
    LockHeight = False
    Persistence.Location = plRegistry
    Persistence.Enabled = False
    UseRunTimeHeight = False
    Version = '6.8.3.8'
    object sbPanelLateral: TAdvToolBar
      Left = 1
      Top = 3
      Width = 83
      Height = 395
      AllowFloating = True
      Caption = ''
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
        Version = '6.8.3.8'
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
        Version = '6.8.3.8'
        OnClick = btCancelarClick
      end
    end
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 415
    Height = 401
    Align = alClient
    TabOrder = 1
    UseDockManager = True
    Version = '2.6.3.3'
    BorderColor = clBlack
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.Indent = 0
    DoubleBuffered = True
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    Text = ''
    ExplicitWidth = 425
    ExplicitHeight = 406
    FullHeight = 0
    object lbsbConta1: TLabel
      Left = 12
      Top = 18
      Width = 28
      Height = 13
      Caption = 'Conta'
      Transparent = True
    end
    object LbsbNomeconta: TLabel
      Left = 12
      Top = 40
      Width = 59
      Height = 13
      Caption = 'Nome Conta'
      Transparent = True
    end
    object EdNomeConta: TEdit
      Left = 126
      Top = 38
      Width = 263
      Height = 21
      TabOrder = 0
      Text = 'mail.micro-net.pt'
    end
    object edConta: TEdit
      Left = 126
      Top = 14
      Width = 263
      Height = 21
      TabOrder = 1
      Text = 'mail.micro-net.pt'
    end
    object gbsbUtilizador: TAdvGroupBox
      Left = 6
      Top = 66
      Width = 395
      Height = 73
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -12
      CaptionFont.Name = 'Segoe UI'
      CaptionFont.Style = []
      Caption = 'From:'
      ParentCtl3D = True
      TabOrder = 2
      object lbsbEmail: TLabel
        Left = 9
        Top = 45
        Width = 100
        Height = 17
        AutoSize = False
        Caption = 'Email'
        Transparent = True
        WordWrap = True
      end
      object lbsbNome: TLabel
        Left = 9
        Top = 20
        Width = 28
        Height = 13
        Caption = 'Nome'
        Transparent = True
      end
      object edFromNome: TEdit
        Left = 120
        Top = 16
        Width = 265
        Height = 21
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        Text = 'silvia.barreiro@micro-net.pt'
      end
      object edFromMail: TEdit
        Left = 120
        Top = 43
        Width = 265
        Height = 21
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 1
        Text = 'silvia.barreiro@micro-net.pt'
      end
    end
    object grpsmtp: TAdvGroupBox
      Left = 9
      Top = 272
      Width = 393
      Height = 75
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -12
      CaptionFont.Name = 'Segoe UI'
      CaptionFont.Style = []
      ParentCtl3D = True
      TabOrder = 3
      object Label8: TLabel
        Left = 9
        Top = 51
        Width = 46
        Height = 13
        Caption = 'Password'
        Transparent = True
      end
      object Label7: TLabel
        Left = 9
        Top = 20
        Width = 43
        Height = 13
        Caption = 'Utilizador'
        Transparent = True
      end
      object EdUserAutenticacao: TEdit
        Left = 117
        Top = 23
        Width = 268
        Height = 21
        Color = cl3DLight
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        TabOrder = 0
      end
      object edtPassword: TEdit
        Left = 117
        Top = 48
        Width = 268
        Height = 21
        Color = cl3DLight
        Ctl3D = True
        Enabled = False
        ParentCtl3D = False
        PasswordChar = '*'
        TabOrder = 1
      end
      object btverpass: TButton
        Left = 64
        Top = 50
        Width = 49
        Height = 17
        Caption = 'mostrar'
        TabOrder = 2
        OnClick = btverpassClick
      end
    end
    object AdvGroupBox17: TAdvGroupBox
      Left = 8
      Top = 140
      Width = 393
      Height = 85
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -12
      CaptionFont.Name = 'Segoe UI'
      CaptionFont.Style = []
      Caption = 'To:'
      ParentCtl3D = True
      TabOrder = 4
      object Label4: TLabel
        Left = 8
        Top = 23
        Width = 25
        Height = 13
        Caption = 'Email'
        Transparent = True
      end
      object Label1: TLabel
        Left = 8
        Top = 55
        Width = 105
        Height = 13
        Caption = 'Assunto(Identifica'#231#227'o)'
        Transparent = True
      end
      object edEmailTo: TEdit
        Left = 117
        Top = 19
        Width = 266
        Height = 21
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        Text = 'silvia.barreiro@micro-net.pt'
      end
      object EDHotelMail: TEdit
        Left = 117
        Top = 51
        Width = 266
        Height = 21
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 1
      end
    end
    object chkAuth: TAdvOfficeCheckBox
      Left = 13
      Top = 252
      Width = 285
      Height = 20
      TabOrder = 5
      OnClick = chkAuthClick
      Alignment = taLeftJustify
      Caption = 'O meu servidor de envio requer autentica'#231#227'o'
      ReturnIsTab = False
      Version = '1.8.1.3'
    end
    object btnSend: TButton
      Left = 8
      Top = 352
      Width = 97
      Height = 41
      Caption = 'Testar Envio'
      TabOrder = 6
      OnClick = btnSendClick
    end
  end
end
