unit CBLFrmSeltipodoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvToolBar, StdCtrls, CheckLst, ExtCtrls, AdvPanel,SBBEConsTipos,
  Menus,sbbetabeladados,CBLOperInterfaceProtel,sbcontrolos;

type
  TFrmCBLSeltipodoc = class(TForm)
    a: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btSair: TAdvToolBarButton;
    btConfirmar: TAdvToolBarButton;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    chLstTiposDocsPMs: TCheckListBox;
    Label2: TLabel;
    LDOC1: TLabel;
    PopupMenu1: TPopupMenu;
    SelecionarTodos1: TMenuItem;
    Removerseleo1: TMenuItem;
    lpara: TLabel;
    LDOC: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SelecionarTodos1Click(Sender: TObject);
    procedure Removerseleo1Click(Sender: TObject);
    Function DafiltroDocspms():string;
  private
    { Private declarations }
      FShemaProtel:string;
    FPOSID_TipoDocPMs:Integer;
    FPOSTipoDocPMs:string;
    FconexaoProtel:string;
   Procedure ObterConexao;
   procedure CopiaTipoDocsContas(pID_TipoDocOrigem,pID_TipoDestino:integer);


   Function GravaDados:boolean;
  public
    { Public declarations }

  Property  POSID_TipoDocPMs:Integer read    FPOSID_TipoDocPMs write FPOSID_TipoDocPMs;
  Property  POSTipoDocPMs:string read    FPOSTipoDocPMs write FPOSTipoDocPMs;


  end;

var
  FrmCBLSeltipodoc: TFrmCBLSeltipodoc;

implementation
uses IERPOGLOBAIS,SBBotoes, SBBaseDados, SBBSSistemaBase;
{$R *.dfm}

Procedure TFrmCBLSeltipodoc.ObterConexao;
var
  IDInterface:integer;
  Listaconf:tsbbetabeladados;
begin

   FShemaProtel:=DevolvechemaPms(IDInterface,FconexaoProtel);
   {If IDInterface>0 then
   begin
      Listaconf:=sb.SBBD.AbrirLV('select ContasPorMercado from ERP_CBLParametros where ID_EmpresaInteraface='+Inttostr(IDInterface));
      If not Listaconf.Vazia then
        FContasPorMercado:= Listaconf.daValor('ContasPorMercado').asboolean;
      Listaconf.Fecha;
      Freeandnil(Listaconf);

   end;  }

end;

Function TFrmCBLSeltipodoc.DafiltroDocspms():string;
var
strsql:string;
Lista:tsbbetabeladados;
begin
  Result:='';
    strsql:='select distinct PMS_ID_TipoDoc from CBL_TipoDocPMS'
     +' where  PMS_ID_TipoDoc<>'+Inttostr(FPOSID_TipoDocPMs);
    { If frmCBLMain.ID_Hotel>0 then
     begin
        strsql:=  strsql+' and  ID_Hotel='+Inttostr(frmCBLMain.ID_Hotel);
     end;   }

   Lista:=sb.SBBD.AbrirLV(strsql);
   while Not(Lista.nofim) do
   begin
    if result<>'' then
     result:=result+',';
     result:=result+ Lista.davalor('PMS_ID_TipoDoc').asstring;
    Lista.Seguinte;
   end;
   Lista.fecha;
   FreeandNil(Lista);
end;

procedure TFrmCBLSeltipodoc.FormShow(Sender: TObject);
var
strsql:string;
var

 strfiltro:string;
begin
  ObterConexao;
  strfiltro:=DafiltroDocspms;
  If strfiltro<>'' then
  begin
   strsql := ' Select   fiscalcd.Ref,+''_''+lizenz.short+''-> ''+cast(fiscalcd.Ref as varchar(5))+''-''+fiscalcd.text as TipoHotel'
          + ' from '+FShemaProtel+'fiscalcd'

          + ' inner join  '+FShemaProtel+'lizenz on   '
          +' lizenz.mpehotel= fiscalcd.mpehotel'
          +' where fiscalcd.ref<>'+Inttostr(FPOSID_TipoDocPMs)
          +' and  fiscalcd.ref in ('+ strfiltro+')';

   PreencheStringList(chLstTiposDocsPMs.Items,sb,strsql,'TipoHotel','Ref',false);
  end
  else
  btconfirmar.enabled:=false;
  LDOC.Caption:=inttostr(FPOSID_TipoDocPMs)+' - '+FPOSTipoDocPMs;
  lpara.Caption:=' para os Tipos Docs.Selecionados:';
end;



Function TFrmCBLSeltipodoc.GravaDados:boolean;
var
  i:Integer;
  objListaItem:TSBItemLista;
  strFiltro:String;

begin
    result:=false;
    for i:=0 to chLstTiposDocsPMs.Count-1 do
    begin
      if chLstTiposDocsPMs.Checked[i] then
      begin
        Result:=true;
        objListaItem:=TSBItemLista(chLstTiposDocsPMs.Items.Objects[i]);
        CopiaTipoDocsContas(FPOSID_TipoDocPMs,objListaItem.Chave);
      end;
    end;

end;



procedure TFrmCBLSeltipodoc.CopiaTipoDocsContas(pID_TipoDocOrigem,pID_TipoDestino:integer);
var
strsql:string;
begin
 If pID_TipoDocOrigem<> pID_TipoDestino then
 begin

  if pID_TipoDestino>0 then
  begin
     strsql:='Delete from [CBL_ContaFamiliaPMS]';
     strsql:=strsql+' Where PMS_ID_TipoDoc='+IntToStr(pID_TipoDestino);
     sb.SBBD.Executa(strsql);
  end;

  strsql:= ' INSERT INTO [CBL_ContaFamiliaPMS] '
         +'  ([PMS_ID_ContaFamilia]'
         +' ,[PMS_ContaFamilia]'
         +' ,[ContaCBLFamilia]'
         +'  ,[ContaCBLIVA]'
         +' ,[ClasseIVA]'

        +' ,[ContaCBLFamiliaD]'
        +' ,[ContaCBLIVAD],ClasseIVAD'
        +',ContaCCusto,ContaCCustoD'
        +' ,ContaAnalitica,ContaAnaliticaD'

        +' ,  ContaCBLFamiliaNCperIVAdifFACT'
        +'   , ContaCBLIVANCperIVAdifFACT'
        +' ,   ClasseIVANCperIVAdifFACT'
        +'  ,  ContaCCustoNCperIVAdifFACT'
        +'   , ContaAnaliticaNCperIVAdifFACT'        
         +' ,[PMS_ID_TipoDoc],mercado)'

        +' SELECT [PMS_ID_ContaFamilia]'
        +'   ,[PMS_ContaFamilia]'
        +' ,[ContaCBLFamilia]'
        +' ,[ContaCBLIVA]'
        +' ,[ClasseIVA]'
       +' ,[ContaCBLFamiliaD]'
        +' ,[ContaCBLIVAD],ClasseIVAD'
        +',ContaCCusto,ContaCCustoD'
        +' ,ContaAnalitica,ContaAnaliticaD'
        +' ,  ContaCBLFamiliaNCperIVAdifFACT'
        +'   , ContaCBLIVANCperIVAdifFACT'
        +' ,   ClasseIVANCperIVAdifFACT'
        +'  ,  ContaCCustoNCperIVAdifFACT'
        +'   , ContaAnaliticaNCperIVAdifFACT'


        +'  ,'+Inttostr(pID_TipoDestino)
        +'  ,Mercado'
        +'  FROM [CBL_ContaFamiliaPMS]'
        +' Where PMS_ID_TipoDoc='+Inttostr(pID_TipoDocOrigem);
        sb.SBBD.Executa(strsql);
 end;
end;


procedure TFrmCBLSeltipodoc.btConfirmarClick(Sender: TObject);
begin
If sb.Dialogos.SBConfirmacao('Pretende Copiar as Contas do  Tipo doc:'+LDOC.Caption+#13
+'?') then
begin
 if GravaDados then
     self.Close
 else
  sb.Dialogos.SBErro('Não existem Tipos Docs. selecionados!');
 
end;
end;

procedure TFrmCBLSeltipodoc.btSairClick(Sender: TObject);
begin
self.close;
end;

procedure TFrmCBLSeltipodoc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFrmCBLSeltipodoc.SelecionarTodos1Click(Sender: TObject);
var
  i:integer;
begin
 for i:=0 to chLstTiposDocsPMs.Count- 1 do
 begin
   chLstTiposDocsPMs.Checked[i]:=true;
 end;

end;

procedure TFrmCBLSeltipodoc.Removerseleo1Click(Sender: TObject);
var
  i:integer;
begin
 for i:=0 to chLstTiposDocsPMs.Count- 1 do
 begin
   chLstTiposDocsPMs.Checked[i]:=false;
 end;


end;

end.
