unit ERP_FrmExportCompras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, AdvEdit, AdvMEdBtn, PlannerMaskDatePicker,
  AdvGroupBox, ActnList, AdvOfficeButtons, Grids, AdvObj, BaseGrid,Sbbotoes,
  AdvGrid, AdvOfficePager, ExtCtrls, AdvPanel, AdvToolBar,dateutils,sbcontrolos,
  ERPOperInterfaceFntCMP,sbbetabeladados, SBEditProcura,sblista,ERPBEEMPRESAINTERFACE,ierpListasDef,
  ImgList,Menus;

type
  TFRMERPExportCompras = class(TForm)
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    BtExportarmov: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    btLimpar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvPanel1: TAdvPanel;
    PanelEnc: TAdvPanel;
    gbDataenc: TAdvGroupBox;
    lbsbInicio: TLabel;
    dtdataInicioEnc: TPlannerMaskDatePicker;
    AdvOfficePager1: TAdvOfficePager;
    GrelhaCompras: TAdvStringGrid;
    PanelTotVendas: TAdvPanel;
    l: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    StTotalVendas: TStaticText;
    StTotalDocs: TStaticText;
    StTotalCreditos: TStaticText;
    tssbImpressao: TAdvOfficePage;
    GroupBox1: TGroupBox;
    LbsbRelatorio: TLabel;
    cmbRelatorios: TComboBox;
    cbsbVisualizar: TAdvOfficeCheckBox;
    ActionList1: TActionList;
    acreeemissaodocs: TAction;
    Accontrair: TAction;
    acexpandir: TAction;
    TssbDocCompras: TAdvOfficePage;
    AdvGroupBox1: TAdvGroupBox;
    Label3: TLabel;
    dtdatafimenc: TPlannerMaskDatePicker;
    SBImagensPopup16x16: TImageList;
    tssbEncomendas: TAdvOfficePage;
    GrelhaEnc: TAdvStringGrid;
    AdvPanel3: TAdvPanel;
    Label5: TLabel;
    gbData: TAdvGroupBox;
    Label6: TLabel;
    dtdataInicio: TPlannerMaskDatePicker;
    AdvGroupBox3: TAdvGroupBox;
    Label7: TLabel;
    dtdatafim: TPlannerMaskDatePicker;
    cmbtipodoc: TComboBox;
    Label4: TLabel;
    Label8: TLabel;
    accontrairenc: TAction;
    acexpandirenc: TAction;
    BtexpEncomendas: TAdvToolBarButton;
    procedure BtExportarmovClick(Sender: TObject);
    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtActualizarClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure GrelhaComprasGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure GrelhaComprasCanSort(Sender: TObject; ACol: Integer;
      var DoSort: Boolean);
    procedure GrelhaComprasGetFloatFormat(Sender: TObject; ACol,
      ARow: Integer; var IsFloat: Boolean; var FloatFormat: String);
    procedure AccontrairExecute(Sender: TObject);
    procedure acexpandirExecute(Sender: TObject);
    procedure acexpandirencExecute(Sender: TObject);
    procedure accontrairencExecute(Sender: TObject);
    procedure BtexpEncomendasClick(Sender: TObject);
  private
    { Private declarations }
    FcontasPorConfigurar,Fexportaencomendas:Boolean;
    FLISTADOCUMENTOSCmp:TSBBETABELADADOS;
    FLISTADOCUMENTOSENC:TSBBETABELADADOS;
    FFormatoDecimalGrelhaValor:string;
    FFormatoDecimalGrelhaQuant:string;
    FPrimeiraExportacao:boolean;
    FPrimeiraExportacaoEnc,FcontasPorConfigurarEnc:boolean ;
    Function  DaDataInicioEncExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
   Function  DaDataInicioExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
   Function  PreencheVariaveisGerais():Boolean;
   procedure PreencheGRELHA;
   procedure PreencheGRELHAEnc;
   Procedure Inicializaform;
   Procedure FormataGrelhaCompras;
   Procedure FormataGrelhaEnc;
   procedure LimpaGrelha;
   procedure LimpaGrelhaEnc;
   Procedure ColocaImagemEstado(pEstado, pLinha: Integer);
   Procedure  Preenchetiposdemovimentos;
  public
    { Public declarations }
      Procedure AbreFormulario;
  end;

var
  FRMERPExportCompras: TFRMERPExportCompras;

implementation
uses iERPOglobais,FNTUTILGrelha, SBBSSistemaBase, SBBSUtilSQL,IERPFrmPrincipal,ERPLogOperacoes,
  SBBaseDados;
var

FID_cLienteIndiferenciado:string;
FExpApenasComprasFechadas:Boolean;


Const
  Col_CMPArv=0;

  Col_CMPDESCricao=1;

  Col_CMPQtd=2;

  Col_CMPVALORSIVA=3;
  Col_CMPVALORIVA=4;
  Col_CMPVALORCIVA=5;
  Col_CMPTXIVA=6;
  Col_CMPCONTACBL=7;
  Col_CMPCONTACBLIVA=8;

  Col_CMPArmazem=9;
  Col_CMPArmazemERP=10;
  COL_CMPTipoArt=11;
  COL_StockImgEstado=12;
  Col_CMPTIPOMOV=13;
  Col_StockEstado=14;

  Col_CMPID_Cliente=15;
  Col_CMPID_cmpcabdocumento=16;

  Col_CMPMaxCols=17;



{$R *.dfm}

Procedure  TFRMERPExportCompras.Preenchetiposdemovimentos;
begin
 PreencheStringListConnection(cmbTipoDoc.Items,sb,'select * from tipomovimento where isnull(contaerp,'''') <>''''','descricao','ID_TipoMovimento',FCONNECTIONSTRING,true);
end;

Function DaNumCasasdecQuantStock():integer;
var
ListaPar:tsbbetabeladados;
strsql:string;
begin
 Result:=2;
 If FCONNECTIONSTRING<>'' then
 begin
  try
  ListaPar:=sb.SBBD.AbrirLV(FCONNECTIONSTRING,'select NumCasasDecQuantStock from tab_flags');
   If not(ListaPar.Vazia) then
    if ListaPar.davalor('NumCasasDecQuantStock').asinteger > 0 then
     Result:= ListaPar.davalor('NumCasasDecQuantStock').asinteger;
  except
  end;
 end;
end;

Function DaNumCasasDecValorStock():integer;
var
ListaPar:tsbbetabeladados;
strsql:string;
begin
 Result:=2;
 If FCONNECTIONSTRING<>'' then
 begin
  try
  ListaPar:=sb.SBBD.AbrirLV(FCONNECTIONSTRING,'select NumCasasDecValorStock from tab_flags');
   If not(ListaPar.Vazia) then
    if ListaPar.davalor('NumCasasDecValorStock').asinteger > 0 then
     Result:= ListaPar.davalor('NumCasasDecValorStock').asinteger;
  except
  end;
 end;


end;

Function FormatoDecimalGrelhaQuant():string;
var
 casasDecimais:integer;
Begin
   casasDecimais:=DaNumCasasdecQuantStock;
  Result:='%.'+inttostr(casasDecimais)+'f';
end;

Function FormatoDecimalGrelhaValor():string;
var
 casasDecimais:integer;
Begin
   casasDecimais:=DaNumCasasDecValorStock;
  Result:='%.'+inttostr(casasDecimais)+'f';
end;

Procedure TFRMERPExportCompras.ColocaImagemEstado(pEstado, pLinha: Integer);
Var
  Index: Integer;
Begin
  Case pEstado Of
    0 : Index := 78;
    1 : Index := 79;
  End;

  GrelhaCompras.AddImageIdx(COL_StockImgEstado, pLinha, Index, haCenter, vaCenter);
End;

Procedure TFRMERPExportCompras.FormataGrelhaCompras;

Var
    i: Integer;
    item: TMenuItem;

  strEstado:string;
Begin
  with GrelhaCompras do
  begin
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 2;
    RowCount := FixedRows + 1;
    ColCount := Col_CMPMaxCols;

    ColWidths[Col_CMPArv] := 28;
    ColWidths[Col_CMPQtd] := 50;


    ColWidths[Col_CMPCONTACBL] := 65;


    ColWidths[Col_CMPTXIVA] := 35;
    ColWidths[Col_CMPVALORIVA] := 60;
    ColWidths[Col_CMPVALORSIVA] := 60;
    ColWidths[Col_CMPVALORCIVA] := 60;


    ColWidths[Col_CMPID_cmpcabdocumento] := 0;
    ColWidths[Col_CMPCONTACBLIVA] := 50;
    ColWidths[Col_CMPID_cliente] := 0;
    ColWidths[Col_CMPArmazem] := 90;
    ColWidths[Col_CMPArmazemERP] := 55;

    ColWidths[COL_StockImgEstado] := 30;
    ColWidths[Col_StockEstado] := 0;
    ColWidths[COL_CMPTipoArt] := 30;
    ColWidths[Col_CMPTIPOMOV] := 30;






    ColWidths[COL_CMPDescricao]:= Width - ColWidths[Col_CMPTIPOMOV]- ColWidths[COL_CMPTipoArt]-ColWidths[Col_CMPCONTACBLIVA]-ColWidths[Col_CMPArv] -ColWidths[Col_CMPTXIVA]-
    ColWidths[Col_CMPCONTACBL]-  ColWidths[Col_CMPQtd]-
                    ColWidths[COL_CMPID_CMPCabdocumento]-
    ColWidths[Col_CMPArmazem]-
    ColWidths[Col_CMPArmazemERP]-ColWidths[COL_StockImgEstado]-


            ColWidths[Col_CMPVALORIVA]-
            ColWidths[Col_CMPVALORSIVA] -
            ColWidths[Col_CMPVALORCIVA] - 21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+[goColsizing]-[goEditing];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;

    ControlLook.NoDisabledButtonLook:=True;

    Cells[Col_CMPTIPOMOV, 0] := SB.Idioma.daTraducao(0, 'Tipo');
    Cells[COL_CMPTipoArt, 0] := SB.Idioma.daTraducao(0, 'T.Art.');
    Cells[Col_CMPDESCricao, 0] := SB.Idioma.daTraducao(42, 'Descrição');
    Cells[Col_CMPTXIVA, 0] := SB.Idioma.daTraducao(0, 'IVA');
    Cells[Col_CMPCONTACBL, 0] := SB.Idioma.daTraducao(0, 'CONTA ERP');
    Cells[Col_CMPCONTACBLIVA, 0] := SB.Idioma.daTraducao(0, 'Conta IVA ERP');
    Cells[Col_CMPQtd, 0] := SB.Idioma.daTraducao(0, 'QTD');
    Cells[Col_CMPVALORIVA, 0] := SB.Idioma.daTraducao(0, 'Valor  IVA');
    Cells[Col_CMPVALORSIVA, 0] := SB.Idioma.daTraducao(0, 'Valor  Sem IVA');
    Cells[Col_CMPVALORCIVA, 0] := SB.Idioma.daTraducao(0, 'Valor  Com IVA');
    Cells[Col_CMPArmazem, 1] := SB.Idioma.daTraducao(0, 'Descrição');
    Cells[Col_CMPArmazemERP, 1] := SB.Idioma.daTraducao(0, 'Conta ERP');


    MergeCells(Col_CMPArmazem, 0, 2, 1);
    MergeCells(Col_CMPDESCricao, 0, 1, 2);
    MergeCells(Col_CMPTXIVA, 0, 1, 2);
    MergeCells(Col_CMPCONTACBL, 0, 1, 2);
    MergeCells(Col_CMPCONTACBLIVA, 0, 1, 2);
    MergeCells(Col_CMPVALORIVA, 0, 1, 2);
    MergeCells(Col_CMPVALORSIVA, 0, 1, 2);
    MergeCells(Col_CMPVALORCIVA, 0, 1, 2);
     MergeCells(Col_CMPQtd, 0, 1, 2);

    Cells[Col_CMPArmazem, 0] := SB.Idioma.daTraducao(0, 'Armazém');
    Alignments[Col_CMPArmazem, 0]:=taCenter;
    Alignments[Col_CMPCONTACBLIVA, 0]:=taCenter;
    Alignments[Col_CMPCONTACBL, 0]:=taCenter;
    Alignments[Col_CMPVALORIVA, 0]:=taCenter;
    Alignments[Col_CMPVALORSIVA, 0]:=taCenter;
    Alignments[Col_CMPVALORCIVA, 0]:=taCenter;


    For i:= 0 To PopupMenu.Items.Count-3 Do
      PopupMenu.Items.Delete(i);

    item:= TMenuItem.Create(GrelhaCompras);
    item.Action := acExpandir;
    item.Caption := 'Expandir Grelha';
    PopupMenu.Items.Insert(0,item);

    item:= TMenuItem.Create(GrelhaCompras);
    item.Action := acContrair;
    item.Caption :=  'Contrair Grelha';
    PopupMenu.Items.Insert(1, item);



    EndUpdate;
  end;
End;


Procedure TFRMERPExportCompras.Inicializaform;
Begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  dtdatafim.Date:= sb.DataSistema;
  PreencheVariaveisGerais;
  FormataGrelhaCompras;
    FormataGrelhaenc;
   Preenchetiposdemovimentos;
end;

Procedure TFRMERPExportCompras.AbreFormulario;
begin
 Inicializaform;
 showmodal;
end;


procedure TFRMERPExportCompras.BtExportarmovClick(Sender: TObject);
var
  ListaIDSExportados:tstringList;
begin
If  assigned(FLISTADOCUMENTOSCMP) then
 begin

    If Not(FcontasPorConfigurar) then
    begin
          ListaIDSExportados:=tstringList.create;
        If Exportarcompras(FLISTADOCUMENTOSCMP,ListaIDSExportados) then
        begin
         If   FPrimeiraExportacao=true  then
         begin
           sb.SBBD.Executa('update ERP_EMPRESAINTERFACE set DATAInicioExportacao='+sb.UtilSQL.DataToSQLData(dtdataInicio.date)
            +' where id_interface=3');
         end;
         MarcaMovimentosComoExportados(dtdataInicio.date,dtdatafim.date,ListaIDSExportados,FLISTADOCUMENTOSCMP,'ERPIntegration');
         RegistaLogOperacao('Operação:Exportação Compras SYSController');
         gbData.enabled:=false;
         LimpaGrelha;
        end;
    end
    else
    begin
      sb.Dialogos.SBMessage('Não é possível exportar!'+#13+'Verifique as Contas ERP.');
    end;
 end;
end;

procedure TFRMERPExportCompras.BtsairClick(Sender: TObject);
begin
 self.close;
end;

procedure TFRMERPExportCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFRMERPExportCompras.FormCreate(Sender: TObject);
begin
 FormataFormPorDefeito(self);
 FormataBotoes(self);
 FLISTADOCUMENTOSCMP:=nil;
 FLISTADOCUMENTOSEnc:=nil;
 FFormatoDecimalGrelhaValor:=FormatoDecimalGrelhaValor;
 FFormatoDecimalGrelhaQuant:=FormatoDecimalGrelhaQuant;
 Fexportaencomendas:=false;
 PanelEnc.Visible:=false;
 BtexpEncomendas.Visible:=false;
 Top:=FrmIERPPrincipal.MenuOpcoes.Height+20;
end;


procedure TFRMERPExportCompras.PreencheGRELHA;
var
    Filtro:string;
    i:Integer;
    DadosNos :TDadosnos;
   TotNDocs:Integer;
   TotalVendas,TotalCreditos:extended;
   dataInicio,DataFim:Tdatetime;
   segue:Boolean;
  SysObjInterface:TERPBEEMPRESAINTERFACE;
  ID_TipoMov:integer;
begin
   SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_COMPRASSYSCONTROLLER');
   segue:=false;
   FcontasPorConfigurar:=false;
   TotNDocs:=0;
   TotalVendas:=0;
   TotalCreditos:=0;
   dataInicio:=0;
   DataFim:=0;
  If TotNDocs>0 then
  begin
   TssbDocCompras.Caption:='Doc.Compras';
   TssbDocCompras.TabAppearance.Font.Size:=10;
   TssbDocCompras.TabAppearance.Font.Style:=[];
  end;

   DadosNos := TDadosnos.create;
   i:=Grelhacompras.FixedRows;
   If assigned(FLISTADOCUMENTOSCMP) then
   begin
    Freeandnil(FLISTADOCUMENTOSCMP);
   end;
   If filtraMaskData(dtdataInicio)>0 Then
      DataInicio:= dtdataInicio.date;
   If filtraMaskData(dtdatafim)>0 Then
      DataFim:= dtdatafim.date;
   ID_TipoMov:=0;
   ID_TipoMov:=daComboBoxValor(cmbTipoDoc);

   If ID_TipoMov>0 then
   begin
      if filtro<>'' then
        filtro:=filtro+' and ';
        filtro:=filtro+' MovimentoStock.id_tipomovimento='+Inttostr(ID_TipoMov);
   end;

   FLISTADOCUMENTOSCMP:=ERPOperInterfacefntCMP.DaListaDocumentosCMPPorExportar(Filtro,DataInicio,DataFim,SysObjInterface.PrefixoContCblAartigo);
   If FLISTADOCUMENTOSCMP<>nil then
    If Not FLISTADOCUMENTOSCMP.Vazia then
       segue:=true;

   if segue =true then
   begin
     While Not FLISTADOCUMENTOSCMP.nofim do
     begin
      with Grelhacompras do
      begin
        If  (Not(ExisteNo(IntTostr(FLISTADOCUMENTOSCMP.davalor('id_movimento').asinteger),DadosNos))) Then
        Begin
             Inc(TotNDocs);
              If  FLISTADOCUMENTOSCMP.davalor('TipoOperacao').asstring='0' then
                    TotalVendas:=TotalVendas+FLISTADOCUMENTOSCMP.davalor('valortotal').asFloat
              else
                TotalCreditos:=TotalCreditos+abs(FLISTADOCUMENTOSCMP.davalor('valortotal').asFloat);
              IncrementaNos(FLISTADOCUMENTOSCMP.davalor('id_movimento').asstring, i, DadosNos);
              cells[Col_CMPDESCricao,i]:=FLISTADOCUMENTOSCMP.davalor('Tipodoc').asstring+'\'+FLISTADOCUMENTOSCMP.davalor('Serie').asstring+
                      ' Nº'+ FLISTADOCUMENTOSCMP.davalor('ID_documento').asstring+
                      ' DT.Mov:'+ FLISTADOCUMENTOSCMP.davalor('Data').asstring+ ' '+
                      ' DT.Doc:'+ FLISTADOCUMENTOSCMP.davalor('DataDoc').asstring+ ' '+
                       FLISTADOCUMENTOSCMP.davalor('NomeCliente').asstring;

              If FLISTADOCUMENTOSCMP.davalor('contaCblCliente').asstring<>'' then
                   cells[Col_CMPDESCricao,i]:=cells[Col_CMPDESCricao,i]+' Nr Cliente: '+ FLISTADOCUMENTOSCMP.davalor('contaCblCliente').asstring
              else
              If FID_clienteIndiferenciado<>'' then
                   cells[Col_CMPDESCricao,i]:=cells[Col_CMPDESCricao,i]+' Nr Cliente: '+ FID_clienteIndiferenciado
              else
                cells[Col_CMPDESCricao,i]:=cells[Col_CMPDESCricao,i]+' Nr Cliente: ';

              floats[Col_CMPVALORSIVA,i]:=FLISTADOCUMENTOSCMP.davalor('ValorDocSemIVA').asfloat;
              floats[Col_CMPVALORIVA,i]:=FLISTADOCUMENTOSCMP.davalor('TotalDociva').asfloat;
              floats[Col_CMPVALORCIVA,i]:=FLISTADOCUMENTOSCMP.davalor('TotalDocComIVA').asfloat;

             If  FLISTADOCUMENTOSCMP.davalor('id_Tipoentidade').asinteger= 1 then
                     cells[Col_CMPTIPOMOV,i]:='C'
             else
                 cells[Col_CMPTIPOMOV,i]:='O';

              FontStyles[Col_CMPVALORCIVA,i]:=[fsBold];
              FontStyles[Col_CMPVALORIVA,i]:=[fsBold];
              FontStyles[Col_CMPVALORSIVA,i]:=[fsBold];
              FontStyles[Col_CMPDESCricao,i]:=[fsBold];

              Ints[Col_StockEstado,i]:=FLISTADOCUMENTOSCMP.davalor('Estado').asinteger;
              ColocaImagemEstado(FLISTADOCUMENTOSCMP.daValor('Estado').AsInteger, i);



              cells[Col_CMPCONTACBL,i]:=FLISTADOCUMENTOSCMP.davalor('ContaCBLTDOC').asstring;
              Ints[Col_CMPID_Cliente,i]:=FLISTADOCUMENTOSCMP.davalor('id_entidade').asinteger;
              Colors [Col_CMPCONTACBL,i]:=clWindow;
              If cells[Col_CMPCONTACBL,i]='' then
              begin
                 Colors [Col_CMPCONTACBL,i]:=clred;
                 FcontasPorConfigurar:=true;
              end;
              MergeCells(Col_CMPDESCricao,i,2,1);
              Ints[Col_CMPID_cmpcabdocumento,i]:=FLISTADOCUMENTOSCMP.davalor('id_movimento').asinteger;
              RowColor[i] := clInfoBk;
              rowcount:=rowcount+1;
              Inc(i);
        end;
        IncrementaNos(FLISTADOCUMENTOSCMP.davalor('id_movimento').asstring, i, DadosNos);
        cells[Col_CMPDESCricao,i]:=FLISTADOCUMENTOSCMP.davalor('DescricaoProduto').asstring;
        floats[Col_CMPQtd,i]:=FLISTADOCUMENTOSCMP.davalor('Quantidade').asfloat;
        If FLISTADOCUMENTOSCMP.davalor('id_Unidade').asInteger>0 then
                floats[Col_CMPQtd,i]:=FLISTADOCUMENTOSCMP.davalor('QuantidadeConvertida').asfloat;
        If  FLISTADOCUMENTOSCMP.davalor('Tipomovimento').asinteger=0 then
        begin

            Cells[COL_CMPTipoArt, i] := FLISTADOCUMENTOSCMP.davalor('TipoArtigoERP').asstring;
            Cells[Col_CMPArmazem, i] := FLISTADOCUMENTOSCMP.davalor('armazem').asstring;
            Cells[Col_CMPArmazemERP, i] :=FLISTADOCUMENTOSCMP.davalor('ID_armazemERP').asstring;
            floats[Col_CMPVALORSIVA,i]:=FLISTADOCUMENTOSCMP.davalor('valorLinhasemIva').asfloat;
            floats[Col_CMPVALORIVA,i]:=FLISTADOCUMENTOSCMP.davalor('valoriva').asfloat;
            floats[Col_CMPVALORCIVA,i]:=FLISTADOCUMENTOSCMP.davalor('VAlorlinhaComIVA').asfloat;
            cells[Col_CMPTXIVA,i]:=FLISTADOCUMENTOSCMP.davalor('percentagemIVA').asstring+'%';
        end
        else
        begin
            cells[Col_CMPTXIVA,i]:='';
            floats[Col_CMPVALORSIVA,i]:=0;
            floats[Col_CMPVALORIVA,i]:=0;
            floats[Col_CMPVALORCIVA,i]:=FLISTADOCUMENTOSCMP.davalor('VAlorlinhaComIVA').asfloat;
            FontStyles[Col_CMPVALORCIVA,i]:=[fsBold];
            FontStyles[Col_CMPDESCricao,i]:=[fsBold];
        end;




        Ints[Col_CMPID_Cliente,i]:=FLISTADOCUMENTOSCMP.davalor('id_entidade').asinteger;
        cells[Col_CMPCONTACBL,i]:=FLISTADOCUMENTOSCMP.davalor('ContaCBLProd').asstring;
        cells[Col_CMPCONTACBLIVA,i]:=FLISTADOCUMENTOSCMP.davalor('contaCblIVA').asstring;
       If  FLISTADOCUMENTOSCMP.davalor('Tipomovimento').asinteger=0 then
        begin

            cells[Col_CMPCONTACBL,i]:=FLISTADOCUMENTOSCMP.davalor('ContaCBLProd').asstring;
            cells[Col_CMPCONTACBLIVA,i]:=FLISTADOCUMENTOSCMP.davalor('contaCblIVA').asstring;
            If  cells[Col_CMPCONTACBL,i]='' then
            begin
              Colors[Col_CMPCONTACBL,i]:=clred;
              FcontasPorConfigurar:=true;
            end;
            If  cells[Col_CMPCONTACBLIVA,i]='' then
            begin
              Colors[Col_CMPCONTACBLIVA,i]:=clred;
              FcontasPorConfigurar:=true;
            end;


        end

        else
        begin
            cells[Col_CMPCONTACBL,i]:=FLISTADOCUMENTOSCMP.davalor('ContaCBLPAG').asstring;
            If  cells[Col_CMPCONTACBL,i]='' then
            begin
                  Colors[Col_CMPCONTACBL,i]:=clred;
            end;
        end;
        rowcount:=rowcount+1;
        Inc(i);
      end;
        FLISTADOCUMENTOSCMP.seguinte;

     end;
     If Assigned(DadosNos) Then
     Begin
          For i:=0 to DadosNos.Num-1 Do
            Grelhacompras.AddNode(DadosNos.elem[i].Posicao, DadosNos.elem[i].NumFilhos);
     End;

   end
   else
     sb.Dialogos.SBMessage('Não existem documentos de Compras para exportar!');
  StTotalDocs.caption:=IntTostr(TotNDocs);
  StTotalVendas.caption:=FormatFloat('0.00',TotalVendas);
  StTotalCreditos.caption:=FormatFloat('0.00',TotalCreditos);
  If TotNDocs>0 then
  begin
   TssbDocCompras.Caption:='Doc.Compras: '+inttostr(TotNDocs);
   TssbDocCompras.TabAppearance.Font.Size:=12;
   TssbDocCompras.TabAppearance.Font.Style:=[fsbold];
  end;


end;


Function  TFRMERPExportCompras.DaDataInicioExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
var Ano, Mes, Dias: Integer;
    data:tdatetime;
     Listaex:Tsbbetabeladados;
Begin
  FPrimeiraExportacao:=true;
  Data := SB.Empresa.DataTrabalho;
  Ano:=YearOf(data);
  Result:= EncodeDate(Ano,1,1);
  Listaex:=sb.sbbd.abrirlv('select * from ERP_CompCab');
  If Not(Listaex.vazia) then
  begin

    If pObjInterface.DATAInicioExportacao>0 then
    begin
       FPrimeiraExportacao:=false;
       Result:= pObjInterface.DATAInicioExportacao;
       gbData.enabled:=false;
       dtdatainicio.color:=clsilver;
    end;
  end;
 Listaex.fecha;
 Freeandnil(Listaex);
end;

Function  TFRMERPExportCompras.DaDataInicioEncExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
var Ano, Mes, Dias: Integer;
    data:tdatetime;
     Listaex:Tsbbetabeladados;
Begin
  FPrimeiraExportacaoEnc:=true;
  Data := SB.Empresa.DataTrabalho;
  Ano:=YearOf(data);
  Result:= EncodeDate(Ano,1,1);
  Listaex:=sb.sbbd.abrirlv('select * from ERP_CompCab where encomenda=1');
  If Not(Listaex.vazia) then
  begin

    If pObjInterface.DataIniExpEncomendas>0 then
    begin
       FPrimeiraExportacaoEnc:=false;
       Result:= pObjInterface.DataIniExpEncomendas;
       gbDataenc.enabled:=false;
       dtdataInicioEnc.color:=clsilver;
    end;
  end;
 Listaex.fecha;
 Freeandnil(Listaex);
end;


Function TFRMERPExportCompras.PreencheVariaveisGerais():Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
 mensagem:string;
begin
  result:=false;
  FExpApenasComprasFechadas:=false;
  FID_clienteIndiferenciado:='';
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_COMPRASSYSCONTROLLER');
  If assigned(ObjInterface) then
  begin
       Result:=True;
       dtdataInicio.Date:=DaDataInicioExportacao(ObjInterface);
       PanelEnc.Visible:=ObjInterface.ExpEncomendas;
       BtexpEncomendas.Visible:=ObjInterface.ExpEncomendas;
       If ObjInterface.ExpEncomendas =true then
       begin
             dtdatainicioenc.Date:=DaDataInicioEncExportacao(ObjInterface);
             Fexportaencomendas:=true;
       end;
       ERPOperInterfaceFNTcmp.FOBJInterface:=MotorERP.ERPInterface.Clone(ObjInterface);
       FID_clienteIndiferenciado:= ObjInterface.ID_clienteIndiferenciado;
       FExpApenasComprasFechadas:= ObjInterface.ExpApenasComprasFechadas;
       FCONNECTIONSTRING := ObjInterface.BDConexao;

       If ObjInterface.BDConexao='' then
         mensagem:='Falta Conexão á Base de Dados do SYSCONTROLLER!';

       If ObjInterface.ID_clienteIndiferenciado='' then
       begin
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar o cliente indeferenciado!'
       end;


       If mensagem<>'' then
       begin
        Result:=false;
        sb.Dialogos.SBMessage(mensagem+#13+'Verifique as Configurações do Interface!');
        BtActualizar.enabled:=false;
        BtExportarmov.Enabled:=false;
       end;
       if result=true then
            CarregaListasSyscontroller(ObjInterface.BDConexao);
        freeandnil(ObjInterface);
  end
  else
  begin
   result:=false;
   sb.Dialogos.SBMessage('Não existe interface: "ERP_COMPRASSYSCONTROLLER" Ativo!');
   BtActualizar.enabled:=false;
   BtExportarmov.Enabled:=false;
  end;

end;


procedure TFRMERPExportCompras.LimpaGrelha;
VAR
  i:integer;
begin
  StTotalDocs.caption:= '0';
  for i:=1 to GrelhaCompras.ALLRowCount-1 do
  begin
      GrelhaCompras.RemoveNode(i);
  end;
  GrelhaCompras.clearnormalcells;
  GrelhaCompras.rowcount:=GrelhaCompras.fixedrows+1;
  If assigned(FLISTADOCUMENTOScmp) then
  begin
   FLISTADOCUMENTOSCMP.Fecha;
   freeandnil(FLISTADOCUMENTOSCMP);

  end;

end;


procedure TFRMERPExportCompras.BtActualizarClick(Sender: TObject);
begin
 if assigned(FLISTADOCUMENTOSCMP) then
 begin
     FLISTADOCUMENTOSCMP.Fecha;
     Freeandnil(FLISTADOCUMENTOSCMP);
 end;
 LimpaGrelha;
 PreencheGRELHA;
 If Fexportaencomendas=true then
 begin
 if assigned(FLISTADOCUMENTOSenc) then
 begin
     FLISTADOCUMENTOSENC.Fecha;
     Freeandnil(FLISTADOCUMENTOSEnc);
 end;
 LimpaGrelhaENC;
 PreencheGRELHAENC;

 end;
end;

procedure TFRMERPExportCompras.btLimparClick(Sender: TObject);
begin
  StTotalDocs.caption:=IntTostr(0);
  StTotalVendas.caption:=FormatFloat('0.00',0);
  StTotalCreditos.caption:=FormatFloat('0.00',0);
  LimpaGrelha;
end;


procedure TFRMERPExportCompras.GrelhaComprasGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ARow>0) And (ACOL in[Col_CMPQtd,Col_CmpVALORIVa,Col_CmpVALORCIVa, Col_CmpVALORSIVa]) then
    HAlign:=taRightJustify;

end;

procedure TFRMERPExportCompras.GrelhaComprasCanSort(Sender: TObject;
  ACol: Integer; var DoSort: Boolean);
begin
 dosort:=false;
end;

procedure TFRMERPExportCompras.GrelhaComprasGetFloatFormat(Sender: TObject;
  ACol, ARow: Integer; var IsFloat: Boolean; var FloatFormat: String);
begin
 inherited;
  If aCol in [Col_CMPVALORSIVA,Col_CMPVALORCIVA,Col_CMPVALORIVA] then
  begin
    isfloat:=true;
    FloatFormat:=FFormatoDecimalGrelhaValor;
  end
  else
  If aCol in [ Col_CMPQtd] then
  begin
    isfloat:=true;
    FloatFormat:=FFormatoDecimalGrelhaQuant;
  end
  else
 
   isfloat:=false;
end;

procedure TFRMERPExportCompras.AccontrairExecute(Sender: TObject);
begin
 GrelhaCompras.ContractAll;;
end;

procedure TFRMERPExportCompras.acexpandirExecute(Sender: TObject);
begin
 GrelhaCompras.ExpandAll;;
end;


Procedure TFRMERPExportCompras.FormataGrelhaEnc;

Var
    i: Integer;
    item: TMenuItem;

  strEstado:string;
Begin
  with GrelhaEnc do
  begin
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 2;
    RowCount := FixedRows + 1;
    ColCount := Col_CMPMaxCols;

    ColWidths[Col_CMPArv] := 28;
    ColWidths[Col_CMPQtd] := 50;


    ColWidths[Col_CMPCONTACBL] := 65;


    ColWidths[Col_CMPTXIVA] := 35;
    ColWidths[Col_CMPVALORIVA] := 60;
    ColWidths[Col_CMPVALORSIVA] := 60;
    ColWidths[Col_CMPVALORCIVA] := 60;


    ColWidths[Col_CMPID_cmpcabdocumento] := 0;
    ColWidths[Col_CMPCONTACBLIVA] := 50;
    ColWidths[Col_CMPID_cliente] := 0;
    ColWidths[Col_CMPArmazem] := 90;
    ColWidths[Col_CMPArmazemERP] := 55;

    ColWidths[COL_StockImgEstado] := 30;
    ColWidths[Col_StockEstado] := 0;
    ColWidths[COL_CMPTipoArt] := 30;
    ColWidths[Col_CMPTIPOMOV] := 30;






    ColWidths[COL_CMPDescricao]:= Width - ColWidths[Col_CMPTIPOMOV]- ColWidths[COL_CMPTipoArt]-ColWidths[Col_CMPCONTACBLIVA]-ColWidths[Col_CMPArv] -ColWidths[Col_CMPTXIVA]-
    ColWidths[Col_CMPCONTACBL]-  ColWidths[Col_CMPQtd]-
                    ColWidths[COL_CMPID_CMPCabdocumento]-
    ColWidths[Col_CMPArmazem]-
    ColWidths[Col_CMPArmazemERP]-ColWidths[COL_StockImgEstado]-


            ColWidths[Col_CMPVALORIVA]-
            ColWidths[Col_CMPVALORSIVA] -
            ColWidths[Col_CMPVALORCIVA] - 21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+[goColsizing]-[goEditing];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;

    ControlLook.NoDisabledButtonLook:=True;

    Cells[Col_CMPTIPOMOV, 0] := SB.Idioma.daTraducao(0, 'Tipo');
    Cells[COL_CMPTipoArt, 0] := SB.Idioma.daTraducao(0, 'T.Art.');
    Cells[Col_CMPDESCricao, 0] := SB.Idioma.daTraducao(42, 'Descrição');
    Cells[Col_CMPTXIVA, 0] := SB.Idioma.daTraducao(0, 'IVA');
    Cells[Col_CMPCONTACBL, 0] := SB.Idioma.daTraducao(0, 'CONTA ERP');
    Cells[Col_CMPCONTACBLIVA, 0] := SB.Idioma.daTraducao(0, 'Conta IVA ERP');
    Cells[Col_CMPQtd, 0] := SB.Idioma.daTraducao(0, 'QTD');
    Cells[Col_CMPVALORIVA, 0] := SB.Idioma.daTraducao(0, 'Valor  IVA');
    Cells[Col_CMPVALORSIVA, 0] := SB.Idioma.daTraducao(0, 'Valor  Sem IVA');
    Cells[Col_CMPVALORCIVA, 0] := SB.Idioma.daTraducao(0, 'Valor  Com IVA');
    Cells[Col_CMPArmazem, 1] := SB.Idioma.daTraducao(0, 'Descrição');
    Cells[Col_CMPArmazemERP, 1] := SB.Idioma.daTraducao(0, 'Conta ERP');


    MergeCells(Col_CMPArmazem, 0, 2, 1);
    MergeCells(Col_CMPDESCricao, 0, 1, 2);
    MergeCells(Col_CMPTXIVA, 0, 1, 2);
    MergeCells(Col_CMPCONTACBL, 0, 1, 2);
    MergeCells(Col_CMPCONTACBLIVA, 0, 1, 2);
    MergeCells(Col_CMPVALORIVA, 0, 1, 2);
    MergeCells(Col_CMPVALORSIVA, 0, 1, 2);
    MergeCells(Col_CMPVALORCIVA, 0, 1, 2);
     MergeCells(Col_CMPQtd, 0, 1, 2);

    Cells[Col_CMPArmazem, 0] := SB.Idioma.daTraducao(0, 'Armazém');
    Alignments[Col_CMPArmazem, 0]:=taCenter;
    Alignments[Col_CMPCONTACBLIVA, 0]:=taCenter;
    Alignments[Col_CMPCONTACBL, 0]:=taCenter;
    Alignments[Col_CMPVALORIVA, 0]:=taCenter;
    Alignments[Col_CMPVALORSIVA, 0]:=taCenter;
    Alignments[Col_CMPVALORCIVA, 0]:=taCenter;


    For i:= 0 To PopupMenu.Items.Count-3 Do
      PopupMenu.Items.Delete(i);

    item:= TMenuItem.Create(GrelhaEnc);
    item.Action := acExpandirEnc;
    item.Caption := 'Expandir Grelha';
    PopupMenu.Items.Insert(0,item);

    item:= TMenuItem.Create(GrelhaEnc);
    item.Action := acContrairEnc;
    item.Caption :=  'Contrair Grelha';
    PopupMenu.Items.Insert(1, item);



    EndUpdate;
  end;
End;


procedure TFRMERPExportCompras.acexpandirencExecute(Sender: TObject);
begin
 GrelhaEnc.ExpandAll;
end;

procedure TFRMERPExportCompras.accontrairencExecute(Sender: TObject);
begin
    GrelhaEnc.contractall;
end;


procedure TFRMERPExportCompras.LimpaGrelhaEnc;
VAR
  i:integer;
begin
//  StTotalDocs.caption:= '0';
  for i:=1 to GrelhaEnc.ALLRowCount-1 do
  begin
      GrelhaEnc.RemoveNode(i);
  end;
  GrelhaEnc.clearnormalcells;
  GrelhaEnc.rowcount:=GrelhaEnc.fixedrows+1;
  If assigned(FLISTADOCUMENTOSENC) then
  begin
   FLISTADOCUMENTOSENC.Fecha;
   freeandnil(FLISTADOCUMENTOSEnc);

  end;

end;


procedure TFRMERPExportCompras.PreencheGRELHAEnc;
var
    Filtro:string;
    i:Integer;
    DadosNos :TDadosnos;
   TotNDocs:Integer;
   TotalVendas,TotalCreditos:extended;
   dataInicio,DataFim:Tdatetime;
   segue:Boolean;
  SysObjInterface:TERPBEEMPRESAINTERFACE;
  ID_TipoMov:integer;
begin
  SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_COMPRASSYSCONTROLLER');
   segue:=false;
   FcontasPorConfigurarEnc:=false;
   TotNDocs:=0;
   TotalVendas:=0;
   TotalCreditos:=0;
   dataInicio:=0;
   DataFim:=0;
  If TotNDocs>0 then
  begin
   tssbEncomendas.Caption:='Encomendas';
   tssbEncomendas.TabAppearance.Font.Size:=10;
   tssbEncomendas.TabAppearance.Font.Style:=[];
  end;
   DadosNos := TDadosnos.create;
   i:=GrelhaEnc.FixedRows;
   If assigned(FLISTADOCUMENTOSEnc) then
   begin
    Freeandnil(FLISTADOCUMENTOSEnc);
   end;
   If filtraMaskData(dtdataInicioEnc)>0 Then
      DataInicio:= dtdataInicioEnc.date;
   If filtraMaskData(dtdatafimenc)>0 Then
      DataFim:= dtdatafimenc.date;

   FLISTADOCUMENTOSEnc:=ERPOperInterfacefntCMP.DaListaDocumentosEncomendasPorExportar(Filtro,DataInicio,DataFim,SysObjInterface.PrefixoContCblAartigo);
   If FLISTADOCUMENTOSEnc<>nil then
    If Not FLISTADOCUMENTOSEnc.Vazia then
       segue:=true;

   if segue =true then
   begin
     While Not FLISTADOCUMENTOSEnc.nofim do
     begin
      with GrelhaEnc do
      begin
        If  (Not(ExisteNo(IntTostr(FLISTADOCUMENTOSEnc.davalor('id_encomenda').asinteger),DadosNos))) Then
        Begin
             Inc(TotNDocs);
              If  FLISTADOCUMENTOSEnc.davalor('TipoOperacao').asstring='0' then
                    TotalVendas:=TotalVendas+FLISTADOCUMENTOSEnc.davalor('valortotal').asFloat
              else
                TotalCreditos:=TotalCreditos+abs(FLISTADOCUMENTOSEnc.davalor('valortotal').asFloat);
              IncrementaNos(FLISTADOCUMENTOSEnc.davalor('id_encomenda').asstring, i, DadosNos);
              cells[Col_CMPDESCricao,i]:=FLISTADOCUMENTOSEnc.davalor('Tipodoc').asstring+'\'+FLISTADOCUMENTOSEnc.davalor('Serie').asstring+
                      ' Nº'+ FLISTADOCUMENTOSEnc.davalor('ID_documento').asstring+
                      ' Data:'+ FLISTADOCUMENTOSEnc.davalor('Data').asstring+ ' '+ FLISTADOCUMENTOSEnc.davalor('NomeCliente').asstring;

              If FLISTADOCUMENTOSEnc.davalor('contaCblCliente').asstring<>'' then
                   cells[Col_CMPDESCricao,i]:=cells[Col_CMPDESCricao,i]+' Nr Cliente: '+ FLISTADOCUMENTOSEnc.davalor('contaCblCliente').asstring
              else
              If FID_clienteIndiferenciado<>'' then
                   cells[Col_CMPDESCricao,i]:=cells[Col_CMPDESCricao,i]+' Nr Cliente: '+ FID_clienteIndiferenciado
              else
                cells[Col_CMPDESCricao,i]:=cells[Col_CMPDESCricao,i]+' Nr Cliente: ';

              floats[Col_CMPVALORSIVA,i]:=FLISTADOCUMENTOSEnc.davalor('ValorDocSemIVA').asfloat;
              floats[Col_CMPVALORIVA,i]:=FLISTADOCUMENTOSEnc.davalor('TotalDociva').asfloat;
              floats[Col_CMPVALORCIVA,i]:=FLISTADOCUMENTOSEnc.davalor('TotalDocComIVA').asfloat;

             If  FLISTADOCUMENTOSEnc.davalor('id_Tipoentidade').asinteger= 1 then
                     cells[Col_CMPTIPOMOV,i]:='C'
             else
                 cells[Col_CMPTIPOMOV,i]:='O';

              FontStyles[Col_CMPVALORCIVA,i]:=[fsBold];
              FontStyles[Col_CMPVALORIVA,i]:=[fsBold];
              FontStyles[Col_CMPVALORSIVA,i]:=[fsBold];
              FontStyles[Col_CMPDESCricao,i]:=[fsBold];

              Ints[Col_StockEstado,i]:=FLISTADOCUMENTOSEnc.davalor('Estado').asinteger;
              ColocaImagemEstado(FLISTADOCUMENTOSEnc.daValor('Estado').AsInteger, i);



              cells[Col_CMPCONTACBL,i]:=FLISTADOCUMENTOSEnc.davalor('ContaCBLTDOC').asstring;
              Ints[Col_CMPID_Cliente,i]:=FLISTADOCUMENTOSEnc.davalor('id_entidade').asinteger;
              Colors [Col_CMPCONTACBL,i]:=clWindow;
              If cells[Col_CMPCONTACBL,i]='' then
              begin
                 Colors [Col_CMPCONTACBL,i]:=clred;
                 FcontasPorConfigurarEnc:=true;
              end;
              MergeCells(Col_CMPDESCricao,i,2,1);
              Ints[Col_CMPID_cmpcabdocumento,i]:=FLISTADOCUMENTOSEnc.davalor('id_encomenda').asinteger;
              RowColor[i] := clInfoBk;
              rowcount:=rowcount+1;
              Inc(i);
        end;
        IncrementaNos(FLISTADOCUMENTOSEnc.davalor('id_encomenda').asstring, i, DadosNos);
        cells[Col_CMPDESCricao,i]:=FLISTADOCUMENTOSEnc.davalor('DescricaoProduto').asstring;
        floats[Col_CMPQtd,i]:=FLISTADOCUMENTOSEnc.davalor('Quantidade').asfloat;
        If FLISTADOCUMENTOSEnc.davalor('id_Unidade').asInteger>0 then
                floats[Col_CMPQtd,i]:=FLISTADOCUMENTOSEnc.davalor('QuantidadeConvertida').asfloat;
        If  FLISTADOCUMENTOSEnc.davalor('Tipomovimento').asinteger=0 then
        begin

            Cells[COL_CMPTipoArt, i] := FLISTADOCUMENTOSEnc.davalor('TipoArtigoERP').asstring;
            Cells[Col_CMPArmazem, i] := FLISTADOCUMENTOSEnc.davalor('armazem').asstring;
            Cells[Col_CMPArmazemERP, i] :=FLISTADOCUMENTOSEnc.davalor('ID_armazemERP').asstring;
            floats[Col_CMPVALORSIVA,i]:=FLISTADOCUMENTOSEnc.davalor('valorLinhasemIva').asfloat;
            floats[Col_CMPVALORIVA,i]:=FLISTADOCUMENTOSEnc.davalor('valoriva').asfloat;
            floats[Col_CMPVALORCIVA,i]:=FLISTADOCUMENTOSEnc.davalor('VAlorlinhaComIVA').asfloat;
            cells[Col_CMPTXIVA,i]:=FLISTADOCUMENTOSEnc.davalor('percentagemIVA').asstring+'%';
        end
        else
        begin
            cells[Col_CMPTXIVA,i]:='';
            floats[Col_CMPVALORSIVA,i]:=0;
            floats[Col_CMPVALORIVA,i]:=0;
            floats[Col_CMPVALORCIVA,i]:=FLISTADOCUMENTOSEnc.davalor('VAlorlinhaComIVA').asfloat;
            FontStyles[Col_CMPVALORCIVA,i]:=[fsBold];
            FontStyles[Col_CMPDESCricao,i]:=[fsBold];
        end;




        Ints[Col_CMPID_Cliente,i]:=FLISTADOCUMENTOSEnc.davalor('id_entidade').asinteger;
        cells[Col_CMPCONTACBL,i]:=FLISTADOCUMENTOSEnc.davalor('ContaCBLProd').asstring;
        cells[Col_CMPCONTACBLIVA,i]:=FLISTADOCUMENTOSEnc.davalor('contaCblIVA').asstring;
       If  FLISTADOCUMENTOSEnc.davalor('Tipomovimento').asinteger=0 then
        begin

            cells[Col_CMPCONTACBL,i]:=FLISTADOCUMENTOSEnc.davalor('ContaCBLProd').asstring;
            cells[Col_CMPCONTACBLIVA,i]:=FLISTADOCUMENTOSEnc.davalor('contaCblIVA').asstring;
            If  cells[Col_CMPCONTACBL,i]='' then
            begin
              Colors[Col_CMPCONTACBL,i]:=clred;
              FcontasPorConfigurarEnc:=true;
            end;
            If  cells[Col_CMPCONTACBLIVA,i]='' then
            begin
              Colors[Col_CMPCONTACBLIVA,i]:=clred;
              FcontasPorConfigurarEnc:=true;
            end;


        end

        else
        begin
            cells[Col_CMPCONTACBL,i]:=FLISTADOCUMENTOSEnc.davalor('ContaCBLPAG').asstring;
            If  cells[Col_CMPCONTACBL,i]='' then
            begin
                  Colors[Col_CMPCONTACBL,i]:=clred;
            end;
        end;
        rowcount:=rowcount+1;
        Inc(i);
      end;
        FLISTADOCUMENTOSEnc.seguinte;

     end;
     If Assigned(DadosNos) Then
     Begin
          For i:=0 to DadosNos.Num-1 Do
            GrelhaEnc.AddNode(DadosNos.elem[i].Posicao, DadosNos.elem[i].NumFilhos);
     End;

   end
   else
     sb.Dialogos.SBMessage('Não existem documentos de Encomendas para exportar!');
  If TotNDocs>0 then
  begin
   tssbEncomendas.Caption:='Encomendas: '+inttostr(TotNDocs);
   tssbEncomendas.TabAppearance.Font.Size:=12;
   tssbEncomendas.TabAppearance.Font.Style:=[fsbold];
  end;
end;

procedure TFRMERPExportCompras.BtexpEncomendasClick(Sender: TObject);
begin
If  assigned(FLISTADOCUMENTOSEnc) then
 begin

    If Not(FcontasPorConfigurarEnc) then
    begin
        If ExportarEncomendas(FLISTADOCUMENTOSEnc) then
        begin
         If   FPrimeiraExportacaoEnc=true  then
         begin
           sb.SBBD.Executa('update ERP_EMPRESAINTERFACE set DataIniExpEncomendas ='+sb.UtilSQL.DataToSQLData(dtdataInicio.date)
            +' where id_interface=3');
         end;
         MarcaEncomendasComoExportados(dtdataInicioEnc.date,dtdatafimEnc.date,FLISTADOCUMENTOSEnc,'ERPIntegration');
         RegistaLogOperacao('Operação:Exportação Encomendas SYSController');
         gbDataEnc.enabled:=false;
         LimpaGrelhaEnc;
        end;
    end
    else
    begin
      sb.Dialogos.SBMessage('Não é possível exportar-encomendas!'+#13+'Verifique as Contas ERP.');
    end;
 end;

end;

end.
