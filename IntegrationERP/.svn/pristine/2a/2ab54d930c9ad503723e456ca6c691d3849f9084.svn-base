unit IERP_FrmPmsPrimveraCBL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SBfrmBase, AdvOfficeButtons, StdCtrls, Grids, AdvObj, BaseGrid,
  AdvGrid, AdvOfficePager, Mask, AdvEdit, AdvMEdBtn, PlannerMaskDatePicker,
  AdvGroupBox, ExtCtrls, AdvPanel, AdvToolBar,Sbbotoes,SBcontrolos,menus,SBBETaBElaDados,
  PMSIntfPrimaveraCBL0900,FntBeFntInterfaceCenExp, AdvEdBtn,
   AdvDirectoryEdit,FntBeTipoCons,FntUtilGrelha,inifiles, ActnList,
  PlannerDatePicker,adodb, AdvProgressBar, DB, DBAdvGrid, Buttons,
  SBEditProcura ,sblista,
  pngimage,SBBEExcepcoes,CBLOperInterfaceProtel ,ERPBEEMPRESAINTERFACE, DateUtils,
  AdvMemo,ERPLogOperacoes, AdvSmoothMessageDialog, AdvUtil, System.Actions;

type
  TFrmPmsIERPPrimveraCBL = class(TForm)
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
    AdvPanel3: TAdvPanel;
    edtipodoc: TEdit;
    GrpMercado: TAdvGroupBox;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    EdExtra: TEdit;
    edInter: TEdit;
    edNacional: TEdit;
    ephotel: TSBEditProcura;
    tssbImpressao: TAdvOfficePage;
    GroupBox1: TGroupBox;
    LbsbRelatorio: TLabel;
    cmbRelatorios: TComboBox;
    cbsbVisualizar: TAdvOfficeCheckBox;
    AdvOfficePage1: TAdvOfficePage;
    mmObservacoes: TAdvMemo;
    AdvPanel4: TAdvPanel;
    Progresso: TAdvProgressBar;
    ActionList1: TActionList;
    acExportar: TAction;
    acactualizar: TAction;
    acExpRecibos: TAction;
    PopupMenu1: TPopupMenu;
    Contrair1: TMenuItem;
    Expandir1: TMenuItem;
    Detalhe1: TMenuItem;
    QTotais: TADOQuery;
    DataSource1: TDataSource;
    QVendasProtel: TADOQuery;
    poprec: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    gbData: TAdvGroupBox;
    lbsbInicio: TLabel;
    lbsbFim: TLabel;
    dtdatainicio: TPlannerMaskDatePicker;
    DtDatafim: TPlannerMaskDatePicker;
    AdvOfficePage2: TAdvOfficePage;
    GrelhaTotais: TAdvStringGrid;
    MensagemInformacao: TAdvSmoothMessageDialog;
    grpndoc: TAdvGroupBox;
    Label6: TLabel;
    edndoc: TEdit;
    CbExportaoqueconsegue: TAdvOfficeCheckBox;
    Tssberros: TAdvOfficePage;
    memoErros: TAdvMemo;
    procedure FormCreate(Sender: TObject);
    procedure acExportarExecute(Sender: TObject);
    procedure acactualizarExecute(Sender: TObject);
    procedure Contrair1Click(Sender: TObject);
    procedure Expandir1Click(Sender: TObject);
    procedure BtActualizarClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure BtsairClick(Sender: TObject);
    procedure GrelhaGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GrelhaTotaisGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
  private
    { Private declarations }
   FPrimeiraExportacao:boolean;
   FLista:TSBBETAbeladados;
   FCBLCompras:Boolean;
   FConnectionString:string;
   FShemaProtel:string;
   FtipoLicenca:Integer;
   id_Pagamentocc:integer;
   FOmitirValoresZero:boolean;
   FOmitirLinhaIVA0perc:boolean;
   FEnviaLinhaIva:boolean;
   FConfPorTipoDoc:boolean;
   FClienteTabMETADATA:Boolean;
   FContasMalConfiguradas:Boolean;
   FContasMalConfiguradasRec:Boolean;
   FErroConfPagamentos:string;
   FErroConfContas:string;
   FErroConfPagamentosRC:string;
   FListaErroConfPagamentos:tstringList;
   FListaErroConfContas:tstringList;
   FExcluirDocsVndAnulados:Boolean;
   FContasIVASPorMercado:Boolean;
   FNumCasaDecimaisVL:integer;
   FFormatDecimalSQl:string;
   FListaContasMercado:TSBBETabelaDados;
   FExportaVendas,
   FExportaRecibos:boolean;
   FIDInterface:integer;
   FContasPorMercado:boolean;
   FVendasProtel,FVendasPrimavera:string;
   FconexaoProtel:string;
   FOBJInterface:TERPBEEMPRESAINTERFACE;
   Procedure Adicionalinha(pID_tipodoc:integer;pTipodoc:string; pvalor,pquantidade:extended);
   Procedure FormataGrelhaTotais;
   Function ValidaLicenca(pmpehotel:string;ptipoLicenca:Integer; var avisos:string):boolean;
   Function dataDocumentoEntreDatasFiltro(pDataDoc:Tdatetime):Boolean;
   Function DaMercado(pID_Pais:integer):integer;
   Procedure LimpaGrelhas;
  procedure AtualizaGrelhatotais;
   Procedure SelecionaHotel(Sender :TObject);
   Procedure SelecionaTipodoc(Sender :TObject);
   Procedure PreencheParametrosGerais();
   Function  InterfaceCBLProtelValido():Boolean;
   Procedure InicializaForm ;
   Procedure FormataGrelha;
   Function Preenchegrelha():TSBBETabelaDados;
   procedure RemoveNodes;
    Function GeraFicheiroPrimavera(var pNomeficheiro:string):boolean;
   Procedure PreencheDadosGerais;
   Function  DaDataInicioExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;

    Procedure AdicionaLinhaValorSemIVa(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
    Procedure AdicionaLinhaValorPagamento(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
    Procedure AdicionaLinhaValorDOIVa(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);





    
    procedure PreechecorGrelhaTotal();
    procedure PreencheHotel(pid_Hotel:Integer=0);
    Function  daFormatDecimalSQl():string;
    procedure CriaV_V_DocvendaPaisHospedePMS;
    Function  DafiltroDocspms():string;
    Function  ValidaIntervalorDatas():boolean;
    Procedure MostraMensagemInformacao(pMensagem:string);

  public
    { Public declarations }
   Procedure AbreFormulario;
   Procedure Sair;

   Property CBLCompras:Boolean read FCBLCompras write FCBLCompras;
  end;

var
  FrmPmsIERPPrimveraCBL: TFrmPmsIERPPrimveraCBL;

implementation
uses IERPOGLobais, strutils, FntBS,
  SBBSIdiomas, SBBSUtilSQL, SBBSSistemaBase, SBBaseDados,
  SBBaseDadosADOAbs,IERPFrmPrincipal, SBBEUtilizador;

Const
  Col_VDArv=0;
  Col_VDDESCricao=1;
  Col_VDTipolinha=2;
  Col_VDCONTACBL=3;
  Col_VDCLASSEIVA=4;
  Col_VDContaOrigem=5;
  Col_VDVALOR=6;
  Col_VDNatureza=7;
  COL_VDID_Lote=8;
  COL_VDID_VndCabdocumento=9;
  COL_VDID_DocPMS=10;
  COL_VDID_TipoDocPMS=11;
  COL_VDDescTipoDocPMS=12;
  Col_VDMaxCols=13;


  Col_RCArv=0;
  Col_RCDESCricao=1;
  Col_RCCONTACBL=2;
  Col_RCVALOR=3;
  Col_RCNatureza=4;
  COL_RCID_CCLiquidacao=5;
  Col_RCMaxCols=6;


  COl_ResID_TipoDoc=0;
  COl_ResTipoDoc=1;
  COl_ResNtot=2;
  COl_ResValor=3;
  COl_ResMAx=4;



{$R *.dfm}


Procedure TFrmPmsIERPPrimveraCBL.Adicionalinha(pID_tipodoc:integer;pTipodoc:string; pvalor,pquantidade:extended);
var
  i,j:Integer;
begin
 If pvalor<>0 then
 begin
  j:=-1;

  For i:=1 to GrelhaTotais.rowcount-1 do
  begin
    If (GrelhaTotais.ints[COl_ResID_TipoDoc,i]= pID_tipodoc) then
    begin
       j:= i;
    end;
  end;
  If J>-1 then
  begin
   GrelhaTotais.Floats[COl_ResValor,j]:=GrelhaTotais.Floats[COl_ResValor,j]+pvalor;
   GrelhaTotais.Floats[COl_ResNtot,j]:=GrelhaTotais.Floats[COl_ResNtot,j]+1;
//   grelhaTotais.rowcount:=grelhaTotais.rowcount+1;
  end
  else
  begin
    If  GrelhaTotais.cells[COl_ResTipoDoc,1]<>'' then
       GrelhaTotais.rowcount:=GrelhaTotais.rowcount+1;
    GrelhaTotais.ints[COl_ResID_TipoDoc,GrelhaTotais.rowcount-1]:=pID_tipodoc;
    GrelhaTotais.cells[COl_ResTipoDoc,GrelhaTotais.rowcount-1]:=pTipodoc;
    GrelhaTotais.Floats[COl_ResValor, GrelhaTotais.rowcount-1]:=pvalor;
    GrelhaTotais.Floats[COl_ResNtot, GrelhaTotais.rowcount-1]:=1;
  end;
 end; 
end;


Function TFrmPmsIERPPrimveraCBL.daFormatDecimalSQl():string;
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






Procedure TFrmPmsIERPPrimveraCBL.FormataGrelhaTotais;
Var
  item: TMenuItem;
  i:integer;
  strEstado:string;
Begin
  with GrelhaTotais do
  begin
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 1;
    RowCount := 2;
    ColCount := COl_ResMAx;

    ColWidths[COl_ResTipoDoc] := 250;

    ColWidths[COl_ResID_TipoDoc] := 50;

    ColWidths[COl_ResNtot] := 100;
    ColWidths[COl_ResValor] := 100;



    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+[goColsizing]-[goEditing];


//    [goFixedVertLine] +
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;
    ControlLook.NoDisabledButtonLook:=True;

    Cells[COl_ResTipoDoc, 0] := SB.Idioma.daTraducao(0, 'Tipo Doc.');
    Cells[COl_ResID_TipoDoc, 0] := SB.Idioma.daTraducao(0, 'Cod.');
    Cells[COl_ResNtot, 0] := SB.Idioma.daTraducao(0, 'Tot.Docs.');
    Cells[COl_ResValor, 0] := SB.Idioma.daTraducao(0, 'Total');
    EndUpdate;
  end;
End;



Procedure TFrmPmsIERPPrimveraCBL.FormataGrelha;
Var
  item: TMenuItem;
  i:integer;
  strEstado:string;
Begin
  with Grelha do
  begin
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 1;
    RowCount := FixedRows + 1;
    ColCount := Col_VDMaxCols;

    ColWidths[Col_VDArv] := 28;

    ColWidths[Col_VDCONTACBL] := 80;
    ColWidths[Col_VDCLASSEIVA] := 80;
    ColWidths[Col_VDContaOrigem] := 80;


    ColWidths[Col_VDVALOR] := 80;
    ColWidths[Col_VDNatureza] := 30;
    ColWidths[COL_VDID_Lote] := 0;

    ColWidths[COL_VDID_VndCabdocumento] := 0;
    ColWidths[COL_VDID_TipoDocPMS] := 0;
    ColWidths[COL_VDDescTipoDocPMS] := 0;

    ColWidths[COL_VDID_DocPMS] := 0;
    ColWidths[Col_VDTipolinha] := 43;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+[goColsizing]-[goEditing];
    ColWidths[COL_VDDescricao]:= Width -  ColWidths[Col_VDTipolinha]-ColWidths[COL_VDID_Lote]-ColWidths[Col_VDCLASSEIVA]-ColWidths[Col_VDArv] -ColWidths[Col_VDCONTACBL]- ColWidths[Col_VDVALOR]-
                            ColWidths[Col_VDNatureza] - ColWidths[COL_VDID_VndCabdocumento]-  ColWidths[Col_VDContaOrigem]-21;


//    [goFixedVertLine] +
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;
    ControlLook.NoDisabledButtonLook:=True;

    Cells[COL_VDID_Lote, 0] := SB.Idioma.daTraducao(0, 'Lote');
    Cells[Col_VDDESCricao, 0] := SB.Idioma.daTraducao(42, 'Descrição');
    Cells[Col_VDCONTACBL, 0] := SB.Idioma.daTraducao(0, 'Conta CBL');
    Cells[Col_VDCLASSEIVA, 0] := SB.Idioma.daTraducao(0, 'Classe IVA');
    Cells[Col_VDNatureza, 0] := SB.Idioma.daTraducao(0, 'Nat.');
    Cells[Col_VDvalor, 0] := SB.Idioma.daTraducao(0, 'Valor');
    Cells[Col_VDTipolinha, 0] := SB.Idioma.daTraducao(0, 'T.Linha');
    Cells[Col_VDContaOrigem, 0] := SB.Idioma.daTraducao(0, 'Conta Origem');
    EndUpdate;
  end;
End;

Function  TFrmPmsIERPPrimveraCBL.InterfaceCBLProtelValido():Boolean;
var
  Listaconf:tsbbetabeladados;
  mensagem:string;
begin
   Result:=false;
   FOBJInterface:=DevolveInterfaceCBL;
   If FOBJInterface<>nil then
   begin
     Result:=true;
     dtdatainicio.Date:= FOBJInterface.DATAInicioExportacao;

  //  IF CBLOperInterfaceProtel.TemExportacoes(mensagem) then
//             gbData.Visible:=false;

     FContasPorMercado:=false;
     FShemaProtel:=FOBJInterface.BDSchema;
     If FOBJInterface.ID>0 then
     begin
        Listaconf:=sb.SBBD.AbrirLV('select ContasPorMercado from ERP_CBLParametros where ID_EmpresaInteraface='+Inttostr( FOBJInterface.ID));
        If not Listaconf.Vazia then
          FContasPorMercado:= Listaconf.daValor('ContasPorMercado').asboolean;
        Listaconf.Fecha;
        Freeandnil(Listaconf);
     end;
   end;

end;


Procedure TFrmPmsIERPPrimveraCBL.AbreFormulario;
Begin
 Inherited;


  if FShemaProtel<>'' then
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

procedure TFrmPmsIERPPrimveraCBL.Sair;
begin
   inherited;
end;

Procedure TFrmPmsIERPPrimveraCBL.PreencheDadosGerais;
var
  strsql:string;
  lstDados:TSBBETabelaDados;
begin
    id_Pagamentocc:=0;
    FOmitirLinhaIVA0perc:=false;
    FContasIVASPorMercado:=false;
    strsql:='Select * from ERP_CBLParametros  where ID_EmpresaInteraface='+IntToStr(FIDInterface);
    Lstdados:=sb.SBBD.AbrirLV(strsql);
    If Not(Lstdados.Vazia) then
    begin

       FContasIVASPorMercado:= Lstdados.daValor('ContasPorMercado').asboolean;
       FExcluirDocsVndAnulados:= Lstdados.daValor('ExcluirDocsVndAnulados').asboolean;
       FNumCasaDecimaisVL:= Lstdados.daValor('NumCasaDecimaisVL').asInteger;
       FExportaVendas:= Lstdados.daValor('ExportaVendas').asBoolean;
       FExportaRecibos:= Lstdados.daValor('ExportaRecibos').asBoolean;

       FOmitirValoresZero:=Lstdados.daValor('OmiteLinhaZero').asboolean;
       FOmitirLinhaIVA0perc:=Lstdados.daValor('OmitirLinhaIVA0perc').asboolean;


       FFormatDecimalSQl:=daFormatDecimalSQl;


       Grelha.FloatFormat:='%.'+Inttostr(FNumCasaDecimaisVL)+'f';




      id_Pagamentocc:=Lstdados.daValor('id_Pagamentocc').asInteger;
      FClienteTabMETADATA:=Lstdados.daValor('FibudebMetaData').asboolean;
    end;
    GrpMercado.Visible:= (FContasIVASPorMercado=true);
    FreeAndnil(Lstdados);
end;


Procedure TFrmPmsIERPPrimveraCBL.InicializaForm;

Begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  Top:=150;
  left:=10;
  Width:=FrmIERPPrincipal.Width-5;
  Formatagrelha;
  FormatagrelhaTotais;




  PreencheDadosGerais;

  tssbDocVendas.TabVisible:=true;

  CriaV_V_DocvendaPaisHospedePMS;


  PMSIntfPrimaveraCBL0900.FIDInterface:=0;
  PMSIntfPrimaveraCBL0900.FIDInterface:=FIDInterface;
  If  PMSIntfPrimaveraCBL0900.PreparaParametrosExportacao then
  begin
      If PMSIntfPrimaveraCBL0900.FOBJInterface<>nil then
      begin
            dtdataInicio.Date:=DaDataInicioExportacao(PMSIntfPrimaveraCBL0900.FOBJInterface);

      end;


      If FConnectionString<>'' then
      begin
        Try
          FListaContasMercado:=sb.SBBD.AbrirLV(FConnectionString,'Select ID_Pais,id_Mercado from PMSPaisMercado');
        Except
        end;
      end;
      end;

 end;


Procedure TFrmPmsIERPPrimveraCBL.AdicionaLinhaValorPagamento(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
var
CodClientePMS:string;
j,  ttZeros:integer;
begin
   ttZeros:=0;
    With gRELHA Do
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
       CodClientePMS:='';
       CodClientePMS:=pLista.davalor('ContaCBLCliente').asstring;
       If Length(CodClientePMS)<6 then
       begin
          ttZeros:=6-Length(CodClientePMS);
          For j:=0 to  ttZeros-1 do
            CodClientePMS:='0'+CodClientePMS;
       end;

         cells[Col_VDCONTACBL,i]:=pLista.davalor('ContaCBLPag').asstring+pLista.davalor('mercado').asstring
         + CodClientePMS;

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



   end;
end;

Procedure TFrmPmsIERPPrimveraCBL.AdicionaLinhaValorSemIVa(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
var
valor:extended;
begin
    With gRELHA Do
    begin
     valor:=0;
     rowcount:=rowcount+1;
     Inc(i);

     valor:=pLista.davalor('valor').asfloat;

     If  pLista.davalor('TipoLinhaFich').asstring='F'   then
     begin
             IncrementaNos(pLista.davalor('ID_Tipodocumento').asstring+
                    pLista.davalor('ID_documento').asstring, i,valor, DadosNos)
     end
     else
     begin
      IncrementaNos(pLista.davalor('ID_Tipodocumento').asstring+
                    pLista.davalor('ID_documento').asstring, i,0, DadosNos);

     end;

     cells[Col_VDTipolinha,i]:=pLista.davalor('TipoLinhaFich').asstring;
     cells[Col_VDDESCricao,i]:=pLista.davalor('DescricaoLinha').asstring;
     If pLista.davalor('TipoLinhaFich').asstring='F'   then
     begin
           cells[Col_VDCONTACBL,i]:=pLista.davalor('ContaCBLFamilia').asstring;
           cells[Col_VDClasseIVA,i]:=pLista.davalor('ClasseIVA').asstring;
     end
     else
     If pLista.davalor('TipoLinhaFich').asstring='O'   then
     begin
        cells[Col_VDCONTACBL,i]:=pLista.davalor('ContaCCusto').asstring;
        cells[Col_VDContaOrigem,i]:=pLista.davalor('ContaCBLFamilia').asstring;
     end
     else
     If pLista.davalor('TipoLinhaFich').asstring='A'   then
     begin
        cells[Col_VDCONTACBL,i]:=pLista.davalor('ContaAnalitica').asstring;
        cells[Col_VDContaOrigem,i]:=pLista.davalor('ContaCBLFamilia').asstring;
     end;

     cells[COL_VDID_Lote,i]:=pLista.davalor('ID_lote').asstring;


//     Floats[Col_VDVALOR,i]:=pLista.davalor('valor').asFloat;     
     Floats[Col_VDVALOR,i]:=abs(pLista.davalor('valor').asFloat);
     cells[Col_VDnatureza,i]:=pLista.davalor('natureza').asstring;

     Colors[Col_VDCONTACBL,i]:=clWindow;

     If cells[Col_VDCONTACBL,i]=''   then
     begin
          Colors[Col_VDCONTACBL,i]:=clred;
          FContasMalConfiguradas:=true;

      If  FListaErroConfContas.indexof(pLista.davalor('DescricaoTipoDoc').asstring+': '+ pLista.davalor('DescricaoLinha').asstring)=-1 then
      begin
           FListaErroConfContas.Add(pLista.davalor('DescricaoTipoDoc').asstring+': '+ pLista.davalor('DescricaoLinha').asstring);
          If FErroConfContas<>'' then
              FErroConfContas:=FErroConfContas+#13;
          FErroConfContas:= FErroConfContas+ pLista.davalor('DescricaoTipoDoc').asstring+': '+ pLista.davalor('DescricaoLinha').asstring;

      end;
     end;

     {If pLista.davalor('Natureza').asstring='D' then
     begin
       If  pLista.davalor('Valor').asFloat<0 then
           cells[Col_VDnatureza,i]:='C'
       else
         cells[Col_VDnatureza,i]:='D';
     end
     else
     begin                                                                                                                                  
         If pLista.davalor('Natureza').asstring='C' then
         begin
           If  pLista.davalor('Valor').asFloat>0 then
               cells[Col_VDnatureza,i]:='D'
           else
             cells[Col_VDnatureza,i]:='C';
         end
     end;  }


     Ints[COL_VDID_VndCabdocumento,i]:=pLista.davalor('ID_documento').asinteger;
     Ints[COL_VDID_DocPMS,i]:=pLista.davalor('ID_documento').asinteger;
     Ints[COL_VDID_TipoDocPMS,i]:=pLista.davalor('ID_Tipodocumento').asinteger;

     

   end;
end;

Procedure TFrmPmsIERPPrimveraCBL.AdicionaLinhaValorDOIVa(pLista:TSBBEtabelaDados;var DadosNos:TdadosNos;var i:integer);
var
valor:extended;
begin
    With gRELHA Do
    begin
     valor:=0;
     rowcount:=rowcount+1;
     Inc(i);

     valor:=pLista.davalor('valor').asfloat;
     IncrementaNos(pLista.davalor('ID_Tipodocumento').asstring+
                    pLista.davalor('ID_documento').asstring, i,valor, DadosNos);

     cells[Col_VDDESCricao,i]:='IVA '+pLista.davalor('IVA').asstring+'%';
     cells[Col_VDTipolinha,i]:=pLista.davalor('TipoLinhaFich').asstring;
     cells[COL_VDID_Lote,i]:=pLista.davalor('ID_lote').asstring;
     cells[Col_VDCONTACBL,i]:=pLista.davalor('ContaCBLIVA').asstring;
     cells[Col_VDContaOrigem,i]:=pLista.davalor('ContaCBLFamilia').asstring;

     cells[Col_VDnatureza,i]:=pLista.davalor('Natureza').asstring;
     Floats[Col_VDVALOR,i]:=abs(pLista.davalor('valor').asFloat);


     Colors[Col_VDCONTACBL,i]:=clWindow;
     If cells[Col_VDCONTACBL,i]=''   then
     begin
          Colors[Col_VDCONTACBL,i]:=clred;
          FContasMalConfiguradas:=true;
     end;

     Ints[COL_VDID_VndCabdocumento,i]:=pLista.davalor('ID_documento').asinteger;
     cells[Col_VDnatureza,i]:=pLista.davalor('natureza').asstring;
     Ints[COL_VDID_DocPMS,i]:=pLista.davalor('ID_documento').asinteger;
     Ints[COL_VDID_TipoDocPMS,i]:=pLista.davalor('ID_Tipodocumento').asinteger;

     
   end;
end;




Function TFrmPmsIERPPrimveraCBL.dataDocumentoEntreDatasFiltro(pDataDoc:Tdatetime):Boolean;
begin
 result:=true;
end;



Function TFrmPmsIERPPrimveraCBL.Preenchegrelha():TSBBETabelaDados;
var
   strsql,filtro:string;
   DadosNos : TDadosnos;
   DadosNosTotais : TDadosnos;
   i:Integer;
   StrDocumentos:string;
   FListaAgrupada:tsbbetabeladados;
   valor:extended;
   TotNac,TotIntCom,TotExtraCom:integer;
begin
    Progresso.Position:=0;
    FListaAgrupada:=nil;
    valor:=0;
    TotNac:=0;
    TotIntCom:=0;
    TotExtraCom:=0;
    edNacional.text:=inttostr(TotNac);
    edInter.text:=inttostr(TotIntCom);
    EdExtra.text:=inttostr(TotExtraCom);
    Try
     PMSIntfPrimaveraCBL0900.FDataInicioExp:=0;
     PMSIntfPrimaveraCBL0900.FdataFimExp:=0;

     If filtraMaskData(dtdatainicio)>0 then
       PMSIntfPrimaveraCBL0900.FDataInicioExp:=dtdatainicio.date;
     If filtraMaskData(DtDatafim)>0 then
      PMSIntfPrimaveraCBL0900.FdataFimExp:=DtDatafim.date;

     Result:=daListaDocumentosPorexportar(edndoc.Text,strsql);
    finally
            mmObservacoes.Lines.add(strsql);
    end;
    RemoveNodes;
    If not(Result.vazia) then
    begin
    gbData.enabled:=false;
    DadosNos := TDadosnos.create;
    DadosNosTotais := TDadosnos.create;
    Try
        With Grelha do
        Begin
          expandAll;
          BeginUpdate;
          i := FixedRows;
          While Not(Result.NoFim)Do
          Begin
   


            If  (Not(ExisteNo(result.davalor('DescricaoTipoDoc').asstring,DadosNosTotais))) Then
            begin
                 IncrementaNos(result.davalor('DescricaoTipoDoc').asstring,i,valor, DadosNosTotais);



            end;
            If  (Not(ExisteNo(result.davalor('ID_Tipodocumento').asstring+
                    result.davalor('ID_documento').asstring,DadosNos))) Then
            Begin
              valor:=0;
              If i>1 then
              begin
                rowcount:=rowcount+1;
                Inc(i);
              end;

              IncrementaNos(result.davalor('ID_Tipodocumento').asstring+
                    result.davalor('ID_documento').asstring, i,valor, DadosNos);




              cells[COL_VDDescTipoDocPMS,i]:=result.davalor('DescricaoTipoDoc').asstring;

              cells[Col_VDDESCricao,i]:='<B>'+result.davalor('DescricaoDoc').asstring+'</B>'+
                      '<B> Data:</B>'+ result.davalor('dataDoc').asstring+
                      '<B> Cliente:</B>'+ result.davalor('Nomecliente').asstring
                      +'<B> NIF:</B>'+ result.davalor('Ncontribuinte').asstring ;

              cells[Col_VDCONTACBL,i]:=result.davalor('ContaCBLTipoDOC').asstring;
              Ints[COL_VDID_VndCabdocumento,i]:=result.davalor('ID_documento').asinteger;
              Ints[COL_VDID_DocPMS,i]:=result.davalor('ID_documento').asinteger;
               Ints[COL_VDID_TipoDocPMS,i]:=result.davalor('ID_Tipodocumento').asinteger;
              cells[Col_VDTipolinha,i]:=result.davalor('TipoLinhaFich').asstring;


              cells[Col_VDnatureza,i]:=result.davalor('natureza').asstring;
              If result.davalor('Mercado').asinteger=1 then
              begin
                  RowColor[i] := clInfoBk;
                  Inc(TotNac);



              end
              else
              If result.davalor('Mercado').asinteger=2 then
              begin
                  RowColor[i] := clYellow;
                  inc(TotIntCom);
              end
              else
              If result.davalor('Mercado').asinteger=3 then
              begin
                  RowColor[i] :=$00B3ACF0 ;
                  inc(TotExtraCom);
              end;

            end;


              If result.davalor('tipoMovimento').asinteger=1 then//pagamento
              begin
                If ((Not(FOmitirValoresZero)) or   (result.davalor('Valor').asFloat<>0)) then
                        AdicionaLinhaValorPagamento(result,DadosNos,i)
              end
              else
              If result.davalor('tipoLinha').asinteger=0 then
              begin
                If ((Not(FOmitirValoresZero)) or   (result.davalor('Valor').asFloat<>0)) then
                begin
                 IncrementaNos(result.davalor('DescricaoTipoDoc').asstring,i,
                 result.davalor('valor').asfloat, DadosNosTotais);
                 AdicionaLinhaValorSemIVa(result,DadosNos,i);
               end;

              end
              else
              If result.davalor('tipoLinha').asinteger=1 then
              begin
                If ((Not(FOmitirValoresZero)) or   (result.davalor('Valorlinha').asFloat<>0)) then
                begin
                 IncrementaNos(result.davalor('DescricaoTipoDoc').asstring,i,
                 result.davalor('valor').asfloat, DadosNosTotais);
                 AdicionaLinhaValorDOIVa(result,dadosNos,i);
                end;

            end;

            result.seguinte;
          end;
          If Assigned(DadosNos) Then
          Begin
               For i:=0 to DadosNos.Num-1 Do
               begin
                 valor:=DadosNos.elem[i].Valor;
                 cells[Col_VDDESCricao,DadosNos.elem[i].Posicao]:=
                    cells[Col_VDDESCricao,DadosNos.elem[i].Posicao]
                     +'<B>  Valor:</B> '+CurrToStrF(valor,ffnumber,2);
                 AddNode(DadosNos.elem[i].Posicao, DadosNos.elem[i].NumFilhos);

           Adicionalinha(ints[COL_VDID_TipoDocPMS,DadosNos.elem[i].Posicao],
               cells[COL_VDDescTipoDocPMS,DadosNos.elem[i].Posicao], valor,1);

               end;
          End;
          endUpdate;

        end;


    Finally
      edNacional.text:=inttostr(TotNac);
      edInter.text:=inttostr(TotIntCom);
      EdExtra.text:=inttostr(TotExtraCom);
      Progresso.Position:= 100;
      FreeAndnil(DadosNos);

      If Assigned(DadosNosTotais) Then
          Begin
               For i:=0 to DadosNosTotais.Num-1 Do
               begin
               end;
          End;
       FreeAndnil(DadosNosTotais);
    end;
    end;

end;


procedure TFrmPmsIERPPrimveraCBL.RemoveNodes;
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

procedure TFrmPmsIERPPrimveraCBL.BtsairClick(Sender: TObject);
begin
  inherited;
self.close;
end;


procedure TFrmPmsIERPPrimveraCBL.AtualizaGrelhatotais;
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

procedure TFrmPmsIERPPrimveraCBL.BtActualizarClick(Sender: TObject);
var strsqlTotais:string;
merros:string;
begin
  inherited;
 Tssberros.TabVisible:=false;
 memoErros.clear;

 If ValidaIntervalorDatas then
 begin
  GrelhaTotais.clearnormalcells;
  GrelhaTotais.rowcount:=  GrelhaTotais.Fixedrows+1;
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
               AtualizaGrelhatotais;
               PreechecorGrelhaTotal;
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

procedure TFrmPmsIERPPrimveraCBL.GrelhaGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if (ARow>0) And (ACOL in[Col_VDVALOR]) then
    HAlign:=taRightJustify;

end;


Function TFrmPmsIERPPrimveraCBL.GeraFicheiroPrimavera(var pNomeficheiro:string):boolean;
var
   strHotel:string;
begin

end;




procedure TFrmPmsIERPPrimveraCBL.acExportarExecute(Sender: TObject);
var
    NomeFicheiro:string;
    segue:Boolean;
    GerouFicheiroVendas:Boolean;
    CamInhoFicheiroVendas:String;
    GerouFicheiroRecibos:Boolean;
    CamInhoFicheiroRecibos:String;
    merros:string;
    ID_Interface,i:Integer;
    ListaErros:tstringlist;
begin
  inherited;
  Tssberros.TabVisible:=false;
  memoErros.Clear;
  BtExportarvendas.enabled:=false;
  screen.cursor:=crhourglass;
  ID_Interface:=0;
  ListaErros:=tstringlist.create;
  TRy
   PMSIntfPrimaveraCBL0900.FNaoInterrompeExportaOqueconsegue:=false;
   PMSIntfPrimaveraCBL0900.FNaoInterrompeExportaOqueconsegue:=CbExportaoqueconsegue.checked;
   if ExportarVendasManual(FLista,ListaErros) then
   begin

       If   FPrimeiraExportacao=true  then
       begin
         sb.SBBD.Executa('update ERP_EMPRESAINTERFACE set DATAInicioExportacao='+sb.UtilSQL.DataToSQLData(dtdataInicio.date)
          +' where id='+inttostr(FOBJInterface.id));
       end;
         sb.SBBD.Executa('update ERP_EMPRESAINTERFACE set DATAUltimaExportacao='+sb.UtilSQL.DataToSQLData(dtdataFim.date)
          +' where id='+inttostr(FOBJInterface.id)
          +' and isnull(DATAUltimaExportacao,0)<'+sb.UtilSQL.DataToSQLData(dtdataFim.date)
          );

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
         If PMSIntfPrimaveraCBL0900.FOBJInterface<>nil then
         begin
            ID_Interface:=  PMSIntfPrimaveraCBL0900.FOBJInterface.ID;
            PMSIntfPrimaveraCBL0900.FOBJInterface:=nil;
            PMSIntfPrimaveraCBL0900.FOBJInterface:=MotorERP.ERPInterface.Edita(ID_Interface);
            dtdataInicio.Date:=DaDataInicioExportacao(PMSIntfPrimaveraCBL0900.FOBJInterface);
            If PMSIntfPrimaveraCBL0900.FOBJInterface.TipoPeriodExportacao=1 then
                   gbData.enabled:=false;
         end;
       end;
   end
   else
   sb.dialogos.sbAviso('Não foi possível exportar!')
  Finally
    screen.cursor:=crdefault;

  end;
END;



procedure TFrmPmsIERPPrimveraCBL.acactualizarExecute(Sender: TObject);
begin
  inherited;
Preenchegrelha;
end;




procedure TFrmPmsIERPPrimveraCBL.btLimparClick(Sender: TObject);
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

procedure TFrmPmsIERPPrimveraCBL.Contrair1Click(Sender: TObject);
begin
  inherited;
 Grelha.ContractAll;
end;

procedure TFrmPmsIERPPrimveraCBL.Expandir1Click(Sender: TObject);
begin
  inherited;
 Grelha.ExpandAll;
end;




procedure TFrmPmsIERPPrimveraCBL.PreechecorGrelhaTotal();
begin
  inherited;
end;



Procedure TFrmPmsIERPPrimveraCBL.PreencheParametrosGerais();
var
   Lstdados:TSBBETabelaDados;
   FRefleteClasseIva,
   FRefleteAnalitica,
   FRefleteCentroCusto,
   FDiario,strsql,FConnectionString:string;
begin

    strsql:='Select * from ERP_CBLParametros where ID_EmpresaInteraface='+IntToStr(FIDInterface);
    Lstdados:=sb.SBBD.AbrirLV(strsql);
    If Not(Lstdados.Vazia) then
    begin
      FConfPorTipoDoc:=true;
      FEnviaLinhaIva:=Lstdados.daValor('EnviaLinhaIVA').asBoolean;
      FRefleteClasseIva:=Lstdados.daValor('RefleteClasseIva').asstring;
      FRefleteAnalitica:=Lstdados.daValor('RefleteAnalitica').asstring;
      FRefleteCentroCusto:=Lstdados.daValor('RefleteCentroCustos').asstring;
      FDiario:=Lstdados.daValor('diario').asstring;
    end;
    freeandnil(Lstdados);
end;

procedure TFrmPmsIERPPrimveraCBL.PreencheHotel(pid_Hotel:Integer=0);
var
  SQL:string;
  ListaH:tsbbetabeladados;
begin

     SQL := ' Select   mpehotel,short'
          + ' from '+FShemaProtel+'Lizenz';
          If pid_Hotel>0 then
          begin
            sql:=SQL+' where mpehotel='+Inttostr(pid_Hotel);
          end;

     ListaH:=sb.SBBD.AbrirLV(SQL);
     Try
       If ListaH.NumLinhas=1 then
       begin
        EpHotel.id_chave:=ListaH.davalor('mpehotel').asinteger;
        EpHotel.text:=ListaH.davalor('short').asstring;
       end;
     Finally
      FreeandnIl(ListaH);
     end;
end;

Procedure TFrmPmsIERPPrimveraCBL.SelecionaHotel(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  btLimpar.Click;
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        EpHotel.id_chave:=Obj.Chave;
        EpHotel.text:=Obj.ValorDescricao;

      End;
   Finally
     FreeAndNil(Obj);
   end;
end;




Function TFrmPmsIERPPrimveraCBL.DafiltroDocspms():string;
var
strsql:string;
Lista:tsbbetabeladados;
begin
  Result:='';
  strsql:='select distinct PMS_ID_TipoDoc from Primav_TipoDocCBL';


   Lista:=sb.SBBD.AbrirLV(FConnectionString ,strsql);
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


Procedure TFrmPmsIERPPrimveraCBL.SelecionaTipodoc(Sender :TObject);
Begin

end;








Procedure TFrmPmsIERPPrimveraCBL.LimpaGrelhas;
begin
    RemoveNodes;
    QTotais.close;
    gbData.enabled:=true;
end;



Function TFrmPmsIERPPrimveraCBL.DaMercado(pID_Pais:integer):integer;
begin
  Result:=1;
  if FListaContasMercado<>nil then
  If FListaContasMercado.dataset.locate('ID_Pais',pID_Pais,[]) then
   Result:=FListaContasMercado.dataset.fieldbyname('id_mercado').asinteger;
end;


procedure TFrmPmsIERPPrimveraCBL.CriaV_V_DocvendaPaisHospedePMS;
begin
 //Preciso de garantir que tras sempre dados

If FconexaoProtel<>'' then
begin
    Try
        sb.SBBD.AbrirLV(FconexaoProtel,' select top 1 * from Proteluser.V_DocvendaPrimeiraLinha');
    except
        sb.SBBD.ExecutaSqlExterno (FconexaoProtel,' Create View Proteluser.V_DocvendaPrimeiraLinha as'
        +' select  R.ref AS ID_internoCab,min(L.ref) as REF'
        +' from  Proteluser.rechhist R'
        +' inner join  Proteluser.leisthis L on L.fisccode=R.fisccode and L.rechnr=R.rechnr'
        +' GROUP BY  R.ref');
 
 

    end;

    Try
        sb.SBBD.AbrirLV(FconexaoProtel,' select top 1 * from Proteluser.V_DocvendaPaisHospede');
    except
        sb.SBBD.ExecutaSqlExterno(FconexaoProtel,' Create View Proteluser.V_DocvendaPaisHospede as'
        +' select distinct R.ref AS ID_internoCab,KHOS.landkz as ID_PaisHospede'
        +' from Proteluser.buchold B'
        +' inner join  Proteluser.rechhist R on R.resno=B.buchnr'
        +' inner join Proteluser.leisthis L on L.fisccode=R.fisccode and L.rechnr=R.rechnr'
        + ' inner join V_DocvendaPrimeiraLinha as PrimLinha on L.ref=PrimLinha.ref'
        + ' and PrimLinha.ID_internoCab=R.ref'
        +' inner join  Proteluser.kunden kHOS on KHOS.kdnr=L.kundennr'
        +' left join  Proteluser.natcode N on N.codenr=KHOS.landkz');


 
 


    end;
 end;

end;


Function TFrmPmsIERPPrimveraCBL.ValidaLicenca(pmpehotel:string;ptipoLicenca:Integer; var avisos:string):boolean;
var
  SBLista:TSBBETabelaDados;
  StrSql:String;
  Avisolicenca,Hotel:string;

begin
 result:=true;

end;

procedure TFrmPmsIERPPrimveraCBL.FormCreate(Sender: TObject);
begin
    Tssberros.TabVisible:=false;
    CbExportaoqueconsegue.Checked:=false;
    FIDINTERFACE:=0;
    edndoc.Text:='';
    grpndoc.Visible:=Uppercase(sb.UtilizadorActual.Login)='MICRONET';
    If InterfaceCBLProtelValido=true then
    begin
      FconexaoProtel:=FOBJInterface.BDConexao;
      FIDInterface:=FOBJInterface.ID;
      FVendasProtel:=CriaEstruturaVendasProtel;
      FVendasPrimavera:=CriaEstruturaVendasPrimavera;
      PreencheParametrosGerais;
      FListaErroConfPagamentos:=tstringList.create;
      FListaErroConfContas:=tstringList.create;
    end;

end;






procedure TFrmPmsIERPPrimveraCBL.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 freeandnil(FListaErroConfContas);
  freeandnil(FListaErroConfPagamentos);
  If assigned(FListaContasMercado) then
  begin
    FListaContasMercado.Fecha;
    freeandnil(FListaContasMercado);
  end;
  Action:=cafree;
end;



Function  TFrmPmsIERPPrimveraCBL.DaDataInicioExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
var Ano, Mes, Dias: Integer;
    data:tdatetime;
     Listaex:Tsbbetabeladados;
Begin
  FPrimeiraExportacao:=true;
  If pObjInterface.DATAInicioExportacao>0 then
  begin
    result := pObjInterface.DATAInicioExportacao;
     If PMSIntfPrimaveraCBL0900.FOBJInterface.TipoPeriodExportacao=2 then
     begin
       Result:=PMSIntfPrimaveraCBL0900.DAultimoDataVendaExportado(PMSIntfPrimaveraCBL0900.FOBJInterface.ID);
       lbsbFim.Visible:=true;
       DtDatafim.Visible:=true;
       DtDatafim.Date:= DateUtils.EndOfTheMonth(Result);
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
       If PMSIntfPrimaveraCBL0900.FOBJInterface.TipoPeriodExportacao=2 then
       begin
         Result:=PMSIntfPrimaveraCBL0900.DAultimoDataVendaExportado(PMSIntfPrimaveraCBL0900.FOBJInterface.ID);
         lbsbFim.Visible:=true;
         DtDatafim.Visible:=true;
         DtDatafim.Date:=DateUtils.EndOfTheMonth(Result);;
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
procedure TFrmPmsIERPPrimveraCBL.GrelhaTotaisGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
   if (ARow>0) And (ACOL=COl_ResValor) then
    HAlign:=taRightJustify;
end;


Function TFrmPmsIERPPrimveraCBL.ValidaIntervalorDatas():boolean;
var
strmensagem,idsHoteis:string;
begin
 idsHoteis:='';
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
 If result =true then
 begin
  idsHoteis:= PMSIntfPrimaveraCBL0900.DaIDHoteis;
  If idsHoteis='' then
  begin
    result:=false;
    strmensagem:='<P align="center"> <FONT color="#00FF40" ><B> Interface mal configurado!</B></FONT><BR>Falta configurar os Hoteis.</P>';
    MostraMensagemInformacao(strmensagem);
  end;
 end;
end;


Procedure TFrmPmsIERPPrimveraCBL.MostraMensagemInformacao(pMensagem:string);
begin
    MensagemInformacao.HTMLText.Text:=pMensagem;
    MensagemInformacao.execute;

end;



end.


