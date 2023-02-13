unit PMSIntfPrimaveraCBL0900;


interface

Uses FntBEEntidadeBase,SBBEObjAbs,SBBEListaObjAbs,SBBETabelaDados,FNTBETipoCons,
SBBEConsTipos,SBBEMapa,dialogs,Sysutils,ERPBEEMPRESAINTERFACE,ERPBECBLCab,ADODB
,ERPBECBLLinhaDetalhe,ERPEnvioEmail,SBBEExcepcoes,Forms,classes;


 Procedure PreencheVariavaisConfGerais;
 Function ExportarVendasAutomatico():Boolean;
 Function ExportarVendasManual(pListaDocs:TsbbeTabeladados; ListaErros:tstringList):Boolean;

 Function ValidaExportacao(var Mensagem:String):Boolean;
 function CriaEstruturaVendasPrimavera:string;
 function CriaEstruturaVendasProtel:string;
 function DaIdsTipodocumento():string;
 Function PreparaParametrosExportacao():Boolean;
 Procedure  InsereLinhaAgrupadaValorDoIVA(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
 Procedure  InsereLinhaAgrupadaValorSemIVA(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);

 Procedure  InsereLinhaAgrupadaCentroCusto(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
 Procedure  InsereLinhaAgrupadaContaAnalitica(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
 Procedure  InsereLinhaPagamento(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
 Function  PreencheTabelaTemporaria(pData:Tdatetime;pStrIDDoumentos:string;pFiltroDocs:string):string;
 function  daListaDocumentosPorexportar(pFiltroDocs:string;var strsql:string):Tsbbetabeladados;
 Function  DAultimoDataVendaExportado(porigem:integer):tdatetime;
 
Function DaIDHoteis():string;
 var
    FIDInterface:integer;
    FDataInicioExp,
    FdataFimExp:Tdatetime;
    FCONNECTIONSTRING:string;
    FConexao:TADOConnection;

    FQuery :TadoQuery;
    FID_cLienteIndiferenciado:string;
    FOBJInterface:TERPBEEMPRESAINTERFACE;

    FIDSHoteis:string;
    FLISTADocumentos:Tsbbetabeladados;
    FNaoInterrompeExportaOqueconsegue:Boolean;



implementation




Uses Variants,IERPOGLobais,StrUtils, DateUtils, SBBSSistemaBase,
  SBBaseDados,UgeralFunc, SBBSUtilSQL, ERPBSEMPRESAINTERFACE;

var
  FContadorLote,
    FEnviaLinhaIva,
  FOmitirLinhaIVA0perc,
  FOmitirValoresZero:Boolean;
  FRefleteClasseIva,

  FReflecteFluxos,
  FRefleteAnalitica,
  FRefleteCentroCusto,
  FDiario,
  FTipoAfetacao:string;
  FcaminhoFicheiro,
  FModulo:string;
  ID_Pagamentocc:integer;
  FNumCasaDecimaisVL:integer;
  FVendasProtel,FVendasPrimavera:string;
  FFormatDecimalSQl:string;
  FShemaProtel:string;
  FContasIVASPorMercado:boolean;
  FperiodoIVA:Integer;
  FClienteTabMETADATA:boolean;
  FExcluirDocsVndAnulados:boolean;
  FListaContasMercado:TSBBETabelaDados;



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
function CriaEstruturaVendasProtel:string;
Var
  SQL :String;
Begin
  SQL := 'CREATE TABLE [%s] ( '

+'[ID_Documento] [int] NOT NULL,'
+'[ID_TipoDocumento] [int] NULL,'

+'[ValorLiquido] [float] NULL,'
+'[ID_ContaLanc] [varchar](10) NOT NULL,'
+'[ID_CodigoCliente] [int] NULL,'
+'[ID_Iva] [int] NULL,'
+'[ID_GrpContaLanc] [int] NULL,'
+'[DataDoc] [datetime] NULL,'
+'[Datavencimento] [datetime] NULL,'
+'[Valor] [float] NULL,'
+'[TaxaIVA] [float] NULL,'

+'[ValorIva] [float] NULL,'
+'[DescricaoArtigo] [varchar](200) NULL,'
+'[DescricaoTipoDoc] [varchar](200) NULL,'
+'[DescricaoArmazem] [varchar](200) NULL,'
+'[DescricaoIva] [varchar](200) NULL,'
+'[descricaodoc] [varchar](200) NULL,'
+'[NomeCliente] [varchar](200) NULL,'
+'[TipoMovimento] [varchar](1) NULL,'
+'[id_ModoPagamento] [int] NULL,'
+'[ContaCBLCliente] [nvarchar](20) NULL,'
+'[HoraDoc] [datetime] NULL,'
+'[id_internodoc] [int] NULL,'
+'[ClasseIva] [varchar](10) NULL,'
+'[ID_Lote] [int] NULL,'
+'[ID_Hotel] [int] NULL,'
+'[Ncontribuinte] [nvarchar](20) NULL,'
+'[abrevserie] [varchar](2) NULL,'
+'[serieERP] [varchar](1) NULL,'
+'[Mercado] [int] NOT NULL,'
+'[ContaAdiantamento] [bit] not NULL default 0,'
+'[TipoLinha] [varchar](1)  NULL,'
+'[DocTotalZERO] [bit] NOT NULL default 0,'
+'[TipoLinhaFich] [varchar](1)  NULL,'
+'[ContaCCusto] [varchar](20) NULL,'

+'[Morada] [varchar](255) NULL,'
+'[Localidade] [varchar](255) NULL,'
+'[CodigoPostal] [varchar](255) NULL,'
+'[Telefone] [varchar](255) NULL,'
+'[NCForaPerIVA] [bit] NOT NULL default 0,'


+'[ContaAnalitica] [varchar](20) NULL)';

  result:=SB.TabelasTemporias.Cria('VendasProtel',SQL);
End;




function CriaEstruturaVendasPrimavera:string;
Var
  SQL :String;
Begin
  SQL := 'CREATE TABLE [%s] ( '

	+'[ID_Documento] [int] NOT NULL,'
	+'[ID_TipoDocumento] [int] NULL,'
	+'[DescricaoTipoDoc] [varchar](200) NULL,'
	+'[Descricaodoc] [varchar](200) NULL,'

	+'[SerieDoc] [varchar](200) NULL,'
	+'[TipoLinha] [int] NULL,'
	+'[Valor] [float] NULL,'
	+'[ContaCBLFamilia] [varchar](200) NULL,'
	+'[ContaCBLIVA] [varchar](200) NULL,'
	+'[ContaCBLPAG] [varchar](200) NULL,'
	+'[ContaCBLTipoDOC] [varchar](200) NULL,'
	+'[ID_CodigoCliente] [int] NULL,'
	+'[DataDoc] [datetime] NULL,'
	+'[DescricaoLinha] [varchar](200) NULL,'
	+'[IVA] [varchar](200) NULL,'
        +'[TaxaIVA] [float] NULL,'
	+'[NomeCliente] [varchar](200) NULL,'
	+'[TipoMovimento] [varchar](1) NULL,'
	+'[Natureza] [varchar](200) NULL,'
	+'[id_ModoPagamento] [int] NULL,'
	+'[ContaCBLCliente] [nvarchar](20) NULL,'
	+'[HoraDoc] [datetime] NULL,'
	+'[id_internodoc] [int] NULL,'
	+'[ClasseIva] [varchar](10) NULL,'
	+'[ID_Lote] [int] NULL,'
	+'[ID_Hotel] [int] NULL,'
	+'[Ncontribuinte] [nvarchar](20) NULL,'
	+'[ordemFich] [int]  NULL,'
	+'[abrevserie] [varchar](2) NULL,'
	+'[DescricaoMovimento] [varchar](50) NULL,'
	+'[serieERP] [varchar](1) NULL,'
	+'[Mercado] [int]not   NULL default 1,'
	+'[ValorLinha] [float]  NULL,'
	+'[ContaAdiantamento] [bit]  NULL default 0,'
	+'[DocTotalZERO] [bit] NOT NULL default 0,'
	+'[TipoLinhaFich] [varchar](1)  NULL,'
	+'[ContaCCusto] [varchar](20) NULL,'
        +'[ordem] [int]not   NULL default 0,'
        +'[Nome] [varchar](255) NULL,'
        +'[Morada] [varchar](255) NULL,'
        +'[Localidade] [varchar](255) NULL,'
        +'[CodigoPostal] [varchar](255) NULL,'
        +'[Telefone] [varchar](255) NULL,'

        +'[NCForaPerIVA] [bit] NOT NULL default 0,'
	+'[ContaAnalitica] [varchar](20) NULL)';

  result:=SB.TabelasTemporias.Cria('VendasPrimavera',SQL);
end;




function DaIdsTipodocumento():string;
var
   Lista:TSBBETabeladados;
   strsql:string;
begin
  result:='';
  strsql:='select Pms_ID_TipoDoc  from CBL_TipoDocPMS';
  Lista:=sb.SBBD.AbrirLV(strsql);
  try
    while not (Lista.NoFim)do
    begin
     Result := Result + IfThen(Result = '', '', ',') + Lista.davalor('Pms_ID_TipoDoc').asString;
     Lista.seguinte;
    end;
  Finally
    Lista.Free;
  end;
  If Length(Result)>0 then
    Result:='('+Result+')';
end;




Procedure  InsereLinhaAgrupadaCentroCusto(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
var
    strsql:string;
    descricaoDoc:string;
    Natureza:string;
    ContaCBLFamilia,ContaCBLIVA,ContaCCusto,ClasseIVA:string;
    segue:Boolean;
begin
 segue:=true;
 If FOmitirValoresZero then
   segue:= ListaVndProtel.daValor('valorliquido').asfloat<>0;

 If segue then
 begin
       ContaCBLFamilia:= ListaVndProtel.daValor('ContaCBLFAmilia').asstring;
       ContaCBLIVA:= ListaVndProtel.daValor('ContaCBLIVA').asstring;
       ClasseIVA:= ListaVndProtel.daValor('ClasseIVA').asstring;
       ContaCCusto:= ListaVndProtel.daValor('ContaCCusto').asstring;

       If ListaVndProtel.daValor('NcForaPerIVA').asBoolean=true then
       begin
              ContaCBLFamilia:= ListaVndProtel.daValor('ContaCBLFamiliaNCperIVAdifFACT').asstring;
              ContaCBLIVA:= ListaVndProtel.daValor('ContaCBLIVANCperIVAdifFACT').asstring;
              ClasseIVA:= ListaVndProtel.daValor('ClasseIVANCperIVAdifFACT').asstring;
              ContaCCusto:= ListaVndProtel.daValor('ContaCCustoNCperIVAdifFACT').asstring;

       end;

       If  ListaVndProtel.daValor('Valorliquido').asFloat>=0 then
         Natureza:= ListaVndProtel.daValor('Natureza').asstring
       else
          Natureza:= ListaVndProtel.daValor('NaturezaNeg').asstring;


      strsql:=' INSERT INTO '+FVendasPrimavera
               +'  (ID_lote,'
               +' ID_InternoDoc,'
               +' [ID_Documento]'
               +'  ,[ID_TipoDocumento]'
               +' ,[DescricaoTipoDoc]'
               +' ,[DescricaoDoc]'
               +' ,[SerieDoc]  '
               +' ,[TipoLinha]'
               +' ,[Valor]'
               +' ,[ContaCBLFamilia]'
               +' ,[ContaCCusto]'
               +' ,[ContaCBLIVA],ClasseIVA'
               +' ,[ContaCBLPag]'
               +' ,[ContaCBLTipoDoc]'
               +' ,[ID_CodigoCliente]'
               +' ,[DataDoc]'
               +' ,[DescricaoLinha],IVA,natureza,tipoMovimento,nomecliente,'
               +' id_ModoPagamento,ContaCblCliente,ID_Hotel,Ncontribuinte,Mercado,valorLinha,DocTotalZERO,TipoLinhaFich,ordem,'
               +' Nome,Morada,Localidade,CodigoPostal,Telefone)'


               +' VALUES ('
               + IntTostr(ID_Lote)+','
               + IntTostr(ListaVndProtel.daValor('ID_InternoDoc').asinteger)+','
               + IntTostr(ListaVndProtel.daValor('ID_documento').asinteger)
               +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
               +','+#39+ListaVndProtel.daValor('DescTipodoc').asstring+#39
               +','+#39+ListaVndProtel.daValor('DescricaoDoc').asstring+#39
               +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
               +','+ IntTostr(0)
               +','+  floattostr(ListaVndProtel.daValor('Valorliquido').asFloat)

               +','+#39+ContaCBLFAmilia+#39
               +','+#39+ContaCCusto+#39
               +','+#39+ContaCBLIVA+#39
               +','+#39+ClasseIVA+#39
               +','' '''
               +','+#39+ListaVndProtel.daValor('ContaCblTipoDocumento').asstring+#39
               +','+ IntTostr(ListaVndProtel.daValor('ID_CodigoCliente').asinteger)
               +','+  SB.UtilSQL.DataToSQLData(ListaVndProtel.daValor('DataDoc').asdatetime)


               +','+#39+ListaVndProtel.daValor('Descricaoartigo').asstring+#39
              +','+#39+ListaVndProtel.daValor('DescricaoIVA').asstring+#39
              +','+#39+Natureza+#39
             +','+#39+ListaVndProtel.daValor('tipoMovimento').asstring+#39
              +','+#39+ListaVndProtel.daValor('nomecliente').asstring+#39
               +','+ IntTostr(ListaVndProtel.daValor('id_ModoPagamento').asinteger)
              +','+#39+ListaVndProtel.daValor('ContaCblCliente').asstring+#39
               +','+ IntTostr(ListaVndProtel.daValor('id_hotel').asinteger)
              +','+#39+ ListaVndProtel.daValor('Ncontribuinte').asstring+#39
              +','+#39+ ListaVndProtel.daValor('Mercado').asstring+#39
              +','+ sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('Valorliquido').asFloat,FFormatDecimalSQl)
              +','+ sb.UtilSQL.BoolToSQLStr(ListaVndProtel.daValor('DocTotalZERO').asBoolean)
              +','+#39+'O'+#39
              +','+inttostr(pordem)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Nomecliente').asstring)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Morada').asstring)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Localidade').asstring)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('codigoPostal').asstring)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('telefone').asstring)
               +')';

      sb.SBBD.Executa(strsql);
 end;
end;



Procedure  InsereLinhaAgrupadaContaAnalitica(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
var
strsql:string;
descricaoDoc:string;
Natureza:string;
ContaCBLFamilia,ContaCBLIVA,ContaCCusto,ClasseIVA,ContaAnalitica:string;
    segue:Boolean;
begin
 segue:=true;
 If FOmitirValoresZero then
   segue:= ListaVndProtel.daValor('valorliquido').asfloat<>0;

 If segue then
 begin

     ContaCBLFamilia:= ListaVndProtel.daValor('ContaCBLFAmilia').asstring;
     ContaCBLIVA:= ListaVndProtel.daValor('ContaCBLIVA').asstring;
     ClasseIVA:= ListaVndProtel.daValor('ClasseIVA').asstring;
     ContaCCusto:= ListaVndProtel.daValor('ContaCCusto').asstring;
     ContaAnalitica:= ListaVndProtel.daValor('ContaAnalitica').asstring;

     If ListaVndProtel.daValor('NcForaPerIVA').asBoolean=true then
     begin
            ContaCBLFamilia:= ListaVndProtel.daValor('ContaCBLFamiliaNCperIVAdifFACT').asstring;
            ContaCBLIVA:= ListaVndProtel.daValor('ContaCBLIVANCperIVAdifFACT').asstring;
            ClasseIVA:= ListaVndProtel.daValor('ClasseIVANCperIVAdifFACT').asstring;
            ContaCCusto:= ListaVndProtel.daValor('ContaCCustoNCperIVAdifFACT').asstring;
            ContaAnalitica:= ListaVndProtel.daValor('ContaAnaliticaNCperIVAdifFACT').asstring;
     end;

     If  ListaVndProtel.daValor('Valorliquido').asFloat>=0 then
       Natureza:= ListaVndProtel.daValor('Natureza').asstring
     else
        Natureza:= ListaVndProtel.daValor('NaturezaNeg').asstring;


    strsql:=' INSERT INTO '+FVendasPrimavera
             +'  (ID_lote,'
             +' ID_InternoDoc,'
             +' [ID_Documento]'
             +'  ,[ID_TipoDocumento]'
             +' ,[DescricaoTipoDoc]'
             +' ,[DescricaoDoc]'
             +' ,[SerieDoc]  '
             +' ,[TipoLinha]'
             +' ,[Valor]'
             +' ,[ContaCBLFamilia],ContaAnalitica'
             +' ,[ContaCBLIVA],ClasseIVA'
             +' ,[ContaCBLPag]'
             +' ,[ContaCBLTipoDoc]'
             +' ,[ID_CodigoCliente]'
             +' ,[DataDoc]'
             +' ,[DescricaoLinha],IVA,natureza,tipoMovimento,nomecliente,'
             +' id_ModoPagamento,ContaCblCliente,ID_Hotel,Ncontribuinte,Mercado,valorLinha,DocTotalZERO,TipoLinhaFich,ordem '
             +' ,Nome,Morada,Localidade,CodigoPostal,Telefone)'
             +' VALUES ('
             + IntTostr(ID_Lote)+','
             + IntTostr(ListaVndProtel.daValor('ID_InternoDoc').asinteger)+','
             + IntTostr(ListaVndProtel.daValor('ID_documento').asinteger)
             +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
             +','+#39+ListaVndProtel.daValor('DescTipodoc').asstring+#39
             +','+#39+ListaVndProtel.daValor('DescricaoDoc').asstring+#39
             +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
             +','+ IntTostr(0)
             +','+  floattostr(ListaVndProtel.daValor('Valorliquido').asFloat)

             +','+#39+ContaCBLFAmilia+#39
             +','+#39+ContaAnalitica+#39
             +','+#39+ContaCBLIVA+#39
             +','+#39+ClasseIVA+#39
             +','' '''
             +','+#39+ListaVndProtel.daValor('ContaCblTipoDocumento').asstring+#39
             +','+ IntTostr(ListaVndProtel.daValor('ID_CodigoCliente').asinteger)
             +','+  SB.UtilSQL.DataToSQLData(ListaVndProtel.daValor('DataDoc').asdatetime)


             +','+#39+ListaVndProtel.daValor('Descricaoartigo').asstring+#39
            +','+#39+ListaVndProtel.daValor('DescricaoIVA').asstring+#39
            +','+#39+Natureza+#39
           +','+#39+ListaVndProtel.daValor('tipoMovimento').asstring+#39
            +','+#39+ListaVndProtel.daValor('nomecliente').asstring+#39
             +','+ IntTostr(ListaVndProtel.daValor('id_ModoPagamento').asinteger)
            +','+#39+ListaVndProtel.daValor('ContaCblCliente').asstring+#39
             +','+ IntTostr(ListaVndProtel.daValor('id_hotel').asinteger)
            +','+#39+ ListaVndProtel.daValor('Ncontribuinte').asstring+#39
            +','+#39+ ListaVndProtel.daValor('Mercado').asstring+#39
            +','+ sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('Valorliquido').asFloat,FFormatDecimalSQl)
            +','+ sb.UtilSQL.BoolToSQLStr(ListaVndProtel.daValor('DocTotalZERO').asBoolean)
            +','+#39+'A'+#39
            +','+inttostr(pordem)
            +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Nomecliente').asstring)
            +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Morada').asstring)
            +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Localidade').asstring)
            +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('codigoPostal').asstring)
            +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('telefone').asstring)


             +')';

    sb.SBBD.Executa(strsql);
 end;
end;



Procedure  InsereLinhaAgrupadaValorSemIVA(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
var
strsql:string;
descricaoDoc:string;
Natureza:string;
ContaCBLFamilia,ContaCBLIVA,ClasseIVA:string;
segue:boolean;
begin

 segue:=true;
 If FOmitirValoresZero then
   segue:= ListaVndProtel.daValor('valorliquido').asfloat<>0;

 If segue then
 begin
       ContaCBLFamilia:= ListaVndProtel.daValor('ContaCBLFAmilia').asstring;
       ContaCBLIVA:= ListaVndProtel.daValor('ContaCBLIVA').asstring;
       ClasseIVA:= ListaVndProtel.daValor('ClasseIVA').asstring;


       If ListaVndProtel.daValor('NcForaPerIVA').asBoolean=true then
       begin
              ContaCBLFamilia:= ListaVndProtel.daValor('ContaCBLFamiliaNCperIVAdifFACT').asstring;
              ContaCBLIVA:= ListaVndProtel.daValor('ContaCBLIVANCperIVAdifFACT').asstring ;
              ClasseIVA:= ListaVndProtel.daValor('ClasseIVANCperIVAdifFACT').asstring ;

       end;

       If  ListaVndProtel.daValor('Valorliquido').asFloat>=0 then
         Natureza:= ListaVndProtel.daValor('Natureza').asstring
       else
          Natureza:= ListaVndProtel.daValor('NaturezaNeg').asstring;




      strsql:=' INSERT INTO '+FVendasPrimavera
               +'  (ID_lote,'
               +' ID_InternoDoc,'
               +' [ID_Documento]'
               +'  ,[ID_TipoDocumento]'
               +' ,[DescricaoTipoDoc]'
               +' ,[DescricaoDoc]'
               +' ,[SerieDoc]  '
               +' ,[TipoLinha]'
               +' ,[Valor]'
               +' ,[ContaCBLFamilia]'
               +' ,[ContaCBLIVA],ClasseIVA'
               +' ,[ContaCBLPag]'
               +' ,[ContaCBLTipoDoc]'
               +' ,[ID_CodigoCliente]'
               +' ,[DataDoc]'
               +' ,[DescricaoLinha],IVA,natureza,tipoMovimento,nomecliente,'
               +' id_ModoPagamento,ContaCblCliente,ID_Hotel,Ncontribuinte,Mercado,valorLinha,DocTotalZERO,TipoLinhaFich,ordem '
               +' ,Nome,Morada,Localidade,CodigoPostal,Telefone)'
               +' VALUES ('
               + IntTostr(ID_Lote)+','
               + IntTostr(ListaVndProtel.daValor('ID_InternoDoc').asinteger)+','
               + IntTostr(ListaVndProtel.daValor('ID_documento').asinteger)
               +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
               +','+#39+ListaVndProtel.daValor('DescTipodoc').asstring+#39
               +','+#39+ListaVndProtel.daValor('DescricaoDoc').asstring+#39
               +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
               +','+ IntTostr(0)
               +','+  floattostr(ListaVndProtel.daValor('Valorliquido').asFloat)
               +','+#39+ContaCBLFamilia+#39
               +','+#39+ContaCBLIVA+#39
               +','+#39+ClasseIVA+#39
               +','' '''
               +','+#39+ListaVndProtel.daValor('ContaCblTipoDocumento').asstring+#39
               +','+ IntTostr(ListaVndProtel.daValor('ID_CodigoCliente').asinteger)
               +','+  SB.UtilSQL.DataToSQLData(ListaVndProtel.daValor('DataDoc').asdatetime)


               +','+#39+ListaVndProtel.daValor('Descricaoartigo').asstring+#39
              +','+#39+ListaVndProtel.daValor('DescricaoIVA').asstring+#39
              +','+#39+Natureza+#39
             +','+#39+ListaVndProtel.daValor('tipoMovimento').asstring+#39
              +','+#39+ListaVndProtel.daValor('nomecliente').asstring+#39
               +','+ IntTostr(ListaVndProtel.daValor('id_ModoPagamento').asinteger)
              +','+#39+ListaVndProtel.daValor('ContaCblCliente').asstring+#39
               +','+ IntTostr(ListaVndProtel.daValor('id_hotel').asinteger)
               +','+#39+ ListaVndProtel.daValor('Ncontribuinte').asstring+#39
              +','+#39+ ListaVndProtel.daValor('Mercado').asstring+#39
                  +','+ sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('Valorliquido').asFloat,FFormatDecimalSQl)
                  +','+ sb.UtilSQL.BoolToSQLStr(ListaVndProtel.daValor('DocTotalZERO').asBoolean)
                +','+#39+ 'F'+#39
                +','+inttostr(pordem)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Nomecliente').asstring)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Morada').asstring)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Localidade').asstring)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('codigoPostal').asstring)
              +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('telefone').asstring)

               +')';

      sb.SBBD.Executa(strsql);
 end;
end;



Procedure  insereLinhaPagamento(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
var
strsql:string;
descricaoDoc:string;
Natureza:string;
begin

 If  ListaVndProtel.daValor('Valorliquido').asFloat>=0 then
   Natureza:= ListaVndProtel.daValor('NaturezaPag').asstring
 else
    Natureza:= ListaVndProtel.daValor('NaturezaPagNeg').asstring;



strsql:=' INSERT INTO '+FVendasPrimavera
         +'  (id_lote,ID_InternoDoc,[ID_Documento]'
         +'  ,[ID_TipoDocumento]'
         +' ,[DescricaoTipoDoc]'
         +' ,[DescricaoDoc]'
         +' ,[SerieDoc]  '
         +' ,[TipoLinha]'
         +' ,[Valor]'
         +' ,[ContaCBLFamilia]'
         +' ,[ContaCBLIVA]'
         +' ,[ContaCBLPag]'
         +' ,[ContaCBLTipoDoc]'
         +' ,[ID_CodigoCliente]'
         +' ,[DataDoc] '
         +' ,[DescricaoLinha],IVA,natureza,tipoMovimento,nomecliente,'
         +'id_modoPagamento,contaCblCliente,id_hotel,Ncontribuinte,mercado,valorlinha,DocTotalZERO,ordem'
        +' ,Nome,Morada,Localidade,CodigoPostal,Telefone,TipoLinhaFich)'
         +' VALUES ('
         + IntTostr(Id_lote)+','
         + IntTostr(ListaVndProtel.daValor('ID_InternoDoc').asinteger)+','
         + IntTostr(ListaVndProtel.daValor('ID_documento').asinteger)
         +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
         +','+#39+ListaVndProtel.daValor('DescTipodoc').asstring+#39
         +','+#39+ListaVndProtel.daValor('DescricaoDoc').asstring+#39
         +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
         +','+ IntTostr(0)
         +','+  floattostr(ListaVndProtel.daValor('Valorliquido').asFloat)
         +','+#39+' '+#39
         +','+#39+' '#39
         +','+#39+ListaVndProtel.daValor('ContaCBLPagamento').asstring+#39
         +','+#39+ListaVndProtel.daValor('ContaCblTipoDocumento').asstring+#39
         +','+ IntTostr(ListaVndProtel.daValor('ID_CodigoCliente').asinteger)
         +','+  SB.UtilSQL.DataToSQLData(ListaVndProtel.daValor('DataDoc').asdatetime)

         +','+#39+ListaVndProtel.daValor('Descricaoartigo').asstring+#39
        +','+#39+ListaVndProtel.daValor('DescricaoIVA').asstring+#39
        +','+#39+Natureza+#39
        +','+#39+ListaVndProtel.daValor('tipoMovimento').asstring+#39
        +','+#39+ListaVndProtel.daValor('nomecliente').asstring+#39
         +','+ IntTostr(ListaVndProtel.daValor('id_modoPagamento').asinteger)
         +','+#39+ListaVndProtel.daValor('ContaCblCliente').asstring+#39
         +','+ IntTostr(ListaVndProtel.daValor('id_hotel').asinteger)
         +','+#39+ ListaVndProtel.daValor('Ncontribuinte').asstring+#39
        +','+#39+ ListaVndProtel.daValor('Mercado').asstring+#39
        +','+ sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('Valorliquido').asFloat,FFormatDecimalSQl)
         +','+ sb.UtilSQL.BoolToSQLStr(ListaVndProtel.daValor('DocTotalZERO').asBoolean)
        +','+inttostr(pordem)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Nomecliente').asstring)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Morada').asstring)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Localidade').asstring)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('codigoPostal').asstring)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('telefone').asstring)
        +',''F'''
         +')';

sb.SBBD.Executa(strsql);

end;



Procedure  InsereLinhaAgrupadaValorDoIVA(ListaVndProtel:TSBBETabeladados;ID_Lote:Integer;pordem:Integer);
var
strsql:string;
descricaoDoc:string;
Natureza:string;
ContaCBLFamilia,ContaCBLIVA,ContaCCusto,ClasseIVA,ContaAnalitica:string;
    segue:Boolean;
begin
 segue:=true;
 If ((FOmitirLinhaIVA0perc) or (FOmitirValoresZero)) then
   segue:= ListaVndProtel.daValor('valoriva').asfloat<>0;

 If segue then
 begin

//só exporta linhas de iva com valor

 ContaCBLFamilia:= ListaVndProtel.daValor('ContaCBLFAmilia').asstring;
 ContaCBLIVA:= ListaVndProtel.daValor('ContaCBLIVA').asstring;
 ClasseIVA:= ListaVndProtel.daValor('ClasseIVA').asstring;
 ContaCCusto:= ListaVndProtel.daValor('ContaCCusto').asstring;
 ContaAnalitica:= ListaVndProtel.daValor('ContaAnalitica').asstring;

 If ListaVndProtel.daValor('NcForaPerIVA').asBoolean=true then
 begin
        ContaCBLFamilia:= ListaVndProtel.daValor('ContaCBLFamiliaNCperIVAdifFACT').asstring;
        ContaCBLIVA:= ListaVndProtel.daValor('ContaCBLIVANCperIVAdifFACT').asstring;
        ClasseIVA:= ListaVndProtel.daValor('ClasseIVANCperIVAdifFACT').asstring;
        ContaCCusto:= ListaVndProtel.daValor('ContaCCustoNCperIVAdifFACT').asstring;
        ContaAnalitica:= ListaVndProtel.daValor('ContaAnaliticaNCperIVAdifFACT').asstring;
 end;
 If  ListaVndProtel.daValor('Valorliquido').asFloat>=0 then
   Natureza:= ListaVndProtel.daValor('Natureza').asstring
 else
    Natureza:= ListaVndProtel.daValor('NaturezaNeg').asstring;




strsql:=' INSERT INTO '+FVendasPrimavera
         +'  (ID_InternoDoc,[ID_Documento]'
         +'  ,[ID_TipoDocumento]'
         +' ,[DescricaoTipoDoc]'
         +' ,[DescricaoDoc]'
         +' ,[SerieDoc]  '
         +' ,[TipoLinha]'
         +' ,[Valor]'
         +' ,[ContaCBLFamilia]'
         +' ,[ContaCBLIVA]'
         +' ,[ContaCBLPag]'
         +' ,[ContaCBLTipoDoc]'
         +' ,[ID_CodigoCliente]'
         +' ,[DataDoc]'
         +' ,[DescricaoLinha], IVA,natureza,tipoMovimento,nomecliente,id_ModoPagamento,'
         +'ContaCblCliente,id_hotel,Ncontribuinte,Mercado,valorLinha,DocTotalZERO,ordem'
        +' ,Nome,Morada,Localidade,CodigoPostal,Telefone,tipoLinhaFich,ID_lote)'
         +'  VALUES ('
       + IntTostr(ListaVndProtel.daValor('ID_InternoDoc').asinteger)+','
         + IntTostr(ListaVndProtel.daValor('ID_documento').asinteger)
         +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)

         +','+#39+ListaVndProtel.daValor('DescTipodoc').asstring+#39
         +','+#39+ListaVndProtel.daValor('DescricaoDoc').asstring+#39
         +','+ IntTostr(ListaVndProtel.daValor('ID_TipodocumentoProtel').asinteger)
         +','+ IntTostr(1)
        +','+ sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('ValorIva').asFloat,FFormatDecimalSQl)

         +','+#39+ContaCBLFAmilia+#39
         +','+#39+ContaCBLIVA+#39
         +','' '''
         +','+#39+ListaVndProtel.daValor('ContaCblTipoDocumento').asstring+#39
         +','+ IntTostr(ListaVndProtel.daValor('ID_CodigoCliente').asinteger)
         +','+  SB.UtilSQL.DataToSQLData(ListaVndProtel.daValor('DataDoc').asdatetime)

         +','+#39+ListaVndProtel.daValor('Descricaoartigo').asstring+#39
        +','+#39+ListaVndProtel.daValor('DescricaoIVA').asstring+#39
        +','+#39+Natureza+#39
          +','+#39+ListaVndProtel.daValor('tipoMovimento').asstring+#39
        +','+#39+ListaVndProtel.daValor('nomecliente').asstring+#39
         +','+ IntTostr(ListaVndProtel.daValor('id_ModoPagamento').asinteger)
         +','+#39+ListaVndProtel.daValor('ContaCblCliente').asstring+#39
         +','+ IntTostr(ListaVndProtel.daValor('id_hotel').asinteger)
         +','+#39+ListaVndProtel.daValor('Ncontribuinte').asstring+#39
         +','+#39+ ListaVndProtel.daValor('Mercado').asstring+#39
         +','+ sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('Valorliquido').asFloat,FFormatDecimalSQl)
         +','+ sb.UtilSQL.BoolToSQLStr(ListaVndProtel.daValor('DocTotalZERO').asBoolean)

       +','+ inttostr(pordem)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Nomecliente').asstring)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Morada').asstring)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Localidade').asstring)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('codigoPostal').asstring)
        +','+ sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('telefone').asstring)
         +',''F'''
          +','+ IntTostr(ID_Lote)

         +')';

  sb.SBBD.Executa(strsql);
end;

end;




Function DAultimoDataVendaExportado(porigem:integer):tdatetime;
var Listadad:tsbbetabeladados;
begin
 result:=0;
 Listadad:=sb.sbbd.abrirlv('select Max(DATA) as DATA from ERP_CBLCabec   where origem='+Inttostr(FOBJInterface.ID));
 If Not(Listadad.vazia) then
 begin
      Result:=Listadad.davalor('DATA').asdatetime;
 end;
 Listadad.fecha;
 Freeandnil(Listadad);

end;


Function DAultimoIDVendaExportado():integer;
var Listadad:tsbbetabeladados;
begin
 result:=0;
 Listadad:=sb.sbbd.abrirlv('select Max(ID_docInterno) as id_internodoc from ERP_CBLCabec  where origem='+Inttostr(FOBJInterface.ID));
 If Not(Listadad.vazia) then
 begin
      Result:=Listadad.davalor('id_internodoc').asinteger;

 end;
 Listadad.fecha;
 Freeandnil(Listadad);

end;


Function daFormatDecimalSQl():string;
var
  i:integer;
begin
 If FNumCasaDecimaisVL>0 then
 begin
     for i:=0 to FNumCasaDecimaisVL do
     begin
      Result:=result+'0';
     end;
     result:='0.'+ Result;
 end;
end;


Procedure PreencheVariavaisConfGerais;
var
  strsql:string;
    FConnectionString:string;
  Lstdados:TSBBETabelaDados;
begin
    id_Pagamentocc:=0;
    FContasIVASPorMercado:=false;
    strsql:='Select * from ERP_CBLParametros where ID_EmpresaInteraface= '+Inttostr(FOBJInterface.ID);
    Lstdados:=sb.SBBD.AbrirLV(strsql);
    If Not(Lstdados.Vazia) then
    begin
           FContasIVASPorMercado:= Lstdados.daValor('ContasPorMercado').asboolean;
      FModulo:=Lstdados.daValor('ModuloVnd').asstring;
      FOmitirValoresZero:=Lstdados.daValor('OmiteLinhaZero').asboolean;
      FNumCasaDecimaisVL:=Lstdados.daValor('NumCasaDecimaisVL').asinteger;
      FRefleteClasseIva:=Lstdados.daValor('RefleteClasseIva').asstring;
      FReflecteFluxos:=Lstdados.daValor('ReflecteFluxos').asstring;
      FRefleteAnalitica:=Lstdados.daValor('RefleteAnalitica').asstring;
      FRefleteCentroCusto:=Lstdados.daValor('RefleteCentroCustos').asstring;
      FDiario:=Lstdados.daValor('Diario').asstring;
      id_Pagamentocc:=Lstdados.daValor('id_Pagamentocc').asInteger;
      FContadorLote:=Lstdados.daValor('LoteIgualNDocumento').asBoolean;
      FTipoAfetacao  :=Lstdados.daValor('TipoAfetacao').asstring;
      FFormatDecimalSQl:=daFormatDecimalSQl;
      FEnviaLinhaIva:=Lstdados.daValor('EnviaLinhaIVA').asBoolean;
      FOmitirLinhaIVA0perc:=Lstdados.daValor('OmitirLinhaIVA0perc').asboolean;
      FperiodoIVA:=FOBJInterface.PeriodoIVA;
      FExcluirDocsVndAnulados:=Lstdados.daValor('ExcluirDocsVndAnulados').asboolean;



    end;
    FreeAndnil(lstdados);
end;





Function DADataDDMM(pData:TDatetime):string;
Var
  Ano,
  Mes,
  Dia: Word;
  AnoStr,
  MesStr,
  DiaStr:String;
Begin
  Result := '';
  DecodeDate(pData, Ano, Mes, Dia);
  AnoStr := IntToStr(Ano);
  MesStr := IntToStr(Mes);

  If Length(MesStr) = 1 Then
    MesStr := '0' + MesStr;

  DiaStr := IntToStr(Dia);
  If Length(DiaStr) = 1 Then
    DiaStr := '0' + DiaStr;

  Result:=DiaStr + MesStr;
end;



Function DADataDDMMANO(pData:TDatetime):string;
Var
  Ano,
  Mes,
  Dia: Word;
  AnoStr,
  MesStr,
  DiaStr:String;
Begin
  Result := '';
  DecodeDate(pData, Ano, Mes, Dia);
  AnoStr := IntToStr(Ano);
  MesStr := IntToStr(Mes);

  If Length(MesStr) = 1 Then
    MesStr := '0' + MesStr;

  DiaStr := IntToStr(Dia);
  If Length(DiaStr) = 1 Then
    DiaStr := '0' + DiaStr;

  Result:=DiaStr + MesStr+AnoStr;
end;

Function TrataDecimais(Valor: String): String;
Begin
  If length(valor)>0 Then
    Result := StringReplace(Valor, ',', '.', [rfReplaceAll])
  Else
    Result := '0.00';

End;







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
    // FShemaProtel:=FOBJInterface.
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
        end
        else
         If FOBJInterface.DATAInicioExportacao=0 then
         begin
           Mensagem:='Falta Preencher a Data inicio de exportação';
           Result:=false;
         end
     end;


     If not(result) then
     begin
         Mensagem:='Não é possível Exportar!'+#13+Mensagem;
     end;


  end
  else
  begin
      result:=false;
       Mensagem:='Não existe interface: "ERP_CBLVENDASPROTEL" Ativo!';
  end;
end;


Function DalistaIDDocs(pListaDocs:TsbbeTabeladados):TstringList;
begin
     Result:=TstringList.create;
     pListaDocs.inicio;
     While Not(pListaDocs.NoFim)do
     begin
        If Result.IndexOf(pListaDocs.davalor('ID_InternoDoc').asstring)=-1 then
            Result.Add(pListaDocs.davalor('ID_InternoDoc').asstring);
        pListaDocs.seguinte;
     end;
end;





Procedure InsereLinha(Objcabec:TERPBECBLcab;ObjLinha:TERPBECBLLinha;pID_Hotel:Integer);
var
 stsql:string;
 i:integer;
begin
  With ObjLinha do
  Begin
    stsql:=' INSERT INTO  ERP_CBLLinhas'
           +'( ID_Interno'
           +', ID_DOCInterno'
           +', NumLinha'
           +', TipoLinha'
           +', Conta'
           +', Descricao'
           +', Valor'
           +', Natureza'
           +', TipoEntidade'
           +', Entidade'
           +', ClasseIva'
           +', ContaOrigem'
           +', TipoOperacao'
           +', Moeda'
           +', Cambio,mpehotel,DataEmissaoDocumento,TaxaIVA)'
           +' values( '
           + IntToStr(ObjLinha.ID_interno)
           +','+ IntToStr(ObjLinha.ID_DOCInterno)
           +',' +IntToStr(ObjLinha.NumLinha)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.TipoLinha)
           +', '+sb.utilsql.StrToSQLStrpelica(ObjLinha.Conta)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.Descricao)
           +', '+sb.utilsql.DecimalToSQLStr(ObjLinha.Valor,FFormatDecimalSQl)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.Natureza)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.TipoEntidade)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.Entidade)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.ClasseIva)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.ContaOrigem)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.TipoOperacao)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.Moeda)
           +','+sb.utilsql.DecimalToSQLStr(ObjLinha.Cambio)
           +',' +IntToStr(pID_Hotel)
           +','+sb.utilsql.DataToSQLData(Objcabec.Data)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.taxaIVA)
           +')';
          sb.SBBD.Executa(stsql);

   end;
end;


Procedure GravaDocvenda(ObjCab:TERPBECBLCab);
var
 stsql:widestring;
 i:integer;
 ProximoID_InternoDoc:integer;
begin
 ProximoID_InternoDoc:=sb.ProximoID('ERP_CBLCAB',true);
  With ObjCab do
  Begin
    ObjCab.ID_interno:=ProximoID_InternoDoc;
    stsql:='INSERT INTO [ERP_CBLCabec]'
           +'([ID_Interno] '
           +',[ID_DOCInterno]'
           +',[Origem]  '
           +',[Modulo]'
           +',[Ano]'
           +',[Mes] '
           +',[Dia] '
           +',[Data] '
           +',[Analitica] '
           +',[CCustos] '
           +',[Diario] '
           +',[Documento]'
           +',[NumDocumento] '
           +',[Descricao] '
           +',[DataHoraRegisto]'
           +',[TotalLinhas]  '
           +',[UtilizadorRegisto]'
           +',[NIF]'
           +',[TipoEntidade]  '
           +',[Entidade]  '
           +',[Nome] '
           +',[Morada]'
           +',[Localidade] '
           +',[CodigoPostal] '
           +',[Telefone]  '
           +',[DataVencimento],mpehotel,NomeBaseDados,integrado )'
          +' values( '
           +inttostr(ObjCab.ID_interno)
           +','+ inttostr(ObjCab.ID_DOCInterno)
           +','+ inttostr(ObjCab.Origem)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Modulo)
           +','+ inttostr(ObjCab.ano)
           +','+ inttostr(ObjCab.mes)
           +','+ inttostr(ObjCab.dia)
          +','+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.Data)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Analitica)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CCustos)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Diario)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Documento)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.NumDocumento)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Descricao)
           +','+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.DataHoraRegisto)

           +','+ inttostr(ObjCab.TotalLinhas)
           +','+ sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.NIF)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.tipoentidade)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.entidade)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.nome)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Morada)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.localidade)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodigoPostal)
           +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Telefone)
           +','+ sb.UtilSQL.DataToSQLData(ObjCab.DataVencimento)
           +','+ inttostr(ObjCab.mpehotel)
           +','+ sb.UtilSQL.StrToSQLStrpelica(FOBJInterface.BDNOME)           

           +',0)';
          sb.SBBD.Executa(stsql);

       For i:=0 to ObjCab.Linhas.Num-1 do
       begin
         ObjCab.Linhas.elem[i].ID_interno:= ObjCab.ID_interno;
         InsereLinha(ObjCab,ObjCab.Linhas.elem[i],objCab.mpehotel);

       end;
  end;




end;




Function PreencheOBJDoc(pListaDocs:TsbbeTabeladados;pid_Internodoc:Integer):TERPBECBLCab;
var
    ObjLinha:TERPBECBLLinha;
    Linha:integer;
    Contamovimentar:string;
    CodClientePMS:string;
    ttZeros,j:integer;
begin
  pListaDocs.dataset.filtered:=false;
  pListaDocs.dataset.filter:='ID_Internodoc='+Inttostr(pid_Internodoc);
  pListaDocs.dataset.filtered:=true;
  If  Not pListaDocs.Vazia then
  begin
    Result:=TERPBECBLCab.Create;
    Result.ID_DOCInterno:= pListaDocs.davalor('ID_Internodoc').asinteger;
    Result.mpehotel:=pListaDocs.davalor('id_Hotel').asinteger;
    Result.NumDocumento:= pListaDocs.davalor('id_documento').asstring;
    Result.Documento:= pListaDocs.davalor('ContaCBLTipoDOC').asstring;
    Result.Origem:=FOBJInterface.ID;//protel 2 syscontroller
    Result.modulo:=Fmodulo;
    Result.Descricao := pListaDocs.davalor('descricaoDoc').asstring;
    Result.Diario:=FDiario;
    Result.Analitica:=FRefleteAnalitica;
    Result.CCustos:=FRefleteCentroCusto;
    result.TotalLinhas:= pListaDocs.NumLinhas;
    result.Nif := pListaDocs.davalor('ncontribuinte').asstring;
    result.ano :=Yearof(pListaDocs.davalor('datadoc').asdatetime);
    result.mes :=Monthof(pListaDocs.davalor('datadoc').asdatetime);
    result.dia :=DayOf(pListaDocs.davalor('datadoc').asdatetime);
    result.Data :=pListaDocs.davalor('datadoc').asdatetime;
    result.TipoEntidade:='C';
    result.nome:= pListaDocs.davalor('Nomecliente').asstring;
    result.Morada:= pListaDocs.davalor('Morada').asstring;
    result.Localidade:= pListaDocs.davalor('Localidade').asstring;
    result.CodigoPostal:= pListaDocs.davalor('CodigoPostal').asstring;
    result.Telefone:= pListaDocs.davalor('Telefone').asstring;
    Result.DataVencimento:= pListaDocs.davalor('Datadoc').asdatetime;
    Result.ID_cliente:= pListaDocs.davalor('ID_CodigoCliente').asinteger;
    Result.entidade:= pListaDocs.davalor('ContaCBLCliente').asstring;
    Result.Integrado:=False;
    Result.DataHoraRegisto:=now;
    Result.UtilizadorRegisto:=Sb.UtilizadorActual.Login;
    Linha:=0;
    While Not (pListaDocs.NoFim) do
    begin
         Contamovimentar:='';
         ObjLinha:=TERPBECBLLinha.create;
         With ObjLinha do
         begin
            ID_DOCInterno:=pListaDocs.davalor('ID_Internodoc').asinteger;
            NumLinha:=Linha+1;
            TipoLinha:=pListaDocs.davalor('TIPOLINHAFICH').ASSTRING;
            Descricao:=pListaDocs.davalor('DescricaoLinha').ASSTRING;
            TaxaIva:=pListaDocs.davalor('IVA').ASSTRING;
          //  FDescricao:string;
//            FTaxaIva:extended;
  //          FPercIvaNDev:extended;
    //        FIvaNDed:extended;
            Natureza:=pListaDocs.davalor('Natureza').asstring;
            TipoEntidade:='C';
            Cambio:=1.0000000;
            Moeda:='EUR';

            If pListaDocs.davalor('TipoMovimento').asstring='1' then
            begin
                CONTA:=pListaDocs.davalor('CONTaCBLPag').asstring;
                If id_Pagamentocc=pListaDocs.davalor('Id_modoPagamento').asinteger then
                begin
                   ttZeros:=0;
                   CodClientePMS:='';
                   CodClientePMS:=pListaDocs.davalor('ContaCBLCliente').asstring;
                   If Length(CodClientePMS)<6 then
                   begin
                         ttZeros:=6-Length(CodClientePMS);
                         For j:=0 to  ttZeros-1 do
                           CodClientePMS:='0'+CodClientePMS;
                   end;
                   Conta:=pListaDocs.davalor('ContaCBLPag').asstring+pListaDocs.davalor('mercado').asstring+CodClientePMS;


               end;

             end
             else
             If pListaDocs.davalor('TipoLinha').asstring='0' then
             begin
               IF pListaDocs.davalor('TipoLinhafich').asstring='F' then
               begin
                 CONTA:=pListaDocs.davalor('CONTaCBLFAMILIA').asstring;
                 ClasseIVA:=pListaDocs.davalor('ClasseIVA').asstring;
               end
               else
               IF pListaDocs.davalor('TipoLinhafich').asstring='O' then
               begin
                 CONTA:=pListaDocs.davalor('CONTaCCusto').asstring;
                 CONTAORIGEM:=pListaDocs.davalor('CONTaCBLFAMILIA').asstring;
               end
               else
               IF pListaDocs.davalor('TipoLinhafich').asstring='A' then
               begin
                 CONTA:=pListaDocs.davalor('CONTaAnalitica').asstring;
               end;

             end
             else
             If pListaDocs.davalor('TipoLinha').asstring='1' then
             Begin
                 CONTA:=pListaDocs.davalor('CONTACBLIVA').asstring;
                 CONTAORIGEM:=pListaDocs.davalor('CONTaCBLFAMILIA').asstring;
             end
             else
             If pListaDocs.davalor('TipoLinha').asstring='2' then
             begin
                 CONTA:=pListaDocs.davalor('CONTACBLIVAPag').asstring;

             end;

             valor:=0;
             valor:=abs(pListaDocs.davalor('Valor').asFloat);
             inc(Linha);
        end;
        Result.Linhas.Adiciona(ObjLinha);
        pListaDocs.seguinte;

    end;
  end;

end;


Function PreparaParametrosExportacao():Boolean;
var
 strMensagemErros:string;
begin
    Result:=false;
    FObjInterface:= MotorERP.ERPInterface.Edita(FIDInterface);
    If  FObjInterface<>nil then
    begin
      Result:=ValidaExportacao(strMensagemErros);
      If Not(Result) then
      begin
        sb.Dialogos.SBMessage(strMensagemErros);
      end
      else
      begin
         FShemaProtel:=FObjInterface.BDSchema;
//         FDataInicioExp:= FObjInterface.DATAInicioExportacao;
         FListaContasMercado:=sb.SBBD.AbrirLV('Select ID_Pais,id_Mercado from PMSPaisMercado');
         FVendasProtel:=CriaEstruturaVendasProtel;
         FVendasPrimavera:=CriaEstruturaVendasPrimavera;
         PreencheVariavaisConfGerais;
      end;
    end;
end;

Function ValidaExportacaoDocumento(ObjCab:TERPBECBLCab;var mensagem:string):Boolean;
var
 i:integer;
 ListaD:Tsbbetabeladados;
 strsql:string;

begin
  result:=true;
  mensagem:='';
  If  ObjCab.Linhas.num=0 then
              mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Documento Sem Linhas:'+ ObjCab.Descricao;

  For i:=0 to  ObjCab.Linhas.Num-1 do
  begin

      If  (ObjCab.Linhas.elem[i].Conta='') then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Conta CBL :'+ ObjCab.Linhas.elem[i].Descricao;
  end;
  If mensagem<>'' then
  begin
   mensagem:='Documento nº'+ObjCab.NumDocumento+' '+ObjCab.Descricao+#13+mensagem;
   result:=false;
  end;
  If Result then
  begin
    try

          ListaD:=sb.SBBD.AbrirLV('select ID_DOCInterno from ERP_CBLCabec '
          +' where origem='+Inttostr(FOBJInterface.ID)+' and ID_DOCInterno='+Inttostr(ObjCab.ID_DOCInterno));
          If Not(ListaD.vazia) then
          begin
            mensagem:='Documento nº'+ObjCab.NumDocumento+' '+ObjCab.Descricao+'.Já foi exportado!';
            Result:=False;
          end;
          ListaD.fecha;
     except
      raise;
     end; 


  end;


end;


Function ExportarVendasManual(pListaDocs:TsbbeTabeladados; ListaErros:tstringList):Boolean;
var
   ObjCabecalhos:TERPBEcblCabecalhos;
   ObjCab:TERPBECBLCab;
   ListaIDSDocs:TstringList;
   i:Integer;
   strsql,strMensagemErros:string;
   entrouerro:boolean;
begin
  ListaErros.clear;
  Result:=false;
  entrouerro:=false;
  strMensagemErros:='';
  If  Not(ValidaExportacao(strMensagemErros)) then
    sb.Dialogos.SBMessage(strMensagemErros)
  else
  If Not(pListaDocs.Vazia) then
  begin
       PreencheVariavaisConfGerais;
       pListaDocs.dataset.filtered:=false;
       pListaDocs.inicio;
       ListaIDSDocs:= DalistaIDDocs(pListaDocs);
       pListaDocs.inicio;
       ObjCabecalhos:=TERPBEcblCabecalhos.create;
       For i:=0 to ListaIDSDocs.Count-1 do
       begin
         Try
          ObjCab:=PreencheOBJDoc(pListaDocs,strtoint(ListaIDSDocs.strings[i]));
          ObjCabecalhos.Adiciona(ObjCab);
         except
           Raise;

             result:=false;
         end;

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
           begin
            ListaErros.add(strMensagemErros);
            If Not(FNaoInterrompeExportaOqueconsegue) then
            begin

              Raise
                SB.ErroNormal(0,'Exportação de Vendas Interrompida','Grava Documento',strMensagemErros);
            end;
           end;
         end;

         SBBD.TerminaTransacao;
         result:=true;

        Except

              On E:EErroDetalhe Do
              Begin
                entrouerro:=true;
                Result:=false;
                If assigned(ObjCabecalhos) then
                  freeandnil(ObjCabecalhos);
                 SBBD.DesfazTransacao;

                raise EErroDetalhe.Create('Exportação Cbl PMS','','Não foi possível exportar.',E.Detalhe);
              End;
              On E :Exception Do
              Begin
                 entrouerro:=true;
                 Result:=false;
                 if assigned(ObjCabecalhos) then
                   freeandnil(ObjCabecalhos);
                 SBBD.DesfazTransacao;
                 raise EErroDetalhe.Create('Exportação Cbl PMS','','Não foi possível exportar.',E.Message);
              End
              else
              if   entrouerro=false then
              begin
                Result:=false;
                if assigned(ObjCabecalhos) then
                 freeandnil(ObjCabecalhos);

                 SBBD.DesfazTransacao;

              end;
        end;
       end;
  end;
end;


Function DaMercado(pID_Pais:integer):integer;
begin
  Result:=1;
  if FListaContasMercado<>nil then
  If FListaContasMercado.dataset.locate('ID_Pais',pID_Pais,[]) then
   Result:=FListaContasMercado.dataset.fieldbyname('id_mercado').asinteger;
end;

Function  PreencheTabelaTemporaria(pData:Tdatetime;pStrIDDoumentos:string;pFiltroDocs:string):string;
var
   ListaVndProtel:TSBBETabeladados;
   strSQL:string;
   descricaoDoc:string;
   Ncontribuinte:string;
   ID_PaisHospede:integer;
   Mercado:integer;
   ID_UltVndcabdocumentoExportado:integer;
   DocTotalZERO:Boolean;
   txtFileR: TextFile;
   caminho:string;
var
 schema:string;
begin
   schema:=FShemaProtel;
   Try
     FIDSHoteis:=DaIDHoteis;//vai buscar ao Protel os hoteis que na tabela do Protel XSEtup, tem interface configurado.

     ID_UltVndcabdocumentoExportado:=DAultimoIDVendaExportado;

      strSQL:=' select TipoMovimento,round(sum(valor),'+IntToStr(FNumCasaDecimaisVL)+') as Valor,'
      +'round(sum(valoriva),'+IntToStr(FNumCasaDecimaisVL)+') as ValorIva,'
       +' round(sum(valorsemiva),'+IntToStr(FNumCasaDecimaisVL)+') as valorsemiva,id_contalancamento,'
        +' sum(quantidade) as Quantidade,'
        +' ID_Internodoc,ID_CodigoCliente,ID_documento,  DataDoc,'
        +'    ID_Iva,ID_Tipodocumento,'
        +'   armazem, Id_ContaLancamento,ID_GrpLancamento,iva,'
        +'  Tipodoc,bez,cc_cliente,'
        +'      nomecliente,ID_Pagamento,Artigo,datavencimento,ID_Hotel,Ncontribuinte,DocTotalZERO'
        +', MoradaEntidade,localidadeEntidade,codigopostalentidade,TelefoneEntidade,NcForaPerIVA ';
        If FContasIVASPorMercado then
           strSQL:=strSQL+',ID_PaisHospede';
        strSQL:=strSQL+' from('


       + ' select '  +'Kunden.vatno as Ncontribuinte,'

       +'Kunden.vorname+'' '' +Kunden.name1   as nomecliente,isnull(Kunden.strasse,'' '')as MoradaEntidade,'
        +' isnull(Kunden.ort,'' '') as localidadeEntidade,'
        + ' isnull(Kunden.plz,'' '') as codigopostalentidade,'
        + ' isnull(Kunden.telefonnr,'' '') as TelefoneEntidade,'


         +'RECHHIST.Ref as ID_Internodoc,'
         +'RECHHIST.kdnr as ID_CodigoCliente,'
          +'Leisthis.rechnr as ID_documento, '
         +'RECHHIST.datum as DataDoc,  '
          +'RECHHIST.datum as DataVencimento, '
          +'Leisthis.vatno as ID_Iva,'
         +'Leisthis.Fisccode as ID_Tipodocumento, '
        +' ( ' +'Leisthis.epreis* ' +'Leisthis.anzahl) as Valor,'


       +' ( ' +'Leisthis.epreis* ' +'Leisthis.anzahl)/(100+' +'Leisthis.mwstsatz)*' +'Leisthis.mwstsatz as valoriva,'

        +' (' +'Leisthis.epreis*' +'Leisthis.anzahl)-((' +'Leisthis.epreis*' +'Leisthis.anzahl)/(100+' +'Leisthis.mwstsatz)*' +'Leisthis.mwstsatz)'
    +'  as valorsemiva,'


           +'hgruppen.gruppe as armazem,'

         +'Leisthis.uktonr as Id_ContaLancamento,'
         +'hgruppen.nummer as ID_GrpLancamento, '

         +'Leisthis.anzahl as Quantidade, '

         +'Leisthis.mwstsatz as iva,'
         +'fiscalcd.code as Tipodoc, '
         +'zahlart.bez,';
        if FContasIVASPorMercado then
        begin
            strSQL:=strSQL +' ID_PaisHospede,'
        end;


        If FClienteTabMETADATA then
             strSQL:=strSQL +  schema+'METADATA.data as cc_cliente,'
        Else
          strSQL:=strSQL  +'kunden.fibudeb as cc_cliente,';


       strSQL:=strSQL

         +'zahlart.za as ID_Pagamento,'
        +'TipoMovimento=CASE WHEN '  +'Leisthis."rkz"=0 '
        +' THEN '+#39+'0'+#39+' ELSE '+#39+'1'+#39+' END ,'
        +'Artigo=CASE WHEN '  +'Leisthis."rkz"=0 '
        +' THEN  ' +'ukto.Bez ELSE ' +'zahlart.bez END, '

         +'Leisthis."mpehotel" as ID_Hotel,'

        + ' case when '  +'RECHHIST.sum_zahl=0 and '  +'RECHHIST.sum_belast=0 then 1 else 0'
        + ' end as DocTotalZERO';

        If FperiodoIVA>0 then
        begin
           strsql:=strsql  +',case when isnull(V_perIVA.ID_NC,0)>0 then 1 else 0 end as NcForaPerIVA'
        end
        else
        begin
         strsql:=strsql  +', 0 as NcForaPerIVA'
        end;


         strsql:=strsql    +' from '+schema+'Leisthis '
        +' inner join '+schema+'RECHHIST on '
        +' RECHHIST.rechnr = Leisthis.rechnr'
        + ' and RECHHIST.Fisccode = Leisthis.Fisccode'
        +' inner join '+schema+'kunden on kunden.kdnr=RECHHIST.kdnr'
        +' left join '+schema+'zahlart on zahlart.zanr=Leisthis.rkz'
        +' left join '+schema+'ukto on ukto.kto=Leisthis.uktonr '
        +' left join '+schema+'hgruppen on hgruppen.hgnr=ukto.hauptgrp '
        +' inner join '+schema+'fiscalcd on  fiscalcd.ref= Leisthis.Fisccode';

        If FperiodoIVA>0 then
        begin
          If FperiodoIVA=1 then
          begin
           strsql:=strsql  +' left join '+schema+'V_NotasCreditoForaPeriodoIvaMensal as V_perIVA '
           +'  on V_perIVA.mpehotel=RECHHIST.mpehotel'
           +'  and V_perIVA.Fisccode=RECHHIST.Fisccode'
           +'  and V_perIVA.ID_NC=RECHHIST.Rechnr'

          end
          else
          If FperiodoIVA=2 then
          begin
           strsql:=strsql  +' left join '+schema+'V_NotasCreditoForaPeriodoIvaTrimestral as V_perIVA '
           +'  on V_perIVA.mpehotel=RECHHIST.mpehotel'
           +'  and V_perIVA.Fisccode=RECHHIST.Fisccode'
           +'  and V_perIVA.ID_NC=RECHHIST.Rechnr'

          end;

        end;



        if FContasIVASPorMercado then
        begin
           strsql:=strsql +' inner join '+schema+'V_DocvendaPaisHospede  on  RECHHIST.ref = V_DocvendaPaisHospede.ID_internoCab'
        end;

        If   FClienteTabMETADATA then
        begin
          strSQL:=strSQL +' Left join '+schema+'METADATA on  METADATA.ref= kunden.kdnr'
            +' and METADATA.mpehotel= RECHHIST.mpehotel'
            +' and METADATA.xkey=''kunden.fibudeb''';
        end;



        strSQL:=strSQL+' where   Leisthis.Fisccode in'+pStrIDDoumentos ;

        If FExcluirDocsVndAnulados then
        Begin
         strSQL:=strSQL+' and RECHHIST.void<>1';
        End;

        If FIDSHoteis<>''  then
        begin

            strSQL:=strSQL + ' AND RECHHIST.mpehotel IN('+FIDSHoteis+')';
            strSQL:=strSQL + ' AND Leisthis.mpehotel IN('+FIDSHoteis+')';
        end;

        if Uppercase(sb.UtilizadorActual.Login)<>'MICRONET' then
        begin
            If ((ID_UltVndcabdocumentoExportado>0) and (pFiltroDocs='')) then
               strSQL:=strSQL + ' AND RECHHIST.Ref>' +   Inttostr(ID_UltVndcabdocumentoExportado);
        end;



        If  FDataInicioExp>0 then
            strsql:=strsql+' and RECHHIST.datum>='+sb.UtilSQL.DataToSQLData(FDataInicioExp);

        If  FdataFimExp>0 then
           strsql:=strsql+' and RECHHIST.datum<='+sb.UtilSQL.DataToSQLData(FdataFimExp);

        If pFiltroDocs<>'' then
                   strsql:=strsql+' and RECHHIST.rechnr in ('+pFiltroDocs+')';




          strSQL:=strSQL +'      ) as x';
          strSQL:=strSQL +' group by TipoMovimento,';
          strSQL:=strSQL +'  ID_Internodoc,ID_CodigoCliente,ID_documento,  DataDoc,';
          strSQL:=strSQL +'   DataVencimento,';
          strSQL:=strSQL +'    ID_Iva,ID_Tipodocumento,';

          strSQL:=strSQL +'   armazem, Id_ContaLancamento,ID_GrpLancamento,iva,';
          strSQL:=strSQL +'  Tipodoc,bez,cc_cliente,';
          strSQL:=strSQL +'      nomecliente,ID_Pagamento,Artigo,id_hotel,Ncontribuinte,DocTotalZERO';
          strSQL:=strSQL +'   , MoradaEntidade,localidadeEntidade,codigopostalentidade,TelefoneEntidade,NcForaPerIVA';
          if FContasIVASPorMercado then
          begin
               strSQL:=strSQL +'    ,id_PaisHospede';
          end;

          strSQL:=strSQL +'        order by ID_Tipodocumento ASC, ID_Internodoc ASC';

         Result:= strSQL;


        ListaVndProtel:=sb.SBBD.AbrirLV( strSQL);


     Try
         caminho:=ExtractFilePath(Application.ExeName);
         AssignFile(txtFileR,caminho+'sqlpms.TXT');
         Rewrite(txtFileR);
         Writeln(txtFileR,strSQL);
         CloseFile(txtFileR);
     except
     end;

        sb.SBBD.executa('Delete from '+FVendasProtel);


        ListaVndProtel.Inicio;
        While Not(ListaVndProtel.NoFim)do
        Begin
            If (1<>0) then
            begin

              Ncontribuinte:=ListaVndProtel.daValor('Ncontribuinte').asstring;
              If Ncontribuinte='' then
                Ncontribuinte:='999999990';
              descricaoDoc:='';
              descricaoDoc:=ListaVndProtel.daValor('TipoDoc').asstring+'nº'+
                             ListaVndProtel.daValor('ID_TipoDocumento').asstring+'/'+
                              ListaVndProtel.daValor('ID_Documento').asstring;

               if FContasIVASPorMercado then
               begin
                     Mercado:=DaMercado(ListaVndProtel.daValor('ID_PaisHospede').asinteger);
               end
               else
               begin
                 Mercado:=1;
               end;

             strSQL:= 'INSERT INTO '+FVendasProtel
                 +' (ID_Internodoc,ID_Documento, ID_TipoDocumento, ValorLiquido,'
                 +' ID_ContaLanc, ID_CodigoCliente,ID_Iva,descricaoDoc,'
                 +' ID_GrpContaLanc, [DataDoc], [Datavencimento],Valor,Valoriva,DescricaoArtigo,'
                 +' DescricaoArmazem,DescricaoIva,tipomovimento,nomecliente,'
                 +'id_ModoPagamento,ContaCBLCliente,ID_Hotel,Ncontribuinte,mercado,DocTotalZERO,'
                 +'Morada,CodigoPostal,localidade,telefone, NCForaPerIVA'
                 +')'
                 +' Values('
                 + IntTostr(ListaVndProtel.daValor('ID_InternoDoc').asinteger) +','
                 + IntTostr(ListaVndProtel.daValor('ID_documento').asinteger) +','
                 + IntTostr(ListaVndProtel.daValor('ID_TipoDocumento').asinteger) +','
                 +  sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('valorsemiva').asFloat,FFormatDecimalSQl)+','
                 +  sb.UtilSQL.StrToSQLStrpelica(ListaVndProtel.daValor('Id_ContaLancamento').asstring) +','
                 + IntTostr(ListaVndProtel.daValor('ID_CodigoCliente').asinteger) +','
                 + IntTostr(ListaVndProtel.daValor('ID_Iva').asinteger) +','
                 +#39+ descricaoDoc+#39 +','
                 + IntTostr(ListaVndProtel.daValor('ID_GrpLancamento').asinteger) +','
                 +  SB.UtilSQL.DataToSQLData(ListaVndProtel.daValor('DataDoc').asdatetime)+',';

                 If ListaVndProtel.daValor('Datavencimento').asdatetime>0 then
                  strSQL:=strSQL+  SB.UtilSQL.DataToSQLData(ListaVndProtel.daValor('Datavencimento').asdatetime)+','
                 Else
                  strSQL:=strSQL+  SB.UtilSQL.DataToSQLData(ListaVndProtel.daValor('DataDoc').asdatetime)+',';

                 strSQL:=strSQL+  sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('Valor').asFloat,FFormatDecimalSQl)+','
                 +sb.UtilSQL.DecimalToSQLStr(ListaVndProtel.daValor('ValorIva').asFloat,FFormatDecimalSQl)+','

                 +#39+ListaVndProtel.daValor('Artigo').asstring+#39 +','
                 +#39+ListaVndProtel.daValor('Armazem').asstring+#39  +','
                 +#39+ListaVndProtel.daValor('Iva').asstring+#39 +','
                 +#39+ListaVndProtel.daValor('tipomovimento').asstring+#39 +','
                 +#39+ListaVndProtel.daValor('nomecliente').asstring+#39 +','
                 + IntTostr(ListaVndProtel.daValor('ID_Pagamento').asinteger)+','
                 +#39+ListaVndProtel.daValor('CC_Cliente').asstring+#39+','
                 + IntTostr(ListaVndProtel.daValor('ID_Hotel').asinteger)+','
                 +#39+Ncontribuinte+#39 +','
                 + IntTostr(Mercado) +','
                 + sb.UtilSQL.BoolToSQLStr(false)+','
                  +#39+ListaVndProtel.daValor('MoradaEntidade').asstring+#39 +','
                  +#39+ListaVndProtel.daValor('codigopostalentidade').asstring+#39 +','                  
                  +#39+ListaVndProtel.daValor('localidadeEntidade').asstring+#39 +','

                  +#39+ListaVndProtel.daValor('TelefoneEntidade').asstring+#39 +','
                  + SB.UtilSQL.BoolToSQLStr(ListaVndProtel.daValor('NCForaPerIVA').asBoolean)
                 +')';
                try
                    sb.SBBD.Executa(strSQL);
                except
                       try
                            caminho:=ExtractFilePath(Application.ExeName);
                            AssignFile(txtFileR,caminho+'sqlInsertTemp.TXT');
                            Rewrite(txtFileR);
                            Writeln(txtFileR,strSQL);
                            CloseFile(txtFileR);
                        except
                        end;
                end;


             end;
           ListaVndProtel.seguinte;
        end;
    Finally
     Try

     except
     end;

    end;

end;



function  DaListaVendasAgrupadasPorTipodocContaLanc:TSBBETabeladados;
var
   strSQL,strSQL1,caminho:string;
   ID_Lote,ID_LotePagamento,id_DocInterno:Integer;
   Ordem:Integer;
     txtFileR: TextFile;

begin
   ID_Lote:=1;
   Ordem:=1;
   ID_LotePagamento:=1;
   sb.SBBD.Executa('delete from '+FVendasPrimavera);


    strSQL:=' select '+FvendasProtel+'.ID_InternoDoc,'
    +' sum('+FvendasProtel+'.ValorLiquido) as ValorLiquido,sum('+FvendasProtel+'.Valor) as Total,'
    +' sum('+FvendasProtel+'.ValorIva) as ValorIva,'
    +' '+FvendasProtel+'.ID_TipoDocumento as ID_TipodocumentoProtel,'
    +'TiposDocumentosVnd.ContaCbl as ContaCblTipoDocumento,'
     +' '+FvendasProtel+'.ID_documento,'+FvendasProtel+'.ID_CodigoCliente,'
     +' '+FvendasProtel+'.dataDoc, '+FvendasProtel+'.dataVencimento,tiposDocumentosVnd.Pms_Tipodoc as DescTipodoc,'
     + ' ContasLancamentoVnd.ContaCBLFamilia '
     + ' ,ContasLancamentoVnd.ContaCBLIVA '
     + ', ContasLancamentoVnd.ClasseIVA'
     + ' ,ContasLancamentoVnd.ContaCCusto,ContasLancamentoVnd.ContaAnalitica  '

     + ' ,ContasLancamentoVnd.ContaCBLFamiliaNCperIVAdifFACT '
     + ' ,ContasLancamentoVnd.ContaCBLIVANCperIVAdifFACT'
     + ' ,ContasLancamentoVnd.ClasseIVANCperIVAdifFACT '
     + ' ,ContasLancamentoVnd.ContaCCustoNCperIVAdifFACT,'
     +' ContasLancamentoVnd.ContaAnaliticaNCperIVAdifFACT  '




    +'  ,'+FvendasProtel+'.Descricaoartigo,'+FvendasProtel+'.DescricaoIVA,'+FvendasProtel+'.descricaodoc'
     +', TiposDocumentosVnd.natureza,TiposDocumentosVnd.NaturezaNeg,TiposDocumentosVnd.NaturezaPag,'
     +' TiposDocumentosVnd.NaturezaPagNeg,'
     +' '+FvendasProtel+'.tipomovimento,'+FvendasProtel+'.nomecliente'
     +', CBL_ModoPagamentoPMS.contaCbl as  ContaCBLPagamento,'+FvendasProtel+'.TipoMovimento,'+FvendasProtel+'.id_modoPagamento'
     +', '+FvendasProtel+'.contacblCliente,'+FvendasProtel+'.id_hotel,'+FvendasProtel+'.Ncontribuinte,'+FvendasProtel+'.mercado ,'+FvendasProtel+'.DocTotalZERO '
     +', '+FvendasProtel+'.Nomecliente,'+FvendasProtel+'.Morada,'+FvendasProtel+'.Localidade,'+FvendasProtel+'.CodigoPostal,'+FvendasProtel+'.Telefone'
    +', '+FvendasProtel+'.NcForaPerIVA'

     +' from '+FvendasProtel+''

     +' inner join CBL_TipoDocPMS As TiposDocumentosVnd on TiposDocumentosVnd.Pms_Id_Tipodoc='+FvendasProtel+'.ID_TipoDocumento'

     +' Left join CBL_contaFamiliaPMS as ContasLancamentoVnd on ContasLancamentoVnd.PMS_ID_ContaFamilia='+FvendasProtel+'.ID_contaLanc'
       +' and ContasLancamentoVnd.PMS_ID_TipoDoc='+FvendasProtel+'.ID_TipoDocumento'
    +' and ContasLancamentoVnd.mercado='+FvendasProtel+'.mercado'
     +' and ContasLancamentoVnd.Pms_Id_Tipodoc= TiposDocumentosVnd.Pms_Id_Tipodoc'
     +' Left join CBL_ModoPagamentoPMS  on CBL_ModoPagamentoPMS.PMS_ID_ModoPagamento='+FvendasProtel+'.ID_ModoPagamento'
     +' and  CBL_ModoPagamentoPMS.id_Hotel='+FvendasProtel+'.id_Hotel';

        If FIDSHoteis<>''  then
        begin

            strSQL:=strSQL +'  where '+FvendasProtel+'.ID_Hotel IN('+FIDSHoteis+')';

        end
       else
        strSQL:=strSQL+'  where 1=1 ';


  strSQL:=strSQL  +' Group By naturezatipodoc,'+FvendasProtel+'.ID_InternoDoc,'+FvendasProtel+'.ID_TipoDocumento,'
    +'TiposDocumentosVnd.ContaCbl ,'
     +' '+FvendasProtel+'.ID_documento,'+FvendasProtel+'.ID_CodigoCliente,'
     +' '+FvendasProtel+'.dataDoc,'+FvendasProtel+'.dataVencimento,tiposDocumentosVnd.Pms_Tipodoc ,'
     +' ContasLancamentoVnd.ContaCBLFamilia,ContasLancamentoVnd.ContaCBLIVA,ContasLancamentoVnd.ClasseIVA,'
     +'  '+FvendasProtel+'.Descricaoartigo,'+FvendasProtel+'.DescricaoIVA,'+FvendasProtel+'.descricaodoc'
     +', TiposDocumentosVnd.natureza,TiposDocumentosVnd.NaturezaNeg,TiposDocumentosVnd.NaturezaPag,'
     +' TiposDocumentosVnd.NaturezaPagNeg '
     +', '+FvendasProtel+'.tipomovimento,'+FvendasProtel+'.nomecliente,CBL_ModoPagamentoPMS.contaCbl'
     +', '+FvendasProtel+'.id_modoPagamento,  '+FvendasProtel+'.contacblCliente,'+FvendasProtel+'.id_hotel,'+FvendasProtel+'.Ncontribuinte ,'+FvendasProtel+'.Mercado,'+FvendasProtel+'.DocTotalZERO'
     +', ContasLancamentoVnd.ContaCCusto,ContasLancamentoVnd.ContaAnalitica'
     +', '+FvendasProtel+'.Nomecliente,'+FvendasProtel+'.Morada,'+FvendasProtel+'.Localidade,'+FvendasProtel+'.CodigoPostal,'+FvendasProtel+'.Telefone'

     + ' ,ContasLancamentoVnd.ContaCBLFamiliaNCperIVAdifFACT '
     + ' ,ContasLancamentoVnd.ContaCBLIVANCperIVAdifFACT'
     + ' ,ContasLancamentoVnd.ClasseIVANCperIVAdifFACT '
     + ' ,ContasLancamentoVnd.ContaCCustoNCperIVAdifFACT, '
     +' ContasLancamentoVnd.ContaAnaliticaNCperIVAdifFACT ,NcForaPerIVA '



   +' order by '+FvendasProtel+'.ID_InternoDoc,'+FvendasProtel+'.datadoc,  '+FvendasProtel+'.ID_TipoDocumento ,'+FvendasProtel+'.ID_documento,'+FvendasProtel+'.tipomovimento,'+FvendasProtel+'.nomecliente,'
     +' TiposDocumentosVnd.ContaCbl,'+FvendasProtel+'.descricaodoc,'
     +' '+FvendasProtel+'.contacblCliente,'+FvendasProtel+'.id_hotel,'+FvendasProtel+'.Ncontribuinte,'+FvendasProtel+'.Mercado,'
     +' ContasLancamentoVnd.ContaCCusto,ContasLancamentoVnd.ContaAnalitica';




   Try
         caminho:=ExtractFilePath(Application.ExeName);
        AssignFile(txtFileR,caminho+'sqlpms1.TXT');
        Rewrite(txtFileR);
        Writeln(txtFileR,strSQL);
        CloseFile(txtFileR);
    except
    end;

      Result:=sb.SBBD.AbrirLV(strSQL);
      Result.inicio;

      id_DocInterno:=Result.davalor('ID_InternoDoc').asinteger;
      While Not(Result.NoFim) do
      begin
         If Result.davalor('ID_InternoDoc').asinteger<>id_DocInterno then
         begin
             Ordem:=1;
             ID_LotePagamento:=ID_Lote;
             id_DocInterno:=Result.davalor('ID_InternoDoc').asinteger;
         end;
         IF   Result.DAVALOR('tipomovimento').asstring='0' then
         begin
          InsereLinhaAgrupadaValorSemIVA(Result,ID_Lote,Ordem);
          If  Result.DAVALOR('ContaCCusto').asstring<>'' then
          begin
              inc(ordem);
              InsereLinhaAgrupadaCentroCusto(Result,ID_Lote,ordem);
          end;

          If  Result.DAVALOR('ContaAnalitica').asstring<>'' then
          begin
              inc(ordem);
              InsereLinhaAgrupadaContaAnalitica(Result,ID_Lote,ordem);
          end;



          If fEnviaLinhaIva then
          begin
              inc(ordem);
              InsereLinhaAgrupadaValorDoIVA(Result,ID_Lote,ordem);
          end;
          Inc(ID_Lote);
         end
         else
         begin
          inc(ordem);
          InsereLinhaPagamento(Result,ID_LotePagamento,ordem);
         end;
         Result.seguinte;
      end;

      Result.fecha;

strSQL1:= 'SELECT [ID_Documento]'
  +'    ,[ID_TipoDocumento]'
  +'      ,[DescricaoTipoDoc]'
  +'      ,[Descricaodoc]'
  +'      ,[SerieDoc]'
  +'      ,[TipoLinha]'
  +'      ,sum(Valor) as Valor'
  +'      ,sum(Valorlinha) as ValorLinha'
  +'      ,sum(ordem) as ordem'
  +'      ,[ContaCBLFamilia]'
  +'      ,[ContaCBLIVA]'
  +'      ,[ContaCBLPAG]'
  +'      ,[ContaCBLTipoDOC]'
  +'      ,[ID_CodigoCliente]'
  +'      ,[DataDoc]'
  +'      ,[DescricaoLinha]'
  +'      ,[IVA]'
  +'      ,[NomeCliente]'
  +'      ,[TipoMovimento]'
  +'      ,[Natureza]'
  +'      ,[id_ModoPagamento]'
  +'      ,[ContaCBLCliente]'
  +'      ,[id_internodoc],ClasseIVA,ContaCCusto, Contaanalitica,id_lote,'
  +' id_hotel,Ncontribuinte,mercado,DocTotalZERO,TipoLinhaFich,'
  +' Morada ,Localidade ,CodigoPostal,Telefone '

  +'  FROM '+FVendasPrimavera;


        If FIDSHoteis<>''  then
        begin
            strSQL1:=strSQL1 +'  where '+FVendasPrimavera+'.ID_Hotel IN('+FIDSHoteis+')';

        end
        else
        strSQL1:=strSQL1      +' Where 1=1 ';
//  If edtipodoc.Text<>'' then
  //  strSQL1:= strSQL1 +' and  ID_TipoDocumento='+edtipodoc.Text;

  If FOmitirValoresZero then
  begin
      strSQL1:= strSQL1 +' and  DocTotalZERO='+SB.UtilSQL.BoolToSQLStr(false);

    {  If FOmitirLinhaIVA0perc=true then
          strSQL1:= strSQL1 +' and  (valor<>0) '
      else
       strSQL1:= strSQL1 +' and  (valorLinha<>0) ';}

  end
  else
  begin
     If FOmitirLinhaIVA0perc=true then
          strSQL1:= strSQL1 +' and  (TipoLinha in(0,2,3,4,5,6) OR (TipoLinha=1 and valor<>0)) '
  end;

strSQL1:= strSQL1
  +'  Group by [id_internodoc],[ID_Documento]'
  +'      ,[ID_TipoDocumento] '
  +'      ,[DescricaoTipoDoc]'
  +'      ,[Descricaodoc]'
  +'      ,[SerieDoc]'
  +'      ,[TipoLinha]'

  +'      ,[ContaCBLFamilia]'
  +'      ,[ContaCBLIVA] '
  +'      ,ClasseIVA'
  +'      ,[ContaCBLPAG]'
  +'      ,[ContaCBLTipoDOC]'
  +'      ,[ID_CodigoCliente]'
  +'      ,[DataDoc]'
  +'      ,[DescricaoLinha]'
  +'      ,[IVA]'
  +'      ,[NomeCliente]'
  +'      ,[TipoMovimento]'
  +'      ,[Natureza]         '
  +'      ,[id_ModoPagamento]'
  +'      ,[ContaCBLCliente]'
  +'      ,[id_internodoc],id_Lote,id_hotel,Ncontribuinte,mercado,DocTotalZERO,TipoLinhaFich,contaCCusto, Contaanalitica'
  +',Morada ,Localidade ,CodigoPostal,Telefone'
  +' order by Id_internodoc,  tipomovimento,ID_Lote,ContaCBLFamilia' ;
result:=sb.SBBD.AbrirLv(strsql1);


end;


function daListaDocumentosPorexportar(pFiltroDocs:string;var strsql:string):Tsbbetabeladados;
var
  StrDocumentos:string;
begin
   Result:=Nil;
   If 1=1 then
   begin
    StrDocumentos:=DaIdsTipodocumento;
    If StrDocumentos<>'' then
    begin
         strsql:=PreencheTabelaTemporaria(FDataInicioExp,StrDocumentos,pFiltroDocs);
         Result:=DaListaVendasAgrupadasPorTipodocContaLanc;
    end
    else
       sb.Dialogos.SBAviso('Não existem tipos de documentos configurados para exportação!')
   end;


end;




Function ExportarVendasAutomatico():Boolean;
var
   ObjCabecalhos:TERPBEcblCabecalhos;
   ObjCab:TERPBECBLCab;
   ListaIDSDocs:TstringList;
   i:Integer;
   strdoc:string;
   strsql1,strsql,strMensagemErros:string;
  pListaDocs:Tsbbetabeladados;
begin
  Result:=false;
  pListaDocs:=daListaDocumentosPorexportar('',strsql1);
  If Not(pListaDocs.Vazia) then
  begin
       PreencheVariavaisConfGerais;
       pListaDocs.dataset.filtered:=false;
       pListaDocs.inicio;
       ListaIDSDocs:= DalistaIDDocs(pListaDocs);
       pListaDocs.inicio;
       ObjCabecalhos:=TERPBEcblCabecalhos.create;
       For i:=0 to ListaIDSDocs.Count-1 do
       begin
        Try
          ObjCab:=PreencheOBJDoc(pListaDocs,strtoint(ListaIDSDocs.strings[i]));
          ObjCabecalhos.Adiciona(ObjCab);
        Except
         raise;
        end;   
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
             strdoc:= ObjCabecalhos.Elem[i].Descricao
              +' nº'+ObjCabecalhos.Elem[i].NumDocumento+' Data '+DateToStr(ObjCabecalhos.Elem[i].Data);
          end;
           If ValidaExportacaoDocumento(ObjCabecalhos.Elem[i],strMensagemErros) then
             GravaDocvenda(ObjCabecalhos.Elem[i])
           else
           begin
             result:=false;
             SBBD.DesfazTransacao;
             EnviaEmailErroExporAuto(5, ObjCabecalhos.Elem[i].ID_DOCInterno,'Exportação CBL_Vendas-PMS',strdoc,strMensagemErros);
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
                   strMensagemErros:='Erro ao exportar  CBL_Vendas-PMS'+#13+E.Message+strdoc;

                 end;
                 On E:EErroDetalhe Do
                 Begin
                  result:=false;
                   SB.SBBD.DesfazTransacao;
                   strMensagemErros:='Erro ao exportar  CBL_Vendas-PMS'+#13+E.Detalhe+strdoc;
                 End
                 else
                 begin
                  result:=false;
                  if  strMensagemErros='' then
                        strMensagemErros:='Erro ao exportar CBL_Vendas-PMS';
                  SB.SBBD.DesfazTransacao;
                end;
               EnviaEmailErroExporAuto(5, ObjCabecalhos.Elem[i].ID_DOCInterno,'Exportação CBL_Vendas-PMS',strdoc,strMensagemErros);
               Freeandnil(ObjCabecalhos);
        end;
       end;
  end;
  if assigned(pListaDocs) then
    FreeAndNil(pListaDocs);

end;




end.    
