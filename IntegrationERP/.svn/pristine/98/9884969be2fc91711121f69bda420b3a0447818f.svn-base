unit ERP_FrmAPIINtegrador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, AdvPanel, AdvToolBar,
  Vcl.StdCtrls, Vcl.Mask, AdvOfficePager, System.Actions, Vcl.ActnList;

type
  TFrm_ERPAPIINtegrador = class(TForm)
    a: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btSair: TAdvToolBarButton;
    btConfirmar: TAdvToolBarButton;
    AdvPanel1: TAdvPanel;
    pnlTipoAutenticacao: TAdvPanel;
    pnltipointegrador: TAdvPanel;
    cmbTipoIntegrador: TComboBox;
    lbsbInicio: TLabel;
    Label1: TLabel;
    cmbTipoAutenticacao: TComboBox;
    PagerInfoAut: TAdvOfficePager;
    pagerinfotaut1: TAdvOfficePage;
    AdvOfficePager12: TAdvOfficePage;
    pagerinfotauto3: TAdvOfficePage;
    pagerinfoaut4: TAdvOfficePage;
    ed_Client_ID: TLabeledEdit;
    ed_Client_Secret: TLabeledEdit;
    ed_EndAutporOAuth: TLabeledEdit;
    ed_EndAcessoAPI: TLabeledEdit;
    ed_EndURIRedirect: TLabeledEdit;
    ActionList1: TActionList;
    acConfirmar: TAction;
    asSair: TAction;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure acConfirmarExecute(Sender: TObject);
    procedure asSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

   Function  Abreformulario():Boolean;
   procedure PreencheTipoIntegrador(pItems: TStrings);
   procedure PreencheTipoAutenticacao(pItems: TStrings);

  end;

var
  Frm_ERPAPIINtegrador: TFrm_ERPAPIINtegrador;

implementation
uses ERPBETipoCons,IERPOGLOBAIS,SBBotoes,SBBETabelaDados, SBBaseDados, SBBSSistemaBase,SBControlos,SBBEConsTipos;
{$R *.dfm}

// tabela Erp_ConfAPIIntegradores
//campos(ID_Integrador,TipoAutenticacao,Client_ID,Client_Secret,EndAutporOAuth,EndAcessoAPI,EndURIRedirect)
Function TFrm_ERPAPIINtegrador.Abreformulario():Boolean;

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
    if cmbTipoAutenticacao.ItemIndex>0 then
         PagerInfoAut.ActivePageIndex:=cmbTipoAutenticacao.ItemIndex-1;

    ed_Client_ID.text:=lst.daValor('Client_ID').asstring;
    ed_Client_Secret.text:=lst.daValor('Client_Secret').asstring;
    ed_EndAutporOAuth.text:=lst.daValor('EndAutporOAuth').asstring;
    ed_EndAcessoAPI.text:=lst.daValor('EndAcessoAPI').asstring;
    ed_EndURIRedirect.text:=lst.daValor('EndURIRedirect').asstring;

  end;
  if Assigned(lst) then
   FreeAndNil(lst);
   result:=true;
end;

procedure TFrm_ERPAPIINtegrador.acConfirmarExecute(Sender: TObject);
var strsql:String;
begin
  strsql:=' UPDATE Erp_ConfAPIIntegradores SET '
 +'ID_Integrador ='+inttostr(cmbTipoIntegrador.ItemIndex)
 +',TipoAutenticacao ='+inttostr(cmbTipoAutenticacao.ItemIndex)
 +',Client_ID ='+sb.UtilSQL.StrToSQLStr(ed_Client_ID.text)
 +',Client_Secret ='+sb.UtilSQL.StrToSQLStr(ed_Client_Secret.text)
 +',EndAutporOAuth ='+sb.UtilSQL.StrToSQLStr(ed_EndAutporOAuth.text)
 +',EndAcessoAPI ='+sb.UtilSQL.StrToSQLStr(ed_EndAcessoAPI.text)
 +',EndURIRedirect ='+sb.UtilSQL.StrToSQLStr(ed_EndURIRedirect.text);
 sb.sbbd.executa(strsql);
end;

procedure TFrm_ERPAPIINtegrador.asSairExecute(Sender: TObject);
begin
  close;
end;

procedure TFrm_ERPAPIINtegrador.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFrm_ERPAPIINtegrador.FormCreate(Sender: TObject);
begin
PreencheTipoIntegrador(cmbTipoIntegrador.items);
PreencheTipoAutenticacao(cmbTipoAutenticacao.items);
end;

procedure TFrm_ERPAPIINtegrador.PreencheTipoIntegrador(pItems: TStrings);
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
procedure TFrm_ERPAPIINtegrador.PreencheTipoAutenticacao(pItems: TStrings);
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
end.
