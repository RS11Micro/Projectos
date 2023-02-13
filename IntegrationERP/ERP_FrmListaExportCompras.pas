unit ERP_FrmListaExportCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid,
  ExtCtrls, AdvPanel, StdCtrls, AdvEdit, DBAdvEd, Mask, AdvMEdBtn,
  PlannerMaskDatePicker, AdvOfficeButtons, AdvCombo, AdvToolBar,
  AdvGroupBox,sbcontrolos,sbbotoes,FntBEFntInterfaceCenexp;

type
  TFrmERPListaExportCompras = class(TForm)
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
    PanelPagamentos: TAdvPanel;
    GridErpPagamentos: TDBAdvGrid;
    AdvPanel3: TAdvPanel;
    Label4: TLabel;
    DBAdvEdit4: TDBAdvEdit;
    DBAdvEdit6: TDBAdvEdit;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    btLimpar: TAdvToolBarButton;
    Tb_ErpDetalhes: TADOTable;
    TB_ERPagamentos: TADOTable;
    Ds_ErpCab: TDataSource;
    DS_ERPPagamentos: TDataSource;
    DS_ERPDetalhes: TDataSource;
    TB_ERPCaB: TADOTable;
    rgtipo: TAdvOfficeRadioGroup;
    procedure BtActualizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtsairClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure FormataGrelhaCabecalho;

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
  FrmERPListaExportCompras: TFrmERPListaExportCompras;

implementation
uses ierpoglobais,IERPFrmPrincipal;
var
FCONNECTIONSTRING:string;

{$R *.dfm}


Function FormatoDecimalGrelhaQuant():string;
var
 casasDecimais:integer;
Begin
   casasDecimais:=MotorFnt.Parametros.NumCasasDecQuantStock;
  Result:='%.'+inttostr(casasDecimais)+'f';
end;

Function FormatoDecimalGrelhaValor():string;
var
 casasDecimais:integer;
Begin
   casasDecimais:=MotorFnt.Parametros.NumCasasDecValorStock;
   Result:='%.'+inttostr(casasDecimais)+'f';
end;
Procedure TFrmERPListaExportCompras.abreformulario;
var
Mensagem:string;
Begin
   FormataFormPorDefeito(self);
   FormataBotoes(self);
   FCONNECTIONSTRING:='';
   FormataGrelhaCabecalho;


   TextaConexaoExportacao(Mensagem);
   if Mensagem<>'' then
   begin
    sb.Dialogos.SBMessage(Mensagem);
    BtActualizar.Enabled:=false;
   end;
   Top:=FRMIERPPrincipal.MenuOpcoes.Height+20;
   showmodal;

end;

Function TFrmERPListaExportCompras.dafiltro():string;
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


 If RbIntegracao.ItemIndex<2 then
 begin
      If result<>'' then
      begin
       Result:=result+' and ';
      end;
      Result:=Result+' integrado='+inttostr(RbIntegracao.ItemIndex);

 end;
 if rgtipo.ItemIndex=0 then
 begin
      If result<>'' then
      begin
       Result:=result+' and ';
      end;
      Result:=Result+' encomenda=0';
 end
 else
 begin
      If result<>'' then
      begin
       Result:=result+' and ';
      end;
      Result:=Result+' encomenda=1';

 end;

end;

procedure TFrmERPListaExportCompras.BtActualizarClick(Sender: TObject);
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

procedure TFrmERPListaExportCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     TB_ERPCab.close;
     Tb_ErpDetalhes.close;
     TB_ERPagamentos.close;

     action:=cafree;
end;



Function TFrmERPListaExportCompras.TestaConexaoBDExterna(pConexao:string):boolean;
begin
    Result:=false;
   TB_ERPCab.Connection:=sb.SBBD.Con;
   Tb_ErpDetalhes.Connection:=sb.SBBD.Con;
      TB_ERPagamentos.Connection:=sb.SBBD.Con;

     TB_ERPCab.open;
     Tb_ErpDetalhes.open;
     TB_ERPagamentos.open;

end;


Function TFrmERPListaExportCompras.TextaConexaoExportacao(var Mensagem:String):Boolean;
var
 ObjInterfaceCenexp:TFntBEFntInterfaceCenexp;
begin
FCONNECTIONSTRING:=sb.SBBD.ConnectionString;
TestaConexaoBDExterna(FCONNECTIONSTRING);
end;
procedure TFrmERPListaExportCompras.BtsairClick(Sender: TObject);
begin
  self.close;
end;

procedure TFrmERPListaExportCompras.btLimparClick(Sender: TObject);
begin
     EdnDocumento.Clear;
    RbIntegracao.ItemIndex:=2;
    
    TB_ERPCab.Filtered:=false;
    dtdataInicio.Clear;
    dtdataFim.clear;
end;


procedure TFrmERPListaExportCompras.FormataGrelhaCabecalho;
var
  i:integer;
begin

 with  GridERPCAb do
 begin
  RemoveAllColumns;

 For i:=0 to 22 do
        AddColumn;
 colcount:=23;
 FixedCols:=0;
 Columns[0].FieldName:='ID_Interno';
 Columns[0].Header:='ID_Interno';
  Columns[0].Width:=60;

 Columns[1].FieldName:='ID_Movimento';
 Columns[1].Header:='ID_Movimento';
 Columns[1].Width:=90;

 Columns[2].FieldName:='DescTipoMovimento';
 Columns[2].Header:='DescTipoMovimento';
 Columns[2].Width:=120;

 Columns[3].FieldName:='NumDocumento';
 Columns[3].Header:='NumDocumento';
 Columns[3].Width:=90;


 Columns[4].FieldName:='Data';
 Columns[4].Header:='Data';
 Columns[4].Width:=65;

 Columns[6].FieldName:='typedoc';
 Columns[6].Header:='Doc. Conta ERP';
 Columns[6].Width:=65;

 Columns[7].FieldName:='status';
 Columns[7].Header:='Status';
 Columns[7].Width:=65;

 Columns[8].FieldName:='IDCliente';
 Columns[8].Header:='ID_Fornecedor' ;
 Columns[8].Width:=65;

 Columns[9].FieldName:='Nrcliente';
 Columns[9].Header:='Forn.Conta ERP';
 Columns[9].Width:=65;

 Columns[10].FieldName:='Nome';
 Columns[10].Header:='Fornecedor';
 Columns[10].Width:=65;

 Columns[11].FieldName:='NIF';
 Columns[11].Header:='Contribuinte';
 Columns[11].Width:=90;

 Columns[12].FieldName:='Morada';
 Columns[12].Header:='Morada';
 Columns[12].Width:=100;

 Columns[13].FieldName:='localidade';
 Columns[13].Header:='Localidade';
 Columns[13].Width:=60;

 Columns[14].FieldName:='CodPostal';
 Columns[14].Header:='CodPostal';
 Columns[14].Width:=60;

 Columns[15].FieldName:='TotalIVA';
 Columns[15].Header:='TotalIVA';
   Columns[15].FloatFormat:='%.2f';
 Columns[15].Width:=80;

 Columns[16].FieldName:='TotalSEMIVA';
 Columns[16].Header:='TotalSEMIVA';
  Columns[16].FloatFormat:='%.2f';
 Columns[16].Width:=80;

 Columns[17].FieldName:='TotalCOMIVA';

 Columns[17].Header:='TotalCOMIVA';
 Columns[17].FloatFormat:='%.2f';
 Columns[17].Width:=80;

 Columns[18].FieldName:='TotalLinhas';
 Columns[18].Header:='TotalLinhas';
 Columns[18].Width:=80;

 Columns[19].FieldName:='DataHoraRegisto';
 Columns[19].Header:='DataHoraRegisto';
 Columns[19].Width:=80;

 Columns[20].FieldName:='UtilizadorRegisto';
 Columns[20].Header:='UtilizadorRegisto';
 Columns[20].Width:=80;



 Columns[21].FieldName:='Integrado';
 Columns[21].Header:='Integrado';
 Columns[21].Width:=80;

 Columns[22].FieldName:='DataHoraIntegracao';
 Columns[22].Header:='DataHoraIntegracao';
 Columns[22].Width:=80;

 Columns[5].FieldName:='Datavenc';
 Columns[5].Header:='Data vencimento';
 Columns[5].Width:=100;


end;

end;
end.
