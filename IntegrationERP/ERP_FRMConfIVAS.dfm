inherited FRMERPConfIVAS: TFRMERPConfIVAS
  Width = 534
  Caption = 'IVA/Conta ERP'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TAdvPanel
    Width = 429
    FullHeight = 0
    object Label5: TLabel
      Left = 4
      Top = 27
      Width = 21
      Height = 13
      Caption = 'IVA'
      Transparent = True
    end
    object Label6: TLabel
      Left = 3
      Top = 62
      Width = 60
      Height = 13
      Caption = 'Conta ERP'
      Transparent = True
    end
    object edtIVA: TSBEditProcura
      Left = 114
      Top = 27
      Width = 313
      Height = 21
      Enabled = True
      TabOrder = 0
      FormatoAntigo = False
      Obrigatorio = False
      ReadOnly = True
      OnBtListaClick = edtIVABtListaClick
      BtListaVisivel = True
    end
    object EdcontaERP: TEdit
      Left = 67
      Top = 58
      Width = 70
      Height = 21
      TabOrder = 1
    end
    object EdPercentagem: TEdit
      Left = 66
      Top = 27
      Width = 46
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
  end
  inherited AdvDockPanel2: TAdvDockPanel
    Left = 429
  end
  inherited AdvPanelStyler1: TAdvPanelStyler
    Left = 176
    Top = 56
  end
end
