program IntegrationERP;





uses
  FastMM4,
  Midas,
  Midaslib,
  Forms,
  IERPFrmPrincipal in 'IERPFrmPrincipal.pas' {FrmIERPPrincipal},
  IERPOGLOBAIS in 'IERPOGLOBAIS.pas',
  IERPListasDef in 'IERPListasDef.pas',
  IERPVersao in 'IERPVersao.pas',
  IERPDMRecursos in 'IERPDMRecursos.pas' {DMIERPRecursos: TDataModule},
  IERPListasFormulariosDef in 'IERPListasFormulariosDef.pas',
  FntFrmTabelas40 in '..\SistemaBase\SBSistemaBase\BS\FntFrmTabelas40.pas' {FrmFntTabelas40},
  IERP_FrmInterface in 'IERP_FrmInterface.pas' {Frm_IERPInterface},
  ERPBELinhaPagamento in 'ERPBELinhaPagamento.pas',
  ERPBECab in 'ERPBECab.pas',
  ERPBELinhaDetalhe in 'ERPBELinhaDetalhe.pas',
  ERPOperInterfaceProtel in 'ERPOperInterfaceProtel.pas',
  IERP_FrmTab_AreaNegocio in 'IERP_FrmTab_AreaNegocio.pas' {Frm_IERPTab_AreaNegocio},
  IERP_FrmListaExportVendas in 'IERP_FrmListaExportVendas.pas' {FrmIERPListaExportVendas},
  IERP_FrmExportVendasPMS in 'IERP_FrmExportVendasPMS.pas' {Frm_IERPExportVendasPMS},
  ERPOperInterfaceFNT in 'ERPOperInterfaceFNT.pas',
  ERP_FrmExportVendas in 'ERP_FrmExportVendas.pas' {Frm_ERPExportVendas},
  ERP_FRMConfIVAS in 'ERP_FRMConfIVAS.pas' {FRMERPConfIVAS},
  ERP_FRMConfPagamentos in 'ERP_FRMConfPagamentos.pas' {FRMERPConfPagamentos},
  ERP_FRMConfProdutos in 'ERP_FRMConfProdutos.pas' {FRMERPConfProdutos},
  IERPFrmDadosEmpresa in 'IERPFrmDadosEmpresa.pas' {FrmIERPDadosEmpresa},
  IERP_FRMAcerca in 'IERP_FRMAcerca.pas' {FRMIERPAcerca},
  ERP_FRMConfTipodoc in 'ERP_FRMConfTipodoc.pas' {FRMERPConfTipodoc},
  ERPOperInterfaceFNTCMP in 'ERPOperInterfaceFNTCMP.pas',
  ERP_FrmExportCompras in 'ERP_FrmExportCompras.pas' {FRMERPExportCompras},
  ERP_FRMConfArmazem in 'ERP_FRMConfArmazem.pas' {FRMERPConfArmazem},
  ERP_FrmListaExportCompras in 'ERP_FrmListaExportCompras.pas' {FrmERPListaExportCompras},
  ERPLogOperacoes in 'ERPLogOperacoes.pas',
  ERP_FRMConfTipoMovStocks in 'ERP_FRMConfTipoMovStocks.pas' {FRMERPConfTipoMovStocks},
  ERP_FrmExportInventarios in 'ERP_FrmExportInventarios.pas' {FRMERPExportInventarios},
  ERP_FrmListaExportInventarios in 'ERP_FrmListaExportInventarios.pas' {FrmERPListaExportInventarios},
  ERP_FRMIntegracaoAutomatica in 'ERP_FRMIntegracaoAutomatica.pas' {FRMERPIntegracaoAutomatica},
  ERP_FrmContaMail in 'ERP_FrmContaMail.pas' {FrmERP_ContaMail},
  ERPEnvioEmail in 'ERPEnvioEmail.pas',
  ERP_FRMProgresso in 'ERP_FRMProgresso.pas' {FRMERPProgresso},
  ERP_FRMConfGeral in 'ERP_FRMConfGeral.pas' {FRMERP_ConfGeral},
  ERPIntegracaoAutomatica in 'ERPIntegracaoAutomatica.pas',
  CBLFRMPmsModosPagamento in 'CBLFRMPmsModosPagamento.pas' {FRMCBLPmsModosPagamento},
  CBLOperInterfaceProtel in 'CBLOperInterfaceProtel.pas',
  CBLFRMPmsTipoDoc in 'CBLFRMPmsTipoDoc.pas' {FRMCBLPmsTipoDoc},
  CBLFrmPmsContasFamilia in 'CBLFrmPmsContasFamilia.pas' {FrmCBLPmsContasFamilia},
  CBLFrmSeltipodoc in 'CBLFrmSeltipodoc.pas' {FrmCBLSeltipodoc},
  FntFrmIntPrimaveraCBL in 'FntFrmIntPrimaveraCBL.pas' {FrmFntIntPrimaveraCBL},
  FNTIntfPrimaveraCBL0900 in 'FNTIntfPrimaveraCBL0900.pas',
  ERPBECBLCab in 'ERPBECBLCab.pas',
  ERPBECBLLinhaDetalhe in 'ERPBECBLLinhaDetalhe.pas',
  CBLFRMPaisMercado in 'CBLFRMPaisMercado.pas' {FRMCBLPaisMercado},
  FNTIntfPrimaveraRecCBL0900 in 'FNTIntfPrimaveraRecCBL0900.pas',
  PMSIntfPrimaveraCBL0900 in 'PMSIntfPrimaveraCBL0900.pas',
  ERP_FrmGerarContasCBLClientes in 'ERP_FrmGerarContasCBLClientes.pas' {FrmERPGerarContasCBLClientes},
  IERP_FrmPmsPrimveraCBL in 'IERP_FrmPmsPrimveraCBL.pas' {FrmPmsIERPPrimveraCBL},
  CBLOperInterfaceFNT in 'CBLOperInterfaceFNT.pas',
  ERP_FRMExportacaoCBLCompras in 'ERP_FRMExportacaoCBLCompras.pas' {FRMERPExportacaoCBLCompras},
  ERPPrimaveraCBLCompras in 'ERPPrimaveraCBLCompras.pas',
  IERP_FrmListaExportVendasCBL in 'IERP_FrmListaExportVendasCBL.pas' {FrmListaExportVendasCBL},
  ERP_FrmListaExportComprasCBL in 'ERP_FrmListaExportComprasCBL.pas' {FrmERPListaExportComprasCBL},
  IERP_FrmTab_Util in 'IERP_FrmTab_Util.pas' {Frm_IERPTab_Util},
  ERP_FRMFntAreasClasses in 'ERP_FRMFntAreasClasses.pas' {FRM_ERPFntAreasClasses},
  ERP_FRMPMSAreasContasLanc in 'ERP_FRMPMSAreasContasLanc.pas' {FRM_ERPPMSAreasContasLanc},
  ERPOperInterfaceFNTEncomendas in 'ERPOperInterfaceFNTEncomendas.pas',
  ERP_FrmAPIINtegrador in 'ERP_FrmAPIINtegrador.pas' {Frm_ERPAPIINtegrador},
  IERP_FrmListaExportVendas1 in 'IERP_FrmListaExportVendas1.pas' {FrmIERPListaExportVendas1},
  APITocOnline in 'APITocOnline.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmIERPPrincipal, FrmIERPPrincipal);
  Application.Run;
end.
