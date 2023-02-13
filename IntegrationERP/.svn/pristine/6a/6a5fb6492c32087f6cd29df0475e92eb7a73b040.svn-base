unit ERPOperInterfaceFNTCMP;






interface
uses  sbbetabeladados,classes,ERPBECab,ERPBELinhadetalhe,ERPBELinhaPagamento,ERPBEEMPRESAINTERFACE,
ADODB,dateutils,Dialogs,SBBEExcepcoes,ERPEnvioEmail,ERPLogOperacoes,forms;

Function DAID_InternoERPGuia(pID_MovimentoOrigem,pID_linhaOrigem:Integer):integer;
Function DaListaInventariosPorExportar(pFiltro:string;pagrupadaPorarmazem:boolean):tsbbetabeladados;
Function DaListaDocumentosCMPPorExportar(pFiltro:string;pdataInicio,pdataFim:Tdatetime;pPrefixoSys:string):tsbbetabeladados;
Function TemExportacoesCmp(var mensagem:string):Boolean;

Function ExportarCompras(pListaDocs:TsbbeTabeladados;var pListaIDSExportados:tstringList):Boolean;
Function ExportarcomprasAutomatico(pdataInicio:Tdatetime):Boolean;

Function ExportarInventarios(pListaDocs:TsbbeTabeladados;var pstrMensagemErros:string):Boolean;
Function TrataExportacaoInventario(pID_Inventario:integer;pagrupadaPorarmazem:boolean):Boolean;
Function ExportarInventariosAutomatico(pagrupadaPorarmazem:boolean):Boolean;
procedure MarcaMovimentosComoExportados(pDataIni,pdatafim:tdatetime;pListaIDSExp:TstringList;pLista:tsbbetabeladados;pnomeInterface:string);
procedure LIMPAEXportacoes;

//encomendas
Function DAID_InternoERPEncomendas(pID_Encomenda,pID_linha:Integer):integer;
Function DaListaDocumentosEncomendasPorExportar(pFiltro:string;pdataInicio,pdataFim:Tdatetime;pPrefixoSys:string):tsbbetabeladados;
Function ExportarencomendasAutomatico(pdataInicio:Tdatetime):Boolean;
procedure MarcaencomendasComoExportados(pDataIni,pdatafim:tdatetime;pLista:tsbbetabeladados;pnomeInterface:string);
Function ExportarEncomendas(pListaDocs:TsbbeTabeladados):Boolean;
var
FID_cLienteIndiferenciado:string;
FExpApenasComprasFechadas:boolean;
FOBJInterface:TERPBEEMPRESAINTERFACE;
FCONNECTIONSTRING:string;
FConexao:TADOConnection;
FQuery :TadoQuery;
FlistaMoviexportados:Tsbbetabeladados;


implementation
uses ierpOglobais,math,SysUtils,strutils, SBBaseDados, SBBSSistemaBase,
  SBBSUtilSQL,IERPFrmPrincipal, SBValor, SBBEListaObjAbs;



procedure GravaERROExportacaoSycontroller(ObjCab:TERPBECab;pDescDoc,pERRO:string);
var
    strsql:string;
begin
    strsql:=' delete from  [Erp_ErroExportacaoMovStocks] '
    +' where  ID_Movimento='+Inttostr(ObjCab.ID_VNDCABDOCUMENTO)
    +' and  Exportado=0';
    sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);

    strsql:=' INSERT INTO [Erp_ErroExportacaoMovStocks] '
             +'  ([ID_Movimento]'
             +'  ,[DescricaoMov]'
             +', MensagemERRO'
             +' ,[CriadoPor] '
             +'  ,[CriadoEm]'
             +' ,[Exportado])'
             +' VALUES ('
             + Inttostr(ObjCab.ID_VNDCABDOCUMENTO)
             +','+Sb.UtilSQL.StrToSQLStrPelica(pDescDoc)
             +','+Sb.UtilSQL.StrToSQLStrPelica(pERRO)
             +','+Sb.UtilSQL.StrToSQLStrPelica('Exportação automática')
             +','+Sb.UtilSQL.DateTimeToSQLDataHora(date)
             +',0)';
    sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);
end;


Function TestaConexaoBDExterna(pConexao:string):boolean;

begin
    Result:=false;
    If assigned(FConexao) then
     FreeAndnil(FConexao);
    FConexao:=TADOConnection.Create(nil);
    FConexao.ConnectionString:=pConexao;
    FConexao.LoginPrompt:=False;
    Try
        FConexao.Open;
       If FConexao.Connected then
          Result:=true;

    except
        result:=false;
    end;
    If  Not(result) then
    begin
        FConexao.Close;
        Freeandnil(FConexao);
    end
    else
    begin
     FQuery:=tadoquery.create(nil);
     FQuery.Connection:=FConexao;
    end;
end;


Function ValidaExportacao(var Mensagem:String):Boolean;

begin
  Mensagem:='';
  FExpApenasComprasFechadas:=false;
  result:=true;
  If assigned(FOBJInterface) then
  begin
     result:=true;

     FID_cLienteIndiferenciado:= FOBJInterface.ID_clienteIndiferenciado;
     FExpApenasComprasFechadas:= FOBJInterface.ExpApenasComprasFechadas;
     FCONNECTIONSTRING:=FOBJInterface.BDConexao;
     If FOBJInterface.BDConexao='' then
     begin
       Mensagem:='Falta configurar a Base de Dados Syscontroller';
       Result:=false;
     end
     else
     begin
        If not(TestaConexaoBDExterna(FOBJInterface.BDConexao)) then
        begin
           Mensagem:='Não é possivel conectar com a  Base de Dados do Syscontroller';
           Result:=false;
        end;
     end;
     If not(result) then
     begin
         Mensagem:='Não é possível Exportar!'+#13+Mensagem;
     end;
  end
  else
  begin
      result:=false;
       Mensagem:='Não existe interface: "ERP_ComprasSyscontroller" Ativo!';
  end;
end;


Function TemExportacoesCmp(var mensagem:string):Boolean;
var
   Listaex:Tsbbetabeladados;
begin
 mensagem:='';
 result:=false;
 Listaex:=sb.sbbd.abrirlv('select Top 1 Id_Movimento as Id_Movimento from ERP_CompCab');
 Result:=not (Listaex.vazia);
 Listaex.fecha;
 Freeandnil(Listaex);
end;


Function DAultimoIDComprasExportado():integer;
var Listadad:tsbbetabeladados;
begin
 result:=0;
 Listadad:=sb.sbbd.abrirlv('select Max(Id_Movimento) as Id_Movimento from ERP_CompCab');
 If Not(Listadad.vazia) then
 begin
      Result:=Listadad.davalor('Id_Movimento').asinteger;

 end;
 Listadad.fecha;
 Freeandnil(Listadad);

end;

Function DaListaInventariosPorExportar(pFiltro:string;pagrupadaPorarmazem:boolean):tsbbetabeladados;
var
  strsql:string;
begin
 If pagrupadaPorarmazem=false then
 begin
  strsql:=' select  0 as id_armazem ,'''' as Armazem, p.descricao,p.datainicio,p.datafim,CI.id_inventario, '
  +' sum(li.QtReal)as Qtd ,prd.vdesc1 as DescricaoProduto,prd.ContaCBL as ContaERP, li.id_produto,li.ID_Unidade, '
  +' sum(li.QtReal*li.PrecoMedioProduto) as valorLinhasemiva,PrecoMedioProduto,'''' as ContaERPARM '
  +' ,TAB_SubFam.VCodSubFam as ID_SubFamilia,TAB_SubFam.vdesc as SubFamilia,'
  +' TAB_Familia.VCodFam as ID_Familia,TAB_Familia.vdesc as Familia,'
  +' Tab_GrFamiliar.vCodGrFam as ID_GrupoFamilia,Tab_GrFamiliar.vdesc as GrupoFamilia'

  +' from cabinventario CI inner join periodo as P on CI.ID_Periodo=P.ID_Periodo '
  +' inner join linhainventario  as LI on CI.ID_Inventario=LI.ID_Inventario '
  +' inner join tab_produto as prd on li.id_produto=prd.vproduto '
  +  ' left JOIN TAB_SubFam ON  '
  +  ' prd.VSUBFAM = TAB_SubFam.VCodSubFam '
  +  ' left JOIN TAB_Familia  ON '
  +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
  +  ' left JOIN Tab_GrFamiliar  ON '
  +  ' TAB_Familia.VCodGrFam= Tab_GrFamiliar.VCodGrFam ';




  if pFiltro<>'' then
     strsql :=strsql+' where CI.ID_Inventario='+pFiltro;


  strsql :=strsql +' group by  p.descricao,p.datainicio,p.datafim,CI.id_inventario,'
  +' prd.vdesc1,prd.ContaCBL,li.id_produto,li.ID_Unidade,PrecoMedioProduto'
  +' ,TAB_SubFam.VCodSubFam,TAB_SubFam.vdesc,'
  +' TAB_Familia.VCodFam ,TAB_Familia.vdesc,'
  +' Tab_GrFamiliar.vCodGrFam ,Tab_GrFamiliar.vdesc';
  Result:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,strsql);
 end
 else
 begin

   strsql:=' select armazem.id_armazem ,armazem.descricao as Armazem, p.descricao,p.datainicio,p.datafim,CI.id_inventario, '
  +' sum(li.QtReal)as Qtd ,prd.vdesc1 as DescricaoProduto,prd.ContaCBL as ContaERP, li.id_produto,li.ID_Unidade, '
  +' sum(li.QtReal*li.PrecoMedioProduto) as valorLinhasemiva,PrecoMedioProduto,armazem.ContaERP as ContaERPARM'
  +' ,TAB_SubFam.VCodSubFam as ID_SubFamilia,TAB_SubFam.vdesc as SubFamilia,'
  +' TAB_Familia.VCodFam as ID_Familia,TAB_Familia.vdesc as Familia,'
  +' Tab_GrFamiliar.vCodGrFam as ID_GrupoFamilia,Tab_GrFamiliar.vdesc as GrupoFamilia'

  +' from cabinventario CI inner join periodo as P on CI.ID_Periodo=P.ID_Periodo '
  +' inner join linhainventario  as LI on CI.ID_Inventario=LI.ID_Inventario '
  +' inner join tab_produto as prd on li.id_produto=prd.vproduto '
  +' inner join armazem on armazem.id_armazem=li.id_armazem '
  +  ' left JOIN TAB_SubFam ON  '
  +  ' prd.VSUBFAM = TAB_SubFam.VCodSubFam '
  +  ' left JOIN TAB_Familia  ON '
  +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
  +  ' left JOIN Tab_GrFamiliar  ON '
  +  ' TAB_Familia.VCodGrFam= Tab_GrFamiliar.VCodGrFam ';

  if pFiltro<>'' then
     strsql :=strsql+' where CI.ID_Inventario='+pFiltro;


  strsql :=strsql +' group by CI.id_inventario,armazem.id_armazem ,armazem.descricao, p.descricao,p.datainicio,p.datafim,'
  +'prd.vdesc1,prd.ContaCBL,li.id_produto,li.ID_Unidade,PrecoMedioProduto,armazem.ContaERP'
  +' ,TAB_SubFam.VCodSubFam,TAB_SubFam.vdesc,'
  +' TAB_Familia.VCodFam ,TAB_Familia.vdesc,'
  +' Tab_GrFamiliar.vCodGrFam ,Tab_GrFamiliar.vdesc';

  strsql :=strsql +' order by  CI.id_inventario,armazem.id_armazem, p.descricao';

  Result:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,strsql);
 end;


end;


Function DaListaDocumentosCMPPorExportar(pFiltro:string;pdataInicio,pdataFim:Tdatetime;pPrefixoSys:string):tsbbetabeladados;
var
  strsql,strsql1,strsql2,mprefixoProdutos:string;
  mensagemerro:string;
  ID_UltCmpcabdocumentoExportado:Integer;
  DescSchema,caminho:string;
  txtFileR: TextFile;
begin

 result:=nil;
ID_UltCmpcabdocumentoExportado:=0;
If ValidaExportacao(mensagemerro) then
begin
 // ID_UltCmpcabdocumentoExportado:=DAultimoIDComprasExportado;
//sem quebras,transferencias e movimentos de correção inventario(consumos)
  strsql:='select  * from ('
  +'  select  0 as TipoMovimento , MovimentoStock.id_movimento,'
  +' MovimentoStock.Numdocumento as ID_Documento,MovimentoStock.data,MovimentoStock.dataDe as DataDoc'
  +', Tipomovimento.abreviatura as Tipodoc,'
  +' MovimentoStock.totaliva as TotalDociva,MovimentoStock.valorTotal as TotalDocComIVA , '
  +' MovimentoStock.valorTotal-MovimentoStock.totaliva as ValorDocSemIVA,'
  +' Tipomovimento.ContaERP as Serie,MovimentoStock.valortotal,MovimentoStock.id_entidade'
  +', Tab_cliente.vnome+'' '' + Tab_cliente.vapel as NomeCliente,'
  +' Tab_cliente.vcont as contribuinteEntidade,Tab_cliente.vmor1 as MoradaEntidade,'
  +' Tab_cliente.vcpos as CodigoPostalEntidade,'
  +' Tab_cliente.vrua as RuaEntidade, Tab_cliente.vlocalidade as LocalidadeEntidade,'
  +''''' as VersaoChaveRSA,'
  +''''' as Certificado,'''' as Hash, '
  +' LinhaMovimentoStock.ID_Linha,tab_Produto.vdesc1 as DescricaoProduto,LinhaMovimentoStock.percentagemIVA,'
  +' MovimentoStock.ID_ModoPagamento,LinhaMovimentoStock.preco as ValorUnitario, '
  +' LinhaMovimentoStock.quantidade,LinhaMovimentoStock.percentagemdesconto as PerDesconto,'
  +'  ValorUnitariosemIVA,'
  +' valoriva,valorLinhasemIva,valorLinhasemIva+ valoriva as VAlorlinhaComIVA '
  +' ,Tab_Produto.contacbl as ContaCBLProd,'
  +'  tab_Iva.contaCbl as contaCblIVA,Tab_cliente.ContaCBL as ContaCBLCliente'
  +' ,tipoMovimento.ContaERP as ContaCBLTDOC,'''' as ContaCBLPAG'
  +', tipoMovimento.id_movimentacao as TipoOperacao,tab_iva.taxexceptionReason as CodIsencao'
  +', Armazem.id_armazem, Armazem.descricao as Armazem, armazem.ContaERP as ID_ArmazemERP'
  +',LinhaMovimentoStock.id_Produto,MovimentoStock.estado'
  +',dbo.QuantidadeStock(dbo.LinhaMovimentoStock.Quantidade, dbo.LinhaMovimentoStock.ID_Produto'
  +', dbo.LinhaMovimentoStock.ID_Unidade)AS QuantidadeConvertida'
  +', LinhaMovimentoStock.TipoArtigoERP,tipoMovimento.ID_TipoEntidade'
  +', LinhaMovimentoStock.id_Unidade,'
  +' TAB_SubFam.VCodSubFam as ID_SubFamilia,TAB_SubFam.vdesc as SubFamilia,'
  +' TAB_Familia.VCodFam as ID_Familia,TAB_Familia.vdesc as Familia,'
  +' Tab_GrFamiliar.vCodGrFam as ID_GrupoFamilia,Tab_GrFamiliar.vdesc as GrupoFamilia'

  +' ,LinhaMovimentoStock.ID_MovimentoOrigem,LinhaMovimentoStock.ID_LinhaOrigem'
  +' ,LinhaMovimentoStock.ID_TipoMovOrigem'
  +', TipoMovOrig.guia as guiaorigem,TipoMovOrig.id_movimentacao as MovGuia'
    +',0 as id_encomenda, linhamovimentostock.id_encomenda as ID_encomendaOrigem,  '
    +' linhamovimentostock.id_Linhaencomenda as ID_linhaencomendaOrigem,movimentostock.Datavencimento'

  +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'

  +' From MovimentoStock '
 +' inner join LinhaMovimentoStock on MovimentoStock.ID_Movimento=LinhaMovimentoStock.ID_Movimento'
  +' Left join  tab_cliente  on tab_cliente.vnume'
  +' =MovimentoStock.ID_Entidade'
  +' left join  tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'

  +' left join  TAB_PRODUTO  on TAB_PRODUTO.VPRODUTO =LinhaMovimentoStock.ID_Produto'
  +  ' left JOIN TAB_SubFam ON  '
  +  ' TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
  +  ' left JOIN TAB_Familia  ON '
  +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
  +  ' left JOIN Tab_GrFamiliar  ON '
  +  ' TAB_Familia.VCodGrFam= Tab_GrFamiliar.VCodGrFam '
  +' left join  Armazem  on Armazem.id_armazem =LinhaMovimentoStock.id_armazem'
  +' inner join  Tipomovimento  on Tipomovimento.ID_tipoMovimento=MovimentoStock.ID_tipoMovimento'
  +' left  join  Tipomovimento as TipoMovOrig  on TipoMovOrig.ID_tipoMovimento=LinhaMovimentoStock.ID_TipoMovOrigem'
  +' left join  tab_iva  on tab_iva.vcodi=LinhaMovimentoStock.id_iva'
  +' where TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0 and  isnull(Tipomovimento.contaERP,'''')<>'+sb.UtilSQL.StrToSQLStrpelica('');

  If  pdataInicio>0 then
       strsql:=strsql+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
  If  pdataFim>0 then
       strsql:=strsql+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

  if FExpApenasComprasFechadas then
         strsql:=strsql+' and MovimentoStock.estado=1';

  If pFiltro<>'' then
      strsql:=strsql+' and '+ pFiltro;

strsql:=strsql+' Union all '

// pagamentos sem quebras,transferencias e movimentos de correção inventario(consumos)
   +'  select  1 as TipoMovimento , MovimentoStock.id_movimento,'
  +' MovimentoStock.Numdocumento as ID_Documento,MovimentoStock.data,MovimentoStock.datade as DataDoc'
  +', Tipomovimento.abreviatura as Tipodoc,'
  +' MovimentoStock.totaliva as TotalDociva,MovimentoStock.valorTotal as TotalDocComIVA ,'
  +' MovimentoStock.valorTotal-MovimentoStock.totaliva as ValorDocSemIVA ,'

  +' Tipomovimento.ContaERP as Serie,MovimentoStock.valortotal,MovimentoStock.id_entidade'
  +', Tab_cliente.vnome+'' '' + Tab_cliente.vapel as NomeCliente,'
  +' Tab_cliente.vcont as contribuinteEntidade,Tab_cliente.vmor1 as MoradaEntidade,'
  +' Tab_cliente.vcpos as CodigoPostalEntidade,'
  +' Tab_cliente.vrua as RuaEntidade, Tab_cliente.vlocalidade as LocalidadeEntidade,'
  +''''' as VersaoChaveRSA,'
  +''''' as Certificado,'''' as Hash, '
  +' 999 as ID_Linha,tab_metodopag.vdescpag as DescricaoProduto,0 as percentagemIVA,'
  +' MovimentoStock.ID_ModoPagamento,MovimentoStock.Valortotal as ValorUnitario, '
  +' 1 as quantidade,0 as PerDesconto,'

  +' 0 as  ValorUnitariosemIVA,'
  +'  0 as valoriva, movimentoStock.Valortotal as valorLinhasemIva,MovimentoStock.Valortotal as VAlorlinhaComIVA, '
  +' '''' as ContaCBLProd,'

  +' '''' as contaCblIVA,Tab_cliente.ContaCBL as ContaCBLCliente'
  +' ,tipoMovimento.ContaERP as ContaCBLTDOC,tab_metodopag.contaCBL as ContaCBLPAG'
  +', tipoMovimento.id_movimentacao as TipoOperacao,'''' as CodIsencao'
  +',0  as id_armazem,'''' as Armazem,'''' as ID_ArmazemERP'
  +', 0 as id_Produto,MovimentoStock.estado'
  +', 0 AS QuantidadeConvertida'
  +', '''' as TipoArtigoERP,tipoMovimento.ID_TipoEntidade'
  +', 0 as id_Unidade'

  +', 0 as ID_SubFamilia,'''' as SubFamilia,'
  +' 0 as ID_Familia,'''' as Familia,'
  +' 0 as ID_GrupoFamilia,'''' as GrupoFamilia '
  +' ,0 as ID_MovimentoOrigem,0 as ID_LinhaOrigem '
  +' ,0  as ID_TipoMovOrigem'
  +', 0 as guiaOrigem,0  as MovGuia'

    +',0 as id_encomenda, 0 as ID_encomendaOrigem,  '
    +' 0 as ID_linhaencomendaOrigem,movimentostock.Datavencimento'

    +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'

  +' From MovimentoStock '
  +' Left join  tab_cliente  on tab_cliente.vnume  =MovimentoStock.ID_Entidade'
  +' left join  tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'

  +' inner join  Tipomovimento  on Tipomovimento.ID_tipoMovimento=MovimentoStock.ID_tipoMovimento'
  +'  inner join  tab_metodopag'
  +'   on tab_metodopag.VCODPAG=MovimentoStock.ID_ModoPagamento '
  +' where TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0 and  isnull(Tipomovimento.contaERP,'''')<>'+sb.UtilSQL.StrToSQLStrpelica('');




  If  pdataInicio>0 then
       strsql:=strsql+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
  If  pdataFim>0 then
       strsql:=strsql+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

  if FExpApenasComprasFechadas then
         strsql:=strsql+' and MovimentoStock.estado=1';


  If pFiltro<>'' then
      strsql:=strsql+' and '+ pFiltro;

// quebras,transferencias
strsql:=strsql+' Union all '
  +'  select  0 as TipoMovimento , MovimentoStock.id_movimento,MovimentoStock.Numdocumento as ID_Documento,MovimentoStock.data'
  +'  ,MovimentoStock.datade as DataDoc'
  +', Tipomovimento.abreviatura as Tipodoc,'
  +' MovimentoStock.totaliva as TotalDociva,MovimentoStock.valorTotal as TotalDocComIVA , '
  +' MovimentoStock.valorTotal-MovimentoStock.totaliva as ValorDocSemIVA,'
  +' Tipomovimento.ContaERP as Serie,MovimentoStock.valortotal,MovimentoStock.id_entidade'
  +', Tab_cliente.vnome+'' '' + Tab_cliente.vapel as NomeCliente,'
  +' Tab_cliente.vcont as contribuinteEntidade,Tab_cliente.vmor1 as MoradaEntidade,'
  +' Tab_cliente.vcpos as CodigoPostalEntidade,'
  +' Tab_cliente.vrua as RuaEntidade, Tab_cliente.vlocalidade as LocalidadeEntidade,'
  +''''' as VersaoChaveRSA,'
  +''''' as Certificado,'''' as Hash, '
  +' LinhaMovimentoStock.ID_Linha,tab_Produto.vdesc1 as DescricaoProduto,LinhaMovimentoStock.percentagemIVA,'
  +' MovimentoStock.ID_ModoPagamento,LinhaMovimentoStock.preco as ValorUnitario, '
  +' LinhaMovimentoStock.quantidade,LinhaMovimentoStock.percentagemdesconto as PerDesconto,'
  +'  ValorUnitariosemIVA,'
  +' valoriva,valorLinhasemIva,valorLinhasemIva+ valoriva as VAlorlinhaComIVA '
  +' ,Tab_Produto.contacbl as ContaCBLProd,'
  +'  tab_Iva.contaCbl as contaCblIVA,Tab_cliente.ContaCBL as ContaCBLCliente'
  +' ,tipoMovimento.ContaERP as ContaCBLTDOC,'''' as ContaCBLPAG'
  +', tipoMovimento.id_movimentacao as TipoOperacao,tab_iva.taxexceptionReason as CodIsencao'
  +', Armazem.id_armazem, Armazem.descricao as Armazem, armazem.ContaERP as ID_ArmazemERP'
  +',LinhaMovimentoStock.id_Produto,MovimentoStock.estado'
  +',dbo.QuantidadeStock(dbo.LinhaMovimentoStock.Quantidade, dbo.LinhaMovimentoStock.ID_Produto'
  +', dbo.LinhaMovimentoStock.ID_Unidade)AS QuantidadeConvertida'
  +', LinhaMovimentoStock.TipoArtigoERP,tipoMovimento.ID_TipoEntidade'
  +', LinhaMovimentoStock.id_Unidade,'
  +' TAB_SubFam.VCodSubFam as ID_SubFamilia,TAB_SubFam.vdesc as SubFamilia,'
  +' TAB_Familia.VCodFam as ID_Familia,TAB_Familia.vdesc as Familia,'
  +' Tab_GrFamiliar.vCodGrFam as ID_GrupoFamilia,Tab_GrFamiliar.vdesc as GrupoFamilia'

  +' ,LinhaMovimentoStock.ID_MovimentoOrigem,LinhaMovimentoStock.ID_LinhaOrigem'
  +' ,LinhaMovimentoStock.ID_TipoMovOrigem'
  +', TipoMovOrig.guia as guiaOrigem,TipoMovOrig.id_movimentacao as MovGuia'
    +',0 as id_encomenda, linhamovimentostock.id_encomenda as ID_encomendaOrigem,  '
    +' linhamovimentostock.id_Linhaencomenda as ID_linhaencomendaOrigem,movimentostock.Datavencimento'
    +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'
  +' From MovimentoStock '
 +' inner join LinhaMovimentoStock on MovimentoStock.ID_Movimento=LinhaMovimentoStock.ID_Movimento'
  +' Left join  tab_cliente  on tab_cliente.vnume'
  +' =MovimentoStock.ID_Entidade'
  +' left join  tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'

  +' left join  TAB_PRODUTO  on TAB_PRODUTO.VPRODUTO =LinhaMovimentoStock.ID_Produto'
  +  ' left JOIN TAB_SubFam ON  '
  +  ' TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
  +  ' left JOIN TAB_Familia  ON '
  +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
  +  ' left JOIN Tab_GrFamiliar  ON '
  +  ' TAB_Familia.VCodGrFam= Tab_GrFamiliar.VCodGrFam '
  +' left join  Armazem  on Armazem.id_armazem =MovimentoStock.id_entidade'
  +' inner join  Tipomovimento  on Tipomovimento.ID_tipoMovimento=MovimentoStock.ID_tipoMovimento'
  +' left join  tab_iva  on tab_iva.vcodi=LinhaMovimentoStock.id_iva'
  +' left  join  Tipomovimento as TipoMovOrig  on TipoMovOrig.ID_tipoMovimento=LinhaMovimentoStock.ID_TipoMovOrigem'
  +' where TipoMovimento.id_tipoentidade  in(2) and MovimentoStock.CBLExportado=0 and  isnull(Tipomovimento.contaERP,'''')<>'+sb.UtilSQL.StrToSQLStrpelica('');

  If  pdataInicio>0 then
       strsql:=strsql+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
  If  pdataFim>0 then
       strsql:=strsql+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

  if FExpApenasComprasFechadas then
         strsql:=strsql+' and MovimentoStock.estado=1';

  If pFiltro<>'' then
      strsql:=strsql+' and '+ pFiltro;
//  movimentos de correção inventario(consumos) com armazem com propriedade consumo pessoal ativa

strsql:=strsql+' Union all '
  +'  select  0 as TipoMovimento , MovimentoStock.id_movimento,MovimentoStock.Numdocumento as ID_Documento,MovimentoStock.data'
  +' ,MovimentoStock.datade as DataDoc'
  +', Tipomovimento.abreviatura as Tipodoc,'
  +' V_TotaisMovimentoCorrInventario.TotalDociva,V_TotaisMovimentoCorrInventario.TotalDocComIVA , '
  +' V_TotaisMovimentoCorrInventario.ValorDocSemIVA,'
  +' Tipomovimento.ContaERP as Serie,MovimentoStock.valortotal,MovimentoStock.id_entidade'
  +', Tab_cliente.vnome+'' '' + Tab_cliente.vapel as NomeCliente,'
  +' Tab_cliente.vcont as contribuinteEntidade,Tab_cliente.vmor1 as MoradaEntidade,'
  +' Tab_cliente.vcpos as CodigoPostalEntidade,'
  +' Tab_cliente.vrua as RuaEntidade, Tab_cliente.vlocalidade as LocalidadeEntidade,'
  +''''' as VersaoChaveRSA,'
  +''''' as Certificado,'''' as Hash, '
  +' LinhaMovimentoStock.ID_Linha,tab_Produto.vdesc1 as DescricaoProduto,LinhaMovimentoStock.percentagemIVA,'
  +' MovimentoStock.ID_ModoPagamento,LinhaMovimentoStock.preco as ValorUnitario, '
  +' LinhaMovimentoStock.quantidade,LinhaMovimentoStock.percentagemdesconto as PerDesconto,'
  +'  ValorUnitariosemIVA,'
  +' valoriva,valorLinhasemIva,valorLinhasemIva+ valoriva as VAlorlinhaComIVA '
  +' ,Tab_Produto.contacbl as ContaCBLProd,'
  +'  tab_Iva.contaCbl as contaCblIVA,Tab_cliente.ContaCBL as ContaCBLCliente'
  +' ,tipoMovimento.ContaERP as ContaCBLTDOC,'''' as ContaCBLPAG'
  +', tipoMovimento.id_movimentacao as TipoOperacao,tab_iva.taxexceptionReason as CodIsencao'
  +', Armazem.id_armazem, Armazem.descricao as Armazem, armazem.ContaERP as ID_ArmazemERP'
  +',LinhaMovimentoStock.id_Produto,MovimentoStock.estado'
  +',dbo.QuantidadeStock(dbo.LinhaMovimentoStock.Quantidade, dbo.LinhaMovimentoStock.ID_Produto'
  +', dbo.LinhaMovimentoStock.ID_Unidade)AS QuantidadeConvertida'
  +', LinhaMovimentoStock.TipoArtigoERP,tipoMovimento.ID_TipoEntidade'
  +', LinhaMovimentoStock.id_Unidade,'
 +' TAB_SubFam.VCodSubFam as ID_SubFamilia,TAB_SubFam.vdesc as SubFamilia,'
  +' TAB_Familia.VCodFam as ID_Familia,TAB_Familia.vdesc as Familia,'
  +' Tab_GrFamiliar.vCodGrFam as ID_GrupoFamilia,Tab_GrFamiliar.vdesc as GrupoFamilia'
  +' ,LinhaMovimentoStock.ID_MovimentoOrigem,LinhaMovimentoStock.ID_LinhaOrigem'
  +' ,LinhaMovimentoStock.ID_TipoMovOrigem'
  +', TipoMovOrig.guia as guiaOrigem,TipoMovOrig.id_movimentacao as MovGuia'
    +',0 as id_encomenda, linhamovimentostock.id_encomenda as ID_encomendaOrigem,  '
    +' linhamovimentostock.id_Linhaencomenda as ID_linhaencomendaOrigem,movimentostock.Datavencimento'
   +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'
  +' From MovimentoStock '
  +' inner join LinhaMovimentoStock on MovimentoStock.ID_Movimento=LinhaMovimentoStock.ID_Movimento'
  +' inner join V_TotaisMovimentoCorrInventario on LinhaMovimentoStock.ID_Movimento=V_TotaisMovimentoCorrInventario.ID_Movimento'
  +' and   LinhaMovimentoStock.id_armazem=V_TotaisMovimentoCorrInventario.id_armazem '
  +' Left join  tab_cliente  on tab_cliente.vnume'
  +' =MovimentoStock.ID_Entidade'
  +' left join  tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'

  +' left join  TAB_PRODUTO  on TAB_PRODUTO.VPRODUTO =LinhaMovimentoStock.ID_Produto'
  +  ' left JOIN TAB_SubFam ON  '
  +  ' TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
  +  ' left JOIN TAB_Familia  ON '
  +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
  +  ' left JOIN Tab_GrFamiliar  ON '
  +  ' TAB_Familia.VCodGrFam= Tab_GrFamiliar.VCodGrFam '
  +' left join  Armazem  on Armazem.id_armazem =LinhaMovimentoStock.id_armazem'
  +' inner join  Tipomovimento on Tipomovimento.ID_tipoMovimento=MovimentoStock.ID_tipoMovimento'
  +' left join  tab_iva  on tab_iva.vcodi=LinhaMovimentoStock.id_iva'
  +' left  join  Tipomovimento as TipoMovOrig  on TipoMovOrig.ID_tipoMovimento=LinhaMovimentoStock.ID_TipoMovOrigem'
  +' where Armazem.consumopessoal=1 and  TipoMovimento.id_tipoentidade  in(4) and MovimentoStock.CBLExportado=0 and  isnull(Tipomovimento.contaERP,'''')<>'+sb.UtilSQL.StrToSQLStrpelica('');

  If  pdataInicio>0 then
       strsql:=strsql+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
  If  pdataFim>0 then
       strsql:=strsql+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

  if FExpApenasComprasFechadas then
         strsql:=strsql+' and MovimentoStock.estado=1';

  If pFiltro<>'' then
      strsql:=strsql+' and '+ pFiltro;


 strsql:=strsql+'  ) as x';
  strsql:=strsql+' order by id_movimento,Tipomovimento,id_Linha';
  try
  Result:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,strsql);

 Finally
      caminho:=ExtractFilePath(Application.ExeName);
      AssignFile(txtFileR,caminho+'sqlCompras.TXT');
      Rewrite(txtFileR);
      Writeln(txtFileR,strsql);
      CloseFile(txtFileR)

   end;
end;
end;





Function DalistaIDDocs(pListaDocs:TsbbeTabeladados):TstringList;
begin
     Result:=TstringList.create;
     pListaDocs.inicio;
     While Not(pListaDocs.NoFim)do
     begin
        If Result.IndexOf(pListaDocs.davalor('id_movimento').asstring)=-1 then
            Result.Add(pListaDocs.davalor('id_movimento').asstring);
        pListaDocs.seguinte;
     end;
end;

Function DalistaIDDocsenc(pListaDocs:TsbbeTabeladados):TstringList;
begin
     Result:=TstringList.create;
     pListaDocs.inicio;
     While Not(pListaDocs.NoFim)do
     begin
        If Result.IndexOf(pListaDocs.davalor('id_ENCOMENDA').asstring)=-1 then
            Result.Add(pListaDocs.davalor('id_ENCOMENDA').asstring);
        pListaDocs.seguinte;
     end;
end;

Function DAID_InternoERPEncomendas(pID_Encomenda,pID_linha:Integer):integer;
var
  strsql:string;
  Listaerp:TSBBEtabeladados;
begin
 Result:=0;
 strsql:= ' select distinct id_interno '
        +' from ERP_CompDetalhes '
        +' where ID_encomenda='+inttostr(pID_Encomenda)
        +' and ID_Linha='+inttostr(pID_linha);
 Listaerp:=sb.SBBD.AbrirLV(strsql);
 Try
  if not (Listaerp.Vazia) then
   result:= Listaerp.davalor('id_interno').asinteger;
 finally
  Listaerp.Fecha;
  Freeandnil(Listaerp);
 end;
end;


Function DAID_InternoERPGuia(pID_MovimentoOrigem,pID_linhaOrigem:Integer):integer;
var
  strsql:string;
  Listaerp:TSBBEtabeladados;
begin
 Result:=0;
 strsql:= ' select distinct id_interno '
        +' from ERP_CompDetalhes '
        +' where ID_Movimento='+inttostr(pID_MovimentoOrigem)
        +' and ID_Linha='+inttostr(pID_linhaOrigem);
 Listaerp:=sb.SBBD.AbrirLV(strsql);
 Try
  if not (Listaerp.Vazia) then
   result:= Listaerp.davalor('id_interno').asinteger;
 finally
  Listaerp.Fecha;
  Freeandnil(Listaerp);
 end;


end;

Function DadescMercado(pMercado:integer):string;
begin

  If pMercado=1 then
   Result:='Nacional'
  else
  If pMercado=2 then
    Result:='Inter-Comunitário'
  else
  If pMercado=3 then
    Result:='Extra-Comunitário'

end;


Function PreencheOBJDoc(pListaDocs:TsbbeTabeladados;pid_Movimento:Integer;pencomenda:boolean=false):TERPBECab;
var
    ObjLinha:TERPBELinha;
    ObjLinhaPagamento:TERPBELinhaPagamento;
begin

 if pencomenda=true then
 begin
   pListaDocs.dataset.filtered:=false;
  pListaDocs.dataset.filter:='id_encomenda='+Inttostr(pid_Movimento);
  pListaDocs.dataset.filtered:=true;

 end
 else
 begin
  pListaDocs.dataset.filtered:=false;
  pListaDocs.dataset.filter:='id_movimento='+Inttostr(pid_Movimento);
  pListaDocs.dataset.filtered:=true;
 end;
  If  Not pListaDocs.Vazia then
  begin

    Result:=TERPBECab.Create; //objecto usao tambem para as compras
    Result.EmModoEdicao:=false;
    Result.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('id_movimento').asinteger;
    result.ID_encomenda:= pListaDocs.davalor('ID_encomenda').asinteger;
         result.Encomenda:=false;
    if result.ID_encomenda>0 then
     result.Encomenda:=true;
    Result.NumDocumento:= pListaDocs.davalor('id_documento').asstring;
    Result.serie:= pListaDocs.davalor('serie').asstring;
    Result.typedoc:= pListaDocs.davalor('ContaCBLTDOC').asstring;
    Result.Data:= pListaDocs.davalor('Data').asdatetime;
    Result.DataDoc:= pListaDocs.davalor('DataDoc').asdatetime;
    If  pListaDocs.davalor('Datavencimento').asdatetime=0 then
       Result.Data:= pListaDocs.davalor('Data').asdatetime
    else
    Result.DataVenc:= pListaDocs.davalor('Datavencimento').asdatetime;
    Result.IDCliente:= pListaDocs.davalor('id_entidade').asinteger;
    If  pListaDocs.davalor('id_Tipoentidade').asinteger= 1 then
       Result.tipomov:=1
    else
     Result.tipomov:=2;


    //aqui tenho de testar se não tem tem de por do InterfaceIMC
    Result.Nrcliente:= pListaDocs.davalor('ContaCBLCliente').asstring;

    If  pListaDocs.davalor('ContaCBLCliente').asstring='' then
         Result.Nrcliente:=FOBJInterface.ID_clienteIndiferenciado;

    Result.DescTipoMovimento:= pListaDocs.davalor('Tipodoc').asstring;
    Result.TotalIVA := pListaDocs.davalor('TotalDociva').asFloat;
    Result.TotalCOMIVA := pListaDocs.davalor('TotalDocComIVA').asFloat;
    Result.TotalSEMIVA := pListaDocs.davalor('ValorDocSemIVA').asFloat;
    Result.TotalBruto:= pListaDocs.davalor('ValorTotal').asFloat;
    Result.Status:= 'N';
    Result.Nome:= pListaDocs.davalor('NomeCliente').asstring;
    Result.Morada:= pListaDocs.davalor('MoradaEntidade').asstring;
    Result.CodPostal:= pListaDocs.davalor('CodigoPostalEntidade').asstring
    +' '+ pListaDocs.davalor('RuaEntidade').asstring;
    Result.localidade:= pListaDocs.davalor('localidadeEntidade').asstring;
    Result.NIF:= pListaDocs.davalor('ContribuinteEntidade').asstring;
    Result.Integrado:=False;
    Result.origem:=2;
    Result.DataHoraRegisto:=now;
    Result.TotalLinhas:=pListaDocs.NumLinhas;
    Result.UtilizadorRegisto:=Sb.UtilizadorActual.Login;

    Result.CodPais:= pListaDocs.davalor('PaisISO').asstring;
    Result.DescPais:= pListaDocs.davalor('DescPais').asstring;
    Result.mercado:= pListaDocs.davalor('Mercado').asinteger;
    Result.DescMercado:=DadescMercado(Result.mercado);





    While Not (pListaDocs.NoFim) do
    begin
        If pListaDocs.davalor('tipoMovimento').asinteger=0 then
        begin
         ObjLinha:=TERPBELinha.create;
         With ObjLinha do
         begin
            ObjLinha.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('id_Movimento').asinteger;
            ObjLinha.ID_encomenda:= pListaDocs.davalor('ID_encomenda').asinteger;
            ObjLinha.NumDocumento:= pListaDocs.davalor('id_documento').asstring;
            ObjLinha.serie:= pListaDocs.davalor('serie').asstring;
            ObjLinha.ID_Linha:= pListaDocs.davalor('ID_Linha').asinteger;
            ObjLinha.ValorIVA:= pListaDocs.davalor('valoriva').asFloat;
            ObjLinha.ValorSemIVA:= pListaDocs.davalor('valorLinhasemIva').asFloat;
            ObjLinha.ValorCOMIVA:= pListaDocs.davalor('VAlorlinhaComIVA').asFloat;
            ObjLinha.TipoArtigo:= pListaDocs.davalor('TipoArtigoERP').asstring;


            ObjLinha.Id_ProdutoOrigem:= pListaDocs.davalor('id_Produto').asinteger;

            ObjLinha.precounitsemIVA:= pListaDocs.davalor('valorLinhasemIva').asFloat;
            ObjLinha.Data:= pListaDocs.davalor('data').asdatetime;
            ObjLinha.DataDoc:= pListaDocs.davalor('DataDoc').asdatetime;

            ObjLinha.servico:= pListaDocs.davalor('ContaCblprod').asstring;
            ObjLinha.Descritivo:= pListaDocs.davalor('DescricaoProduto').asstring;
            ObjLinha.qnt:= pListaDocs.davalor('quantidade').asfloat;
           If ((pListaDocs.davalor('guiaOrigem').asboolean =true) and
            (pListaDocs.davalor('MovGuia').asinteger =0)){saida} then
            begin
               If pListaDocs.davalor('ID_MovimentoOrigem').asinteger>0 then
               begin
                ObjLinha.ID_MovimentoOrigem:= pListaDocs.davalor('ID_MovimentoOrigem').asinteger;
                ObjLinha.ID_linhaOrigem:= pListaDocs.davalor('ID_linhaOrigem').asinteger;
                ObjLinha.ID_InternoOrigem:= DAID_InternoERPGuia(ObjLinha.ID_MovimentoOrigem,ObjLinha.ID_linhaOrigem);
               end;
            end;

               If pListaDocs.davalor('ID_encomendaOrigem').asinteger>0 then
               begin
                ObjLinha.ID_encomendaOrigem:= pListaDocs.davalor('ID_encomendaOrigem').asinteger;
                ObjLinha.ID_linhaencOrigem:= pListaDocs.davalor('ID_linhaencomendaOrigem').asinteger;
                ObjLinha.ID_InternoOrigem:= DAID_InternoERPEncomendas(ObjLinha.ID_encomendaOrigem,ObjLinha.ID_linhaencOrigem);
               end;





            If  pListaDocs.davalor('id_Unidade').asinteger>0 then
            begin
              ObjLinha.qnt:= pListaDocs.davalor('QuantidadeConvertida').asfloat;
              Try
                If (pListaDocs.davalor('valorLinhasemIva').asFloat<>0) and
                  (pListaDocs.davalor('quantidade').asfloat<>0) then
                      ObjLinha.precounitsemIVA:= (pListaDocs.davalor('valorLinhasemIva').asFloat /ObjLinha.qnt);
              except

              raise EErroNormal.Create('Exportação Movimentos','Conversão de Unidades:'+ pListaDocs.davalor('id_Movimento').asstring+
                      ' Produto: '+pListaDocs.davalor('DescricaoProduto').asstring,'Verifique as Unidades!');
              end;
            end;

            ObjLinha.precounit:= pListaDocs.davalor('valorunitario').asfloat;
            ObjLinha.codiva:= pListaDocs.davalor('ContaCBlIVA').asstring;
            ObjLinha.taxaiva:= pListaDocs.davalor('percentagemIVA').asFloat;
            ObjLinha.total:= pListaDocs.davalor('VAlorlinhaComIVA').asFloat;

            ObjLinha.Armazem:= pListaDocs.davalor('Armazem').asstring;
            ObjLinha.id_armazem:= pListaDocs.davalor('id_armazem').asinteger;
            ObjLinha.ID_ArmazemERP:= pListaDocs.davalor('ID_ArmazemERP').asstring;

            ObjLinha.CodIsencao:= pListaDocs.davalor('CodIsencao').asstring;
            ObjLinha.origem:=result.Origem;
            ObjLinha.Descontoperc:= pListaDocs.davalor('perDesconto').asFloat;

   //13-11-2019 Sr.Pedro Pinheiro falou com o eng.Paulo fernandes e transmitiu me para concatenar a origem com hieraquia de Produtos
            //origem 2 neste caso pois trata-se de fontenario
            ObjLinha.ID_GrupoProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_GrupoFamilia').asstring);
            ObjLinha.GrupoProduto:= pListaDocs.davalor('GrupoFamilia').asstring;


            ObjLinha.ID_FamiliaProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_Familia').asstring);
            ObjLinha.FamiliaProduto:= pListaDocs.davalor('Familia').asstring;

            ObjLinha.ID_SubFamiliaProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_SubFamilia').asstring);
            ObjLinha.SubFamiliaProduto:= pListaDocs.davalor('SubFamilia').asstring;

            Result.Linhas.Adiciona(ObjLinha);
          end
         end
          else
          If  pListaDocs.davalor('id_ModoPagamento').asinteger>0 then
          begin
            ObjLinhaPagamento:=TERPBELinhaPagamento.create;
            ObjLinhaPagamento.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('id_Movimento').asinteger;
            ObjLinhaPagamento.ID_Linha:= pListaDocs.davalor('ID_Linha').asinteger;
            ObjLinhaPagamento.ID_ModoPagamento:= pListaDocs.davalor('ID_ModoPagamento').asInteger;
            ObjLinhaPagamento.ContaERP:= pListaDocs.davalor('ContaCBLPag').asstring;
            ObjLinhaPagamento.descricao:= pListaDocs.davalor('DescricaoProduto').asstring;
            ObjLinhaPagamento.Valor:= pListaDocs.davalor('ValorUnitario').asFloat;

            Result.Pagamentos.Adiciona(ObjLinhaPagamento);

           end;


        pListaDocs.seguinte;
    end;
  end;

end;





Function ValidaExportacaoDocumento(ObjCab:TERPBECab;var mensagem:string):Boolean;
var
 i:integer;
 ListaD:Tsbbetabeladados;

begin
  result:=true;
  mensagem:='';

  If FOBJInterface.ObgContaERPCliente=true then
    If ObjCab.Nrcliente='' then
      mensagem:='Conta do CLIENTE';

  For i:=0 to  ObjCab.Linhas.Num-1 do
  begin
      If  FOBJInterface.ObgLinhaContaERPProd=true then
        If  (ObjCab.Linhas.elem[i].servico='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do Produto:'+ ObjCab.Linhas.elem[i].Descritivo;

      If  FOBJInterface.ObgLinhaContaERPIVA=true then
       If  (ObjCab.Linhas.elem[i].codiva='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do IVA:'+FloatTostr(ObjCab.Linhas.elem[i].taxaiva);
  end;
  If   FOBJInterface.ObgLinhaContaERPModPag=true then
      For i:=0 to  ObjCab.Pagamentos.Num-1 do
      begin
          If  (ObjCab.Pagamentos.elem[i].ContaERP='') then
              mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do Pagamento:'+ ObjCab.Pagamentos.elem[i].Descricao;
      end;
  If mensagem<>'' then
  begin
   mensagem:=ObjCab.DescTipoMovimento+' nº '+ObjCab.NumDocumento+' | Data: '+datetostr(ObjCab.Data)+#13+mensagem;
   result:=false;
  end;
  If Result then
  begin
          ListaD:=sb.SBBD.AbrirLV('select id_interno, Id_Movimento from ERP_CompCab  where Id_Movimento='+Inttostr(ObjCab.ID_VNDCABDOCUMENTO));
          If Not(ListaD.vazia) then
          begin
            ObjCab.EmModoEdicao:=true;
            ObjCab.ID_InternoERP:=Listad.davalor('id_interno').asinteger;
          end;
          ListaD.fecha;
  end;

end;

Function ValidaExportacaoDocumentoENC(ObjCab:TERPBECab;var mensagem:string):Boolean;
var
 i:integer;
 ListaD:Tsbbetabeladados;

begin
  result:=true;
  mensagem:='';
  If ObjCab.Nrcliente='' then
    mensagem:='Conta do CLIENTE';
  For i:=0 to  ObjCab.Linhas.Num-1 do
  begin
      If  (ObjCab.Linhas.elem[i].servico='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do Produto:'+ ObjCab.Linhas.elem[i].Descritivo;
      If  (ObjCab.Linhas.elem[i].codiva='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do IVA:'+FloatTostr(ObjCab.Linhas.elem[i].taxaiva);
  end;
  For i:=0 to  ObjCab.Pagamentos.Num-1 do
  begin
      If  (ObjCab.Pagamentos.elem[i].ContaERP='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do Pagamento:'+ ObjCab.Pagamentos.elem[i].Descricao;
  end;
  If mensagem<>'' then
  begin
   mensagem:='Documento nº'+ObjCab.NumDocumento+' '+ObjCab.typedoc+#13+mensagem;
   result:=false;
  end;
  If Result then
  begin
          ListaD:=sb.SBBD.AbrirLV('select id_interno, id_encomenda from ERP_CompCab  where Id_encomenda='+Inttostr(ObjCab.id_encomenda));
          If Not(ListaD.vazia) then
          begin
            ObjCab.EmModoEdicao:=true;
            ObjCab.ID_InternoERP:=Listad.davalor('id_interno').asinteger;
          end;
          ListaD.fecha;
  end;

end;



Procedure InsereLinha(ObjLinha:TERPBELinha);
var
 stsql:string;
 i:integer;
begin
//[mpehotel]
//   +',datainv'
  With ObjLinha do
  Begin
     If ObjLinha.ID_MovimentoOrigem>0 then
     begin
        ObjLinha.ID_InternoOrigem:= DAID_InternoERPGuia(ObjLinha.ID_MovimentoOrigem,ObjLinha.ID_linhaOrigem);
     end;

     If ObjLinha.ID_EncomendaOrigem>0 then
     begin
        ObjLinha.ID_InternoOrigem:= DAID_InternoERPEncomendas
        (ObjLinha.ID_EncomendaOrigem,ObjLinha.ID_linhaencOrigem);
     end;

    stsql:= ' INSERT INTO [ERP_CompDetalhes]'
         + ' ([ID_Interno]'
         +  ',[ID_Linha]   '
         +  ',[Serie]'
         +  ',[NumDocumento] '
         +  ',[Data] '
         +  ',[DataDoc] '
         +  ',[servico]'
         +  ',[Descritivo] '
         +  ',[qnt] '
         +  ',[ValorUnitSemIVA]'
         +  ',[ValorTotalSemIVA] '
         +  ',[ValorTotalIVA] '
         +  ',[ValorTotalComIVA]'
         +  ',[codiva] '
         +  ',[taxaiva] '
         +  ',[Armazem]'
         +  ',[ID_Armazem]'
         +  ',[ID_ArmazemERP]'
         +  ',[CCusto] '
         +  ',[CodIsencao] '
         +  ',[Descontoperc] '
         +  ',[DescontoValor] '
         +  ',[ID_Movimento]   '
         +  ',[Origem],TipoArtigo '
          +',ID_GrupoProduto'
          +',GrupoProduto'
          +',ID_FamiliaProduto'
          +',FamiliaProduto'
          +',ID_SubFamiliaProduto'
          +',SubFamiliaProduto'
          +',ID_MovimentoOrigem'
          +',ID_linhaOrigem'
          +',ID_InternoOrigem'
          +',ID_EncomendaOrigem'
          +',ID_linhaEncOrigem'
          +',ID_Encomenda'

         +') '
          +' values( '
          + IntToStr(ObjLinha.ID_internoDoc)
         +','+ IntToStr(ObjLinha.ID_Linha)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.Serie)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.NumDocumento)
           +','+ sb.UtilSQL.DataToSQLData(ObjLinha.Data)
           +','+ sb.UtilSQL.DataToSQLData(ObjLinha.DataDoc)           
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.servico)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.Descritivo)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.qnt,'0.0000')
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.precounitsemIVA,'0.0000')
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.ValorSemIVA,'0.0000')
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.ValorIVA,'0.0000')
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.ValorComIVA,'0.0000')
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.codiva)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.taxaiva)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.Armazem)
           +','+ inttostr(ObjLinha.ID_Armazem)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.ID_ArmazemERP)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.CCusto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.CodIsencao)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.Descontoperc)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.DescontoValor)
           +','+ IntToStr(ObjLinha.ID_VNDCABDOCUMENTO)
           +','+ IntToStr(ObjLinha.Origem)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.TipoArtigo)

           +','+ IntToStr(ObjLinha.ID_GrupoProduto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.GrupoProduto)

           +','+ IntToStr(ObjLinha.ID_FamiliaProduto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.FamiliaProduto)

           +','+ IntToStr(ObjLinha.ID_SubFamiliaProduto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.SubFamiliaProduto)
           +','+ IntToStr(ObjLinha.ID_MovimentoOrigem)
           +','+ IntToStr(ObjLinha.ID_linhaOrigem)
           +','+ IntToStr(ObjLinha.ID_InternoOrigem)
           +','+ IntToStr(ObjLinha.ID_EncomendaOrigem)
           +','+ IntToStr(ObjLinha.ID_linhaEncOrigem)
           +','+ IntToStr(ObjLinha.ID_Encomenda)


           +')';
         Try
          sb.SBBD.Executa(stsql);
          except
          raise;
         end; 

   end;
end;


Procedure InsereLinhaPagamento(ObjPagamento:TERPBELinhaPagamento);
var
 stsql:string;
 i:integer;
begin
  With ObjPagamento do
  Begin
    stsql:= ' INSERT INTO [ERP_CompPagamentos]'
           + '('
           + 'ID_Interno'
           +', ID_Movimento'
           + ',ID_linha'
           + ',ID_ModoPagamento'
           + ',ContaERP'
           + ',Descricao'
           + ',Valor)'
          +' values( '
            + IntToStr(ObjPagamento.ID_internoDoc)
           +','+ IntToStr(ObjPagamento.ID_VNDCABDOCUMENTO)
           +','+ IntToStr(ObjPagamento.ID_Linha)
           +','+ IntToStr(ObjPagamento.ID_ModoPagamento)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjPagamento.ContaERP)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjPagamento.Descricao)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjPagamento.Valor)
           +')';
          try
              sb.SBBD.Executa(stsql);
          except
           raise
          end; 

   end;
end;

Procedure EnviaParaLogMovimenstosAlterados(pID_interno:Integer);
var
strsql:string;
begin
 try
  strsql:='';
  strsql:= 'INSERT INTO [LOGERP_CompCab]'
      +'         ([ID_Interno]'
           +',[typedoc]'
           +',[Serie]'
           +',[ID_Movimento]'
           +',[NumDocumento]'
           +',[Data]'
           +',[DataVenc]'
           +',[IDCliente]'
           +',[Nrcliente]'
           +',[Status]'
           +',[Assinatura]'
           +',[Chave]'
           +',[Nome]'
           +',[Morada]'
           +',[localidade]'
           +',[CodPostal]'
           +',[NIF]'
           +',[TotalIVA]'
           +',[TotalSEMIVA]'
           +',[TotalCOMIVA]'
           +',[Integrado]'
           +',[DataHoraIntegracao]'
           +',[Origem]'
           +',[DataHoraRegisto]'
           +',[TotalLinhas]'
           +',[UtilizadorRegisto]'
           +',[DescTipoMovimento]'
           +',[PRIMAVERA_ID]'
           +',[PRIMAVERA_TipoDoc]'
           +',[PRIMAVERA_Serie]'
           +',[PRIMAVERA_NumDoc]'
           +',[TIPOMOV]'
           +')'

    +' SELECT [ID_Interno]'
      +',[typedoc]'
      +',[Serie]'
      +',[ID_Movimento]'
      +',[NumDocumento]'
      +',[Data]'
      +',[DataVenc]'
      +',[IDCliente]'
      +',[Nrcliente]'
      +',[Status]'
      +',[Assinatura]'
      +',[Chave]'
      +',[Nome]'
      +',[Morada]'
      +',[localidade]'
      +',[CodPostal]'
      +',[NIF]'
      +',[TotalIVA]'
      +',[TotalSEMIVA]'
      +',[TotalCOMIVA]'
      +',[Integrado]'
      +',[DataHoraIntegracao]'
      +',[Origem]'
      +',[DataHoraRegisto]'
      +',[TotalLinhas]'
      +',[UtilizadorRegisto]'
      +',[DescTipoMovimento]'
      +',[PRIMAVERA_ID]'
      +',[PRIMAVERA_TipoDoc]'
      +',[PRIMAVERA_Serie]'
      +',[PRIMAVERA_NumDoc],TIPOMOV'
      +' FROM [ERP_CompCab]'
      +' where  ID_Interno='+inttostr(pID_Interno);
      sb.SBBD.Executa(strsql);




   strsql:='';
strsql:= 'INSERT INTO [LOGERP_CompDetalhes]'
           +'([ID_Interno]'
           +',[ID_Movimento]'
           +',[ID_Linha]'
           +',[Serie]'
           +',[NumDocumento]'
           +',[datainv]'
           +',[Data]'
           +',[servico]'
           +',[Descritivo]'
           +',[qnt]'
           +',[ValorUnitSemIVA]'
           +',[ValorTotalSemIVA]'
           +',[ValorTotalIVA]'
           +',[ValorTotalComIVA]'
           +',[codiva]'
           +',[taxaiva]'
           +',[ID_Armazem]'
           +',[Armazem]'
           +',[ID_ArmazemERP]'
           +',[CCusto]'
           +',[CodIsencao]'
           +',[Descontoperc]'
           +',[DescontoValor]'
           +',[Origem])'

+' SELECT [ID_Interno]'
      +',[ID_Movimento]'
      +',[ID_Linha]'
      +',[Serie]'
      +',[NumDocumento]'
      +',[datainv]'
      +',[Data]'
      +',[servico]'
      +',[Descritivo]'
      +',[qnt]'
      +',[ValorUnitSemIVA]'
      +',[ValorTotalSemIVA]'
      +',[ValorTotalIVA]'
      +',[ValorTotalComIVA]'
      +',[codiva]'
      +',[taxaiva]'
      +',[ID_Armazem]'
      +',[Armazem]'
      +',[ID_ArmazemERP]'
      +',[CCusto]'
      +',[CodIsencao]'
      +',[Descontoperc]'
      +',[DescontoValor]'
      +',[Origem]'
  +' FROM [ERP_CompDetalhes]'
  +'  where  ID_Interno='+inttostr(pID_Interno);
  sb.SBBD.Executa(strsql);

  strsql:='';
strsql:= 'INSERT INTO [LOGERP_CompPagamentos]'
           +'([ID_Interno]'
           +',[ID_Movimento]'
           +',[ID_linha]'
           +',[ID_ModoPagamento]'
           +',[ContaERP]'
           +',[Descricao]'
           +',[Valor])'

    +' SELECT [ID_Interno]'
      +',[ID_Movimento]'
      +',[ID_linha]'
      +',[ID_ModoPagamento]'
      +',[ContaERP]'
      +',[Descricao]'
      +',[Valor]'
  +' FROM [ERP_CompPagamentos]'
  +'  where  ID_Interno='+inttostr(pID_Interno);
  sb.SBBD.Executa(strsql);
 except
  raise
 end; 
end;


Procedure GravaDocCmp(ObjCab:TERPBECab);
var
 stsql:widestring;
 i:integer;
 ProximoID_InternoDoc:integer;
 encomenda:boolean;
begin

  encomenda:=false;

  With ObjCab do
  Begin
    if objcab.id_encomenda>0 then
    begin
     encomenda:=true;
    end;

   If ObjCab.EmModoEdicao then
   begin
    ObjCab.ID_internoDoc:=ObjCab.ID_InternoERP;
    EnviaParaLogMovimenstosAlterados(ObjCab.ID_internoDoc);
    stsql:=' update ERP_CompCAB'
          + ' set typedoc='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.typedoc)
           +',Serie='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Serie)
           +',Numdocumento=' + sb.UtilSQL.StrToSQLStrpelica(ObjCab.Numdocumento)
           +',Data=' + sb.UtilSQL.DataToSQLData(ObjCab.Data)
           +',DataDoc=' + sb.UtilSQL.DataToSQLData(ObjCab.DataDoc)           
           +',DataVenc='+ sb.UtilSQL.DataToSQLData(ObjCab.DataVenc)

           +',IDCliente=' + IntToStr(ObjCab.IDCliente)
           +',Nrcliente=' + sb.UtilSQL.StrToSQLStrpelica(ObjCab.Nrcliente)
           +',Status='  + sb.UtilSQL.StrToSQLStrpelica(ObjCab.Status)
           +',Nome=' + sb.UtilSQL.StrToSQLStrpelica(ObjCab.Nome)
           +',Morada='  + sb.UtilSQL.StrToSQLStrpelica(ObjCab.Morada)
           +',localidade='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.localidade)
           +',CodPostal='  + sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodPostal)
           +',NIF='  + sb.UtilSQL.StrToSQLStrpelica(ObjCab.NIF)
          +' ,TotalIVA='   + sb.UtilSQL.DecimalToSQLStr(ObjCab.TotalIVA)
           +',TotalSEMIVA=' + sb.UtilSQL.DecimalToSQLStr(ObjCab.TotalSEmIVA)
           +',TotalCOMIVA='+ sb.UtilSQL.DecimalToSQLStr(ObjCab.TotalCOMIVA)
           +',Origem=' + IntToStr(ObjCab.Origem)
           +',DataHoraRegisto='  + sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.DataHoraRegisto)
           +',ID_Movimento='   + IntToStr(ObjCab.ID_VNDCABDOCUMENTO)
           +',ID_encomenda='   + IntToStr(ObjCab.ID_encomenda)
           +',TotalLinhas='  + IntToStr(ObjCab.TotalLinhas)
           +',UtilizadorRegisto='  + sb.UtilSQL.StrToSQLStrpelica(ObjCab.UtilizadorRegisto)
           +', integrado=0'
             +',encomenda=' + sb.UtilSQL.BoolToSQLStr(encomenda)
           +',DescTipoMovimento='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.DescTipoMovimento)
           +' where  ID_interno='+ inttostr(ObjCab.ID_internoDoc);
          sb.SBBD.Executa(stsql);
          sb.SBBD.Executa('delete from  ERP_CompDetalhes where  ID_interno='+ inttostr(ObjCab.ID_internoDoc));
          sb.SBBD.Executa('delete from  ERP_CompPagamentos where  ID_interno='+ inttostr(ObjCab.ID_internoDoc));

   end
   else
   begin
    ProximoID_InternoDoc:=sb.ProximoID('ERP_CompCAB',true);
    ObjCab.ID_internoDoc:=ProximoID_InternoDoc;
    stsql:=' INSERT INTO ERP_CompCAB'
         +'  ('
          +'ID_Interno'
          + ',typedoc'
           +',Serie'
           +',Numdocumento'
           +',Data'
           +',DataDoc'
           +',DataVenc'
           +',IDCliente'
           +',Nrcliente'

           +',Status'
           +',Assinatura'
           +',Chave'
           +',Nome'
           +',Morada'
           +',localidade'
           +',CodPostal'
           +',NIF'
          +' ,[TotalIVA]'
           +',[TotalSEMIVA]'
           +',[TotalCOMIVA]'

           +',Origem'
           +',DataHoraRegisto'
           +',ID_Movimento'
           +',TotalLinhas'
           +',UtilizadorRegisto,integrado,DescTipoMovimento,TIPOMOV'
           +' , id_encomenda,encomenda '
           +',CodPais,DescPais ,Mercado ,DescMercado'
           +')'
           +' values( '
           +inttostr(ObjCab.ID_internoDoc)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.typedoc)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Serie)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Numdocumento)
           +','+ sb.UtilSQL.DataToSQLData(ObjCab.Data)
           +','+ sb.UtilSQL.DataToSQLData(ObjCab.DataDoc)           
           +','+ sb.UtilSQL.DataToSQLData(ObjCab.DataVenc)
           +','+ IntToStr(ObjCab.IDCliente)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Nrcliente)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Status)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Assinatura)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Chave)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Nome)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Morada)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.localidade)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodPostal)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.NIF)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjCab.TotalIVA)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjCab.TotalSEmIVA)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjCab.TotalCOMIVA)
           +','+ IntToStr(ObjCab.Origem)
           +','+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.DataHoraRegisto)
           +','+ IntToStr(ObjCab.ID_VNDCABDOCUMENTO)
           +','+ IntToStr(ObjCab.TotalLinhas)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.UtilizadorRegisto)
           +','+ sb.UtilSQL.BoolToSQLStr(false)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.DescTipoMovimento)
           +','+ inttostr(ObjCab.TipoMov)
            +','+ inttostr(ObjCab.id_encomenda)
           +','+ sb.UtilSQL.BoolToSQLStr(encomenda)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodPais)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.DescPais)
           +','+ IntToStr(ObjCab.Mercado)
           +','+ sb.UtilSQL.StrToSQLStrpelica(DescMercado)

           +')';
          sb.SBBD.Executa(stsql);
       end;

       For i:=0 to ObjCab.Linhas.Num-1 do
       begin
         ObjCab.Linhas.elem[i].ID_internoDoc:= ObjCab.ID_internoDoc;
         InsereLinha(ObjCab.Linhas.elem[i]);
       end;

       For i:=0 to ObjCab.Pagamentos.Num-1 do
       begin
          ObjCab.Pagamentos.elem[i].ID_internoDoc:= ObjCab.ID_internoDoc;
           InsereLinhaPagamento(ObjCab.Pagamentos.Elem[i]);
       end;
    end;
end;



Function ExportarCompras(pListaDocs:TsbbeTabeladados;var pListaIDSExportados:tstringList):Boolean;
var
   ObjCabecalhos:TERPBECabecalhos;
   ObjCab:TERPBECab;
   ListaIDSDocs:TstringList;
   i:Integer;

   strsql,strMensagemErros,strdoc:string;

begin
 Result:=false;
  strMensagemErros:='';
  If  Not(ValidaExportacao(strMensagemErros)) then
    sb.Dialogos.SBMessage(strMensagemErros)
  else
  If Not(pListaDocs.Vazia) then
  begin


       pListaDocs.dataset.filtered:=false;
       pListaDocs.inicio;
       ListaIDSDocs:= DalistaIDDocs(pListaDocs);
       pListaDocs.inicio;
       ObjCabecalhos:=TERPBECabecalhos.create;
       For i:=0 to ListaIDSDocs.Count-1 do
       begin
          ObjCab:=PreencheOBJDoc(pListaDocs,strtoint(ListaIDSDocs.strings[i]));
          ObjCabecalhos.Adiciona(ObjCab);
       end;

       If ObjCabecalhos.num>0 then
       begin
        SBBD.IniciaTransacao;
        try
         For i:=0 to  ObjCabecalhos.Num-1 do
         begin
            If assigned(ObjCabecalhos.Elem[i]) then
            Begin
              strdoc:=ObjCabecalhos.Elem[i].DescTipoMovimento+' | nº '+
               ObjCabecalhos.Elem[i].NumDocumento+' Data: '+DateToStr(ObjCabecalhos.Elem[i].Data);
            end;

           If ValidaExportacaoDocumento(ObjCabecalhos.Elem[i],strMensagemErros) then
           begin
               GravaDocCMp(ObjCabecalhos.Elem[i]);
               pListaIDSExportados.add(inttostr(ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO));
           end
           else
           begin
           Raise
               SB.ErroNormal(0,'Exportação de Compras Interrompida','Grava Documento',strMensagemErros);
               GravaERROExportacaoSycontroller(ObjCabecalhos.Elem[i],strdoc,strMensagemErros);
           end;
         end;

         SBBD.TerminaTransacao;
         result:=true;

        Except
              SBBD.DesfazTransacao;
              Result:=false;
              if assigned(ObjCabecalhos) then
               freeandnil(ObjCabecalhos);
              raise;
        end;
       end;
  end;
end;


procedure MarcaMovimentosComoExportados(pDataIni,pdatafim:tdatetime;pListaIDSExp:TstringList;pLista:tsbbetabeladados;pnomeInterface:string);
var
 Nomeinterface,strsql:string;
 id_Interno:integer;
 ListaIDDocs:tstringList;
begin
If pListaIDSExp.Count>0 then
begin
 ListaIDDocs:=tstringList.create;
 pLista.dataset.filtered:=false;
 Nomeinterface:='ERPIntegration';
//grava cabecalho LOG
 id_Interno:=0;
 id_Interno:=MotorFnt.sb.ProximoID('LogCabCBLExportacao',true);
 strsql:='INSERT INTO [LogCabCBLExportacao]'
         +'  ([ID_Interno]'
         +'  ,[NomeInterface]'
         +' ,[DataExportacao]'
         +'  ,[HoraExportacao]'
         +' ,[ExportadoPor] '
         +'  ,[DataInicio]'
         +' ,[DataFim]  '
         +' ,[NomeFicheiro])'
         +'     VALUES '
         +'   ('
         + Inttostr(id_interno)
         +','+sb.UtilSQL.StrToSQLStrpelica(Nomeinterface)
         +','+sb.UtilSQL.DataToSQLData(sb.DataSistema)
         +','+sb.UtilSQL.DateTimeToSQLDataHora(time)
         +','+sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
         +','+sb.UtilSQL.DataToSQLData(pDataIni)
         +','+sb.UtilSQL.DataToSQLData(pdatafim)
         +','+sb.UtilSQL.StrToSQLStrpelica('')
         +')';
  sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);



 //atencão na lista de compras o campo id_movimento está com "alias" id_VndCabdocumento
 pLista.inicio;
 While not (pLista.nofim) do
 begin
      If pListaIDSExp.indexof(pLista.davalor('id_movimento').asstring)<>-1 then  //verfica se esta na lista dos exportados
      If ListaIDDocs.indexof(pLista.davalor('id_movimento').asstring)=-1 then
      Begin
              strsql:='INSERT INTO [LogLinhaCBLExportacao]'
                  +' ([ID_Interno]'
                  +'  ,[ID_InternoDoc]'
                  +'  ,[EstadoDoc]'
                  +'  ,DescricaoDoc '
                  +' ,ID_DocumentoExterno'
                   +', NomeEntidade'
                   +',DataDoc '
                  +' ,[Compra])'
                  +'      VALUES'
                  +' ('
                  + Inttostr(id_interno)
                  +','+Inttostr(pLista.davalor('id_movimento').asinteger)
                  +','+Inttostr(pLista.davalor('Estado').asinteger)
                  +','+sb.UtilSQL.StrToSQLStrpelica(pLista.davalor('TipoDoc').asstring)
                  +','+sb.UtilSQL.StrToSQLStrpelica(pLista.davalor('ID_Documento').asstring)
                  +','+sb.UtilSQL.StrToSQLStrpelica(pLista.davalor('NomeCliente').asstring)
                  +','+sb.UtilSQL.DataToSQLData(pLista.davalor('datadoc').asdatetime)
                  +',1)';

          sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);

          strsql:='update movimentostock set CBLExportado=1'
          +',    ID_LogCabCBLExportacao='+Inttostr(id_interno)
          +',  CBLExportadopor='+sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
          +',  CBLExportadoDTHora='+sb.UtilSQL.DateTimeToSQLDataHora(sb.DataSistema)
          +' Where id_Movimento='+Inttostr(pLista.davalor('id_movimento').asinteger);
          sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);

         strsql:=' update Erp_ErroExportacaoMovStocks set Exportado=1 '
             +', dataexportacaomanual='+sb.UtilSQL.DateTimeToSQLDataHora(sb.DataSistema)
             +', Exportadopor='+sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
            +' where  ID_Movimento='+Inttostr(pLista.davalor('id_movimento').asinteger)
            +' and  Exportado=0';
          sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);            

          ListaIDDocs.Add(pLista.davalor('id_movimento').asstring)
      end;
   pLista.seguinte;
 end;
 Freeandnil(ListaIDDocs);
end;
end;



procedure LIMPAEXportacoes();
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
 strsql:string;
begin
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_COMPRASSYSCONTROLLER');
  If ObjInterface<>nil then
  begin
    If ObjInterface.BDConexao<>'' then
    begin
     strsql:=' update Contadores set id_corrente=0 where Nome_tabela=''LogCabCBLExportacao''';
     sb.SBBD.ExecutaSqlExterno(ObjInterface.BDConexao,strsql);

     strsql:='Delete from  LogLinhaCBLExportacao';
     sb.SBBD.ExecutaSqlExterno(ObjInterface.BDConexao,strsql);

     strsql:='Delete from  LogCabCBLExportacao';
     sb.SBBD.ExecutaSqlExterno(ObjInterface.BDConexao,strsql);


     strsql:='update movimentostock set CBLExportado=0'
          +',    ID_LogCabCBLExportacao='+Inttostr(0)
          +',  CBLExportadopor='+sb.UtilSQL.StrToSQLStrpelica('');

          sb.SBBD.ExecutaSqlExterno(ObjInterface.BDConexao,strsql);
    end;
    Freeandnil(ObjInterface);
  end;


end;






Function ExportarMovStocksautomatico(pListaDocs:TsbbeTabeladados;var pListaIDSExportados:tstringList):Boolean;
var
   ObjCabecalhos:TERPBECabecalhos;
   ObjCab:TERPBECab;
   ListaIDSDocs:TstringList;
   i:Integer;
   strdoc,strsql,strMensagemErros:string;
begin
  Result:=false;
  strMensagemErros:='';
  If Not(pListaDocs.Vazia) then
  begin

       pListaDocs.dataset.filtered:=false;
       pListaDocs.inicio;
       ListaIDSDocs:= DalistaIDDocs(pListaDocs);
       pListaDocs.inicio;
       ObjCabecalhos:=TERPBECabecalhos.create;
       For i:=0 to ListaIDSDocs.Count-1 do
       begin
          ObjCab:=PreencheOBJDoc(pListaDocs,strtoint(ListaIDSDocs.strings[i]));
          ObjCabecalhos.Adiciona(ObjCab);
       end;

       If ObjCabecalhos.num>0 then
       begin
        SBBD.IniciaTransacao;
        try
         For i:=0 to  ObjCabecalhos.Num-1 do
         begin
            If assigned(ObjCabecalhos.Elem[i]) then
            Begin
              strdoc:=ObjCabecalhos.Elem[i].DescTipoMovimento+' nº '+
               ObjCabecalhos.Elem[i].NumDocumento+' Data '+DateToStr(ObjCabecalhos.Elem[i].Data);
            end;
           If ValidaExportacaoDocumento(ObjCabecalhos.Elem[i],strMensagemErros) then
           begin
               GravaDocCMP(ObjCabecalhos.Elem[i]);
               pListaIDSExportados.add(inttostr(ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO));
           end
           else
           begin
             result:=false;
             SBBD.DesfazTransacao;
             pListaIDSExportados.clear;
             ERPEnvioEmail.EnviaEmail('Exportação Mov-Stocks','Exportação Interrompida! '+strMensagemErros);
             GravaERROExportacaoSycontroller(ObjCabecalhos.Elem[i],strdoc,strMensagemErros);
             EnviaEmailErroExporAuto(3, ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO,'Exportação Mov-Stocks',strdoc,strMensagemErros);
             exit;
           end;
         end;

         SBBD.TerminaTransacao;
         result:=true;
        Except

                 on E:Exception do
                 begin

                   Result:=false;
                   SB.SBBD.DesfazTransacao;
                   strMensagemErros:='Erro ao exportar  Movimentos Compra '+#13+E.Message+' '+ strdoc;
                   ERPEnvioEmail.EnviaEmail('Exportao Mov-Stocks','Exportação Interrompida! '+strdoc+E.Message );
                 end;
                 On E:EErroDetalhe Do
                 Begin
                   Result:=false;
                   SB.SBBD.DesfazTransacao;
                   strMensagemErros:='Erro ao exportar  Movimentos Compra '+#13+E.Detalhe+' '+ strdoc;
                   ERPEnvioEmail.EnviaEmail('Exportao Mov-Stocks','Exportação Interrompida! '+strdoc+E.Detalhe);
                 End
                 else
                 begin
                  Result:=false;
                  if  strMensagemErros='' then
                          strMensagemErros:='Erro ao exportar Movimentos Compra';
                  ERPEnvioEmail.EnviaEmail('Exportao Mov-Stocks','Exportação Interrompida! '+strMensagemErros+' '+ strdoc);
                  SB.SBBD.DesfazTransacao;
                end;
        end;
       end;
  end;
end;




//não interrompe se falhar uum documento
Function ExportarMovStocksAutomaticaNaoPARA(pListaDocs:TsbbeTabeladados;var pListaIDSExportados:tstringList):Boolean;
var
   ObjCabecalhos:TERPBECabecalhos;
   ObjCab:TERPBECab;
   ListaIDSDocs:TstringList;
   i:Integer;
   strdoc,strsql,strMensagemErros:string;
begin
  Result:=false;
  strMensagemErros:='';
  If Not(pListaDocs.Vazia) then
  begin
       pListaDocs.dataset.filtered:=false;
       pListaDocs.inicio;
       ListaIDSDocs:= DalistaIDDocs(pListaDocs);
       pListaDocs.inicio;
       ObjCabecalhos:=TERPBECabecalhos.create;
       For i:=0 to ListaIDSDocs.Count-1 do
       begin
          ObjCab:=PreencheOBJDoc(pListaDocs,strtoint(ListaIDSDocs.strings[i]));
          ObjCabecalhos.Adiciona(ObjCab);
       end;

       If ObjCabecalhos.num>0 then
       begin
         For i:=0 to  ObjCabecalhos.Num-1 do
         begin
            If assigned(ObjCabecalhos.Elem[i]) then
            Begin
              strdoc:=ObjCabecalhos.Elem[i].DescTipoMovimento+' nº'+
               ObjCabecalhos.Elem[i].NumDocumento+' Data '+DateToStr(ObjCabecalhos.Elem[i].Data);
            end;
           If ValidaExportacaoDocumento(ObjCabecalhos.Elem[i],strMensagemErros) then
           begin
                SBBD.IniciaTransacao;
                try
                   GravaDocCMP(ObjCabecalhos.Elem[i]);
                   SBBD.TerminaTransacao;
                   pListaIDSExportados.add(inttostr(ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO));
                   Result:=true;
                except
                on E:Exception do
                         begin
                           SB.SBBD.DesfazTransacao;
                           strMensagemErros:='Erro ao exportar  Movimentos Compra'+#13+E.Message+' '+ strdoc;
                           ERPEnvioEmail.EnviaEmail('Exportao Mov-Stocks','Movimento não exportado! '+strMensagemErros);
                           GravaERROExportacaoSycontroller(ObjCabecalhos.Elem[i],strdoc,strMensagemErros);                           
                         end;
                         On E:EErroDetalhe Do
                         Begin
                           SB.SBBD.DesfazTransacao;
                           strMensagemErros:='Erro ao exportar  Movimentos Compra'+#13+E.Detalhe+' '+ strdoc;
                           ERPEnvioEmail.EnviaEmail('Exportao Mov-Stocks','Movimento não! '+strMensagemErros);
                           GravaERROExportacaoSycontroller(ObjCabecalhos.Elem[i],strdoc,strMensagemErros);
                         End
                         else
                         begin
                          if  strMensagemErros='' then
                                  strMensagemErros:='Erro ao exportar Movimentos Compra';
                          ERPEnvioEmail.EnviaEmail('Exportação Mov-Stocks','Movimento não exportado!  '+strMensagemErros+' '+ strdoc);
                          SB.SBBD.DesfazTransacao;
                           GravaERROExportacaoSycontroller(ObjCabecalhos.Elem[i],strdoc,strMensagemErros);
                        end;

                end;
           end
           else
           begin
             GravaERROExportacaoSycontroller(ObjCabecalhos.Elem[i],strdoc,strMensagemErros);
             ERPEnvioEmail.EnviaEmail('Exportação Mov-Stocks','Movimento não exportado! '+strMensagemErros);
             EnviaEmailErroExporAuto(3, ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO,'Exportação Mov-Stocks',strdoc,strMensagemErros);
           end;
         end;
       end;
  end;
end;




Function ExportarcomprasAutomatico(pdataInicio:Tdatetime):Boolean;
var SysObjInterface:TERPBEEMPRESAINTERFACE;
  ID_TipoMov:integer;
  filtro:string;
  Lista:tsbbetabeladados;
  ListaIDSExportados:TsTringList;
  atualizou:boolean;
begin
  atualizou:=false;
  If FOBJInterface<>nil then
  begin
       If TestaConexaoBDExterna(FOBJInterface.BDConexao) then
       begin
        FExpApenasComprasFechadas:=true;

        ListaIDSExportados:=TstringList.create;
        Lista:=DaListaDocumentosCMPPorExportar(Filtro,FOBJInterface.DATAInicioExportacao,0,FOBJInterface.PrefixoContCblAartigo);
        If Lista<>nil then
        try
          If Not Lista.Vazia then
          begin
           If FOBJInterface.NaoParaInterfaceAutCompras=true then
              atualizou:= ExportarMovStocksAutomaticaNaoPARA(Lista,ListaIDSExportados)
           else
             atualizou:=ExportarMovStocksautomatico(Lista,ListaIDSExportados);

           If atualizou=true then
           begin
              MarcaMovimentosComoExportados(FOBJInterface.DATAInicioExportacao,date,ListaIDSExportados,lista,'ERPIntegration');
              RegistaLogOperacao('Operação:Exportação Compras SYSController');
           end;

          end;
         Finally
          Lista.Fecha;
          FreeAndNil(lista);
          ListaIDSExportados.free;
         end;
      end
      else
       EnviaEmailErroExporAuto(2, 0,'Exportação Compras-Syscontroller','Exportação automática','Não foi possivel Conectar á Base de dados Sycontroller');
   end;
end;


//exportação automatica de inventarios



Function DevolveIDInventariosExportados:string;
Var strsql:string;
lstInventarios:tsbbeTabelaDados;
begin
  strsql:='select * from ERP_CabInventario';
  lstInventarios:=sb.sbbd.AbrirLV(strsql);

  if lstInventarios.Vazia then
   result:=''
  else
  begin
    while not lstInventarios.NoFim do
    begin
        Result := Result + ifthen(Result <> '', ',' , '') + IntToStr(lstInventarios.davalor('id_inventario').AsInteger);
        lstInventarios.seguinte;
    end;
  end;
  if Assigned(lstInventarios) then
    freeandnil(lstInventarios);
end;



Function Daid_Inventario(pData:TDatetime;var pdatainicioperiodo:Tdatetime):integer;
var
 SQL,sqldata:string;
 mfiltro:string;
 id_Periodo:integer;
 listainv:tsbbetabeladados;
begin
  result:=0;
  id_Periodo:=0;
  pdatainicioperiodo:=0;
  id_Periodo:=Motorfnt.Periodo.PeriodoData(pData);
  If id_Periodo>0 then
  begin
    sqldata:='select datainicio from periodo where id_periodo='+Inttostr(id_Periodo);
    pdatainicioperiodo:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,sqldata).davalor('datainicio').AsDateTime;
    mfiltro:=DevolveIDInventariosExportados;
    if mfiltro<> '' then
       mfiltro:='id_inventario not in('+mfiltro+')';

    SQL :=' select id_inventario from CabInventario '
          +' where Estado=1 and id_Periodo='+Inttostr(id_Periodo);
    If mfiltro<> '' then
             SQL:=SQL+' and '+mfiltro;

   listainv:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,sql);
   If Not(listainv.vazia) then
    result:=listainv.davalor('id_inventario').asinteger;
   listainv.Fecha;
   Freeandnil(listainv);
  end;

end;




Function ExportarInventarios(pListaDocs:TsbbeTabeladados;var pstrMensagemErros:string):Boolean;
var
Strsqlcab,strsqlLinha,
sql,strMensagemErros:string;
mProximoID_InternoDoc,mID_Inventario:integer;
begin
   Result:=false;
   pstrMensagemErros:='';
   pListaDocs.Inicio;
   SBBD.IniciaTransacao;
   try     mID_Inventario:=pListaDocs.davalor('id_inventario').Asinteger;
           mProximoID_InternoDoc:=sb.ProximoID('ERP_CabInventario',true);
           Strsqlcab:='INSERT INTO ERP_CabInventario(Id_interno,ID_Inventario'
           +',Descricao,DataExportacao,DataInicio,DataFim) values(';
           Strsqlcab:=Strsqlcab+inttostr(mProximoID_InternoDoc)
           +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('id_inventario').AsString)
           +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('descricao').AsString)
           +','+sb.UtilSQL.DataToSQLData(date)
           +','+sb.UtilSQL.DataToSQLData(pListaDocs.davalor('DataInicio').AsDateTime)
           +','+sb.UtilSQL.DataToSQLData(pListaDocs.davalor('Datafim').AsDateTime)
           +')';

           sb.sbbd.Executa(Strsqlcab);

           while not pListaDocs.NoFim do
           begin
            strsqlLinha:='INSERT INTO Erp_LinhasInventario(Id_interno,ID_Inventario'
            +',DescricaoProduto,ID_Produto,ContaERP,ID_Unidade,Qtd,PrecoMedioProduto,ValorLinhaSemIVA'
            +',id_armazem, Armazem, ID_ArmazemERP'
            +',ID_GrupoProduto'
            +',GrupoProduto'
            +',ID_FamiliaProduto'
            +',FamiliaProduto'
            +',ID_SubFamiliaProduto'
            +',SubFamiliaProduto'
            +')Values(';
            strsqlLinha:=strsqlLinha+inttostr(mProximoID_InternoDoc)
            +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('id_inventario').AsString)
            +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('DescricaoProduto').AsString)
            +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('ID_Produto').AsString)
            +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('ContaERP').AsString)
            +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('ID_Unidade').AsString)
            +','+sb.UtilSQL.DecimalToSQLStr(pListaDocs.davalor('Qtd').asfloat)
            +','+sb.UtilSQL.DecimalToSQLStr(pListaDocs.davalor('PrecoMedioProduto').asfloat)
            +','+sb.UtilSQL.DecimalToSQLStr(pListaDocs.davalor('ValorLinhaSemIVA').asfloat)

            +','+inttostr(pListaDocs.davalor('id_armazem').Asinteger)
            +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('Armazem').AsString)
            +','+sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('ContaERPARM').AsString)

            +','+ IntToStr(pListaDocs.davalor('ID_GrupoFamilia').Asinteger)
            +','+ sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('GrupoFamilia').AsString)

            +','+ IntToStr(pListaDocs.davalor('ID_Familia').Asinteger)
            +','+ sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('Familia').AsString)

            +','+ IntToStr(pListaDocs.davalor('ID_SubFamilia').Asinteger)
            +','+ sb.UtilSQL.StrToSQLStrpelica(pListaDocs.davalor('SubFamilia').AsString)




            +')';
            sb.sbbd.Executa(strsqlLinha);
            pListaDocs.Seguinte;
           end;

     result:=true;
     sbbd.TerminaTransacao;
     if result=true then
     begin
       sql:='update cabinventario set ExportadoErpInterface=1 where id_inventario='+inttostr(mID_Inventario);
       sb.SBBD.ExecutaSqlExterno(FOBJInterface.BDConexao,sql)
     end;


     except
                 on E:Exception do
                 begin
                   SB.SBBD.DesfazTransacao;
                   pstrMensagemErros:='Erro ao exportar o inventario'+#13+E.Message;

                 end;
                 On E:EErroDetalhe Do
                 Begin
                   SB.SBBD.DesfazTransacao;
                   pstrMensagemErros:='Erro ao exportar o inventario'+#13+E.Detalhe;
                 End
                 else
                 begin
                  if  pstrMensagemErros='' then
                          pstrMensagemErros:='Erro ao exportar o inventario';
                  SB.SBBD.DesfazTransacao;
                end;
     end;
end;




Function TrataExportacaoInventario(pID_Inventario:integer;pagrupadaPorarmazem:boolean):Boolean;
var
Strsqlcab,strsqlLinha,strMensagemErros,DescTipoDoc:string;
ProximoID_InternoDoc:integer;
pListaDocs:Tsbbetabeladados;
Id_inventarioactual:integer;
begin
   Result:=false;
   If pID_Inventario>0 then
   begin
       pListaDocs:=ERPOperInterfacefntCMP.DaListaInventariosPorExportar(inttostr(pID_Inventario),pagrupadaPorarmazem);
       If not(pListaDocs.Vazia) then
       begin
          Result:= ExportarInventarios(pListaDocs,strMensagemErros);
          If Not(Result) then
          begin
              DescTipoDoc:=pListaDocs.davalor('descricao').AsString;
              strMensagemErros:=strMensagemErros+' Inventário nº '+inttostr(pID_Inventario);
              ERPEnvioEmail.EnviaEmailErroExporAuto(4, pID_Inventario,'Exportação Inventarios',DescTipoDoc,'Exportação Interrompida:'+strMensagemErros);
          end;
        end;
    end;
end;

Function ExportarInventariosAutomatico(pagrupadaPorarmazem:boolean):Boolean;
var
Strsqlcab,strsqlLinha,strMensagemErros,DescTipoDoc:string;
ProximoID_InternoDoc:integer;
pListaDocs:Tsbbetabeladados;
Id_inventarioactual,Id_InventarioAnterior:integer;
mdatainicioperiodoatual,mdatainicioperiodoanterior:Tdatetime ;
sql:string;
data:TDateTime;
begin
/// testa para a data atual
   Result:=false;
   Id_inventarioactual:=0;
   mdatainicioperiodoatual:=0;
   data:=  sb.DataSistema;
   Id_inventarioactual:=Daid_Inventario(data,mdatainicioperiodoatual);
   If Id_inventarioactual>0 then
   begin
      Result:=TrataExportacaoInventario(Id_inventarioactual,pagrupadaPorarmazem);
   end;
//como normalmente o inventario só é fecha no mes seguinte
// ou seja janeiro so sera fechado em fevereiro temos de testar tambem o periodo anterior
//logo   a funcao  "Daid_Inventario" devolve a data inicio do periodo,para garantir que trazemos o anterior
// á data inicio do periodo da data de sistema  retiramos um para que a nova data a pesquisar apanhe a data de fiim do anterior
   if mdatainicioperiodoatual>0 then
   begin
     Result:=false;
     Id_InventarioAnterior:=0;
     Id_InventarioAnterior:=Daid_Inventario(mdatainicioperiodoatual-1,mdatainicioperiodoanterior);
     If Id_InventarioAnterior>0 then
     begin
        Result:=TrataExportacaoInventario(Id_InventarioAnterior,pagrupadaPorarmazem);

     end;
   end;

end;



Function DaListaDocumentosEncomendasPorExportar(pFiltro:string;pdataInicio,pdataFim:Tdatetime;pPrefixoSys:string):tsbbetabeladados;
var
  strsql,strsql1,strsql2,mprefixoProdutos:string;
  mensagemerro:string;
  ID_UltCmpcabdocumentoExportado:Integer;
  DescSchema:string;
begin
 result:=nil;
ID_UltCmpcabdocumentoExportado:=0;
If ValidaExportacao(mensagemerro) then
begin
  strsql:=' select  0 as TipoMovimento , 0 as id_movimento,cabencomenda.id_encomenda as ID_Documento,cabencomenda.dataencomenda as data'
  +', ''Enc'' as Tipodoc,cabencomenda.id_encomenda,'
  +' cabencomenda.totalcomiva- cabencomenda.totalsemiva as TotalDociva,cabencomenda.totalcomiva as TotalDocComIVA , '
  +' cabencomenda.totalsemiva as ValorDocSemIVA,'
  +' ''Enc'' as Serie,cabencomenda.totalcomiva as valortotal,cabencomenda.id_fornecedor as id_entidade'
  +', Tab_cliente.vnome+'' '' + Tab_cliente.vapel as NomeCliente,'
  +' Tab_cliente.vcont as contribuinteEntidade,Tab_cliente.vmor1 as MoradaEntidade,'
  +' Tab_cliente.vcpos as CodigoPostalEntidade,'
  +' Tab_cliente.vrua as RuaEntidade, Tab_cliente.vlocalidade as LocalidadeEntidade,'
  +''''' as VersaoChaveRSA,'
  +''''' as Certificado,'''' as Hash, '
  +' Linhaencomenda.ID_Linha,tab_Produto.vdesc1 as DescricaoProduto,linhaencomenda.percentagemIVA,'
  +' 0 as ID_ModoPagamento,linhaencomenda.preco as ValorUnitario, '
  +' linhaencomenda.quantidade,0 as PerDesconto,'
  +'  preco as ValorUnitariosemIVA,'
  +' valoriva,valorsemIva as valorlinhasemiva,valorcomiva as VAlorlinhaComIVA '
  +' ,Tab_Produto.contacbl as ContaCBLProd,'
  +'  tab_Iva.contaCbl as contaCblIVA,Tab_cliente.ContaCBL as ContaCBLCliente'
  +' ,''ENC'' as ContaCBLTDOC,'''' as ContaCBLPAG'
  +', 0 as TipoOperacao,tab_iva.taxexceptionReason as CodIsencao'
  +', Armazem.id_armazem, Armazem.descricao as Armazem, armazem.ContaERP as ID_ArmazemERP'
  +',Linhaencomenda.id_Produto,0 estado'
  +',dbo.QuantidadeStock(dbo.Linhaencomenda.Quantidade, dbo.Linhaencomenda.ID_Produto'
  +', dbo.Linhaencomenda.ID_Unidade)AS QuantidadeConvertida'
  +', ''M'' as TipoArtigoERP,1 as ID_TipoEntidade'
  +', Linhaencomenda.id_Unidade,'
  +' TAB_SubFam.VCodSubFam as ID_SubFamilia,TAB_SubFam.vdesc as SubFamilia,'
  +' TAB_Familia.VCodFam as ID_Familia,TAB_Familia.vdesc as Familia,'
  +' Tab_GrFamiliar.vCodGrFam as ID_GrupoFamilia,Tab_GrFamiliar.vdesc as GrupoFamilia'

  +' ,0 as ID_MovimentoOrigem,0 as ID_LinhaOrigem'
  +' ,0 as ID_TipoMovOrigem'
  +', 0 as guiaorigem,0 as MovGuia'
  +',0 as ID_encomendaOrigem,  0 as ID_linhaencomendaOrigem,cabencomenda.dataencomenda as Datavencimento'
  +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'

  +' From cabencomenda '
 +' inner join linhaencomenda on cabencomenda.id_encomenda=linhaencomenda.id_encomenda'
  +' Left join  tab_cliente  on tab_cliente.vnume'
  +' =cabencomenda.id_fornecedor'

  +' left join  tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'  
  +' left join  TAB_PRODUTO  on TAB_PRODUTO.VPRODUTO =linhaencomenda.ID_Produto'
  +  ' left JOIN TAB_SubFam ON  '
  +  ' TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
  +  ' left JOIN TAB_Familia  ON '
  +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
  +  ' left JOIN Tab_GrFamiliar  ON '
  +  ' TAB_Familia.VCodGrFam= Tab_GrFamiliar.VCodGrFam '
  +' left join  Armazem  on Armazem.id_armazem =linhaencomenda.id_armazem'
  +' left join  tab_iva  on tab_iva.vcodi=linhaencomenda.id_iva'
  +' inner join EstadoEncomenda on EstadoEncomenda.ID_Estado '
  +' =CabEncomenda.ID_Estado'
  +' where ((EstadoEncomenda.Satisfeito=1) or (EstadoEncomenda.enviada=1)) and cabencomenda.CBLExportado=0 ';

  If  pdataInicio>0 then
       strsql:=strsql+' and cabencomenda.dataencomenda>='+sb.UtilSQL.DataToSQLData(pdataInicio);
  If  pdataFim>0 then
       strsql:=strsql+' and cabencomenda.dataencomenda<='+sb.UtilSQL.DataToSQLData(pdataFim);


  If pFiltro<>'' then
      strsql:=strsql+' and '+ pFiltro;

  strsql:=strsql+' order by cabencomenda.id_encomenda,Linhaencomenda.id_Linha';
  Result:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,strsql);
end;
end;

Function ExportarEncautomatico(pListaDocs:TsbbeTabeladados):Boolean;
var
   ObjCabecalhos:TERPBECabecalhos;
   ObjCab:TERPBECab;
   ListaIDSDocs:TstringList;
   i:Integer;

   strdoc,strsql,strMensagemErros:string;

begin
  Result:=false;
  strMensagemErros:='';
  If Not(pListaDocs.Vazia) then
  begin

       pListaDocs.dataset.filtered:=false;
       pListaDocs.inicio;
       ListaIDSDocs:= DalistaIDDocsenc(pListaDocs);
       pListaDocs.inicio;
       ObjCabecalhos:=TERPBECabecalhos.create;
       For i:=0 to ListaIDSDocs.Count-1 do
       begin
          ObjCab:=PreencheOBJDoc(pListaDocs,strtoint(ListaIDSDocs.strings[i]),true);
          ObjCabecalhos.Adiciona(ObjCab);
       end;

       If ObjCabecalhos.num>0 then
       begin
        SBBD.IniciaTransacao;
        try
         For i:=0 to  ObjCabecalhos.Num-1 do
         begin
            If assigned(ObjCabecalhos.Elem[i]) then
            Begin
             strdoc:=' '+ObjCabecalhos.Elem[i].DescTipoMovimento+' | '+
               ObjCabecalhos.Elem[i].NumDocumento+' Data '+DateToStr(ObjCabecalhos.Elem[i].Data);
            end;


           If ValidaExportacaoDocumentoEnc(ObjCabecalhos.Elem[i],strMensagemErros) then
           begin
             try
               GravaDocCMP(ObjCabecalhos.Elem[i])
               except
               raise;
               end;
           end
           else

           begin
             ERPEnvioEmail.EnviaEmail('Exportação Mov-Stocks-Encomendas','Exportação Interrompida! '+strMensagemErros);
             result:=false;
             SBBD.DesfazTransacao;
             EnviaEmailErroExporAuto(3, ObjCabecalhos.Elem[i].ID_encomenda,'Exportação Mov-Stocks-Encomendas',strdoc,strMensagemErros);
             exit;
           end;
         end;

         SBBD.TerminaTransacao;
         result:=true;


        Except

                 on E:Exception do
                 begin

                  Result:=false;
                   SB.SBBD.DesfazTransacao;
                   strMensagemErros:='Erro ao exportar o inventario'+#13+E.Message+' '+ strdoc;
                   ERPEnvioEmail.EnviaEmail('Exportao Mov-Stocks','Exportao Interrompida! '+strMensagemErros);
                 end;
                 On E:EErroDetalhe Do
                 Begin
                   Result:=false;
                   SB.SBBD.DesfazTransacao;
                   strMensagemErros:='Erro ao exportar o inventario'+#13+E.Detalhe+' '+ strdoc;
                   ERPEnvioEmail.EnviaEmail('Exportao Mov-Stocks','Exportao Interrompida! '+strMensagemErros);
                 End
                 else
                 begin
                  Result:=false;
                  if  strMensagemErros='' then
                          strMensagemErros:='Erro ao exportar o inventario';
                  ERPEnvioEmail.EnviaEmail('Exportao Mov-Stocks','Exportao Interrompida! '+strMensagemErros+' '+ strdoc);
                  SB.SBBD.DesfazTransacao;
                end;

        end;
       end;
  end;
end;



Function ExportarEncomendasAutomatico(pdataInicio:Tdatetime):Boolean;
var SysObjInterface:TERPBEEMPRESAINTERFACE;
  ID_TipoMov:integer;
  filtro:string;
  Lista:tsbbetabeladados;
begin
  If FOBJInterface<>nil then
  begin
       If TestaConexaoBDExterna(FOBJInterface.BDConexao) then
       begin
        FExpApenasComprasFechadas:=true;
        Lista:=DaListaDocumentosEncomendasPorExportar(Filtro,FOBJInterface.DATAInicioExportacao,0,FOBJInterface.PrefixoContCblAartigo);
        If Lista<>nil then
        try
          If Not Lista.Vazia then
          begin
           if ExportarEncautomatico(Lista) then
           begin
              MarcaEncomendasComoExportados(FOBJInterface.DATAInicioExportacao,date,lista,'ERPIntegration');
              RegistaLogOperacao('Operação:Exportação Encomendas SYSController');
           end;

          end;
         Finally
          Lista.Fecha;
          FreeAndNil(lista);
         end;
      end
      else
       EnviaEmailErroExporAuto(2, 0,'Exportação Encomendas-Syscontroller','Exportação automática','Não foi possivel Conectar á Base de dados Sycontroller');
   end;
end;


procedure MarcaEncomendasComoExportados(pDataIni,pdatafim:tdatetime;pLista:tsbbetabeladados;pnomeInterface:string);
var
 Nomeinterface,strsql:string;
 id_Interno:integer;
 ListaIDDocs:tstringList;
begin
 ListaIDDocs:=tstringList.create;
 pLista.dataset.filtered:=false;
 Nomeinterface:='ERPIntegration';
//grava cabecalho LOG
 id_Interno:=0;
 id_Interno:=MotorFnt.sb.ProximoID('LogCabCBLExportacao',true);
 strsql:='INSERT INTO [LogCabCBLExportacao]'
         +'  ([ID_Interno]'
         +'  ,[NomeInterface]'
         +' ,[DataExportacao]'
         +'  ,[HoraExportacao]'
         +' ,[ExportadoPor] '
         +'  ,[DataInicio]'
         +' ,[DataFim]  '
         +' ,[NomeFicheiro])'
         +'     VALUES '
         +'   ('
         + Inttostr(id_interno)
         +','+sb.UtilSQL.StrToSQLStrpelica(Nomeinterface)
         +','+sb.UtilSQL.DataToSQLData(sb.DataSistema)
         +','+sb.UtilSQL.DateTimeToSQLDataHora(time)
         +','+sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
         +','+sb.UtilSQL.DataToSQLData(pDataIni)
         +','+sb.UtilSQL.DataToSQLData(pdatafim)
         +','+sb.UtilSQL.StrToSQLStrpelica('Encomendas')
         +')';
  sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);



 //atencão na lista de compras o campo id_movimento está com "alias" id_VndCabdocumento
 pLista.inicio;
 While not (pLista.nofim) do
 begin
      If ListaIDDocs.indexof(pLista.davalor('id_encomenda').asstring)=-1 then
      Begin
              strsql:='INSERT INTO [LogLinhaCBLExportacao]'
                  +' ([ID_Interno]'
                  +'  ,[ID_InternoDoc]'
                  +'  ,[EstadoDoc]'
                  +'  ,DescricaoDoc '
                  +' ,ID_DocumentoExterno'
                   +', NomeEntidade'
                   +',DataDoc '
                  +' ,[Compra])'
                  +'      VALUES'
                  +' ('
                  + Inttostr(id_interno)
                  +','+Inttostr(pLista.davalor('id_encomenda').asinteger)
                  +','+Inttostr(pLista.davalor('Estado').asinteger)
                  +','+sb.UtilSQL.StrToSQLStrpelica(pLista.davalor('TipoDoc').asstring)
                  +','+sb.UtilSQL.StrToSQLStrpelica(pLista.davalor('ID_Documento').asstring)
                  +','+sb.UtilSQL.StrToSQLStrpelica(pLista.davalor('NomeCliente').asstring)
                  +','+sb.UtilSQL.DataToSQLData(pLista.davalor('data').asdatetime)
                  +',1)';

          sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);

          strsql:='update cabencomenda set CBLExportado=1'
          +',    ID_LogCabCBLExportacao='+Inttostr(id_interno)
          +',  CBLExportadopor='+sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
          +',  CBLExportadoDTHora='+sb.UtilSQL.DateTimeToSQLDataHora(sb.DataSistema)
          +' Where id_encomenda='+Inttostr(pLista.davalor('id_encomenda').asinteger);
          sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);
          ListaIDDocs.Add(pLista.davalor('id_encomenda').asstring)
      end;
   pLista.seguinte;
 end;

 Freeandnil(ListaIDDocs);
end;


Function ExportarEncomendas(pListaDocs:TsbbeTabeladados):Boolean;
var
   ObjCabecalhos:TERPBECabecalhos;
   ObjCab:TERPBECab;
   ListaIDSDocs:TstringList;
   i:Integer;

   strsql,strMensagemErros:string;

begin
 Result:=false;
  strMensagemErros:='';
  If  Not(ValidaExportacao(strMensagemErros)) then
    sb.Dialogos.SBMessage(strMensagemErros)
  else
  If Not(pListaDocs.Vazia) then
  begin


       pListaDocs.dataset.filtered:=false;
       pListaDocs.inicio;
       ListaIDSDocs:= DalistaIDDocsenc(pListaDocs);
       pListaDocs.inicio;
       ObjCabecalhos:=TERPBECabecalhos.create;
       For i:=0 to ListaIDSDocs.Count-1 do
       begin
          ObjCab:=PreencheOBJDoc(pListaDocs,strtoint(ListaIDSDocs.strings[i]),true);
          ObjCabecalhos.Adiciona(ObjCab);
       end;

       If ObjCabecalhos.num>0 then
       begin
        SBBD.IniciaTransacao;
        try
         For i:=0 to  ObjCabecalhos.Num-1 do
         begin
           If ValidaExportacaoDocumentoENC(ObjCabecalhos.Elem[i],strMensagemErros) then
               GravaDocCMP(ObjCabecalhos.Elem[i])
           else
           Raise
               SB.ErroNormal(0,'Exportação de Encomendas Interrompida','Grava Documento',strMensagemErros);
         end;

         SBBD.TerminaTransacao;
         result:=true;

        Except
              SBBD.DesfazTransacao;
              Result:=false;
              if assigned(ObjCabecalhos) then
               freeandnil(ObjCabecalhos);
              raise;
        end;
       end;
  end;
end;

end.
