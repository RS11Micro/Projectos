unit IERP_FrmListaExportVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  ExtCtrls, AdvPanel, StdCtrls, AdvEdit, DBAdvEd, Mask, AdvMEdBtn,
  PlannerMaskDatePicker, AdvOfficeButtons, AdvCombo, AdvToolBar,
  AdvGroupBox,sbcontrolos,sbbotoes,FntBEFntInterfaceCenexp, AdvUtil;

type
  TFrmIERPListaExportVendas = class(TForm)
    AdvPanel1: TAdvPanel;
    panelFiltros: TAdvPanel;
    AdvGroupBox1: TAdvGroupBox;
    Inicio: TLabel;
    dtdataInicio: TPlannerMaskDatePicker;
    dtdataFim: TPlannerMaskDatePicker;
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
    Btsair: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    btLimpar: TAdvToolBarButton;
    AdvGroupBox2: TAdvGroupBox;
    Label5: TLabel;
    EdnDocumento: TEdit;
    AdvGroupBox3: TAdvGroupBox;
    CbOrigem: TAdvComboBox;
    RbIntegracao: TAdvOfficeRadioGroup;
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
    procedure BtActualizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtsairClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
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
  FrmIERPListaExportVendas: TFrmIERPListaExportVendas;

implementation
uses ierpoglobais,IERPFrmPrincipal;

var
FCONNECTIONSTRING:string;
{$R *.dfm}

Procedure TFrmIERPListaExportVendas.abreformulario;
var
Mensagem:string;
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

Function TFrmIERPListaExportVendas.dafiltro():string;
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

procedure TFrmIERPListaExportVendas.BtActualizarClick(Sender: TObject);
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

procedure TFrmIERPListaExportVendas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     TB_ERPCab.close;
     Tb_ErpDetalhes.close;
     TB_ERPagamentos.close;

     action:=cafree;
end;





Function TFrmIERPListaExportVendas.TestaConexaoBDExterna(pConexao:string):boolean;
begin
   Result:=false;
   TB_ERPCab.Connection:=sb.SBBD.Con;
   Tb_ErpDetalhes.Connection:=sb.SBBD.Con;
   TB_ERPagamentos.Connection:=sb.SBBD.Con;

   TB_ERPCab.open;
   Tb_ErpDetalhes.open;
   TB_ERPagamentos.open;

end;


Function TFrmIERPListaExportVendas.TextaConexaoExportacao(var Mensagem:String):Boolean;
var
 ObjInterfaceCenexp:TFntBEFntInterfaceCenexp;
begin
FCONNECTIONSTRING:=sb.SBBD.ConnectionString;
TestaConexaoBDExterna(FCONNECTIONSTRING);
end;

procedure TFrmIERPListaExportVendas.BtsairClick(Sender: TObject);
begin
  self.close;
end;

procedure TFrmIERPListaExportVendas.btLimparClick(Sender: TObject);
begin
    EdnDocumento.Clear;
    RbIntegracao.ItemIndex:=2;
    CbOrigem.ItemIndex:=2;
    TB_ERPCab.Filtered:=false;
    dtdataInicio.Clear;
    dtdataFim.clear;    
end;

end.
