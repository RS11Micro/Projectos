unit FntFrmIntPrimaveraCBL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SBfrmBase, AdvOfficeButtons, StdCtrls, Grids, AdvObj, BaseGrid,
  AdvGrid, AdvOfficePager, Mask, AdvEdit, AdvMEdBtn, PlannerMaskDatePicker,
  AdvGroupBox, ExtCtrls, AdvPanel, AdvToolBar,Sbbotoes,SBcontrolos,menus,SBBETaBElaDados,
  FntBeFntInterfaceCenExp, AdvEdBtn,
   AdvDirectoryEdit,FntBeTipoCons,FntUtilGrelha,inifiles, ActnList,
  PlannerDatePicker,adodb, AdvProgressBar, DB, DBAdvGrid, Buttons,
  SBEditProcura ,sblista,FNTIntfPrimaveraRecCBL0900,
  pngimage,SBBEExcepcoes,ERPBEEMPRESAINTERFACE,CBLOperInterfaceFNT,
  AdvMemo,FNTIntfPrimaveraCBL0900,ERPLogOperacoes,DateUtils,
  AdvSmoothMessageDialog;
                                     
type
  TFrmFntIntPrimaveraCBL = class(TSBFormBase)
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    BtExportarvendas: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    btLimpar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvPanel1: TAdvPanel;
    TSSbPage: TAdvOfficePager;
    tssbDocVendas: TAdvOfficePage;
    Grelha: TAdvStringGrid;
    tssbImpressao: TAdvOfficePage;
    GroupBox1: TGroupBox;
    LbsbRelatorio: TLabel;
    cmbRelatorios: TComboBox;
    cbsbVisualizar: TAdvOfficeCheckBox;
    ActionList1: TActionList;
    acExportar: TAction;
    acactualizar: TAction;
    PopupMenu1: TPopupMenu;
    Contrair1: TMenuItem;
    Expandir1: TMenuItem;
    AdvPanel3: TAdvPanel;
    QTotais: TADOQuery;
    DataSource1: TDataSource;
    QVendasProtel: TADOQuery;
    acExpRecibos: TAction;
    poprec: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Detalhe1: TMenuItem;
    GrpMercado: TAdvGroupBox;
    EdExtra: TEdit;
    Label5: TLabel;
    edInter: TEdit;
    Label4: TLabel;
    edNacional: TEdit;
    Label3: TLabel;
    AdvPanel4: TAdvPanel;
    Progresso: TAdvProgressBar;
    ephotel: TSBEditProcura;
    AdvOfficePage1: TAdvOfficePage;
    mmObservacoes: TAdvMemo;
    PanelTotVendas: TAdvPanel;
    l: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    StTotalVendas: TStaticText;
    StTotalDocs: TStaticText;
    StTotalCreditos: TStaticText;
    gbData: TAdvGroupBox;
    lbsbInicio: TLabel;
    lbsbFim: TLabel;
    dtdatainicio: TPlannerMaskDatePicker;
    DtDatafim: TPlannerMaskDatePicker;
    grpndoc: TAdvGroupBox;
    edndoc: TEdit;
    MensagemInformacao: TAdvSmoothMessageDialog;
    Label6: TLabel;
    CbExportaoqueconsegue: TAdvOfficeCheckBox;
    Tssberros: TAdvOfficePage;
    memoErros: TAdvMemo;
    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtActualizarClick(Sender: TObject);
    procedure GrelhaGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure BtExportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acExportarExecute(Sender: TObject);
    procedure AdvToolBarButton3Click(Sender: TObject);
    procedure acactualizarExecute(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure Contrair1Click(Sender: TObject);
    procedure Expandir1Click(Sender: TObject);

    procedure GrelhaRecGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure EpHotelBtEliminarClick(Sender: TObject);

  private
    { Private declarations }
 {   FRefleteClasseIva,
   FRefleteAnalitica,
   FRefleteCentroCusto:string;  }
   FPrimeiraExportacao:boolean;
   FLista:TSBBETAbeladados;

   FConnectionString:string;
   FShema:string;
   FtipoLicenca:Integer;

   FConfPorTipoDoc:boolean;
   FContasMalConfiguradas:Boolean;
   FContasMalConfiguradasRec:Boolean;
   FErroConfPagamentos:string;
   FErroConfContas:string;
   FErroConfPagamentosRC:string;
   FListaErroConfPagamentos:tstringList;
   FListaErroConfContas:tstringList;
   FListaContasMercado:TSBBETabelaDados;
   FExportaVendas,
   FExportaRecibos:boolean;
   FIDInterface:integer;
   FVendasProtel,FVendasPrimavera:string;
   FOBJInterface:TERPBEEMPRESAINTERFACE;


   FFaltaConfContasProd,
   FFaltaConfContasIVAS,
   FFaltaConfContasClasseIVA,
   FFaltaConfContasPag:Boolean;
   FComprasEstadoAberto:Integer;

   Function ValidaLicenca(pmpehotel:string;ptipoLicenca:Integer; var avisos:string):boolean;
   Function dataDocumentoEntreDatasFiltro(pDataDoc:Tdatetime):Boolean;
   Function DaMercado(pID_Pais:integer):integer;
   Procedure LimpaGrelhas;
   procedure AtualizaGrelhatotais;

   Procedure SelecionaTipodoc(Sender :TObject);

   Function  InterfaceCBLValido():Boolean;
   Procedure InicializaForm ;
   Procedure FormataGrelha;
   Function Preenchegrelha():TSBBETabelaDados;
   procedure RemoveNodes;
    Function GeraFicheiroPrimavera(var pNomeficheiro:string):boolean;


    Procedure AdicionaLinhaValorSemIVa(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
    Procedure AdicionaLinhaValorPagamento(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
    Procedure AdicionaLinhaValorDOIVa(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);

    procedure AdicionaLinhaCentroCusto(pListaDados:TSBBETabelaDados; var pid_Linha:integer);
    procedure AdicionaLinhaContaAnalitica(pListaDados:TSBBETabelaDados; var pid_Linha:integer);


    
    procedure PreechecorGrelhaTotal();
    Function daFormatDecimalSQl():string;

    Function  DaDataInicioExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
    Function  ValidaIntervalorDatas():boolean;
    Procedure MostraMensagemInformacao(pMensagem:string);
  public


    { Public declarations }


   Procedure AbreFormulario;override;
   Procedure Sair; override;


   Property IDInterface:integer read FIDInterface  write   FIDInterface;
   end;

var
  FrmFntIntPrimaveraCBL: TFrmFntIntPrimaveraCBL;

implementation
uses IERPOGLobais, strutils, FntBS,
  SBBSIdiomas, SBBSUtilSQL, SBBSSistemaBase, SBBaseDados,
  SBBaseDadosADOAbs, ERPBSEMPRESAINTERFACE,IERPFrmPrincipal;


Const

  Col_VDArv=0;

  Col_VDsubfamilia=1;
  Col_VDDESCricao=2;
    Col_VDTLinha=3;
  Col_VDCONTACBL=4;

  Col_VDClasseIVA=5;
  Col_VDContaOrigem=6;
  Col_VDVALOR=7;
  Col_VDNatureza=8;

  COL_StockImgEstado=9;
  Col_StockEstado=10;

  COL_VDID_VndCabdocumento=11;

  Col_VDMaxCols=12;


  Col_RCArv=1;
  Col_RCDESCricao=1;
  Col_RCCONTACBL=2;
  Col_RCVALOR=3;
  Col_RCNatureza=4;
  COL_RCID_CCLiquidacao=5;
  Col_RCMaxCols=6;
{$R *.dfm}





Function TFrmFntIntPrimaveraCBL.daFormatDecimalSQl():string;
var
  i:integer;
begin
 If FNumCasaDecimaisVL>0 then
 begin
     for i:=0 to FNumCasaDecimaisVL do
     begin
      Result:=result+'0';
     end;
     result:='0.'+ Result;
 end;
end;

Procedure TFrmFntIntPrimaveraCBL.FormataGrelha;

Var
  item: TMenuItem;
  i:integer;
  strEstado:string;
Begin
  with Grelha do
  begin
    BeginUpdate;
    Clear;
    showhint:=true;
    FixedCols := 0;
    FixedRows := 1;
    RowCount := FixedRows + 1;
    ColCount := Col_VDMaxCols;

    ColWidths[Col_VDArv] := 28;

    ColWidths[Col_VDCONTACBL] := 80;
    ColWidths[Col_VDTLinha] := 35;


    ColWidths[Col_VDClasseIVA] := 80;
    ColWidths[Col_VDContaOrigem] := 80;


    ColWidths[Col_VDVALOR] := 80;
    ColWidths[Col_VDNatureza] := 30;
    ColWidths[Col_StockEstado] := 0;
    ColWidths[COL_StockImgEstado] := 0;

    ColWidths[COL_StockImgEstado] := 0;
    ColWidths[Col_StockEstado] := 0;


    ColWidths[COL_VDID_VndCabdocumento] := 0;
    ColWidths[Col_VDsubfamilia] := 150;


    ColWidths[COL_VDDescricao]:= Width - ColWidths[Col_VDsubfamilia]-ColWidths[Col_VDTLinha]-ColWidths[Col_VDArv] -ColWidths[Col_VDClasseIVA]-ColWidths[Col_VDCONTACBL]- ColWidths[Col_VDVALOR]-
                            ColWidths[Col_VDNatureza] - ColWidths[COL_VDID_VndCabdocumento]-
                              ColWidths[COL_StockImgEstado] -
            ColWidths[Col_StockEstado]- ColWidths[Col_VDContaOrigem] -21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+[goColsizing]-[goEditing];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;

    ControlLook.NoDisabledButtonLook:=True;

    Cells[Col_VDContaOrigem, 0] := SB.Idioma.daTraducao(0, 'Conta Origem');
    Cells[Col_VDsubfamilia, 0] := SB.Idioma.daTraducao(0, 'Sub.Família');
    Cells[Col_VDDESCricao, 0] := SB.Idioma.daTraducao(42, 'Descrição');
    Cells[Col_VDCONTACBL, 0] := SB.Idioma.daTraducao(0, 'Conta CBL');
    Cells[Col_VDClasseIVA, 0] := SB.Idioma.daTraducao(0, 'Classe IVA');
    Cells[Col_VDNatureza, 0] := SB.Idioma.daTraducao(0, 'Nat.');
    Cells[Col_VDvalor, 0] := SB.Idioma.daTraducao(0, 'Valor');
    Cells[Col_VDTLinha, 0] := SB.Idioma.daTraducao(0, 'T.Linha');



    With Grelha do
    begin
     { For i:= 0 To PopupMenu.Items.Count-3 Do
          PopupMenu.Items.Delete(i);

        item:= TMenuItem.Create(Grelha);
        item.Action := acreeemissaodocs;
        PopupMenu.Items.Insert(0, item);

        item:= TMenuItem.Create(Grelha);
        item.Action := acexpandir;
        PopupMenu.Items.Insert(1, item);

        item:= TMenuItem.Create(Grelha);
        item.Action := accontrair;
        PopupMenu.Items.Insert(2, item);
        If FCBLCompras then
        begin
            item:= TMenuItem.Create(Grelha);
            item.Action := acRemoverMarcaExportacao;
            PopupMenu.Items.Insert(3, item);

        end;  }



    end;
    EndUpdate;
  end;
End;



Function  TFrmFntIntPrimaveraCBL.InterfaceCBLValido():Boolean;
var
  Listaconf:tsbbetabeladados;
  mensagem:string;
begin
   Result:=false;
   FOBJInterface:=DevolveInterfaceCBL(idinterface);
   If FOBJInterface<>nil then
   begin
     Result:=true;

     dtdatainicio.Date:= FOBJInterface.DATAInicioExportacao;

   end;

end;


Procedure TFrmFntIntPrimaveraCBL.AbreFormulario;
Begin
 Inherited;
  if FIDInterface>0 Then
  begin
        InicializaForm;
        Self.Showmodal;
  end
  else
  begin
      sb.Dialogos.SBAviso('A Coneção para a Base de Dados CBL, não se encontra Configurada!');
      self.close;
  end;
End;

procedure TFrmFntIntPrimaveraCBL.Sair;
begin
   inherited;
end;



Procedure TFrmFntIntPrimaveraCBL.InicializaForm;

Begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  Top:=150;
  left:=15;
  Width:=FrmIERPPrincipal.Width-5;
  Formatagrelha;
  FNTIntfPrimaveraCBL0900.FIDInterface:=FIDInterface;
  If  FNTIntfPrimaveraCBL0900.PreencheVariavaisConfGerais then
  begin
      grpndoc.Visible:=false;
      If uppercase(sb.UtilizadorActual.Login)='MICRONET' then
       grpndoc.Visible:=true;


      If InterfaceCBLvalido=true then
      begin
           FListaErroConfPagamentos:=tstringList.create;
           FListaErroConfContas:=tstringList.create;

           tssbDocVendas.TabVisible:=true;

           dtdataInicio.Date:=DaDataInicioExportacao(FNTIntfPrimaveraCBL0900.FOBJInterface);

          If FConnectionString<>'' then
          begin
            Try
              FListaContasMercado:=sb.SBBD.AbrirLV(FConnectionString,'Select ID_Pais,id_Mercado from PMSPaisMercado');
            Except
            end;
          end;
      end
      else
      sb.Dialogos.SBAviso('Interface mal configurado!');
   end
   else
   begin
    sb.Dialogos.SBAviso('Interface mal configurado!');
   end;
end;




Procedure TFrmFntIntPrimaveraCBL.AdicionaLinhaValorPagamento(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
begin
   { With gRELHA Do
    begin
     rowcount:=rowcount+1;
     Inc(i);

     IncrementaNos(pLista.davalor('ID_Tipodocumento').asstring+
                    pLista.davalor('ID_documento').asstring, i, DadosNos);

     cells[Col_VDDESCricao,i]:=pLista.davalor('DescricaoLinha').asstring;
     cells[Col_VDCONTACBL,i]:=pLista.davalor('ContaCBLPag').asstring;
     cells[COL_VDID_Lote,i]:=pLista.davalor('ID_lote').asstring;
     Colors[Col_VDCONTACBL,i]:=clwindow;
     cells[Col_VDTipolinha,i]:=pLista.davalor('TipoLinhaFich').asstring;
     If id_Pagamentocc=pLista.davalor('Id_modoPagamento').asinteger then
     begin
         cells[Col_VDCONTACBL,i]:=pLista.davalor('ContaCBLPag').asstring+pLista.davalor('ContaCBLCliente').asstring;

     end;

     If cells[Col_VDCONTACBL,i]=''   then
     begin
          Colors[Col_VDCONTACBL,i]:=clred;
          FContasMalConfiguradas:=true;

         If  FListaErroConfPagamentos.indexof(EpHotel.text+': '+pLista.davalor('DescricaoLinha').asstring)=-1 then
         begin
           FListaErroConfPagamentos.Add(EpHotel.text+': '+pLista.davalor('DescricaoLinha').asstring);
          If FErroConfPagamentos<>'' then
              FErroConfPagamentos:=FErroConfPagamentos+#13;
          FErroConfPagamentos:=FErroConfPagamentos+EpHotel.text+': '+ pLista.davalor('DescricaoLinha').asstring;
        end;

     end;


     //fazer controlo de senão tem cor vermelha ou algo

 //    Floats[Col_VDVALOR,i]:=pLista.davalor('valor').asFloat;     
     Floats[Col_VDVALOR,i]:=abs(pLista.davalor('valor').asFloat);
     cells[Col_VDnatureza,i]:=pLista.davalor('natureza').asstring;



     Ints[COL_VDID_VndCabdocumento,i]:=pLista.davalor('ID_documento').asinteger;
     Ints[COL_VDID_DocPMS,i]:=pLista.davalor('ID_documento').asinteger;
     Ints[COL_VDID_TipoDocPMS,i]:=pLista.davalor('ID_Tipodocumento').asinteger;



   end;  }
end;

Procedure TFrmFntIntPrimaveraCBL.AdicionaLinhaValorSemIVa(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
begin

end;

Procedure TFrmFntIntPrimaveraCBL.AdicionaLinhaValorDOIVa(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
var
valor:extended;
begin
end;




Function TFrmFntIntPrimaveraCBL.dataDocumentoEntreDatasFiltro(pDataDoc:Tdatetime):Boolean;
begin
 result:=true;
end;



Function TFrmFntIntPrimaveraCBL.Preenchegrelha():TSBBETabelaDados;
var
   strsql,filtro:string;
   DadosNos : TDadosnos;
   i:Integer;
   TotNDocs:Integer;
   TotalVendas,TotalCreditos:extended;
   LinhaaZero:boolean;
   ContaCBL:string;

begin
   mmObservacoes.Lines.Clear;
   TotNDocs:=0;
   TotalVendas:=0;
   TotalCreditos:=0;
   LinhaaZero:=false;

   FNTIntfPrimaveraCBL0900.FDataInicioExp:=dtdatainicio.date;
   FNTIntfPrimaveraCBL0900.FdataFimExp:=DtDatafim.date;


   Result:=FNTIntfPrimaveraCBL0900.daListaDocumentosPorexportar(edndoc.text,strsql);

    RemoveNodes;
    DadosNos := TDadosnos.create;
    Try
        With Grelha do
        Begin
          expandAll;
          BeginUpdate;
          i := FixedRows;
          While Not(Result.NoFim)Do
          Begin
            LinhaaZero:=false;
            If  (Not(ExisteNo(result.davalor('ID_VndCabdocumento').asstring,DadosNos))) Then
            Begin
              If   ((Not(FOmitirValoresZero)) or  ((FOmitirValoresZero)
              and (result.davalor('valortotal').asFloat>0))) then
              begin
                 Inc(TotNDocs);
                 If  result.davalor('TipoOperacao').asstring='0' then
                       TotalVendas:=TotalVendas+result.davalor('valortotal').asFloat
                 else
                   TotalCreditos:=TotalCreditos+abs(result.davalor('valortotal').asFloat);
                 IncrementaNos(result.davalor('ID_VndCabdocumento').asstring, i, DadosNos);
                 cells[Col_VDsubfamilia,i]:=result.davalor('Tipodoc').asstring+
                       ' Nº'+ result.davalor('ID_documento').asstring+
                      ' Data:'+ result.davalor('Data').asstring+ ' '+ result.davalor('Cliente').asstring;

                 cells[Col_VDCONTACBL,i]:=result.davalor('VNDCONTACBL').asstring;
                 ContaCBL:=  result.davalor('VNDCONTACBL').asstring;
                 ContaCBL:=TrimLeft(ContaCBL);
                 ContaCBL:=TrimRight(ContaCBL);
                 Colors [Col_VDCONTACBL,i]:=clWindow;
                 If Length(ContaCBL)<=0 then
                 begin
                   Colors [Col_VDCONTACBL,i]:=clred;
                   mmObservacoes.Lines.add('Falta Conta CBL do T.Doc:'+result.davalor('Tipodoc').asstring)
                 end
              end
              else
               LinhaaZero:=true;

             If Not (LinhaaZero) then
             begin
              Ints[COL_VDID_VndCabdocumento,i]:=result.davalor('ID_VndCabdocumento').asinteger;
              MergeCells(Col_VDsubfamilia, i, 2, 1);
              RowColor[i] := clInfoBk;
              rowcount:=rowcount+1;
              Inc(i);
             end; 
            end;

            If ((Not(FOmitirValoresZero)) or   (result.davalor('valor').asFloat>0)) then
            begin
              IncrementaNos(result.davalor('ID_VndCabdocumento').asstring, i, DadosNos);
              cells[Col_VDDESCricao,i]:=result.davalor('DescricaoLinha').asstring;
              cells[Col_VDsubfamilia,i]:=result.davalor('subfamilia').asstring;
              cells[Col_VDTLinha,i]:='F';
              If  result.davalor('TipoLinha').asstring='0' then
              begin
                cells[Col_VDClasseIVA,i]:=result.davalor('ClasseIva').asstring;
                cells[Col_VDCONTACBL,i]:=result.davalor('ProdContCBL').asstring;
                Colors [Col_VDCONTACBL,i]:=clWindow;
                Colors [Col_VDClasseIVA,i]:=clWindow;
                ContaCBL:=  result.davalor('ProdContCBL').asstring;
                ContaCBL:=TrimLeft(ContaCBL);
                ContaCBL:=TrimRight(ContaCBL);
                If Length(ContaCBL)<=0 then
                begin
                  Colors [Col_VDCONTACBL,i]:=clred;
                  FFaltaConfContasProd:=true;
                  mmObservacoes.Lines.add('Falta Conta CBL de:'+result.davalor('DescricaoLinha').asstring);
                end;

                If cells[Col_VDClasseIVA,i]='' then
                begin
                 Colors [Col_VDClasseIVA,i]:=clred;
                 FFaltaConfContasClasseIVA:=true;
                 mmObservacoes.Lines.add('Falta Classe IVA de:'+result.davalor('DescricaoLinha').asstring)
                end;

                If  result.davalor('TipoOperacao').asstring='0' then
                    cells[Col_VDNatureza,i]:='C'
                else
                      cells[Col_VDNatureza,i]:='D';


                Floats[Col_VDVALOR,i]:=result.davalor('valor').asFloat;
                Ints[COL_VDID_VndCabdocumento,i]:=result.davalor('ID_VndCabdocumento').asinteger;

                If FRefleteCentroCusto='S' then
                If    result.davalor('ContaCCusto').asstring<>'' then
                  begin
                    AdicionaLinhaCentroCusto(result,i);
                    IncrementaNos(result.davalor('ID_VndCabdocumento').asstring, i, DadosNos);
                  end;

                 If    FRefleteAnalitica='S' then
                 If    result.davalor('ContaAnalitica').asstring<>'' then
                  begin
                    AdicionaLinhacontaanalitica(result,i);
                    IncrementaNos(result.davalor('ID_VndCabdocumento').asstring, i, DadosNos);
                  end;
             end
             else
             If  result.davalor('TipoLinha').asstring='1' then
             begin
                   cells[Col_VDCONTACBL,i]:=result.davalor('IVACONTACBL').asstring;

                    If  result.davalor('TipoOperacao').asstring='0' then
                        cells[Col_VDNatureza,i]:='C'
                    else
                      cells[Col_VDNatureza,i]:='D';

                     Colors [Col_VDCONTACBL,i]:=clWindow;

                     cells[Col_VDContaOrigem,i]:=result.davalor('ProdContCBL').asstring;
                    If cells[Col_VDCONTACBL,i]='' then
                    begin
                       Colors [Col_VDCONTACBL,i]:=clred;
                       FFaltaConfContasIVAS:=true;

                       mmObservacoes.Lines.add('Falta Conta IVA de:'+result.davalor('DescricaoLinha').asstring);

                    end;

                   Floats[Col_VDVALOR,i]:=result.davalor('valor').asFloat;
                   Ints[COL_VDID_VndCabdocumento,i]:=result.davalor('ID_VndCabdocumento').asinteger;

              end
              else
              If  result.davalor('TipoLinha').asstring='2' then
              begin

                If result.davalor('ContPagCBL').asstring='' then
                begin
                   Colors [Col_VDCONTACBL,i]:=clred;
                   FFaltaConfContasPag:=true;
                   mmObservacoes.Lines.add('Falta Conta Pagamento de:'+result.davalor('DescricaoLinha').asstring)
                end
                else
                begin
                    cells[Col_VDCONTACBL,i]:=result.davalor('ContPagCBL').asstring;
                    Colors [Col_VDCONTACBL,i]:=clWindow;
                end;

                 If  result.davalor('TipoOperacao').asstring='0' then
                     cells[Col_VDNatureza,i]:='D'
                 else
                   cells[Col_VDNatureza,i]:='C';

                Floats[Col_VDVALOR,i]:=result.davalor('valor').asFloat;
                Ints[COL_VDID_VndCabdocumento,i]:=result.davalor('ID_VndCabdocumento').asinteger;


              end;

              rowcount:=rowcount+1;
              Inc(i);
            end;
    
           result.seguinte;
          end;
          If Assigned(DadosNos) Then
          Begin
               For i:=0 to DadosNos.Num-1 Do
                 AddNode(DadosNos.elem[i].Posicao, DadosNos.elem[i].NumFilhos);
          End;
          endUpdate;

        end;
    Finally
      FreeAndnil(DadosNos);
    end;

    StTotalDocs.caption:=IntTostr(TotNDocs);
    StTotalVendas.caption:=FormatFloat('0.00',TotalVendas);
    StTotalCreditos.caption:=FormatFloat('0.00',TotalCreditos);
end;


procedure TFrmFntIntPrimaveraCBL.RemoveNodes;
var
    i:longint;
begin
    for i:=1 to Grelha.ALLRowCount-1 do
    begin
        if Grelha.IsNode(Grelha.RealRowindex(i)) then
            Grelha.RemoveNode(Grelha.RealRowindex(i));
    end;
    Grelha.ClearNormalCells;
    Grelha.Rowcount:=Grelha.FixedRows+1;
End;



procedure TFrmFntIntPrimaveraCBL.BtsairClick(Sender: TObject);
begin
  inherited;
self.close;
end;

procedure TFrmFntIntPrimaveraCBL.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  freeandnil(FListaErroConfContas);
  freeandnil(FListaErroConfPagamentos);
  If assigned(FListaContasMercado) then
  begin
    FListaContasMercado.Fecha;
    freeandnil(FListaContasMercado);
  end;
  Action:=cafree;
end;


procedure TFrmFntIntPrimaveraCBL.AtualizaGrelhatotais;
var
   strsqlTotais:string;
begin

strsqlTotais:='select Tipodocumento,CASE tipo '
+ ' WHEN 0  THEN ''Valor Sem IVA'''
+ '  WHEN 1     THEN ''Valor IVA'''
+ '  WHEN 2    THEN ''Total Pag.'''
+ '  ELSE ''erro'''
+ ' END as TipoMov'
+ '       ,round(abs(total),2) as total,Tipo'

+ ' from ( '
+ ' select descricaotipodoc As Tipodocumento,ID_TipoDocumento,'
+ ' tipomovimento,Tipolinha,sum(valor)as Total,'
+ ' case when TipoMovimento=1 then tipoLinha+TipoMovimento+1'
+ ' else tipoLinha+TipoMovimento end Tipo'

+ ' from '+FVendasPrimavera
+' Where '+FVendasPrimavera+'.tipolinhaFich=''F'' and '+FVendasPrimavera+'.ID_Hotel='+Inttostr(EpHotel.id_chave);

  If FOmitirValoresZero then
  begin
      strsqlTotais:= strsqlTotais +' and  DocTotalZERO='+SB.UtilSQL.BoolToSQLStr(false);

      If FOmitirLinhaIVA0perc=true then
          strsqlTotais:= strsqlTotais +' and  (valor<>0) '
      else
       strsqlTotais:= strsqlTotais +' and  (valorLinha<>0) ';

  end;


strsqlTotais:=strsqlTotais+ ' Group by id_tipodocumento,descricaotipodoc,tipomovimento,Tipolinha)'
+ ' as x'
+ ' order by tipodocumento,tipo';
 QTotais.Close;
QTotais.ConnectionString:=sb.SBBD.ConnectionString;
QTotais.SQL.Clear;
QTotais.SQL.add(strsqlTotais);

QTotais.Open;


end;

Procedure TFrmFntIntPrimaveraCBL.MostraMensagemInformacao(pMensagem:string);
begin
    MensagemInformacao.HTMLText.Text:=pMensagem;
    MensagemInformacao.execute;

end;


Function TFrmFntIntPrimaveraCBL.ValidaIntervalorDatas():boolean;
var
strmensagem:string;
begin

 if (DateUtils.DateOf(dtdatainicio.Date)<=DateUtils.DateOf(sb.DataSistema)) and
  (DateUtils.DateOf(dtdatafim.Date)<DateUtils.DateOf(sb.DataSistema)) then
 begin
  result:=true;
 end
 else
 begin
    result:=false;
    strmensagem:='<P align="center"> <FONT color="#00FF40" ><B>As datas de exportação tem de ser inferiores a data atual!!</B></FONT><BR>Para garantir que exporta todos os documentos gerados no dia!</P>';
    MostraMensagemInformacao(strmensagem);

 end;

end;

procedure TFrmFntIntPrimaveraCBL.BtActualizarClick(Sender: TObject);
var strsqlTotais:string;
merros:string;
begin
  inherited;
  Tssberros.TabVisible:=false;
  memoErros.clear;

  If ValidaIntervalorDatas then
  begin
      If FOBJInterface<>nil then
      begin
             screen.cursor:=crhourglass;
             try
               FErroConfPagamentosRC:='';
               TSSbPage.ActivePage:=tssbDocVendas;
               FErroConfPagamentos:='';
               FErroConfContas:='';
               FListaErroConfPagamentos.Clear;
               FListaErroConfContas.Clear;

               If assigned(FLista) then
               begin
                   FLista.Fecha;
                   FreeAndnil(FLista);
               end;
                LimpaGrelhas;
                tssbDocVendas.TabAppearance.Font.Style:=[];
                FContasMalConfiguradas:=false;
                FContasMalConfiguradasRec:=false;

                FLista:=Preenchegrelha;

                If assigned(flista) then
                begin
                   BtExportarvendas.Enabled:=not(FLista.Vazia);

                  If BtExportarvendas.Enabled then
                        tssbDocVendas.TabAppearance.Font.Style:=[fsBold];
                end;

             Finally
                  screen.cursor:=crdefault;
             end;
       end;
    end;   
end;

procedure TFrmFntIntPrimaveraCBL.GrelhaGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if (ARow>0) And (ACOL=Col_VDVALOR) then
    HAlign:=taRightJustify;

end;


Function TFrmFntIntPrimaveraCBL.GeraFicheiroPrimavera(var pNomeficheiro:string):boolean;
var
   strHotel:string;
begin

end;

procedure TFrmFntIntPrimaveraCBL.BtExportarClick(Sender: TObject);
var
    NomeFicheiro:string;
begin
  inherited;
    screen.cursor:=crhourglass;
    try
    //ValidaExportacao
    If 1=1 then
    begin
      acExportar.enabled:=false;
    end;
    finally
      screen.cursor:=crdefault;
    End;
end;

procedure TFrmFntIntPrimaveraCBL.FormCreate(Sender: TObject);
begin
  inherited;
    FIDINTERFACE:=0;
    Tssberros.TabVisible:=false;
    memoErros.Clear;
end;

procedure TFrmFntIntPrimaveraCBL.acExportarExecute(Sender: TObject);
var
   ID_Interface,i:integer ;
   ListaErros:tstringlist;
begin
  inherited;
    Tssberros.TabVisible:=false;
    memoErros.Clear;
    ListaErros:=tstringlist.create;

    FNTIntfPrimaveraCBL0900.FNaoInterrompeExportaOqueconsegue:=false;
    FNTIntfPrimaveraCBL0900.FNaoInterrompeExportaOqueconsegue:=CbExportaoqueconsegue.checked;

    If assigned(FLista) then
    If FLista.numlinhas>0 then
    begin
      ID_Interface:=0;
      BtExportarvendas.enabled:=false;
      screen.cursor:=crhourglass;

      TRy
       If ExportarVendasManual(FLista,ListaErros) then
       begin
         If   FPrimeiraExportacao=true  then
           begin
             sb.SBBD.Executa('update ERP_EMPRESAINTERFACE set DATAInicioExportacao='+sb.UtilSQL.DataToSQLData(dtdataInicio.date)
              +' where id='+inttostr(FOBJInterface.id));
           end;
             sb.SBBD.Executa('update ERP_EMPRESAINTERFACE set DATAUltimaExportacao='+sb.UtilSQL.DataToSQLData(dtdataFim.date)
              +' where id='+inttostr(FOBJInterface.id)
              +' and isnull(DATAUltimaExportacao,0)<'+sb.UtilSQL.DataToSQLData(dtdataFim.date));


             FPrimeiraExportacao:=falsE;
             RegistaLogOperacao('Operação:Exportação CBL Vendas PMS entre:'+dtdatainicio.text +' a '+dtdatafim.text);

             If ListaErros.Count>0 then
             begin
                  sb.Dialogos.SBMessage('Não foi possivel Exportar certos documentos!'+#13+'Verifique separador de erros.');
                  Tssberros.TabVisible:=true;
                  memoErros.Clear;
                  For i:=0 to  ListaErros.Count-1 do
                    memoErros.Lines.Add(ListaErros.strings[i]);

             end
             else
                     sb.Dialogos.SBMessage('Exportação efetuada com Sucesso!'+#13+' Entre:'+dtdatainicio.text +' a '+dtdatafim.text);

             If  ListaErros.Count=0 then
             begin
                 LimpaGrelhas;
                 If FNTIntfPrimaveraCBL0900.FOBJInterface<>nil then
                 begin
                    ID_Interface:=  FNTIntfPrimaveraCBL0900.FOBJInterface.ID;
                    FNTIntfPrimaveraCBL0900.FOBJInterface:=nil;
                    FNTIntfPrimaveraCBL0900.FOBJInterface:=MotorERP.ERPInterface.Edita(ID_Interface);
                    dtdataInicio.Date:=DaDataInicioExportacao(FNTIntfPrimaveraCBL0900.FOBJInterface);
                    If FNTIntfPrimaveraCBL0900.FOBJInterface.TipoPeriodExportacao=1 then
                           gbData.enabled:=false;
                 end;
             end;
       end;
      Finally
        screen.cursor:=crdefault;

      end;
    end;

END;


procedure TFrmFntIntPrimaveraCBL.AdvToolBarButton3Click(Sender: TObject);
begin
  inherited;
 Preenchegrelha;
end;

procedure TFrmFntIntPrimaveraCBL.acactualizarExecute(Sender: TObject);
begin
  inherited;
Preenchegrelha;
end;




procedure TFrmFntIntPrimaveraCBL.btLimparClick(Sender: TObject);
begin
  inherited;
  gbData.enabled:=true;
  RemoveNodes;
  Grelha.ClearNormalCells;
  Grelha.RowCount:=grelha.FixedRows+1;
  If FLista<>nil then
      FLista.Fecha;
  BtExportarvendas.Enabled:=false;

end;

procedure TFrmFntIntPrimaveraCBL.Contrair1Click(Sender: TObject);
begin
  inherited;
 Grelha.ContractAll;
end;

procedure TFrmFntIntPrimaveraCBL.Expandir1Click(Sender: TObject);
begin
  inherited;
 Grelha.ExpandAll;
end;




procedure TFrmFntIntPrimaveraCBL.PreechecorGrelhaTotal();
begin
  inherited;
end;



Procedure TFrmFntIntPrimaveraCBL.SelecionaTipodoc(Sender :TObject);
Begin

end;








Procedure TFrmFntIntPrimaveraCBL.LimpaGrelhas;
begin
    RemoveNodes;
    QTotais.close;
    gbData.enabled:=true;
end;



procedure TFrmFntIntPrimaveraCBL.GrelhaRecGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if (ARow>0) And (ACOL=Col_RCVALOR) then
    HAlign:=taRightJustify;
end;

Function TFrmFntIntPrimaveraCBL.DaMercado(pID_Pais:integer):integer;
begin
  Result:=1;
  if FListaContasMercado<>nil then
  If FListaContasMercado.dataset.locate('ID_Pais',pID_Pais,[]) then
   Result:=FListaContasMercado.dataset.fieldbyname('id_mercado').asinteger;
end;

procedure TFrmFntIntPrimaveraCBL.EpHotelBtEliminarClick(Sender: TObject);
begin
  inherited;
 btLimpar.click;
end;

Function TFrmFntIntPrimaveraCBL.ValidaLicenca(pmpehotel:string;ptipoLicenca:Integer; var avisos:string):boolean;
var
  SBLista:TSBBETabelaDados;
  StrSql:String;
  Avisolicenca,Hotel:string;

begin
 result:=true;
end;

procedure TFrmFntIntPrimaveraCBL.AdicionaLinhaCentroCusto(pListaDados:TSBBETabelaDados; var pid_Linha:integer);
var
 i:integer;
begin
  with Grelha do
  begin
      rowcount:=rowcount+1;
      Inc(pid_Linha);
      i:= pid_Linha;
      cells[Col_VDTLinha,i]:='O';
       cells[Col_VDsubfamilia,i]:=pListaDados.davalor('subfamilia').asstring;
      cells[Col_VDDESCricao,i]:=pListaDados.davalor('DescricaoLinha').asstring;
      cells[Col_VDContaOrigem,i]:=pListaDados.davalor('ProdContCBL').asstring;
      cells[Col_VDCONTACBL,i]:=pListaDados.davalor('ContaCCusto').asstring;

      Colors [Col_VDCONTACBL,i]:=clWindow;
      Colors [Col_VDClasseIVA,i]:=clWindow;

      If cells[Col_VDCONTACBL,i]='' then
      begin
       Colors [Col_VDCONTACBL,i]:=clred;
       FFaltaConfContasProd:=true;
      end;

      Floats[Col_VDVALOR,i]:=pListaDados.davalor('valor').asFloat;
      Ints[COL_VDID_VndCabdocumento,i]:=pListaDados.davalor('ID_VndCabdocumento').asinteger;



      If  pListaDados.davalor('TipoOperacao').asstring='0' then
          cells[Col_VDNatureza,i]:='C'
      else
            cells[Col_VDNatureza,i]:='D';
   end;
end;


procedure TFrmFntIntPrimaveraCBL.AdicionaLinhaContaAnalitica(pListaDados:TSBBETabelaDados; var pid_Linha:integer);
var
 i:integer;
begin
  with Grelha do
  begin
      rowcount:=rowcount+1;
      Inc(pid_Linha);
      i:= pid_Linha;
      cells[Col_VDTLinha,i]:='A';
      cells[Col_VDsubfamilia,i]:=pListaDados.davalor('subfamilia').asstring;
      cells[Col_VDDESCricao,i]:=pListaDados.davalor('DescricaoLinha').asstring;
      cells[Col_VDContaOrigem,i]:=pListaDados.davalor('ProdContCBL').asstring;
      cells[Col_VDCONTACBL,i]:=pListaDados.davalor('ContaAnalitica').asstring;

      Colors [Col_VDCONTACBL,i]:=clWindow;
      Colors [Col_VDClasseIVA,i]:=clWindow;

      If cells[Col_VDCONTACBL,i]='' then
      begin
       Colors [Col_VDCONTACBL,i]:=clred;
       FFaltaConfContasProd:=true;
      end;


      Floats[Col_VDVALOR,i]:=pListaDados.davalor('valor').asFloat;
      Ints[COL_VDID_VndCabdocumento,i]:=pListaDados.davalor('ID_VndCabdocumento').asinteger;


      If  pListaDados.davalor('TipoOperacao').asstring='0' then
          cells[Col_VDNatureza,i]:='C'
      else
            cells[Col_VDNatureza,i]:='D';
   end;
end;






Function  TFrmFntIntPrimaveraCBL.DaDataInicioExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
var Ano, Mes, Dias: Integer;
    data:tdatetime;
     Listaex:Tsbbetabeladados;
Begin
  FPrimeiraExportacao:=true;
  If pObjInterface.DATAInicioExportacao>0 then
  begin
     result := pObjInterface.DATAInicioExportacao;
     If FNTIntfPrimaveraCBL0900.FOBJInterface.TipoPeriodExportacao=2 then
     begin
       Result:=FNTIntfPrimaveraCBL0900.DAultimoDataVendaExportado(FNTIntfPrimaveraCBL0900.FOBJInterface.id);
       DtDatafim.Visible:=true;
       DtDatafim.Date:=DateUtils.EndOfTheMonth(Result);
       dtdatainicio.enabled:=false;
       If Uppercase(sb.UtilizadorActual.Login)='MICRONET' then
       begin
         dtdatainicio.enabled:=true;
       end;
      end
  end;
  Listaex:=sb.sbbd.abrirlv('select * from ERP_CBLCabec where origem='+Inttostr(FOBJInterface.ID));
  If Not(Listaex.vazia) then
  begin
    If pObjInterface.DATAInicioExportacao>0 then
    begin
       FPrimeiraExportacao:=false;
       If FNTIntfPrimaveraCBL0900.FOBJInterface.TipoPeriodExportacao=2 then
       begin
            Result:=FNTIntfPrimaveraCBL0900.DAultimoDataVendaExportado(FNTIntfPrimaveraCBL0900.FOBJInterface.id);
            lbsbFim.Visible:=true;
            DtDatafim.Visible:=true;
            DtDatafim.Date:=DateUtils.EndOfTheMonth(Result);
       end
       else
       begin
         FPrimeiraExportacao:=false;
         Result:= pObjInterface.DATAInicioExportacao;
         gbData.enabled:=false;
         dtdatainicio.color:=clsilver;
       end;
    end;
    FPrimeiraExportacao:=false;
  end;
 Listaex.fecha;
 Freeandnil(Listaex);
end;
end.


