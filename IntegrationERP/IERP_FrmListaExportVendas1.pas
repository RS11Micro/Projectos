unit IERP_FrmListaExportVendas1;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  APITocOnline    ,
  Dialogs, DB, ADODB, Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,System.StrUtils,REST.Json,
  ExtCtrls, AdvPanel, StdCtrls, AdvEdit, DBAdvEd, Mask, AdvMEdBtn,
  PlannerMaskDatePicker, AdvOfficeButtons, AdvCombo, AdvToolBar,
  AdvGroupBox,sbcontrolos,sbbotoes,FntBEFntInterfaceCenexp, AdvUtil,
  AdvOfficePager, REST.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Client,
  REST.Response.Adapter, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Authenticator.OAuth,REST.Authenticator.OAuth.WebForm.Win, System.Actions,
  Vcl.ActnList, Vcl.Buttons;

type
  TFrmIERPListaExportVendas1 = class(TForm)
    TB_ERPCab: TADOTable;
    TB_ERPCabID_VNDCABDOCUMENTO: TIntegerField;
    TB_ERPCabtypedoc: TStringField;
    TB_ERPCabSerie: TStringField;
    TB_ERPCabNumero: TIntegerField;
    TB_ERPCabData: TDateTimeField;
    TB_ERPCabIDCliente: TIntegerField;
    TB_ERPCabNrcliente: TStringField;
    TB_ERPCabTotalBruto: TBCDField;
    TB_ERPCabStatus: TStringField;
    TB_ERPCabAssinatura: TStringField;
    TB_ERPCabChave: TStringField;
    TB_ERPCabNome: TStringField;
    TB_ERPCabMorada: TStringField;
    TB_ERPCablocalidade: TStringField;
    TB_ERPCabCodPostal: TStringField;
    TB_ERPCabNIF: TStringField;
    TB_ERPCabTotalPago: TBCDField;
    TB_ERPCabIntegrado: TBooleanField;
    TB_ERPCabDataHoraIntegracao: TDateTimeField;
    TB_ERPCabOrigem: TIntegerField;
    TB_ERPCabDataHoraRegisto: TDateTimeField;
    TB_ERPCabTotalLinhas: TIntegerField;
    TB_ERPCabUtilizadorRegisto: TStringField;
    Tb_ErpDetalhes: TADOTable;
    TB_ERPagamentos: TADOTable;
    TB_ERPagamentosID_VndCabdocumento: TIntegerField;
    TB_ERPagamentosID_linha: TIntegerField;
    TB_ERPagamentosID_ModoPagamento: TIntegerField;
    TB_ERPagamentosContaERP: TStringField;
    TB_ERPagamentosDescricao: TStringField;
    TB_ERPagamentosValor: TFloatField;
    Ds_ErpCab: TDataSource;
    DS_ERPPagamentos: TDataSource;
    DS_ERPDetalhes: TDataSource;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    btLimpar: TAdvToolBarButton;
    Tb_ErpDetalhesID_VNDCABDOCUMENTO: TIntegerField;
    Tb_ErpDetalhesID_Interno: TIntegerField;
    Tb_ErpDetalhesID_Linha: TIntegerField;
    Tb_ErpDetalhesmpehotel: TIntegerField;
    Tb_ErpDetalhesSerie: TStringField;
    Tb_ErpDetalhesnumero: TIntegerField;
    Tb_ErpDetalhesData: TDateTimeField;
    Tb_ErpDetalhesservico: TStringField;
    Tb_ErpDetalhesDescritivo: TStringField;
    Tb_ErpDetalhesqnt: TFloatField;
    Tb_ErpDetalhesprecounit: TBCDField;
    Tb_ErpDetalhescodiva: TStringField;
    Tb_ErpDetalhestaxaiva: TBCDField;
    Tb_ErpDetalhestotal: TBCDField;
    Tb_ErpDetalhesCodIsencao: TStringField;
    Tb_ErpDetalhesOrigem: TIntegerField;
    TB_ERPCabTOTALIVA: TFloatField;
    TB_ERPCabID_Interno: TIntegerField;
    TB_ERPagamentosID_Interno: TIntegerField;
    pager: TAdvOfficePager;
    page1: TAdvOfficePage;
    page2: TAdvOfficePage;
    panelFiltros: TAdvPanel;
    AdvGroupBox1: TAdvGroupBox;
    Inicio: TLabel;
    dtdataInicio: TPlannerMaskDatePicker;
    dtdataFim: TPlannerMaskDatePicker;
    AdvGroupBox2: TAdvGroupBox;
    Label5: TLabel;
    EdnDocumento: TEdit;
    AdvGroupBox3: TAdvGroupBox;
    CbOrigem: TAdvComboBox;
    RbIntegracao: TAdvOfficeRadioGroup;
    PanelCabecalhos: TAdvPanel;
    GridERPCAb: TDBAdvGrid;
    PanelLinhas: TAdvPanel;
    GridErpDetalhes: TDBAdvGrid;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label1: TLabel;
    DBAdvEdit3: TDBAdvEdit;
    DBAdvEdit1: TDBAdvEdit;
    DBAdvEdit2: TDBAdvEdit;
    PanelPagamentos: TAdvPanel;
    GridErpPagamentos: TDBAdvGrid;
    AdvPanel3: TAdvPanel;
    Label3: TLabel;
    Label4: TLabel;
    DBAdvEdit4: TDBAdvEdit;
    DBAdvEdit5: TDBAdvEdit;
    DBAdvEdit6: TDBAdvEdit;
    Pagerintegracao: TAdvOfficePager;
    pageintegracao1: TAdvOfficePage;
    AdvOfficePager2: TAdvOfficePage;
    ed_Client_ID: TLabeledEdit;
    ed_Client_Secret: TLabeledEdit;
    ed_AccessToken: TLabeledEdit;
    ed_RefreshToken: TLabeledEdit;
    ed_AuthCode: TLabeledEdit;
    ed_EndAutporOAuth: TLabeledEdit;
    ed_EndAcessoAPI: TLabeledEdit;
    ed_EndURIRedirect: TLabeledEdit;
    cmbTipoIntegrador: TComboBox;
    lbapi: TLabel;
    cmbTipoAutenticacao: TComboBox;
    lntipoautenticacao: TLabel;
    OAuth2_Toconline: TOAuth2Authenticator;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    RESTResponse: TRESTResponse;
    RESTRequest: TRESTRequest;
    RESTClient: TRESTClient;
    Clientserv: TRESTClient;
    RespServ: TRESTResponse;
    ReqServ: TRESTRequest;
    FDMemTable1: TFDMemTable;
    RESTResponseDataSetAdapter2: TRESTResponseDataSetAdapter;
    ReqProds: TRESTRequest;
    memo2: TMemo;
    Memo1: TMemo;
    ClientProds: TRESTClient;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    memtbProds: TFDMemTable;
    RespProds: TRESTResponse;
    acOperacoesTO: TActionList;
    acautenticacao: TAction;
    aclistaprodutosdaAPI: TAction;
    aclistaservicosApi: TAction;
    Btsair: TAdvToolBarButton;
    btIntegrar: TAdvToolBarButton;
    acInsereProdutos: TAction;
    Client_Inseremapeamentos: TRESTClient;
    request_mapeamentos: TRESTRequest;
    response_mapeamentos: TRESTResponse;
    acInsereServicos: TAction;
    acremoveservicos: TAction;
    acinserefamilias: TAction;
    client_Serie: TRESTClient;
    Requestserie: TRESTRequest;
    Responseserie: TRESTResponse;
    Button5: TButton;
    edtipodoc: TEdit;
    acapagaservicos: TAction;
    Button6: TButton;
    Button7: TButton;
    acExportaVendas: TAction;
    ac_motivosisencao: TAction;
    client_Misencao: TRESTClient;
    Req_Misencao: TRESTRequest;
    Resp_Misencao: TRESTResponse;
    OAuth2Authenticator1: TOAuth2Authenticator;
    acIntegrarTO: TAction;
    Client_Inserefamilia: TRESTClient;
    Request_Inserefamilia: TRESTRequest;
    Response_Inserefamilia: TRESTResponse;
    Button1: TButton;
    actaxasIVATO: TAction;
    ClientNIFPT: TRESTClient;
    ReqNIFPT: TRESTRequest;
    RespNIFPT: TRESTResponse;
    procedure BtActualizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtsairClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure acautenticacaoExecute(Sender: TObject);
    procedure aclistaprodutosdaAPIExecute(Sender: TObject);
    procedure aclistaservicosApiExecute(Sender: TObject);
    procedure acInsereProdutosExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure acInsereServicosExecute(Sender: TObject);
    procedure acinserefamiliasExecute(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure acapagaservicosExecute(Sender: TObject);
    procedure acExportaVendasExecute(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ac_motivosisencaoExecute(Sender: TObject);
    procedure acIntegrarTOExecute(Sender: TObject);
    procedure actaxasIVATOExecute(Sender: TObject);
  private
    { Private declarations }
    Function dafiltro():string;
    Function TextaConexaoExportacao(var Mensagem:String):Boolean;
    Function TestaConexaoBDExterna(pConexao:string):boolean;
    procedure PreencheDadosIntegracao;
    procedure PreencheTipoIntegrador(pItems: TStrings);
    procedure PreencheTipoAutenticacao(pItems: TStrings);
    procedure OAuth2_Toconline_BrowserTitleChanged(const ATitle: string; var DoCloseWebView: boolean);
    procedure ResetRESTComponentsToDefaults;
    procedure ExportaPorInvoiceType(pinvoicetype:string);
    function JaexisteMotivoToc(pid_misencao:integer):boolean;
    function JaexisteTaxToc(pid_tax:integer):boolean;
  public
    { Public declarations }
    Procedure abreformulario;
  end;

var
  FrmIERPListaExportVendas: TFrmIERPListaExportVendas1;

implementation
uses IERPFrmPrincipal,ERPBETipoCons,IERPOGLOBAIS,SBBETabelaDados, SBBaseDados, SBBSSistemaBase,SBBEConsTipos;

var
FCONNECTIONSTRING:string;
{$R *.dfm}

Procedure TFrmIERPListaExportVendas1.abreformulario;
var
Mensagem:string;
Begin
   FormataFormPorDefeito(self);
   FormataBotoes(self);
   PreencheTipoIntegrador(cmbTipoIntegrador.items);
   PreencheTipoAutenticacao(cmbTipoAutenticacao.items);
   PreencheDadosIntegracao;
   FCONNECTIONSTRING:='';
   TextaConexaoExportacao(Mensagem);
   if Mensagem<>'' then
   begin
    sb.Dialogos.SBMessage(Mensagem);
    BtActualizar.Enabled:=false;
   end;
   Top:=FRMIERPPrincipal.MenuOpcoes.Height+20;
   showmodal;

end;

Function TFrmIERPListaExportVendas1.dafiltro():string;
var
origem:Integer;
begin
 Result:='';
 If  ((filtraMaskData(dtdataInicio)>0) and (filtraMaskData(dtdataFim)>0)) Then
 begin
      Result:='((data>='+datetostr(dtdataInicio.Date)+') and (data<='+datetostr(dtdataFim.Date)+'))';
 end;

 If EdnDocumento.text<>'' then
 begin
      If result<>'' then
      begin
       Result:=result+' and ';
      end;
      Result:=Result+' Numero='+EdnDocumento.text;
 end;

 origem:=CbOrigem.ItemIndex;
 If origem>0 then
 begin
      If result<>'' then
      begin
       Result:=result+' and ';
      end;
      Result:=Result+' origem='+inttostr(origem);
 end;
 If RbIntegracao.ItemIndex<2 then
 begin
      If result<>'' then
      begin
       Result:=result+' and ';
      end;
      Result:=Result+' integrado='+inttostr(RbIntegracao.ItemIndex);

 end;


end;

procedure TFrmIERPListaExportVendas1.acapagaservicosExecute(Sender: TObject);
var strsql,

textoResposta,
mIDtoc:string;
mJson:ansiString;
BintegrouResultados:Boolean;
mquery:TsbbeTabeladados;
i:integer;

begin
 acautenticacao.Execute;
  Client_Inseremapeamentos.BaseURL:=' https://api11.toconline.pt/api/services';
  request_mapeamentos.Method:=rmDELETE;
  i:=0;
     while not i<3000 do
     begin
         try
          try
            mJson:='{"data":{"id": "'+inttostr(i)+'"}}';
            request_mapeamentos.Params.ParameterByName('body').Value:=mJson;
            request_mapeamentos.Execute;
            memo1.Lines.Text:=request_mapeamentos.Response.Content;
            textoResposta:=request_mapeamentos.Response.Content;
            mIDtoc := GETCamposJsonString(textoResposta, 'ID');
            BintegrouResultados:=true;
            except
            on E:Exception do
               begin
                 BintegrouResultados:=false;
                 showmessage('Erro de conexão ao endpoint: '+e.Message);
               end;
          end;
         finally
            if mIDtoc<>'' then
                 InsereServicoIntegrado(mIDtoc,mquery);

         end;
         inc(i);
     end;
end;


procedure TFrmIERPListaExportVendas1.acautenticacaoExecute(Sender: TObject);
var
  wv: Tfrm_OAuthWebForm;
  LToken: string;
begin
  ed_AuthCode.Text := '';
  ed_AccessToken.Text := '';
  ed_RefreshToken.Text := '';

  /// step #1: get the auth-code
  OAuth2_Toconline.AuthorizationEndpoint := ed_EndAutporOAuth.Text+'/auth';
  OAuth2_Toconline.ResponseType := TOAuth2ResponseType.rtCODE;
  OAuth2_Toconline.ClientID := ed_Client_ID.Text;
  OAuth2_Toconline.RedirectionEndpoint :=ed_EndURIRedirect.Text;
  OAuth2_Toconline.Scope := 'commercial';


  wv := Tfrm_OAuthWebForm.Create(self);
  try
    wv.OnTitleChanged := OAuth2_Toconline_BrowserTitleChanged;
    wv.ShowModalWithURL(OAuth2_Toconline.AuthorizationRequestURI
      // optional
      // + '&login_hint=' + URIEncode('user@example.com');
      );
  finally
    wv.Release;
  end;

  /// step #2: get the access-token

  ResetRESTComponentsToDefaults;

  RESTClient.BaseURL := 'https://app11.toconline.pt/oauth/auth';

  RESTRequest.Method := TRESTRequestMethod.rmPOST;
  RESTRequest.Resource := 'o/oauth2/token';
  RESTRequest.Params.AddItem('code', ed_AuthCode.Text, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest.Params.AddItem('client_id', ed_Client_ID.Text, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest.Params.AddItem('client_secret', ed_Client_Secret.Text, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest.Params.AddItem('redirect_uri', 'urn:ietf:wg:oauth:2.0:oob', TRESTRequestParameterKind.pkGETorPOST);



  RESTRequest.Params.AddItem('grant_type', 'authorization_code', TRESTRequestParameterKind.pkGETorPOST);

  RESTRequest.Execute;

  if RESTRequest.Response.GetSimpleValue('access_token', LToken) then
     ed_AccessToken.Text := LToken;
    OAuth2_Toconline.AccessToken := LToken;
  if RESTRequest.Response.GetSimpleValue('refresh_token', LToken) then
     ed_RefreshToken.Text := LToken;
    OAuth2_Toconline.RefreshToken := LToken;

end;
procedure TFrmIERPListaExportVendas1.acExportaVendasExecute(Sender: TObject);
var
textoResposta:string;
begin
   ExportaPorInvoiceType('FR');
   ExportaPorInvoiceType('FS');
   ExportaPorInvoiceType('FT');
   ExportaPorInvoiceType('NC');
   ExportaPorInvoiceType('ND');
end;

procedure TFrmIERPListaExportVendas1.ExportaPorInvoiceType(pinvoicetype:string);
var strsqlcab,
strsqllinhas,
strsqlpagamento,
textoResposta,
mIDtoc,
strsqlintegrado,
marrayrespostaserie,mID_serietoc:string;
mJson:ansiString;
BintegrouResultados:Boolean;
mqueryCabdoc,mQueryLinhasDoc,mqueryPagDoc:TsbbeTabeladados;
mID_InternoDoc:integer;

begin
  client_Serie.BaseURL := 'https://app11.toconline.pt/api/commercial_document_series?';
  Requestserie.Params.ParameterByName('filter[document_type]').Value:=pinvoicetype;
  Requestserie.Params.ParameterByName('filter[prefix]').Value:='E';
  Requestserie.Execute;
  textoResposta:=Requestserie.Response.Content;

  mID_serietoc:=(getData2(textoResposta,'commercial_document_series','id'));


  Client_Inseremapeamentos.BaseURL:=' https://api11.toconline.pt/api/v1/commercial_sales_documents';
  strsqlcab:='select * from ERP_Cab where integrado=0 and invoicetype='+sb.UtilSQL.StrToSQLStr(pinvoicetype) ;
  mqueryCabdoc:=sb.sbbd.AbrirLV(strsqlcab);
  mIDtoc:='';
  if not mqueryCabdoc.Vazia then
  begin

     while not mqueryCabdoc.nofim do
     begin
           try
            try
             mID_InternoDoc:=mqueryCabdoc.daValor('ID_Interno').AsInteger;
             strsqllinhas:='select * from ERP_detalhes where  ID_Interno='+inttostr(mID_InternoDoc);
             strsqlpagamento:='select * from ERP_Pagamentos where  ID_Interno='+inttostr(mID_InternoDoc);
              mQueryLinhasDoc:=sb.sbbd.AbrirLV(strsqllinhas);
              mqueryPagDoc:=sb.sbbd.AbrirLV(strsqlpagamento);
              mJson:=DaJsonVenda (mqueryCabdoc,mQueryLinhasDoc,mqueryPagDoc,mID_serietoc,'');

              request_mapeamentos.Params.ParameterByName('body').Value:=mJson;
              request_mapeamentos.Execute;
              memo1.Lines.Text:=request_mapeamentos.Response.Content;
              textoResposta:=request_mapeamentos.Response.Content;

              mIDtoc := GETCamposJsonString(textoResposta, 'document_no');


              BintegrouResultados:=true;
              except
              on E:Exception do
                 begin
                   BintegrouResultados:=false;
                   showmessage('Erro de conexão ao endpoint: '+e.Message);
                 end;
            end;
           finally
            if mIDtoc<>'' then
            begin
                strsqlintegrado:='update erp_cab set integrado=1 where id_interno='+inttostr(mID_InternoDoc);
                sb.SBBD.Executa(strsqlintegrado);

                 strsqlintegrado:=' INSERT INTO Erp_VendasIntegradas(Id_Interno,TOdocument_no) '
                 +' values('+ inttostr(mID_InternoDoc)+','+sb.UtilSQL.StrToSQLStr(mIDtoc)+')';
                 sb.SBBD.Executa(strsqlintegrado);
            end;
           end;
          if assigned(mQueryLinhasDoc) then
             freeandnil(mQueryLinhasDoc);
          if assigned(mqueryPagDoc) then
             freeandnil(mqueryPagDoc);

          mqueryCabdoc.seguinte;
     end;
  end;
  if assigned(mqueryCabdoc) then
   freeandnil(mqueryCabdoc);
end;

procedure TFrmIERPListaExportVendas1.acinserefamiliasExecute(Sender: TObject);
var strsql,

textoResposta,
mIDtoc:string;
mJson:ansiString;
BintegrouResultados:Boolean;
mquery:TsbbeTabeladados;

begin
  Client_Inserefamilia.BaseURL:=' https://api11.toconline.pt/api/item_families';
  strsql:='select distinct ID_FamiliaProduto,FamiliaProduto from erp_detalhes '
  +' where TipoArtigo='+sb.UtilSQL.StrToSQLStr('P')+' and ID_FamiliaProduto not in(select codeintegrador from Erp_FamiliasIntegradas) ';
  mquery:=sb.sbbd.AbrirLV(strsql);
  if not mquery.vazia then
  begin
     while not mquery.nofim do
     begin
           try
            try
              mJson:=DaJsonFamilia(mquery);
              Request_Inserefamilia.Params.ParameterByName('body').Value:=mJson;
              Request_Inserefamilia.Execute;
              memo1.Lines.Text:=Request_Inserefamilia.Response.Content;
              textoResposta:=Request_Inserefamilia.Response.Content;

              mIDtoc := GETCamposJsonString(textoResposta, 'ID');
              BintegrouResultados:=true;
              except
              on E:Exception do
                 begin
                   BintegrouResultados:=false;
                   showmessage('Erro de conexão ao endpoint: '+e.Message);
                 end;
            end;
           finally
            if mIDtoc<>'' then
                 InserefamiliaIntegrada(mIDtoc,mquery);
           end;
          mquery.seguinte;
     end;
  end;
  if assigned(mquery) then
   freeandnil(mquery);
end;

procedure TFrmIERPListaExportVendas1.acInsereProdutosExecute(Sender: TObject);
var strsql,

textoResposta,
mIDtoc:string;
mJson:ansiString;
BintegrouResultados:Boolean;
mquery:TsbbeTabeladados;

begin

  Client_Inseremapeamentos.BaseURL:=' https://api11.toconline.pt/api/products';
  strsql:='select distinct Id_Integrador,servico,descritivo,TipoArtigo,ID_GrupoServico from ERP_Detalhes '
  +' inner join Erp_FamiliasIntegradas on ID_FamiliaProduto=CodeIntegrador '
  +' where TipoArtigo='+sb.UtilSQL.StrToSQLStr('P')+' and servico not in(select codeintegrador from Erp_ProdutosIntegrados) ';
  mquery:=sb.sbbd.AbrirLV(strsql);
  if not mquery.vazia then
  begin
     while not mquery.nofim do
     begin
           try
            try
              mJson:=DaJsonProduto(mquery);
              request_mapeamentos.Params.ParameterByName('body').Value:=mJson;
              request_mapeamentos.Execute;
              memo1.Lines.Text:=request_mapeamentos.Response.Content;
              textoResposta:=request_mapeamentos.Response.Content;

              mIDtoc := GETCamposJsonString(textoResposta, 'ID');
              BintegrouResultados:=true;
              except
              on E:Exception do
                 begin
                   BintegrouResultados:=false;
                   showmessage('Erro de conexão ao endpoint: '+e.Message);
                 end;
            end;
           finally
            if mIDtoc<>'' then
                 InsereProdutoIntegrado(mIDtoc,mquery);
           end;
          mquery.seguinte;
     end;
  end;
  if assigned(mquery) then
   freeandnil(mquery);
end;

procedure TFrmIERPListaExportVendas1.acInsereServicosExecute(Sender: TObject);
var strsql,

textoResposta,
mIDtoc:string;
mJson:ansiString;
BintegrouResultados:Boolean;
mquery:TsbbeTabeladados;

begin
  Client_Inseremapeamentos.BaseURL:=' https://api11.toconline.pt/api/services';
  request_mapeamentos.Method:=rmpost;
  strsql:='select distinct servico,descritivo,TipoArtigo,ID_GrupoServico from ERP_Detalhes '
  +' where TipoArtigo='+sb.UtilSQL.StrToSQLStr('S')+' and servico not in(select codeintegrador from Erp_ServicosIntegrados) ';
  mquery:=sb.sbbd.AbrirLV(strsql);
  if not mquery.vazia then
  begin
     while not mquery.nofim do
     begin
         try
          try
            mJson:=DaJsonServico(mquery);
            request_mapeamentos.Params.ParameterByName('body').Value:=mJson;
            request_mapeamentos.Execute;
            memo1.Lines.Text:=request_mapeamentos.Response.Content;
            textoResposta:=request_mapeamentos.Response.Content;
            mIDtoc := GETCamposJsonString(textoResposta, 'ID');
            BintegrouResultados:=true;
            except
            on E:Exception do
               begin
                 BintegrouResultados:=false;
                 showmessage('Erro de conexão ao endpoint: '+e.Message);
               end;
          end;
         finally
            if mIDtoc<>'' then
                 InsereServicoIntegrado(mIDtoc,mquery);

         end;
         mquery.seguinte;
     end;
  end;
  if assigned(mquery) then
   freeandnil(mquery);
end;

procedure TFrmIERPListaExportVendas1.acIntegrarTOExecute(Sender: TObject);
begin
   acautenticacao.Execute;
   ac_motivosisencao.Execute;
   actaxasIVATO.Execute;
   acinserefamilias.Execute;
   acInsereProdutos.Execute;
   acInsereServicos.Execute;
   acExportaVendas.Execute;
end;

procedure TFrmIERPListaExportVendas1.aclistaprodutosdaAPIExecute(
  Sender: TObject);
begin

  ReqProds.Execute;
  Memo1.Lines.Text:=ReqProds.Response.Content;
end;

procedure TFrmIERPListaExportVendas1.aclistaservicosApiExecute(Sender: TObject);
begin
  ReqServ.Execute;
  Memo2.Lines.Text:=ReqServ.Response.Content;
end;

procedure TFrmIERPListaExportVendas1.actaxasIVATOExecute(Sender: TObject);
var
i:integer;
textoResposta,
marrayrespostaserie,
mID_serietoc  :string;
mTDataTaxesToc:TDataTaxesToc;
mtype,
midTax,
mdocument_text,
mapplicable_legislation,
strsql:string;
mid_isencao:integer;

mtax_country_region,
mtax_code,
mdescription,
mtax_percentage,
mtax_expiration_date:string;

begin
  client_Misencao.BaseURL := 'https://app11.toconline.pt/api/taxes';
  Req_Misencao.Execute;
  Memo1.Lines.Text:=Req_Misencao.Response.Content;
  textoResposta:=Req_Misencao.Response.Content;
  mTDataTaxesToc:=tJson.JsonToObject<TDataTaxesToc>(Req_Misencao.Response.Content);
  if assigned(mTDataTaxesToc) then
  begin
   for I :=0 to length(mTDataTaxesToc.data)-1 do
   begin
    mtype:=mTDataTaxesToc.data[i].&type;
    midTax:=mTDataTaxesToc.data[i].id;
    mtax_country_region:=mTDataTaxesToc.data[i].attributes.tax_country_region;
    mtax_code:=mTDataTaxesToc.data[i].attributes.tax_code;
    mdescription:=mTDataTaxesToc.data[i].attributes.description;
    mtax_percentage:=mTDataTaxesToc.data[i].attributes.tax_percentage;
    mtax_expiration_date:=mTDataTaxesToc.data[i].attributes.tax_expiration_date;


    if not JaexisteTaxToc(strtoint(midTax)) then
    begin
      strsql:='INSERT INTO Erp_TaxesTO(id,type,tax_country_region,tax_code,'
      +'description,tax_percentage,tax_expiration_date) VALUES('
      +sb.UtilSQL.StrToSQLStrPelica(midTax)
      +','+sb.UtilSQL.StrToSQLStrPelica(mtype)
      +','+sb.UtilSQL.StrToSQLStrPelica(mtax_country_region)
      +','+sb.UtilSQL.StrToSQLStrPelica(mtax_code)
      +','+sb.UtilSQL.StrToSQLStrPelica(mdescription)
      +','+sb.UtilSQL.StrToSQLStrPelica(mtax_percentage)
      +','+sb.UtilSQL.StrToSQLStrPelica(mtax_expiration_date)
      +')';
      sb.SBBD.Executa(strsql);
    end;
  end;
end;
end;
procedure TFrmIERPListaExportVendas1.ac_motivosisencaoExecute(Sender: TObject);
var
i:integer;
textoResposta,
marrayrespostaserie,
mID_serietoc  :string;
mDataMinsencaoToc:TDataMinsencaoToc;
mtype,
mcode,
mdocument_text,
mapplicable_legislation,
strsql:string;
mid_isencao:integer;
begin

  client_Misencao.BaseURL := 'https://app11.toconline.pt/api/tax_exemption_reasons';
  Req_Misencao.Execute;
  Memo1.Lines.Text:=Req_Misencao.Response.Content;
  textoResposta:=Req_Misencao.Response.Content;
  mDataMinsencaoToc:=tJson.JsonToObject<TDataMinsencaoToc>(Req_Misencao.Response.Content);
  if assigned(mDataMinsencaoToc) then
  begin
   for I :=0 to length(mDataMinsencaoToc.data)-1 do
   begin
    mtype:=mDataMinsencaoToc.data[i].&type;
    mcode:=mDataMinsencaoToc.data[i].attributes.code;
    mdocument_text:=mDataMinsencaoToc.data[i].attributes.document_text;
    mapplicable_legislation:=mDataMinsencaoToc.data[i].attributes.applicable_legislation;
    mid_isencao:=mDataMinsencaoToc.data[i].id;
    if not JaexisteMotivoToc(mid_isencao) then
    begin
      strsql:='INSERT INTO Erp_MotIsencaoToc(id,code,type,document_text,applicable_legislation) '
      +' values ('
      +inttostr(mid_isencao)
      +','+sb.UtilSQL.StrToSQLStrPelica(mcode)
      +','+sb.UtilSQL.StrToSQLStrPelica(mtype)
      +','+sb.UtilSQL.StrToSQLStrPelica(mdocument_text)
      +','+sb.UtilSQL.StrToSQLStrPelica(mapplicable_legislation)
      +')';
      sb.SBBD.Executa(strsql);
    end;
  end;
end;
end;

function TFrmIERPListaExportVendas1.JaexisteMotivoToc(pid_misencao:integer):boolean;
var
strsql:string;
lst:tsbbeTabelaDados;
begin
   strsql:='select id from Erp_MotIsencaoToc where id='+inttostr(pid_misencao);
   lst:=sb.SBBD.AbrirLV(strsql);
   result:= not lst.Vazia;
   if assigned(lst) then
     freeandnil(lst);
end;

function TFrmIERPListaExportVendas1.JaexisteTaxToc(pid_tax:integer):boolean;
var
strsql:string;
lst:tsbbeTabelaDados;
begin
   strsql:='select id from Erp_TaxesTO where id='+inttostr(pid_tax);
   lst:=sb.SBBD.AbrirLV(strsql);
   result:= not lst.Vazia;
   if assigned(lst) then
     freeandnil(lst);
end;
procedure TFrmIERPListaExportVendas1.BtActualizarClick(Sender: TObject);
var
  filtro:string;
begin
 filtro:=dafiltro;
 if filtro<>'' then
 begin
     Tb_ErpDetalhes.Active:=false;
     TB_ERPCab.Filtered:=false;
     TB_ERPCab.Filter:=filtro;
     TB_ERPCab.Filtered:=true;
     Tb_ErpDetalhes.Active:=true;
 end
 else
      TB_ERPCab.Filtered:=false;
end;

procedure TFrmIERPListaExportVendas1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     TB_ERPCab.close;
     Tb_ErpDetalhes.close;
     TB_ERPagamentos.close;

     action:=cafree;
end;





Function TFrmIERPListaExportVendas1.TestaConexaoBDExterna(pConexao:string):boolean;
begin
   Result:=false;
   TB_ERPCab.Connection:=sb.SBBD.Con;
   Tb_ErpDetalhes.Connection:=sb.SBBD.Con;
   TB_ERPagamentos.Connection:=sb.SBBD.Con;

   TB_ERPCab.open;
   Tb_ErpDetalhes.open;
   TB_ERPagamentos.open;

end;


Function TFrmIERPListaExportVendas1.TextaConexaoExportacao(var Mensagem:String):Boolean;
var
 ObjInterfaceCenexp:TFntBEFntInterfaceCenexp;
begin
FCONNECTIONSTRING:=sb.SBBD.ConnectionString;
TestaConexaoBDExterna(FCONNECTIONSTRING);
end;

procedure TFrmIERPListaExportVendas1.BtsairClick(Sender: TObject);
begin
  self.close;
end;

procedure TFrmIERPListaExportVendas1.Button1Click(Sender: TObject);
begin
  ValidaNIF(edtipodoc.Text);
end;
procedure TFrmIERPListaExportVendas1.Button4Click(Sender: TObject);
begin
 acExportaVendas.Execute;
end;

procedure TFrmIERPListaExportVendas1.Button5Click(Sender: TObject);
var
textoResposta,
marrayrespostaserie,
mID_serietoc  :string;
begin
 acautenticacao.Execute;


  client_Serie.BaseURL := 'https://app11.toconline.pt/api/commercial_document_series?';
  Requestserie.Params.ParameterByName('filter[document_type]').Value:=edtipodoc.Text;
  Requestserie.Params.ParameterByName('filter[prefix]').Value:='E';
  Requestserie.Execute;
  Memo1.Lines.Text:=Requestserie.Response.Content;

  textoResposta:=Requestserie.Response.Content;
  mID_serietoc:=(getData2(textoResposta,'commercial_document_series','id'));

end;

procedure TFrmIERPListaExportVendas1.PreencheDadosIntegracao;

var strsql:string;
lst:TsbbeTabeladados;
begin
   strsql:=' select  ID_Integrador,TipoAutenticacao,Client_ID,Client_Secret,EndAutporOAuth,'
   +'EndAcessoAPI,EndURIRedirect from Erp_ConfAPIIntegradores';

  lst:=sbbd.AbrirLV(strsql);

  if not lst.Vazia then
  begin
    cmbTipoIntegrador.ItemIndex:=lst.daValor('ID_Integrador').AsInteger;
    cmbTipoAutenticacao.ItemIndex:=lst.daValor('TipoAutenticacao').AsInteger;
    ed_Client_ID.text:=lst.daValor('Client_ID').asstring;
    ed_Client_Secret.text:=lst.daValor('Client_Secret').asstring;
    ed_EndAutporOAuth.text:=lst.daValor('EndAutporOAuth').asstring;
    ed_EndAcessoAPI.text:=lst.daValor('EndAcessoAPI').asstring;
    ed_EndURIRedirect.text:=lst.daValor('EndURIRedirect').asstring;

  end;
  if Assigned(lst) then
   FreeAndNil(lst);
end;


procedure TFrmIERPListaExportVendas1.btLimparClick(Sender: TObject);
begin
    EdnDocumento.Clear;
    RbIntegracao.ItemIndex:=2;
    CbOrigem.ItemIndex:=2;
    TB_ERPCab.Filtered:=false;
    dtdataInicio.Clear;
    dtdataFim.clear;
end;

procedure TFrmIERPListaExportVendas1.PreencheTipoIntegrador(pItems: TStrings);
var
    ObjItemLista:TSBItemLista;
begin
    LimpaLista(pItems);

    ObjItemLista:=TSBItemLista.Create;
    ObjItemLista.Chave:=ord(taNenhum);
    pItems.AddObject(SB.Idioma.daTraducao(0, 'Nenhum'), ObjItemLista);

    ObjItemLista:=TSBItemLista.Create;
    ObjItemLista.Chave:=ord(taToconline);
    pItems.AddObject(SB.Idioma.daTraducao(0, 'Toconline'), ObjItemLista);



end;
procedure TFrmIERPListaExportVendas1.PreencheTipoAutenticacao(pItems: TStrings);
var
    ObjItemLista:TSBItemLista;
begin
    LimpaLista(pItems);

//taNone, taSimple, taBasic, taOAUTH,taOAUTH2
    ObjItemLista:=TSBItemLista.Create;
    ObjItemLista.Chave:=ord(taNone);
    pItems.AddObject(SB.Idioma.daTraducao(0, 'None'), ObjItemLista);

    ObjItemLista:=TSBItemLista.Create;
    ObjItemLista.Chave:=ord(taSimple);
    pItems.AddObject(SB.Idioma.daTraducao(0, 'Simple'), ObjItemLista);

    ObjItemLista:=TSBItemLista.Create;
    ObjItemLista.Chave:=ord(taBasic);
    pItems.AddObject(SB.Idioma.daTraducao(2419, 'Basic'), ObjItemLista);

    ObjItemLista:=TSBItemLista.Create;
    ObjItemLista.Chave:=ord(taOAUTH);
    pItems.AddObject(SB.Idioma.daTraducao(0, 'OAUTH'), ObjItemLista);


    ObjItemLista:=TSBItemLista.Create;
    ObjItemLista.Chave:=ord(taOAUTH2);
    pItems.AddObject(SB.Idioma.daTraducao(0, 'OAUTH2'), ObjItemLista);



end;

procedure TFrmIERPListaExportVendas1.OAuth2_Toconline_BrowserTitleChanged(const ATitle: string; var DoCloseWebView: boolean);
begin
  if (ContainsText(ATitle,'code')) then
  begin
    ed_AuthCode.Text := Copy(ATitle, 32, Length(ATitle));

    if (ed_AuthCode.Text <> '') then
      DoCloseWebView := TRUE;
  end;
end;
procedure TFrmIERPListaExportVendas1.ResetRESTComponentsToDefaults;
begin
  /// reset all of the rest-components for a complete
  /// new request
  ///
  /// --> we do not clear the private data from the                                <
  /// individual authenticators.
  ///
  RESTRequest.ResetToDefaults;
  RESTClient.ResetToDefaults;
  RESTResponse.ResetToDefaults;
  RESTResponseDataSetAdapter.ResetToDefaults;
end;

end.
