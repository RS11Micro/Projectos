
unit ERPOperInterfaceProtel;


interface
uses  sbbetabeladados,classes,ERPBECab,ERPBELinhadetalhe,
ERPBELinhaPagamento,ERPBEEMPRESAINTERFACE,
ADODB,ERPEnvioEmail,SBBEExcepcoes,Forms,dialogs;

Function DaSqlAdiantamentos(pDataIniExpAdiantamentos:Tdatetime;DescSchema,pfiltro:string):string;

Function DaListaDocumentosPorExportar(pFiltroGeral:string;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pID_Documento:string=''):tsbbetabeladados;
Function DaListaDocumentosPorExportarNova(pFiltroGeral:string;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pID_Documento:string=''):tsbbetabeladados;
Function DaListaDocumentosPorExportarNova1(pFiltroGeral:string;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pID_Documento:string=''):tsbbetabeladados;
Function TemExportacoes(var mensagem:string):Boolean;
Function ExportarVendas(pListaDocs:TsbbeTabeladados;pids_Hoteis:string):Boolean;

Function ExportarAutomatica():Boolean;
Function TestaConexaoBDExterna(pConexao:string):boolean;
Procedure ExportaAdiantamentos(pDataIniExpAdiantamentos:Tdatetime;DescSchema,pfiltro:string);
var
    FID_cLienteIndiferenciado:string;
    FOBJInterface:TERPBEEMPRESAINTERFACE;
    FOBJInterfaceSys:TERPBEEMPRESAINTERFACE;

implementation
uses ierpOglobais,math,SysUtils,strutils, SBBaseDados, SBBSSistemaBase,
  FntBSVndDocumento, SBBSUtilSQL,fntbeapoio,ERPLogOperacoes,IERPFrmPrincipal;

var
 FCONNECTIONSTRING:string;
 FConexao:TADOConnection;

 FQuery :TadoQuery;
 listContasSaco,FListaContasMercado:Tsbbetabeladados;


Function DaMercado(pID_Pais:integer;var pdescricao:string):integer;
begin
  Result:=1;
  pdescricao:='Nacional';
  if FListaContasMercado<>nil then
  If FListaContasMercado.dataset.locate('ID_Pais',pID_Pais,[]) then
  begin
   Result:=FListaContasMercado.dataset.fieldbyname('id_mercado').asinteger;
   pdescricao:=FListaContasMercado.dataset.fieldbyname('Descmercado').asstring;
  end;
end;

procedure atualizaContacblProdutosProtel;
var strsql:string;
  ProtelObjInterface,
  SysObjInterface:TERPBEEMPRESAINTERFACE;
  DescSchemaPms,
  DescSchemaSys:string;
begin
  ProtelObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
  SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');


  DescSchemaPms:=ProtelObjInterface.BDSchema;
  If    ProtelObjInterface.Namelinkedserver<>'' then
    DescSchemaPms:= ProtelObjInterface.Namelinkedserver+'.'+DescSchemaPms;

  DescSchemaSys:= SysObjInterface.BDSchema;
  If    SysObjInterface.Namelinkedserver<>'' then
    DescSchemaSys:= SysObjInterface.Namelinkedserver+'.'+DescSchemaSys;

  strsql :='update artpms set artpms.gvkonto=artsys.ContaCbl  '
  +' from '+DescSchemaPms+'ArticlesPMSSYS as artpms inner join '+DescSchemaSys+'TAB_PRODUTO as artsys'
  +' on  artpms.Id_ProdutoSYS=artsys.vproduto ';
  sb.sbbd.Executa(strsql);

  if assigned(ProtelObjInterface) then
   FreeAndNil(ProtelObjInterface);
  if assigned(SysObjInterface) then
   FreeAndNil(SysObjInterface);
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
  result:=true;
  If assigned(FOBJInterface) then
  begin
     result:=true;

     FID_cLienteIndiferenciado:= FOBJInterface.ID_clienteIndiferenciado;
     If FOBJInterface.BDConexao='' then
     begin
       Mensagem:='Falta configurar a Base de Dados HOTEL';
       Result:=false;
     end
     else
     begin
        If not(TestaConexaoBDExterna(FOBJInterface.BDConexao)) then
        begin
           Mensagem:='Não é possivel conectar com a  Base de Dados do Hotel';
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
       Mensagem:='Não existe interface: "ERP_VENDASPROTEL" Ativo!';
  end;
end;


Function TemExportacoes(var mensagem:string):Boolean;
var
   Listaex:Tsbbetabeladados;
begin
 mensagem:='';
 result:=false;
 Listaex:=sb.sbbd.abrirlv('select Top 1 id_vndcabdocumento as id_vndcabdocumento from ERP_Cab where origem=1');
 Result:=not (Listaex.vazia);
 Listaex.fecha;
 Freeandnil(Listaex);
end;


Function DAultimoIDVendaExportado():integer;
var Listadad:tsbbetabeladados;
begin
 result:=0;
 Listadad:=sb.sbbd.abrirlv('select Max(id_vndcabdocumento) as id_vndcabdocumento from ERP_Cab  where origem=1');
 If Not(Listadad.vazia) then
 begin
      Result:=Listadad.davalor('id_vndcabdocumento').asinteger;

 end;
 Listadad.fecha;
 Freeandnil(Listadad);

end;



Function DaultimoID_RefExportadoadiantamentos():integer;
var
Listaad:tsbbetabeladados;
begin
 result:=0;
 Listaad:=sb.sbbd.abrirlv('select max(isnull(ref,0)) as ref from ERP_Adiantamentos');
 If Not(Listaad.vazia) then
 begin
      Result:=Listaad.davalor('ref').asinteger;
 end;
 Listaad.fecha;
 Freeandnil(Listaad);
end;


Function DaSqlAdiantamentos(pDataIniExpAdiantamentos:Tdatetime;DescSchema,pfiltro:string):string;
var  UltRefExportado:integer;
begin
UltRefExportado:=  DaultimoID_RefExportadoadiantamentos;

 result:='';
 Result:='   Select'
       +'    leisthis.ref as Ref,'
       +'   leisthis.mpehotel as Mpehotel,'
       +'    leisthis.datum as Data,'
       +'   leisthis.uhrzeit as Hora,'
       +'    leisthis.buchref as Reserva,'
       +'    leisthis.kundennr as IDCliente,'
       +'    leisthis.gast as Nome,'
       +'    leisthis.rkz as ID_ModoPagamento,'
       +'   leisthis.text as Descricao,'
       +'    leisthis.epreis as Valor, Z.fibukto'
       +'   from '+DescSchema+'leisthis '
       +'   inner join '+DescSchema+'kunden on kunden.kdnr='+DescSchema+'leisthis.kundennr'
       + '    inner join '+DescSchema+'zahlart as Z on Z.zanr='+DescSchema+'leisthis.Rkz'
       +'   where leisthis.rkz>0 and leisthis.rechnr=-1 and leisthis.fisccode=0 and leisthis.ref>'+Inttostr(UltRefExportado)
       +' and  '+pfiltro;

        If  pDataIniExpAdiantamentos>0 then
        begin
             Result:=Result+' and leisthis.datum>='+sb.UtilSQL.DataToSQLData(pDataIniExpAdiantamentos)
             +' and  leisthis.datum<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
        end;
    Result:=Result+'  order by Data,Hora ';

end;

Procedure ExportaAdiantamentos(pDataIniExpAdiantamentos:Tdatetime;DescSchema,pfiltro:string);
var
  strsql:string;
  UltRefExportado:integer;
begin
UltRefExportado:=  DaultimoID_RefExportadoadiantamentos;
strsql:=' INSERT INTO [ERP_Adiantamentos]'
       +'    ([Ref]'
       +'   ,[Mpehotel]'
       +'    ,[Data] '
       +'    ,[Hora]'
       +'    ,[Reserva]'
       +'   ,[IDCliente]'
       +'   ,[Nome]'
       +'   ,[ID_ModoPagamento]'
       +'   ,[Descricao]'
       +'   ,[Valor]'
       +'   ,[contaerp])'
       +'   Select'
       +'    leisthis.ref as Ref,'
       +'   leisthis.mpehotel as Mpehotel,'
       +'    leisthis.datum as Data,'
       +'   leisthis.uhrzeit as Hora,'
       +'    leisthis.buchref as Reserva,'
       +'    leisthis.kundennr as IDCliente,'
       +'    leisthis.gast as Nome,'
       +'    leisthis.rkz as ID_ModoPagamento,'
       +'   leisthis.text as Descricao,'
       +'    leisthis.epreis as Valor, Z.fibukto'
       +'   from '+DescSchema+'leisthis '
       +'   inner join '+DescSchema+'kunden on kunden.kdnr='+DescSchema+'leisthis.kundennr'
       + '    inner join '+DescSchema+'zahlart as Z on Z.zanr='+DescSchema+'leisthis.Rkz'
       +'   where leisthis.rkz>0 and leisthis.rechnr=-1 and leisthis.fisccode=0 and leisthis.ref>'+Inttostr(UltRefExportado)
       +' and  '+pfiltro;

        If  pDataIniExpAdiantamentos>0 then
        begin
             strsql:=strsql+' and leisthis.datum>='+sb.UtilSQL.DataToSQLData(pDataIniExpAdiantamentos)
             +' and  leisthis.datum<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
        end;
  strsql:=strsql+'  order by Data,Hora ';
  sb.SBBD.Executa(strsql);
end;


{
Function DaListaDocumentosPorExportar(pFiltro:string;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pFiltraDoc:boolean=false):tsbbetabeladados;
var
  StrFiltroRechist, strsql,strsql1,strsql2:string;
  mensagemerro:string;
  ID_UltVndcabdocumentoExportado:Integer;
  DescSchema:string;
  txtFileR: TextFile;
  caminho:string;
  FiltraIntervaloDatasManual:boolean;
begin
 result:=nil;
 ID_UltVndcabdocumentoExportado:=0;
 DescSchema:=FOBJInterface.BDSchema;

 if pdatafim=0 then
 begin
   pdatafim:=sb.DataSistema;
   FiltraIntervaloDatasManual:=false;
 end
 else
   FiltraIntervaloDatasManual:=true;


 ID_UltVndcabdocumentoExportado:=DAultimoIDVendaExportado;
 If ValidaExportacao(mensagemerro) then
 begin
  If ID_UltVndcabdocumentoExportado>0 then
  Begin
     If FiltraIntervaloDatasManual then
     begin
     end;


     if pFiltraDoc=false then
     begin
         StrFiltroRechist:=StrFiltroRechist+' and  r.Ref>'+Inttostr(ID_UltVndcabdocumentoExportado)
         +' and  r.datum<'+sb.UtilSQL.DataToSQLData(pdatafim);
     end
     else
     begin
         StrFiltroRechist:=StrFiltroRechist+' and r.datum>='+sb.UtilSQL.DataToSQLData(pdata)
         +' and  r.datum<'+sb.UtilSQL.DataToSQLData(pdatafim);
     end;
  End
  Else
  If  pdata>0 then
  begin
       StrFiltroRechist:=StrFiltroRechist+' and r.datum>='+sb.UtilSQL.DataToSQLData(pdata)
       +' and  r.datum<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
  end;





  strsql:='select * '
        + ' from ( '
        + ' select distinct R.Ref as ID_Interno, 1 as TipoLinha '
        + ' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        + ' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        + ' ,status = case r.void When 0 then ''N'''
        + '          When 2 then  ''N'''
        + '          When 1 then  ''A'''

        + '          end,sig,'
        + ' ''482'' as Versao,k.vorname+'' ''+k.name1 as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        + ' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        + ' 0 as troco,'

        + '  '''' as ContaCblprod,'''' as Descritivo,0 as Quant,0 as VAlorUnit,'
        + '   '''' as ContaCBLIVA,''0'' as taxaiva,0 as VAlor,''1'' as Armazem,'
        + '    '''' as CCusto,'''' as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        + '    '''' as ContaCBLPAg,''''  as DescricaoPagamento,0 as ID_ModoPagamento,0 as valoriva,F.Code'
        +',  '''' as TipoArtigoERP '
        +', ''UN'' as CodUnvenda  '
        +',''UN'' as UniVenda '
        +', ''UN'' as CodUnBase  '
        +', ''UN'' as  UniBase '
        +',''1'' as factorconversao    '
        +', '''' as  AreaNegocio, '''' as DescAreaNegocio'
        +',''0'' as ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',''0'' as ID_Familia,'''' as  Familia'
        +',''0'' as ID_SubFamilia,'''' as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,0 as RefL,r.datum as datamovimento '

        + ' FROM '+DescSchema+'rechhist R'
        + '     inner join  '+DescSchema+'leisthis L'
        + '      on L.fisccode=R.fisccode'
        + '      and L.rechnr=R.rechnr'
        + '      left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref'
        + '      left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr'
        + '      left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        + '      left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref'
        +'        left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        + '     WHERE R.fisccode <> 0 and S.ERPexporta =''S'''+ StrFiltroRechist;
   strsql1:=
         ' select distinct  R.Ref as ID_Interno, 2 as TipoLinha'
        + ' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        + ' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        + ' ,status = case r.void When 0 then ''N'''
        + '          When 2 then  ''N'''
        + '          When 1 then  ''A'''

        + '          end,sig,'
        + ' ''482'' as Versao,k.vorname+'' ''+k.name1   as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        + ' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        + ' 0 as troco,'

        + ' case when l.article<=0 then  '
        + 'cast (U.Gvkonto as varchar(100)) collate Latin1_General_CI_AS '

        + ' else '
        + ' case when Id_produtosys> 0 then '

        + ' cast (ArtSys.ContaCbl as varchar(100)) collate Latin1_General_CI_AS '
//        + '  ArtSys.ContaPms '
        + ' else '
        +' cast (ArticlesPMSSYS.Gvkonto  as varchar(100)) collate Latin1_General_CI_AS '
//        +'  art.Gvkonto '
        + ' end end  as ContaCblprod '

        +', case when l.article<=0 then  U.bez else art.text end as Descritivo '
        +', L.anzahl as Quant,L.epreis as VAlorUnit,'
        + ' M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        + ' u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        + ' '''' as ContaCBLPAg,'' ''  as DescricaoPagamento ,0 as ID_ModoPagamento,'
       +' ( l.epreis* L.anzahl)/(100+L.mwstsatz)*L.mwstsatz as valoriva,F.Code'
       +', U.kst1 as TipoArtigoERP,'

       +' Case  when ArtSys.vproduto  is null then  '
       +'''UN'' else CodUnvenda end as CodUnvenda, '


       +' Case  when ArtSys.vproduto  is null then'
       +' ''UN'' else UniVenda end as UniVenda,'

       +' Case  when ArtSys.vproduto  is null then'
       +' ''UN'' else CodUnBase end as CodUnBase,'

       +' Case  when ArtSys.vproduto  is null then'
       +' ''UN'' else UniBase end as UniBase,'

       +' Case  when ArtSys.vproduto  is null then'
       +' ''1'' else factorconversao end as factorconversao'
       +',ERP_AreaNegocio.ContaERP as AreaNegocio'
       +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'



       +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
       +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
       +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'

        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,l.ref as RefL,l.datum as datamovimento '
       + ' from '+DescSchema+'leisthis L  '
        + ' Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode '
        + ' and L.rechnr=R.rechnr  '
        + ' left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref  '
        + ' left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref '
        + ' left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr '
        + ' left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        + ' left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        + ' left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
        + ' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'



        + ' left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        + ' left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        + ' left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        + ' left join '+DescSchema+'Articles as Art on l.article=Art.ref '
        + ' left join '+DescSchema+'ArticlesPMSSYS as ArticlesPMSSYS on ArticlesPMSSYS.ref=Art.ref '
        + ' left join '+pShemaSys+'tab_produto as ArtSys on ArticlesPMSSYS.Id_ProdutoSYS=ArtSys.vproduto '
        + ' left join '+pShemaSys+'  V_ERPInterfaceProdUnidade  on V_ERPInterfaceProdUnidade.ID_Produto=ArtSys.vproduto'


          +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS '
          +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'
          +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
          +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'




        + '  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz=0 '+StrFiltroRechist;


       strsql2:=
         ' select R.Ref as ID_Interno, 3 as TipoLinha'
        + ' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr as ID_entidade, '
        + ' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        + ' ,status = case r.void When 0 then ''N'''
        + '          When 2 then  ''N'''
        + '          When 1 then  ''A'''

        + '          end,sig,'
        + ' ''482'' as Versao,k.vorname+'' ''+k.name1  as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        + ' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        + ' 0 as troco,'

        + '  U.Gvkonto as ContaCblprod,U.bez as Descritivo,L.anzahl as Quant,L.epreis as VAlorUnit,'
        + '     M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        + '     u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor,'
        + '     Z.fibukto as ContaCBLPAg,Z.bez  as DescricaoPagamento,Z.zanr as ID_ModoPagamento, 0 as Valoriva,F.Code'
        +', U.kst1 as TipoArtigoERP'
        +', ''UN'' as CodUnvenda  '
        +',''UN'' as UniVenda '
        +', ''UN'' as CodUnBase  '
        +', ''UN'' as  UniBase '
        +',''1'' as factorconversao    '
       +',ERP_AreaNegocio.ContaERP as AreaNegocio'
       +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'

       +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
       +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
       +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'

       +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais ,l.ref as RefL ,l.datum as datamovimento '
        + '     from '+DescSchema+'leisthis L'
        + '     Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode'
        + '     and L.rechnr=R.rechnr'
        + '          left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref'
        + ' 	left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref'
        + '      left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr'
        + '      left join '+DescSchema+'natcode N on k.landkz=N.Codenr'

        + '      left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'


        + '    left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
        + ' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'
        + '    left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        + '    left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        + '    left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        + '    inner join '+DescSchema+'zahlart as Z on Z.zanr=L.Rkz'



          +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS '
          +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'
          +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
          +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'

        + '  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz>0 '+StrFiltroRechist

        + '  )as x' ;
   strsql:=strsql+' Union ALL '+ strsql1+' Union All '+  strsql2;

  strsql:=strsql+ '    where   isnull(x.serie,'' '')<>'+sb.UtilSQL.StrToSQLStrpelica('');

  If pFiltraDoc then
  begin
      If  pdata>0 then
     begin
           strsql:=strsql+' and x.data>='+sb.UtilSQL.DataToSQLData(pdata)
           +' and  x.data<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
      end;
  end
  else
  begin
      If ID_UltVndcabdocumentoExportado>0 then
      Begin
       strsql:=strsql+' and  x.ID_Interno>'+Inttostr(ID_UltVndcabdocumentoExportado)
       +' and  x.data<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
      End
      Else
      If  pdata>0 then
      begin
           strsql:=strsql+' and x.data>='+sb.UtilSQL.DataToSQLData(pdata)
           +' and  x.data<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
      end;
  end;

  If pFiltro<>'' then
      strsql:=strsql+' and '+ pFiltro;

  strsql:=strsql+ '  order by id_interno,tipolinha';

  Result:=sb.SBBD.AbrirLV(strsql);


  try
      caminho:=ExtractFilePath(Application.ExeName);
      AssignFile(txtFileR,caminho+'sqlDocspms.TXT');
      Rewrite(txtFileR);
      Writeln(txtFileR,strsql);
      CloseFile(txtFileR)
   except
   end;
 end;
end;}





Function DafiltroCabecalhoRechist(pID_UltVndcabdocumentoExportado:integer;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pID_Documento:string=''):string;
var
  FiltroManual :boolean;
begin
 result:='';
 FiltroManual:=false;
 If (((pdata >0) and (pdatafim>0)) or  (pID_Documento<>''))then
 begin
    FiltroManual:=true;
 end;

 If   FiltroManual then
 begin
    Result:=Result+' and  r.datum>='+sb.UtilSQL.DataToSQLData(pdata);
    Result:=Result+' and  r.datum<='+sb.UtilSQL.DataToSQLData(pdatafim);
    If  pID_Documento<>'' then
    begin
        Result:=Result+' and  r.rechnr in('+pID_Documento+')';
    end
 end
 Else
 begin
     If (pID_UltVndcabdocumentoExportado>0) then
     begin
             Result:=Result+' and  r.ref>'+Inttostr(pID_UltVndcabdocumentoExportado)
            +' and  r.datum<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
     end
     else
     begin
          Result:=Result+' and  r.datum>='+sb.UtilSQL.DataToSQLData(pdata)
         +' and  r.datum<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
     end;
  end;
  If FOBJInterface.IDSHoteis<>'' then
     Result:=Result+ ' and r.mpehotel IN('+FOBJInterface.IDSHoteis+')';
end;



Function DafiltroGeral(pfiltro:string;pID_UltVndcabdocumentoExportado:integer;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pID_Documento:string=''):string;
var
  FiltroManual :boolean;
begin
 result:='';
 FiltroManual:=false;
 If (((pdata >0) and (pdatafim>0)) or  (pID_Documento<>''))then
 begin
    FiltroManual:=true;
 end;


 If (((pdata >0) and (pdatafim>0)) or  (pID_Documento<>''))then
 begin
    FiltroManual:=true;
 end;
 If   FiltroManual then
 begin
    Result:=Result+' and  x.data>='+sb.UtilSQL.DataToSQLData(pdata);
    Result:=Result+' and  x.data<='+sb.UtilSQL.DataToSQLData(pdatafim);
    If  pID_Documento<>'' then
    begin
        Result:=Result+' and x.Id_documento in('+pID_Documento+')';
    end
 end
 Else
 begin
     If (pID_UltVndcabdocumentoExportado>0) then
     begin
             Result:=Result+' and  x.ID_Interno>'+Inttostr(pID_UltVndcabdocumentoExportado)
            +' and  x.data<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
     end
     else
     begin
          Result:=Result+' and  x.data>='+sb.UtilSQL.DataToSQLData(pdata)
         +' and  x.data<'+sb.UtilSQL.DataToSQLData(sb.DataSistema);
     end;
  end;
  If  FOBJInterface.IDSHoteis<>'' then
     Result:=Result+ ' and x.mpehotel IN('+FOBJInterface.IDSHoteis+')';

end;
Function DaListaDocumentosPorExportar(pFiltroGeral:string;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pID_Documento:string=''):tsbbetabeladados;
var
   StrFiltroRechist,strFiltroGeral,
   strsql,strsql1,strsql2:string;
  mensagemerro:string;
  ID_UltVndcabdocumentoExportado:Integer;
  DescSchema:string;
  txtFileR: TextFile;
  caminho:string;
  FiltraIntervaloDatasManual:boolean;
begin
 result:=nil;
 ID_UltVndcabdocumentoExportado:=0;
 DescSchema:=FOBJInterface.BDSchema;
 If   FOBJInterface.Namelinkedserver<>'' then
 begin
  DescSchema:= FOBJInterface.Namelinkedserver+'.'+  DescSchema;
 end;
 ID_UltVndcabdocumentoExportado:=DAultimoIDVendaExportado;
 If ValidaExportacao(mensagemerro) then
 begin

  StrFiltroRechist:=DafiltroCabecalhoRechist(ID_UltVndcabdocumentoExportado,pdata,pdatafim,pPrefixoProtel,pShemaSys,pID_Documento);
  strFiltroGeral:= DafiltroGeral(pFiltroGeral,ID_UltVndcabdocumentoExportado,pdata,pdatafim,pPrefixoProtel,pShemaSys,pID_Documento);

  strsql:='select * '
        + ' from ( '
        + ' select distinct R.Ref as ID_Interno, 1 as TipoLinha '
        + ' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        + ' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        + ' ,status = case r.void When 0 then ''N'''
        + '          When 2 then  ''N'''
        + '          When 1 then  ''A'''

        + '          end,sig,'
        + ' ''482'' as Versao,k.vorname+'' ''+k.name1 as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        + ' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        + ' 0 as troco,'

        + '  '''' as ContaCblprod,'''' as Descritivo,0 as Quant,0 as VAlorUnit,'
        + '   '''' as ContaCBLIVA,''0'' as taxaiva,0 as VAlor,''1'' as Armazem,'
        + '    '''' as CCusto,'''' as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        + '    '''' as ContaCBLPAg,''''  as DescricaoPagamento,0 as ID_ModoPagamento,0 as valoriva,F.Code'
        +',  '''' as TipoArtigoERP '
        +', ''UN'' as CodUnvenda  '
        +',''UN'' as UniVenda '
        +', ''UN'' as CodUnBase  '
        +', ''UN'' as  UniBase '
        +',''1'' as factorconversao    '
        +', '''' as  AreaNegocio, '''' as DescAreaNegocio'
        +',''0'' as ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',''0'' as ID_Familia,'''' as  Familia'
        +',''0'' as ID_SubFamilia,'''' as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,0 as RefL,r.datum as datamovimento '

        + ' FROM '+DescSchema+'rechhist R'
        + '     inner join  '+DescSchema+'leisthis L'
        + '      on L.fisccode=R.fisccode'
        + '      and L.rechnr=R.rechnr'
        + '      left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref'
        + '      left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr'
        + '      left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        + '      left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref'
        +'        left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        + '     WHERE R.fisccode <> 0 and S.ERPexporta =''S'''+ StrFiltroRechist;
   strsql1:=
         ' select distinct  R.Ref as ID_Interno, 2 as TipoLinha'
        + ' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        + ' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        + ' ,status = case r.void When 0 then ''N'''
        + '          When 2 then  ''N'''
        + '          When 1 then  ''A'''

        + '          end,sig,'
        + ' ''482'' as Versao,k.vorname+'' ''+k.name1   as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        + ' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        + ' 0 as troco,'

        + ' case when l.article<=0 then  '
        + 'cast (U.Gvkonto as varchar(100)) collate Latin1_General_CI_AS '

        + ' else '
        + ' case when Id_produtosys> 0 then '

        + ' cast (ArtSys.ContaCbl as varchar(100)) collate Latin1_General_CI_AS '
//        + '  ArtSys.ContaPms '
        + ' else '
        +' cast (ArticlesPMSSYS.Gvkonto  as varchar(100)) collate Latin1_General_CI_AS '
//        +'  art.Gvkonto '
        + ' end end  as ContaCblprod '

        +', case when l.article<=0 then  U.bez else art.text end as Descritivo '
        +', L.anzahl as Quant,L.epreis as VAlorUnit,'
        + ' M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        + ' u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        + ' '''' as ContaCBLPAg,'' ''  as DescricaoPagamento ,0 as ID_ModoPagamento,'
       +' ( l.epreis* L.anzahl)/(100+L.mwstsatz)*L.mwstsatz as valoriva,F.Code'
       +', U.kst1 as TipoArtigoERP,'

       +' Case  when ArtSys.vproduto  is null then  '
       +'''UN'' else CodUnvenda end as CodUnvenda, '


       +' Case  when ArtSys.vproduto  is null then'
       +' ''UN'' else UniVenda end as UniVenda,'

       +' Case  when ArtSys.vproduto  is null then'
       +' ''UN'' else CodUnBase end as CodUnBase,'

       +' Case  when ArtSys.vproduto  is null then'
       +' ''UN'' else UniBase end as UniBase,'

       +' Case  when ArtSys.vproduto  is null then'
       +' ''1'' else factorconversao end as factorconversao'
       +',ERP_AreaNegocio.ContaERP as AreaNegocio'
       +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'



       +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
       +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
       +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'

        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,l.ref as RefL,l.datum as datamovimento '
       + ' from '+DescSchema+'leisthis L  '
        + ' Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode '
        + ' and L.rechnr=R.rechnr  '
        + ' left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref  '
        + ' left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref '
        + ' left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr '
        + ' left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        + ' left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        + ' left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
        + ' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'



        + ' left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        + ' left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        + ' left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        + ' left join '+DescSchema+'Articles as Art on l.article=Art.ref '
        + ' left join '+DescSchema+'ArticlesPMSSYS as ArticlesPMSSYS on ArticlesPMSSYS.ref=Art.ref '
        + ' left join '+pShemaSys+'tab_produto as ArtSys on ArticlesPMSSYS.Id_ProdutoSYS=ArtSys.vproduto '
        + ' left join '+pShemaSys+'  V_ERPInterfaceProdUnidade  on V_ERPInterfaceProdUnidade.ID_Produto=ArtSys.vproduto'


          +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS '
          +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'
          +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
          +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'




        + '  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz=0 '+StrFiltroRechist;


       strsql2:=
         ' select R.Ref as ID_Interno, 3 as TipoLinha'
        + ' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr as ID_entidade, '
        + ' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        + ' ,status = case r.void When 0 then ''N'''
        + '          When 2 then  ''N'''
        + '          When 1 then  ''A'''

        + '          end,sig,'
        + ' ''482'' as Versao,k.vorname+'' ''+k.name1  as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        + ' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        + ' 0 as troco,'

        + '  U.Gvkonto as ContaCblprod,U.bez as Descritivo,L.anzahl as Quant,L.epreis as VAlorUnit,'
        + '     M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        + '     u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor,'
        + '     Z.fibukto as ContaCBLPAg,Z.bez  as DescricaoPagamento,Z.zanr as ID_ModoPagamento, 0 as Valoriva,F.Code'
        +', U.kst1 as TipoArtigoERP'
        +', ''UN'' as CodUnvenda  '
        +',''UN'' as UniVenda '
        +', ''UN'' as CodUnBase  '
        +', ''UN'' as  UniBase '
        +',''1'' as factorconversao    '
       +',ERP_AreaNegocio.ContaERP as AreaNegocio'
       +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'

       +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
       +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
       +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'

       +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais ,l.ref as RefL ,l.datum as datamovimento '
        + '     from '+DescSchema+'leisthis L'
        + '     Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode'
        + '     and L.rechnr=R.rechnr'
        + '          left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref'
        + ' 	left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref'
        + '      left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr'
        + '      left join '+DescSchema+'natcode N on k.landkz=N.Codenr'

        + '      left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'


        + '    left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
        + ' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'
        + '    left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        + '    left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        + '    left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        + '    inner join '+DescSchema+'zahlart as Z on Z.zanr=L.Rkz'



          +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS '
          +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'
          +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
          +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'

        + '  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz>0 '+StrFiltroRechist

        + '  )as x' ;
   strsql:=strsql+' Union ALL '+ strsql1+' Union All '+  strsql2;

   strsql:=strsql+ '    where   isnull(x.serie,'' '')<>'+sb.UtilSQL.StrToSQLStrpelica('');


   strsql:=strsql+'  '+ strFiltroGeral;

   strsql:=strsql+ '  order by id_interno,tipolinha';

   Result:=sb.SBBD.AbrirLV(strsql);


  try
      caminho:=ExtractFilePath(Application.ExeName);
      AssignFile(txtFileR,caminho+'sqlDocspms.TXT');
      Rewrite(txtFileR);
      Writeln(txtFileR,strsql);
      CloseFile(txtFileR)
   except
   end;
 end;
end;

Function DaListaDocumentosPorExportarNova1(pFiltroGeral:string;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pID_Documento:string=''):tsbbetabeladados;
var
   StrFiltroRechist,strFiltroGeral,
   strsql,strsql1,strsql1_1,strsql2:string;
  mensagemerro:string;
  ID_UltVndcabdocumentoExportado:Integer;
  DescSchema:string;
  txtFileR: TextFile;
  caminho:string;
  FiltraIntervaloDatasManual:boolean;
begin
 result:=nil;
 ID_UltVndcabdocumentoExportado:=0;
 DescSchema:=FOBJInterface.BDSchema;
 If   FOBJInterface.Namelinkedserver<>'' then
 begin
  DescSchema:= FOBJInterface.Namelinkedserver+'.'+  DescSchema;
 end;
 ID_UltVndcabdocumentoExportado:=DAultimoIDVendaExportado;
 If ValidaExportacao(mensagemerro) then
 begin

  StrFiltroRechist:=DafiltroCabecalhoRechist(ID_UltVndcabdocumentoExportado,pdata,pdatafim,pPrefixoProtel,pShemaSys,pID_Documento);
  strFiltroGeral:= DafiltroGeral(pFiltroGeral,ID_UltVndcabdocumentoExportado,pdata,pdatafim,pPrefixoProtel,pShemaSys,pID_Documento);

  strsql:='select * '
        + ' from ( '
        + ' select distinct R.Ref as ID_Interno, 1 as TipoLinha '
        + ' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        + ' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        + ' ,status = case r.void When 0 then ''N'''
        + '          When 2 then  ''N'''
        + '          When 1 then  ''A'''

        + '          end,sig,'
        + ' ''482'' as Versao,k.vorname+'' ''+k.name1 as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        + ' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        + ' 0 as troco,'

        + '  '''' as ContaCblprod,'''' as Descritivo,0 as Quant,0 as VAlorUnit,'
        + '   '''' as ContaCBLIVA,''0'' as taxaiva,0 as VAlor,''1'' as Armazem,'
        + '    '''' as CCusto,'''' as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        + '    '''' as ContaCBLPAg,''''  as DescricaoPagamento,0 as ID_ModoPagamento,0 as valoriva,F.Code'
        +',  '''' as TipoArtigoERP '
        +', ''UN'' as CodUnvenda  '
        +',''UN'' as UniVenda '
        +', ''UN'' as CodUnBase  '
        +', ''UN'' as  UniBase '
        +',''1'' as factorconversao    '
        +', '''' as  AreaNegocio, '''' as DescAreaNegocio'
        +',''0'' as ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',''0'' as ID_Familia,'''' as  Familia'
        +',''0'' as ID_SubFamilia,'''' as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,0 as RefL,r.datum as datamovimento '
        //novo toc

        +',  '''' as ProductType,'''' as TaxCountry,'''' as tax_code,S.typedoc as invoicetype,'
        +'  '''' as Id_gruposervico,'''' as ContaCBL,'''' as payment_mechanism  '


        + ' FROM '+DescSchema+'rechhist R'
        + '     inner join  '+DescSchema+'leisthis L'
        + '      on L.fisccode=R.fisccode'
        + '      and L.rechnr=R.rechnr'
        + '      left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref'
        + '      left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr'
        + '      left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        + '      left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref'
        +'       left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        + '      WHERE R.fisccode <> 0 and S.ERPexporta =''S'''+ StrFiltroRechist;
   strsql1:=
         ' select distinct  R.Ref as ID_Interno, 2 as TipoLinha'
        +' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        +' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'
        +' ,status = case r.void When 0 then ''N'''
        +'          When 2 then  ''N'''
        +'          When 1 then  ''A'''

        +'          end,sig,'
        +' ''482'' as Versao,k.vorname+'' ''+k.name1   as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        +' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        +' 0 as troco,'
        +' case when l.article<=0 then  '
        +'cast (U.Gvkonto as varchar(100)) collate Latin1_General_CI_AS '
        +' else '
        +' case when Id_produtosys> 0 then '
        +' cast (ArtSys.ContaCbl as varchar(100)) collate Latin1_General_CI_AS '
        +' else '
        +' cast (ArticlesPMSSYS.Gvkonto  as varchar(100)) collate Latin1_General_CI_AS '
        +' end end  as ContaCblprod '
        +', case when l.article<=0 then  U.bez else art.text end as Descritivo '
        +', L.anzahl as Quant,L.epreis as VAlorUnit,'
        +' M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        +' u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        +' '''' as ContaCBLPAg,'' ''  as DescricaoPagamento ,0 as ID_ModoPagamento,'
        +' ( l.epreis* L.anzahl)/(100+L.mwstsatz)*L.mwstsatz as valoriva,F.Code'
        +', U.kst1 as TipoArtigoERP,'
        +' Case  when ArtSys.vproduto  is null then  '
        +'''UN'' else CodUnvenda end as CodUnvenda, '
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else UniVenda end as UniVenda,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else CodUnBase end as CodUnBase,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else UniBase end as UniBase,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''1'' else factorconversao end as factorconversao'
        +',ERP_AreaNegocio.ContaERP as AreaNegocio'
        +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'
        +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
        +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,l.ref as RefL,l.datum as datamovimento,'

       //novo toc-online
		   +' isnull(MCP.short,'' '') as ProductType, '
   	   +'(Select xvalue from '
       +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
       +' and xkey='+sb.UtilSQL.StrToSQLStr('TaxCountry')+' and mpehotel=1) as TaxCountry,'
 	   	 +' M.kennz2 as tax_code,'''' as invoicetype, isnull(MCG.short,'''') as Id_gruposervico,'

       +'	(select xvalue from '
       +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
       +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TOC')
       +' and mpehotel=0)+(select xvalue from '
       +DescSchema+'xsetup  '
       +' where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
       +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TAA')
       +' and mpehotel=0) + isnull(TAAC.data,'''') as ContaCBL,'
		   +' '''' as payment_mechanism '
// fim novo toc online
       +' from '+DescSchema+'leisthis L  '
       +' Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode '
       +' and L.rechnr=R.rechnr  '
       +' left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref  '
       +' left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref '
       +' left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr '
       +' left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
       +' left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
       +' left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
       +' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'



        + ' left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        + ' left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        + ' left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        + ' left join '+DescSchema+'Articles as Art on l.article=Art.ref '
        + ' left join '+DescSchema+'ArticlesPMSSYS as ArticlesPMSSYS on ArticlesPMSSYS.ref=Art.ref '
        + ' left join '+pShemaSys+'tab_produto as ArtSys on ArticlesPMSSYS.Id_ProdutoSYS=ArtSys.vproduto '
        + ' left join '+pShemaSys+'V_ERPInterfaceProdUnidade  on V_ERPInterfaceProdUnidade.ID_Produto=ArtSys.vproduto'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS '
        +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'

        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
        +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'


        //novo toc-online
        +' left join (select ref,data from '
        +DescSchema+'metadata where type=5400 and '
        +'xkey='+sb.UtilSQL.StrToSQLStr('TipoProdutoT')+') as TAAP on TAAP.ref=L.ukto '

        +' left join (select ref,data from '
        +DescSchema+'metadata where type=5400 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('gruposervico')+') as TAAG on TAAG.ref=L.ukto '
        +' left join (select ref,data from '
        +DescSchema+'metadata where type=5400 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('contacbl')+') as TAAC on TAAC.ref=L.ukto '

        +' left join '+DescSchema+'metacodes as MCP on MCP.ref=TAAP.data '
        +' left join '+DescSchema+'metacodes as MCG on MCG.ref=TAAG.data '
//        + '  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz=0  '+StrFiltroRechist;
//novo toc online
        + '  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz=0 and L.article in (-1,0) '+StrFiltroRechist;

// pbb 02-02-2023 novo toc_line  para separar artigos de contas de lançamento tiverem se ser montados dois sql aos tipos de linha 2
strsql1_1:=
        ' select distinct  R.Ref as ID_Interno, 2 as TipoLinha'
        +' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +' r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        +' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'
        +' ,status = case r.void When 0 then ''N'''
        +' When 2 then  ''N'''
        +' When 1 then  ''A'''
        +' end,sig,'
        +' ''482'' as Versao,k.vorname+'' ''+k.name1   as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        +' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        +' 0 as troco,'
        +' case when l.article<=0 then  '
        +' cast (U.Gvkonto as varchar(100)) collate Latin1_General_CI_AS '
        +' else '
        +' case when Id_produtosys> 0 then '
        +' cast (ArtSys.ContaCbl as varchar(100)) collate Latin1_General_CI_AS '
        +' else '
        +' cast (ArticlesPMSSYS.Gvkonto  as varchar(100)) collate Latin1_General_CI_AS '
        +' end end  as ContaCblprod '
        +' ,case when l.article<=0 then  U.bez else art.text end as Descritivo '
        +' ,L.anzahl as Quant,L.epreis as VAlorUnit,'
        +' M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        +' u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        +' '''' as ContaCBLPAg,'' ''  as DescricaoPagamento ,0 as ID_ModoPagamento,'
        +' ( l.epreis* L.anzahl)/(100+L.mwstsatz)*L.mwstsatz as valoriva,F.Code'
        +' ,U.kst1 as TipoArtigoERP,'
        +' Case  when ArtSys.vproduto  is null then  '
        +'''UN'' else CodUnvenda end as CodUnvenda, '
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else UniVenda end as UniVenda,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else CodUnBase end as CodUnBase,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else UniBase end as UniBase,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''1'' else factorconversao end as factorconversao'
        +',ERP_AreaNegocio.ContaERP as AreaNegocio'
        +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'
        +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
        +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,l.ref as RefL,l.datum as datamovimento,'
		    +'isnull(AMPT.short,'' '') as ProductType,'
        +'(Select xvalue from '
        +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
        +' and xkey='+sb.UtilSQL.StrToSQLStr('TaxCountry')+' and mpehotel=1) as TaxCountry,'
        +' M.kennz2 as tax_code,'' '' as invoicetype,'' '' as Id_gruposervico,'


		    +' (select xvalue from '
        +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
        +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TOC')+' and mpehotel=0)+case when '
        +'(Select data from '+DescSchema+'metadata where type=5401 and '
        +'xkey='+sb.UtilSQL.StrToSQLStr('contacblart')
        +' and ref=L.article) !='''' then (select xvalue from '
        +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
        +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo Artigos')+' and mpehotel=0)+ isnull(ACBL.data,'''') '
        +' when exists (Select * from '
        +DescSchema+'metadata where type=5400 and '
        +'xkey='+sb.UtilSQL.StrToSQLStr('contacbl')+' and ref=L.ukto) then (select xvalue from '
        +DescSchema+'xsetup where '
        +' xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
        +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TAA')
        +' and mpehotel=0)+(select data from '
        +DescSchema+'metadata where type=5400 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('contacbl')
        +' and ref=L.ukto) else '''' end as ContaCBL,'


      {  +'(select xvalue from '


        +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
        +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TOC')+' and mpehotel=0)+case when exists '
        +'(Select * from '
        +DescSchema+'metadata where ref=ACBL.ref) then '                               +'(select xvalue from '
        +DescSchema+'xsetup '
        +' where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')+' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo Artigos')
        +' and mpehotel=0)+ isnull(ACBL.data,'''') when exists '
        +' (Select * from '
        +DescSchema+'metadata where type=5400 and '
        +'xkey='+sb.UtilSQL.StrToSQLStr('contacbl')+' and ref=L.ukto) then (select xvalue from '
        +DescSchema+'xsetup where '
        +' xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')+' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TAA')
        +' and mpehotel=0)+(select data from '
        +DescSchema+'metadata where type=5400 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('contacbl')+' and ref=L.ukto) else '' '' end as ContaCBL,'

}


  	    +' '''' as payment_mechanism '
        +' from '+DescSchema+'leisthis L  '
        +' Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode '
        +' and L.rechnr=R.rechnr  '
        +' left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref  '
        +' left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref '
        +' left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr '
        +' left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        +' left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        +' left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
        +' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'
        +' left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        +' left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        +' left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        +' left join '+DescSchema+'Articles as Art on l.article=Art.ref '
        +' left join '+DescSchema+'ArticlesPMSSYS as ArticlesPMSSYS on ArticlesPMSSYS.ref=Art.ref '
        +' left join '+pShemaSys+'tab_produto as ArtSys on ArticlesPMSSYS.Id_ProdutoSYS=ArtSys.vproduto '
        +' left join '+pShemaSys+'V_ERPInterfaceProdUnidade  on V_ERPInterfaceProdUnidade.ID_Produto=ArtSys.vproduto'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS  on  erpvf.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio  on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'


        +' left join (select ref,data from '+DescSchema+'metadata where type=5401 '
        +' and xkey='+sb.UtilSQL.StrToSQLStr('ProductTypeA')+') as APT on APT.ref=L.article'
        +' left join (select ref,data from '+DescSchema+'metadata where type=5401 '
        +' and xkey='+sb.UtilSQL.StrToSQLStr('contacblart')+') as ACBL on ACBL.ref=L.article'
        +' left join '+DescSchema+'metacodes as AMPT on AMPT.ref=APT.data '
        +'  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz=0 and L.article >0 '+StrFiltroRechist;

// fim strsql_1_1
       strsql2:=
         ' select R.Ref as ID_Interno, 3 as TipoLinha'
        +' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +' r.rechnr as ID_Documento,r.datum as data,r.kdnr as ID_entidade, '
        +' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        +' ,status = case r.void When 0 then ''N'''
        +'          When 2 then  ''N'''
        +'          When 1 then  ''A'''
        +'          end,sig,'
        +' ''482'' as Versao,k.vorname+'' ''+k.name1  as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        +' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        +' 0 as troco,'

        +' U.Gvkonto as ContaCblprod,U.bez as Descritivo,L.anzahl as Quant,L.epreis as VAlorUnit,'
        +' M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        +' u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor,'
        +' Z.fibukto as ContaCBLPAg,Z.bez  as DescricaoPagamento,Z.zanr as ID_ModoPagamento, 0 as Valoriva,F.Code'
        +', U.kst1 as TipoArtigoERP'
        +', ''UN'' as CodUnvenda  '
        +',''UN'' as UniVenda '
        +', ''UN'' as CodUnBase  '
        +', ''UN'' as  UniBase '
        +',''1'' as factorconversao    '
        +',ERP_AreaNegocio.ContaERP as AreaNegocio'
        +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'
        +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
        +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais ,l.ref as RefL ,l.datum as datamovimento, '
        +' '''' as ProductType,'''' as TaxCountry,'''' as tax_code,'''' as invoicetype,'''' as Id_gruposervico,'
        +' '''' as ContaCBL,	isnull(MCBLP.short,'''') as payment_mechanism '
        +' from '+DescSchema+'leisthis L'
        +' Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode'
        +' and L.rechnr=R.rechnr'
        +' left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref'
        +' left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref'
        +' left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr'
        +' left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        +' left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        +' left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
        +' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'
        +' left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        +' left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        +' left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        +' inner join '+DescSchema+'zahlart as Z on Z.zanr=L.Rkz'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS '
        +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
        +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'
        +' left join (select ref,data from '
        +DescSchema+'metadata where type=5100 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('ContaCBLPay')+') as CBLP on CBLP.ref=L.rkz  '
       	+' left join '+DescSchema+'metacodes as MCBLP on MCBLP.ref=CBLP.data '
        +'  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz>0 '+StrFiltroRechist
        +'  )as x' ;

   strsql:=strsql+' Union ALL '+ strsql1+' Union All '+strsql1_1+' Union All '+  strsql2;

   strsql:=strsql+ '    where   isnull(x.serie,'' '')<>'+sb.UtilSQL.StrToSQLStrpelica('');


   strsql:=strsql+'  '+ strFiltroGeral;

   strsql:=strsql+ '  order by id_interno,tipolinha';

   Result:=sb.SBBD.AbrirLV(strsql);


  try
      caminho:=ExtractFilePath(Application.ExeName);
      AssignFile(txtFileR,caminho+'sqlDocspms.TXT');
      Rewrite(txtFileR);
      Writeln(txtFileR,strsql);
      CloseFile(txtFileR)
   except
   end;
 end;
end;
Function DaListaDocumentosPorExportarNova(pFiltroGeral:string;pdata,pdatafim:Tdatetime;pPrefixoProtel,pShemaSys:string;pID_Documento:string=''):tsbbetabeladados;
var
   StrFiltroRechist,strFiltroGeral,
   strsql,strsql1,strsql1_1,strsql2:string;
  mensagemerro:string;
  ID_UltVndcabdocumentoExportado:Integer;
  DescSchema:string;
  txtFileR: TextFile;
  caminho:string;
  FiltraIntervaloDatasManual:boolean;
begin
 result:=nil;
 ID_UltVndcabdocumentoExportado:=0;
 DescSchema:=FOBJInterface.BDSchema;
 If   FOBJInterface.Namelinkedserver<>'' then
 begin
  DescSchema:= FOBJInterface.Namelinkedserver+'.'+  DescSchema;
 end;
 ID_UltVndcabdocumentoExportado:=DAultimoIDVendaExportado;
 If ValidaExportacao(mensagemerro) then
 begin

  StrFiltroRechist:=DafiltroCabecalhoRechist(ID_UltVndcabdocumentoExportado,pdata,pdatafim,pPrefixoProtel,pShemaSys,pID_Documento);
  strFiltroGeral:= DafiltroGeral(pFiltroGeral,ID_UltVndcabdocumentoExportado,pdata,pdatafim,pPrefixoProtel,pShemaSys,pID_Documento);

  strsql:='select * '
        + ' from ( '
        + ' select distinct R.Ref as ID_Interno, 1 as TipoLinha '
        + ' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        + ' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        + ' ,status = case r.void When 0 then ''N'''
        + '          When 2 then  ''N'''
        + '          When 1 then  ''A'''

        + '          end,sig,'
        + ' ''482'' as Versao,k.vorname+'' ''+k.name1 as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        + ' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        + ' 0 as troco,'

        + '  '''' as ContaCblprod,'''' as Descritivo,0 as Quant,0 as VAlorUnit,'
        + '   '''' as ContaCBLIVA,''0'' as taxaiva,0 as VAlor,''1'' as Armazem,'
        + '    '''' as CCusto,'''' as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        + '    '''' as ContaCBLPAg,''''  as DescricaoPagamento,0 as ID_ModoPagamento,0 as valoriva,F.Code'
        +',  '''' as TipoArtigoERP '
        +', ''UN'' as CodUnvenda  '
        +',''UN'' as UniVenda '
        +', ''UN'' as CodUnBase  '
        +', ''UN'' as  UniBase '
        +',''1'' as factorconversao    '
        +', '''' as  AreaNegocio, '''' as DescAreaNegocio'
        +',''0'' as ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',''0'' as ID_Familia,'''' as  Familia'
        +',''0'' as ID_SubFamilia,'''' as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,0 as RefL,r.datum as datamovimento '
        //novo toc

        +',  '''' as ProductType,'''' as TaxCountry,'''' as tax_code,S.typedoc as invoicetype,'
        +'  '''' as Id_gruposervico,'''' as ContaCBL,'''' as payment_mechanism  '


        + ' FROM '+DescSchema+'rechhist R'
        + '     inner join  '+DescSchema+'leisthis L'
        + '      on L.fisccode=R.fisccode'
        + '      and L.rechnr=R.rechnr'
        + '      left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref'
        + '      left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr'
        + '      left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        + '      left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref'
        +'       left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        + '      WHERE R.fisccode <> 0 and S.ERPexporta =''S'''+ StrFiltroRechist;
   strsql1:=
         ' select distinct  R.Ref as ID_Interno, 2 as TipoLinha'
        +' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +'   r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        +' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'
        +' ,status = case r.void When 0 then ''N'''
        +'          When 2 then  ''N'''
        +'          When 1 then  ''A'''

        +'          end,sig,'
        +' ''482'' as Versao,k.vorname+'' ''+k.name1   as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        +' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        +' 0 as troco,'
        +' case when l.article<=0 then  '
        +'cast (U.Gvkonto as varchar(100)) collate Latin1_General_CI_AS '
        +' else '
        +' case when Id_produtosys> 0 then '
        +' cast (ArtSys.ContaCbl as varchar(100)) collate Latin1_General_CI_AS '
        +' else '
        +' cast (ArticlesPMSSYS.Gvkonto  as varchar(100)) collate Latin1_General_CI_AS '
        +' end end  as ContaCblprod '
        +', case when l.article<=0 then  U.bez else art.text end as Descritivo '
        +', L.anzahl as Quant,L.epreis as VAlorUnit,'
        +' M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        +' u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        +' '''' as ContaCBLPAg,'' ''  as DescricaoPagamento ,0 as ID_ModoPagamento,'
        +' ( l.epreis* L.anzahl)/(100+L.mwstsatz)*L.mwstsatz as valoriva,F.Code'
        +', U.kst1 as TipoArtigoERP,'
        +' Case  when ArtSys.vproduto  is null then  '
        +'''UN'' else CodUnvenda end as CodUnvenda, '
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else UniVenda end as UniVenda,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else CodUnBase end as CodUnBase,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else UniBase end as UniBase,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''1'' else factorconversao end as factorconversao'
        +',ERP_AreaNegocio.ContaERP as AreaNegocio'
        +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'
        +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
        +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,l.ref as RefL,l.datum as datamovimento,'

       //novo toc-online
		   +' isnull(MCP.short,'' '') as ProductType, '
   	   +'(Select xvalue from '
       +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
       +' and xkey='+sb.UtilSQL.StrToSQLStr('TaxCountry')+' and mpehotel=1) as TaxCountry,'
 	   	 +' M.kennz2 as tax_code,'''' as invoicetype, isnull(MCG.short,'''') as Id_gruposervico,'
       +'	(select xvalue from '
       +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
       +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TOC')
       +' and mpehotel=0)+(select xvalue from '
       +DescSchema+'xsetup  '
       +' where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
       +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TAA')
       +' and mpehotel=0) + isnull(TAAC.data,'''') as ContaCBL,'
		   +' '''' as payment_mechanism '
// fim novo toc online
       +' from '+DescSchema+'leisthis L  '
       +' Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode '
       +' and L.rechnr=R.rechnr  '
       +' left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref  '
       +' left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref '
       +' left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr '
       +' left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
       +' left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
       +' left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
       +' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'



        + ' left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        + ' left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        + ' left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        + ' left join '+DescSchema+'Articles as Art on l.article=Art.ref '
        + ' left join '+DescSchema+'ArticlesPMSSYS as ArticlesPMSSYS on ArticlesPMSSYS.ref=Art.ref '
        + ' left join '+pShemaSys+'tab_produto as ArtSys on ArticlesPMSSYS.Id_ProdutoSYS=ArtSys.vproduto '
        + ' left join '+pShemaSys+'  V_ERPInterfaceProdUnidade  on V_ERPInterfaceProdUnidade.ID_Produto=ArtSys.vproduto'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS '
        +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'

        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
        +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'
        //novo toc-online
	      +' left join (select ref,data from '
        +DescSchema+'metadata where type=5400 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('producttype')+') as TAAP on TAAP.ref=L.ukto '
        +' left join (select ref,data from '
        +DescSchema+'metadata where type=5400 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('gruposervico')+') as TAAG on TAAG.ref=L.ukto '
        +' left join (select ref,data from '
        +DescSchema+'metadata where type=5400 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('contacbl')+') as TAAC on TAAC.ref=L.ukto '
        +' inner join '+DescSchema+'metacodes as MCP on MCP.ref=TAAP.data '
        +' left join '+DescSchema+'metacodes as MCG on MCG.ref=TAAG.data '
//        + '  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz=0  '+StrFiltroRechist;
//novo toc online
        + '  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz=0 and L.article in (-1,0) '+StrFiltroRechist;

// pbb 02-02-2023 novo toc_line  para separar artigos de contas de lançamento tiverem se ser montados dois sql aos tipos de linha 2
strsql1_1:=
        ' select distinct  R.Ref as ID_Interno, 2 as TipoLinha'
        +' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +' r.rechnr as ID_Documento,r.datum as data,r.kdnr  as ID_entidade, '
        +' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'
        +' ,status = case r.void When 0 then ''N'''
        +' When 2 then  ''N'''
        +' When 1 then  ''A'''
        +' end,sig,'
        +' ''482'' as Versao,k.vorname+'' ''+k.name1   as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        +' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        +' 0 as troco,'
        +' case when l.article<=0 then  '
        +' cast (U.Gvkonto as varchar(100)) collate Latin1_General_CI_AS '
        +' else '
        +' case when Id_produtosys> 0 then '
        +' cast (ArtSys.ContaCbl as varchar(100)) collate Latin1_General_CI_AS '
        +' else '
        +' cast (ArticlesPMSSYS.Gvkonto  as varchar(100)) collate Latin1_General_CI_AS '
        +' end end  as ContaCblprod '
        +' ,case when l.article<=0 then  U.bez else art.text end as Descritivo '
        +' ,L.anzahl as Quant,L.epreis as VAlorUnit,'
        +' M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        +' u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor, '
        +' '''' as ContaCBLPAg,'' ''  as DescricaoPagamento ,0 as ID_ModoPagamento,'
        +' ( l.epreis* L.anzahl)/(100+L.mwstsatz)*L.mwstsatz as valoriva,F.Code'
        +' ,U.kst1 as TipoArtigoERP,'
        +' Case  when ArtSys.vproduto  is null then  '
        +'''UN'' else CodUnvenda end as CodUnvenda, '
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else UniVenda end as UniVenda,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else CodUnBase end as CodUnBase,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''UN'' else UniBase end as UniBase,'
        +' Case  when ArtSys.vproduto  is null then'
        +' ''1'' else factorconversao end as factorconversao'
        +',ERP_AreaNegocio.ContaERP as AreaNegocio'
        +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'
        +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
        +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais,l.ref as RefL,l.datum as datamovimento,'
		    +'isnull(AMPT.short,'' '') as ProductType,'
        +'(Select xvalue from '
        +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
        +' and xkey='+sb.UtilSQL.StrToSQLStr('TaxCountry')+' and mpehotel=1) as TaxCountry,'
        +' M.kennz2 as tax_code,'' '' as invoicetype,'' '' as Id_gruposervico,'
        +'(select xvalue from '
        +DescSchema+'xsetup where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')
        +' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TOC')+' and mpehotel=0)+case when exists '
        +'(Select * from '
        +DescSchema+'metadata where ref=ACBL.ref) then '
        +'(select xvalue from '
        +DescSchema+'xsetup '
        +' where xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')+' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo Artigos')
        +' and mpehotel=0)+ isnull(ACBL.data,'''') when exists '
        +' (Select * from '
        +DescSchema+'metadata where type=5400 and '
        +'xkey='+sb.UtilSQL.StrToSQLStr('contacbl')+' and ref=L.ukto) then (select xvalue from '
        +DescSchema+'xsetup where '
        +' xsection='+sb.UtilSQL.StrToSQLStr('ERP_interface')+' and xkey='+sb.UtilSQL.StrToSQLStr('Prefixo TAA')
        +' and mpehotel=0)+(select data from '
        +DescSchema+'metadata where type=5400 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('contacbl')+' and ref=L.ukto) else '' '' end as ContaCBL,'
  	    +' '''' as payment_mechanism '
        +' from '+DescSchema+'leisthis L  '
        +' Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode '
        +' and L.rechnr=R.rechnr  '
        +' left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref  '
        +' left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref '
        +' left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr '
        +' left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        +' left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        +' left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
        +' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'
        +' left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        +' left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        +' left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        +' left join '+DescSchema+'Articles as Art on l.article=Art.ref '
        +' left join '+DescSchema+'ArticlesPMSSYS as ArticlesPMSSYS on ArticlesPMSSYS.ref=Art.ref '
        +' left join '+pShemaSys+'tab_produto as ArtSys on ArticlesPMSSYS.Id_ProdutoSYS=ArtSys.vproduto '
        +' left join '+pShemaSys+'V_ERPInterfaceProdUnidade  on V_ERPInterfaceProdUnidade.ID_Produto=ArtSys.vproduto'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS  on  erpvf.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio  on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'
        +' left join (select ref,data from '+DescSchema+'metadata where type=5401 '
        +' and xkey='+sb.UtilSQL.StrToSQLStr('ProductTypeP')+') as APT on APT.ref=L.article'
        +' left join (select ref,data from '+DescSchema+'metadata where type=5401 '
        +' and xkey='+sb.UtilSQL.StrToSQLStr('contacblart')+') as ACBL on ACBL.ref=L.article'
        +' left join '+DescSchema+'metacodes as AMPT on AMPT.ref=APT.data '
        +'  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz=0 and L.article >0 '+StrFiltroRechist;

// fim strsql_1_1
       strsql2:=
         ' select R.Ref as ID_Interno, 3 as TipoLinha'
        +' ,r.mpehotel,S.ERPSerie as ContaCBlDoc,f.ref as Serie,'
        +' r.rechnr as ID_Documento,r.datum as data,r.kdnr as ID_entidade, '
        +' isnull(k.fibudeb,'' '')as ContaCBLCliente,r.sum_belast as totalbruto,0 as desFinc'

        +' ,status = case r.void When 0 then ''N'''
        +'          When 2 then  ''N'''
        +'          When 1 then  ''A'''
        +'          end,sig,'
        +' ''482'' as Versao,k.vorname+'' ''+k.name1  as nomecliente,isnull(k.strasse,'' '')as MoradaEntidade,'
        +' isnull(k.ort,'' '') as localidadeEntidade,'
        +' isnull(k.plz,'' '') as codigopostalentidade,isnull(k.vatno,'' '')as ContribuinteEntidade,r.sum_zahl as totalpago,'
        +' 0 as troco,'

        +' U.Gvkonto as ContaCblprod,U.bez as Descritivo,L.anzahl as Quant,L.epreis as VAlorUnit,'
        +' M.account as ContaCBLIVA,L.mwstsatz as taxaiva,(L.anzahl*L.epreis) as VAlor,''1'' as Armazem,'
        +' u.kst1 as CCusto,metacodes.short as CodIsencao,0 as PercDesconto,0 as DescontoValor,'
        +' Z.fibukto as ContaCBLPAg,Z.bez  as DescricaoPagamento,Z.zanr as ID_ModoPagamento, 0 as Valoriva,F.Code'
        +', U.kst1 as TipoArtigoERP'
        +', ''UN'' as CodUnvenda  '
        +',''UN'' as UniVenda '
        +', ''UN'' as CodUnBase  '
        +', ''UN'' as  UniBase '
        +',''1'' as factorconversao    '
        +',ERP_AreaNegocio.ContaERP as AreaNegocio'
        +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio'
        +',U.statgrp as  ID_GrupoFamilia,'''' as  GrupoFamilia'
        +',Familia.hgnr as ID_Familia,Familia.gruppe as Familia'
        +',U.kto as ID_SubFamilia,U.Bez as  SubFamilia'
        +', N.codenr as ID_Pais, N.ADDINFO as PaisISO,N.land as DescPais ,l.ref as RefL ,l.datum as datamovimento, '
        +' '''' as ProductType,'''' as TaxCountry,'''' as tax_code,'''' as invoicetype,'''' as Id_gruposervico,'
        +' '''' as ContaCBL,	isnull(MCBLP.short,'''') as payment_mechanism '
        +' from '+DescSchema+'leisthis L'
        +' Inner join '+DescSchema+'rechhist R on L.fisccode=R.fisccode'
        +' and L.rechnr=R.rechnr'
        +' left join '+DescSchema+'fiscalcdsaft S on r.fisccode=s.ref'
        +' left join '+DescSchema+'fiscalcd F on r.fisccode=f.ref'
        +' left join '+DescSchema+'Kunden K on r.kdnr=K.kdnr'
        +' left join '+DescSchema+'natcode N on k.landkz=N.Codenr'
        +' left join '+DescSchema+'PortugueseInvoiceSigning_history P on r.rechnr = p.refrech and R.fisccode = p.refcodefisc'
        +' left join '+DescSchema+'ukto U on (L.Ukto=U.ktonr)'
        +' left join '+DescSchema+'hgruppen Familia on (familia.hgnr=U.hauptgrp)'
        +' left join '+DescSchema+'mwst M on (L.vatno=M.Satznr)'
        +' left join '+DescSchema+'metadata on L.ukto=metadata.ref and metadata.xkey=''Motivo_isenção'''
        +' and metadata.mpehotel=R.mpehotel'
        +' left join '+DescSchema+'metacodes on metadata.data=metacodes.ref and metadata.xkey=''Motivo_isenção'''
        +' inner join '+DescSchema+'zahlart as Z on Z.zanr=L.Rkz'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS '
        +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioContaLancPMS.KTONR=U.KTONR'
        +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
        +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioContaLancPMS.ID_AreaNegocio'
        +' left join (select ref,data from '
        +DescSchema+'metadata where type=5100 and '
        +' xkey='+sb.UtilSQL.StrToSQLStr('ContaCBLPay')+') as CBLP on CBLP.ref=L.rkz  '
       	+' left join '+DescSchema+'metacodes as MCBLP on MCBLP.ref=CBLP.data '
        +'  WHERE (R.fisccode <> 0) and (S.ERPexporta =''S'') and L.rkz>0 '+StrFiltroRechist
        +'  )as x' ;

   strsql:=strsql+' Union ALL '+ strsql1+' Union All '+strsql1_1+' Union All '+  strsql2;

   strsql:=strsql+ '    where   isnull(x.serie,'' '')<>'+sb.UtilSQL.StrToSQLStrpelica('');


   strsql:=strsql+'  '+ strFiltroGeral;

   strsql:=strsql+ '  order by id_interno,tipolinha';

   Result:=sb.SBBD.AbrirLV(strsql);


  try
      caminho:=ExtractFilePath(Application.ExeName);
      AssignFile(txtFileR,caminho+'sqlDocspms.TXT');
      Rewrite(txtFileR);
      Writeln(txtFileR,strsql);
      CloseFile(txtFileR)
   except
   end;
 end;
end;


Function DalistaIDDocs(pListaDocs:TsbbeTabeladados):TstringList;
begin
     Result:=TstringList.create;
     pListaDocs.inicio;
     While Not(pListaDocs.NoFim)do
     begin
        If Result.IndexOf(pListaDocs.davalor('ID_Interno').asstring)=-1 then
            Result.Add(pListaDocs.davalor('ID_Interno').asstring);
        pListaDocs.seguinte;
     end;
end;

Function PreencheOBJDoc(pListaDocs:TsbbeTabeladados;pid_Internodoc:Integer):TERPBECab;
var
    ObjLinha:TERPBELinha;
    ObjLinhaPagamento:TERPBELinhaPagamento;
    Linha:integer;
    DescMercado:string;
    Mercado:integer;
   SysObjInterface:TERPBEEMPRESAINTERFACE;
begin
   SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
   If assigned(FListaContasMercado) then
   begin
     FListaContasMercado.fecha;
     Freeandnil(FListaContasMercado);
   end;
   FListaContasMercado:=sb.SBBD.AbrirLV('Select ID_Pais,id_Mercado,descmercado from PMSPaisMercado');
   
  pListaDocs.dataset.filtered:=false;
  pListaDocs.dataset.filter:='ID_Interno='+Inttostr(pid_Internodoc);
  pListaDocs.dataset.filtered:=true;
  If  Not pListaDocs.Vazia then
  begin
    Result:=TERPBECab.Create;
    Result.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('ID_Interno').asinteger;
    Result.mpehotel:=pListaDocs.davalor('mpehotel').asinteger;
    Result.Numero:= pListaDocs.davalor('id_documento').asinteger;
    Result.serie:= pListaDocs.davalor('serie').asstring;
    Result.typedoc:= pListaDocs.davalor('ContaCBLDOC').asstring;
    Result.Data:= pListaDocs.davalor('Data').asdatetime;
    Result.DataVenc:= pListaDocs.davalor('Data').asdatetime;
    Result.IDCliente:= pListaDocs.davalor('id_entidade').asinteger;

    Result.Nrcliente:= pListaDocs.davalor('ContaCBLCliente').asstring;

    If  pListaDocs.davalor('ContaCBLCliente').asstring='' then
    begin
      If listContasSaco.Localiza('mpehotel',pListaDocs.davalor('mpehotel').asstring,[]) then
         Result.Nrcliente:=listContasSaco.davalor('xvalue').asstring;
    end;


    Result.TotalBruto:= pListaDocs.davalor('TotalBruto').asFloat;

    Result.Status:= pListaDocs.davalor('status').asstring;
    Result.Assinatura:= pListaDocs.davalor('sig').asstring;
    Result.chave:= pListaDocs.davalor('versao').asstring;
    Result.Nome:= pListaDocs.davalor('Nomecliente').asstring;
    Result.Morada:= pListaDocs.davalor('MoradaEntidade').asstring;
    Result.CodPostal:= pListaDocs.davalor('CodigoPostalEntidade').asstring;
    Result.localidade:= pListaDocs.davalor('localidadeEntidade').asstring;
    Result.NIF:= pListaDocs.davalor('ContribuinteEntidade').asstring;
    Result.TotalPago:=pListaDocs.davalor('totalpago').asFloat;
    Result.Integrado:=False;
    Result.Origem:=SysObjInterface.Origem;
    Result.DataHoraRegisto:=now;
    Result.TotalLinhas:=pListaDocs.NumLinhas-1;
    Result.UtilizadorRegisto:=Sb.UtilizadorActual.Login;
    Result.CodPais:= pListaDocs.davalor('PaisISO').asstring;
    Result.DescPais:= pListaDocs.davalor('DescPais').asstring;
    result.Invoicetype:=  pListaDocs.davalor('invoicetype').asstring;
    Result.mercado:=-1;
    DescMercado:='';
    If pListaDocs.davalor('ID_Pais').asinteger>0 then
    begin
      Mercado:=DaMercado(pListaDocs.davalor('ID_Pais').asinteger,DescMercado);
      Result.Mercado:=Mercado;
      Result.DescMercado:=DescMercado;
    end;   



    Linha:=1;
    While Not (pListaDocs.NoFim) do
    begin
      if  pListaDocs.daValor('TipoLinha').asinteger=2 then
      begin
         ObjLinha:=TERPBELinha.create;
         With ObjLinha do
         begin
            ObjLinha.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('ID_Interno').asinteger;
            ObjLinha.Numero:= pListaDocs.davalor('id_documento').asinteger;
            ObjLinha.serie:= pListaDocs.davalor('serie').asstring;
            ObjLinha.ID_Linha:= Linha;
            ObjLinha.mpehotel:=Result.mpehotel;

            ObjLinha.Data:= pListaDocs.davalor('data').asdatetime;
            ObjLinha.servico:= pListaDocs.davalor('ContaCBL').asstring;
            ObjLinha.Descritivo:= pListaDocs.davalor('Descritivo').asstring;
            ObjLinha.qnt:= pListaDocs.davalor('quant').asfloat;

            If pListaDocs.davalor('ProductType').asstring<>'' then
                    ObjLinha.TipoArtigo:= pListaDocs.davalor('ProductType').asstring;

             if ObjLinha.TipoArtigo='S' then
                ObjLinha.ID_GrupoServico:= pListaDocs.davalor('Id_gruposervico').asstring;

             ObjLinha.TaxCode:= pListaDocs.davalor('tax_code').asstring;
             ObjLinha.TaxCountryRegion := pListaDocs.davalor('TaxCountry').asstring;



            ObjLinha.CODIGOUNIDADEBASE:= pListaDocs.davalor('CodUnBase').asstring;
            ObjLinha.CODIGOUNIDADEVENDA:= pListaDocs.davalor('CodUnvenda').asstring;
            ObjLinha.DESCRICAOUNIDADEVENDA:= pListaDocs.davalor('UniVenda').asstring;
            ObjLinha.DESCRICAOUNIDADEBASE:= pListaDocs.davalor('UniBase').asstring;
            ObjLinha.FATORCONVERSAO:= pListaDocs.davalor('factorconversao').asfloat;


            ObjLinha.precounit:= pListaDocs.davalor('VAlorUnit').asfloat;
            ObjLinha.codiva:= pListaDocs.davalor('ContaCBlIVA').asstring;
            ObjLinha.taxaiva:= pListaDocs.davalor('taxaiva').asFloat;
            ObjLinha.total:= pListaDocs.davalor('valor').asFloat;
            ObjLinha.valoriva:= pListaDocs.davalor('valoriva').asFloat;
            ObjLinha.Armazem:= '';
            ObjLinha.CodIsencao:= pListaDocs.davalor('CodIsencao').asstring;
            ObjLinha.Descontoperc:= pListaDocs.davalor('PercDesconto').asFloat;
            ObjLinha.Origem:=  Result.Origem;

            ObjLinha.AreaNegocio:= pListaDocs.davalor('AreaNegocio').asstring;
            ObjLinha.DescAreaNegocio:= pListaDocs.davalor('DescAreaNegocio').asstring;
            ObjLinha.Ref:= pListaDocs.davalor('RefL').asinteger;
            ObjLinha.DataMovimento:=pListaDocs.davalor('DataMovimento').asdatetime;

            //13-11-2019 Sr.Pedro Pinheiro falou com o eng.Paulo fernandes e transmitiu me para concatenar a origem com hieraquia de Produtos
            //origem 1 neste caso pois trata-se de Protel
            ObjLinha.ID_GrupoProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_GrupoFamilia').asstring);
            // a Desctição dogrupo de familia foi me transmitido por e.mail o seguinte
            ///* IDGRUPO (statgrp)
             // 0- LOGIS
             //1- F&B
             //2 -EXTRAS

             If pListaDocs.davalor('ID_GrupoFamilia').asinteger=0 then
              ObjLinha.GrupoProduto:='LOGIS'
             else
             If pListaDocs.davalor('ID_GrupoFamilia').asinteger=1 then
              ObjLinha.GrupoProduto:='F&B'

             else
             If pListaDocs.davalor('ID_GrupoFamilia').asinteger=2 then
              ObjLinha.GrupoProduto:='EXTRAS';


            ObjLinha.ID_FamiliaProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_Familia').asstring);
            ObjLinha.FamiliaProduto:= pListaDocs.davalor('Familia').asstring;

            ObjLinha.ID_SubFamiliaProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_SubFamilia').asstring);
            ObjLinha.SubFamiliaProduto:= pListaDocs.davalor('SubFamilia').asstring;



            inc(Linha);
            Result.Linhas.Adiciona(ObjLinha);


          end;
      end
      else
      if  pListaDocs.daValor('TipoLinha').asinteger=3 then
      begin
             inc(Linha);
            ObjLinhaPagamento:=TERPBELinhaPagamento.create;

            ObjLinhaPagamento.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('id_Interno').asinteger;
            ObjLinhaPagamento.ID_Linha:= Linha;
            ObjLinhaPagamento.ID_ModoPagamento:= pListaDocs.davalor('ID_ModoPagamento').asInteger;
            ObjLinhaPagamento.ID_Linha:= Linha;
            ObjLinhaPagamento.ContaERP:= pListaDocs.davalor('payment_mechanism').asstring;
            ObjLinhaPagamento.descricao:= pListaDocs.davalor('descricaoPagamento').asstring;
            ObjLinhaPagamento.Valor:= pListaDocs.davalor('valor').asFloat;
            ObjLinhaPagamento.Ref:= pListaDocs.davalor('RefL').asinteger;
            ObjLinhaPagamento.DataMovimento:=pListaDocs.davalor('DataMovimento').asdatetime;



            If FOBJInterface.ID_PagamentoCC>0 then
            begin
              If  (ObjLinhaPagamento.ID_ModoPagamento=FOBJInterface.ID_PagamentoCC) then
              begin
                  If (FOBJInterface.TipoCtrlCodClienteCC  in[1,2]) then
                     If  pListaDocs.davalor('ContaCBLCliente').asstring='' then
                     begin
                        Result.Nrcliente:='';
                     end;
              end;
            end;
            Result.Pagamentos.Adiciona( ObjLinhaPagamento);
      end;

      pListaDocs.seguinte;

    end;
  end;
  If assigned(FListaContasMercado) then
  begin
     FListaContasMercado.fecha;
     Freeandnil(FListaContasMercado);
  end;
  if Assigned(SysObjInterface) then
   FreeAndNil(SysObjInterface);
end;





Function ValidaExportacaoDocumento(ObjCab:TERPBECab;var mensagem:string):Boolean;
var
 i:integer;
 ListaD:Tsbbetabeladados;

begin
  result:=true;
  mensagem:='';
  If FOBJInterface.ObgContaERPCliente=true then
  begin
      If ObjCab.Nrcliente='' then
      begin
       If  FOBJInterface.TipoCtrlCodClienteCC<>1 then
           mensagem:='Conta do CLIENTE';
      end;
  end;

  If  ObjCab.Linhas.num=0 then
              mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Documento Sem Linhas:'+ ObjCab.typedoc+'-'+ObjCab.Serie+' nrº '+ObjCab.NumDocumento;

  For i:=0 to  ObjCab.Linhas.Num-1 do
  begin
     If  FOBJInterface.ObgLinhaContaERPProd=true then
        If  (ObjCab.Linhas.elem[i].servico='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do Produto:'+ ObjCab.Linhas.elem[i].Descritivo;

     If  FOBJInterface.ObgLinhaContaERPIVA=true then
      If  (ObjCab.Linhas.elem[i].codiva='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do IVA:'+FloatTostr(ObjCab.Linhas.elem[i].taxaiva);

     If  FOBJInterface.ObgLinhaContaERPAreaNeg=true then
      If  (ObjCab.Linhas.elem[i].areanegocio='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP Area de Negócio:'+ ObjCab.Linhas.elem[i].Descritivo;

  end;

  If FOBJInterface.ObgLinhaContaERPModPag then
      For i:=0 to  ObjCab.Pagamentos.Num-1 do
      begin
          If  (ObjCab.Pagamentos.elem[i].ContaERP='') then
              mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do Pagamento:'+ ObjCab.Pagamentos.elem[i].Descricao;
      end;
  If mensagem<>'' then
  begin
   mensagem:='Documento nº'+Inttostr(ObjCab.Numero)+' '+ObjCab.typedoc+#13+mensagem;
   result:=false;
  end;
  If Result then
  begin
          ListaD:=sb.SBBD.AbrirLV('select id_vndcabdocumento from ERP_Cab  where origem=1 and id_vndcabdocumento='+Inttostr(ObjCab.ID_VNDCABDOCUMENTO));

          If Not(ListaD.vazia) then
          begin
            mensagem:='Documento nº'+Inttostr(ObjCab.Numero)+' '+ObjCab.typedoc+#13+'Documento já foi exportado!';
            Result:=False;
          end;
          ListaD.fecha;


  end;


end;




Procedure InsereLinha(ObjLinha:TERPBELinha;var Erros:string);
var
 stsql:string;
 i:integer;
begin
  Erros:='';
  With ObjLinha do
  Begin
    stsql:= ' INSERT INTO ERP_Detalhes'
          +' ('
            +'ID_Interno'
          +' ,Serie'
          +' ,numero'
          +',Data'
             +',servico'
          +',Descritivo'
          +',qnt'
          +',precounit'
          +',codiva'
          +',taxaiva'
          +',total'
          +',CCusto'
          +',CodIsencao'
          +',Descontoperc'
          +',DescontoValor'
          +',ID_Linha'
          +',ID_VNDCABDOCUMENTO'
          +',Origem,TipoArtigo'
          +',CODIGOUNIDADEVENDA'
          +',CODIGOUNIDADEBASE'
          +',DESCRICAOUNIDADEVENDA'
          +',DESCRICAOUNIDADEBASE '
          +',FATORCONVERSAO '
          +',AreaNegocio '
          +',DescAreaNegocio '
          +',ID_GrupoProduto'
          +',GrupoProduto'
          +',ID_FamiliaProduto'
          +',FamiliaProduto'
          +',ID_SubFamiliaProduto'
          +',SubFamiliaProduto'
          +',Ref'
          +',DataMovimento'
          +',mpehotel'
          +',valoriva'
          +',ID_GrupoServico '
          +',taxcode '
          +',TaxCountryRegion '


          +')'
          +' values( '
          + IntToStr(ObjLinha.ID_internoDoc)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.Serie)
           +','+ IntToStr(ObjLinha.Numero)
           +','+ sb.UtilSQL.DataToSQLData(ObjLinha.Data)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.servico)
           +','+ sb.UtilSQL.StrToSQLStrPelica(ObjLinha.Descritivo)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.qnt)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.precounit)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.codiva)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.taxaiva)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.total)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.CCusto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.CodIsencao)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.Descontoperc)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.DescontoValor)
           +','+ IntToStr(ObjLinha.ID_Linha)
           +','+ IntToStr(ObjLinha.ID_VNDCABDOCUMENTO)
           +','+ IntToStr(ObjLinha.Origem)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.TipoArtigo)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.CODIGOUNIDADEVENDA)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.CODIGOUNIDADEBASE)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.DESCRICAOUNIDADEVENDA)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.DESCRICAOUNIDADEBASE)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.FATORCONVERSAO,'0.0000')
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.AreaNegocio)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.DESCAreaNegocio)
           
           +','+ IntToStr(ObjLinha.ID_GrupoProduto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.GrupoProduto)

           +','+ IntToStr(ObjLinha.ID_FamiliaProduto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.FamiliaProduto)

           +','+ IntToStr(ObjLinha.ID_SubFamiliaProduto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.SubFamiliaProduto)
           +','+ IntToStr(ObjLinha.Ref)
           +','+ sb.UtilSQL.DataToSQLData(ObjLinha.DataMovimento)
           +','+ IntToStr(ObjLinha.mpehotel)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.valoriva)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.ID_GrupoServico)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.taxcode)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.TaxCountryRegion)

          +')';
          sb.SBBD.Executa(stsql);
          Try
          except
           erros:=stsql;
          end;

   end;
end;


Procedure InsereLinhaPagamento(ObjPagamento:TERPBELinhaPagamento;var erros:string);
var
 stsql:string;
 i:integer;
begin
  erros:='';
  With ObjPagamento do
  Begin
    stsql:= ' INSERT INTO ERP_Pagamentos'
           + '('
           + 'ID_Interno'
           +', ID_VndCabdocumento'
           + ',ID_linha'
           + ',ID_ModoPagamento'
           + ',ContaERP'
           + ',Descricao'
           + ',Valor'
          +',Ref'
          +',DataMovimento'
           +')'
           +' values( '
           + IntToStr(ObjPagamento.ID_internoDoc)
           +','+ IntToStr(ObjPagamento.ID_VNDCABDOCUMENTO)
           +','+ IntToStr(ObjPagamento.ID_Linha)
           +','+ IntToStr(ObjPagamento.ID_ModoPagamento)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjPagamento.ContaERP)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjPagamento.Descricao)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjPagamento.Valor)
           +','+ IntToStr(ObjPagamento.Ref)
           +','+ sb.UtilSQL.DataToSQLData(ObjPagamento.DataMovimento)

           +')';
           Try
            sb.SBBD.Executa(stsql);
           except
            erros:= stsql;
           end;
   end;
end;

Function GravaDocvenda(ObjCab:TERPBECab;var erros:string):Boolean;
var
 stsql:widestring;
 i:integer;
 ProximoID_InternoDoc:integer;
 TotalIVA,valorivataxa:extended;
 ObjIVA:Tfntbeapoio;
 OBJlinhasIVA:TFntBELinhasApoio;
 strdoc:string;
    txtFileR: TextFile;
   caminho:string;

begin
  TotalIVA:=0;
  Result:=true;
  ProximoID_InternoDoc:=sb.ProximoID('ERP_CAB',true);

  OBJlinhasIVA:=nil;
  OBJlinhasIVA:=TFntBELinhasApoio.create;
  With ObjCab do
  Begin

    strdoc:= ObjCab.typedoc+'/'+ObjCab.Serie
     +' nº'+IntToStr(ObjCab.Numero)+' Data '+DateToStr(ObjCab.Data);

    ObjCab.ID_internoDoc:=ProximoID_InternoDoc;
    stsql:=' INSERT INTO ERP_Cab'
    +'  ('
    +'ID_Interno'
    + ',typedoc'
    +',Serie'
    +',Numero'
    +',Data'
    +',DataVenc'
    +',IDCliente'
    +',Nrcliente'
    +',TotalBruto'
    +',Status'
    +',Assinatura'
    +',Chave'
    +',Nome'
    +',Morada'
    +',localidade'
    +',CodPostal'
    +',NIF'
    +',TotalPago'
    +',Origem'
    +',DataHoraRegisto'
    +',ID_VNDCABDOCUMENTO'
    +',TotalLinhas'
    +',UtilizadorRegisto,integrado,mpehotel'
    +',CodPais,DescPais ,Mercado ,DescMercado,Invoicetype'
           +')'
           +' values( '
           +inttostr(ObjCab.ID_internoDoc)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.typedoc)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Serie)
           +','+ IntToStr(ObjCab.Numero)
           +','+ sb.UtilSQL.DataToSQLData(ObjCab.Data)
           +','+ sb.UtilSQL.DataToSQLData(ObjCab.DataVenc)
           +','+ IntToStr(ObjCab.IDCliente)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Nrcliente)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjCab.TotalBruto)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Status)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Assinatura)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Chave)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Nome)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Morada)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.localidade)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodPostal)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.NIF)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjCab.TotalPago)
           +','+ IntToStr(ObjCab.Origem)
           +','+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.DataHoraRegisto)
           +','+ IntToStr(ObjCab.ID_VNDCABDOCUMENTO)
           +','+ IntToStr(ObjCab.TotalLinhas)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.UtilizadorRegisto)
           +','+ sb.UtilSQL.BoolToSQLStr(false)
           +','+ IntToStr(ObjCab.mpehotel)
          +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodPais)
          +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.DescPais)
          +','+ IntToStr(ObjCab.Mercado)
          +','+ sb.UtilSQL.StrToSQLStrpelica(DescMercado)
          +','+ sb.UtilSQL.StrToSQLStrpelica(Invoicetype)
           +')';
        Try
          sb.SBBD.Executa(stsql);
          result:=true;
        except
         erros:='Erro na Gravação do Cabeçalho doc: ' +strdoc;
         result:=false;
        end;
       If result =true then
       begin
          For i:=0 to ObjCab.Linhas.Num-1 do
          begin
            If result =true then
            begin
                ObjCab.Linhas.elem[i].ID_internoDoc:= ObjCab.ID_internoDoc;
                InsereLinha(ObjCab.Linhas.elem[i],erros);
                If erros<>'' then
                begin
                  erros:='Erro na Gravação das Linhas do doc: '+strdoc;
                  result:=false;
                end;

                ObjIVA:=OBJlinhasIVA.ApoioTaxaIVA[ObjCab.Linhas.elem[i].taxaiva];
                If ObjIVA<>nil then
                begin
                  ObjIVA.Valor:=ObjIVA.Valor+ ObjCab.Linhas.elem[i].ValorIVA;
                end
                else
                begin
                  ObjIVA:=TFntBEApoio.create;
                  ObjIVA.Valor:=ObjCab.Linhas.elem[i].ValorIVA;
                  ObjIVA.TaxaIVA:=ObjCab.Linhas.elem[i].taxaiva;
                  ObjIVA.id:= ObjCab.ID_internoDoc;
                  OBJlinhasIVA.Adiciona(ObjIVA);
                end;
             end;   
          end;

          TotalIVA:=0;
          for i:=0 to   OBJlinhasIVA.num-1 do
          begin
            valorivataxa:=0;
            valorivataxa:=OBJlinhasIVA.Elem[i].Valor;
            valorivataxa:=MotorFnt.VndDocumento.Arredonda(valorivataxa,2);
            TotalIVA:= TotalIVA+valorivataxa
          end;

          stsql:='update   ERP_Cab set TOTALIVA='+sb.UtilSQL.DecimalToSQLStr(TotalIVA)
               +' where  ID_Interno='+Inttostr(ObjCab.ID_internoDoc);
          sb.SBBD.Executa(stsql);

          For i:=0 to ObjCab.Pagamentos.Num-1 do
          begin
              ObjCab.Pagamentos.elem[i].ID_internoDoc:= ObjCab.ID_internoDoc;
              InsereLinhaPagamento(ObjCab.Pagamentos.Elem[i],erros);
              If erros<>'' then
              begin
               erros:='Erro nas Linhas do doc: '+strdoc;
               Result:=false;
              end;
          end;


         end;
         if OBJlinhasIVA<>nil then
             freeandnil(OBJlinhasIVA);
    end;
 If  erros<>'' then
 begin
  Try
      caminho:=ExtractFilePath(Application.ExeName);
      AssignFile(txtFileR,caminho+'sqlpms.TXT');
      Rewrite(txtFileR);
      Writeln(txtFileR,stsql);
      CloseFile(txtFileR);
   except
   end;   
 end;

end;

Function ExportarVendas(pListaDocs:TsbbeTabeladados;pids_Hoteis:string):Boolean;
var
   ObjCabecalhos:TERPBECabecalhos;
   ObjCab:TERPBECab;
   ListaIDSDocs:TstringList;
   i:Integer;

   strsql,strMensagemErros,strBDSchema:string;

begin
  Result:=false;
  strMensagemErros:='';
  strBDSchema:= FOBJInterface.BDSchema;
  If   FOBJInterface.Namelinkedserver<>'' then
     strBDSchema:=FOBJInterface.Namelinkedserver+'.'+ strBDSchema;

  If  Not(ValidaExportacao(strMensagemErros)) then
    sb.Dialogos.SBMessage(strMensagemErros)
  else
  If Not(pListaDocs.Vazia) then
  begin
        strsql:=  'select xvalue,xsection,mpehotel from '+strBDSchema+'xsetup'
        +' where xsection = ''ERP_Interface'''
        +' and xkey = ''ClienteSaco'''
        +' and mpehotel IN('+pids_Hoteis+')';

        listContasSaco:=sb.SBBD.AbrirLV(strsql);


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
           If ValidaExportacaoDocumento(ObjCabecalhos.Elem[i],strMensagemErros) then
           begin
              If Not(GravaDocvenda(ObjCabecalhos.Elem[i],strMensagemErros)) then
              begin
               Raise
                 SB.ErroNormal(0,'Exportação de Vendas Interrompida','Grava Documento',strMensagemErros);
              end;
           end
           else
           Raise
               SB.ErroNormal(0,'Exportação de Vendas Interrompida','Grava Documento',strMensagemErros);
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




Function DaIDHoteis():string;
var
    strsql:string;
    listaHoteis:Tsbbetabeladados;
begin
    result:='';
    If   FOBJInterface.IDSHoteis<>'' then
    begin
      Result:= FOBJInterface.IDSHoteis;
    end;

end;


Function ExportarVendasAutomatica(pListaDocs:TsbbeTabeladados;pids_Hoteis:string):Boolean;
var
   ObjCabecalhos:TERPBECabecalhos;
   ObjCab:TERPBECab;
   ListaIDSDocs:TstringList;
   i:Integer;
   strsql,strMensagemErros,strdoc,strBDSchema:string;
begin
  Result:=false;

  strBDSchema:=FOBJInterface.BDSchema;
  If FOBJInterface.Namelinkedserver<>'' then
     strBDSchema:= FOBJInterface.Namelinkedserver+'.'+ strBDSchema;

  strMensagemErros:='';
  If Not(pListaDocs.Vazia) then
  begin
        strsql:=  'select xvalue,xsection,mpehotel from '+strBDSchema+'xsetup'
        +' where xsection = ''ERP_Interface'''
        +' and xkey = ''ClienteSaco'''
        +' and mpehotel IN('+pids_Hoteis+')';

        listContasSaco:=sb.SBBD.AbrirLV(strsql);



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
          strdoc:='';
          If assigned(ObjCabecalhos.Elem[i]) then
          Begin
             strdoc:= ObjCabecalhos.Elem[i].typedoc+'/'+ObjCabecalhos.Elem[i].Serie
              +' nº'+IntToStr(ObjCabecalhos.Elem[i].Numero)+' Data '+DateToStr(ObjCabecalhos.Elem[i].Data);
          end;

           If ValidaExportacaoDocumento(ObjCabecalhos.Elem[i],strMensagemErros) then
           begin
              If not(GravaDocvenda(ObjCabecalhos.Elem[i],strMensagemErros)) then
              begin
                 result:=false;
                 SBBD.DesfazTransacao;
                 EnviaEmailErroExporAuto(1, ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO,'Exportação Vendas-PMS',strdoc,strMensagemErros);
                 exit;
              end
           end
           else
           begin
             result:=false;
             SBBD.DesfazTransacao;
             EnviaEmailErroExporAuto(1, ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO,'Exportação Vendas-PMS',strdoc,strMensagemErros);
             exit;
           end;
         end;

         SBBD.TerminaTransacao;
         result:=true;

        Except
                 on E:Exception do
                 begin
                   result:=false;
                   SB.SBBD.DesfazTransacao;
                   strMensagemErros:='Erro ao exportar  Vendas-PMS'+#13+E.Message+strdoc;

                 end;
                 On E:EErroDetalhe Do
                 Begin
                  result:=false;
                   SB.SBBD.DesfazTransacao;
                   strMensagemErros:='Erro ao exportar  Vendas-PMS'+#13+E.Detalhe+strdoc;
                 End
                 else
                 begin
                  result:=false;
                  if  strMensagemErros='' then
                        strMensagemErros:='Erro ao exportar Vendas-PMS';
                  SB.SBBD.DesfazTransacao;
                end;
               EnviaEmailErroExporAuto(1, ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO,'Exportação Vendas-PMS',strdoc,strMensagemErros);
               Freeandnil(ObjCabecalhos);
         end;
       end;
  end;
  If assigned(ObjCabecalhos) then
        Freeandnil(ObjCabecalhos);
end;



Function ExportarAutomatica():Boolean;
var
  Lista:tsbbetabeladados;
  IDSHoteis,Filtro:string;
  Ano, Mes, Dias: Integer;
  data,datainicio:tdatetime;
  ProtelObjInterface,
  SysObjInterface:TERPBEEMPRESAINTERFACE;
  schema:string;
  BDSchemaSys,BDSchemaPms:string;
Begin

 ProtelObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
 Try
 If ProtelObjInterface<>nil then
 begin
     If TestaConexaoBDExterna(ProtelObjInterface.BDConexao) then
     begin


          SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
          IDSHoteis:=DaIDHoteis;//vai buscar ao Protel os hoteis que na tabela do Protel XSEtup, tem interface configurado.
          If IDSHoteis<>'' then
          begin
              filtro:='x.mpehotel IN('+IDSHoteis+')';
              datainicio:= ProtelObjInterface.DATAInicioExportacao;
              BDSchemaSys:=SysObjInterface.BDSchema;
              If  SysObjInterface.Namelinkedserver<>'' then
                  BDSchemaSys:=SysObjInterface.Namelinkedserver+'.'+ BDSchemaSys;
              Lista:=DaListaDocumentosPorExportarNova(Filtro,DataInicio,0,ProtelObjInterface.PrefixoContCblAartigo,BDSchemaSys);
              Try
               If Lista<>nil then
                If Not Lista.vazia then
                If ExportarVendasAutomatica(Lista,IDSHoteis) then
                begin
                     ERPLogOperacoes.RegistaLogOperacao('Operação:Exportação vendas PMS');
                end;

                BDSchemaPms:=  ProtelObjInterface.BDSchema;
                If  ProtelObjInterface.Namelinkedserver<>'' then
                  BDSchemaPms:=ProtelObjInterface.Namelinkedserver+'.'+ BDSchemaPms;

                If ProtelObjInterface.exportaAdiantamentosPMS then
                begin
                  filtro:=' leisthis.mpehotel IN('+IDSHoteis+')';
                  ExportaAdiantamentos(ProtelObjInterface.DataIniExpAdiantamentosPMS,BDSchemaPms,filtro);
                end;
             Finally
               Lista.Fecha;
               freeandnil(Lista);
              end;

               if assigned(ProtelObjInterface) then
                 FreeAndNil(ProtelObjInterface);
               if assigned(SysObjInterface) then
                 FreeAndNil(SysObjInterface);
          end
          else
          begin
             EnviaEmailErroExporAuto(1, 0,'Exportação Vendas-PMS','Problema na configuração do Interface PMS','Falta configurar os Hoteis!');
          end;
      end
      else
      begin
           EnviaEmailErroExporAuto(1, 0,'Exportação Vendas-PMS','Problema Conexão com Base de Dados do Hotel!','');
      end;
 end;
 Finally
  freeandnil(ProtelObjInterface);
 end;


end;







end.
