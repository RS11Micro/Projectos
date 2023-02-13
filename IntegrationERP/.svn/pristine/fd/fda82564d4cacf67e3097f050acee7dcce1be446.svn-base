unit ERP_FrmExportVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, AdvEdit, AdvMEdBtn, PlannerMaskDatePicker,System.StrUtils,
  AdvGroupBox, ActnList, AdvOfficeButtons, Grids, AdvObj, BaseGrid,Sbbotoes,
  AdvGrid, AdvOfficePager, ExtCtrls, AdvPanel, AdvToolBar,dateutils,sbcontrolos,
  ERPOperInterfaceFnt,sbbetabeladados, SBEditProcura,sblista,ERPBEEMPRESAINTERFACE,
  ierpListasDef,ERPLogOperacoes,menus, AdvUtil, System.Actions,
  Data.Bind.Components,
   REST.Utils,
  REST.Types,
  REST.Client,
  REST.Response.Adapter,
  REST.Authenticator.Simple,
  REST.Authenticator.Basic,
  REST.Authenticator.OAuth,
  Data.Bind.ObjectScope, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;






type
  TFrm_ERPExportVendas = class(TForm)
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
    dtdataFim: TPlannerMaskDatePicker;
    Label4: TLabel;
    procedure BtExportarClick(Sender: TObject);
    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure epCentroExploracaoBtListaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtActualizarClick(Sender: TObject);
    procedure GrelhaVENDASGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure btLimparClick(Sender: TObject);
    procedure AccontrairExecute(Sender: TObject);
    procedure acexpandirExecute(Sender: TObject);
    procedure GrelhaVENDASGetFloatFormat(Sender: TObject; ACol,
      ARow: Integer; var IsFloat: Boolean; var FloatFormat: String);
  private
    { Private declarations }
    FcontasPorConfigurar:Boolean;
    FLISTADOCUMENTOS:TSBBETABELADADOS;
   Function  PreencheVariaveisGerais():Boolean;
   procedure PreencheGRELHA;

   Procedure SeleccionaCentroExploracao(Sender :TObject);
   Procedure AntesAbrirListaCexploracao(Sender :TObject;var pAbreLista:boolean);
   Procedure Inicializaform;
   Procedure FormataGrelhaVendas;
   Procedure ListaVaziaCexploracao(Sender :TObject;var pAbreLista:boolean);
   procedure LimpaGrelha;
   Function  TrataContaCblProduto(pid_produto:string):string;
   procedure OAuth2_Toconline_BrowserTitleChanged(const ATitle: string; var DoCloseWebView: boolean);
  public
    { Public declarations }
    Procedure AbreFormulario;

  end;

var
  Frm_ERPExportVendas: TFrm_ERPExportVendas;

implementation
uses iERPOglobais,REST.Authenticator.OAuth.WebForm.Win,FNTUTILGrelha, SBBSSistemaBase, SBBSUtilSQL,IERPFrmPrincipal,

  System.UITypes, System.JSON, REST.Json;
var

FID_cLienteIndiferenciado:string;


Const
  Col_VDArv=0;
  Col_VDDESCricao=1;
  Col_VDQtd=2;
  Col_VDVALOR=3;
  Col_VDTXIVA=4;
  Col_VDCONTACBL=5;
  Col_VDCONTACBLIVA=6;

  COL_VDTLTOTAL=7;
  COL_VDTOTALIVA=8;
  COL_VDTipoArt=9;

  COL_CODIGOUNIDADEVENDA=10;
  COL_CODIGOUNIDADEBASE=11;
  COl_AreaNegocio=12;
  COl_ContaAreaNegocio=13;

  COl_Grupo=14;
  COl_Familia=15;
  COl_SubFamilia=16;


  COL_FATORCONVERSAO=17;
  COL_DESCRICAOUNIDADEVENDA=18;
  COL_DESCRICAOUNIDADEBASE=19;

  Col_VDID_Cliente=20;
  Col_VDID_Vndcabdocumento=21;
  Col_VDMaxCols=22;



{$R *.dfm}

Procedure TFrm_ERPExportVendas.FormataGrelhaVendas;
Var
  item: TMenuItem;
  i:integer;
  strEstado:string;
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
    ColWidths[Col_VDCONTACBLIVA] := 80;
    ColWidths[Col_VDID_cliente] := 0;

    ColWidths[COL_VDTLTOTAL] := 80;
    ColWidths[COL_VDTOTALIVA] := 80;
    ColWidths[COL_VDTipoArt] := 30;



    ColWidths[COL_CODIGOUNIDADEVENDA] := 45;
    ColWidths[COL_CODIGOUNIDADEBASE] := 45;
    ColWidths[COL_DESCRICAOUNIDADEVENDA] := 0;
    ColWidths[COL_DESCRICAOUNIDADEBASE] := 0;
    ColWidths[COL_FATORCONVERSAO] := 60;
     ColWidths[COl_AreaNegocio] := 65;
     ColWidths[COl_ContaAreaNegocio] := 45;
    ColWidths[COl_Grupo]:=200;
    ColWidths[COl_Familia]:=200;
    ColWidths[COl_SubFamilia]:=200;








 {   ColWidths[COL_VDDescricao]:= Width - ColWidths[COL_VDTipoArt] -ColWidths[Col_VDCONTACBLIVA]-ColWidths[Col_VDArv] -ColWidths[Col_VDTXIVA]-
    ColWidths[Col_VDCONTACBL]- ColWidths[Col_VDVALOR]- ColWidths[Col_VDQtd]-
    ColWidths[COL_VDTLTOTAL]-    ColWidths[COL_VDTOTALIVA]- ColWidths[COL_VDID_VndCabdocumento]-

    ColWidths[COL_CODIGOUNIDADEVENDA] -
    ColWidths[COL_CODIGOUNIDADEBASE] -
    ColWidths[COL_DESCRICAOUNIDADEVENDA] -
    ColWidths[COL_DESCRICAOUNIDADEBASE] -
    ColWidths[COL_FATORCONVERSAO]-     ColWidths[COl_AreaNegocio]-
     ColWidths[COl_ContaAreaNegocio]-

    21;}


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+ [goColsizing];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;

    ControlLook.NoDisabledButtonLook:=True;



    Cells[COl_AreaNegocio, 0] := SB.Idioma.daTraducao(0, 'Desc.Area');
    Cells[COl_ContaAreaNegocio, 0] := SB.Idioma.daTraducao(0, 'Area ERP');

    Cells[Col_VDDESCricao, 0] := SB.Idioma.daTraducao(42, 'Descrição');
    Cells[Col_VDTXIVA, 0] := SB.Idioma.daTraducao(0, 'IVA');
    Cells[Col_VDCONTACBL, 0] := SB.Idioma.daTraducao(0, 'CONTA ERP');
    Cells[Col_VDCONTACBLIVA, 0] := SB.Idioma.daTraducao(0, 'CONTA IVA ERP');
    Cells[Col_VDQtd, 0] := SB.Idioma.daTraducao(0, 'QTD');
    Cells[Col_VDvalor, 0] := SB.Idioma.daTraducao(0, 'Valor');

    Cells[COL_VDTLTOTAL, 0] := SB.Idioma.daTraducao(0, 'TOTAL');
    Cells[COL_VDTOTALIVA, 0] := SB.Idioma.daTraducao(0, 'TOTAL IVA');

    Cells[COL_VDTipoArt, 0] := SB.Idioma.daTraducao(0, 'T.Art.');

    Cells[COL_CODIGOUNIDADEVENDA, 0] := SB.Idioma.daTraducao(0, 'Un.Vnd');
    Cells[COL_CODIGOUNIDADEBASE, 0] := SB.Idioma.daTraducao(0, 'Un.Base');
    Cells[COL_FATORCONVERSAO, 0] := SB.Idioma.daTraducao(0, 'Fact.Conv.');

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

Procedure TFrm_ERPExportVendas.Inicializaform;
var Ano, Mes, Dias: Integer;
data:tdatetime;
Begin
//  FormataFormPorDefeito(self); ao formatar advstringgrid fico sem titulos nas colunas
  FormataBotoes(self);
  Data := SB.Empresa.DataTrabalho;
  Ano:=YearOf(data);
  dtdataInicio.Date:= EncodeDate(Ano,1,1);
  PreencheVariaveisGerais;  
  FormataGrelhaVendas;
end;

Procedure TFrm_ERPExportVendas.AbreFormulario;
begin
 Inicializaform;
 showmodal;
end;

procedure TFrm_ERPExportVendas.BtExportarClick(Sender: TObject);
begin
 BtExportar.Enabled:=false;
 screen.cursor:=crhourglass;
 Try
     If  assigned(FLISTADOCUMENTOS) then
     begin
        FcontasPorConfigurar:=false;
        If Not(FcontasPorConfigurar) then
        begin
            If ExportarVendas(FLISTADOCUMENTOS) then
            begin
             RegistaLogOperacao('Operação:Exportação Vendas SYSPOS');
             LimpaGrelha;
            end;
        end
        else
        begin
          sb.Dialogos.SBMessage('Não é possível exportar!'+#13+'Verifique as Contas ERP.');
        end;
     end;
 Finally
  BtExportar.Enabled:=true;
   screen.cursor:=crDefault;
 end;
end;

procedure TFrm_ERPExportVendas.OAuth2_Toconline_BrowserTitleChanged(const ATitle: string; var DoCloseWebView: boolean);
begin

end;

procedure TFrm_ERPExportVendas.BtsairClick(Sender: TObject);
begin
 self.close;
end;


procedure TFrm_ERPExportVendas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFrm_ERPExportVendas.epCentroExploracaoBtListaClick(

  Sender: TObject);
begin
Listas.AbrirSQL('ListaCentroExploracao','', SeleccionaCentroExploracao,AntesAbrirListaCexploracao,ListaVaziaCexploracao);
end;

Procedure TFrm_ERPExportVendas.ListaVaziaCexploracao(Sender :TObject;var pAbreLista:boolean);
begin
  pAbreLista:=false;
  sb.Dialogos.SBAviso('Não existem c.exploração com interface "Primavera_ERP_VND" ativos!');
end;

Procedure TFrm_ERPExportVendas.SeleccionaCentroExploracao(Sender :TObject);
Begin
end;

Procedure TFrm_ERPExportVendas.AntesAbrirListaCexploracao(Sender :TObject;var pAbreLista:boolean);
var
     FsbLista:TSBBETabelaDados;
begin
end;


procedure TFrm_ERPExportVendas.FormCreate(Sender: TObject);
begin
 FormataFormPorDefeito(self);
 FormataBotoes(self);
 FLISTADOCUMENTOS:=nil;
 Top:=FrmIERPPrincipal.MenuOpcoes.Height+20;

end;

procedure TFrm_ERPExportVendas.PreencheGRELHA;
var
   Filtro:string;
   i:Integer;
   DadosNos :TDadosnos;
   TotNDocs:Integer;
   TotalVendas,TotalCreditos:extended;
   dataInicio,datafim:Tdatetime;
   segue:Boolean;
   SysObjInterface:TERPBEEMPRESAINTERFACE;

begin
   SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
   segue:=false;
   FcontasPorConfigurar:=false;
   TotNDocs:=0;
   TotalVendas:=0;
   TotalCreditos:=0;
   dataInicio:=SysObjInterface.DATAInicioExportacao;
   datafim:=0;
   DadosNos := TDadosnos.create;
   i:=1;
   If assigned(FLISTADOCUMENTOS) then
   begin
    Freeandnil(FLISTADOCUMENTOS);
   end;
   IF ERPOperInterfacefnt.FOBJInterface.IDSCentrosExploracao<>'' THEN
        Filtro:='Vndcabdocumento.id_centroExploracao in('+ERPOperInterfacefnt.FOBJInterface.IDSCentrosExploracao+')';
  If gbsbData.visible=true then
   If filtraMaskData(dtdataInicio)>0 Then
   begin
       DataInicio:= dtdataInicio.date;
       If filtraMaskData(dtdataFim)>0 Then
       begin
        datafim:= dtdataFim.date;
       end;

   end;



   FLISTADOCUMENTOS:=ERPOperInterfacefnt.DaListaDocumentosPorExportar(Filtro,DataInicio,DataFim,SysObjInterface.PrefixoContCblAartigo);
   If FLISTADOCUMENTOS<>nil then
    If Not FLISTADOCUMENTOS.Vazia then
       segue:=true;

   if segue =true then
   begin
     While Not FLISTADOCUMENTOS.nofim do
     begin
      with GrelhaVENDAS do
      begin
        If  (Not(ExisteNo(IntTostr(FLISTADOCUMENTOS.davalor('ID_VndCabdocumento').asinteger),DadosNos))) Then
        Begin
             Inc(TotNDocs);
              If  FLISTADOCUMENTOS.davalor('TipoOperacao').asstring='0' then
                    TotalVendas:=TotalVendas+FLISTADOCUMENTOS.davalor('valortotal').asFloat
              else
                TotalCreditos:=TotalCreditos+abs(FLISTADOCUMENTOS.davalor('valortotal').asFloat);
              IncrementaNos(FLISTADOCUMENTOS.davalor('ID_VndCabdocumento').asstring, i, DadosNos);
              cells[Col_VDDESCricao,i]:=FLISTADOCUMENTOS.davalor('Tipodoc').asstring+'\'+FLISTADOCUMENTOS.davalor('Serie').asstring+
                      ' Nº'+ FLISTADOCUMENTOS.davalor('ID_documento').asstring+
                      ' Data:'+ FLISTADOCUMENTOS.davalor('Data').asstring+ ' '+ FLISTADOCUMENTOS.davalor('NomeCliente').asstring;

              If FLISTADOCUMENTOS.davalor('contaCblCliente').asstring<>'' then
                   cells[Col_VDDESCricao,i]:=cells[Col_VDDESCricao,i]+' Nr Cliente: '+ FLISTADOCUMENTOS.davalor('contaCblCliente').asstring
              else
              If FID_clienteIndiferenciado<>'' then
                   cells[Col_VDDESCricao,i]:=cells[Col_VDDESCricao,i]+' Nr Cliente: '+ FID_clienteIndiferenciado
              else
              cells[Col_VDDESCricao,i]:=cells[Col_VDDESCricao,i]+' Nr Cliente: ';


              Floats[COL_VDTLTOTAL, i] := FLISTADOCUMENTOS.davalor('valortotal').asFloat;
              Floats[COL_VDTOTALIVA, i] := FLISTADOCUMENTOS.davalor('TOTALIVA').asFloat;


              cells[Col_VDCONTACBL,i]:=FLISTADOCUMENTOS.davalor('ContaCBLTDOC').asstring;
              Ints[Col_VDID_Cliente,i]:=FLISTADOCUMENTOS.davalor('id_entidade').asinteger;
              Colors [Col_VDCONTACBL,i]:=clWindow;
              If cells[Col_VDCONTACBL,i]='' then
              begin
                 Colors [Col_VDCONTACBL,i]:=clred;
                 FcontasPorConfigurar:=true;
              end;
              MergeCells(Col_VDDESCricao,i,4,1);
              Ints[COL_VDID_VndCabdocumento,i]:=FLISTADOCUMENTOS.davalor('ID_VndCabdocumento').asinteger;
              RowColor[i] := clInfoBk;
              rowcount:=rowcount+1;
              Inc(i);
        end;
        IncrementaNos(FLISTADOCUMENTOS.davalor('ID_VndCabdocumento').asstring, i, DadosNos);
        cells[Col_VDDESCricao,i]:=FLISTADOCUMENTOS.davalor('DescricaoProduto').asstring;
        floats[Col_VDQtd,i]:=FLISTADOCUMENTOS.davalor('Quantidade').asfloat;
        cells[COL_VDTipoArt,i]:=FLISTADOCUMENTOS.davalor('TipoArtigoERP').asstring;
        floats[Col_VDVALOR,i]:=FLISTADOCUMENTOS.davalor('Valor').asfloat;
        cells[Col_VDTXIVA,i]:=FLISTADOCUMENTOS.davalor('percentagemIVA').asstring+'%';
        Ints[Col_VDID_Cliente,i]:=FLISTADOCUMENTOS.davalor('id_entidade').asinteger;


        Cells[COl_Grupo, i] := FLISTADOCUMENTOS.davalor('GrupoFamilia').asstring;
        Cells[COl_Familia, i] := FLISTADOCUMENTOS.davalor('Familia').asstring;
        Cells[COl_subFamilia, i] := FLISTADOCUMENTOS.davalor('subFamilia').asstring;


        If  FLISTADOCUMENTOS.davalor('Tipomovimento').asinteger=0 then
        begin

            cells[COL_CODIGOUNIDADEVENDA,i]:=FLISTADOCUMENTOS.davalor('CodUnvenda').asstring;
            cells[COL_CODIGOUNIDADEBASE,i]:=FLISTADOCUMENTOS.davalor('CodUnBase').asstring;
            cells[COL_FATORCONVERSAO,i]:=FLISTADOCUMENTOS.davalor('factorconversao').asstring;

            cells[Col_VDCONTACBL,i]:=FLISTADOCUMENTOS.davalor('ContaCBLProd').asstring;
            cells[Col_VDCONTACBLIVA,i]:=FLISTADOCUMENTOS.davalor('contaCblIVA').asstring;

            Cells[COl_AreaNegocio, i] :=FLISTADOCUMENTOS.davalor('DescAreaNegocio').asstring;
            Cells[COl_ContaAreaNegocio, i] :=FLISTADOCUMENTOS.davalor('AreaNegocio').asstring;

            If FOBJInterface.ObgLinhaContaERPProd=true then
            begin
                If  cells[Col_VDCONTACBL,i]='' then
                begin
                  Colors[Col_VDCONTACBL,i]:=clred;
                  FcontasPorConfigurar:=true;
                end;
            end;
            If FOBJInterface.ObgLinhaContaERPIVA=true then
            begin
                If  cells[Col_VDCONTACBLIVA,i]='' then
                begin
                  Colors[Col_VDCONTACBLIVA,i]:=clred;
                  FcontasPorConfigurar:=true;
                end;
            end;
        end

        else
        begin
            cells[Col_VDCONTACBL,i]:=FLISTADOCUMENTOS.davalor('ContaCBLPAG').asstring;
            cells[Col_VDTXIVA,i]:='';
            If FOBJInterface.ObgLinhaContaERPModPag=true then
            begin
                If  cells[Col_VDCONTACBL,i]='' then
                begin
                      Colors[Col_VDCONTACBL,i]:=clred;
                end;
           end;
        end;



        rowcount:=rowcount+1;
        Inc(i);
      end;
        FLISTADOCUMENTOS.seguinte;

     end;
     If Assigned(DadosNos) Then
     Begin
          For i:=0 to DadosNos.Num-1 Do
            GrelhaVENDAS.AddNode(DadosNos.elem[i].Posicao, DadosNos.elem[i].NumFilhos);
     End;

   end
   else
     sb.Dialogos.sBConfirmacao('Não existem documentos de venda para exportar!');
  StTotalDocs.caption:=IntTostr(TotNDocs);
  StTotalVendas.caption:=FormatFloat('0.00',TotalVendas);
  StTotalCreditos.caption:=FormatFloat('0.00',TotalCreditos);

end;

Function TFrm_ERPExportVendas.TrataContaCblProduto(pid_produto:string):string;
var
mProduto:string;
contador:integer;
  minterface:TERPBEEMPRESAINTERFACE;
Begin
   minterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
   mProduto:=pid_produto;
   if length(pid_produto)>=4 then
     result:=minterface.PrefixoContCblAartigo+pid_produto
   else
   begin
     contador:= length(pid_produto);
     while contador<4 do
     begin
       mProduto:='0'+mProduto;
       inc(contador);
     end;
          result:=minterface.PrefixoContCblAartigo+mProduto;
   end;
   if assigned(minterface) then
    freeandnil(minterface);
end;


Function TFrm_ERPExportVendas.PreencheVariaveisGerais():Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
 mensagem:string;
begin
  result:=false;



  FID_clienteIndiferenciado:='';
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
  If assigned(ObjInterface) then
  begin
       Result:=True;
       ERPOperInterfaceFNT.FOBJInterface:=MotorERP.ERPInterface.Clone(ObjInterface);
       FID_clienteIndiferenciado:= ObjInterface.ID_clienteIndiferenciado;

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

       If mensagem='' then
       begin
            dtdataInicio.date:= ObjInterface.DATAInicioExportacao;
            IF ERPOperInterfacefnt.TemExportacoes(mensagem) then
               gbsbData.Visible:=false ;



           gbsbData.visible:=Uppercase(sb.UtilizadorActual.Login)='MICRONET';



       end;



       If mensagem<>'' then
       begin
        Result:=false;
        sb.Dialogos.SBMessage(mensagem+#13+'Verifique as Configurações do Interface!');
        BtActualizar.enabled:=false;
        BtExportar.Enabled:=false;
       end;
       if result=true then
            CarregaListasSyscontroller(ObjInterface.BDConexao);
        freeandnil(ObjInterface);
  end
  else
  begin
   result:=false;
   sb.Dialogos.SBMessage('Não existe interface: "ERP_VENDASSYSCONTROLLER" Ativo!');
   BtActualizar.enabled:=false;
   BtExportar.Enabled:=false;
  end;

end;


procedure TFrm_ERPExportVendas.BtActualizarClick(Sender: TObject);
begin
 screen.cursor:=crhourglass;
 Try
         if assigned(FLISTADOCUMENTOS) then
         begin
             FLISTADOCUMENTOS.Fecha;
             Freeandnil(FLISTADOCUMENTOS);
         end;
         LimpaGrelha;
         PreencheGRELHA;
 Finally
   screen.cursor:=crDefault;
 end;
end;

procedure TFrm_ERPExportVendas.GrelhaVENDASGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ARow>0) And (ACOL in[Col_VDQtd, Col_VDVALOR,COL_VDTOTALIVA]) then
    HAlign:=taRightJustify;


end;


procedure TFrm_ERPExportVendas.LimpaGrelha;
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
  StTotalVendas.caption:='';
  StTotalCreditos.caption:='';
  StTotalDocs.caption:='';    
end;


procedure TFrm_ERPExportVendas.btLimparClick(Sender: TObject);
begin
  StTotalDocs.caption:=IntTostr(0);
  StTotalVendas.caption:=FormatFloat('0.00',0);
  StTotalCreditos.caption:=FormatFloat('0.00',0);
  LimpaGrelha;
  FLISTADOCUMENTOS.Fecha;
  Freeandnil(FLISTADOCUMENTOS);
end;

procedure TFrm_ERPExportVendas.AccontrairExecute(Sender: TObject);
begin
 GrelhaVENDAS.ContractAll;
end;

procedure TFrm_ERPExportVendas.acexpandirExecute(Sender: TObject);
begin
 GrelhaVENDAS.ExpandAll;
end;

procedure TFrm_ERPExportVendas.GrelhaVENDASGetFloatFormat(Sender: TObject;
  ACol, ARow: Integer; var IsFloat: Boolean; var FloatFormat: String);
begin
    isfloat:=false;
  If (aCol= COL_FATORCONVERSAO)then
  begin
    isfloat:=true;
    FloatFormat:='%.4f';
  end;


end;

end.
