unit FNTIntfPrimaveraRecCBL0900;
interface

Uses FntBEEntidadeBase,SBBEObjAbs,SBBEListaObjAbs,SBBETabelaDados,FNTBETipoCons,
SBBEConsTipos,SBBEMapa,dialogs,Sysutils;

 Const
        //Comum
        CARACTERESPACO='0';
        CARACTERESPACO_AREALIVRE=' ';

        //Detalhe

          DETALHE_REFLETECLASSESIVA=1;
          DETALHE_REFLETEANALITICA=1;
          DETALHE_REFLETECENTROSCUSTOS=1;
          DETALHE_TIPOLINHA=1;
          DETALHE_MODULO=1;
          DETALHE_DATA=4;//DDMM
          DETALHE_CONTAMOVIMENTAR=20;
          DETALHE_DIARIO=5;
          DETALHE_NDIARIO=10;
          DETALHE_DOCUMENTO=5;
          DETALHE_NDOCUMENTO=10;
          DETALHE_DESCRICAO=50;
          DETALHE_VALORORIGEM=18;
          DETALHE_NATUREZA=1;
          DETALHE_ENTIDADE=12;
          DETALHE_TIPOENTIDADE=1;
          DETALHE_CLASSEIVA=10;
          DETALHE_CONTAORIGEM=20;
          DETALHE_LOTE=5;
          DETALHE_CLASSESELO=15;
          DETALHE_QUANTSELO=9;
          DETALHE_REFLETECLASSESSELO=1;
          DETALHE_REFLETEPLANOFUNCIONAL=1;
          DETALHE_TERCEIRO=15;
          DETALHE_TIPOTERCEIRO=1;
          DETALHE_MESRECOLHA=2;
          DETALHE_TIPOOPERACAO=1;
          DETALHE_ANO=4;
          DETALHE_MOEDAORIGEM=3;
          DETALHE_CAMBIOORIGEM=18;
          DETALHE_CAMBIOBASE=18;
          DETALHE_CAMBIOALTERNATIVO=18;
          DETALHE_TIPOAFETACAO=1;
          DETALHE_REFLETEFLUXOS=1;
          DETALHE_IVAAUTOLIQUIDACAO=10;
          DETALHE_PERCENTAGEMNDEDUTIVEL=7;
          //Versão CBL8.00
          DETALHE_TIPOLANCAMENTO=3;
          DETALHE_DATADOCUMENTO=8;
          DETALHE_NUMERODOCEXTERNO=20;
          DETALHE_OBSERVACOES=50;
          DETALHE_ITEMTESOURARIA=35;
          DETALHE_REFLETECOPE=1;
          DETALHE_COPECLASESTATISTICA=5;
          DETALHE_COPETIPOCONTA=1;
          DETALHE_COPECONTABANCARIA=5;
          DETALHE_COPEPAISENTIDADE=2;
          DETALHE_COPEPAISENTIDADEATIVOFINANC=2;
          DETALHE_COPENPC2INTERVENIENTE=20;
          DETALHE_COPEENTIDADEATIVO=15;
          DETALHE_COPEMONTANTE=18;
          //VERSÃO CBL8.01
          DETALHE_CODIGOPROJLINHA=40;
          DETALHE_ELEMENTOPEPLINHA=100;
          DETALHE_SERIEDOCUMENTO=5;
          DETALHE_PENDENTEDESCDOC=30;
          DETALHE_PENDENTEFILIAL=3;
        //VERSÃO CBL09.00 segundo documentação entregue por Sr.Pedro Pinheiro
        //tokens deixam de existir

{          DETALHE_PENDENTENUMEROPRESTACAO=5;
          DETALHE_PENDENTEVALOR=18;
          DETALHE_PENDENTEVALORMOEDABASE=18;
          DETALHE_PENDENTEVALORMOEDAALTER=18;
          DETALHE_PENDENTEMOEDADOC=3;
          DETALHE_PENDENTEMODULO=1;      }


         //VERSÃO CBL09.00 7 outubro de 2016   INDICAÇÕES sR.mANUEL pINTO
         //ACRESCENTAR TOKESN PREENCHER APENAS NIF O RESTO VAZIO
         //Temos um ficheiro em Word com mais tokens do que foi feito...
         //vamos alterar acrescentar numero contribuinte.

         DETALHE_PENDENTENUMEROPRESTACAO=5;
          DETALHE_PENDENTEVALOR=18;
          DETALHE_PENDENTEVALORMOEDABASE=18;
          DETALHE_PENDENTEVALORMOEDAALTER=18;
          DETALHE_PENDENTEMOEDADOC=3;
          DETALHE_PENDENTEMODULO=1; //727
          DETALHE_DATAOPERACAO=8;
          DETALHE_DATAEXPEDICAO=8;
          DETALHE_DATARECEPCAO=8;
          DETALHE_NIF=20;//752
          DETALHE_DESIGNACAOFISCAL=50;
          DETALHE_PAIS=2;
          DETALHE_DOCUMENTORECTIFICADO=60;
          DETALHE_TAXAIVA=6;
          DETALHE_MODOPAGAMENTO=5;
          DETALHE_BASEINCIDENCIA=11;
          DETALHE_IVANAODEDUTIVEL=11;
          DETALHE_TIPOOPERACAO1=2;
          DETALHE_NIFENTIDADE=20;
          DETALHE_NOMEFISCALENTIDADE=50;
          DETALHE_PAISENTIDADE=2;
          DETALHE_NIFTERCEIRO=20;
          DETALHE_NOMEFISCALTERCEIRO=50;
          DETALHE_PAISTERCEIRO=2;
          DETALHE_TIPORECOLHA=1;//1063//0

 Type

 TTipoAlinhamento=(taEsquerda, taDireita);

 Function GeraToken(const pValor:Variant; pTamanho: Integer;
            pCaracter: Char; pAlinhamento:TTipoAlinhamento=taEsquerda):String;




Type
  TLinhaVD = Class(TFntBEEntidadeBase)

  Public

         DETALHE_REFLETECLASSESIVA,
          DETALHE_REFLETEANALITICA,
          DETALHE_REFLETECENTROSCUSTOS,
          DETALHE_TIPOLINHA,
          DETALHE_MODULO,
          DETALHE_DATA,
          DETALHE_CONTAMOVIMENTAR,
          DETALHE_DIARIO,
          DETALHE_NDIARIO,
          DETALHE_DOCUMENTO,
          DETALHE_NDOCUMENTO,
          DETALHE_DESCRICAO,
          DETALHE_VALORORIGEM,
          DETALHE_NATUREZA,
          DETALHE_ENTIDADE,
          DETALHE_TIPOENTIDADE,
          DETALHE_CLASSEIVA,
          DETALHE_CONTAORIGEM,
          DETALHE_LOTE,
          DETALHE_CLASSESELO,
          DETALHE_QUANTSELO,
          DETALHE_REFLETECLASSESSELO,
          DETALHE_REFLETEPLANOFUNCIONAL,
          DETALHE_TERCEIRO,
          DETALHE_TIPOTERCEIRO,
          DETALHE_MESRECOLHA,
          DETALHE_TIPOOPERACAO,
          DETALHE_ANO,
          DETALHE_MOEDAORIGEM,
          DETALHE_CAMBIOORIGEM,
          DETALHE_CAMBIOBASE,
          DETALHE_CAMBIOALTERNATIVO,
          DETALHE_TIPOAFETACAO,
          DETALHE_REFLETEFLUXOS,
          DETALHE_IVAAUTOLIQUIDACAO,
          DETALHE_PERCENTAGEMNDEDUTIVEL,

 //Versão CBL8.00
          DETALHE_TIPOLANCAMENTO,
          DETALHE_DATADOCUMENTO,
          DETALHE_NUMERODOCEXTERNO,
          DETALHE_OBSERVACOES,
          DETALHE_ITEMTESOURARIA,
          DETALHE_REFLETECOPE,
          DETALHE_COPECLASESTATISTICA,
          DETALHE_COPETIPOCONTA,
          DETALHE_COPECONTABANCARIA,
          DETALHE_COPEPAISENTIDADE,
          DETALHE_COPEPAISENTIDADEATIVOFINANC,
          DETALHE_COPENPC2INTERVENIENTE,
          DETALHE_COPEENTIDADEATIVO,
          DETALHE_COPEMONTANTE,

          DETALHE_CODIGOPROJLINHA,
          DETALHE_ELEMENTOPEPLINHA,
          DETALHE_SERIEDOCUMENTO,
          DETALHE_PENDENTEDESCDOC,
          DETALHE_PENDENTEFILIAL:string;

        //VERSÃO CBL09.00 segundo documentação entregue por Sr.Pedro Pinheiro

         //alterações 7-10-2016 acrescentar os tokens segundo ficheiro Word M.Pinto
         //diferente do excel entregue anteriormente
         //PREENCEER APENAS nif O RESTO VAI A VAZIO m:pinto
          DETALHE_PENDENTENUMEROPRESTACAO,
          DETALHE_PENDENTEVALOR,
          DETALHE_PENDENTEVALORMOEDABASE,
          DETALHE_PENDENTEVALORMOEDAALTER,
          DETALHE_PENDENTEMOEDADOC,
          DETALHE_PENDENTEMODULO,
          DETALHE_DATAOPERACAO,
          DETALHE_DATAEXPEDICAO,
          DETALHE_DATARECEPCAO,
          DETALHE_NIF,
          DETALHE_DESIGNACAOFISCAL,
          DETALHE_PAIS,
          DETALHE_DOCUMENTORECTIFICADO,
          DETALHE_TAXAIVA,
          DETALHE_MODOPAGAMENTO,
          DETALHE_BASEINCIDENCIA,
          DETALHE_IVANAODEDUTIVEL,
          DETALHE_TIPOOPERACAO1,
          DETALHE_NIFENTIDADE,
          DETALHE_NOMEFISCALENTIDADE,
          DETALHE_PAISENTIDADE,
          DETALHE_NIFTERCEIRO,
          DETALHE_NOMEFISCALTERCEIRO,
          DETALHE_PAISTERCEIRO,
          DETALHE_TIPORECOLHA:STRING;




  End;

 type TLinhasVD = Class(TSBBEListaObjAbs)
  private
    function GetLinhaVDIdx(i: LongInt): TLinhaVD;


	public
    procedure Adiciona(pLinha: TLinhaVD);
    property Elem[i: LongInt]: TLinhaVD read GetLinhaVDIdx;

  End;



    Function DaListaDocumentosRecibosV90(pDataInicio,pDataFim:Tdatetime;pHotel:Integer):TSBBETAbelaDados;
    Function DaListaDocumentosRecibosV901(pDataInicio,pDataFim:Tdatetime;pHotel:Integer):TSBBETAbelaDados;
 Function GeraFicheirosRecibosVersao09(pLista:TSBBEtabeladados;pHotel:string;var pNomeFicheiro:String):Boolean;
 Function PreencheLinhaVndRec(pLista:TSBBEtabeladados):TLinhasVD;
 Procedure PreencheVariavaisConfGerais(pcaminhoFicheiro:string);
 var
 FDataInicioExp,
 FdataFimExp:Tdatetime;
 schema:string;
    FConnectionString:string;

implementation




Uses Variants,ierpOGLobais,StrUtils, DateUtils, SBBSSistemaBase,Classes,
  SBBaseDados,UgeralFunc, SBBSUtilSQL;

var FOmitirValoresZero:Boolean;
  FRefleteClasseIva,
  FRefleteAnalitica,
  FRefleteCentroCusto,
  FREFLETEFLUXOS,
  FREFLETECope,
  FDiario:string;
  FcaminhoFicheiro,
  FModulo:string;
  id_Pagamentocc:integer;
  FRecNatPAGCC:string;
  FRecNatPAG:string;





  {


INSERT INTO [dbo].[RecibosCBLPrimavera]
           ([ID]
           ,[ID_recibo]
           ,[DescricaoDoc]
           ,[TipoLinha]
           ,[TipoDocumento]
           ,[Serie]
           ,[ContaCBLTIPODOC]
           ,[ContaCBLPAG]
           ,[NATUREZA]
           ,[DataDoc]
           ,[ContaCBLCliente]
           ,[HoraDoc]
           ,[NomeCliente]
           ,[Valor]
           ,[DescricaoLinha]
           ,[ncontribuinte])
     VALUES
           (<ID, int,>
           ,<ID_recibo, nvarchar(30),>
           ,<DescricaoDoc, nvarchar(150),>
           ,<TipoLinha, int,>
           ,<TipoDocumento, nvarchar(10),>
           ,<Serie, nvarchar(10),>
           ,<ContaCBLTIPODOC, varchar(200),>
           ,<ContaCBLPAG, varchar(200),>
           ,<NATUREZA, nvarchar(1),>
           ,<DataDoc, datetime,>
           ,<ContaCBLCliente, varchar(5),>
           ,<HoraDoc, datetime,>
           ,<NomeCliente, nvarchar(200),>
           ,<Valor, float,>
           ,<DescricaoLinha, nvarchar(50),>
           ,<ncontribuinte, nvarchar(30),>)
GO
                 }

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




Procedure PreencheVariaveisNatureza(pvalor:Extended;var RecNatPAGCC:string; var RecNatPAG:string);
begin
  If  pvalor>=0 then
  begin
    RecNatPAGCC:=FRecNatPAGCC;
    RecNatPAG:=FRecNatPAG;
  end
  else
  begin
     If FRecNatPAGCC='C' then
       RecNatPAGCC:='D'
     else
       RecNatPAGCC:='C';

     If FRecNatPAG='C' then
       RecNatPAG:='D'
     else
       RecNatPAG:='C';

  end;
end;



Function DaListaDocumentosRecibosV90(pDataInicio,pDataFim:Tdatetime;pHotel:Integer):TSBBETAbelaDados;
var
   strSQL:string;
   RecNatPAGCC,
   RecNatPAG:string;
   ID_recibo,DescricaoDoc
   ,TipoLinha,TipoDocumento,Serie,ContaCBLTIPODOC,ContaCBLPAG
   ,NATUREZA,ContaCBLCliente,HoraDoc ,NomeCliente
  ,DescricaoLinha ,ncontribuinte,ID_HotelPms,ID_PagamentoPms:string;
  DataDoc:tdatetime;
  Valor:extended;
  ID_ClientePMS:Integer;


   Lista:TSBBETabeladados;
   DEBNO:string;
begin
   strSQL:='select fiscalcd.text as TipoDocOrigem,rechno,kunden.name1 as NomeCliente,'+schema+'.zahlart.bez as PagamentoCC,'
          + ' zahlart1.bez as PagamentoREC,'+schema+'.debitore.paid as Valor,'+schema+'.debitore.comment as ID_Recibo'
          +','+schema+'.debitore.datum as Data,'+schema+'.debitore.kundennr as ID_cliente'
          +','+schema+'.debitore.zahlart as ID_ModoPagCC'
          +','+schema+'.debitore.buchzahl as ID_ModoPagRC'
          +','+schema+'.kunden.fibudeb as cc_cliente'
          +','+schema+'.debitore.austext as DescDoc'
          +','+schema+'.Kunden.vatno as Ncontribuinte'
          +','+schema+'.debitore.mpehotel'
          +','+schema+'.debitore.debNo'

          +' from '+schema+'.debitore'
          +' inner join '+schema+'.fiscalcd on  '+schema+'.fiscalcd.ref= '+schema+'.debitore.fisccode'
          +' inner join '+schema+'.Kunden on  '+schema+'.Kunden.kdnr= '+schema+'.debitore.kundennr'
          +' inner join '+schema+'.zahlart on  '+schema+'.zahlart.za= '+schema+'.debitore.zahlart'
          +' inner join '+schema+'.zahlart as zahlart1 on  zahlart1.za= '+schema+'.debitore.buchzahl'
          +' where leistref=0 ';
         If pHotel>0 then
         begin
            strSQL:=strSQL + ' AND '+schema+'.debitore."mpehotel"=' + InTtostr(pHotel);
         end;

         If pDataInicio>0 then
            strSQL:=strSQL + ' AND '+schema+'.debitore."datum">=' + SB.UtilSQL.DataToSQLData(pDataInicio);

         If pDataFim>0 then
            strSQL:=strSQL +' AND '+schema+'.debitore."datum"<=' + SB.UtilSQL.DataToSQLData(pDataFim);

         strSQL:=strSQL+' order by '+schema+'.debitore."datum",'+schema+'.debitore.kundennr,'+schema+'.debitore.comment';

         Lista:=sb.SBBD.AbrirLV(strSQL);

         Lista.Inicio;

         sb.SBBD.ExecutaSqlExterno(FConnectionString,'delete from RecibosCblPrimavera');
         While Not (Lista.NoFim) do
         begin
            PreencheVariaveisNatureza(Lista.daValor('valor').asFloat,RecNatPAGCC,RecNatPAG);

            ID_recibo:= Lista.daValor('iD_Recibo').asstring;
            DescricaoDoc:= Lista.daValor('DescDoc').asstring;
            TipoLinha:='0';
            TipoDocumento:='';
            Serie:='';
            ContaCBLTIPODOC:='';
            ContaCBLPAG:='';
            DataDoc:= Lista.daValor('data').asdatetime;
            ContaCBLCliente:= Lista.daValor('cc_cliente').asstring;
//            HoraDoc
            NomeCliente := Lista.daValor('NomeCliente').asstring;
            Valor:=0;
            Valor:= abs(Lista.daValor('valor').asfloat);
            ncontribuinte := Lista.daValor('Ncontribuinte').asstring;
            ID_HotelPms := Lista.daValor('mpehotel').asstring;
            ID_ClientePMS:= Lista.daValor('ID_cliente').asInteger;


             //Linha Pagamento Conta corrente
             NATUREZA:= RecNatPAGCC;
             DescricaoLinha := Lista.daValor('PagamentoCC').asstring;
             ID_PagamentoPms := Lista.daValor('ID_ModoPagCC').asstring;
             DEBNO:= Lista.daValor('DEBNO').asstring;

             TipoLinha:='0';
             strSQL:=' Insert Into RecibosCblPrimavera ([ID_recibo],[DescricaoDoc]'
             +' ,[TipoLinha],[TipoDocumento],[Serie],[ContaCBLTIPODOC],[ContaCBLPAG]'
             +' ,[NATUREZA],[DataDoc],[ContaCBLCliente],[NomeCliente]'
             +' ,[Valor],[DescricaoLinha] ,[ncontribuinte]'
             +',ID_PagamentoPms,ID_HotelPms,ID_ClientePMS,DEBNO)'
             +' values ( '
             + sb.UtilSQL.StrToSQLStrpelica(ID_recibo)
             +','+ sb.UtilSQL.StrToSQLStrpelica(DescricaoDoc)
             +','+ sb.UtilSQL.StrToSQLStrpelica(TipoLinha)
             +','+ sb.UtilSQL.StrToSQLStrpelica(TipoDocumento)
             +','+ sb.UtilSQL.StrToSQLStrpelica(Serie)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLTIPODOC)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLPAG)
             +','+ sb.UtilSQL.StrToSQLStrpelica(NATUREZA)
             +','+ sb.UtilSQL.DataToSQLData(DataDoc)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLCliente)
             +','+ sb.UtilSQL.StrToSQLStrpelica(NomeCliente)
             +','+ sb.UtilSQL.DecimalToSQLStr(Valor)
             +','+ sb.UtilSQL.StrToSQLStrpelica(DescricaoLinha)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ncontribuinte)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_PagamentoPms)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_HotelPms)
             +','+ inttostr(ID_ClientePMS)
             +','+ #39+DEBNO+#39
             +')';
             sb.SBBD.ExecutaSqlExterno(FConnectionString,strSQL);



             //Linha Pagamento Liquidacao
             NATUREZA:= RecNatPAG;
             DescricaoLinha := Lista.daValor('PagamentoREC').asstring;
            ID_PagamentoPms := Lista.daValor('ID_ModoPagRC').asstring;
            TipoLinha:='1';
          strSQL:=' Insert Into RecibosCblPrimavera ([ID_recibo],[DescricaoDoc]'
             +' ,[TipoLinha],[TipoDocumento],[Serie],[ContaCBLTIPODOC],[ContaCBLPAG]'
             +' ,[NATUREZA],[DataDoc],[ContaCBLCliente],[NomeCliente]'
             +' ,[Valor],[DescricaoLinha] ,[ncontribuinte]'
             +',ID_PagamentoPms,ID_HotelPms,ID_ClientePMS,DEBNO)'
             +' values ( '
             + sb.UtilSQL.StrToSQLStrpelica(ID_recibo)
             +','+ sb.UtilSQL.StrToSQLStrpelica(DescricaoDoc)
             +','+ sb.UtilSQL.StrToSQLStrpelica(TipoLinha)
             +','+ sb.UtilSQL.StrToSQLStrpelica(TipoDocumento)
             +','+ sb.UtilSQL.StrToSQLStrpelica(Serie)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLTIPODOC)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLPAG)
             +','+ sb.UtilSQL.StrToSQLStrpelica(NATUREZA)
             +','+ sb.UtilSQL.DataToSQLData(DataDoc)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLCliente)
             +','+ sb.UtilSQL.StrToSQLStrpelica(NomeCliente)
             +','+ sb.UtilSQL.DecimalToSQLStr(Valor)
             +','+ sb.UtilSQL.StrToSQLStrpelica(DescricaoLinha)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ncontribuinte)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_PagamentoPms)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_HotelPms)
             +','+ inttostr(ID_ClientePMS)
                 +','+ #39+DEBNO+#39
             +')';
             sb.SBBD.ExecutaSqlExterno(FConnectionString,strSQL);
              Lista.seguinte;
         end;

         strSQL:='update RecibosCblPrimavera '
                +' set ContaCBLPAG=Primav_ModoPagamento.contacbl'
                +' from RecibosCblPrimavera'
                +' inner join Primav_ModoPagamento'
                +' on Primav_ModoPagamento.Pms_ID_ModoPagamento=RecibosCblPrimavera.id_PagamentoPms';

         sb.SBBD.ExecutaSqlExterno(FConnectionString,strSQL);





end;



Procedure PreencheVariavaisConfGerais(pcaminhoFicheiro:string);
var
  strsql:string;
    FConnectionString:string;
  Lstdados:TSBBETabelaDados;
begin
Try
    FcaminhoFicheiro:=pcaminhoFicheiro;
    id_Pagamentocc:=0;

    strsql:='Select * from ERP_CBLParametros';
    Lstdados:=sb.SBBD.AbrirLV(strsql);
    If Not(Lstdados.Vazia) then
    begin
      FModulo:=Lstdados.daValor('ModuloReC').asstring;
      FOmitirValoresZero:=Lstdados.daValor('OmiteLinhaZero').asboolean;
      FREFLETEFLUXOS:=Lstdados.daValor('ReflecteFluxosRec').asstring;
      FREFLETECope:=Lstdados.daValor('ReflecteCOPERec').asstring;
      FRefleteClasseIva:=Lstdados.daValor('RefleteClasseIvaReC').asstring;
      FRefleteAnalitica:=Lstdados.daValor('RefleteAnaliticaReC').asstring;
      FRefleteCentroCusto:=Lstdados.daValor('RefleteCentroCustosReC').asstring;
      FDiario:=Lstdados.daValor('DiarioReC').asstring;
      id_Pagamentocc:=Lstdados.daValor('id_Pagamentocc').asInteger;
      FRecNatPAGCC:=Lstdados.daValor('RecNatPAGCC').asstring;
      FRecNatPAG:=Lstdados.daValor('RecNatPAG').asstring;


    end;

    FreeAndnil(lstdados);
except
raise
end;

end;


procedure TLinhasVD.Adiciona(pLinha: TLinhaVD);
begin
  Self.AdicionaObj(pLinha);
end;


function TLinhasVD.GetLinhaVDIdx(i: LongInt): TLinhaVD;
begin
  If i < Self.Num  Then
  Begin
    result := TLinhaVD(self.Elemento[i]);
  End
  Else
  Begin
    result := nil;
  End;
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

Function TrataDecimais(Valor: String): String;
Begin
  If length(valor)>0 Then
    Result := StringReplace(Valor, ',', '.', [rfReplaceAll])
  Else
    Result := '0.00';

End;


Function PreencheLinhaVndRec(pLista:TSBBEtabeladados):TLinhasVD;
var
   LinhaVD:TLinhaVD;
   Lote:Integer;
begin
 Lote:=1;
 Result:= TLinhasVD.Create;
 pLista.inicio;
 While Not(pLista.nofim) do
 begin
   If ((Not(FOmitirValoresZero)) or   (pLista.davalor('valor').asFloat>0)) then
   begin
    LinhaVD:=TLinhaVD.Create;
    With LinhaVD do
    begin

         DETALHE_REFLETECLASSESIVA:=FRefleteClasseIva;
         DETALHE_REFLETEANALITICA:=FRefleteAnalitica;
         DETALHE_REFLETECENTROSCUSTOS:=FRefleteCentroCusto;
         DETALHE_TIPOLINHA:='F';
         DETALHE_MODULO:=FModulo;

         DETALHE_DATA:=DADataDDMM(pLista.davalor('datadoc').asdatetime);//DDMM//tratar
         DETALHE_NATUREZA:= pLista.davalor('Natureza').asstring;

         If pLista.davalor('TipoLinha').asinteger=0 then
             DETALHE_CONTAMOVIMENTAR:=pLista.davalor('ContaCBLPag').asstring+pLista.davalor('ContaCBLCliente').asstring
         Else
          DETALHE_CONTAMOVIMENTAR:=pLista.davalor('ContaCBLPag').asstring;



         DETALHE_DIARIO:=FDiario;
         DETALHE_NDIARIO:='-1';
         DETALHE_DOCUMENTO:=pLista.davalor('contaCBlTipoDoc').asstring;

         DETALHE_NDOCUMENTO:='-1';
         DETALHE_DESCRICAO:=pLista.davalor('ID_Recibo').asstring;


         DETALHE_VALORORIGEM:=TrataDecimais(Floattostr(UgeralFunc.Arredonda(pLista.davalor('Valor').asFloat,2)));
//         DETALHE_VALORORIGEM:=TrataDecimais(Currtostrf(pLista.davalor('Valor').asFloat,Ffnumber,4));
         DETALHE_ENTIDADE:='';
         //pLista.davalor('nomefornecedor').asstring;
         DETALHE_TIPOENTIDADE:='';
         DETALHE_CLASSEIVA:='';
         DETALHE_CONTAORIGEM:=DETALHE_CONTAMOVIMENTAR;
         DETALHE_LOTE:=InTtostr(Lote);
         DETALHE_CLASSESELO:='';
         DETALHE_QUANTSELO:='';
         DETALHE_REFLETECLASSESSELO:='';
         DETALHE_REFLETEPLANOFUNCIONAL:='';
         DETALHE_TERCEIRO:='';
         DETALHE_TIPOTERCEIRO:='';
         DETALHE_MESRECOLHA:='';
         DETALHE_TIPOOPERACAO:='';
         DETALHE_ANO:=IntTostr(YearOf(pLista.davalor('Datadoc').asdatetime));
         DETALHE_MOEDAORIGEM:='EUR';
         DETALHE_CAMBIOORIGEM:='1.0000000';
         DETALHE_CAMBIOBASE:='1.0000000';
         DETALHE_CAMBIOALTERNATIVO:='1.0000000';
         DETALHE_TIPOAFETACAO:='0';
         DETALHE_REFLETEFLUXOS:=FREFLETEFLUXOS;
         DETALHE_IVAAUTOLIQUIDACAO:='';
         DETALHE_PERCENTAGEMNDEDUTIVEL:='';
        // //VERSÃO CBL8.00
          DETALHE_TIPOLANCAMENTO:='000';
          DETALHE_DATADOCUMENTO:=DADataDDMMANO(pLista.davalor('datadoc').asdatetime);
          DETALHE_NUMERODOCEXTERNO:=pLista.davalor('ID_Recibo').asstring;
          DETALHE_OBSERVACOES:='';
          DETALHE_ITEMTESOURARIA:='';
          DETALHE_REFLETECOPE:=FREFLETECope;
          DETALHE_COPECLASESTATISTICA:='';
          DETALHE_COPETIPOCONTA:='';
          DETALHE_COPECONTABANCARIA:='';
          DETALHE_COPEPAISENTIDADE:='';
          DETALHE_COPEPAISENTIDADEATIVOFINANC:='';
          DETALHE_COPENPC2INTERVENIENTE:='';
          DETALHE_COPEENTIDADEATIVO:='';
          DETALHE_COPEMONTANTE:='';
          //VERSÃO CBL8.01
          DETALHE_CODIGOPROJLINHA:='';
          DETALHE_ELEMENTOPEPLINHA:=copy(plista.davalor('debNo').asstring,1,100);
          DETALHE_SERIEDOCUMENTO:=Copy(pLista.davalor('Serie').asstring,1,5);
          DETALHE_PENDENTEDESCDOC:='';
          DETALHE_PENDENTEFILIAL:='';

         DETALHE_PENDENTENUMEROPRESTACAO:='';
          DETALHE_PENDENTEVALOR:='';
          DETALHE_PENDENTEVALORMOEDABASE:='';
          DETALHE_PENDENTEVALORMOEDAALTER:='';
          DETALHE_PENDENTEMOEDADOC:='';
          DETALHE_PENDENTEMODULO:='';
          DETALHE_DATAOPERACAO:=DADataDDMMANO(pLista.davalor('dataMovimento').asdatetime);//DDMMANO//tratar
          DETALHE_DATAEXPEDICAO:='';
          DETALHE_DATARECEPCAO:='';
          DETALHE_NIF:=pLista.davalor('ncontribuinte').asstring;
          DETALHE_DESIGNACAOFISCAL:='';
          DETALHE_PAIS:='';
          DETALHE_DOCUMENTORECTIFICADO:='';
          DETALHE_TAXAIVA:='';
          DETALHE_MODOPAGAMENTO:='';
          DETALHE_BASEINCIDENCIA:='';
          DETALHE_IVANAODEDUTIVEL:='';
          DETALHE_TIPOOPERACAO1:='';
          DETALHE_NIFENTIDADE:='';
          DETALHE_NOMEFISCALENTIDADE:='';
          DETALHE_PAISENTIDADE:='';
          DETALHE_NIFTERCEIRO:='';
          DETALHE_NOMEFISCALTERCEIRO:='';
          DETALHE_PAISTERCEIRO:='';
          DETALHE_TIPORECOLHA:='0';




         Result.Adiciona(LinhaVD);
         inc(Lote);
      end;
    end;

    pLista.seguinte;
  end;
end;




Procedure AdicionaLinhaFactura(pLinha:TLinhaVD;pNDocumento:integer;var ListaLinhas:Tstringlist);
var

         DETALHEREFLETECLASSESIVA,
          DETALHEREFLETEANALITICA,
          DETALHEREFLETECENTROSCUSTOS,
          DETALHETIPOLINHA,
          DETALHEMODULO,
          DETALHEDATA,
          DETALHECONTAMOVIMENTAR,
          DETALHEDIARIO,
          DETALHENDIARIO,
          DETALHEDOCUMENTO,
          DETALHENDOCUMENTO,
          DETALHEDESCRICAO,
          DETALHEVALORORIGEM,
          DETALHENATUREZA,
          DETALHEENTIDADE,
          DETALHETIPOENTIDADE,
          DETALHECLASSEIVA,
          DETALHECONTAORIGEM,
          DETALHELOTE,
          DETALHECLASSESELO,
          DETALHEQUANTSELO,
          DETALHEREFLETECLASSESSELO,
          DETALHEREFLETEPLANOFUNCIONAL,
          DETALHETERCEIRO,
          DETALHETIPOTERCEIRO,
          DETALHEMESRECOLHA,
          DETALHETIPOOPERACAO,
          DETALHEANO,
          DETALHEMOEDAORIGEM,
          DETALHECAMBIOORIGEM,
          DETALHECAMBIOBASE,
          DETALHECAMBIOALTERNATIVO,
          DETALHETIPOAFETACAO,
          DETALHEREFLETEFLUXOS,
          DETALHEPERCENTAGEMNDEDUTIVEL,
          DETALHEIVAAUTOLIQUIDACAO,
               //VERSÃ CBL8.00
          DETALHETIPOLANCAMENTO,
          DETALHEDATADOCUMENTO,
          DETALHENUMERODOCEXTERNO,
          DETALHEOBSERVACOES,
          DETALHEITEMTESOURARIA,
          DETALHEREFLETECOPE,
          DETALHECOPECLASESTATISTICA,
          DETALHECOPETIPOCONTA,
          DETALHECOPECONTABANCARIA,
          DETALHECOPEPAISENTIDADE,
          DETALHECOPEPAISENTIDADEATIVOFINANC,
          DETALHECOPENPC2INTERVENIENTE,
          DETALHECOPEENTIDADEATIVO,
          DETALHECOPEMONTANTE,
          //VERSÃ CBL8.01
          DETALHECODIGOPROJLINHA,
          DETALHEELEMENTOPEPLINHA,
          DETALHESERIEDOCUMENTO,
          DETALHEPENDENTEDESCDOC,
          DETALHEPENDENTEFILIAL,
   DETALHEPENDENTENUMEROPRESTACAO,
          DETALHEPENDENTEVALOR,
          DETALHEPENDENTEVALORMOEDABASE,
          DETALHEPENDENTEVALORMOEDAALTER,
          DETALHEPENDENTEMOEDADOC,
          DETALHEPENDENTEMODULO,

          DETALHEDATAOPERACAO,
          DETALHEDATAEXPEDICAO,
          DETALHEDATARECEPCAO,
          DETALHENIF,
          DETALHEDESIGNACAOFISCAL,
          DETALHEPAIS,
          DETALHEDOCUMENTORECTIFICADO,
          DETALHETAXAIVA,
          DETALHEMODOPAGAMENTO,
          DETALHEBASEINCIDENCIA,
          DETALHEIVANAODEDUTIVEL,
          DETALHETIPOOPERACAO1,
          DETALHENIFENTIDADE,
          DETALHENOMEFISCALENTIDADE,
          DETALHEPAISENTIDADE,
          DETALHENIFTERCEIRO,
          DETALHENOMEFISCALTERCEIRO,
          DETALHEPAISTERCEIRO,
          DETALHETIPORECOLHA:STRING;






        valorlinha,
        centroanalitico,
        ID_Iva,
        ID_Caixa:string;
        LINHASTR:STRING;
begin

          DETALHEREFLETECLASSESIVA:=GeraToken(pLinha.DETALHE_REFLETECLASSESIVA,DETALHE_REFLETECLASSESIVA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEREFLETEANALITICA:=GeraToken(pLinha.DETALHE_REFLETEANALITICA,DETALHE_REFLETEANALITICA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEREFLETECENTROSCUSTOS:=GeraToken(pLinha.DETALHE_REFLETECENTROSCUSTOS,DETALHE_REFLETECENTROSCUSTOS,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHETIPOLINHA:=GeraToken(pLinha.DETALHE_TIPOLINHA,DETALHE_TIPOLINHA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEMODULO:=GeraToken(pLinha.DETALHE_MODULO,DETALHE_MODULO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEDATA:=GeraToken(pLinha.DETALHE_DATA,DETALHE_DATA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECONTAMOVIMENTAR:=GeraToken(pLinha.DETALHE_CONTAMOVIMENTAR,DETALHE_CONTAMOVIMENTAR,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEDIARIO:=GeraToken(pLinha.DETALHE_DIARIO,DETALHE_DIARIO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHENDIARIO:=GeraToken(pLinha.DETALHE_NDIARIO,DETALHE_NDIARIO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEDOCUMENTO:=GeraToken(pLinha.DETALHE_DOCUMENTO,DETALHE_DOCUMENTO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHENDOCUMENTO:=GeraToken(pNDocumento,DETALHE_NDOCUMENTO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEDESCRICAO:=GeraToken(pLinha.DETALHE_DESCRICAO,DETALHE_DESCRICAO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEVALORORIGEM:=GeraToken(pLinha.DETALHE_VALORORIGEM,DETALHE_VALORORIGEM,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHENATUREZA:=GeraToken(pLinha.DETALHE_NATUREZA,DETALHE_NATUREZA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEENTIDADE:=GeraToken(pLinha.DETALHE_ENTIDADE,DETALHE_ENTIDADE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHETIPOENTIDADE:=GeraToken(pLinha.DETALHE_TIPOENTIDADE,DETALHE_TIPOENTIDADE,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHECLASSEIVA:=GeraToken(pLinha.DETALHE_CLASSEIVA,DETALHE_CLASSEIVA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECONTAORIGEM:=GeraToken(pLinha.DETALHE_CONTAORIGEM,DETALHE_CONTAORIGEM,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHELOTE:=GeraToken(pLinha.DETALHE_LOTE,DETALHE_LOTE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECLASSESELO:=GeraToken(pLinha.DETALHE_CLASSESELO,DETALHE_CLASSESELO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEQUANTSELO:=GeraToken(pLinha.DETALHE_QUANTSELO,DETALHE_QUANTSELO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEREFLETECLASSESSELO:=GeraToken(pLinha.DETALHE_REFLETECLASSESSELO,DETALHE_REFLETECLASSESSELO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEREFLETEPLANOFUNCIONAL:=GeraToken(pLinha.DETALHE_REFLETEPLANOFUNCIONAL,DETALHE_REFLETEPLANOFUNCIONAL,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHETERCEIRO:=GeraToken(pLinha.DETALHE_TERCEIRO,DETALHE_TERCEIRO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHETIPOTERCEIRO:=GeraToken(pLinha.DETALHE_TIPOTERCEIRO,DETALHE_TIPOTERCEIRO,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHEMESRECOLHA:=GeraToken(pLinha.DETALHE_MESRECOLHA,DETALHE_MESRECOLHA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHETIPOOPERACAO:=GeraToken(pLinha.DETALHE_TIPOOPERACAO,DETALHE_TIPOOPERACAO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEANO:=GeraToken(pLinha.DETALHE_ANO,DETALHE_ANO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEMOEDAORIGEM:=GeraToken(pLinha.DETALHE_MOEDAORIGEM,DETALHE_MOEDAORIGEM,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECAMBIOORIGEM:=GeraToken(pLinha.DETALHE_CAMBIOORIGEM,DETALHE_CAMBIOORIGEM,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECAMBIOBASE:=GeraToken(pLinha.DETALHE_CAMBIOBASE,DETALHE_CAMBIOBASE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECAMBIOALTERNATIVO:=GeraToken(pLinha.DETALHE_CAMBIOALTERNATIVO,DETALHE_CAMBIOALTERNATIVO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHETIPOAFETACAO:=GeraToken(pLinha.DETALHE_TIPOAFETACAO,DETALHE_TIPOAFETACAO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEREFLETEFLUXOS:=GeraToken(pLinha.DETALHE_REFLETEFLUXOS,DETALHE_REFLETEFLUXOS,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEIVAAUTOLIQUIDACAO:=GeraToken(pLinha.DETALHE_IVAAUTOLIQUIDACAO,DETALHE_IVAAUTOLIQUIDACAO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPERCENTAGEMNDEDUTIVEL:=GeraToken(pLinha.DETALHE_PERCENTAGEMNDEDUTIVEL,DETALHE_PERCENTAGEMNDEDUTIVEL,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          //versaoa 8.00
          DETALHETIPOLANCAMENTO:=GeraToken(pLinha.DETALHE_TIPOLANCAMENTO,DETALHE_TIPOLANCAMENTO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEDATADOCUMENTO:=GeraToken(pLinha.DETALHE_DATADOCUMENTO,DETALHE_DATADOCUMENTO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHENUMERODOCEXTERNO:=GeraToken(pLinha.DETALHE_NUMERODOCEXTERNO,DETALHE_NUMERODOCEXTERNO,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHEOBSERVACOES:=GeraToken(pLinha.DETALHE_OBSERVACOES,DETALHE_OBSERVACOES,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHEITEMTESOURARIA:=GeraToken(pLinha.DETALHE_ITEMTESOURARIA,DETALHE_ITEMTESOURARIA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEREFLETECOPE:=GeraToken(pLinha.DETALHE_REFLETECOPE,DETALHE_REFLETECOPE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECOPECLASESTATISTICA:=GeraToken(pLinha.DETALHE_COPECLASESTATISTICA,DETALHE_COPECLASESTATISTICA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECOPETIPOCONTA:=GeraToken(pLinha.DETALHE_COPETIPOCONTA,DETALHE_COPETIPOCONTA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECOPECONTABANCARIA:=GeraToken(pLinha.DETALHE_COPECONTABANCARIA,DETALHE_COPECONTABANCARIA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECOPEPAISENTIDADE:=GeraToken(pLinha.DETALHE_COPEPAISENTIDADE,DETALHE_COPEPAISENTIDADE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECOPEPAISENTIDADEATIVOFINANC:=GeraToken(pLinha.DETALHE_COPEPAISENTIDADEATIVOFINANC,DETALHE_COPEPAISENTIDADEATIVOFINANC,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECOPENPC2INTERVENIENTE:=GeraToken(pLinha.DETALHE_COPENPC2INTERVENIENTE,DETALHE_COPENPC2INTERVENIENTE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECOPEENTIDADEATIVO:=GeraToken(pLinha.DETALHE_COPEENTIDADEATIVO,DETALHE_COPEENTIDADEATIVO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHECOPEMONTANTE:=GeraToken(pLinha.DETALHE_COPEMONTANTE,DETALHE_COPEMONTANTE,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHECODIGOPROJLINHA:=GeraToken(pLinha.DETALHE_CODIGOPROJLINHA,DETALHE_CODIGOPROJLINHA,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHEELEMENTOPEPLINHA:=GeraToken(pLinha.DETALHE_ELEMENTOPEPLINHA,DETALHE_ELEMENTOPEPLINHA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHESERIEDOCUMENTO:=GeraToken(pLinha.DETALHE_SERIEDOCUMENTO,DETALHE_SERIEDOCUMENTO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPENDENTEDESCDOC:=GeraToken(pLinha.DETALHE_PENDENTEDESCDOC,DETALHE_PENDENTEDESCDOC,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPENDENTEFILIAL:=GeraToken(pLinha.DETALHE_PENDENTEFILIAL,DETALHE_PENDENTEFILIAL,
           CARACTERESPACO_AREALIVRE,taEsquerda);




          //07-10-2016

          DETALHEPENDENTENUMEROPRESTACAO:=GeraToken(pLinha.DETALHE_PENDENTENUMEROPRESTACAO,DETALHE_PENDENTENUMEROPRESTACAO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPENDENTEVALOR:=GeraToken(pLinha.DETALHE_PENDENTEVALOR,DETALHE_PENDENTEVALOR,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPENDENTEVALORMOEDABASE:=GeraToken(pLinha.DETALHE_PENDENTEVALORMOEDABASE,DETALHE_PENDENTEVALORMOEDABASE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPENDENTEVALORMOEDAALTER:=GeraToken(pLinha.DETALHE_PENDENTEVALORMOEDAALTER,DETALHE_PENDENTEVALORMOEDAALTER,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPENDENTEMOEDADOC:=GeraToken(pLinha.DETALHE_PENDENTEMOEDADOC,DETALHE_PENDENTEMOEDADOC,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPENDENTEMODULO:=GeraToken(pLinha.DETALHE_PENDENTEMODULO,DETALHE_PENDENTEMODULO,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHEDATAOPERACAO:=GeraToken(pLinha.DETALHE_DATAOPERACAO,DETALHE_DATAOPERACAO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEDATAEXPEDICAO:=GeraToken(pLinha.DETALHE_DATAEXPEDICAO,DETALHE_DATAEXPEDICAO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEDATARECEPCAO:=GeraToken(pLinha.DETALHE_DATARECEPCAO,DETALHE_DATARECEPCAO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

         //ESTE NOVO COM DADOS
          DETALHENIF:=GeraToken(pLinha.DETALHE_NIF,DETALHE_NIF,
           CARACTERESPACO_AREALIVRE,taEsquerda);


          DETALHEDESIGNACAOFISCAL:=GeraToken(pLinha.DETALHE_DESIGNACAOFISCAL,DETALHE_DESIGNACAOFISCAL,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPAIS:=GeraToken(pLinha.DETALHE_PAIS,DETALHE_PAIS,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEDOCUMENTORECTIFICADO:=GeraToken(pLinha.DETALHE_DOCUMENTORECTIFICADO,DETALHE_DOCUMENTORECTIFICADO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHETAXAIVA:=GeraToken(pLinha.DETALHE_TAXAIVA,DETALHE_TAXAIVA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEMODOPAGAMENTO:=GeraToken(pLinha.DETALHE_MODOPAGAMENTO,DETALHE_MODOPAGAMENTO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEBASEINCIDENCIA:=GeraToken(pLinha.DETALHE_BASEINCIDENCIA,DETALHE_BASEINCIDENCIA,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEIVANAODEDUTIVEL:=GeraToken(pLinha.DETALHE_IVANAODEDUTIVEL,DETALHE_IVANAODEDUTIVEL,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHETIPOOPERACAO1:=GeraToken(pLinha.DETALHE_TIPOOPERACAO1,DETALHE_TIPOOPERACAO1,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHENIFENTIDADE:=GeraToken(pLinha.DETALHE_NIFENTIDADE,DETALHE_NIFENTIDADE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHENOMEFISCALENTIDADE:=GeraToken(pLinha.DETALHE_NOMEFISCALENTIDADE,DETALHE_NOMEFISCALENTIDADE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPAISENTIDADE:=GeraToken(pLinha.DETALHE_PAISENTIDADE,DETALHE_PAISENTIDADE,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHENIFTERCEIRO:=GeraToken(pLinha.DETALHE_NIFTERCEIRO,DETALHE_NIFTERCEIRO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHENOMEFISCALTERCEIRO:=GeraToken(pLinha.DETALHE_NOMEFISCALTERCEIRO,DETALHE_NOMEFISCALTERCEIRO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHEPAISTERCEIRO:=GeraToken(pLinha.DETALHE_PAISTERCEIRO,DETALHE_PAISTERCEIRO,
           CARACTERESPACO_AREALIVRE,taEsquerda);

          DETALHETIPORECOLHA:=GeraToken(pLinha.DETALHE_TIPORECOLHA,DETALHE_TIPORECOLHA,
           CARACTERESPACO_AREALIVRE,taEsquerda);








LINHASTR:=DETALHEREFLETECLASSESIVA+
                  DETALHEREFLETEANALITICA+
                  DETALHEREFLETECENTROSCUSTOS+
                  DETALHETIPOLINHA+
                  DETALHEMODULO+
                  DETALHEDATA+
                  DETALHECONTAMOVIMENTAR+
                  DETALHEDIARIO+
                  DETALHENDIARIO+
                  DETALHEDOCUMENTO+
                  DETALHENDOCUMENTO+
                  DETALHEDESCRICAO+
                  DETALHEVALORORIGEM+
                  DETALHENATUREZA+
                  DETALHEENTIDADE+
                  DETALHETIPOENTIDADE+
                  DETALHECLASSEIVA+
                  DETALHECONTAORIGEM+
                  DETALHELOTE+
                  DETALHECLASSESELO+
                  DETALHEQUANTSELO+
                  DETALHEREFLETECLASSESSELO+
                  DETALHEREFLETEPLANOFUNCIONAL+
                  DETALHETERCEIRO+
                  DETALHETIPOTERCEIRO+
                  DETALHEMESRECOLHA+
                  DETALHETIPOOPERACAO+
                  DETALHEANO+
                  DETALHEMOEDAORIGEM+
                  DETALHECAMBIOORIGEM+
                  DETALHECAMBIOBASE+
                  DETALHECAMBIOALTERNATIVO+
                  DETALHETIPOAFETACAO+
                  DETALHEREFLETEFLUXOS+
                  DETALHEIVAAUTOLIQUIDACAO+
                  DETALHEPERCENTAGEMNDEDUTIVEL+
                  DETALHETIPOLANCAMENTO+  //versoa8.00
                  DETALHEDATADOCUMENTO+
                  DETALHENUMERODOCEXTERNO+
                  DETALHEOBSERVACOES+
                  DETALHEITEMTESOURARIA+
                  DETALHEREFLETECOPE+
                  DETALHECOPECLASESTATISTICA+
                  DETALHECOPETIPOCONTA+
                  DETALHECOPECONTABANCARIA+
                  DETALHECOPEPAISENTIDADE+
                  DETALHECOPEPAISENTIDADEATIVOFINANC+
                  DETALHECOPENPC2INTERVENIENTE+
                  DETALHECOPEENTIDADEATIVO+
                  DETALHECOPEMONTANTE+
                  //VERSÃ CBL8.01
                  DETALHECODIGOPROJLINHA+
                  DETALHEELEMENTOPEPLINHA+
                  DETALHESERIEDOCUMENTO+
                  DETALHEPENDENTEDESCDOC+
                  DETALHEPENDENTEFILIAL+
                  DETALHEPENDENTENUMEROPRESTACAO+
                  DETALHEPENDENTEVALOR+
                  DETALHEPENDENTEVALORMOEDABASE+
                  DETALHEPENDENTEVALORMOEDAALTER+
                  DETALHEPENDENTEMOEDADOC+
                  DETALHEPENDENTEMODULO+

                  DETALHEDATAOPERACAO+
                  DETALHEDATAEXPEDICAO+
                  DETALHEDATARECEPCAO+
                  DETALHENIF+
                  DETALHEDESIGNACAOFISCAL+
                  DETALHEPAIS+
                  DETALHEDOCUMENTORECTIFICADO+
                  DETALHETAXAIVA+
                  DETALHEMODOPAGAMENTO+
                  DETALHEBASEINCIDENCIA+
                  DETALHEIVANAODEDUTIVEL+
                  DETALHETIPOOPERACAO1+
                  DETALHENIFENTIDADE+
                  DETALHENOMEFISCALENTIDADE+
                  DETALHEPAISENTIDADE+
                  DETALHENIFTERCEIRO+
                  DETALHENOMEFISCALTERCEIRO+
                  DETALHEPAISTERCEIRO+
                  DETALHETIPORECOLHA;


 ListaLinhas.Add(lINHASTR);

end;
{duvidas ID_cliente
IVA A Zero envio linha á parte
controlamos ficheiros Gerados?
Nome do Ficheiro?
Agrupar? por Familia
Trta Iva Incluido
}




Function   DaProximoID(pNomeTabela:String;pActualiza:Boolean):integer;
var
   lstContadores:tsbbetabeladados;
   FConnectionString,strsql:string;
begin
{   FConnectionString:=ObterConexao;
   If FConnectionString<>''  then
   begin
      lstContadores:=SB.SBBD.AbrirLV(FConnectionString,'select ID_Corrente+1 as ID_Corrente from contadores Where Nome_tabela='+#39+pNomeTabela+#39);
      Result:= lstContadores.davalor('ID_Corrente').AsInteger;
      If  pActualiza    then
      begin
        strsql:='Update contadores set id_corrente='+inttostr(Result)
            +' Where Nome_tabela='+#39+pNomeTabela+#39;
            SB.SBBD.executasqlexterno(FConnectionString,strsql);
      end;
   end;}
end;

Function GeraFicheirosRecibosVersao09(pLista:TSBBEtabeladados;pHotel:string;var pNomeFicheiro:String):Boolean;
var
   ListaLinhas:Tstringlist;
   txtFileC,txtFileL,
   txtFileRC,txtFileRL: TextFile;
   pObjDocs:TLinhasVd;
   i,e:integer;
   NomeFicheiro:string;
   ID_Ficheiro:Integer;
   NID_documento:Integer;
   documento:string;

begin
  Result:=false;
  NID_documento:=0;

  documento:='';
  pObjDocs:=PreencheLinhaVndRec(pLista);
  If pObjDocs.Num>0 then
  begin
      ID_Ficheiro:=DaProximoID('FichPrimaveraCBLRC',true);
      NomeFicheiro:='Protel_ExpCBLRC_'+DatetimeTostr(FDataInicioExp)+'_'
      +DatetimeTostr(FDataFimExp)+'_'+IntTostr(ID_Ficheiro);
      If pHotel<>'' then
      Begin
         NomeFicheiro:='MPE'+ pHotel+'_'+ NomeFicheiro;
      End;

      pNomeFicheiro:= NomeFicheiro;
      ListaLinhas:=Tstringlist.create;
      Try
        Try
         For i:=0 to  pObjDocs.Num-1 do
         begin
             If pObjDocs.Elem[i].DETALHE_DESCRICAO<>documento then
             begin
                NID_documento:=NID_documento-1;
                documento:=pObjDocs.Elem[i].DETALHE_DESCRICAO;
             end;
              AdicionaLinhaFactura(pObjDocs.Elem[i],NID_documento,ListaLinhas);
         End;

          //Gera os ficheiros
          AssignFile(txtFileC,FcaminhoFicheiro+'\'+NomeFicheiro+'.TXT');
          Rewrite(txtFileC);
          Writeln(txtFileC,'CBLLP09.00');
          Writeln(txtFileC,'GCPLP09.00');
          Writeln(txtFileC,'');
          Writeln(txtFileC,'');
          Writeln(txtFileC,'');
          For i:=0 to  ListaLinhas.Count-1 do
            Writeln(txtFileC,ListaLinhas.Strings[i]);
          CloseFile(txtFileC);
          Result:=true;
        except
            Raise;
            Result:=False;
        end;

       Finally

        FreeAndnil(ListaLinhas);
       End;
  end;
end;


//Preenche o token ao seu tamanho com o caracter de "espaço"
Function GeraToken(const pValor:Variant; pTamanho: Integer;
            pCaracter: Char; pAlinhamento:TTipoAlinhamento=taEsquerda):String;
var
    StringBase: string;
    StringAcrescimo: String;
    Resultado:String;
Begin
    Case VarType(pValor) of
        varSmallint, varInteger, varInt64:
            StringBase:=VarToStr(pValor);

        varSingle, varDouble, varCurrency:
        begin
            //É necessário arredondar a duas casas decimais e depois remover a virgula
            //Ex: 1234,567 passa a 123457
            StringBase:=FormatFloat('###0.00', pValor);
            StringBase:= LeftStr(StringBase,Length(StringBase)-3)+RightStr(StringBase,2);
        end;

        varString:
            StringBase:=VarToStr(pValor);

        varDate:
            StringBase:=FormatDateTime('yyyymmdd',VarToDateTime(pValor));

        else
            raise  SB.ErroNormal(0,'FntFicheiroADSE','TFicheiroADSE.GeraToken',
                'O tipo de dados do parâmetro pValor não está previsto!');

    end;
    StringAcrescimo:='';
    While Length(StringAcrescimo)+Length(StringBase)< pTamanho do
        StringAcrescimo:= StringAcrescimo + pCaracter;
    Case pAlinhamento of
        taEsquerda:
            Resultado:=StringBase + StringAcrescimo;

        taDireita:
            Resultado:=StringAcrescimo + StringBase;
    end;
    if Length(Resultado)>pTamanho then
       raise  SB.ErroNormal(0, 'FntInterfacePrimaveraCBL', 'InterfacePrimaveraConector.GeraToken',
            'O tamanho do token ''' + Resultado + ''' é de '+ IntToStr(Length(Resultado)) +
            ', o tamanho máximo é de ' + IntToStr(pTamanho) + ' caracteres.')
    else
        result:=Resultado;
End;



  




Function DaListaDocumentosRecibosV901(pDataInicio,pDataFim:Tdatetime;pHotel:Integer):TSBBETAbelaDados;
var
   strSQL:string;
   RecNatPAGCC,
   RecNatPAG:string;
   ID_recibo,DescricaoDoc
   ,TipoLinha,TipoDocumento,Serie,ContaCBLTIPODOC,ContaCBLPAG
   ,NATUREZA,ContaCBLCliente,HoraDoc ,NomeCliente
  ,DescricaoLinha ,ncontribuinte,ID_HotelPms,ID_PagamentoPms:string;
  DataDoc,DataMovimento:tdatetime;
  Valor:extended;
  ID_ClientePMS:Integer;
 ID_Reserva:string;

   Lista:TSBBETabeladados;
   DEBNO:string;
begin
   strSQL:='select leisthis.buchref,fiscalcd.text as TipoDocOrigem,kunden.name1 as NomeCliente,'
            +schema+'.zahlart.bez as Pagamento,'
            +schema+'.leisthis.epreis as Valor,'+schema+'.leisthis.eftreceipt as  ID_Recibo'
          +','+schema+'.leisthis.datum as Data,'+schema+'.leisthis.kundennr as ID_cliente'
          +','+schema+'.Leisthis.rkz as ID_ModoPag'
          +','+schema+'.kunden.fibudeb as cc_cliente'
          +','+schema+'.leisthis.text as DescDoc'
          +','+schema+'.Kunden.vatno as Ncontribuinte'
          +','+schema+'.Leisthis.mpehotel'
          +','+schema+'.leisthis.Ref as debNo'
           +','+schema+'.leisthis.rdatum as DataMovimento'

          +' from '+schema+'.leisthis'
        +' left join '+schema+'.fiscalcd on  '+schema+'.fiscalcd.ref= '+schema+'.Leisthis.Fisccode'
          +' inner join '+schema+'.Kunden on  '+schema+'.Kunden.kdnr= '+schema+'.leisthis.kundennr'
          +' inner join '+schema+'.zahlart on  '+schema+'.zahlart.za= '+schema+'.leisthis.rkz'
          +' where arinvoice>0 and arout=1';


         If pHotel>0 then
         begin
            strSQL:=strSQL + ' AND '+schema+'.leisthis."mpehotel"=' + InTtostr(pHotel);
         end;

         If pDataInicio>0 then
            strSQL:=strSQL + ' AND '+schema+'.leisthis."datum">=' + SB.UtilSQL.DataToSQLData(pDataInicio);

         If pDataFim>0 then
            strSQL:=strSQL +' AND '+schema+'.leisthis."datum"<=' + SB.UtilSQL.DataToSQLData(pDataFim);

         strSQL:=strSQL+' order by '+schema+'.leisthis."buchref",'+schema+'.leisthis."datum", '
         +schema+'.leisthis.eftreceipt,'+schema+'.leisthis.kundennr';



         Lista:=sb.SBBD.AbrirLV(strSQL);

         Lista.Inicio;

         sb.SBBD.ExecutaSqlExterno(FConnectionString,'delete from RecibosCblPrimavera');
     While Not (Lista.NoFim) do
         begin
            PreencheVariaveisNatureza(Lista.daValor('valor').asFloat,RecNatPAGCC,RecNatPAG);

            ID_recibo:= Lista.daValor('iD_Recibo').asstring;
            DescricaoDoc:= Lista.daValor('DescDoc').asstring;
            TipoLinha:='0';
            TipoDocumento:='';
            Serie:='';
            ContaCBLTIPODOC:='';
            ContaCBLPAG:='';
            DataDoc:= Lista.daValor('data').asdatetime;
            DataMovimento:= Lista.daValor('DataMovimento').asdatetime;
            ContaCBLCliente:= Lista.daValor('cc_cliente').asstring;
//            HoraDoc
            NomeCliente := Lista.daValor('NomeCliente').asstring;
            Valor:=0;
            Valor:= abs(Lista.daValor('valor').asfloat);
            ncontribuinte := Lista.daValor('Ncontribuinte').asstring;
            ID_HotelPms := Lista.daValor('mpehotel').asstring;
            ID_ClientePMS:= Lista.daValor('ID_cliente').asInteger;
            ID_Reserva:=Lista.daValor('buchref').asstring;


             //Linha Pagamento Conta corrente
             NATUREZA:= RecNatPAGCC;

             DescricaoLinha := 'Conta Corrente';
             ID_PagamentoPms := inttostr(id_Pagamentocc);
             DEBNO:= Lista.daValor('DEBNO').asstring;

             TipoLinha:='0';
             strSQL:=' Insert Into RecibosCblPrimavera ([ID_recibo],[DescricaoDoc]'
             +' ,[TipoLinha],[TipoDocumento],[Serie],[ContaCBLTIPODOC],[ContaCBLPAG]'
             +' ,[NATUREZA],[DataDoc],[ContaCBLCliente],[NomeCliente]'
             +' ,[Valor],[DescricaoLinha] ,[ncontribuinte]'
             +',ID_PagamentoPms,ID_HotelPms,ID_ClientePMS,DEBNO,ID_Reserva,DataMovimento)'
             +' values ( '
             + sb.UtilSQL.StrToSQLStrpelica(ID_recibo)
             +','+ sb.UtilSQL.StrToSQLStrpelica(DescricaoDoc)
             +','+ sb.UtilSQL.StrToSQLStrpelica(TipoLinha)
             +','+ sb.UtilSQL.StrToSQLStrpelica(TipoDocumento)
             +','+ sb.UtilSQL.StrToSQLStrpelica(Serie)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLTIPODOC)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLPAG)
             +','+ sb.UtilSQL.StrToSQLStrpelica(NATUREZA)
             +','+ sb.UtilSQL.DataToSQLData(DataDoc)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLCliente)
             +','+ sb.UtilSQL.StrToSQLStrpelica(NomeCliente)
             +','+ sb.UtilSQL.DecimalToSQLStr(Valor)
             +','+ sb.UtilSQL.StrToSQLStrpelica(DescricaoLinha)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ncontribuinte)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_PagamentoPms)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_HotelPms)
             +','+ inttostr(ID_ClientePMS)
             +','+ #39+DEBNO+#39
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_Reserva)
              +','+ sb.UtilSQL.DataToSQLData(DataMovimento)

             +')';
             sb.SBBD.ExecutaSqlExterno(FConnectionString,strSQL);



             //Linha Pagamento Liquidacao
             NATUREZA:= RecNatPAG;
             DescricaoLinha := Lista.daValor('Pagamento').asstring;
            ID_PagamentoPms := Lista.daValor('ID_ModoPag').asstring;
            TipoLinha:='1';
          strSQL:=' Insert Into RecibosCblPrimavera ([ID_recibo],[DescricaoDoc]'
             +' ,[TipoLinha],[TipoDocumento],[Serie],[ContaCBLTIPODOC],[ContaCBLPAG]'
             +' ,[NATUREZA],[DataDoc],[ContaCBLCliente],[NomeCliente]'
             +' ,[Valor],[DescricaoLinha] ,[ncontribuinte]'
             +',ID_PagamentoPms,ID_HotelPms,ID_ClientePMS,DEBNO,id_reserva,DataMovimento)'
             +' values ( '
             + sb.UtilSQL.StrToSQLStrpelica(ID_recibo)
             +','+ sb.UtilSQL.StrToSQLStrpelica(DescricaoDoc)
             +','+ sb.UtilSQL.StrToSQLStrpelica(TipoLinha)
             +','+ sb.UtilSQL.StrToSQLStrpelica(TipoDocumento)
             +','+ sb.UtilSQL.StrToSQLStrpelica(Serie)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLTIPODOC)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLPAG)
             +','+ sb.UtilSQL.StrToSQLStrpelica(NATUREZA)
             +','+ sb.UtilSQL.DataToSQLData(DataDoc)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ContaCBLCliente)
             +','+ sb.UtilSQL.StrToSQLStrpelica(NomeCliente)
             +','+ sb.UtilSQL.DecimalToSQLStr(Valor)
             +','+ sb.UtilSQL.StrToSQLStrpelica(DescricaoLinha)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ncontribuinte)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_PagamentoPms)
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_HotelPms)
             +','+ inttostr(ID_ClientePMS)
                 +','+ #39+DEBNO+#39
             +','+ sb.UtilSQL.StrToSQLStrpelica(ID_Reserva)
             +','+ sb.UtilSQL.DataToSQLData(DataMovimento)

             +')';
             sb.SBBD.ExecutaSqlExterno(FConnectionString,strSQL);
              Lista.seguinte;
         end;

         strSQL:='update RecibosCblPrimavera '
                +' set ContaCBLPAG=Primav_ModoPagamento.contacbl'
                +' from RecibosCblPrimavera'
                +' inner join Primav_ModoPagamento'
                +' on Primav_ModoPagamento.Pms_ID_ModoPagamento=RecibosCblPrimavera.id_PagamentoPms';

         sb.SBBD.ExecutaSqlExterno(FConnectionString,strSQL);

end;




end.
