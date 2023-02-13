unit ERPPrimaveraCBLCompras;

interface
uses  sbbetabeladados,classes,ERPBECab,ERPBELinhadetalhe,ERPBELinhaPagamento,ERPBEEMPRESAINTERFACE,
ADODB,dateutils,Dialogs,SBBEExcepcoes,forms,ERPEnvioEmail,ERPLogOperacoes,ERPBECBLCab,ERPBECBLLinhaDetalhe;

Type
  TFntBETipoExportacao=(teTotalDocumento,teProduto,teSubFamilia,teFamilia,teGrupoFamilia);
          
  Procedure PreencheVariavaisConfGerais;
   Function DaListaDocumentosCompras1(pFiltro:string;pdataInicio,pdataFim:Tdatetime):tsbbetabeladados;

  Function ExportarComprasManual(pListaDocs:TsbbeTabeladados):Boolean;
  Function ValidaExportacao(var Mensagem:String):Boolean;
  procedure MarcaMovimentosComoExportados(pDataIni,pdatafim:tdatetime;pLista:tsbbetabeladados;pnomeInterface:string);
   procedure RemoveMarcaExportacaoFNT();
var
   FOBJInterface:TERPBEEMPRESAINTERFACE;
   FConexao:TADOConnection;
   FCONNECTIONSTRING:string;

   Ftipoexportacao:TFntBETipoExportacao;
   FContasProdutoPorIVA:boolean;
   FIDInterface,FperiodoIVA:integer;
   FContadorLote,
   FEnviaLinhaIva,
   FOmitirLinhaIVA0perc,
   FOmitirValoresZero,FContasPorMercado:Boolean;

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
   FShema:string;
   FContasIVASPorMercado:boolean;
   FClienteTabMETADATA:boolean;
   FExcluirDocsVndAnulados:boolean;
   FExpApenasComprasFechadas:Boolean;
   FListaContasMercado:TSBBETabelaDados;
   FID_CentroExploracao:integer;
   FID_INTERFACECENEXP:integer;



implementation
uses ierpOglobais,math,SysUtils,strutils, SBBaseDados, SBBSSistemaBase,
  SBBSUtilSQL,IERPFrmPrincipal, SBValor;



Procedure EnviaParaLogMovimenstosAlterados(pID_interno:Integer);
var
strsql:string;
begin
 strsql:='';
 strsql:=' INSERT INTO [LOGALTERP_CBLCMPCabec]'
          +' ([ID_Interno]'
           +',[ID_DOCInterno]'
           +',[Origem]'
           +',[Modulo]'
           +',[Ano]'
           +',[Mes]'
           +',[Dia]'
           +',[Data]'
           +',[Analitica]'
           +',[CCustos]'
           +',[Diario]'
           +',[Documento]'
           +',[NumDocumento]'
           +',[Descricao]'
           +',[DataHoraRegisto]'
           +',[TotalLinhas]'
           +',[UtilizadorRegisto]'
           +',[Integrado]'
           +',[DataHoraIntegracao]'
           +',[PRIMAVERA_ID]'
           +',[PRIMAVERA_Diario]'
           +',[PRIMAVERA_NumDiario]'
           +',[PRIMAVERA_Documento]'
           +',[PRIMAVERA_NumDocumento]'
           +',[ErroIntegracao]'
           +',[NIF]'
           +',[TipoEntidade]'
           +',[Entidade]'
           +',[NumeroDocumentoExterno]'
           +',[Nome]'
           +',[Morada]'
           +',[Localidade]'
           +',[CodigoPostal]'
           +',[Telefone]'
           +',[DataVencimento]'
           +',[PRIMAVERA_CCT_ID]'
           +',[PRIMAVERA_CCT_TipoDoc]'
           +',[PRIMAVERA_CCT_NumDoc]'
           +',[PRIMAVERA_CCT_Serie])'
           +' Select '
          +' [ID_Interno]'
           +',[ID_DOCInterno]'
           +',[Origem]'
           +',[Modulo]'
           +',[Ano]'
           +',[Mes]'
           +',[Dia]'
           +',[Data]'
           +',[Analitica]'
           +',[CCustos]'
           +',[Diario]'
           +',[Documento]'
           +',[NumDocumento]'
           +',[Descricao]'
           +',[DataHoraRegisto]'
           +',[TotalLinhas]'
           +',[UtilizadorRegisto]'
           +',[Integrado]'
           +',[DataHoraIntegracao]'
           +',[PRIMAVERA_ID]'
           +',[PRIMAVERA_Diario]'
           +',[PRIMAVERA_NumDiario]'
           +',[PRIMAVERA_Documento]'
           +',[PRIMAVERA_NumDocumento]'
           +',[ErroIntegracao]'
           +',[NIF]'
           +',[TipoEntidade]'
           +',[Entidade]'
           +',[NumeroDocumentoExterno]'
           +',[Nome]'
           +',[Morada]'
           +',[Localidade]'
           +',[CodigoPostal]'
           +',[Telefone]'
           +',[DataVencimento]'
           +',[PRIMAVERA_CCT_ID]'
           +',[PRIMAVERA_CCT_TipoDoc]'
           +',[PRIMAVERA_CCT_NumDoc]'
           +',[PRIMAVERA_CCT_Serie]'
           +' FROM ERP_CBLCMPCabec'
           +' where  ID_Interno='+inttostr(pID_Interno);
            sb.SBBD.Executa(strsql);

 strsql:=' INSERT INTO [LOGALTERP_CBLCMPLinhas]'
          + '([ID_Interno]'
           +',[ID_DOCInterno]'
           +',[NumLinha]'
           +',[TipoLinha]'
           +',[Conta]'
           +',[Descricao]'
           +',[Valor]'
           +',[TaxaIva]'
           +',[PercIvaNDev]'
           +',[IvaNDed]'
           +',[Natureza]'
           +',[TipoEntidade]'
           +',[Entidade]'
           +',[ClasseIva]'
           +',[ContaOrigem]'
           +',[TipoOperacao]'
           +',[Moeda]'
           +',[Cambio]'
           +',[ClasseIvaAutofaturacao]'
           +',[DataEmissaoDocumento]'
           +',[NumeroDocumentoExterno]'
           +',[Observacoes])'

          +  'seLect '
           +'[ID_Interno]'
           +',[ID_DOCInterno]'
           +',[NumLinha]'
           +',[TipoLinha]'
           +',[Conta]'
           +',[Descricao]'
           +',[Valor]'
           +',[TaxaIva]'
           +',[PercIvaNDev]'
           +',[IvaNDed]'
           +',[Natureza]'
           +',[TipoEntidade]'
           +',[Entidade]'
           +',[ClasseIva]'
           +',[ContaOrigem]'
           +',[TipoOperacao]'
           +',[Moeda]'
           +',[Cambio]'
           +',[ClasseIvaAutofaturacao]'
           +',[DataEmissaoDocumento]'
           +',[NumeroDocumentoExterno]'
           +',[Observacoes]'
           +' FROM ERP_CBLCMPLinhas'
           +' where  ID_Interno='+inttostr(pID_Interno);
            sb.SBBD.Executa(strsql);



end;



Function BD2TipoExportacao(pTipoExportacao: Integer): TFntBETipoExportacao;
begin
  case pTipoExportacao of
    0 : Result := teTotalDocumento;
    1 : Result := teProduto;
    2 : Result := teSubFamilia;
    3 : Result := teFamilia;
    4 : Result := teGrupoFamilia;
  end;
End;

Function daFormatDecimalSQl():string;
var
  i:integer;
begin
FNumCasaDecimaisVL:=4;
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

 Lstdados:TSBBETabelaDados;
begin
    id_Pagamentocc:=0;
    If assigned(FObjInterface) then
      FObjInterface:=nil;
    FObjInterface:= MotorERP.ERPInterface.Edita(FIDInterface);
    If FObjInterface<>nil then
    begin
        FShema:= FObjInterface.BDSchema;
        FExpApenasComprasFechadas:=FObjInterface.ExpApenasComprasFechadas;
        strsql:='Select * from '+ FShema+'FntInterfaceCenexp where ID_Interfacecenexp= '+Inttostr(FOBJInterface.ID_InterfaceIMC);
        Lstdados:=sb.SBBD.AbrirLV(strsql);
        If Not(Lstdados.Vazia) then
        begin
          FID_INTERFACECENEXP:=Lstdados.daValor('ID_Interfacecenexp').asInteger;
          FModulo:=Lstdados.daValor('ModuloVnd').asstring;
          FContasProdutoPorIVA:=Lstdados.daValor('ContasProdutoPorIVA').asboolean;
          FOmitirValoresZero:=Lstdados.daValor('OmitirValoresZero').asboolean;
          FOmitirLinhaIVA0perc:=Lstdados.daValor('OmitirLinhaDOIVAZERO').asboolean;



          FRefleteClasseIva:=Lstdados.daValor('RefleteClasseIva').asstring;
          FReflecteFluxos:=Lstdados.daValor('RefleteFluxos').asstring;
          FRefleteAnalitica:=Lstdados.daValor('RefleteAnalitica').asstring;
          FRefleteCentroCusto:=Lstdados.daValor('RefleteCentroCusto').asstring;
          FDiario:=Lstdados.daValor('DiarioVND').asstring;
          id_Pagamentocc:=Lstdados.daValor('ID_PagCredito').asInteger;
          FTipoAfetacao  :=Lstdados.daValor('TipoAfectacao').asstring;
          FFormatDecimalSQl:=daFormatDecimalSQl;
          FEnviaLinhaIva:=Lstdados.daValor('EnviaLinhasIVAs').asBoolean;
          FContasPorMercado:=Lstdados.daValor('ContasCblPormercado').asBoolean;
          FConnectionString:=FOBJInterface.BDConexao;

          Ftipoexportacao :=BD2TipoExportacao(Lstdados.daValor('tipoexportacao').asinteger);
          FperiodoIVA:=FOBJInterface.PeriodoIVA;
        end;
        FreeAndnil(lstdados);
    end
    else
    sb.Dialogos.SBAviso('Interface mal configurado!');
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
    end;
end;



Function ValidaExportacao(var Mensagem:String):Boolean;

begin
  Mensagem:='';
  result:=true;
  If assigned(FOBJInterface) then
  begin
     result:=true;
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
       Mensagem:='Não existe interface: "ERPCBL_ComprasSyscontroller" Ativo!';
  end;
end;







Function DalistaIDDocs(pListaDocs:TsbbeTabeladados):TstringList;
begin
     Result:=TstringList.create;
     pListaDocs.inicio;
     While Not(pListaDocs.NoFim)do
     begin
        If Result.IndexOf(pListaDocs.davalor('ID_Movimento').asstring)=-1 then
            Result.Add(pListaDocs.davalor('ID_Movimento').asstring);
        pListaDocs.seguinte;
     end;
end;

Function ValidaExportacaoDocumento(ObjCab:TERPBECBLCab;var mensagem:string):Boolean;
var
 i:integer;
 ListaD:Tsbbetabeladados;
 strsql:string;
 TotLinhasMov,Totlinhascusto:integer;
 listaIdCentroscusto:Tstringlist;
  Contacbl:string;
begin
  result:=true;
  mensagem:='';
  TotLinhasMov:=0;
  Totlinhascusto:=0;
  listaIdCentroscusto:=Tstringlist.create;
  If  ObjCab.Linhas.num=0 then
              mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Documento Sem Linhas:'+ ObjCab.Descricao;

  For i:=0 to  ObjCab.Linhas.Num-1 do
  begin
      Contacbl:=ObjCab.Linhas.elem[i].Conta;
      Contacbl:=TrimLeft(Contacbl);
      Contacbl:=TrimRight(Contacbl);
      If Length(contacbl)<=0 then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Falta Conta CBL: '+ ObjCab.Linhas.elem[i].Descricao;

      If   ObjCab.Linhas.elem[i].TipoLinhaInt=0   then
      begin
         inc(TotLinhasMov);
      end;

      If   ObjCab.Linhas.elem[i].TipoLinhaInt=2   then
      begin
        If  listaIdCentroscusto.indexof(inttostr(ObjCab.Linhas.elem[i].id_linhamov))=-1 then
         listaIdCentroscusto.Add(inttostr(ObjCab.Linhas.elem[i].id_linhamov));
      end;
  end;

  If  ObjCab.Obrigacentrocusto=true then
  begin
    If   (listaIdCentroscusto.count<TotLinhasMov) then
    begin
       If mensagem<>'' then
        mensagem:=mensagem+#13;
       mensagem:=mensagem+'Existem Linhas de movimentos sem centro de custo';
    end;
  end;

  If mensagem<>'' then
  begin
   mensagem:='Documento nº'+ObjCab.NumDocumento+' '+ObjCab.Descricao+#13+mensagem;
   result:=false;
  end;
  If Result then
  begin
          ListaD:=sb.SBBD.AbrirLV('select id_interno, ID_docInterno from ERP_CBLCMPCabec  where ID_docInterno='+Inttostr(ObjCab.ID_DOCInterno));
          If Not(ListaD.vazia) then
          begin
            ObjCab.EmModoEdicao:=true;
            ObjCab.ID_interno:=Listad.davalor('id_interno').asinteger;
          end;
          ListaD.fecha;
  end;
  Freeandnil(listaIdCentroscusto);


end;






Procedure InsereLinha(Objcabec:TERPBECBLcab;ObjLinha:TERPBECBLLinha;pID_Hotel:Integer);
var
 stsql:string;
 i:integer;
begin

  With ObjLinha do
  Begin
    stsql:=' INSERT INTO  ERP_CBLCMPLinhas'
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
           +', ClasseIva,ClasseIvaAutofaturacao'
           +', ContaOrigem'
           +', TipoOperacao'
           +', Moeda'
           +', Cambio,mpehotel,DataEmissaoDocumento,TaxaIVA,percivaNDev,IvaNded)'
           +' values( '
           + IntToStr(ObjLinha.ID_interno)
           +','+ IntToStr(ObjLinha.ID_DOCInterno)
           +',' +IntToStr(ObjLinha.NumLinha)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.TipoLinha)
           +', '+sb.utilsql.StrToSQLStrpelica(ObjLinha.Conta)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.Descricao)
           +', '+sb.utilsql.DecimalToSQLStr(ObjLinha.Valor,'0.0000')
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.Natureza)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.TipoEntidade)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.Entidade)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.ClasseIva)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.ClasseIvaAutofaturacao)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.ContaOrigem)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.TipoOperacao)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.Moeda)
           +','+sb.utilsql.DecimalToSQLStr(ObjLinha.Cambio)
           +',' +IntToStr(pID_Hotel)
           +','+sb.utilsql.DataToSQLData(Objcabec.Data)
           +','+sb.utilsql.StrToSQLStrpelica(ObjLinha.taxaIVA)
            +', '+sb.utilsql.DecimalToSQLStr(ObjLinha.PercIvaNDev,'0.00')
            +', '+sb.utilsql.DecimalToSQLStr(ObjLinha.IvaNDed,'0.0000')
           +')';
          sb.SBBD.Executa(stsql);

   end;
end;


Procedure GravaDocCompras(ObjCab:TERPBECBLCab);
var
 stsql:widestring;
 i:integer;
 ProximoID_InternoDoc:integer;
begin

Try
  If ObjCab.EmModoEdicao then
   begin
    ObjCab.ID_interno:=ObjCab.ID_Interno;
    EnviaParaLogMovimenstosAlterados(ObjCab.ID_interno);


    stsql:=' UPDATE [ERP_CBLCMPCabec]'
           +'   SET '
           + ' Origem=' + IntToStr(ObjCab.Origem)
           +',Modulo='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Modulo)
           +',Ano = '+ inttostr(ObjCab.Ano)
           +',Mes = '+ inttostr(ObjCab.Mes)
           +',Dia = '+ inttostr(ObjCab.dia)
           +',Data = '+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.Data)
           +',Analitica = '+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Analitica)
           +',CCustos = '+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CCustos)
           +',Diario = '+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Diario)
           +',Documento = '+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Documento)
           +',NumDocumento = '+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.NumDocumento)
           +',Descricao = '+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Descricao)
           +',DataHoraRegisto = '+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.DataHoraRegisto)

           +',TotalLinhas='+ inttostr(ObjCab.TotalLinhas)
           +',UtilizadorRegisto='+ sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
           +',Integrado=0'
           +',NIF='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.NIF)
           +',tipoentidade='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.tipoentidade)
           +',entidade='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.entidade)
           +',nome='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.nome)
           +',Morada='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Morada)
           +',localidade='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.localidade)
           +',CodigoPostal='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodigoPostal)
           +',Telefone='+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Telefone)
           +',DataVencimento='+ sb.UtilSQL.DataToSQLData(ObjCab.DataVencimento)
           +' where  ID_interno='+ inttostr(ObjCab.ID_interno);






          sb.SBBD.Executa(stsql);
          sb.SBBD.Executa('delete from  ERP_CBLCmpLinhas where  ID_interno='+ inttostr(ObjCab.ID_interno));

   end
   else
   begin
        ProximoID_InternoDoc:=sb.ProximoID('ERP_CBLCOMPCAB',true);
        With ObjCab do
        Begin
          ObjCab.ID_interno:=ProximoID_InternoDoc;
          stsql:='INSERT INTO [ERP_CBLCMPCabec]'
                 +'([ID_Interno] '
                 +',[ID_DOCInterno]'
                 +',[Origem]  '
                 +',[Modulo]'
                 +',[Ano]'
                 +',[Mes] '
                 +',[Dia] '
                 +',[Data] '

                 +',[AnoMov]'
                 +',[MesMov] '
                 +',[DiaMov] '
                 +',[DataMov] '

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
                 +',[DataVencimento],mpehotel,NomeBaseDados,integrado'
                +',CodPais,DescPais ,Mercado ,DescMercado'
                 +')'
                +' values( '
                 +inttostr(ObjCab.ID_interno)
                 +','+ inttostr(ObjCab.ID_DOCInterno)
                 +','+ inttostr(ObjCab.Origem)
                 +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.Modulo)
                 +','+ inttostr(ObjCab.ano)
                 +','+ inttostr(ObjCab.mes)
                 +','+ inttostr(ObjCab.dia)
                +','+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.Data)

               +','+ inttostr(ObjCab.anoMov)
                 +','+ inttostr(ObjCab.mesMov)
                 +','+ inttostr(ObjCab.diaMov)
                +','+ sb.UtilSQL.DateTimeToSQLDataHora(ObjCab.DataMov)

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
                 +',0 '
                +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.CodPais)
                +','+ sb.UtilSQL.StrToSQLStrpelica(ObjCab.DescPais)
                +','+ IntToStr(ObjCab.Mercado)
                +','+ sb.UtilSQL.StrToSQLStrpelica(DescMercado)


                 +')';
                sb.SBBD.Executa(stsql);
           end;
      end;
       For i:=0 to ObjCab.Linhas.Num-1 do
       begin
         ObjCab.Linhas.elem[i].ID_interno:= ObjCab.ID_interno;
         InsereLinha(ObjCab,ObjCab.Linhas.elem[i],objCab.mpehotel);

       end;
except
raise;
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



Function PreencheOBJDoc(pListaDocs:TsbbeTabeladados;pid_Internodoc:Integer):TERPBECBLCab;
var
    ObjLinha:TERPBECBLLinha;
    Linha:integer;
    Contamovimentar:string;
    ttZeros,j:integer;
    CodClientePMS:string;
    id:integer;

begin
id:= pid_Internodoc;
  pListaDocs.dataset.filtered:=false;
  pListaDocs.dataset.filter:='ID_Movimento='+Inttostr(pid_Internodoc);
  pListaDocs.dataset.filtered:=true;
  If  Not pListaDocs.Vazia then
  begin

    Result:=TERPBECBLCab.Create;
    Result.EmModoEdicao:=false;
    Result.Obrigacentrocusto:= pListaDocs.davalor('ObrigaCentroCustoConcluir').asboolean;
    Result.ID_DOCInterno:= pListaDocs.davalor('ID_Movimento').asinteger;
    Result.mpehotel:=0;
    Result.NumDocumento:= pListaDocs.davalor('id_documento').asstring;
    Result.Documento:= pListaDocs.davalor('VNDCONTACBL').asstring;
    Result.Origem:=FOBJInterface.ID;
    Result.modulo:=Fmodulo;
    Result.Descricao := pListaDocs.davalor('TipoDoc').asstring+'\'+pListaDocs.davalor('Seriedoc').asstring
         +'Nº'+pListaDocs.davalor('ID_Documento').asstring;
    Result.Diario:=pListaDocs.davalor('diariodoc').asstring;
    Result.Analitica:=FRefleteAnalitica;
    Result.CCustos:=FRefleteCentroCusto;
    result.TotalLinhas:= pListaDocs.NumLinhas;
    result.Nif := pListaDocs.davalor('ContribuinteEntidade').asstring;
    result.ano :=Yearof(pListaDocs.davalor('data').asdatetime);
    result.mes :=Monthof(pListaDocs.davalor('data').asdatetime);
    result.dia :=DayOf(pListaDocs.davalor('data').asdatetime);
    result.Data :=pListaDocs.davalor('data').asdatetime;

    result.anoMov :=Yearof(pListaDocs.davalor('dataMov').asdatetime);
    result.mesMov :=Monthof(pListaDocs.davalor('dataMov').asdatetime);
    result.diaMov :=DayOf(pListaDocs.davalor('dataMov').asdatetime);
    result.DataMov :=pListaDocs.davalor('dataMov').asdatetime;


    result.TipoEntidade:='F';



    result.nome:= pListaDocs.davalor('DescricaoEntidade').asstring;
    result.Morada:= pListaDocs.davalor('Morada').asstring;
    result.Localidade:= pListaDocs.davalor('Localidade').asstring;
    result.CodigoPostal:= pListaDocs.davalor('CodigoPostal').asstring;
    result.Telefone:= pListaDocs.davalor('Telefone').asstring;
    Result.DataVencimento:= pListaDocs.davalor('Data').asdatetime;
    Result.ID_cliente:= pListaDocs.davalor('ID_CodigoCliente').asinteger;
    Result.entidade:= pListaDocs.davalor('ContaCBLfORN').asstring;
    Result.Integrado:=False;
    Result.DataHoraRegisto:=now;
    Result.UtilizadorRegisto:=Sb.UtilizadorActual.Login;
    Result.CodPais:= pListaDocs.davalor('PaisISO').asstring;
    Result.DescPais:= pListaDocs.davalor('DescPais').asstring;
    Result.mercado:= pListaDocs.davalor('Mercado').asinteger;
    Result.DescMercado:=DadescMercado(Result.mercado);


    Linha:=0;
    While Not (pListaDocs.NoFim) do
    begin
         Contamovimentar:='';
         ObjLinha:=TERPBECBLLinha.create;
         With ObjLinha do
         begin
            ID_DOCInterno:=pListaDocs.davalor('ID_Movimento').asinteger;
            NumLinha:=Linha+1;
            ID_LinhaMov:=pListaDocs.davalor('ID_Linha').asinteger;
            TipoLinha:=pListaDocs.davalor('linhaFich').asstring;
            TipoLinhaInt:=pListaDocs.davalor('TipoLinha').asinteger;
            descricao:=pListaDocs.davalor('DescricaoLinha').ASSTRING;
            Descricao:=sb.UtilStr.CSSubstituiStr(Descricao,#39,#39#39);
            TaxaIva:=pListaDocs.davalor('TaxaIva').ASSTRING;

            If pListaDocs.davalor('tipoLinha').asinteger=0 then
            begin
                IvaNDed:=pListaDocs.davalor('valorIVANaoDedutivel').Asfloat;
                 PercIvaNDev:=pListaDocs.davalor('percIVANaoDedutivel').Asfloat;
            end;
            TipoEntidade:='F';
            Cambio:=1.0000000;
            Moeda:='EUR';
            CONTA:=pListaDocs.davalor('Conta').asstring;
            ClasseIVA:=pListaDocs.davalor('ClasseIVA').asstring;
            CONTAORIGEM:=pListaDocs.davalor('Contaorigem').asstring;
            Natureza:=pListaDocs.davalor('Natureza').asstring;
            If pListaDocs.davalor('TemIVAAutoLiquidacao').asBoolean then
              ClasseIvaAutofaturacao:=pListaDocs.davalor('ClasseIVAAL').asstring;
            valor:=0;
            valor:=abs(pListaDocs.davalor('Valor').asFloat);
            inc(Linha);
        end;
        Result.Linhas.Adiciona(ObjLinha);
        pListaDocs.seguinte;

    end;
  end;

end;

Function ExportarComprasManual(pListaDocs:TsbbeTabeladados):Boolean;
var
   ObjCabecalhos:TERPBEcblCabecalhos;
   ObjCab:TERPBECBLCab;
   ListaIDSDocs:TstringList;
   i:Integer;
   strsql,strMensagemErros:string;
   entrouerro:boolean;
begin
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


         end;

       end;

       If ObjCabecalhos.num>0 then
       begin
        SBBD.IniciaTransacao;
        try
         For i:=0 to  ObjCabecalhos.Num-1 do
         begin
           If ValidaExportacaoDocumento(ObjCabecalhos.Elem[i],strMensagemErros) then
              GravaDocCompras(ObjCabecalhos.Elem[i])
           else
           Raise
               SB.ErroNormal(0,'Exportação de Compras Interrompida','Grava Documento',strMensagemErros);
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

                raise EErroDetalhe.Create('Exportação Cbl Compras','','Não foi possível exportar.',E.Detalhe);
              End;
              On E :Exception Do
              Begin
                 entrouerro:=true;
                 Result:=false;
                 if assigned(ObjCabecalhos) then
                   freeandnil(ObjCabecalhos);
                 SBBD.DesfazTransacao;
                 raise EErroDetalhe.Create('Exportação Cbl Compras','','Não foi possível exportar.',E.Message);
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



procedure MarcaMovimentosComoExportados(pDataIni,pdatafim:tdatetime;pLista:tsbbetabeladados;pnomeInterface:string);
var
 Nomeinterface,strsql:string;
 id_Interno:integer;
 ListaIDDocs:tstringList;
    txtFileR: TextFile;
   caminho:string;

begin
 ListaIDDocs:=tstringList.create;
 pLista.dataset.filtered:=false;
 Nomeinterface:='ERP_CBLCOMPRAS';
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
                  +','+sb.UtilSQL.StrToSQLStrpelica(pLista.davalor('DescricaoEntidade').asstring)
                  +','+sb.UtilSQL.DataToSQLData(pLista.davalor('data').asdatetime)
                  +',1)';

          sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);

          strsql:='update movimentostock set CBLExportado=1'
          +',    ID_LogCabCBLExportacao='+Inttostr(id_interno)
          +',  CBLExportadopor='+sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
          +',  CBLExportadoDTHora='+sb.UtilSQL.DateTimeToSQLDataHora(sb.DataSistema)
          +' Where id_Movimento='+Inttostr(pLista.davalor('id_movimento').asinteger);
          sb.SBBD.ExecutaSqlExterno(FCONNECTIONSTRING,strsql);
          ListaIDDocs.Add(pLista.davalor('id_movimento').asstring)
      end;
   pLista.seguinte;
 end;

 Freeandnil(ListaIDDocs);
end;






Function DaListaDocumentosCompras1(pFiltro:string;pdataInicio,pdataFim:Tdatetime):tsbbetabeladados;

var
   stsrql,
   stsrqlMov,stsrqlMovIVA,stsrqlMovIVAAUTLIQ,stsrqlMovRetencaoIVA,
   stsrqlCcusto,stsrqlAnali,stsrqlPag,stsrqlPag1:string;
   EnviaLinhasIvas:boolean;
    txtFileR: TextFile;
   caminho:string;
begin
    EnviaLinhasIvas:= FEnviaLinhaIva;
    stsrql:='select  TipoLinha,LinhaFich,VNDCONTACBL'
          +'  ,CONTA,ContaOrigem,ClasseIVA, '
          +' CASE When TemIVAAutoLiquidacao=1 then classeIVAAL else '''' end as classeIVAAL,Sum(VALOR) as Valor,ID_Movimento,'
          +'  DescricaoLinha,ContaCBLForn,ID_Documento,TipoDoc,Seriedoc,TipoOperacao'
          +' ,data,datamov,liquidacaoAutomatica,natureza,descricaoEntidade'
          +', DiarioDoc,estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora,subfamilia'
          +' ,Morada,Localidade,CodigoPostal,Telefone, ID_CodigoCliente,'
          +'ContribuinteEntidade,TAXAIVA,ObrigaCentroCustoConcluir,id_Linha,TemIVAAutoLiquidacao,PercIVADedutivel'
          +',PercIVANaoDedutivel,ValorIVADedutivel,ValorIVAnaoDedutivel,iD_entidade'
          +' ,Mercado,PaisISO,descPais' ;

         stsrql :=stsrql+' from      (';

         stsrqlMov:='select 0 as TipoLinha,Movimentostock.TemIvaAutoLiquidacao,''F'' as LinhaFich,' ;

          If FperiodoIVA>0 then
          begin
             //conta   produto
             stsrqlMov:=stsrqlMov  +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
             +' CASE'
             +'  WHEN isnull(V_perIVA.ID_MovimentoDev,0)>0 THEN'
             +'    CodigoExternoFPerIVA'
             +'  else  codigoExternoD'
             +'  end'
             +' else'
             +' CASE'
             +'  WHEN (tipoMovimento.id_movimentacao =0)THEN'
             +'     codigoExterno'
             +'  end'
             +' end as Conta,'

             //classe IVa
              +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
              +' CASE'
              +'  WHEN isnull(V_perIVA.ID_MovimentoDev,0)>0 THEN'
              +'   classeIVAFPerIVA'
              +'  else  classeIVAD'
              +'  end'
              +' else'
              +' CASE'
              +'  WHEN (tipoMovimento.id_movimentacao =0)THEN'
              +'     classeIVA'
              +'  end'
              +' end as classeIVA,'


            //classe IVa  AUTOliquidacao
              +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
              +' CASE'
              +'  WHEN isnull(V_perIVA.ID_MovimentoDev,0)>0 THEN'
              +'   classeIVAFPerIVAAL'
              +'  else  classeIVAD'
              +'  end'
              +' else'
              +' CASE'
              +'  WHEN (tipoMovimento.id_movimentacao =0)THEN'
              +'     classeIVAAL'
              +'  end'
              +' end as classeIVAAL,'


             //conta Origem
              + ' '''' as  ContaOrigem,' ;
          end
          else
          begin
              stsrqlMov:=stsrqlMov   + ' case when tipoMovimento.id_movimentacao=''0'' then IMCExportacaoProduto.codigoExterno else codigoExternoD'
            + ' end as Conta,'
            + ' case when tipoMovimento.id_movimentacao=''0'' then IMCExportacaoProduto.classeIVA else classeIVAD'
            + ' end as classeIVA,'
  //classe IVa  AUTOliquidacao
              +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
              +' classeIVAD'
              +' else'
              +'     classeIVAAL'
              +'  end'
              +' as classeIVAAL,'

            + ' '''' as  ContaOrigem,';
          end;


            stsrqlMov:=stsrqlMov   +' IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
           +' IMCTipoDocumentoVenda.diario as DiarioDoc,'
           + ' case when Linhamovimentostock.percIvaDedutivel<>100 then (ValorLinhaSemIVA+ValorIvaDedutivel)'
           +' else  ValorLinhaSemIVA  end As Valor,'
          +' movimentostock.id_movimento ,'
          +' Linhamovimentostock.id_Linha,tab_Produto.vdesc1 as DescricaoLinha'
          +' ,Movimentostock.Numdocumento as ID_Documento,tipoMovimento.abreviatura as TipoDoc,'
          +''' ''as Seriedoc,'
          +' tipoMovimento.id_movimentacao as TipoOperacao,Movimentostock.datade as data,'
          +' Movimentostock.data as dataMov,'
          +' tipoMovimento.liquidacaoAutomatica'
          +',IMCTipoDocumentoVenda.NaturezaProd as Natureza,Tab_cliente.contacbl as ContaCBLForn,'
          +' descricaoEntidade,'
          +' Movimentostock.estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
          +',TAB_SubFam.vdesc as subfamilia'
          +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
          +', vcont as ContribuinteEntidade'
          +', Linhamovimentostock.percentagemIVA as TAXAIVA,tipomovimento.ObrigaCentroCustoConcluir,Linhamovimentostock.percIVADedutivel'
          +',PercIVANaoDedutivel,ValorIVADedutivel,ValorIVAnaoDedutivel,Movimentostock.ID_entidade'
          +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'

          +' from '+ fshema+' Movimentostock';


         If FperiodoIVA>0 then
          begin
            If FperiodoIVA=1 then
            begin
             stsrqlMov:=stsrqlMov  +' left join '+fshema+'V_StkNotasCreditoForaPeriodoIvaMensal as V_perIVA '
             +'  on Movimentostock.id_movimento=V_perIVA.ID_MovimentoDev'

            end
            else
            If FperiodoIVA=2 then
            begin
             stsrqlMov:=stsrqlMov  +' left join '+fshema+'V_stkNotasCreditoForaPeriodoIvaTrimestral as V_perIVA '
             +'  on Movimentostock.id_movimento=V_perIVA.ID_MovimentoDev'
            end;
          end;





          stsrqlMov:=stsrqlMov  +' left join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=Movimentostock.ID_entidade'
          +' left join   '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
          +' inner join  '+ fshema+'Linhamovimentostock on Linhamovimentostock.id_Movimento=Movimentostock.id_Movimento'
          +' inner join  '+ fshema+'tipoMovimento on tipoMovimento.id_tipoMovimento=Movimentostock.id_tipoMovimento'
          +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd=Movimentostock.ID_TipoMovimento'
          +' inner join  '+ fshema+'FntInterFaceCenExp on FntInterFaceCenExp.ID_InterFaceCenExp=IMCTipoDocumentoVenda.ID_InterFaceCenExp '
          +' inner join  '+ fshema+'FntInterFace on FntInterFace.ID_InterFace=FntInterFaceCenExp.ID_InterFace '
          +' inner join  '+ fshema+'TAb_Produto on TAb_Produto.Vproduto= Linhamovimentostock.ID_Produto'
          +'  INNER JOIN  '+ fshema+'TAB_SubFam TAB_SubFam ON  '
          +' TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
          +' INNER JOIN  '+ fshema+'TAB_Familia TAB_Familia ON '
          +' TAB_SubFam.VCodFam = TAB_Familia.VCodFam '
          +' INNER  JOIN '+ fshema+' Tab_GrFamiliar Tab_GrFamiliar ON '
          +' TAB_Familia.vCodGrFam = Tab_GrFamiliar.VCodGrFam ';


         If FTipoExportacao=teProduto  then
          begin
           stsrqlMov:=stsrqlMov +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
           If FContasPorMercado=true then
                stsrqlMov:=stsrqlMov +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlMov:=stsrqlMov +' and (IMCExportacaoProduto.mercado=1)';

          end
          else
          If FTipoExportacao=teSubFamilia  then
          begin
           stsrqlMov:=stsrqlMov +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.VsubFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';

           If FContasPorMercado=true then
                stsrqlMov:=stsrqlMov +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlMov:=stsrqlMov +' and (IMCExportacaoProduto.mercado=1)';

          end
          else
          If FTipoExportacao=teFamilia  then
          begin
           stsrqlMov:=stsrqlMov +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_SubFam.VCodFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ' ;

           If FContasPorMercado=true then
                stsrqlMov:=stsrqlMov +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlMov:=stsrqlMov +' and (IMCExportacaoProduto.mercado=1)';

          end
          else
          If FTipoExportacao=teGrupoFamilia  then
          begin
           stsrqlMov:=stsrqlMov +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_Familia.VCodGrFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
           If FContasPorMercado=true then
                stsrqlMov:=stsrqlMov +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlMov:=stsrqlMov +' and (IMCExportacaoProduto.mercado=1)';
           
          end;


         If FContasProdutoPorIVA then
              stsrqlMov:=stsrqlMov +' and IMCExportacaoProduto.ID_IVA=Linhamovimentostock.ID_IVA';

         stsrqlMov:=stsrqlMov +' Where FntInterFaceCenExp.id_Interfacecenexp='+IntToStr(FID_INTERFACECENEXP)
          +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
          +' and TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0';
          IF   pFiltro<>'' then
             stsrqlMov:=stsrqlMov+' and '+ pFiltro;

         If  pdataInicio>0 then
               stsrqlMov:=stsrqlMov+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
          If  pdataFim>0 then
               stsrqlMov:=stsrqlMov+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

          if FExpApenasComprasFechadas then
                 stsrqlMov:=stsrqlMov+' and MovimentoStock.estado=1';



        If    EnviaLinhasIvas then
        begin
          stsrqlMovIVA:=  ' select 1 as TipoLinha,Movimentostock.TemIvaAutoLiquidacao,''F'' as LinhaFich,';

          If FperiodoIVA>0 then
          begin


             //conta IVa
             stsrqlMovIVA:=stsrqlMovIVA  +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
               +' CASE'
               +'  WHEN isnull(V_perIVA.ID_MovimentoDev,0)>0 THEN'
               +'   CodigoExternoIvaFPerIVA'
               +'  else  CodigoExternoIvaD'
               +'  end'
               +' else'
               +' CASE'
               +'  WHEN (tipoMovimento.id_movimentacao =0)THEN'
               +'     CodigoExternoIva'
               +'  end'
               +' end as Conta,'
             //conta Origem
             +''' '' as classeIVA,'
               +''' '' as classeIVAAL,'
             +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
             +' CASE'
             +'  WHEN isnull(V_perIVA.ID_MovimentoDev,0)>0 THEN'
             +'    CodigoExternoFPerIVA'
             +'  else  codigoExternoD'
             +'  end'
             +' else'
             +' CASE'
             +'  WHEN (tipoMovimento.id_movimentacao =0)THEN'
             +'     codigoExterno'
             +'  end'
             +' end as ContaOrigem,';
          end
          else
          begin
             stsrqlMovIVA:=stsrqlMovIVA  +' case when tipoMovimento.id_movimentacao=''0'' '
               + ' then IMCExportacaoProduto.codigoExternoIVA else codigoExternoIVAD'
               + ' end as CONTA,'
               +''' ''as classeIVA,'
               +''' ''as classeIVAAL,'               
               + ' case when tipoMovimento.id_movimentacao=''0'' then IMCExportacaoProduto.codigoExterno else codigoExternoD'
               + ' end as ContaOrigem,'
          end;



          stsrqlMovIVA:=stsrqlMovIVA
               + ' IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
               + ' IMCTipoDocumentoVenda.diario as DiarioDoc,'
               + ' case when Linhamovimentostock.percIvaDedutivel= 100 then'
               +'  Linhamovimentostock.ValorIVA else'
               +'  Linhamovimentostock.ValorIVADedutivel end as Valor'
               +' ,movimentostock.id_movimento ,'
               +' Linhamovimentostock.id_Linha,Tab_iva.Vdesc as DescricaoLinha'
               +' ,Movimentostock.Numdocumento as ID_Documento'
               +',tipoMovimento.abreviatura as TipoDoc,'
               +''' ''as Seriedoc,'
               +' tipoMovimento.id_movimentacao as TipoOperacao,Movimentostock.datade as data,'
               +' Movimentostock.data as dataMov,'               
               +'tipoMovimento.liquidacaoAutomatica'
               +',IMCTipoDocumentoVenda.NaturezaProd as Natureza,Tab_cliente.contacbl as ContaCBLForn,descricaoEntidade,'
               +' Movimentostock.estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
               +',TAB_SubFam.vdesc as subfamilia'
               +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
               +', vcont as ContribuinteEntidade'
               +', Linhamovimentostock.percentagemIVA as TAXAIVA,tipomovimento.ObrigaCentroCustoConcluir,Linhamovimentostock.percIVADedutivel'
               +',PercIVANaoDedutivel,ValorIVADedutivel,ValorIVAnaoDedutivel,Movimentostock.ID_entidade'
               +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'


               +' from  '+ fshema+'Movimentostock';

                If FperiodoIVA>0 then
                begin
                  If FperiodoIVA=1 then
                  begin
                   stsrqlMovIVA:=stsrqlMovIVA  +' left join '+fshema+'V_StkNotasCreditoForaPeriodoIvaMensal as V_perIVA '
                   +'  on Movimentostock.id_movimento=V_perIVA.ID_MovimentoDev'

                  end
                  else
                  If FperiodoIVA=2 then
                  begin
                   stsrqlMovIVA:=stsrqlMovIVA  +' left join '+fshema+'V_stkNotasCreditoForaPeriodoIvaTrimestral as V_perIVA '
                   +'  on Movimentostock.id_movimento=V_perIVA.ID_MovimentoDev'
                  end;
               end;

               stsrqlMovIVA:=stsrqlMovIVA  +'  left join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=Movimentostock.ID_entidade'
              +' left join   '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
              +' inner join  '+ fshema+'Linhamovimentostock on Linhamovimentostock.id_Movimento=Movimentostock.id_Movimento'
              +' inner join  '+ fshema+'tipoMovimento on tipoMovimento.id_tipoMovimento=Movimentostock.id_tipoMovimento'

              +' inner Join  '+ fshema+'tab_Iva on Tab_iva.vcodi=Linhamovimentostock.ID_Iva'
              +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= Movimentostock.id_tipoMovimento'
              +' inner join  '+ fshema+'FntInterFaceCenExp on FntInterFaceCenExp.ID_InterFaceCenExp=IMCTipoDocumentoVenda.ID_InterFaceCenExp '
              +' inner join  '+ fshema+'FntInterFace on FntInterFace.ID_InterFace=FntInterFaceCenExp.ID_InterFace '
              +' inner join  '+ fshema+'TAb_Produto on TAb_Produto.Vproduto= Linhamovimentostock.ID_Produto'
              +'  INNER JOIN  '+ fshema+'TAB_SubFam TAB_SubFam ON  '
              +  '  TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
              +  ' INNER JOIN  '+ fshema+'TAB_Familia TAB_Familia ON '
              +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
              +  ' INNER JOIN  '+ fshema+'Tab_GrFamiliar Tab_GrFamiliar ON '
              +  ' TAB_Familia.vCodGrFam = Tab_GrFamiliar.VCodGrFam ';

               If FTipoExportacao=teProduto  then
               Begin
                 stsrqlMovIVA:=stsrqlMovIVA +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
                 +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovIVA:=stsrqlMovIVA +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovIVA:=stsrqlMovIVA +' and (IMCExportacaoProduto.mercado=1)';



               End
               Else
                If FTipoExportacao=teSubFamilia  then
                begin
                 stsrqlMovIVA:=stsrqlMovIVA +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.VsubFam'
                 +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovIVA:=stsrqlMovIVA +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovIVA:=stsrqlMovIVA +' and (IMCExportacaoProduto.mercado=1)';


                end
                else
                If FTipoExportacao=teFamilia  then
                begin
                 stsrqlMovIVA:=stsrqlMovIVA +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_SubFam.VCodFam'
                  +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovIVA:=stsrqlMovIVA +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovIVA:=stsrqlMovIVA +' and (IMCExportacaoProduto.mercado=1)';

                end
                else
                If FTipoExportacao=teGrupoFamilia  then
                begin
                 stsrqlMovIVA:=stsrqlMovIVA +' left join '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_Familia.VCodGrFam'
                  +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovIVA:=stsrqlMovIVA +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovIVA:=stsrqlMovIVA +' and (IMCExportacaoProduto.mercado=1)';

                end;


                if FContasProdutoPorIVA then
                    stsrqlMovIVA:=stsrqlMovIVA +' and IMCExportacaoProduto.ID_IVA=Linhamovimentostock.ID_IVA';

                   stsrqlMovIVA:=stsrqlMovIVA +' Where  FntInterFaceCenExp.id_Interfacecenexp='+IntToStr(FID_INTERFACECENEXP)
                  +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
                  +' and TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0';
                IF   pFiltro<>'' then
                   stsrqlMovIVA:=stsrqlMovIVA+' and '+ pFiltro;

                IF FOmitirLinhaIVA0perc=true  then
                   stsrqlMovIVA:=stsrqlMovIVA+' and Linhamovimentostock.percentagemIVA<>0';

               If  pdataInicio>0 then
                     stsrqlMovIVA:=stsrqlMovIVA+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
                If  pdataFim>0 then
                     stsrqlMovIVA:=stsrqlMovIVA+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

                if FExpApenasComprasFechadas then
                       stsrqlMovIVA:=stsrqlMovIVA+' and MovimentoStock.estado=1';


            end;



            //iva de autoliquidacao

         If    EnviaLinhasIvas then
        begin
          stsrqlMovIVAAUTLIQ:=  ' select 1 as TipoLinha,Movimentostock.TemIvaAutoLiquidacao,''F'' as LinhaFich,';

          If FperiodoIVA>0 then
          begin
             //conta IVa
             stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ  +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
               +' CASE'
               +'  WHEN isnull(V_perIVA.ID_MovimentoDev,0)>0 THEN'
               +'   CodigoExternoIvaFPerIVAAL'
               +'  else  CodigoExternoIvaDAL'
               +'  end'
               +' else'
               +' CASE'
               +'  WHEN (tipoMovimento.id_movimentacao =0)THEN'
               +'     CodigoExternoIvaAL'
               +'  end'
               +' end as Conta,'
             //conta Origem
             +''' '' as classeIVA,'
            +''' '' as classeIVAAL,'
             +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
             +' CASE'
             +'  WHEN isnull(V_perIVA.ID_MovimentoDev,0)>0 THEN'
             +'    CodigoExternoFPerIVA'
             +'  else  codigoExternoD'
             +'  end'
             +' else'
             +' CASE'
             +'  WHEN (tipoMovimento.id_movimentacao =0)THEN'
             +'     codigoExterno'
             +'  end'
             +' end as ContaOrigem,';
          end
          else
          begin
             stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ  +' case when tipoMovimento.id_movimentacao=''0'' '
               + ' then IMCExportacaoProduto.codigoExternoIVAAL else codigoExternoIVADAL'
               + ' end as CONTA,'
               +''' ''as classeIVA,'
            +''' '' as classeIVAAL,'
               + ' case when tipoMovimento.id_movimentacao=''0'' then IMCExportacaoProduto.codigoExterno else codigoExternoD'
               + ' end as ContaOrigem,'
          end;



          stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ
               + ' IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
               + ' IMCTipoDocumentoVenda.diario as DiarioDoc,'
               +'  Linhamovimentostock.ValorIVA as Valor'
               +' ,movimentostock.id_movimento ,'
               +' Linhamovimentostock.id_Linha,Tab_iva.Vdesc as DescricaoLinha'
               +' ,Movimentostock.Numdocumento as ID_Documento'
               +',tipoMovimento.abreviatura as TipoDoc,'
               +''' ''as Seriedoc,'
               +' tipoMovimento.id_movimentacao as TipoOperacao,Movimentostock.datade as data,'
               +' Movimentostock.data as dataMov,'               
               +' tipoMovimento.liquidacaoAutomatica'
               +' ,CASE'
               +'  WHEN (IMCTipoDocumentoVenda.NaturezaProd =''D'')THEN'
               +'     ''C'' else    ''D'' end as Natureza'

               +',Tab_cliente.contacbl as ContaCBLForn,descricaoEntidade,'



               +' Movimentostock.estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
               +',TAB_SubFam.vdesc as subfamilia'
               +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
               +', vcont as ContribuinteEntidade'
               +', Linhamovimentostock.percentagemIVA as TAXAIVA,tipomovimento.ObrigaCentroCustoConcluir,Linhamovimentostock.percIVADedutivel'
               +',PercIVANaoDedutivel,ValorIVADedutivel,ValorIVAnaoDedutivel,Movimentostock.iD_entidade'
               +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'
               +' from  '+ fshema+'Movimentostock';

                If FperiodoIVA>0 then
                 begin
                  If FperiodoIVA=1 then
                  begin
                   stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ  +' left join '+fshema+'V_StkNotasCreditoForaPeriodoIvaMensal as V_perIVA '
                   +'  on Movimentostock.id_movimento=V_perIVA.ID_MovimentoDev'

                  end
                  else
                  If FperiodoIVA=2 then
                  begin
                   stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ  +' left join '+fshema+'V_stkNotasCreditoForaPeriodoIvaTrimestral as V_perIVA '
                   +'  on Movimentostock.id_movimento=V_perIVA.ID_MovimentoDev'
                  end;
                end;

               stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ  +'  left join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=Movimentostock.ID_entidade'
              +' left join   '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
              +' inner join  '+ fshema+'Linhamovimentostock on Linhamovimentostock.id_Movimento=Movimentostock.id_Movimento'
              +' inner join  '+ fshema+'tipoMovimento on tipoMovimento.id_tipoMovimento=Movimentostock.id_tipoMovimento'

              +' inner Join  '+ fshema+'tab_Iva on Tab_iva.vcodi=Linhamovimentostock.ID_Iva'
              +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= Movimentostock.id_tipoMovimento'
              +' inner join  '+ fshema+'FntInterFaceCenExp on FntInterFaceCenExp.ID_InterFaceCenExp=IMCTipoDocumentoVenda.ID_InterFaceCenExp '
              +' inner join  '+ fshema+'FntInterFace on FntInterFace.ID_InterFace=FntInterFaceCenExp.ID_InterFace '
              +' inner join  '+ fshema+'TAb_Produto on TAb_Produto.Vproduto= Linhamovimentostock.ID_Produto'
              +'  INNER JOIN  '+ fshema+'TAB_SubFam TAB_SubFam ON  '
              +  '  TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
              +  ' INNER JOIN  '+ fshema+'TAB_Familia TAB_Familia ON '
              +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
              +  ' INNER JOIN  '+ fshema+'Tab_GrFamiliar Tab_GrFamiliar ON '
              +  ' TAB_Familia.vCodGrFam = Tab_GrFamiliar.VCodGrFam ';

               If FTipoExportacao=teProduto  then
               Begin
                 stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
                 +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and (IMCExportacaoProduto.mercado=1)';



               End
               Else
                If FTipoExportacao=teSubFamilia  then
                begin
                 stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.VsubFam'
                 +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and (IMCExportacaoProduto.mercado=1)';


                end
                else
                If FTipoExportacao=teFamilia  then
                begin
                 stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_SubFam.VCodFam'
                  +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and (IMCExportacaoProduto.mercado=1)';

                end
                else
                If FTipoExportacao=teGrupoFamilia  then
                begin
                 stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' left join '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_Familia.VCodGrFam'
                  +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and (IMCExportacaoProduto.mercado=1)';

                end;


                if FContasProdutoPorIVA then
                    stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' and IMCExportacaoProduto.ID_IVA=Linhamovimentostock.ID_IVA';

                   stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ +' Where  FntInterFaceCenExp.id_Interfacecenexp='+IntToStr(FID_INTERFACECENEXP)
                  +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
                  +' and TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0';
                 IF   pFiltro<>'' then
                   stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ+' and '+ pFiltro;

               If  pdataInicio>0 then
                     stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
                If  pdataFim>0 then
                     stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

                if FExpApenasComprasFechadas then
                       stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ+' and MovimentoStock.estado=1';
                stsrqlMovIVAAUTLIQ:=stsrqlMovIVAAUTLIQ+' and MovimentoStock.TemIvaAutoLiquidacao=1';

            end;

           ///Linha da Retenção

           stsrqlMovRetencaoIVA:=  ' select 1 as TipoLinha,Movimentostock.TemIvaAutoLiquidacao,''F'' as LinhaFich,';
         If FperiodoIVA>0 then
          begin
           stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA
               +' RetencaoFonte.ContaCBL'
               +'  as Conta,'
              +''' '' as classeIVA,'
               +''' '' as classeIVAAL,'
             +' CASE WHEN tipoMovimento.id_movimentacao =1 THEN'
             +' CASE'
             +'  WHEN isnull(V_perIVA.ID_MovimentoDev,0)>0 THEN'
             +'    CodigoExternoFPerIVA'
             +'  else  codigoExternoD'
             +'  end'
             +' else'
             +' CASE'
             +'  WHEN (tipoMovimento.id_movimentacao =0)THEN'
             +'     codigoExterno'
             +'  end'
             +' end as ContaOrigem,';
          end
          else
          begin
             stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA  
               + ' RetencaoFonte.ContaCBL'
               + '  as CONTA,'
               +''' ''as classeIVA,'
               +''' ''as classeIVAAL,'               
               + ' case when tipoMovimento.id_movimentacao=''0'' then IMCExportacaoProduto.codigoExterno else codigoExternoD'
               + ' end as ContaOrigem,'
          end;





            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA
               + ' IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
               + ' IMCTipoDocumentoVenda.diario as DiarioDoc,'
               +'  Linhamovimentostock.ValorRetencao as Valor'
               +' ,movimentostock.id_movimento ,'
               +' Linhamovimentostock.id_Linha,tab_Produto.vdesc1  as DescricaoLinha'
               +' ,Movimentostock.Numdocumento as ID_Documento'
               +',tipoMovimento.abreviatura as TipoDoc,'
               +''' ''as Seriedoc,'
               +' tipoMovimento.id_movimentacao as TipoOperacao,Movimentostock.datade as data,'
               +' Movimentostock.data as dataMov,'               
               +'tipoMovimento.liquidacaoAutomatica'
               +' ,CASE'
               +'  WHEN (IMCTipoDocumentoVenda.NaturezaProd =''D'')THEN'
               +'     ''C'' else    ''D'' end as Natureza'


               +',Tab_cliente.contacbl as ContaCBLForn,descricaoEntidade,'
               +' Movimentostock.estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
               +',TAB_SubFam.vdesc as subfamilia'
               +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
               +', vcont as ContribuinteEntidade'
               +', Linhamovimentostock.percentagemIVA as TAXAIVA,tipomovimento.ObrigaCentroCustoConcluir,Linhamovimentostock.percIVADedutivel'
               +',PercIVANaoDedutivel,ValorIVADedutivel,ValorIVAnaoDedutivel,Movimentostock.iD_entidade'
               +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'

               +' from  '+ fshema+'Movimentostock';


                If FperiodoIVA>0 then
                 begin
                  If FperiodoIVA=1 then
                  begin
                   stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA  +' left join '+fshema+'V_StkNotasCreditoForaPeriodoIvaMensal as V_perIVA '
                   +'  on Movimentostock.id_movimento=V_perIVA.ID_MovimentoDev'

                  end
                  else
                  If FperiodoIVA=2 then
                  begin
                   stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA  +' left join '+fshema+'V_stkNotasCreditoForaPeriodoIvaTrimestral as V_perIVA '
                   +'  on Movimentostock.id_movimento=V_perIVA.ID_MovimentoDev'
                  end;
                end;

               stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA  +'  left join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=Movimentostock.ID_entidade'
              +' left join   '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
              +' inner join  '+ fshema+'Linhamovimentostock on Linhamovimentostock.id_Movimento=Movimentostock.id_Movimento'
              +' inner join  '+ fshema+'RetencaoFonte on RetencaoFonte.id_RetencaoFonte=Linhamovimentostock.id_Retencao'
              +' inner join  '+ fshema+'tipoMovimento on tipoMovimento.id_tipoMovimento=Movimentostock.id_tipoMovimento'

              +' left Join  '+ fshema+'tab_Iva on Tab_iva.vcodi=Linhamovimentostock.ID_Iva'
              +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= Movimentostock.id_tipoMovimento'
              +' inner join  '+ fshema+'FntInterFaceCenExp on FntInterFaceCenExp.ID_InterFaceCenExp=IMCTipoDocumentoVenda.ID_InterFaceCenExp '
              +' inner join  '+ fshema+'FntInterFace on FntInterFace.ID_InterFace=FntInterFaceCenExp.ID_InterFace '
              +' inner join  '+ fshema+'TAb_Produto on TAb_Produto.Vproduto= Linhamovimentostock.ID_Produto'
              +'  INNER JOIN  '+ fshema+'TAB_SubFam TAB_SubFam ON  '
              +  '  TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
              +  ' INNER JOIN  '+ fshema+'TAB_Familia TAB_Familia ON '
              +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
              +  ' INNER JOIN  '+ fshema+'Tab_GrFamiliar Tab_GrFamiliar ON '
              +  ' TAB_Familia.vCodGrFam = Tab_GrFamiliar.VCodGrFam ';

               If FTipoExportacao=teProduto  then
               Begin
                 stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
                 +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and (IMCExportacaoProduto.mercado=1)';



               End
               Else
                If FTipoExportacao=teSubFamilia  then
                begin
                 stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.VsubFam'
                 +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and (IMCExportacaoProduto.mercado=1)';


                end
                else
                If FTipoExportacao=teFamilia  then
                begin
                 stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_SubFam.VCodFam'
                  +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and (IMCExportacaoProduto.mercado=1)';

                end
                else
                If FTipoExportacao=teGrupoFamilia  then
                begin
                 stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' left join '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_Familia.VCodGrFam'
                  +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
                 If FContasPorMercado=true then
                            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
                 else
                            stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and (IMCExportacaoProduto.mercado=1)';

                end;


                if FContasProdutoPorIVA then
                    stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' and IMCExportacaoProduto.ID_IVA=Linhamovimentostock.ID_IVA';

                   stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA +' Where  FntInterFaceCenExp.id_Interfacecenexp='+IntToStr(FID_INTERFACECENEXP)
                  +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
                  +' and TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0';
                 IF   pFiltro<>'' then
                   stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA+' and '+ pFiltro;

               If  pdataInicio>0 then
                     stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
                If  pdataFim>0 then
                     stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

                if FExpApenasComprasFechadas then
                       stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA+' and MovimentoStock.estado=1';

              stsrqlMovRetencaoIVA:=stsrqlMovRetencaoIVA+' and LinhaMovimentoStock.valorretencao<>0';






















            //centros de custo

          stsrqlCcusto:='select 2 as TipoLinha,Movimentostock.TemIvaAutoLiquidacao,''O'' as LinhaFich,'
          + ' CBLCentrosCustos.CBLCentroCusto as Conta,'
          +''' ''as classeIVA,'
          +''' ''as classeIVAAL,'          
          + ' case when tipoMovimento.id_movimentacao=''0'' then IMCExportacaoProduto.codigoExterno else codigoExternoD'
          + ' end as ContaOrigem,'
          +' IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
          +' IMCTipoDocumentoVenda.diario as DiarioDoc,'
          +' LinhaMovStockDetalheCentroCusto.valorccusto  As Valor,'
          +' movimentostock.id_movimento ,'
          +' Linhamovimentostock.id_Linha,tab_Produto.vdesc1 as DescricaoLinha'
          +' ,Movimentostock.Numdocumento as ID_Documento,tipoMovimento.abreviatura as TipoDoc,'
          +''' ''as Seriedoc,'
          +' tipoMovimento.id_movimentacao as TipoOperacao,Movimentostock.datade as data,'
               +' Movimentostock.data as dataMov,'          
          +' tipoMovimento.liquidacaoAutomatica'
          +',IMCTipoDocumentoVenda.NaturezaProd as Natureza,Tab_cliente.contacbl as ContaCBLForn,'
          +' descricaoEntidade,'
          +' Movimentostock.estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
          +',TAB_SubFam.vdesc as subfamilia'
          +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
          +', vcont as ContribuinteEntidade'
          +', Linhamovimentostock.percentagemIVA as TAXAIVA,tipomovimento.ObrigaCentroCustoConcluir,Linhamovimentostock.percIVADedutivel'
         +',PercIVANaoDedutivel,ValorIVADedutivel,ValorIVAnaoDedutivel,Movimentostock.iD_entidade'          
           +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'
          +' from '+ fshema+' Movimentostock'




          +' left join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=Movimentostock.ID_entidade'
          +' left join   '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
          +' inner join  '+ fshema+'Linhamovimentostock on Linhamovimentostock.id_Movimento=Movimentostock.id_Movimento'
          +' inner join  '+ fshema+'LinhaMovStockDetalheCentroCusto on Linhamovimentostock.id_Movimento=LinhaMovStockDetalheCentroCusto.id_Movimento'
          +' AND Linhamovimentostock.id_LINHA=LinhaMovStockDetalheCentroCusto.id_LINHA '
          +' inner join  '+ fshema+'CBLCentrosCustos on CBLCentrosCustos.ID_CBLCentroCusto=LinhaMovStockDetalheCentroCusto.ID_CBLCentroCusto'
          +' inner join  '+ fshema+'tipoMovimento on tipoMovimento.id_tipoMovimento=Movimentostock.id_tipoMovimento'
          +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd=Movimentostock.ID_TipoMovimento'
          +' inner join  '+ fshema+'FntInterFaceCenExp on FntInterFaceCenExp.ID_InterFaceCenExp=IMCTipoDocumentoVenda.ID_InterFaceCenExp '
          +' inner join  '+ fshema+'FntInterFace on FntInterFace.ID_InterFace=FntInterFaceCenExp.ID_InterFace '
          +' inner join  '+ fshema+'TAb_Produto on TAb_Produto.Vproduto= Linhamovimentostock.ID_Produto'
          +'  INNER JOIN  '+ fshema+'TAB_SubFam TAB_SubFam ON  '
          +  '  TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
          +  ' INNER JOIN  '+ fshema+'TAB_Familia TAB_Familia ON '
          +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam '
          +  ' INNER  JOIN '+ fshema+' Tab_GrFamiliar Tab_GrFamiliar ON '
          +  ' TAB_Familia.vCodGrFam = Tab_GrFamiliar.VCodGrFam ';


         If FTipoExportacao=teProduto  then
          begin
           stsrqlCcusto:=stsrqlCcusto +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';

           If FContasPorMercado=true then
                stsrqlCcusto:=stsrqlCcusto +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlCcusto:=stsrqlCcusto +' and (IMCExportacaoProduto.mercado=1)';

          end
          else
          If FTipoExportacao=teSubFamilia  then
          begin
           stsrqlCcusto:=stsrqlCcusto +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.VsubFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
         stsrqlCcusto:=stsrqlCcusto +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';

           If FContasPorMercado=true then
                stsrqlCcusto:=stsrqlCcusto +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlCcusto:=stsrqlCcusto +' and (IMCExportacaoProduto.mercado=1)';

          end
          else
          If FTipoExportacao=teFamilia  then
          begin
           stsrqlCcusto:=stsrqlCcusto +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_SubFam.VCodFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ' ;
          end
          else
          If FTipoExportacao=teGrupoFamilia  then
          begin
           stsrqlCcusto:=stsrqlCcusto +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_Familia.VCodGrFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';

         stsrqlCcusto:=stsrqlCcusto +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';

           If FContasPorMercado=true then
                stsrqlCcusto:=stsrqlCcusto +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlCcusto:=stsrqlCcusto +' and (IMCExportacaoProduto.mercado=1)';

          end;


         if FContasProdutoPorIVA then
              stsrqlCcusto:=stsrqlCcusto +' and IMCExportacaoProduto.ID_IVA=Linhamovimentostock.ID_IVA';

           stsrqlCcusto:=stsrqlCcusto +' Where FntInterFaceCenExp.id_Interfacecenexp='+IntToStr(FID_INTERFACECENEXP)
          +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
          +' and TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0';
          IF   pFiltro<>'' then
             stsrqlCcusto:=stsrqlCcusto+' and '+ pFiltro;

         If  pdataInicio>0 then
               stsrqlCcusto:=stsrqlCcusto+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
          If  pdataFim>0 then
               stsrqlCcusto:=stsrqlCcusto+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

          if FExpApenasComprasFechadas then
                 stsrqlCcusto:=stsrqlCcusto+' and MovimentoStock.estado=1';

 ///contas analiticas


          stsrqlAnali:='select 3 as TipoLinha,Movimentostock.TemIvaAutoLiquidacao,''A'' as LinhaFich,'
          + '  CBLContasAnaliticas.CBLAnalitica  as Conta,'
          +''' ''as classeIVA,'
          +''' ''as classeIVAAL,'          
          + ' case when tipoMovimento.id_movimentacao=''0'' then IMCExportacaoProduto.codigoExterno else codigoExternoD'
          + ' end as ContaOrigem,'
          +' IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
          +' IMCTipoDocumentoVenda.diario as DiarioDoc,'
          +' LinhaMovStockDetalheCentroCusto.valoranalitica  As Valor,'
          +' movimentostock.id_movimento ,'
          +' Linhamovimentostock.id_Linha,tab_Produto.vdesc1 as DescricaoLinha'
          +' ,Movimentostock.Numdocumento as ID_Documento,tipoMovimento.abreviatura as TipoDoc,'
          +''' ''as Seriedoc,'
          +' tipoMovimento.id_movimentacao as TipoOperacao,Movimentostock.datade as data,'
               +' Movimentostock.data as dataMov,'          
          +' tipoMovimento.liquidacaoAutomatica'
          +',IMCTipoDocumentoVenda.NaturezaProd as Natureza,Tab_cliente.contacbl as ContaCBLForn,'
          +' descricaoEntidade,'
          +' Movimentostock.estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
          +',TAB_SubFam.vdesc as subfamilia'
          +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
          +', vcont as ContribuinteEntidade'
          +', Linhamovimentostock.percentagemIVA as TAXAIVA,tipomovimento.ObrigaCentroCustoConcluir,Linhamovimentostock.percIVADedutivel'
         +',PercIVANaoDedutivel,ValorIVADedutivel,ValorIVAnaoDedutivel,Movimentostock.iD_entidade'          
          +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'
          +' from '+ fshema+' Movimentostock'
          +' left join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=Movimentostock.ID_entidade'
          +' left join   '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
          +' inner join  '+ fshema+'Linhamovimentostock on Linhamovimentostock.id_Movimento=Movimentostock.id_Movimento'
          +' inner join  '+ fshema+'LinhaMovStockDetalheCentroCusto on Linhamovimentostock.id_Movimento=LinhaMovStockDetalheCentroCusto.id_Movimento'
          +' AND Linhamovimentostock.id_LINHA=LinhaMovStockDetalheCentroCusto.id_LINHA '



          +' inner join  '+ fshema+'CBLContasAnaliticas on CBLContasAnaliticas.ID_CBLAnalitica=LinhaMovStockDetalheCentroCusto.ID_CBLAnalitica'
          +' inner join  '+ fshema+'tipoMovimento on tipoMovimento.id_tipoMovimento=Movimentostock.id_tipoMovimento'
          +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd=Movimentostock.ID_TipoMovimento'
          +' inner join  '+ fshema+'FntInterFaceCenExp on FntInterFaceCenExp.ID_InterFaceCenExp=IMCTipoDocumentoVenda.ID_InterFaceCenExp '
          +' inner join  '+ fshema+'FntInterFace on FntInterFace.ID_InterFace=FntInterFaceCenExp.ID_InterFace '
          +' inner join  '+ fshema+'TAb_Produto on TAb_Produto.Vproduto= Linhamovimentostock.ID_Produto'
          +'  INNER JOIN  '+ fshema+'TAB_SubFam TAB_SubFam ON  '
          +  '  TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
          +  ' INNER JOIN  '+ fshema+'TAB_Familia TAB_Familia ON '
          +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam '
          +  ' INNER  JOIN '+ fshema+' Tab_GrFamiliar Tab_GrFamiliar ON '
          +  ' TAB_Familia.vCodGrFam = Tab_GrFamiliar.VCodGrFam ';


         If FTipoExportacao=teProduto  then
          begin
           stsrqlAnali:=stsrqlAnali +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';

           If FContasPorMercado=true then
                stsrqlAnali:=stsrqlAnali +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlAnali:=stsrqlAnali +' and (IMCExportacaoProduto.mercado=1)';

          end
          else
          If FTipoExportacao=teSubFamilia  then
          begin
           stsrqlAnali:=stsrqlAnali +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.VsubFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
           If FContasPorMercado=true then
                stsrqlAnali:=stsrqlAnali +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlAnali:=stsrqlAnali +' and (IMCExportacaoProduto.mercado=1)';

          end
          else
          If FTipoExportacao=teFamilia  then
          begin
           stsrqlAnali:=stsrqlAnali +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_SubFam.VCodFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ' ;
           If FContasPorMercado=true then
                stsrqlAnali:=stsrqlAnali +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlAnali:=stsrqlAnali +' and (IMCExportacaoProduto.mercado=1)';

          end
          else
          If FTipoExportacao=teGrupoFamilia  then
          begin
           stsrqlAnali:=stsrqlAnali +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_Familia.VCodGrFam'
           +' and IMCExportacaoProduto.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp  ';
           If FContasPorMercado=true then
                stsrqlAnali:=stsrqlAnali +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
             stsrqlAnali:=stsrqlAnali +' and (IMCExportacaoProduto.mercado=1)';

          end;


         if FContasProdutoPorIVA then
              stsrqlAnali:=stsrqlAnali +' and IMCExportacaoProduto.ID_IVA=Linhamovimentostock.ID_IVA';

           stsrqlAnali:=stsrqlAnali +' Where FntInterFaceCenExp.id_Interfacecenexp='+IntToStr(FID_INTERFACECENEXP)
          +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
          +' and TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0';
          IF   pFiltro<>'' then
             stsrqlAnali:=stsrqlAnali+' and '+ pFiltro;

         If  pdataInicio>0 then
               stsrqlAnali:=stsrqlAnali+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
          If  pdataFim>0 then
               stsrqlAnali:=stsrqlAnali+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

          if FExpApenasComprasFechadas then
                 stsrqlAnali:=stsrqlAnali+' and MovimentoStock.estado=1';






      stsrqlPag:=' select 4 as TipoLinha,Movimentostock.TemIvaAutoLiquidacao,''F'' as linhaFich,'
                +' IMCMODoPagamento.CodigoEXterno as Conta,'
                +''' ''as classeIVA,'
                  +''' '' as classeIVAAL,'
                +''' ''as contaorigem,'
                +' IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
                +'IMCTipoDocumentoVenda.diario as DiarioDoc'
                  +' ,CASE'
                +'  WHEN (movimentostock.TEMIVAAutoliquidacao =1)and  (movimentostock.TEMRetencao =0) THEN'
                +'  movimentostock.ValorTotal - movimentostock.TotalIva '
                +'  when  (movimentostock.TEMIVAAutoliquidacao =0)and  (movimentostock.TEMRetencao =0) '
                +' then movimentostock.ValorTotal '

                +'  when  (movimentostock.TEMIVAAutoliquidacao =0)and  (movimentostock.TEMRetencao =1) '
                +' then movimentostock.ValorTotal- movimentostock.TotalRetencao end as Valor '

              {  +' ,CASE'
                +'  WHEN (movimentostock.TEMIVAAutoliquidacao =1)THEN'
                +'  movimentostock.ValorTotal - movimentostock.TotalIva '
                +' else    movimentostock.ValorTotal end as Valor'}


                +' ,movimentostock.id_movimento ,''0'' as id_Linha,Tab_MetodoPag.vdescpag  as DescricaoLinha'
                +' ,Movimentostock.Numdocumento as ID_Documento,tipoMovimento.abreviatura as TipoDoc,'
                +''' ''as Seriedoc,'
                +' tipoMovimento.id_movimentacao as TipoOperacao,Movimentostock.datade as data,'
                +' Movimentostock.data as dataMov,'
                +'tipoMovimento.liquidacaoAutomatica'
                +',IMCTipoDocumentoVenda.NaturezaPag as Natureza,Tab_cliente.contacbl as ContaCBLForn,descricaoEntidade,'
                +' Movimentostock.estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
                +' ,'''' as subfamilia'
                +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
                +', vcont as ContribuinteEntidade'
                +', 0 as TAXAIVA,tipomovimento.ObrigaCentroCustoConcluir,0 as percIVADedutivel'
                +',0 as PercIVANaoDedutivel,0 as ValorIVADedutivel,0 as ValorIVAnaoDedutivel,Movimentostock.iD_entidade'
  +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'
         +' from  '+ fshema+'Movimentostock'
          +' left join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=Movimentostock.ID_entidade'
          +' left join   '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
          +' LEFT join  '+ fshema+'Tab_MetodoPag on Tab_MetodoPag.vcodpag=Movimentostock.id_ModoPagamento'
          +' inner join  '+ fshema+'tipoMovimento on tipoMovimento.id_tipoMovimento=Movimentostock.id_tipoMovimento'
          +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= Movimentostock.id_tipoMovimento'
          +' inner join  '+ fshema+'FntInterFaceCenExp on FntInterFaceCenExp.ID_InterFaceCenExp=IMCTipoDocumentoVenda.ID_InterFaceCenExp '
          +' inner join  '+ fshema+'FntInterFace on FntInterFace.ID_InterFace=FntInterFaceCenExp.ID_InterFace '
          +' LEFT join  '+ fshema+'IMCMODoPagamento on IMCMODoPagamento.ID_ModoPagamento= Movimentostock.id_ModoPagamento'
          +' and IMCMODoPagamento.ID_InterFaceCenExp= FntInterFaceCenExp.ID_InterFaceCenExp';
        stsrqlPag:=stsrqlPag +' Where   tipoMovimento.Liquidacaoautomatica=1 AND FntInterFaceCenExp.id_Interfacecenexp='+IntToStr(FID_INTERFACECENEXP)
          +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
            +' and TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0';
           IF   pFiltro<>'' then
             stsrqlPag:=stsrqlPag+' and '+ pFiltro;

         If  pdataInicio>0 then
               stsrqlPag:=stsrqlPag+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
          If  pdataFim>0 then
               stsrqlPag:=stsrqlPag+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

          if FExpApenasComprasFechadas then
                 stsrqlPag:=stsrqlPag+' and MovimentoStock.estado=1';



      stsrqlPag1:=' select 4 as TipoLinha,Movimentostock.TemIvaAutoLiquidacao,''F'' as linhaFich,'
                +'     case when TAB_CLIENTE.ContaCBL<>'''' and FntInterFaceCenExp.ContaCBLPagCC<>'''' then '
                 +' FntInterFaceCenExp.ContaCBLPagCC+Cast(isnull(tab_Pais.mercado,1) as varchar(3))+TAB_CLIENTE.ContaCBL '
                 +' else '''' end as Conta,'
                 +''' ''as classeIVA,'
            +''' '' as classeIVAAL,'
                 +''' ''as contaorigem,'
                 +'  IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
                 +' IMCTipoDocumentoVenda.diario as DiarioDoc'
                +' ,CASE'
                +'  WHEN (movimentostock.TEMIVAAutoliquidacao =1)and  (movimentostock.TEMRetencao =0) THEN'
                +'  movimentostock.ValorTotal - movimentostock.TotalIva '
                +'  when  (movimentostock.TEMIVAAutoliquidacao =0)and  (movimentostock.TEMRetencao =0) '
                +' then movimentostock.ValorTotal '

                +'  when  (movimentostock.TEMIVAAutoliquidacao =0)and  (movimentostock.TEMRetencao =1) '
                +' then movimentostock.ValorTotal- movimentostock.TotalRetencao end as Valor '





                 +' ,movimentostock.id_movimento ,''0'' as id_Linha,''Pagamento a Fornecedor''  as DescricaoLinha'
                 +' ,Movimentostock.Numdocumento as ID_Documento,tipoMovimento.abreviatura as TipoDoc,'
                 +''' ''as Seriedoc,'
                 +' tipoMovimento.id_movimentacao as TipoOperacao,Movimentostock.datade as data,'
               +' Movimentostock.data as dataMov,'
                 +'tipoMovimento.liquidacaoAutomatica'

                +',IMCTipoDocumentoVenda.NaturezaPag as Natureza,Tab_cliente.contacbl as ContaCBLForn,descricaoEntidade'
                +',Movimentostock.estado,CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
                +' ,'''' as subfamilia'
                +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
                +', vcont as ContribuinteEntidade'
                +', 0 as TAXAIVA,tipomovimento.ObrigaCentroCustoConcluir,0 as percIVADedutivel'
                +',0 as PercIVANaoDedutivel,0 as ValorIVADedutivel,0 as ValorIVAnaoDedutivel,Movimentostock.iD_entidade'
                  +' ,isnull(tab_Pais.mercado,1) as Mercado,tab_Pais.VABRE as PaisISO, tab_Pais.VDESC as descPais'
          +' from  '+ fshema+'Movimentostock'
          +' left join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=Movimentostock.ID_entidade'
          +' left join   '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
          +' inner join  '+ fshema+'tipoMovimento on tipoMovimento.id_tipoMovimento=Movimentostock.id_tipoMovimento'
          +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= Movimentostock.id_tipoMovimento'
          +' inner join  '+ fshema+'FntInterFaceCenExp on FntInterFaceCenExp.ID_InterFaceCenExp=IMCTipoDocumentoVenda.ID_InterFaceCenExp '
          +' inner join  '+ fshema+'FntInterFace on FntInterFace.ID_InterFace=FntInterFaceCenExp.ID_InterFace ';
        stsrqlPag1:=stsrqlPag1 +' Where tipoMovimento.Liquidacaoautomatica=0  '
            +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
            +' and FntInterFaceCenExp.id_Interfacecenexp='+IntToStr(FID_INTERFACECENEXP)
            +' and TipoMovimento.id_tipoentidade not in(2,4) and MovimentoStock.CBLExportado=0';
         IF   pFiltro<> '' then
             stsrqlPag1:=stsrqlPag1+' and '+ pFiltro;

         If  pdataInicio>0 then
               stsrqlPag1:=stsrqlPag1+' and MovimentoStock.data>='+sb.UtilSQL.DataToSQLData(pdataInicio);
         If  pdataFim>0 then
               stsrqlPag1:=stsrqlPag1+' and MovimentoStock.data<='+sb.UtilSQL.DataToSQLData(pdataFim);

         if FExpApenasComprasFechadas then
                 stsrqlPag1:=stsrqlPag1+' and MovimentoStock.estado=1';




       stsrql:=stsrql+stsrqlMov;


       If EnviaLinhasIvas then
         stsrql:=stsrql+' Union All '+stsrqlMovIVA+' Union All '+stsrqlMovIVAAUTLIQ;

        stsrql:=stsrql  +' Union All '  +stsrqlMovRetencaoIVA+' Union All '  +stsrqlCCusto +' Union All '   +stsrqlAnali
        +' Union All '   +stsrqlPag+' Union All '   +stsrqlPag1;

        stsrql:=stsrql+  ' ) as x';

        If FOmitirValoresZero then
              stsrql:=stsrql+  ' Where x.Valor<>0';



          stsrql:=stsrql +' Group By ID_Movimento,TemIvaAutoLiquidacao,ID_Documento,id_Linha,TipoDoc,Seriedoc,TipoLinha,TipoOperacao'
          +' ,LinhaFich, subfamilia,ContaCBLForn,VNDCONTACBL,diarioDoc,conta,Contaorigem,'
          +'  DescricaoLinha,data,datamov,liquidacaoAutomatica,natureza,descricaoEntidade,ClasseIVA, classeIVAAL,estado'
          +',CBLExportado,CBLExportadoPor,CBLExportadoDTHora'
          +',Morada,Localidade,CodigoPostal,Telefone, ID_CodigoCliente,ContribuinteEntidade,TAXAIVA,'
          +' ObrigaCentroCustoConcluir, percIVADedutivel,percIVAnaoDedutivel,ValorIVADedutivel,ValorIVAnaoDedutivel,iD_entidade'
          +',Mercado,PaisISO,descPais'
          +' order by data,Id_Movimento,tipoLinha';



Result:=Sb.SBBD.AbrirLV(stsrql);

{caminho:=ExtractFilePath(Application.ExeName);
  AssignFile(txtFileR,caminho+'sqlCBLCMP.TXT');
  Rewrite(txtFileR);
  Writeln(txtFileR,stsrqlPag1);
  CloseFile(txtFileR);}

end;    





procedure RemoveMarcaExportacaoFNT();
var
ListaInterfacescmp:Tsbbetabeladados;
strSQL:string;
bdconexao:string;
begin
  strSQL:=' select ERP_EMPRESAINTERFACE.BDConexao'
          +' from ERP_EMPRESAINTERFACE'
          +' inner join ERP_Interface on ERP_Interface.ID_Interface=ERP_EMPRESAINTERFACE.ID_Interface'
          +' where ((ERP_Interface.NomeInterface=''ERP_ComprasSYSCONTROLLER'')'
          +' or (ERP_Interface.NomeInterface=''ERP_CBLCOMPRASFNT''))';
  ListaInterfacescmp:=sb.SBBD.AbrirLV(strSQL);
  Try
      while Not (ListaInterfacescmp.NoFim) do
      Begin
       bdconexao:=ListaInterfacescmp.davalor('BDConexao').asstring;
       If  bdconexao<>'' then
       begin
         If TestaConexaoBDExterna(bdconexao) then
         begin
           sb.SBBD.ExecutaSqlExterno(bdconexao,'delete from  LogLinhaCBLExportacao');
           sb.SBBD.ExecutaSqlExterno(bdconexao,'delete from  LogCabCBLExportacao');
          strsql:='update movimentostock set CBLExportado=0'
              +',    ID_LogCabCBLExportacao=0'
              +',  CBLExportadopor=''''';
          sb.SBBD.ExecutaSqlExterno(bdconexao,strsql);
         end;
       end;
       ListaInterfacescmp.seguinte;
      end;
  Finally
   ListaInterfacescmp.Fecha;
   Freeandnil(ListaInterfacescmp);
  end;

end;





end.
