unit ERP_FrmListaExportInventarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  ExtCtrls, AdvPanel, StdCtrls, AdvEdit, DBAdvEd, Mask, AdvMEdBtn,
  PlannerMaskDatePicker, AdvOfficeButtons, AdvCombo, AdvToolBar,
  AdvGroupBox,sbcontrolos,sbbotoes,FntBEFntInterfaceCenexp, ActnList,
  AdvSmoothMessageDialog,ERPLogOperacoes,menus,ERPBEEMPRESAINTERFACE;

type
  TFrmERPListaExportInventarios = class(TForm)
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    btLimpar: TAdvToolBarButton;
    AdvPanel1: TAdvPanel;
    panelFiltros: TAdvPanel;
    AdvGroupBox1: TAdvGroupBox;
    Inicio: TLabel;
    dtdataInicio: TPlannerMaskDatePicker;
    dtdataFim: TPlannerMaskDatePicker;
    RbIntegracao: TAdvOfficeRadioGroup;
    PanelCabecalhos: TAdvPanel;
    PanelLinhas: TAdvPanel;
    AdvPanel2: TAdvPanel;
    TB_ERPCaB: TADOTable;
    Ds_ErpCab: TDataSource;
    DS_ERPDetalhes: TDataSource;
    Tb_ErpDetalhes: TADOTable;
    GridERPCAb: TDBAdvGrid;
    GridErpDetalhes: TDBAdvGrid;
    ActionList1: TActionList;
    acRemover: TAction;
    MensagemInformacao: TAdvSmoothMessageDialog;
    MessageDialogQueston: TAdvSmoothMessageDialog;
    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtActualizarClick(Sender: TObject);
    procedure acRemoverExecute(Sender: TObject);
  private
    { Private declarations }
    Function  dafiltro():string;
    Function  TextaConexaoExportacao(var Mensagem:String):Boolean;
    Function  TestaConexaoBDExterna(pConexao:string):boolean;
    Function  ValidaRemocao():boolean;
    Function  MensagemQuestao(pMensagem:string):boolean;
    Procedure MostraMensagemInformacao(pMensagem:string);
    procedure RemoveInventarioExportado(pID_Inventario:integer;pDescricao:string);

  public
    { Public declarations }
        Procedure abreformulario;
  end;

var
  FrmERPListaExportInventarios: TFrmERPListaExportInventarios;

implementation
uses ierpoglobais,IERPFrmPrincipal;
var
FCONNECTIONSTRING:string;
{$R *.dfm}

Procedure TFrmERPListaExportInventarios.abreformulario;
var
    Mensagem:string;
   i: Integer;
   item: TMenuItem;
Begin
   FormataFormPorDefeito(self);
   FormataBotoes(self);
   FCONNECTIONSTRING:='';

   TextaConexaoExportacao(Mensagem);
   if Mensagem<>'' then
   begin
    sb.Dialogos.SBMessage(Mensagem);
    BtActualizar.Enabled:=false;
   end;
   Top:=FRMIERPPrincipal.MenuOpcoes.Height+20;

   With GridERPCAb  do
   begin
       For i:= 0 To PopupMenu.Items.Count-3 Do
        PopupMenu.Items.Delete(i);


       item:= TMenuItem.Create(GridERPCAb);
       item.Caption := SB.Idioma.daTraducao(0, 'Remover Exportação-Inventário');
       item.Action := acRemover;
       PopupMenu.Items.Insert(0, item);
   end;
   showmodal;

end;

Function TFrmERPListaExportInventarios.TestaConexaoBDExterna(pConexao:string):boolean;
begin
   Result:=false;
   TB_ERPCab.Connection:=sb.SBBD.Con;
   Tb_ErpDetalhes.Connection:=sb.SBBD.Con;
   TB_ERPCab.open;
   Tb_ErpDetalhes.open;
end;


Function TFrmERPListaExportInventarios.TextaConexaoExportacao(var Mensagem:String):Boolean;
var
 ObjInterfaceCenexp:TFntBEFntInterfaceCenexp;
begin
    FCONNECTIONSTRING:=sb.SBBD.ConnectionString;
    TestaConexaoBDExterna(FCONNECTIONSTRING);
end;

procedure TFrmERPListaExportInventarios.BtsairClick(Sender: TObject);
begin
  self.close;
end;

procedure TFrmERPListaExportInventarios.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFrmERPListaExportInventarios.BtActualizarClick(Sender: TObject);
var
  filtro:string;
begin
 filtro:=dafiltro;
 TB_ERPCab.Active:=false;
 TB_ERPCab.Active:=true;
 TB_ErpDetalhes.Active:=false;

 if filtro<>'' then
 begin

     TB_ERPCab.Filtered:=false;
     TB_ERPCab.Filter:=filtro;
     TB_ERPCab.Filtered:=true;
     TB_ErpDetalhes.Active:=true;
 end
 Else
 begin

    TB_ERPCab.Active:=true;
    TB_ERPCab.Filtered:=false;
    TB_ErpDetalhes.Active:=true;
 end;

end;

Function TFrmERPListaExportInventarios.dafiltro():string;
var
    origem:Integer;
begin
 Result:='';
 If  ((filtraMaskData(dtdataInicio)>0) and (filtraMaskData(dtdataFim)>0)) Then
 begin
      Result:='((DataExportacao>='+datetostr(dtdataInicio.Date)+') and (DataExportacao<='+datetostr(dtdataFim.Date)+'))';
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

Function  TFrmERPListaExportInventarios.ValidaRemocao():boolean;
begin
   Result:=true;
   If  TB_ERPCaB.FieldByName('integrado').asboolean=true then
   begin
     Result:=false;
     MostraMensagemInformacao('Não é possível remover o Inventário!<BR>Já foi integrado.');
   end;

   If Result=true then
   begin
      Result:= MensagemQuestao('Tem a certeza que deseja remover a exportação do Inventário: '+TB_ERPCaB.FieldByName('Descricao').asstring);
   end;
end;

Function TFrmERPListaExportInventarios.MensagemQuestao(pMensagem:string):boolean;
begin
    MessageDialogQueston.HTMLText.Text:=pMensagem;
    Result:=MessageDialogQueston.Execute;
end;

Procedure TFrmERPListaExportInventarios.MostraMensagemInformacao(pMensagem:string);
begin
    MensagemInformacao.HTMLText.Text:=pMensagem;
    MensagemInformacao.execute;
end;

procedure TFrmERPListaExportInventarios.RemoveInventarioExportado(pID_Inventario:integer;pDescricao:string);
var
     strsql:string;
    ObjInterface:TERPBEEMPRESAINTERFACE;
Begin
 sb.SBBD.IniciaTransacao;
 Try
     strsql:=' Delete from [ERP_LinhasInventario] where ID_Inventario='+Inttostr(pID_Inventario);
     sb.SBBD.Executa(strsql);

     strsql:=' Delete from [ERP_CabInventario] where ID_Inventario='+Inttostr(pID_Inventario);
     sb.SBBD.Executa(strsql);

     RegistaLogOperacao('Remoção do Inventário:'+Inttostr(pID_Inventario)+' '+pDescricao);
     sb.SBBD.TerminaTransacao;

     ObjInterface:=nil;
     ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_COMPRASSYSCONTROLLER');
     If assigned(ObjInterface) then
     begin
       strsql:='update cabinventario set ExportadoErpInterface=0 where id_inventario='+inttostr(pID_Inventario);
       sb.SBBD.ExecutaSqlExterno(ObjInterface.BDConexao,strsql)

     end;

     BtActualizar.Click;
 Except
   sb.SBBD.DesfazTransacao;
     raise;
 end;

end;

procedure TFrmERPListaExportInventarios.acRemoverExecute(Sender: TObject);
begin
  If TB_ERPCaB.FieldByName('ID_Inventario').asinteger> 0 then
  begin
    If ValidaRemocao then
    begin
       RemoveInventarioExportado(TB_ERPCaB.FieldByName('ID_Inventario').asinteger,TB_ERPCaB.FieldByName('Descricao').asstring);
    end;

  end;
end;

end.
