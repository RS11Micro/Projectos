unit ERP_FrmListaExportComprasCBL;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  ExtCtrls, AdvPanel, StdCtrls, AdvEdit, DBAdvEd, Mask, AdvMEdBtn,
  PlannerMaskDatePicker, AdvOfficeButtons, AdvCombo, AdvToolBar,
  AdvGroupBox,sbcontrolos,sbbotoes,FntBEFntInterfaceCenexp,SBBEConsTipos;

type
  TFrmERPListaExportComprasCBL = class(TForm)
    AdvPanel1: TAdvPanel;
    panelFiltros: TAdvPanel;
    AdvGroupBox1: TAdvGroupBox;
    Inicio: TLabel;
    dtdataInicio: TPlannerMaskDatePicker;
    dtdataFim: TPlannerMaskDatePicker;
    AdvGroupBox2: TAdvGroupBox;
    Label5: TLabel;
    EdnDocumento: TEdit;
    RbIntegracao: TAdvOfficeRadioGroup;
    PanelCabecalhos: TAdvPanel;
    GridERPCAb: TDBAdvGrid;
    PanelLinhas: TAdvPanel;
    GridErpDetalhes: TDBAdvGrid;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    DBAdvEdit3: TDBAdvEdit;
    DBAdvEdit2: TDBAdvEdit;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    btLimpar: TAdvToolBarButton;
    TB_ERPCab: TADOTable;
    Tb_ErpDetalhes: TADOTable;
    Ds_ErpCab: TDataSource;
    DS_ERPDetalhes: TDataSource;
    TB_ERPCabID_Interno: TIntegerField;
    TB_ERPCabID_DOCInterno: TIntegerField;
    TB_ERPCabOrigem: TIntegerField;
    TB_ERPCabModulo: TStringField;
    TB_ERPCabAno: TIntegerField;
    TB_ERPCabMes: TIntegerField;
    TB_ERPCabDia: TIntegerField;
    TB_ERPCabData: TDateTimeField;
    TB_ERPCabAnalitica: TStringField;
    TB_ERPCabCCustos: TStringField;
    TB_ERPCabDiario: TStringField;
    TB_ERPCabDocumento: TStringField;
    TB_ERPCabNumDocumento: TStringField;
    TB_ERPCabDescricao: TStringField;
    TB_ERPCabDataHoraRegisto: TDateTimeField;
    TB_ERPCabTotalLinhas: TIntegerField;
    TB_ERPCabUtilizadorRegisto: TStringField;
    TB_ERPCabIntegrado: TBooleanField;
    TB_ERPCabDataHoraIntegracao: TDateTimeField;
    TB_ERPCabPRIMAVERA_ID: TGuidField;
    TB_ERPCabPRIMAVERA_Diario: TStringField;
    TB_ERPCabPRIMAVERA_NumDiario: TIntegerField;
    TB_ERPCabPRIMAVERA_Documento: TStringField;
    TB_ERPCabPRIMAVERA_NumDocumento: TIntegerField;
    TB_ERPCabErroIntegracao: TMemoField;
    TB_ERPCabNIF: TStringField;
    TB_ERPCabTipoEntidade: TStringField;
    TB_ERPCabEntidade: TStringField;
    TB_ERPCabNumeroDocumentoExterno: TStringField;
    TB_ERPCabNome: TStringField;
    TB_ERPCabMorada: TStringField;
    TB_ERPCabLocalidade: TStringField;
    TB_ERPCabCodigoPostal: TStringField;
    TB_ERPCabTelefone: TStringField;
    TB_ERPCabDataVencimento: TWideStringField;
    TB_ERPCabPRIMAVERA_CCT_ID: TGuidField;
    TB_ERPCabPRIMAVERA_CCT_TipoDoc: TStringField;
    TB_ERPCabPRIMAVERA_CCT_NumDoc: TIntegerField;
    TB_ERPCabPRIMAVERA_CCT_Serie: TStringField;
    TB_ERPCabmpehotel: TIntegerField;
    TB_ERPCabNomeBaseDados: TStringField;
    TB_ERPCabDataMov: TDateTimeField;
    TB_ERPCabAnoMov: TIntegerField;
    TB_ERPCabMesMov: TIntegerField;
    TB_ERPCabDiaMov: TIntegerField;
    procedure BtActualizarClick(Sender: TObject);
    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Function dafiltro():string;
    Function TextaConexaoExportacao(var Mensagem:String):Boolean;
    Function TestaConexaoBDExterna(pConexao:string):boolean;

  public
    { Public declarations }
    Procedure abreformulario;
  end;

var
  FrmERPListaExportComprasCBL: TFrmERPListaExportComprasCBL;

implementation
uses ierpoglobais,IERPFrmPrincipal;

var
FCONNECTIONSTRING:string;

{$R *.dfm}


Procedure TFrmERPListaExportComprasCBL.abreformulario;
var
Mensagem:string;
strsql:string;
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
   showmodal;

end;

Function TFrmERPListaExportComprasCBL.dafiltro():string;
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
      Result:=Result+' Numdocumento='+EdnDocumento.text;
 end;



 If RbIntegracao.ItemIndex<2 then
 begin
      If result<>'' then
      begin
       Result:=result+' and ';
      end;
      If  RbIntegracao.ItemIndex=0 then
      begin
             Result:=Result+' integrado='+inttostr(RbIntegracao.ItemIndex)+' or '
             +' integrado=null';

      end
      else
      Result:=Result+' integrado='+inttostr(RbIntegracao.ItemIndex);

 end;


end;

Function TFrmERPListaExportComprasCBL.TestaConexaoBDExterna(pConexao:string):boolean;
begin
    Result:=false;
    TB_ERPCab.Connection:=sb.SBBD.Con;
    Tb_ErpDetalhes.Connection:=sb.SBBD.Con;


    TB_ERPCab.open;
    Tb_ErpDetalhes.open;

end;


Function TFrmERPListaExportComprasCBL.TextaConexaoExportacao(var Mensagem:String):Boolean;
var
 ObjInterfaceCenexp:TFntBEFntInterfaceCenexp;
begin
FCONNECTIONSTRING:=sb.SBBD.ConnectionString;
TestaConexaoBDExterna(FCONNECTIONSTRING);
end;


procedure TFrmERPListaExportComprasCBL.BtActualizarClick(Sender: TObject);
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

procedure TFrmERPListaExportComprasCBL.BtsairClick(Sender: TObject);
begin
 self.close;
end;

procedure TFrmERPListaExportComprasCBL.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 TB_ERPCab.close;
 Tb_ErpDetalhes.close;
 action:=cafree;
end;

end.
