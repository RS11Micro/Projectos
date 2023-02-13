unit IERPDMRecursos;

interface

uses
  SysUtils, Classes, ImgList, Controls, ActnList,CBLFRMPmsModosPagamento,ERP_FRMPMSAreasContasLanc,
  ERP_FrmAPIINtegrador,
  System.ImageList, System.Actions;

type
  TDMIERPRecursos = class(TDataModule)
    ActionList1: TActionList;
    acTeclado: TAction;
    acUtilizadores: TAction;
    acSair: TAction;
    acParametros: TAction;
    acReentrar: TAction;
    acsbacerca: TAction;
    acExportacaovendas: TAction;
    acTipodocPmsContaErp: TAction;
    acProdutoPMSContaErp: TAction;
    acIVAPMSContaERP: TAction;
    AcPagamentoPMSContaERP: TAction;
    acCentroExploracaoInterface: TAction;
    acListaVendasExportadas: TAction;
    GAImagens16: TImageList;
    GAImagens24: TImageList;
    acInterfaces: TAction;
    AcExportacaoVendasProtel: TAction;
    AcTipoDocFNt: TAction;
    acProdutosfnt: TAction;
    acIVASFNT: TAction;
    acPagamentosFNt: TAction;
    acdadosEmpresa: TAction;
    acHoteisContaSaco: TAction;
    acTipoDocCompras: TAction;
    acExportaCompras: TAction;
    acArmazens: TAction;
    acListaDocExportadoCMP: TAction;
    acexportaInventarios: TAction;
    acListaInventariosExportados: TAction;
    acExportAutomatica: TAction;
    acConfContaMail: TAction;
    acConfGerais: TAction;
    acCBLPagamentosPMS: TAction;
    acCbLTipodocContas: TAction;
    acExpVendasCBLPMS: TAction;
    acPmsPaisesMercados: TAction;
    acListaDocsVendasExportadasCBL: TAction;
    acListaDocsComprasExportadasCBL: TAction;
    AcAreaNegocio: TAction;
    acClassePrecosAreaNeg: TAction;
    acPmsContasLancAreaNeg: TAction;
    acConfiguraIntegradores: TAction;
    acListaVendasExportadas1: TAction;
    procedure acInterfacesExecute(Sender: TObject);
    procedure acUtilizadoresExecute(Sender: TObject);
    procedure AcExportacaoVendasProtelExecute(Sender: TObject);
    procedure acListaVendasExportadasExecute(Sender: TObject);
    procedure acTipodocPmsContaErpExecute(Sender: TObject);
    procedure acProdutoPMSContaErpExecute(Sender: TObject);
    procedure acIVAPMSContaERPExecute(Sender: TObject);
    procedure AcPagamentoPMSContaERPExecute(Sender: TObject);
    procedure AcTipoDocFNtExecute(Sender: TObject);
    procedure acProdutosfntExecute(Sender: TObject);
    procedure acIVASFNTExecute(Sender: TObject);
    procedure acPagamentosFNtExecute(Sender: TObject);
    procedure acExportacaovendasExecute(Sender: TObject);
    procedure acdadosEmpresaExecute(Sender: TObject);
    procedure acReentrarExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure acsbacercaExecute(Sender: TObject);
    procedure acHoteisContaSacoExecute(Sender: TObject);
    procedure acTipoDocComprasExecute(Sender: TObject);
    procedure acExportaComprasExecute(Sender: TObject);
    procedure acArmazensExecute(Sender: TObject);
    procedure acListaDocExportadoCMPExecute(Sender: TObject);
    procedure acexportaInventariosExecute(Sender: TObject);
    procedure acListaInventariosExportadosExecute(Sender: TObject);
    procedure acExportAutomaticaExecute(Sender: TObject);
    procedure acConfContaMailExecute(Sender: TObject);
    procedure acConfGeraisExecute(Sender: TObject);
    procedure acCBLPagamentosPMSExecute(Sender: TObject);
    procedure acCbLTipodocContasExecute(Sender: TObject);
    procedure acExpVendasCBLPMSExecute(Sender: TObject);
    procedure acPmsPaisesMercadosExecute(Sender: TObject);
    procedure acListaDocsVendasExportadasCBLExecute(Sender: TObject);
    procedure acListaDocsComprasExportadasCBLExecute(Sender: TObject);
    procedure AcAreaNegocioExecute(Sender: TObject);
    procedure acClassePrecosAreaNegExecute(Sender: TObject);
    procedure acPmsContasLancAreaNegExecute(Sender: TObject);
    procedure acConfiguraIntegradoresExecute(Sender: TObject);
    procedure acListaVendasExportadas1Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMIERPRecursos: TDMIERPRecursos;

implementation
uses ierpoglobais,IERPFrmPrincipal,IERP_FrmExportVendaspms,ERP_FrmExportVendas,IERP_FrmListaExportVendas,IERP_FrmListaExportVendas1,
IERPFrmDadosEmpresa,IERP_FRMAcerca,ERP_FrmExportCompras,ERP_FrmListaExportInventarios,ERP_FrmListaExportCompras,ERP_FrmExportInventarios,
ERP_FRMIntegracaoAutomatica,ERP_FrmContaMail,ERP_FRMConfGeral,
CBLFRMPmsTipoDoc,FntFrmIntPrimaveraCBL,CBLFRMPaisMercado,IERP_FrmPmsPrimveraCBL,
IERP_FrmListaExportVendasCBL,ERP_FrmListaExportComprasCBL,ERP_FRMFntAreasClasses;

{$R *.dfm}

procedure TDMIERPRecursos.acInterfacesExecute(Sender: TObject);
begin
 Listas.AbrirSQL('ListaERP_EMPRESAINTERFACE','',MotorERP.ERPInterface);
end;

procedure TDMIERPRecursos.AcAreaNegocioExecute(Sender: TObject);
begin

 Listas.AbrirSQL('ListaAreaNegocio', '',MotorERP.AreaNegocio);

end;


procedure TDMIERPRecursos.acUtilizadoresExecute(Sender: TObject);
begin

 Listas.AbrirSQL('ListaUtilizadorBSP','', SB.Utilizador);
end;

procedure TDMIERPRecursos.AcExportacaoVendasProtelExecute(Sender: TObject);
var
  Frm_IERPExportVendas:TFrm_IERPExportVendaspms;
begin
Frm_IERPExportVendas:=TFrm_IERPExportVendaspms.create(self);
Frm_IERPExportVendas.abreformulario;
end;
procedure TDMIERPRecursos.acListaVendasExportadas1Execute(Sender: TObject);
var
  FrmIERPListaExportVendas1:TFrmIERPListaExportVendas1;
begin
FrmIERPListaExportVendas1:=TFrmIERPListaExportVendas1.create(self);
FrmIERPListaExportVendas1.abreformulario;

end;

procedure TDMIERPRecursos.acListaVendasExportadasExecute(Sender: TObject);
var
  FrmIERPListaExportVendas:TFrmIERPListaExportVendas;
begin
FrmIERPListaExportVendas:=TFrmIERPListaExportVendas.create(self);
FrmIERPListaExportVendas.abreformulario;

end;

procedure TDMIERPRecursos.acTipodocPmsContaErpExecute(Sender: TObject);
begin
 Listas.AbrirSQL('ListaPmsTipoDoc','')
end;

procedure TDMIERPRecursos.acProdutoPMSContaErpExecute(Sender: TObject);
begin
 Listas.AbrirSQL('ListaPmsProdutos','')

end;

procedure TDMIERPRecursos.acIVAPMSContaERPExecute(Sender: TObject);
begin
 Listas.AbrirSQL('ListaPmsIVAS','');
end;

procedure TDMIERPRecursos.AcPagamentoPMSContaERPExecute(Sender: TObject);
begin

 Listas.AbrirSQL('ListaPmsPagamentos','');
end;

procedure TDMIERPRecursos.AcTipoDocFNtExecute(Sender: TObject);
var segue:boolean;
begin
    segue:=true;
    If MotorFnt=nil then
    begin
       segue:= AbreMotorSyscontroller;
    end;
    If segue  then
      ListasFnt.AbrirSQl('listaTiposDocsContaERP','', motorFnt.TipoDocVnd)
    else
    sb.Dialogos.SBMessage('Não é possível entrar nesta opção!'+#13+'Por favor verfique as configurações do Interface.');



end;

procedure TDMIERPRecursos.acProdutosfntExecute(Sender: TObject);
var segue:boolean;
begin
    segue:=true;
    If MotorFnt=nil then
    begin
       segue:= AbreMotorSyscontroller;
    end;
    If segue  then
      ListasFnt.AbrirSQl('listaProdutosComContaERP','', motorFnt.Produto)
    else
    sb.Dialogos.SBMessage('Não é possível entrar nesta opção!'+#13+'Por favor verfique as configurações do Interface.');


end;

procedure TDMIERPRecursos.acIVASFNTExecute(Sender: TObject);
var segue:boolean;
begin
    segue:=true;
    If MotorFnt=nil then
    begin
       segue:= AbreMotorSyscontroller;
    end;
    If segue  then
     ListasFNT.AbrirSQl('listaIVASComContaERP','', motorFnt.IVA)
    else
    sb.Dialogos.SBMessage('Não é possível entrar nesta opção!'+#13+'Por favor verfique as configurações do Interface.');


end;

procedure TDMIERPRecursos.acPagamentosFNtExecute(Sender: TObject);
var segue:boolean;
begin
    segue:=true;
    If MotorFnt=nil then
    begin
       segue:= AbreMotorSyscontroller;
    end;
    If segue  then
     ListasFNT.AbrirSQl('listaPagamentosComContaERP','', motorFnt.Metodopagamento)
    else
    sb.Dialogos.SBMessage('Não é possível entrar nesta opção!'+#13+'Por favor verfique as configurações do Interface.');
     

end;

procedure TDMIERPRecursos.acExportacaovendasExecute(Sender: TObject);
var
  Frm_ERPExportVendas:TFrm_ERPExportVendas;
begin
Frm_ERPExportVendas:=TFrm_ERPExportVendas.create(self);
Frm_ERPExportVendas.abreformulario;
end;

procedure TDMIERPRecursos.acdadosEmpresaExecute(Sender: TObject);
var
formempresa:TFrmIERPDadosEmpresa;
begin
formempresa:=TFrmIERPDadosEmpresa.Create(self);
formempresa.AbreFormulario;

end;

procedure TDMIERPRecursos.acReentrarExecute(Sender: TObject);
begin
 if not SB.Dialogos.SBLogin() then
  begin
    if FrmIERPPrincipal.QuestaoConfirmaSairAplicacao then
    begin
      FrmIERPPrincipal.ConfirmaSair:=False;
      acSair.Execute;
    end
    else
      acReentrar.Execute;
  end
  else
  begin
      FrmIERPPrincipal.abriu:=true;
      FrmIERPPrincipal.ColocaDadosNaStatusBar(SB.UtilizadorActual.Login,SB.UtilizadorActual.Grupo,datetostr(date));


  end;
end;


procedure TDMIERPRecursos.acSairExecute(Sender: TObject);
begin
    FrmIERPPrincipal.Close;
end;

procedure TDMIERPRecursos.acsbacercaExecute(Sender: TObject);
var
 FRMIERPAcerca:TFRMIERPAcerca;
begin
  FRMIERPAcerca:= TFRMIERPAcerca.create(self);
  FRMIERPAcerca.showmodal;
end;

procedure TDMIERPRecursos.acHoteisContaSacoExecute(Sender: TObject);
begin
 Listas.AbrirSQL('ListaHoteisContaSaco','');

end;

procedure TDMIERPRecursos.acTipoDocComprasExecute(Sender: TObject);
var segue:boolean;
begin
    segue:=true;
    If MotorFnt=nil then
    begin
       segue:= AbreMotorSyscontroller;
    end;
    If segue  then
      ListasFnt.AbrirSQl('listaTiposDocsComprasContaERP','', motorFnt.TipoMovimento)
    Else
    begin
        sb.Dialogos.SBMessage('Não é possível entrar nesta opção!'+#13+'Por favor verfique as configurações do Interface.');
    end;
end;

procedure TDMIERPRecursos.acExportaComprasExecute(Sender: TObject);
var
  Frm_ERPExportCompras:TFRMERPExportCompras;
begin
Frm_ERPExportCompras:=TFRMERPExportCompras.create(self);
Frm_ERPExportCompras.abreformulario;
end;

procedure TDMIERPRecursos.acArmazensExecute(Sender: TObject);
var segue:boolean;
begin
    segue:=true;
    If MotorFnt=nil then
    begin
       segue:= AbreMotorSyscontroller;
    end;
    If segue  then
      ListasFnt.AbrirSQl('listaArmazemContaERP','', motorFnt.armazem)
    Else
    begin
        sb.Dialogos.SBMessage('Não é possível entrar nesta opção!'+#13+'Por favor verfique as configurações do Interface.');
    end;
end;

procedure TDMIERPRecursos.acListaDocExportadoCMPExecute(Sender: TObject);
var
  Frm_ERPListaExportCompras:TFrmERPListaExportCompras;
begin
Frm_ERPListaExportCompras:=TFrmERPListaExportCompras.create(self);
Frm_ERPListaExportCompras.abreformulario;

end;

procedure TDMIERPRecursos.acexportaInventariosExecute(Sender: TObject);
var
  FrmExportInventarios:TFRMERPExportInventarios;
begin
FrmExportInventarios:=TFRMERPExportInventarios.create(self);
FrmExportInventarios.abreformulario;

end;
procedure TDMIERPRecursos.acListaInventariosExportadosExecute(
  Sender: TObject);
var
  Frm_ERPListaExportInventarios:TFrmERPListaExportInventarios;
begin
Frm_ERPListaExportInventarios:=TFrmERPListaExportInventarios.create(self);
Frm_ERPListaExportInventarios.abreformulario;

end;

procedure TDMIERPRecursos.acExportAutomaticaExecute(Sender: TObject);
var
form:TFRMERPIntegracaoAutomatica;
begin
with FrmIERPPrincipal do
begin
   TprocessaVendas.Interval:=2000 ;
   TprocessaVendas.enabled:=true;
end;
//form:=TFRMERPIntegracaoAutomatica.create(nil);
//form.showmodal;
end;

procedure TDMIERPRecursos.acConfContaMailExecute(Sender: TObject);
var
FormERP_ContaMail:TFrmERP_ContaMail;
begin
FormERP_ContaMail:=TFrmERP_ContaMail.create(self);

end;

procedure TDMIERPRecursos.acConfGeraisExecute(Sender: TObject);
var
FormERP_ConfGeral:TFRMERP_ConfGeral;
begin
FormERP_ConfGeral:=TFRMERP_ConfGeral.create(self);
FormERP_ConfGeral.abreformulario;
end;

procedure TDMIERPRecursos.acConfiguraIntegradoresExecute(Sender: TObject);
var
Frm_ERPAPIINtegrador:TFrm_ERPAPIINtegrador;
begin
Frm_ERPAPIINtegrador:=TFrm_ERPAPIINtegrador.create(self);
If Frm_ERPAPIINtegrador.Abreformulario then
        Frm_ERPAPIINtegrador.showmodal;
end;

procedure TDMIERPRecursos.acCBLPagamentosPMSExecute(Sender: TObject);
var
FRMPmsModosPagamento:TFRMCBLPmsModosPagamento;
begin
FRMPmsModosPagamento:=TFRMCBLPmsModosPagamento.create(self);
If FRMPmsModosPagamento.Abreformulario then
        FRMPmsModosPagamento.showmodal;
end;

procedure TDMIERPRecursos.acCbLTipodocContasExecute(Sender: TObject);
var
FRMCBLPmsTipoDoc:TFRMCBLPmsTipoDoc;
begin
FRMCBLPmsTipoDoc:=TFRMCBLPmsTipoDoc.create(self);
If FRMCBLPmsTipoDoc.abreformulario then
        FRMCBLPmsTipoDoc.showmodal;

end;

procedure TDMIERPRecursos.acExpVendasCBLPMSExecute(Sender: TObject);
var
FormexpCBLPMs:TFrmPmsIERPPrimveraCBL;
begin
FormexpCBLPMs:=TFrmPmsIERPPrimveraCBL.create(self);
FormexpCBLPMs.AbreFormulario;
end;

procedure TDMIERPRecursos.acPmsPaisesMercadosExecute(Sender: TObject);
var
FRMCBLPaisMercado:TFRMCBLPaisMercado;
begin
 FRMCBLPaisMercado:=TFRMCBLPaisMercado.create(self);
 If FRMCBLPaisMercado.Abreformulario=true then
         FRMCBLPaisMercado.showmodal;

end;

procedure TDMIERPRecursos.acListaDocsVendasExportadasCBLExecute(
  Sender: TObject);
var
  FrmIERPListaExportVendasCBL:TFrmListaExportVendasCBL;
begin
FrmIERPListaExportVendasCBL:=TFrmListaExportVendasCBL.create(self);
FrmIERPListaExportVendasCBL.abreformulario;
   
end;


procedure TDMIERPRecursos.acListaDocsComprasExportadasCBLExecute(
  Sender: TObject);
var
  FrmIERPListaExportCMPCBL:TFrmERPListaExportComprasCBL;
begin
FrmIERPListaExportCMPCBL:=TFrmERPListaExportComprasCBL.create(self);
FrmIERPListaExportCMPCBL.abreformulario;

end;


procedure TDMIERPRecursos.acClassePrecosAreaNegExecute(Sender: TObject);
var
FormAreasClasses:TFRM_ERPFntAreasClasses;
begin
 FormAreasClasses:=TFRM_ERPFntAreasClasses.create(nil);
 FormAreasClasses.showmodal;
end;

procedure TDMIERPRecursos.acPmsContasLancAreaNegExecute(Sender: TObject);
var
FormAreasContaLancPMS:TFRM_ERPPMSAreasContasLanc;
begin
 FormAreasContaLancPMS:=TFRM_ERPPMSAreasContasLanc.create(nil);
 FormAreasContaLancPMS.showmodal;
end;



end.
