unit FNTIntfPrimaveraCBL0900;

interface

Uses FntBEEntidadeBase,SBBEObjAbs,SBBEListaObjAbs,SBBETabelaDados,FNTBETipoCons,
SBBEConsTipos,SBBEMapa,dialogs,Sysutils,ERPBEEMPRESAINTERFACE,ERPBECBLCab,ADODB
,ERPBECBLLinhaDetalhe,ERPEnvioEmail,SBBEExcepcoes,Forms,classes;

Type
  TFntBETipoExportacao=(teTotalDocumento,teProduto,teSubFamilia,teFamilia,teGrupoFamilia);
          
  Function PreencheVariavaisConfGerais():boolean;
 Function ExportarVendasAutomatico():Boolean;
 Function ExportarVendasManual(pListaDocs:TsbbeTabeladados; ListaErros:tstringList):Boolean;

 Function ValidaExportacao(var Mensagem:String):Boolean;
 function daListaDocumentosPorexportar(pNumdoc:string;var pstrsql:string):Tsbbetabeladados;
 Function DAultimoDataVendaExportado(porigem:integer):tdatetime;

 var
   Forigem:integer;
   FDataInicioExp,
   FdataFimExp:Tdatetime;
   FCONNECTIONSTRING:string;
   FConexao:TADOConnection;

   FContasProdutoPorIVA:boolean;
   FQuery :TadoQuery;
   FID_cLienteIndiferenciado:string;
   FOBJInterface:TERPBEEMPRESAINTERFACE;

   FID_Hotel:integer;
   FLISTADocumentos:Tsbbetabeladados;
   Ftipoexportacao:TFntBETipoExportacao;
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
  FListaContasMercado:TSBBETabelaDados;
  FID_CentroExploracao:integer;
  FID_INTERFACECENEXP:integer;
  FNaoInterrompeExportaOqueconsegue:Boolean;


implementation




Uses Variants,IERPOGLobais,StrUtils, DateUtils, SBBSSistemaBase,
  SBBaseDados,UgeralFunc, SBBSUtilSQL, ERPBSEMPRESAINTERFACE;


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

  

function DaIdsTipodocumento():string;
var
   Lista:TSBBETabeladados;
   strsql:string;
begin
  result:='';
  strsql:='select * from '+fshema+'IMCTipoDocumentoVenda ';
  Lista:=sb.SBBD.AbrirLV(strsql);
  try
    while not (Lista.NoFim)do
    begin
     Result := Result + IfThen(Result = '', '', ',') + Lista.davalor('ID_TipoDocVnd').asString;
     Lista.seguinte;
    end;
  Finally
    Lista.Free;
  end;
  If Length(Result)>0 then
    Result:='('+Result+')';
end;








Function DAultimoIDVendaExportado(porigem:integer):integer;
var Listadad:tsbbetabeladados;
begin
 result:=0;
 Listadad:=sb.sbbd.abrirlv('select Max(ID_docInterno) as id_internodoc from ERP_CBLCabec  where origem='+Inttostr(porigem));
 If Not(Listadad.vazia) then
 begin
      Result:=Listadad.davalor('id_internodoc').asinteger;

 end;
 Listadad.fecha;
 Freeandnil(Listadad);

end;

Function DAultimoDataVendaExportado(porigem:integer):tdatetime;
var Listadad:tsbbetabeladados;
begin
 result:=0;
 Listadad:=sb.sbbd.abrirlv('select Max(DATA) as DATA from ERP_CBLCabec  where origem='+Inttostr(porigem));
 If Not(Listadad.vazia) then
 begin
      Result:=Listadad.davalor('DATA').asdatetime;

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


Function PreencheVariavaisConfGerais():boolean;
var
  strsql:string;
    FConnectionString:string;
  Lstdados:TSBBETabelaDados;
begin
    id_Pagamentocc:=0;
    If assigned(FObjInterface) then
       FObjInterface:=nil;
    FObjInterface:= MotorERP.ERPInterface.Edita(FIDInterface);
    Result:= (FObjInterface<>nil);
    If  Result=true then
      Result:= TestaConexaoBDExterna(FOBJInterface.BDConexao);

    If result=true then
    begin
        FShema:= FObjInterface.BDSchema;
        strsql:='Select * from '+ FShema+'FntInterfaceCenexp where ID_Interfacecenexp= '+Inttostr(FOBJInterface.ID_InterfaceIMC);
        Lstdados:=sb.SBBD.AbrirLV(strsql);
        If Not(Lstdados.Vazia) then
        begin
          FID_INTERFACECENEXP:=Lstdados.daValor('ID_Interfacecenexp').asInteger;
          FID_CentroExploracao:=Lstdados.daValor('ID_CentroExploracao').asInteger;
          FModulo:=Lstdados.daValor('ModuloVnd').asstring;
          FContasProdutoPorIVA:=Lstdados.daValor('ContasProdutoPorIVA').asboolean;
          FOmitirValoresZero:=Lstdados.daValor('OmitirValoresZero').asboolean;
          FOmitirLinhaIVA0perc:=Lstdados.daValor('OmitirLinhaDOIVAZERO').asboolean;
          FNumCasaDecimaisVL:=4;
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
          FOmitirLinhaIVA0perc:=true;
          Ftipoexportacao :=BD2TipoExportacao(Lstdados.daValor('tipoexportacao').asinteger);

          FperiodoIVA:=FOBJInterface.PeriodoIVA;

        end;
        FreeAndnil(lstdados);
   end;
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
        If Result.IndexOf(pListaDocs.davalor('id_VndCabdocumento').asstring)=-1 then
            Result.Add(pListaDocs.davalor('id_VndCabdocumento').asstring);
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
           +', '+sb.utilsql.DecimalToSQLStr(ObjLinha.Valor,'0.0000')
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
Try
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

except
raise;
end;



end;






Procedure AdicionaLinhaCentroCusto(var pObjCabVend:TERPBECBLCab;pListaDocs:TsbbeTabeladados;var Linha:Integer);
var
    ObjLinha:TERPBECBLLinha;

   Contamovimentar:string;
begin

   Contamovimentar:='';
    ObjLinha:=TERPBECBLLinha.create;
    With ObjLinha do
    begin
       ID_DOCInterno:=pListaDocs.davalor('ID_Vndcabdocumento').asinteger;
       NumLinha:=Linha+1;
       TipoLinha:='O';
       descricao:=pListaDocs.davalor('DescricaoLinha').ASSTRING;
       Descricao:=sb.UtilStr.CSSubstituiStr(Descricao,#39,#39#39);
       TaxaIva:=pListaDocs.davalor('TaxaIva').ASSTRING;
       If pListaDocs.davalor('TipoOperacao').asstring='0' then
         NATUREZA:='C'
        else
          NATUREZA:='D';

       TipoEntidade:='C';
       Cambio:=1.0000000;
       Moeda:='EUR';

       CONTA:=pListaDocs.davalor('CONTaCCusto').asstring;
       CONTAORIGEM:=pListaDocs.davalor('ProdContCBL').asstring;
       valor:=0;
       valor:=abs(pListaDocs.davalor('Valor').asFloat);

   end;
   pObjCabVend.Linhas.Adiciona(ObjLinha);

end;


Procedure AdicionaLinhaContaAnalitica(var pObjCabVend:TERPBECBLCab;pListaDocs:TsbbeTabeladados;var Linha:Integer);
var
    ObjLinha:TERPBECBLLinha;

   Contamovimentar:string;
begin

   Contamovimentar:='';
    ObjLinha:=TERPBECBLLinha.create;
    With ObjLinha do
    begin
       ID_DOCInterno:=pListaDocs.davalor('ID_Vndcabdocumento').asinteger;
       NumLinha:=Linha+1;
       TipoLinha:='A';
       descricao:=pListaDocs.davalor('DescricaoLinha').ASSTRING;
       Descricao:=sb.UtilStr.CSSubstituiStr(Descricao,#39,#39#39);

       TaxaIva:=pListaDocs.davalor('TaxaIva').ASSTRING;
       If pListaDocs.davalor('TipoOperacao').asstring='0' then
         NATUREZA:='C'
        else
          NATUREZA:='D';
       TipoEntidade:='C';
       Cambio:=1.0000000;
       Moeda:='EUR';

       CONTA:=pListaDocs.davalor('CONTaAnalitica').asstring;
       valor:=0;
       valor:=abs(pListaDocs.davalor('Valor').asFloat);

   end;
   pObjCabVend.Linhas.Adiciona(ObjLinha);

end;


Function PreencheOBJDoc(pListaDocs:TsbbeTabeladados;pid_Internodoc:Integer):TERPBECBLCab;
var
    ObjLinha:TERPBECBLLinha;
    Linha:integer;
    Contamovimentar:string;
    ttZeros,j:integer;
    CodClientePMS:string;

begin
  pListaDocs.dataset.filtered:=false;
  pListaDocs.dataset.filter:='ID_Vndcabdocumento='+Inttostr(pid_Internodoc);
  pListaDocs.dataset.filtered:=true;
  If  Not pListaDocs.Vazia then
  begin

    Result:=TERPBECBLCab.Create;
    Result.ID_DOCInterno:= pListaDocs.davalor('ID_Vndcabdocumento').asinteger;
    Result.mpehotel:=0;
    Result.NumDocumento:= pListaDocs.davalor('id_documento').asstring;
    Result.Documento:= pListaDocs.davalor('VNDCONTACBL').asstring;
    Result.Origem:=FOBJInterface.ID;
    Result.modulo:=Fmodulo;
    Result.Descricao := pListaDocs.davalor('TipoDoc').asstring+'\'+pListaDocs.davalor('Seriedoc').asstring
         +'Nº'+pListaDocs.davalor('ID_Documento').asstring;
    Result.Diario:=FDiario;
    Result.Analitica:=FRefleteAnalitica;
    Result.CCustos:=FRefleteCentroCusto;
    result.TotalLinhas:= pListaDocs.NumLinhas;
    result.Nif := pListaDocs.davalor('ContribuinteEntidade').asstring;
    result.ano :=Yearof(pListaDocs.davalor('data').asdatetime);
    result.mes :=Monthof(pListaDocs.davalor('data').asdatetime);
    result.dia :=DayOf(pListaDocs.davalor('data').asdatetime);
    result.Data :=pListaDocs.davalor('data').asdatetime;
    result.TipoEntidade:='C';



    result.nome:= pListaDocs.davalor('cliente').asstring;
    result.Morada:= pListaDocs.davalor('Morada').asstring;
    result.Localidade:= pListaDocs.davalor('Localidade').asstring;
    result.CodigoPostal:= pListaDocs.davalor('CodigoPostal').asstring;
    result.Telefone:= pListaDocs.davalor('Telefone').asstring;
    Result.DataVencimento:= pListaDocs.davalor('Data').asdatetime;
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
            ID_DOCInterno:=pListaDocs.davalor('ID_Vndcabdocumento').asinteger;
            NumLinha:=Linha+1;
            TipoLinha:='F';
            descricao:=pListaDocs.davalor('DescricaoLinha').ASSTRING;
            Descricao:=sb.UtilStr.CSSubstituiStr(Descricao,#39,#39#39);

           TaxaIva:=pListaDocs.davalor('TaxaIVA').ASSTRING;
        //    Natureza:=pListaDocs.davalor('Natureza').asstring;
            TipoEntidade:='C';
            Cambio:=1.0000000;
            Moeda:='EUR';


             If pListaDocs.davalor('TipoLinha').asstring='0' then
             begin
               CONTA:=pListaDocs.davalor('ProdContCBL').asstring;
               ClasseIVA:=pListaDocs.davalor('ClasseIVA').asstring;
               If pListaDocs.davalor('TipoOperacao').asstring='0' then
                 NATUREZA:='C'
                else
                  NATUREZA:='D';

             end
             else
             If pListaDocs.davalor('TipoLinha').asstring='1' then
             Begin
                 CONTA:=pListaDocs.davalor('IVACONTACBL').asstring;
                 CONTAORIGEM:=pListaDocs.davalor('ProdContCBL').asstring;
                 If pListaDocs.davalor('TipoOperacao').asstring='0' then
                   NATUREZA:='C'
                 else
                    NATUREZA:='D';
             end
             else
             If pListaDocs.davalor('tipoLinha').asstring='2' then
             begin
                 If pListaDocs.davalor('TipoOperacao').asstring='0' then
                  NATUREZA:='D'
                 else
                  NATUREZA:='C';


                 CONTA:=pListaDocs.davalor('ContPagCBL').asstring;
                 If ((id_Pagamentocc=pListaDocs.davalor('Id_modoPagamento').asinteger) or
                    (9999=pListaDocs.davalor('Id_modoPagamento').asinteger))then
                 begin
                   CONTA:=pListaDocs.davalor('ContPagCBL').asstring;

                   ttZeros:=0;
                   CodClientePMS:='';
                   CodClientePMS:=pListaDocs.davalor('ContaCBLCliente').asstring;
                   If Length(CodClientePMS)<6 then
                   begin
                         ttZeros:=6-Length(CodClientePMS);
                         For j:=0 to  ttZeros-1 do
                           CodClientePMS:='0'+CodClientePMS;
                   end;
                   Conta:=pListaDocs.davalor('ContPagCBL').asstring+pListaDocs.davalor('mercado').asstring+CodClientePMS;
                 end;
             end;

             valor:=0;
             valor:=abs(pListaDocs.davalor('Valor').asFloat);
             inc(Linha);
        end;
        Result.Linhas.Adiciona(ObjLinha);

        If   pListaDocs.davalor('tipoLinha').asstring='0' then
        begin
         If    FRefleteCentroCusto='S' then
          If  (pListaDocs.davalor('ContaCCusto').asstring<>'') then
          Begin
                AdicionaLinhaCentroCusto(Result,pListaDocs,Linha);
          end;
          If FRefleteAnalitica='S' then
          If  (pListaDocs.davalor('ContaAnalitica').asstring<>'') then
          Begin
              AdicionaLinhaContaAnalitica(Result,pListaDocs,Linha);
          end;
        end;

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
         FShema:=FObjInterface.BDSchema;
///         FDataInicioExp:= FObjInterface.DATAInicioExportacao;
         PreencheVariavaisConfGerais;
      end;
    end;
end;

Function ValidaExportacaoDocumento(ObjCab:TERPBECBLCab;var mensagem:string):Boolean;
var
 i:integer;
 ListaD:Tsbbetabeladados;
 strsql:string;
 Contacbl:string;

begin
  result:=true;
  mensagem:='';
  If  ObjCab.Linhas.num=0 then
              mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Documento Sem Linhas:'+ ObjCab.Descricao;

  For i:=0 to  ObjCab.Linhas.Num-1 do
  begin
      Contacbl:=ObjCab.Linhas.elem[i].Conta;
      Contacbl:=TrimLeft(Contacbl);
      Contacbl:=TrimRight(Contacbl);
      If Length(contacbl)<=0 then
          mensagem := mensagem + ifthen(mensagem <> '', #13 , '') + 'Falta Conta CBL: '+ ObjCab.Linhas.elem[i].Descricao;
  end;
  If mensagem<>'' then
  begin
   mensagem:='Documento nº'+ObjCab.NumDocumento+' '+ObjCab.Descricao+#13+mensagem;
   result:=false;
  end;
  If Result then
  begin
    try

          ListaD:=sb.SBBD.AbrirLV('select ID_DOCInterno from ERP_CBLCabec  where origem='+inttostr(FIDInterface) +' and ID_DOCInterno='+Inttostr(ObjCab.ID_DOCInterno));
          If Not(ListaD.vazia) then
          begin
            mensagem:='Documento já exportado:'+#13+'Documento nº'+ObjCab.NumDocumento+' '+ObjCab.Descricao;
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


function daListaDocumentosPorexportar(pNumdoc:string;var pstrsql:string):Tsbbetabeladados;
var
  StrDocumentos:string;
      strsql,
   stsrql1,stsrql2,stsrql3,stsrql4:string;


 schema:string;
ID_UltVndcabdocumentoExportado:integer;
   txtFileR: TextFile;
   caminho:string;
begin
   Result:=Nil;
   If PreparaParametrosExportacao then
   begin
    StrDocumentos:=DaIdsTipodocumento;
    If StrDocumentos<>'' then
    begin


   schema:=FShema;
//   Try

     ID_UltVndcabdocumentoExportado:=DAultimoIDVendaExportado(FIDInterface);


   strsql:='select  TipoLinha,tipomov,VNDCONTACBL'
          +'  ,ContPagCBL,Sum(VALOR) as Valor,id_VndCabdocumento,'
          +'  DescricaoLinha'
          +' ,ID_Documento,TipoDoc,Seriedoc,TipoOperacao,data'
          +',valortotal,Cliente,ContribuinteEntidade,ContaCblCliente'
          +' ,mercado, Morada,Localidade,CodigoPostal,Telefone, ID_CodigoCliente,ID_ModoPagamento,subfamilia,taxaiva';
          If FperiodoIVA>0 then
          begin
             strsql:=strsql  +',case when isnull(V_perIVA.ID_VndCabDocumentoDev,0)>0 then CodigoExternoFPerIVA else ProdContCBL end as ProdContCBL';
             strsql:=strsql  +',case when isnull(V_perIVA.ID_VndcabdocumentoDev,0)>0 then CodigoExternoIvaFPerIVA else IVACONTACBL end as IVACONTACBL';
             strsql:=strsql  +',case when isnull(V_perIVA.ID_VndcabdocumentoDev,0)>0 then ClasseIVAFPerIVA else ClasseIVA end as ClasseIVA';
             strsql:=strsql  +',case when isnull(V_perIVA.ID_VndcabdocumentoDev,0)>0 then CentroCustoFPerIVA else ContaCCusto end as ContaCCusto';
             strsql:=strsql  +',case when isnull(V_perIVA.ID_VndcabdocumentoDev,0)>0 then ContaAnaliticaFPerIVA else ContaAnalitica end as ContaAnalitica';

          end
          else
          begin
           strsql:=strsql  +',IVACONTACBL,ProdContCBL,ClasseIVA,ContaCCusto, ContaAnalitica';
          end;


      strsql:=strsql+' from      (';

    stsrql1:='select 0 as TipoLinha,0 as tipomov,IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
         +' '''' as ContPagCBL,'

          +' CASE WHEN vndcabdocumento.IvaIncluido=1  then (VndLinhaDocumento.valor-VndLinhaDocumento.valoriva) else '
          +' VndLinhaDocumento.valor'
          +' END As Valor,'
          +' vndcabdocumento.id_VndCabdocumento,'
          +' VndLinhaDocumento.id_Linha,VndLinhaDocumento.DescricaoProduto as DescricaoLinha,VndLinhaDocumento.DescricaoProduto as DescricaoLinha1'
          +' ,VndLinhaDocumento.ID_Documento,TipoDocVnd.Descricao as TipoDoc, Serievnd.abreviatura as Seriedoc,'
          +' TipoDocVnd.TipoOperacao,VndCabdocumento.data'
             +',vndcabdocumento.valortotal,'

             + ' case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.codigoExterno else codigoExternoD'
                       + ' end as ProdContCBL,'

             + ' case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.classeIVA else classeIVAD'
                       + ' end as classeIVA,'


             + ' case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.codigoExternoIVA else codigoExternoIVAD'
                       + ' end as IVACONTACBL'




             +', vndcabdocumento.nomeentidade+'' ''+ vndcabdocumento.apelidoEntidade as Cliente'
             +',vndcabdocumento.contribuinteentidade'
             + ' ,case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.ContaCCusto else ContaCCustoD'
                       + ' end as ContaCCusto'
             + ' ,case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.ContaAnalitica else ContaAnaliticaD'
             + ' end as ContaAnalitica,'
             +' vndcabdocumento.id_TipodocVnd  as ID_Tipodocumento'
             +', tab_cliente.contacbl as  ContaCblCliente'
             +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
             +',9999 as ID_ModoPagamento '
             +',CodigoExternoFPerIVA '
             +', CodigoExternoIvaFPerIVA'
             +', ClasseIVAFPerIVA '
             +', CentroCustoFPerIVA'
             +', ContaAnaliticaFPerIVA'
             +',TAB_SubFam.vdesc as subfamilia'
             +',isnull(tab_Pais.mercado,1) as Mercado'
             +', VndLinhaDocumento.percentagemiva as TAXAIVA'
          +' from  '+ fshema+'vndcabdocumento'
          +' inner join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=vndcabdocumento.id_entidade'
          +' left join  '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
          
          +' inner join '+ fshema+'VndLinhaDocumento on VndLinhaDocumento.id_VndCabdocumento=vndcabdocumento.ID_Vndcabdocumento'
          +' inner join '+ fshema+'TipodocVnd on TipodocVnd.id_TipodocVnd=vndcabdocumento.id_TipodocVnd'
          +' inner join '+ fshema+'SerieVnd on TipodocVnd.id_TipodocVnd=SerieVnd.id_TipodocVnd'
          +' and SerieVnd.id_serievnd=vndcabdocumento.Id_serievnd'

          +' inner join '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= vndcabdocumento.ID_TipoDocVnd'
          +'  inner join '+ fshema+'FntInterFaceCenExp '
         +'  on IMCTipoDocumentoVenda.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp '
          +' inner join '+ fshema+'TAb_Produto on TAb_Produto.Vproduto= VndLinhaDocumento.ID_Produto'
          +'  INNER JOIN '+ fshema+'TAB_SubFam TAB_SubFam ON  '
          +  '  TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
          +  ' INNER JOIN '+ fshema+'TAB_Familia TAB_Familia ON '
          +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam '
          +  ' INNER JOIN '+ fshema+'Tab_GrFamiliar Tab_GrFamiliar ON '
          +  ' TAB_Familia.vCodGrFam = Tab_GrFamiliar.VCodGrFam ';

          If FTipoExportacao=teProduto  then
          begin
           stsrql1:=stsrql1 +' left join '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
                                  +' and IMCExportacaoProduto.ID_InterfaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp';
           If FContasPorMercado=true then
            stsrql1:=stsrql1 +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
            stsrql1:=stsrql1 +' and (IMCExportacaoProduto.mercado=1)'

          end
          else

          If FTipoExportacao=teSubFamilia  then
          begin
             stsrql1:=stsrql1 +' left join '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.VsubFam'
                                  +' and IMCExportacaoProduto.ID_InterfaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp';

           If FContasPorMercado=true then
            stsrql1:=stsrql1 +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
            stsrql1:=stsrql1 +' and (IMCExportacaoProduto.mercado=1)'

          end
          else
          If FTipoExportacao=teFamilia  then
          begin
           stsrql1:=stsrql1 +' left join '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_SubFam.VCodFam'
                                  +' and IMCExportacaoProduto.ID_InterfaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp';

           If FContasPorMercado=true then
            stsrql1:=stsrql1 +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
            stsrql1:=stsrql1 +' and (IMCExportacaoProduto.mercado=1)';
          end
          else
          If FTipoExportacao=teGrupoFamilia  then
          begin
                stsrql1:=stsrql1 +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_Familia.VCodGrFam'
                                  +' and IMCExportacaoProduto.ID_InterfaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp';

             If FContasPorMercado=true then
              stsrql1:=stsrql1 +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
             else
              stsrql1:=stsrql1 +' and (IMCExportacaoProduto.mercado=1)'
          end;
          if FContasProdutoPorIVA then
              stsrql1:=stsrql1 +' and IMCExportacaoProduto.ID_IVA=VndLinhaDocumento.ID_IVA';


           stsrql1:=stsrql1 +' Where VndCabdocumento.anulado=0 '
          +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' and TipoMovimento=0'
          +'  and FntInterFaceCenExp.ID_InterFaceCenExp='+Inttostr(FOBJInterface.ID_InterfaceIMC);

          if FOmitirValoresZero then
            stsrql1:=stsrql1 +' and vndlinhadocumento.valor<>0 ';



          If ((ID_UltVndcabdocumentoExportado>0) and (pNumdoc='')) then
           stsrql1:=stsrql1+' and VndCabdocumento.ID_vndcabdocumento>'+Inttostr(ID_UltVndcabdocumentoExportado);

         If  FDataInicioExp>0 then
             stsrql1:=stsrql1+' and VndCabdocumento.data>='+sb.UtilSQL.DataToSQLData(FDataInicioExp);

         If  FdataFimExp>0 then
            stsrql1:=stsrql1+' and VndCabdocumento.data<='+sb.UtilSQL.DataToSQLData(FdataFimExp);




        stsrql2:=  ' select 1 as TipoLinha,0 as tipomov,IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
          +' '''' as ContPagCBL,'
          +'  VndLinhaDocumento.ValorIVA as Valor'
          +' ,vndcabdocumento.id_VndCabdocumento,'
          +' VndLinhaDocumento.id_Linha,Tab_iva.Vdesc as DescricaoLinha,VndLinhaDocumento.DescricaoProduto as DescricaoLinha1'
          +' ,VndLinhaDocumento.ID_Documento,TipoDocVnd.Descricao as TipoDoc, Serievnd.abreviatura as Seriedoc,'
          +' TipoDocVnd.TipoOperacao,VndCabdocumento.data,'
          +'VndCabdocumento.valortotal,'


   + ' case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.codigoExterno else codigoExternoD'
               + ' end as ProdContCBL,'

     + ' case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.classeIVA else classeIVAD'
               + ' end as classeIVA,'


     + ' case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.codigoExternoIVA else codigoExternoIVAD'
               + ' end as IVACONTACBL'
             +', vndcabdocumento.nomeentidade+'' ''+ vndcabdocumento.apelidoEntidade as Cliente'
     +',vndcabdocumento.contribuinteentidade'
     + ' ,case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.ContaCCusto else ContaCCustoD'
               + ' end as ContaCCusto'
     + ' ,case when IMCTipoDocumentoVenda.NaturezaDoc=''C'' then IMCExportacaoProduto.ContaAnalitica else ContaAnaliticaD'
               + ' end as ContaAnalitica,vndcabdocumento.id_TipodocVnd  as ID_Tipodocumento'
          +', tab_cliente.contacbl as  ContaCblCliente'
          +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
          +',0 as ID_ModoPagamento '
             +',CodigoExternoFPerIVA '
             +', CodigoExternoIvaFPerIVA'
             +', ClasseIVAFPerIVA '
             +', CentroCustoFPerIVA'
             +', ContaAnaliticaFPerIVA'
                        +',TAB_SubFam.vdesc as subfamilia'
             +',isnull(tab_Pais.mercado,1) as Mercado'
             +', VndLinhaDocumento.percentagemiva as TAXAIVA'
          +' from  '+ fshema+'vndcabdocumento'

          +' inner join  '+ fshema+'Tab_cliente on Tab_cliente.vnume=vndcabdocumento.id_entidade'
          +' left join  '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'

          +' inner join  '+ fshema+'VndLinhaDocumento on VndLinhaDocumento.id_VndCabdocumento=vndcabdocumento.ID_Vndcabdocumento'
          +' inner join  '+ fshema+'TipodocVnd on TipodocVnd.id_TipodocVnd=vndcabdocumento.id_TipodocVnd'
          +' inner join  '+ fshema+'SerieVnd on TipodocVnd.id_TipodocVnd=SerieVnd.id_TipodocVnd'
          +' and SerieVnd.id_serievnd=vndcabdocumento.Id_serievnd'
          +' inner Join  '+ fshema+'tab_Iva on Tab_iva.vcodi=vndLinhadocumento.ID_Iva'
          +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= vndcabdocumento.ID_TipoDocVnd'
          +'  inner join '+ fshema+'FntInterFaceCenExp '
          +'  on IMCTipoDocumentoVenda.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp '
          +' inner join  '+ fshema+'TAb_Produto on TAb_Produto.Vproduto= VndLinhaDocumento.ID_Produto'
          +'  INNER JOIN  '+ fshema+'TAB_SubFam TAB_SubFam ON  '
          +  '  TAB_PRODUTO.VSUBFAM = TAB_SubFam.VCodSubFam '
          +  ' INNER JOIN  '+ fshema+'TAB_Familia TAB_Familia ON '
          +  ' TAB_SubFam.VCodFam = TAB_Familia.VCodFam'
          +  ' INNER JOIN  '+ fshema+'Tab_GrFamiliar Tab_GrFamiliar ON '
          +  ' TAB_Familia.vCodGrFam = Tab_GrFamiliar.VCodGrFam ';


         If FTipoExportacao=teProduto  then
          begin
           stsrql2:=stsrql2 +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.vproduto'
                                  +' and IMCExportacaoProduto.ID_InterfaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp';

           If FContasPorMercado=true then
            stsrql2:=stsrql2 +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
            stsrql2:=stsrql2 +' and (IMCExportacaoProduto.mercado=1)'

          end
          else
           If FTipoExportacao=teSubFamilia  then
          begin
           stsrql2:=stsrql2 +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAb_Produto.VsubFam'
                       +' and IMCExportacaoProduto.ID_InterfaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp';
           If FContasPorMercado=true then
             stsrql2:=stsrql2 +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
            stsrql2:=stsrql2 +' and (IMCExportacaoProduto.mercado=1)'

          end
          else
          If FTipoExportacao=teFamilia  then
          begin
           stsrql2:=stsrql2 +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_SubFam.VCodFam'
                       +' and IMCExportacaoProduto.ID_InterfaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp';
           If FContasPorMercado=true then
            stsrql2:=stsrql2 +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
            stsrql2:=stsrql2 +' and (IMCExportacaoProduto.mercado=1)'

          end
          else
          If FTipoExportacao=teGrupoFamilia  then
          begin
           stsrql2:=stsrql2 +' left join  '+ fshema+'IMCExportacaoProduto on IMCExportacaoProduto.ID_Codigo= TAB_Familia.VCodGrFam'
                       +' and IMCExportacaoProduto.ID_InterfaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp';
           If FContasPorMercado=true then
            stsrql2:=stsrql2 +' and (IMCExportacaoProduto.mercado=isnull(tab_Pais.mercado,1))'
           else
            stsrql2:=stsrql2 +' and (IMCExportacaoProduto.mercado=1)'

          end;
          if FContasProdutoPorIVA then
              stsrql2:=stsrql2 +' and IMCExportacaoProduto.ID_IVA=VndLinhaDocumento.ID_IVA';

          stsrql2:=stsrql2 +' Where VndCabdocumento.anulado=0 '
          +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' and TipoMovimento=0'
          +'  and FntInterFaceCenExp.ID_InterFaceCenExp='+Inttostr(FOBJInterface.ID_InterfaceIMC);



          if FOmitirValoresZero then
            stsrql2:=stsrql2 +' and vndlinhadocumento.valor<>0 ';

          If FOmitirLinhaIVA0perc then
                      stsrql2:=stsrql2 +' and vndlinhadocumento.percentagemIVA<>0 ';



          If ((ID_UltVndcabdocumentoExportado>0) and (pNumdoc='')) then
           stsrql2:=stsrql2+' and VndCabdocumento.ID_vndcabdocumento>'+Inttostr(ID_UltVndcabdocumentoExportado);


        If  FDataInicioExp>0 then
            stsrql2:=stsrql2+' and VndCabdocumento.data>='+sb.UtilSQL.DataToSQLData(FDataInicioExp);
        If  FdataFimExp>0 then
           stsrql2:=stsrql2+' and VndCabdocumento.data<='+sb.UtilSQL.DataToSQLData(FdataFimExp);




       stsrql3:=' select 2 as TipoLinha,1 as tipomov,IMCTipoDocumentoVenda.CodigoDefeito'
          +' as VNDCONTACBL,'
          +' IMCMODoPagamento.CodigoEXterno as ContPagCBL,'
          +' VndLinhaDocumento.Valor as Valor'
          +' ,vndcabdocumento.id_VndCabdocumento,VndLinhaDocumento.id_Linha,'
          +' VndLinhaDocumento.DescricaoProduto as DescricaoLinha,'
          +' VndLinhaDocumento.DescricaoProduto as DescricaoLinha1'
          +' ,VndLinhaDocumento.ID_Documento,TipoDocVnd.Descricao as TipoDoc, '
          +' Serievnd.abreviatura as Seriedoc,'
          +' TipoDocVnd.TipoOperacao,VndCabdocumento.data,VndCabdocumento.valortotal,'
          +' '''' as ProdContCBL,  '
          +' '''' as ClasseIVA ,'
          +' '''' as IVACONTACBL'
               +', vndcabdocumento.nomeentidade+'' ''+ vndcabdocumento.apelidoEntidade as Cliente'
            +',vndcabdocumento.contribuinteentidade,'

           +' '''' as  ContaCCusto,'
          +' '''' as ContaAnalitica,vndcabdocumento.id_TipodocVnd  as ID_Tipodocumento'

             +', tab_cliente.contacbl as  ContaCblCliente'
             +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
             +',IMCMODoPagamento.ID_ModoPagamento '

             +', ''''CodigoExternoFPerIVA '
             +',  ''''CodigoExternoIvaFPerIVA'
             +', '''' ClasseIVAFPerIVA '
             +',  ''''CentroCustoFPerIVA'
             +',  ''''ContaAnaliticaFPerIVA'
             +',  '''' as subfamilia'
             +',isnull(tab_Pais.mercado,1) as Mercado'
             +', VndLinhaDocumento.percentagemiva as TAXAIVA'

          +' from  '+ fshema+'vndcabdocumento'
          +' inner join  '+ fshema+'TAB_CLIENTE on TAB_CLIENTE.vnume=vndcabdocumento.ID_Entidade'
          +' left join  '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'          
          +' inner join  '+ fshema+'VndLinhaDocumento on VndLinhaDocumento.id_VndCabdocumento=vndcabdocumento.ID_Vndcabdocumento'
          +' inner join  '+ fshema+'TipodocVnd on TipodocVnd.id_TipodocVnd=vndcabdocumento.id_TipodocVnd'
          +' inner join  '+ fshema+'SerieVnd on TipodocVnd.id_TipodocVnd=SerieVnd.id_TipodocVnd'
          +' and SerieVnd.id_serievnd=vndcabdocumento.Id_serievnd'

          +' inner join  '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= vndcabdocumento.ID_TipoDocVnd'
          +'  inner join '+ fshema+'FntInterFaceCenExp '
          +'  on IMCTipoDocumentoVenda.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp '


          +' left join  '+ fshema+'IMCMODoPagamento on IMCMODoPagamento.ID_ModoPagamento= VndLinhaDocumento.ID_ModoPagamento'
          +' and IMCMODoPagamento.ID_InterFaceCenExp= FntInterFaceCenExp.ID_InterFaceCenExp'
          +' Where VndCabdocumento.anulado=0 '
          +'  and FntInterFaceCenExp.ID_InterFaceCenExp='+Inttostr(FOBJInterface.ID_InterfaceIMC)

          +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' and TipoMovimento=1'
          +' and ((TipoDocVnd.ligcc=1 and TipoDocVnd.LiqAutomatica=1) or (TipoDocVnd.ligcaixa=1))' ;

          if FOmitirValoresZero then
            stsrql3:=stsrql3 +' and vndlinhadocumento.valor<>0 ';

          If ((ID_UltVndcabdocumentoExportado>0) and (pNumdoc='')) then
           stsrql3:=stsrql3+' and VndCabdocumento.ID_vndcabdocumento>'+Inttostr(ID_UltVndcabdocumentoExportado);

        If  FDataInicioExp>0 then
            stsrql3:=stsrql3+' and VndCabdocumento.data>='+sb.UtilSQL.DataToSQLData(FDataInicioExp);

        If  FdataFimExp>0 then
           stsrql3:=stsrql3+' and VndCabdocumento.data<='+sb.UtilSQL.DataToSQLData(FdataFimExp);


      stsrql4:=' select 2 as TipoLinha,1 as tipomov,IMCTipoDocumentoVenda.CodigoDefeito as VNDCONTACBL,'
            +' FntInterFaceCenExp.ContaCBLPagCC+Cast(isnull(tab_Pais.mercado,1) as varchar(3))+TAB_CLIENTE.ContaCBL as ContPagCBL,'
          +' VndCabdocumento.ValorTotal as Valor'
          +' ,vndcabdocumento.id_VndCabdocumento,9999 as id_Linha,'
          +'''Conta Corrente'' as  DescricaoLinha,''Conta Corrente'' as DescricaoLinha1'
          +' ,VndCabdocumento.ID_Documento,TipoDocVnd.Descricao as TipoDoc,'
          +' Serievnd.abreviatura as Seriedoc,'
          +' TipoDocVnd.TipoOperacao,VndCabdocumento.data,VndCabdocumento.valortotal,'
          +' '''' as ProdContCBL,  '
          +' '''' as ClasseIVA ,'
          +' '''' as IVACONTACBL'

           +', vndcabdocumento.nomeentidade+'' ''+ vndcabdocumento.apelidoEntidade as Cliente'
          +',vndcabdocumento.contribuinteentidade,'
          +' '''' as  ContaCCusto,'
          +' '''' as ContaAnalitica,vndcabdocumento.id_TipodocVnd  as ID_Tipodocumento'
          +', tab_cliente.contacbl as  ContaCblCliente'
          +', Vmor1 as morada,vlocalidade as localidade,VCPos+''-''+VRua as  codigoPostal,vtelf as telefone,vnume as  ID_CodigoCliente'
          +',0 as ID_ModoPagamento '
          +', ''''CodigoExternoFPerIVA '
          +',  ''''CodigoExternoIvaFPerIVA'
          +', '''' ClasseIVAFPerIVA '
          +',  ''''CentroCustoFPerIVA'
          +',  ''''ContaAnaliticaFPerIVA'
          +',  '''' as subfamilia'
          +',isnull(tab_Pais.mercado,1) as Mercado'
          +', 0 as TAXAIVA'
          +' from  '+ fshema+'vndcabdocumento'
          +' inner join  '+ fshema+'TAB_CLIENTE on TAB_CLIENTE.vnume=vndcabdocumento.ID_Entidade'
          +' left join  '+ fshema+'tab_Pais on tab_Pais.icodi=Tab_cliente.IcodiPais'
          +' inner join  '+ fshema+'TipodocVnd on TipodocVnd.id_TipodocVnd=vndcabdocumento.id_TipodocVnd'
          +' inner join  '+ fshema+'SerieVnd on TipodocVnd.id_TipodocVnd=SerieVnd.id_TipodocVnd'
          +' and SerieVnd.id_serievnd=vndcabdocumento.Id_serievnd'

          +' inner join '+ fshema+'IMCTipoDocumentoVenda on IMCTipoDocumentoVenda.ID_TipoDocVnd= vndcabdocumento.ID_TipoDocVnd'

          +'  inner join '+ fshema+'FntInterFaceCenExp '          
          +'  on IMCTipoDocumentoVenda.ID_InterFaceCenExp=FntInterFaceCenExp.ID_InterFaceCenExp '

          +' Where VndCabdocumento.anulado=0 '
          +'  and FntInterFaceCenExp.ID_InterFaceCenExp='+Inttostr(FOBJInterface.ID_InterfaceIMC)
          +' and IMCTipoDocumentoVenda.CodigoDefeito<>'''' '
          +' and TipoDocVnd.ligcc=1 and TipoDocVnd.LiqAutomatica=0';


          If ((ID_UltVndcabdocumentoExportado>0) and (pNumdoc='')) then
           stsrql4:=stsrql4+' and VndCabdocumento.ID_vndcabdocumento>'+Inttostr(ID_UltVndcabdocumentoExportado);

          
        If  FDataInicioExp>0 then
            stsrql4:=stsrql4+' and VndCabdocumento.data>='+sb.UtilSQL.DataToSQLData(FDataInicioExp);
        If  FdataFimExp>0 then
           stsrql4:=stsrql4+' and VndCabdocumento.data<='+sb.UtilSQL.DataToSQLData(FdataFimExp);





          strsql:=strsql+stsrql1+' Union All '+stsrql2+' Union All '+stsrql3+' Union All '+ stsrql4+
          ' ) as x ';

          If FperiodoIVA>0 then
          begin
            If FperiodoIVA=1 then
            begin
             strsql:=strsql  +' left join '+fshema+'V_NotasCreditoForaPeriodoIvaMensal as V_perIVA '
             +'  on x.ID_Vndcabdocumento=V_perIVA.ID_VndcabdocumentoDev'

            end
            else
            If FperiodoIVA=2 then
            begin
             strsql:=strsql  +' left join '+fshema+'V_NotasCreditoForaPeriodoIvaTrimestral as V_perIVA '
                            +'  on x.ID_Vndcabdocumento=V_perIVA.ID_VndcabdocumentoDev'
            end;
          end;
           If pNumdoc<>'' then
            strsql:=strsql+'  where x.ID_documento in('+pNumdoc+')';

           strsql:=strsql  +' Group By id_VndCabdocumento,subfamilia,ID_Documento,cliente,contribuinteentidade,TipoDoc,Seriedoc,TipoOperacao,'
                 +' TipoLinha,tipomov,VNDCONTACBL,ProdContCBL,'
                 +'  IVACONTACBL,DescricaoLinha,DescricaoLinha1,ContPagCBL,data,classeiva,valortotal, ContaCCusto,ContaAnalitica'
                 +', ContaCblCliente,Morada,Localidade,CodigoPostal,Telefone, ID_CodigoCliente,ID_ModoPagamento'
                 +',isnull(V_perIVA.ID_VndCabDocumentoDev,0)'
                 +',CodigoExternoFPerIVA '
                 +', CodigoExternoIvaFPerIVA'
                 +', ClasseIVAFPerIVA '
                 +', CentroCustoFPerIVA'
                 +', ContaAnaliticaFPerIVA,Mercado,TaxaIva'
                 +' order by id_vndcabdocumento,tipomov,subfamilia,DescricaoLinha1,'
                 +' tipolinha,VNDCONTACBL,ProdContCBL, ContaCCusto,ContaAnalitica,taxaIVa';



                 Try
                   caminho:=ExtractFilePath(Application.ExeName);
                    AssignFile(txtFileR,caminho+'sqlFntCBLSYS.TXT');
                    Rewrite(txtFileR);
                    Writeln(txtFileR,strsql);
                    CloseFile(txtFileR);
                 except
                 end;


                 Result:=sb.SBBD.AbrirLV(strsql);

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

