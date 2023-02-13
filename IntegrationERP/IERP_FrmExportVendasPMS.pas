unit IERP_FrmExportVendasPMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, AdvEdit, AdvMEdBtn, PlannerMaskDatePicker,
  AdvGroupBox, ActnList, AdvOfficeButtons, Grids, AdvObj, BaseGrid,Sbbotoes,
  AdvGrid, AdvOfficePager, ExtCtrls, AdvPanel, AdvToolBar,dateutils,sbcontrolos,
  ERPOperInterfaceProtel,sbbetabeladados, SBEditProcura,sblista
  ,ERPBEEMPRESAINTERFACE,ERPLogOperacoes,fntbeapoio,menus, DB, ADODB,
  DBAdvGrid, AdvUtil, System.Actions;

type
  TFrm_IERPExportVendasPMS = class(TForm)
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    BtExportar: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    btLimpar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    AdvOfficePager1: TAdvOfficePager;
    tssbDocVendas: TAdvOfficePage;
    GrelhaVENDAS: TAdvStringGrid;
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
    gbsbData: TAdvGroupBox;
    lbsbInicio: TLabel;
    dtdataInicio: TPlannerMaskDatePicker;
    Label3: TLabel;
    ephotel: TSBEditProcura;
    Label5: TLabel;
    tsbbadiantamentos: TAdvOfficePage;
    Ds_adiant: TDataSource;
    conProtel: TADOConnection;
    Qadiantamentos: TADOQuery;
    gridadint: TDBAdvGrid;
    grpndoc: TAdvGroupBox;
    Label6: TLabel;
    edndoc: TEdit;
    dtdataFim: TPlannerMaskDatePicker;
    Label4: TLabel;
    procedure BtExportarClick(Sender: TObject);
    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ephotelBtListaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtActualizarClick(Sender: TObject);
    procedure GrelhaVENDASGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure btLimparClick(Sender: TObject);
    procedure AccontrairExecute(Sender: TObject);
    procedure acexpandirExecute(Sender: TObject);
    procedure GrelhaVENDASGetFloatFormat(Sender: TObject; ACol,
      ARow: Integer; var IsFloat: Boolean; var FloatFormat: String);
    procedure FormShow(Sender: TObject);
    procedure AdvToolBarButton1Click(Sender: TObject);
  private
    { Private declarations }
    FcontasPorConfigurar:Boolean;
    FLISTADOCUMENTOS:TSBBETABELADADOS;
    fTipoPesquisa:integer;
    Function  PreencheVariaveisGerais():Boolean;
    Procedure SelecionaHotel(Sender :TObject);
    Procedure AntesAbrirListaCexploracao(Sender :TObject;var pAbreLista:boolean);
    Procedure Inicializaform;
    Procedure FormataGrelhaVendas;
    Procedure ListaVaziaCexploracao(Sender :TObject;var pAbreLista:boolean);
    procedure LimpaGrelha;
    procedure PreencheGRELHA;
    Function  DaIDHoteis():string;
    procedure atualizaContacblProdutosProtel;
    procedure mostraAdiantamentos;   
  public
    { Public declarations }
    Procedure AbreFormulario;
  end;

var
  Frm_IERPExportVendasPMS: TFrm_IERPExportVendasPMS;

implementation
uses IERPOglobais,FNTUTILGrelha, SBBSSistemaBase, SBBSUtilSQL,IERPFrmPrincipal,IERPListasDef,
  FntBSVndDocumento;
var
FID_clienteIndiferenciado:string;

Const
  Col_VDArv=0;
  Col_VDDESCricao=1;
  Col_VDQtd=2;
  Col_VDVALOR=3;
  Col_VDTXIVA=4;
  Col_VDCONTACBL=5;
  Col_VDCONTACBLIVA=6;
  COL_MTTLVALORBRUTO=7;
  COL_MTTLIVA=8;
  COL_VDTipoArt=9;

  COL_CODIGOUNIDADEVENDA=10;
  COL_CODIGOUNIDADEBASE=11;
  COL_FATORCONVERSAO=12;
  COL_DESCRICAOUNIDADEVENDA=13;
  COL_DESCRICAOUNIDADEBASE=14;
  COl_AreaNegocio=15;
  COl_ContaAreaNegocio=16;

  COl_Grupo=17;
  COl_Familia=18;
  COl_SubFamilia=19;



  Col_VDID_Cliente=20;
  Col_VDID_Vndcabdocumento=21;
    Col_VDDESCricaoinicial=22;
  Col_VDMaxCols=23;



{$R *.dfm}

Procedure TFrm_IERPExportVendasPMS.FormataGrelhaVendas;
Var
  i:integer;
  strEstado:string;
  item: TMenuItem;
Begin
  with GrelhaVendas do
  begin
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 1;
    RowCount := FixedRows + 1;
    ColCount := Col_VDMaxCols;

    ColWidths[Col_VDArv] := 28;
    ColWidths[Col_VDQtd] := 50;


    ColWidths[Col_VDCONTACBL] := 80;


    ColWidths[Col_VDTXIVA] := 50;
    ColWidths[Col_VDVALOR] := 80;
    ColWidths[COL_VDID_VndCabdocumento] := 0;
    ColWidths[Col_VDDESCricaoinicial] := 0;

    ColWidths[Col_VDCONTACBLIVA] := 80;
    ColWidths[Col_VDID_cliente] := 0;
    ColWidths[COL_MTTLVALORBRUTO] := 80;
     ColWidths[COL_MTTLIVA] := 80;
    ColWidths[COL_VDTipoArt] := 30;


    ColWidths[COL_CODIGOUNIDADEVENDA] := 45;
    ColWidths[COL_CODIGOUNIDADEBASE] := 45;
    ColWidths[COL_DESCRICAOUNIDADEVENDA] := 0;
    ColWidths[COL_DESCRICAOUNIDADEBASE] := 0;
    ColWidths[COL_FATORCONVERSAO] := 60;

     ColWidths[COl_AreaNegocio] := 65;
     ColWidths[COl_ContaAreaNegocio] := 45;

     ColWidths[COL_VDDescricao]:=200;
     ColWidths[COl_Grupo]:=200;
     ColWidths[COl_Familia]:=200;
     ColWidths[COl_SubFamilia]:=200;



{    ColWidths[COL_VDDescricao]:= Width - ColWidths[COL_VDTipoArt] -ColWidths[COL_MTTLVALORBRUTO]- ColWidths[COL_MTTLIVA]-
    ColWidths[Col_VDCONTACBLIVA]-ColWidths[Col_VDArv] -ColWidths[Col_VDTXIVA]-
    ColWidths[Col_VDCONTACBL]- ColWidths[Col_VDVALOR]- ColWidths[Col_VDQtd]-
                    ColWidths[COL_VDID_VndCabdocumento]-
                    ColWidths[COL_CODIGOUNIDADEVENDA] -
                    ColWidths[COL_CODIGOUNIDADEBASE] -
                    ColWidths[COL_DESCRICAOUNIDADEVENDA] -
                    ColWidths[COL_DESCRICAOUNIDADEBASE] -
                    ColWidths[COL_FATORCONVERSAO]-  ColWidths[COl_AreaNegocio]-
                             ColWidths[COl_ContaAreaNegocio]-
                    21; }




    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+ [gocolsizing];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;

    ControlLook.NoDisabledButtonLook:=True;
    Cells[Col_VDDESCricao, 0] := SB.Idioma.daTraducao(42, 'Descrição');
    Cells[Col_VDTXIVA, 0] := SB.Idioma.daTraducao(0, 'IVA');
    Cells[Col_VDCONTACBL, 0] := SB.Idioma.daTraducao(0, 'CONTA ERP');
    Cells[Col_VDCONTACBLIVA, 0] := SB.Idioma.daTraducao(0, 'CONTA IVA ERP');
    Cells[Col_VDQtd, 0] := SB.Idioma.daTraducao(0, 'QTD');
    Cells[Col_VDvalor, 0] := SB.Idioma.daTraducao(0, 'Valor');
    Cells[COL_MTTLVALORBRUTO, 0] := SB.Idioma.daTraducao(0, 'TTL Bruto');
    Cells[COL_MTTLIVA, 0] := SB.Idioma.daTraducao(0, 'TTL IVA');
    Cells[COL_VDTipoArt, 0] := SB.Idioma.daTraducao(0, 'T.Art.');
    Cells[COl_AreaNegocio, 0] := SB.Idioma.daTraducao(0, 'Desc.Area');
    Cells[COl_ContaAreaNegocio, 0] := SB.Idioma.daTraducao(0, 'Area ERP');

    Cells[COL_CODIGOUNIDADEVENDA, 0] := SB.Idioma.daTraducao(0, 'Un.Vnd');
    Cells[COL_CODIGOUNIDADEBASE, 0] := SB.Idioma.daTraducao(0, 'Un.Base');
    Cells[COL_FATORCONVERSAO, 0] := SB.Idioma.daTraducao(0, 'Fact.Conv.');


    Cells[COl_Grupo, 0] := SB.Idioma.daTraducao(0, 'Grupo');
    Cells[COl_Familia, 0] := SB.Idioma.daTraducao(0, 'Familia');
    Cells[COl_SubFamilia, 0] := SB.Idioma.daTraducao(0, 'Sub.Familia');

    

    For i:= 0 To PopupMenu.Items.Count-3 Do
      PopupMenu.Items.Delete(i);

    item:= TMenuItem.Create(GrelhaVENDAS);
    item.Action := acExpandir;
    item.Caption := 'Expandir Grelha';
    PopupMenu.Items.Insert(0,item);

    item:= TMenuItem.Create(GrelhaVENDAS);
    item.Action := acContrair;
    item.Caption :=  'Contrair Grelha';
    PopupMenu.Items.Insert(1, item);



    EndUpdate;
  end;
End;

Procedure TFrm_IERPExportVendasPMS.Inicializaform;
var Ano, Mes, Dias: Integer;
data:tdatetime;
Begin
 // FormataFormPorDefeito(self);
  FormataBotoes(self);
  Data := SB.Empresa.DataTrabalho;
  Ano:=YearOf(data);
  dtdataInicio.Date:= EncodeDate(Ano,1,1);
  tsbbadiantamentos.TabVisible:=false;
  If preencheVariaveisGerais then
  begin
    If FOBJInterface.exportaAdiantamentosPMS=true then
    begin
       conProtel.ConnectionString:= FOBJInterface.BDConexao;
       conProtel.Connected:=true;
       tsbbadiantamentos.TabVisible:=true;
       Qadiantamentos.Connection:= conProtel;
    end;
  end;
  grpndoc.Visible:=Uppercase(sb.UtilizadorActual.Login)='MICRONET';
  gbsbData.visible:=Uppercase(sb.UtilizadorActual.Login)='MICRONET';
  FormataGrelhaVendas;


end;

Procedure TFrm_IERPExportVendasPMS.AbreFormulario;
begin
 Inicializaform;
 showmodal;
end;

procedure TFrm_IERPExportVendasPMS.BtExportarClick(Sender: TObject);
var
IDSHoteis,filtro:string;
begin
Screen.cursor:=crhourGlass;
Try
  IDSHoteis:=DaIDHoteis;
  If    IDSHoteis<>'' then
  begin
   If FOBJInterface.exportaAdiantamentosPMS then
   begin
       filtro:= ' Leisthis.mpehotel IN('+IDSHoteis+')';
       ERPOperInterfaceProtel.ExportaAdiantamentos(FOBJInterface.DataIniExpAdiantamentosPMS,FOBJInterface.BDSchema,filtro);

   end;

   If  assigned(FLISTADOCUMENTOS) then
   begin
        If ERPOperInterfaceProtel.ExportarVendas(FLISTADOCUMENTOS,IDSHoteis) then
        begin
         ERPLogOperacoes.RegistaLogOperacao('Operação:Exportação vendas PMS');
         LimpaGrelha;
        end;
  end;
 end
 else
 sb.Dialogos.SBMessage('Não é possível exportar!'+#13+'Interface não tem os hoteis associados.');

Finally
 Screen.cursor:=crdefault;
end;
end;

procedure TFrm_IERPExportVendasPMS.BtsairClick(Sender: TObject);
begin
 self.close;
end;

procedure TFrm_IERPExportVendasPMS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Qadiantamentos.Close;
 conProtel.Connected:=false;

 action:=cafree;
end;

procedure TFrm_IERPExportVendasPMS.ephotelBtListaClick(

  Sender: TObject);
begin
  Listas.AbrirSQL('ListaPmsHoteis','', EpHotel, SelecionaHotel);
end;

Procedure TFrm_IERPExportVendasPMS.ListaVaziaCexploracao(Sender :TObject;var pAbreLista:boolean);
begin
  pAbreLista:=false;
  sb.Dialogos.SBAviso('Não existem c.exploração com interface "Primavera_ERP_VND" ativos!');
end;

Procedure TFrm_IERPExportVendasPMS.SelecionaHotel(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj:=TSBSelecaoLista(Sender);
       ephotel.ID_Chave:=Obj.Chave;
       ephotel.text:=Obj.ValorDescricao;

  Obj.Free;
end;

procedure TFrm_IERPExportVendasPMS.AdvToolBarButton1Click(Sender: TObject);
 begin
Screen.cursor:=crhourGlass;
fTipoPesquisa:=1;
Try
  //atualizaContacblProdutosProtel;
  If assigned(FLISTADOCUMENTOS) then
  Begin
   FLISTADOCUMENTOS.Fecha;
   Freeandnil(FLISTADOCUMENTOS);
  End;
  LimpaGrelha;
  PreencheGRELHA;
  If tsbbadiantamentos.TabVisible=true then
  begin
   mostraAdiantamentos;
  end;
Finally
 Screen.cursor:=crdefault;
end;
end;



Procedure TFrm_IERPExportVendasPMS.AntesAbrirListaCexploracao(Sender :TObject;var pAbreLista:boolean);
var
     FsbLista:TSBBETabelaDados;
begin
end;






procedure TFrm_IERPExportVendasPMS.FormCreate(Sender: TObject);
begin
 FormataFormPorDefeito(self);
 FormataBotoes(self);
 FLISTADOCUMENTOS:=nil;
 Top:=FrmIERPPrincipal.MenuOpcoes.Height+20;
end;




Function TFrm_IERPExportVendasPMS.PreencheVariaveisGerais():Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
 mensagem:string;
begin
  result:=false;
  FID_clienteIndiferenciado:='';
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
  If assigned(ObjInterface) then
  begin
       Result:=True;
       ERPOperInterfaceProtel.FOBJInterface:=MotorERP.ERPInterface.Clone(ObjInterface);
       FID_clienteIndiferenciado:= ObjInterface.ID_clienteIndiferenciado;

       If ObjInterface.BDConexao='' then
         mensagem:='Falta Conexão á Base de Dados do Hotel!';


       If mensagem='' then
       begin
           IF ERPOperInterfaceProtel.TemExportacoes(mensagem) then
             gbsbData.Visible:=false
           Else
            dtdataInicio.Date:= ERPOperInterfaceProtel.FOBJInterface.DATAInicioExportacao;
       end;


       If mensagem<>'' then
       begin
        Result:=false;
        sb.Dialogos.SBMessage(mensagem+#13+'Verifique as Configurações do Interface!');
        BtActualizar.enabled:=false;
        BtExportar.Enabled:=false;
       end;
       if result=true then
        CarregaListasProtel(ObjInterface.BDConexao,ObjInterface.BDSchema,ObjInterface.Namelinkedserver);
        freeandnil(ObjInterface);
  end
  else
  begin
   result:=false;
   sb.Dialogos.SBMessage('Não existe interface: "ERP_VENDASPROTEL" Ativo!');
   BtActualizar.enabled:=false;
   BtExportar.Enabled:=false;
  end;

end;

procedure TFrm_IERPExportVendasPMS.BtActualizarClick(Sender: TObject);
 begin
Screen.cursor:=crhourGlass;
fTipoPesquisa:=0;
Try
  //atualizaContacblProdutosProtel;
  If assigned(FLISTADOCUMENTOS) then
  Begin
   FLISTADOCUMENTOS.Fecha;
   Freeandnil(FLISTADOCUMENTOS);
  End;
  LimpaGrelha;
  PreencheGRELHA;
  If tsbbadiantamentos.TabVisible=true then
  begin
   mostraAdiantamentos;
  end;
Finally
 Screen.cursor:=crdefault;
end;
end;


procedure TFrm_IERPExportVendasPMS.mostraAdiantamentos;
var
IDSHoteis,filtro,strsql:string;
begin
  IDSHoteis:=DaIDHoteis;
  If    IDSHoteis<>'' then
  begin
   If FOBJInterface.exportaAdiantamentosPMS then
   begin
       filtro:= ' Leisthis.mpehotel IN('+IDSHoteis+')';
       strsql:=ERPOperInterfaceProtel.DaSqlAdiantamentos(FOBJInterface.DataIniExpAdiantamentosPMS,FOBJInterface.BDSchema,filtro);
       If strsql<>'' then
       begin
        Qadiantamentos.Close;
        Qadiantamentos.SQL.Clear;
        Qadiantamentos.SQL.Add(strsql);
        Qadiantamentos.Open;
       end;
   end;
  end; 

end;


procedure TFrm_IERPExportVendasPMS.atualizaContacblProdutosProtel;
var strsql:string;
  ProtelObjInterface,
  SysObjInterface:TERPBEEMPRESAINTERFACE;
  DescSchemaPms,
  DescSchemaSys:string;
begin
  ProtelObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
  SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
  DescSchemaPms:=ProtelObjInterface.BDSchema;
  DescSchemaSys:= SysObjInterface.BDSchema;
  strsql :='update artpms set artpms.gvkonto=artsys.ContaCbl  '
  +' from '+DescSchemaPms+'ArticlesPMSSYS as artpms inner join '+DescSchemaSys+'TAB_PRODUTO as artsys'
  +' on  artpms.Id_ProdutoSYS=artsys.vproduto ';
  sb.sbbd.Executa(strsql);

  if assigned(ProtelObjInterface) then
   FreeAndNil(ProtelObjInterface);
  if assigned(SysObjInterface) then
   FreeAndNil(SysObjInterface);
end;

procedure TFrm_IERPExportVendasPMS.GrelhaVENDASGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ARow>0) And (ACOL in[Col_VDQtd, Col_VDVALOR,COL_MTTLIVA,COL_MTTLVALORBRUTO]) then
    HAlign:=taRightJustify;

end;


procedure TFrm_IERPExportVendasPMS.LimpaGrelha;
VAR
  i:integer;
begin
  for i:=1 to GrelhaVENDAS.ALLRowCount-1 do
  begin
      GrelhaVENDAS.RemoveNode(i);
  end;
  GrelhaVENDAS.clearnormalcells;
  GrelhaVENDAS.rowcount:=GrelhaVENDAS.fixedrows+1;
  If assigned(FLISTADOCUMENTOS) then
  begin
   FLISTADOCUMENTOS.Fecha;
   freeandnil(FLISTADOCUMENTOS);

  end;

end;
procedure TFrm_IERPExportVendasPMS.btLimparClick(Sender: TObject);
begin
  StTotalDocs.caption:=IntTostr(0);
  StTotalVendas.caption:=FormatFloat('0.00',0);
  StTotalCreditos.caption:=FormatFloat('0.00',0);
  edNDoc.Text:='';
  LimpaGrelha;
end;

Function TFrm_IERPExportVendasPMS.DaIDHoteis():string;
var
    strsql:string;
    listaHoteis:Tsbbetabeladados;
begin
    result:='';

    If   FOBJInterface.IDSHoteis<>'' then
    begin
      Result:= FOBJInterface.IDSHoteis;
    end;

end;


procedure TFrm_IERPExportVendasPMS.PreencheGRELHA;
var
    Filtro:string;
    i,j:Integer;
    DadosNos :TDadosnos;
    TotNDocs:Integer;
    TotalVendas,TotalCreditos:extended;
    dataInicio,DataFim:Tdatetime;
    segue:Boolean;
    listContasSaco:Tsbbetabeladados;
    strsql:string;
    IDSHoteis:string;

    totaliva,valorivataxa:extended;
    ProtelObjInterface,
    SysObjInterface:TERPBEEMPRESAINTERFACE;

    ObjIVA:Tfntbeapoio;
    OBJlinhasIVA:TFntBELinhasApoio;
    OBJlinhasIVADoc:TFntBELinhasApoio;
    PosPai:integer;
    fILTRADOC:BOOLEAN;
    strFiltroDoc,BDSchemaSys:string;
begin

  OBJlinhasIVA:=nil;
  OBJlinhasIVA:=TFntBELinhasApoio.create;
  totaliva:=0;
  ProtelObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
  SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
  IDSHoteis:=DaIDHoteis;//vai buscar ao Protel os hoteis que na tabela do Protel XSEtup, tem interface configurado.
  If IDSHoteis<>'' then
  begin
   segue:=false;
   FcontasPorConfigurar:=false;
   TotNDocs:=0;
   TotalVendas:=0;
   TotalCreditos:=0;
   DataInicio:=0;
   DataFim:=0;
   DadosNos := TDadosnos.create;
   i:=1;
   If assigned(FLISTADOCUMENTOS) then
   begin
    Freeandnil(FLISTADOCUMENTOS);
   end;

   Filtro:='';
   If filtraMaskData(dtdataInicio)>0 Then
      DataInicio:= dtdataInicio.date;

   If filtraMaskData(dtdataFim)>0 Then
      DataFim:= dtdataFim.date;


   listContasSaco:=nil;
    strsql:=  'select xvalue,xsection,mpehotel from '+FOBJInterface.BDSchema+'xsetup'
        +' where xsection = ''ERP_Interface'''
            +' and xkey = ''ClienteSaco''';

    listContasSaco:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao, strsql);

   If ephotel.ID_Chave>0 then
       filtro:='x.mpehotel='+inttostr(ephotel.ID_Chave)
   else
     filtro:='x.mpehotel IN('+IDSHoteis+')';
   strFiltroDoc:='';
   BtExportar.Enabled:=true;
   IF edNDoc.Visible=true then
    If edNDoc.text<>'' then
    begin
      strFiltroDoc:=edNDoc.text;
    end;
    BDSchemaSys:=SysObjInterface.BDSchema;

    If  SysObjInterface.Namelinkedserver<>'' then
      BDSchemaSys:=SysObjInterface.Namelinkedserver+'.'+ BDSchemaSys;

   if fTipoPesquisa=0 then
   begin

   FLISTADOCUMENTOS:=ERPOperInterfaceProtel.DaListaDocumentosPorExportarNova1
   (Filtro,DataInicio,DataFim,ProtelObjInterface.PrefixoContCblAartigo,BDSchemaSys,strFiltroDoc);
   end;
   if fTipoPesquisa=1 then
   begin

   FLISTADOCUMENTOS:=ERPOperInterfaceProtel.DaListaDocumentosPorExportar
   (Filtro,DataInicio,DataFim,ProtelObjInterface.PrefixoContCblAartigo,BDSchemaSys,strFiltroDoc);
   end;

   if assigned(ProtelObjInterface) then
     FreeAndNil(ProtelObjInterface);
   if assigned(SysObjInterface) then
     FreeAndNil(SysObjInterface);

   If FLISTADOCUMENTOS<>nil then
    If Not FLISTADOCUMENTOS.Vazia then
       segue:=true;

   if segue =true then
   begin
     While Not FLISTADOCUMENTOS.nofim do
     begin
        with GrelhaVENDAS do
        begin
            If  FLISTADOCUMENTOS.davalor('TipoLinha').asinteger=1 then
            begin
                If  (Not(ExisteNo(IntTostr(FLISTADOCUMENTOS.davalor('ID_Interno').asinteger),DadosNos))) Then
                Begin
                  Inc(TotNDocs);
                  IncrementaNos(FLISTADOCUMENTOS.davalor('ID_Interno').asstring, i, DadosNos);
                   RowColor[i] := clInfoBk;
                  cells[Col_VDDESCricao,i]:=FLISTADOCUMENTOS.davalor('contacbldoc').asstring+'\'+FLISTADOCUMENTOS.davalor('Serie').asstring+' '+
                          '('+FLISTADOCUMENTOS.davalor('Code').asstring+ ' Nº '+ FLISTADOCUMENTOS.davalor('ID_documento').asstring+')'+
                          ' Data:'+ FLISTADOCUMENTOS.davalor('Data').asstring+ ' '+ FLISTADOCUMENTOS.davalor('NomeCliente').asstring;

                  cells[Col_VDDESCricaoinicial,i]:=cells[Col_VDDESCricao,i];

                  If FLISTADOCUMENTOS.davalor('contaCblCliente').asstring<>'' then
                       cells[Col_VDDESCricao,i]:=cells[Col_VDDESCricao,i]+' Nr Cliente: '+ FLISTADOCUMENTOS.davalor('contaCblCliente').asstring
                  else
                  If listContasSaco.davalor('xvalue').asstring<>'' then // tem cliente saco configurado
                  begin
                         cells[Col_VDDESCricao,i]:=cells[Col_VDDESCricao,i]+' Nr Cliente: '+listContasSaco.davalor('xvalue').asstring;
                  end
                  else
                  begin
                     cells[Col_VDDESCricao,i]:=cells[Col_VDDESCricao,i]+' Nr Cliente: ';
                     If FOBJInterface.ObgContaERPCliente=true then
                     begin
                       Colors [Col_VDDESCricao,i]:=clred;
                       FcontasPorConfigurar:=true;
                    end;
                  end;

                  cells[Col_VDCONTACBL,i]:=FLISTADOCUMENTOS.davalor('ContaCBLDOC').asstring;
                  Ints[Col_VDID_Cliente,i]:=FLISTADOCUMENTOS.davalor('id_entidade').asinteger;
                  Colors [Col_VDCONTACBL,i]:=clWindow;

                  If cells[Col_VDCONTACBL,i]='' then
                  begin
                     Colors [Col_VDCONTACBL,i]:=clred;
                     FcontasPorConfigurar:=true;
                  end;


                  floats[COL_MTTLVALORBRUTO, i] := FLISTADOCUMENTOS.davalor('TotalBruto').asfloat;


                  MergeCells(Col_VDDESCricao,i,4,1);
                  Ints[COL_VDID_VndCabdocumento,i]:=FLISTADOCUMENTOS.davalor('ID_Interno').asinteger;

                  rowcount:=rowcount+1;
                  Inc(i);
                end;
                FLISTADOCUMENTOS.seguinte;
            end;

            If  FLISTADOCUMENTOS.davalor('TipoLinha').asinteger=2 then
            begin
                IncrementaNos(FLISTADOCUMENTOS.davalor('ID_Interno').asstring, i, FLISTADOCUMENTOS.davalor('Valoriva').asfloat,DadosNos);
                floats[Col_VDQtd,i]:=FLISTADOCUMENTOS.davalor('Quant').asfloat;
                floats[Col_VDVALOR,i]:=FLISTADOCUMENTOS.davalor('Valor').asfloat;
                Ints[Col_VDID_Cliente,i]:=FLISTADOCUMENTOS.davalor('id_entidade').asinteger;
                TotalVendas:=TotalVendas+FLISTADOCUMENTOS.davalor('Valor').asfloat;
                cells[Col_VDTXIVA,i]:=FLISTADOCUMENTOS.davalor('taxaiva').asstring+'%';
                cells[Col_VDDESCricao,i]:=FLISTADOCUMENTOS.davalor('Descritivo').asstring;
                  cells[COL_VDTipoArt,i]:='S';  //por defeito é S indicações od Sr.Pedro pinheiro mail 26112018
                  If FLISTADOCUMENTOS.davalor('ProductType').asstring<>'' then
                     cells[COL_VDTipoArt,i]:=FLISTADOCUMENTOS.davalor('ProductType').asstring;
                                          

                cells[COL_CODIGOUNIDADEVENDA,i]:=FLISTADOCUMENTOS.davalor('CodUnvenda').asstring;
                cells[COL_CODIGOUNIDADEBASE,i]:=FLISTADOCUMENTOS.davalor('CodUnBase').asstring;
                Floats[COL_FATORCONVERSAO,i]:=FLISTADOCUMENTOS.davalor('factorconversao').asfloat;

                cells[Col_VDCONTACBL,i]:=FLISTADOCUMENTOS.davalor('ContaCBL').asstring;
                cells[Col_VDCONTACBLIVA,i]:=FLISTADOCUMENTOS.davalor('contaCblIVA').asstring;
                ObjIVA:=OBJlinhasIVA.ApoioDOCTaxaIVA[FLISTADOCUMENTOS.davalor('ID_Interno').asinteger,FLISTADOCUMENTOS.davalor('taxaiva').asfloat];
                If ObjIVA<>nil then
                begin
                     ObjIVA.Valor:=ObjIVA.Valor+ FLISTADOCUMENTOS.davalor('Valoriva').asfloat;
                end
                else
                begin
                   ObjIVA:=TFntBEApoio.create;
                   ObjIVA.Valor:=FLISTADOCUMENTOS.davalor('Valoriva').asfloat;
                   ObjIVA.TaxaIVA:=FLISTADOCUMENTOS.davalor('taxaiva').asfloat;
                   ObjIVA.id:=FLISTADOCUMENTOS.davalor('ID_Interno').asinteger;
                   OBJlinhasIVA.Adiciona(ObjIVA);
               end;

               Cells[COl_AreaNegocio, i] :=FLISTADOCUMENTOS.davalor('DescAreaNegocio').asstring;
               Cells[COl_ContaAreaNegocio, i] :=FLISTADOCUMENTOS.davalor('AreaNegocio').asstring;


               If FLISTADOCUMENTOS.davalor('ID_GrupoFamilia').asinteger=0 then
                Cells[COl_Grupo, i] :='LOGIS'
               else
               If FLISTADOCUMENTOS.davalor('ID_GrupoFamilia').asinteger=1 then
                Cells[COl_Grupo, i] :='F&B'

               else
               If FLISTADOCUMENTOS.davalor('ID_GrupoFamilia').asinteger=2 then
                Cells[COl_Grupo, i] :='EXTAS';

               Cells[COl_Familia, i] := FLISTADOCUMENTOS.davalor('Familia').asstring;
               Cells[COl_subFamilia, i] := FLISTADOCUMENTOS.davalor('subFamilia').asstring;



                If FOBJInterface.ObgLinhaContaERPProd=true then
                begin
                    If  cells[Col_VDCONTACBL,i]='' then
                    begin
                        Colors[Col_VDCONTACBL,i]:=clred;
                        FcontasPorConfigurar:=true;
                    end;
                end;

                If  FOBJInterface.ObgLinhaContaERPIVA=true then
                If  cells[Col_VDCONTACBLIVA,i]='' then
                begin
                    Colors[Col_VDCONTACBLIVA,i]:=clred;
                    FcontasPorConfigurar:=true;
                end;
            end
            else
            If  FLISTADOCUMENTOS.davalor('TipoLinha').asinteger=3 then
            begin
                PosPai:=IncrementaNos(FLISTADOCUMENTOS.davalor('ID_Interno').asstring, i, DadosNos);
                floats[Col_VDQtd,i]:=FLISTADOCUMENTOS.davalor('Quant').asfloat;
                floats[Col_VDVALOR,i]:=FLISTADOCUMENTOS.davalor('Valor').asfloat;
                Ints[Col_VDID_Cliente,i]:=FLISTADOCUMENTOS.davalor('id_entidade').asinteger;
                cells[Col_VDDESCricao,i]:=FLISTADOCUMENTOS.davalor('descricaopagamento').asstring;
                cells[Col_VDCONTACBL,i]:=FLISTADOCUMENTOS.davalor('payment_mechanism').asstring;
                If  FOBJInterface.ObgLinhaContaERPModPag=true then
                begin
                    If  cells[Col_VDCONTACBL,i]='' then
                    begin
                      Colors[Col_VDCONTACBL,i]:=clred;
                    end;
                end;

                //controla conta de terceiro em fatura conta corrente
                If (FLISTADOCUMENTOS.davalor('ID_ModoPagamento').asinteger=FOBJInterface.ID_PagamentoCC) then
                begin
                  If  FLISTADOCUMENTOS.davalor('ContaCBLCliente').asstring='' then
                  begin
                      If FOBJInterface.TipoCtrlCodClienteCC= 1 then  //se nao tem conta de terceiro rxporta sem conta
                      begin
                           cells[Col_VDDESCricao,PosPai]:=cells[Col_VDDESCricaoinicial,PosPai]+' Nr Cliente: ';
                      end
                      else
                      If FOBJInterface.TipoCtrlCodClienteCC= 2 then //se nao tem conta de terceiro nao deixa exportae
                      begin
                            cells[Col_VDDESCricao,PosPai]:=cells[Col_VDDESCricaoinicial,PosPai]+' Nr Cliente: ';
                            If FOBJInterface.ObgContaERPCliente=true then
                            begin
                                Colors [Col_VDDESCricao,PosPai]:=clred;
                                FcontasPorConfigurar:=true;
                            end;
                      end;
                  end;
                end;

             end;
             rowcount:=rowcount+1;
             Inc(i);
             FLISTADOCUMENTOS.seguinte;

        end;
     end;

     If Assigned(DadosNos) Then
     Begin

          For i:=0 to DadosNos.Num-1 Do
          begin
             GrelhaVENDAS.AddNode(DadosNos.elem[i].Posicao, DadosNos.elem[i].NumFilhos);
             totaliva:=0;
             OBJlinhasIVADoc:= OBJlinhasIVA.DalinhasdoID(strtoint(DadosNos.elem[i].Nome));
             If OBJlinhasIVADoc<>nil then
             begin
                for j:=0 to   OBJlinhasIVADoc.num-1 do
                begin
                   valorivataxa:=0;
                   valorivataxa:=OBJlinhasIVADoc.Elem[j].Valor;
                   valorivataxa:=MotorFnt.VndDocumento.Arredonda(valorivataxa,2);
                   TotalIVA:= TotalIVA+valorivataxa
               end;
               totaliva :=motorFnt.VndDocumento.Arredonda(TotalIVA,2);
               GrelhaVENDAS.Floats[COL_MTTLIVA,DadosNos.elem[i].Posicao]:= totaliva;
            end;
          end;
     End;

end
else
  sb.Dialogos.sbmessage('Não existem documentos de venda para exportar!');

  StTotalDocs.caption:=IntTostr(TotNDocs);
  StTotalVendas.caption:=FormatFloat('0.00',TotalVendas);

  if    listContasSaco<>nil then
  begin
   listContasSaco.fecha;
   freeandnil(listContasSaco);

  end;
end
else
    sb.Dialogos.sBConfirmacao('Problema na Configuração!'+#13+'No Interface  PMS não está configurado o Interface ERP.');
end;

procedure TFrm_IERPExportVendasPMS.AccontrairExecute(Sender: TObject);
begin
 GrelhaVENDAS.ContractAll;
end;

procedure TFrm_IERPExportVendasPMS.acexpandirExecute(Sender: TObject);
begin
 GrelhaVENDAS.ExpandAll;
end;

procedure TFrm_IERPExportVendasPMS.GrelhaVENDASGetFloatFormat(
  Sender: TObject; ACol, ARow: Integer; var IsFloat: Boolean;
  var FloatFormat: String);
begin
    isfloat:=false;
  If (aCol= COL_FATORCONVERSAO)then
  begin
    isfloat:=true;
    FloatFormat:='%.4f';
  end

end;

procedure TFrm_IERPExportVendasPMS.FormShow(Sender: TObject);
begin
 grpndoc.Visible:=Uppercase(sb.UtilizadorActual.Login)='MICRONET';
 gbsbData.visible:=Uppercase(sb.UtilizadorActual.Login)='MICRONET';

end;

end.
