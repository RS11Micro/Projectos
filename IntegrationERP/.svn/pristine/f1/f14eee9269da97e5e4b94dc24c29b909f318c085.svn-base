unit ERPOperInterfaceFNT;




interface
uses  sbbetabeladados,classes,ERPBECab,ERPBELinhadetalhe,ERPBELinhaPagamento,
dateutils,ERPBEEMPRESAINTERFACE,
ADODB,ERPEnvioEmail;

Function DaListaDocumentosPorExportar(pFiltro:string;pdata,pdataFim:Tdatetime;pPrefixoSys:string):tsbbetabeladados;
Function TemExportacoes(var mensagem:string):Boolean;
Function ExportarVendas(pListaDocs:TsbbeTabeladados):Boolean;
Function ExportarAutomatica():Boolean;

Function TestaConexaoBDExterna(pConexao:string):boolean;
var
FID_cLienteIndiferenciado:string;
FOBJInterface:TERPBEEMPRESAINTERFACE;
implementation
uses ierpOglobais,math,SysUtils,strutils, SBBaseDados, SBBSSistemaBase,
  SBBSUtilSQL,IERPFrmPrincipal, SBBaseDadosADO;

var
 FCONNECTIONSTRING:string;
 FConexao:TADOConnection;

 FQuery :TadoQuery;



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
       Mensagem:='Não existe interface: "ERP_VENDASSYSController" Ativo!';
  end;
end;


Function TemExportacoes(var mensagem:string):Boolean;
var
   Listaex:Tsbbetabeladados;
begin
 mensagem:='';
 result:=false;
 Listaex:=sb.sbbd.abrirlv('select Top 1 id_vndcabdocumento as id_vndcabdocumento from ERP_Cab where origem=2');
 Result:=not (Listaex.vazia);
 Listaex.fecha;
 Freeandnil(Listaex);
end;


Function DAultimoIDVendaExportado():integer;
var Listadad:tsbbetabeladados;
begin
 result:=0;
 Listadad:=sb.sbbd.abrirlv('select Max(id_vndcabdocumento) as id_vndcabdocumento from ERP_Cab  where origem=2');
 If Not(Listadad.vazia) then
 begin
      Result:=Listadad.davalor('id_vndcabdocumento').asinteger;

 end;
 Listadad.fecha;
 Freeandnil(Listadad);

end;


Function DaListaDocumentosPorExportar(pFiltro:string;pdata,pdataFim:Tdatetime;pPrefixoSys:string):tsbbetabeladados;
var
  strsql,strsql1,strsql2,mprefixoProdutos:string;
  mensagemerro:string;
  ID_UltVndcabdocumentoExportado:Integer;
  DescSchema:string;
begin
 result:=nil;
ID_UltVndcabdocumentoExportado:=0;
If ValidaExportacao(mensagemerro) then
begin
  ID_UltVndcabdocumentoExportado:=DAultimoIDVendaExportado;

  strsql:='select Vndcabdocumento.id_centroexploracao, Vndcabdocumento.id_vndcabdocumento,Vndcabdocumento.id_documento,Vndcabdocumento.data,Vndcabdocumento.AbrevDoc as TipoDoc,'
  +' Vndcabdocumento.AbrevSerie as Serie,Vndcabdocumento.valortotal,Vndcabdocumento.id_entidade'
  +', Vndcabdocumento.nomeentidade+'' '' + Vndcabdocumento.apelidoEntidade as NomeCliente,'
  +' Vndcabdocumento.contribuinteEntidade,Vndcabdocumento.MoradaEntidade,Vndcabdocumento.CodigoPostalEntidade,'
  +' Vndcabdocumento.RuaEntidade, Vndcabdocumento.LocalidadeEntidade, Vndcabdocumento.VersaoChaveRSA,'
  +' Vndcabdocumento.Certificado,Vndcabdocumento.Hash,Vndcabdocumento.anulado,'
  +' VndLinhadocumento.ID_Linha,VndLinhadocumento.DescricaoProduto,VndLinhadocumento.percentagemIVA,VndLinhadocumento.valoriva,VndLinhadocumento.tipoMovimento,'
  +' VndLinhadocumento.ID_ModoPagamento,VndLinhadocumento.ValorUnitario, '
  +' VndLinhadocumento.quantidade,VndLinhadocumento.PerDesconto,VndLinhadocumento.valor,'
  +' Tab_Produto.contaCbl as ContaCBLProd,'
  +'  tab_Iva.contaCbl as contaCblIVA,Tab_cliente.ContaCBL as ContaCBLCliente'
  +' ,TipoDocVnd.ContaERP as ContaCBLTDOC,tab_metodopag.ContaCBL as ContaCBLPAG'
  +', TipoDocVnd.TipoOperacao,tab_iva.taxexceptionReason as CodIsencao, VndLinhadocumento.id_Produto'
  +' , Vndcabdocumento.valorIVA as TOTALIVA,VndLinhadocumento.TipoArtigoERP'
  +', CodUnvenda,UniVenda,CodUnBase,UniBase,factorconversao,ERP_AreaNegocio.ContaERP as AreaNegocio'
  +', ERP_AreaNegocio.DescricaoArea as DescAreaNegocio,'
  +' TAB_SubFam.VCodSubFam as ID_SubFamilia,TAB_SubFam.vdesc as SubFamilia,'
  +' TAB_Familia.VCodFam as ID_Familia,TAB_Familia.vdesc as Familia,'
  +' Tab_GrFamiliar.vCodGrFam as ID_GrupoFamilia,Tab_GrFamiliar.vdesc as GrupoFamilia'
  +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'
  +', VndLinhadocumento.ID_GrupoServico,tipodocvnd.InvoiceType '
  +', tab_iva.TaxCode,Tab_iva.TaxCountryRegion '

  +' From VndcabDocumento '
  +' inner join  tab_cliente  on tab_cliente.vnume'

  +' =VndcabDocumento.ID_Entidade'
  +' left join  tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
  +' inner join  VndLinhaDocumento  on VndLinhaDocumento.id_vndcabdocumento=VndcabDocumento.id_vndcabdocumento'
  +' left join  TAB_PRODUTO  on TAB_PRODUTO.VPRODUTO =VndLinhaDocumento.ID_Produto'
  +  ' left JOIN TAB_SubFam ON  '
  +  ' TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
  +  ' left JOIN TAB_Familia  ON '
  +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
  +  ' left JOIN Tab_GrFamiliar  ON '
  +  ' TAB_Familia.VCodGrFam= Tab_GrFamiliar.VCodGrFam '

  +' inner join  Tipodocvnd  on Tipodocvnd.id_TipodocVnd=VndcabDocumento.id_Tipodocvnd'
  +' left join  tab_iva  on tab_iva.vcodi=VndLinhadocumento.id_iva'
  +' left join  tab_metodopag  on tab_metodopag.VCODPAG=VndLinhadocumento.ID_ModoPagamento'
  +' left join  V_ERPInterfaceProdUnidade  on V_ERPInterfaceProdUnidade.ID_Produto=VndLinhaDocumento.ID_Produto'
  +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioCPrecosFNT '
  +' on  '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocioCPrecosFNT.ID_ClassePrecos=VndLinhaDocumento.id_classe'

  +' left join '+sb.SBBD.NomeBD+'.dbo.ERP_AreaNegocio '
  +' on  ERP_AreaNegocio.ID_AreaNegocio=ERP_AreaNegocioCPrecosFNT.ID_AreaNegocio'




  +' where   isnull(Tipodocvnd.contaERP,'''')<>'+sb.UtilSQL.StrToSQLStrpelica('');


  If  ( pdata>0) and  (pdatafim >0) then
  begin
      strsql:=strsql+' and Vndcabdocumento.data>='+sb.UtilSQL.DataToSQLData(pdata)
      +' and Vndcabdocumento.data<='+sb.UtilSQL.DataToSQLData(pdatafim);
  end
  else
  begin
      If ID_UltVndcabdocumentoExportado>0 then
      Begin
       strsql:=strsql+' and Vndcabdocumento.id_Vndcabdocumento>'+Inttostr(ID_UltVndcabdocumentoExportado);
      End
      Else
      Begin
       If  pdata>0 then
           strsql:=strsql+' and Vndcabdocumento.data>='+sb.UtilSQL.DataToSQLData(pdata);
      end;
   end;

  If pFiltro<>'' then
      strsql:=strsql+' and '+ pFiltro;
  strsql:=strsql+' order by Vndcabdocumento.id_Vndcabdocumento,VndLinhaDocumento.tipomovimento,'
            +' VndLinhaDocumento.id_Linha';
  Result:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,strsql);
end;
end;





Function DalistaIDDocs(pListaDocs:TsbbeTabeladados):TstringList;
begin
     Result:=TstringList.create;
     pListaDocs.inicio;
     While Not(pListaDocs.NoFim)do
     begin
        If Result.IndexOf(pListaDocs.davalor('ID_vndcabdocumento').asstring)=-1 then
            Result.Add(pListaDocs.davalor('ID_vndcabdocumento').asstring);
        pListaDocs.seguinte;
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

Function PreencheOBJDoc(pListaDocs:TsbbeTabeladados;pid_vndcabdocumento:Integer):TERPBECab;
var
    ObjLinha:TERPBELinha;
    ObjLinhaPagamento:TERPBELinhaPagamento;
   SysObjInterface:TERPBEEMPRESAINTERFACE;

begin
   SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');

  pListaDocs.dataset.filtered:=false;
  pListaDocs.dataset.filter:='ID_VNDCABDocumento='+Inttostr(pid_vndcabdocumento);
  pListaDocs.dataset.filtered:=true;
  If  Not pListaDocs.Vazia then
  begin
    Result:=TERPBECab.Create;
    Result.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('id_vndcabdocumento').asinteger;
    Result.TOTALIVA:= pListaDocs.davalor('TOTALIVA').asfloat;


    Result.mpeHotel:= pListaDocs.davalor('ID_CentroExploracao').asinteger;
    Result.Numero:= pListaDocs.davalor('id_documento').asinteger;
    Result.serie:= pListaDocs.davalor('serie').asstring;
    Result.typedoc:= pListaDocs.davalor('ContaCBLTDOC').asstring;
    Result.Data:= pListaDocs.davalor('Data').asdatetime;
    Result.DataVenc:= pListaDocs.davalor('Data').asdatetime;
    Result.IDCliente:= pListaDocs.davalor('id_entidade').asinteger;
    //aqui tenho de testar se não tem tem de por do InterfaceIMC
    Result.Nrcliente:= pListaDocs.davalor('ContaCBLCliente').asstring;

    If  pListaDocs.davalor('ContaCBLCliente').asstring='' then
         Result.Nrcliente:=FOBJInterface.ID_clienteIndiferenciado;

    Result.TotalBruto:= pListaDocs.davalor('ValorTotal').asFloat;
    Result.Status:= 'N';
    If pListaDocs.davalor('Anulado').asBoolean=true then
        Result.Status:= 'A';
    Result.Assinatura:= pListaDocs.davalor('Hash').asstring;
    Result.chave:= pListaDocs.davalor('Certificado').asstring+'.'+pListaDocs.davalor('VersaoChaveRSA').asstring;
    Result.Nome:= pListaDocs.davalor('NomeCliente').asstring;
    Result.Morada:= pListaDocs.davalor('MoradaEntidade').asstring;
    Result.CodPostal:= pListaDocs.davalor('CodigoPostalEntidade').asstring
    +' '+ pListaDocs.davalor('RuaEntidade').asstring;
    Result.localidade:= pListaDocs.davalor('localidadeEntidade').asstring;
    Result.NIF:= pListaDocs.davalor('ContribuinteEntidade').asstring;
    Result.TotalPago:=pListaDocs.davalor('ValorTotal').asFloat;
    Result.Integrado:=False;
    Result.Origem:=SysObjInterface.Origem;
    Result.DataHoraRegisto:=now;
    Result.TotalLinhas:=pListaDocs.NumLinhas;
    Result.UtilizadorRegisto:=Sb.UtilizadorActual.Login;

    Result.CodPais:= pListaDocs.davalor('PaisISO').asstring;
    Result.DescPais:= pListaDocs.davalor('DescPais').asstring;
    Result.mercado:= pListaDocs.davalor('Mercado').asinteger;
    Result.DescMercado:=DadescMercado(Result.mercado);

    Result.Invoicetype:=pListaDocs.davalor('Invoicetype').asstring;


    If Result.TypeDoc='' then
        Result.ComERROSConfig:=true;
    While Not (pListaDocs.NoFim) do
    begin
      if  pListaDocs.daValor('TipoMovimento').asinteger=0 then
      begin
         ObjLinha:=TERPBELinha.create;
         With ObjLinha do
         begin
            ObjLinha.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('id_vndcabdocumento').asinteger;
            ObjLinha.Numero:= pListaDocs.davalor('id_documento').asinteger;
            ObjLinha.serie:= pListaDocs.davalor('serie').asstring;
            ObjLinha.ID_Linha:= pListaDocs.davalor('ID_Linha').asinteger;
            ObjLinha.id_ProdutoOrigem:= pListaDocs.davalor('id_Produto').asinteger;
            ObjLinha.Data:= pListaDocs.davalor('data').asdatetime;
             ObjLinha.servico:= pListaDocs.davalor('ContaCblprod').asstring;
            ObjLinha.Descritivo:= pListaDocs.davalor('DescricaoProduto').asstring;
            ObjLinha.qnt:= pListaDocs.davalor('quantidade').asfloat;
            ObjLinha.precounit:= pListaDocs.davalor('valorunitario').asfloat;
            ObjLinha.codiva:= pListaDocs.davalor('ContaCBlIVA').asstring;
            ObjLinha.TipoArtigo:= pListaDocs.davalor('TipoArtigoERP').asstring;
            ObjLinha.ValorIVA:= pListaDocs.davalor('valoriva').asfloat;

            ObjLinha.taxaiva:= pListaDocs.davalor('percentagemIVA').asFloat;
            ObjLinha.total:= pListaDocs.davalor('valor').asFloat;
            ObjLinha.Armazem:= '';
            ObjLinha.CodIsencao:= pListaDocs.davalor('CodIsencao').asstring;               
            ObjLinha.Descontoperc:= pListaDocs.davalor('perDesconto').asFloat;


            ObjLinha.CODIGOUNIDADEBASE:= pListaDocs.davalor('CodUnBase').asstring;
            ObjLinha.CODIGOUNIDADEVENDA:= pListaDocs.davalor('CodUnvenda').asstring;
            ObjLinha.DESCRICAOUNIDADEVENDA:= pListaDocs.davalor('UniVenda').asstring;
            ObjLinha.DESCRICAOUNIDADEBASE:= pListaDocs.davalor('UniBase').asstring;
            ObjLinha.FATORCONVERSAO:= pListaDocs.davalor('factorconversao').asfloat;
            ObjLinha.AreaNegocio:= pListaDocs.davalor('AreaNegocio').asstring;
            ObjLinha.DescAreaNegocio:= pListaDocs.davalor('DescAreaNegocio').asstring;


            //13-11-2019 Sr.Pedro Pinheiro falou com o eng.Paulo fernandes e transmitiu me para concatenar a origem com hieraquia de Produtos
            //origem 2 neste caso pois trata-se de fontenario
            ObjLinha.ID_GrupoProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_GrupoFamilia').asstring);
            ObjLinha.GrupoProduto:= pListaDocs.davalor('GrupoFamilia').asstring;


            ObjLinha.ID_FamiliaProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_Familia').asstring);
            ObjLinha.FamiliaProduto:= pListaDocs.davalor('Familia').asstring;

            ObjLinha.ID_SubFamiliaProduto:= Strtoint(Inttostr(Result.Origem)+pListaDocs.davalor('ID_SubFamilia').asstring);
            ObjLinha.SubFamiliaProduto:= pListaDocs.davalor('SubFamilia').asstring;
            ObjLinha.ID_GrupoServico:= pListaDocs.davalor('ID_GrupoServico').asstring;
            ObjLinha.TaxCode:= pListaDocs.davalor('TaxCode').asstring;
            ObjLinha.TaxCountryRegion:= pListaDocs.davalor('TaxCountryRegion').asstring;





            ObjLinha.Origem:=  Result.Origem;
            If  ObjLinha.servico='' then
                Result.ComERROSConfig:=true;


            Result.Linhas.Adiciona(ObjLinha);
//            DescontoValor:extended;

          end;
      end
      else
      if  pListaDocs.daValor('TipoMovimento').asinteger=1 then
      begin
            ObjLinhaPagamento:=TERPBELinhaPagamento.create;

            ObjLinhaPagamento.ID_VNDCABDOCUMENTO:= pListaDocs.davalor('id_vndcabdocumento').asinteger;
            ObjLinhaPagamento.ID_Linha:= pListaDocs.davalor('ID_Linha').asinteger;
            ObjLinhaPagamento.ID_ModoPagamento:= pListaDocs.davalor('ID_ModoPagamento').asInteger;
            ObjLinhaPagamento.ID_Linha:= pListaDocs.davalor('ID_Linha').asinteger;
            ObjLinhaPagamento.ContaERP:= pListaDocs.davalor('ContaCBLPag').asstring;
            ObjLinhaPagamento.descricao:= pListaDocs.davalor('DescricaoProduto').asstring;
            ObjLinhaPagamento.Valor:= pListaDocs.davalor('valor').asFloat;
            ObjLinhaPagamento.DataMovimento := pListaDocs.davalor('data').asdatetime;
            If ObjLinhaPagamento.ContaERP='' then
                Result.ComERROSConfig:=true;

            Result.Pagamentos.Adiciona( ObjLinhaPagamento);
      end;

      pListaDocs.seguinte;

    end;
  end;
  if assigned(SysObjInterface) then
    FreeAndNil(SysObjInterface);
end;





Function ValidaExportacaoDocumento(ObjCab:TERPBECab;var mensagem:string):Boolean;
var
 i:integer;
 ListaD:Tsbbetabeladados;

begin

  result:=true;
  mensagem:='';
  If FOBJInterface.ObgContaERPCliente then
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

      If  (ObjCab.Linhas.elem[i].TipoArtigo='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Tipo Artigo do Produto:'+ ObjCab.Linhas.elem[i].Descritivo;

      If  FOBJInterface.ObgLinhaContaERPAreaNeg=true then
        If  (ObjCab.Linhas.elem[i].areanegocio='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP Area de Negócio:'+ ObjCab.Linhas.elem[i].Descritivo;


  end;
   If   FOBJInterface.ObgLinhaContaERPModPag=true then
   begin
      For i:=0 to  ObjCab.Pagamentos.Num-1 do
      begin
          If  (ObjCab.Pagamentos.elem[i].ContaERP='') then
              mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta ERP do Pagamento:'+ ObjCab.Pagamentos.elem[i].Descricao;
      end;
  end;
  If mensagem<>'' then
  begin
   mensagem:='Documento nº'+Inttostr(ObjCab.Numero)+' '+ObjCab.typedoc+#13+mensagem;
   result:=false;
  end;
  If Result then
  begin

          ListaD:=sb.SBBD.AbrirLV('select id_vndcabdocumento from ERP_Cab  where origem='+INTTOSTR(FOBJInterface.Origem)
          +' and id_vndcabdocumento='+Inttostr(ObjCab.ID_VNDCABDOCUMENTO));

          If Not(ListaD.vazia) then
          begin
            mensagem:='Documento nº'+Inttostr(ObjCab.Numero)+' '+ObjCab.typedoc+#13+'Documento já foi exportado!';
            Result:=False;
          end;
          ListaD.fecha;


  end;


end;




Procedure InsereLinha(ObjLinha:TERPBELinha);
var
 stsql:string;
 i:integer;
begin
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
          +',CODIGOUNIDADEBASE  '
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
          +',ValorIva'
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
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.Descritivo)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.qnt)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.precounit,'0.0000')
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

           +','+ sb.UtilSQL.DecimalToSQLStr(ObjLinha.valoriva)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.ID_GrupoServico)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.taxcode)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjLinha.TaxCountryRegion)

          +')';
          sb.SBBD.Executa(stsql);

   end;
end;


Procedure InsereLinhaPagamento(ObjPagamento:TERPBELinhaPagamento);
var
 stsql:string;
 i:integer;
begin
//[mpehotel]
//   +',datainv'
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
            +',DataMovimento'
           + ',Valor)'
          +' values( '
            + IntToStr(ObjPagamento.ID_internoDoc)
           +','+ IntToStr(ObjPagamento.ID_VNDCABDOCUMENTO)
           +','+ IntToStr(ObjPagamento.ID_Linha)
           +','+ IntToStr(ObjPagamento.ID_ModoPagamento)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjPagamento.ContaERP)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjPagamento.Descricao)
          +','+ sb.UtilSQL.DataToSQLData(ObjPagamento.DataMovimento)
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjPagamento.Valor)
           +')';
          sb.SBBD.Executa(stsql);
   end;
end;

Procedure GravaDocvenda(ObjCab:TERPBECab);
var
 stsql:widestring;
 i:integer;
 ProximoID_InternoDoc:integer;
begin

 ProximoID_InternoDoc:=sb.ProximoID('ERP_CAB',true);

  With ObjCab do
  Begin
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
           +',TOTALIVA'
           +',Origem'
           +',DataHoraRegisto'
           +',ID_VNDCABDOCUMENTO'
           +',TotalLinhas'
           +',UtilizadorRegisto,integrado'
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
           +','+ sb.UtilSQL.DecimalToSQLStr(ObjCab.TOTALIVA)
           +','+ IntToStr(ObjCab.Origem)
           +','+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.DataHoraRegisto)
           +','+ IntToStr(ObjCab.ID_VNDCABDOCUMENTO)
           +','+ IntToStr(ObjCab.TotalLinhas)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.UtilizadorRegisto)
           +','+ sb.UtilSQL.BoolToSQLStr(false)
          +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodPais)
          +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.DescPais)
          +','+ IntToStr(ObjCab.Mercado)
          +','+ sb.UtilSQL.StrToSQLStrpelica(DescMercado)
          +','+ sb.UtilSQL.StrToSQLStrpelica(Invoicetype)
           +')';
          sb.SBBD.Executa(stsql);

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

Function ExportarVendas(pListaDocs:TsbbeTabeladados):Boolean;
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
               GravaDocvenda(ObjCabecalhos.Elem[i])
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

Function ExportarVendasAutomatica(pListaDocs:TsbbeTabeladados):Boolean;
var
   ObjCabecalhos:TERPBECabecalhos;
   ObjCab:TERPBECab;
   ListaIDSDocs:TstringList;
   i:Integer;

   strsql,strMensagemErros,DescTipoDoc:string;

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
           If ValidaExportacaoDocumento(ObjCabecalhos.Elem[i],strMensagemErros) then
               GravaDocvenda(ObjCabecalhos.Elem[i])
           Else
           Begin
             SBBD.DesfazTransacao;
             DescTipoDoc:= ObjCabecalhos.Elem[i].typedoc+'/'+ObjCabecalhos.Elem[i].Serie
              +' nº'+IntToStr(ObjCabecalhos.Elem[i].Numero)+' Data '+DateToStr(ObjCabecalhos.Elem[i].Data);
             EnviaEmailErroExporAuto(2, ObjCabecalhos.Elem[i].ID_VNDCABDOCUMENTO,'Exportação Vendas-Syscontroller',DescTipoDoc,strMensagemErros);

             Result:=false;
             exit;
           End;
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


Function ExportarAutomatica():Boolean;
var
  Lista:tsbbetabeladados;
  Filtro:string;
  Ano, Mes, Dias: Integer;
  data,datainicio:tdatetime;
Begin
 If TestaConexaoBDExterna(FOBJInterface.BDConexao) then
 begin
  datainicio:= FOBJInterface.DATAInicioExportacao;
  If FOBJInterface.IDSCentrosExploracao<>'' then
          Filtro:='Vndcabdocumento.id_centroExploracao in('+FOBJInterface.IDSCentrosExploracao+')';
  Lista:=DaListaDocumentosPorExportar(Filtro,DataInicio,0,FOBJInterface.PrefixoContCblAartigo);
  Try
    If Lista<>nil then
    begin
      If Not Lista.Vazia then
      begin
        ExportarVendasAutomatica(Lista)
      end;
    end;
  Finally
   Lista.Fecha;
   freeandnil(Lista);
  end;
 end
 Else
 EnviaEmailErroExporAuto(2, 0,'Exportação Vendas-Syscontroller','Exportação automática','Não foi possivel Conectar á Base de dados Sycontroller');

end;





end.
