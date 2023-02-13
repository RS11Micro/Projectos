inherited FRMERPConfArmazem: TFRMERPConfArmazem
  Height = 174
  Caption = 'Armaz'#233'm'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlPrincipal: TAdvPanel
    Height = 147
    FullHeight = 0
    object Label5: TLabel
      Left = 4
      Top = 17
      Width = 55
      Height = 13
      Caption = 'Armaz'#233'm'
      Transparent = True
    end
    object Label6: TLabel
      Left = 4
      Top = 63
      Width = 60
      Height = 13
      Caption = 'Conta ERP'
      Transparent = True
    end
    object edtDescricao: TSBEditProcura
      Left = 68
      Top = 14
      Width = 231
      Height = 21
      Enabled = True
      TabOrder = 0
      FormatoAntigo = False
      Obrigatorio = False
      ReadOnly = True
      OnBtListaClick = edtDescricaoBtListaClick
      BtListaVisivel = True
      OnBtEliminarClick = edtDescricaoBtEliminarClick
    end
    object EdcontaERP: TEdit
      Left = 71
      Top = 57
      Width = 70
      Height = 21
      TabOrder = 1
    end
  end
  inherited AdvDockPanel2: TAdvDockPanel
    Height = 147
    inherited sbPanelLateral: TAdvToolBar
      Height = 141
    end
  end
end
