unit IERPListasFormulariosDef;


interface


Procedure CarregaFormularios;

implementation
uses IERPOGlobais,SBFrmSplash,SBListasFac40, SBFormulariosFac40, IERPListasDef
,SBListasFormulariosDef40
,SBListaDef40 ,
 SBBSSistemaBase
 ,IERP_FrmInterface
 ,IERP_FrmTab_Util
, ERP_FRMConfTipodoc,
ERP_FRMConfProdutos,ERP_FRMConfIVAS,ERP_FRMConfPagamentos,IERP_FrmTab_AreaNegocio
,IERPFrmDadosEmpresa ,ERP_FRMConfTipoMovStocks,ERP_FRMConfArmazem

;

procedure CarregaFormularios;
var
  ObjFormDef:TSBFormularioDef40;
begin

     

  ObjFormDef:=Formularios.AdicionaEntidade('ERP_EMPRESAINTERFACE',TFrm_IERPInterface);
  ObjFormDef.Titulo:='Configuração de Interfaces';

  ObjFormDef:=Formularios.AdicionaEntidade('AreaNegocio',TFrm_IERPTab_AreaNegocio);
  ObjFormDef.Titulo:='Áreas de Negócio';



  ObjFormDef := Formularios.AdicionaEntidade('Utilizador', TFrm_IERPTab_Util);
  ObjFormDef.ID_String := 572;

  If FormulariosFNT<>nil then
  begin
      //formulario fontenario
        ObjFormDef:=FormulariosFNT.AdicionaEntidade('TiposDocsContaERP',TFRMERPConfTipodoc);
       ObjFormDef.Titulo:='Associar Tipo Doc.Vendas/Conta ERP';



        ObjFormDef:=FormulariosFNT.AdicionaEntidade('TiposDocsComprasContaERP',TFRMERPConfTipoMovStocks);
       ObjFormDef.Titulo:='Associar Tipo Doc.Compras/Conta ERP';


      ObjFormDef:=FormulariosFnt.AdicionaEntidade('ProdutosComContaERP',TFRMERPConfProdutos);
      ObjFormDef.Titulo:='Associar Produtos./Conta ERP';

      ObjFormDef:=FormulariosFnt.AdicionaEntidade('IVASComContaERP',TFRMERPConfIVAS);
      ObjFormDef.Titulo:='Associar IVA/Conta ERP';

      ObjFormDef:=FormulariosFnt.AdicionaEntidade('PagamentosComContaERP',TFRMERPConfPagamentos);
       ObjFormDef.Titulo:='Associar Modos Pagamento/Conta ERP';

      ObjFormDef:=FormulariosFnt.AdicionaEntidade('ArmazemContaERP',TFRMERPConfArmazem);
       ObjFormDef.Titulo:='Associar Armazens/Conta ERP';

  end;


{  //Formulários}
end;
end.
