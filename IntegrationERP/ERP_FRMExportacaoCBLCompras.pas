unit ERP_FRMExportacaoCBLCompras;

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
  AdvMemo,ERPPrimaveraCBLCompras,dateutils,ERPLogOperacoes,
  AdvSmoothMessageDialog;
type
  TFRMERPExportacaoCBLCompras = class(TForm)
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    BtExportar: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    btLimpar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvPanel1: TAdvPanel;
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
    Grelha: TAdvStringGrid;
    PanelTotCmp: TAdvPanel;
    Label4: TLabel;
    lbTotaldocAnt: TLabel;
    StTotalDocmp: TStaticText;
    stTotalDoCCmpAnt: TStaticText;
    gbData: TAdvGroupBox;
    lbsbInicio: TLabel;
    lbsbFim: TLabel;
    dtdataInicio: TPlannerMaskDatePicker;
    CbMovimentosIntDatas: TAdvOfficeRadioGroup;
    GbIDInternosStocks: TAdvGroupBox;
    Label5: TLabel;
    edidsInternos: TEdit;
    DtDatafim: TPlannerMaskDatePicker;
    MensagemInformacao: TAdvSmoothMessageDialog;

    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtActualizarClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Contrair1Click(Sender: TObject);
    procedure Expandir1Click(Sender: TObject);
    procedure acExportarExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure GrelhaGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure GrelhaGridHint(Sender: TObject; ARow, ACol: Integer;
      var hintstr: String);
    procedure btLimparClick(Sender: TObject);
  private
    { Private declarations }
   FListaDocs:TSBBETabelaDados;
   FIDInterface:integer;
   FComprasEstadoAberto:integer;
   FTotDocsDataDocInferior:integer;
   FListaContasMercado:TSBBETabelaDados;
   FPrimeiraExportacao:boolean;
   FcontasPorConfigurar:boolean;
   FMensagemDocsComIVANDedutivel :String;
   ListaDocsIVANDedutivel:tstringlist;
   Function  DaDataInicioExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
   Procedure FormataGrelha;
   Function  PreenchegrelhaCompras():TSBBETabelaDados;   
   Procedure InicializaForm ;
   Procedure RemoveNodes;
   procedure AdicionaLinhaContaAnalitica(pListaDados:TSBBETabelaDados; var pid_Linha:integer);
   procedure AdicionaLinhaCentroCusto(pListaDados:TSBBETabelaDados; var pid_Linha:integer);

   Procedure ColocaImagemEstado(pEstado, pLinha: Integer);
   Function DaMercado(pID_Pais:integer):integer;
   Procedure MostraMensagemInformacao(pMensagem:string);

  public
    { Public declarations }
   Procedure AbreFormulario;

   Property IDInterface:integer read FIDInterface  write   FIDInterface;
  end;

var
  FRMERPExportacaoCBLCompras: TFRMERPExportacaoCBLCompras;

implementation
uses IERPOGLobais, strutils, FntBS,
  SBBSIdiomas, SBBSUtilSQL, SBBSSistemaBase, SBBaseDados,
  SBBaseDadosADOAbs, ERPBSEMPRESAINTERFACE,IERPFrmPrincipal;


{$R *.dfm}
Const

  Col_VDArv=0;
  Col_VDsubfamilia=1;
  Col_VDDESCricao=2;
  Col_VDTLinha=3;
  Col_VDTDiario=4;
  Col_VDCONTACBL=5;

  Col_VDClasseIVA=6;
  Col_VDClasseIVAAL=7;
  Col_VDContaOrigem=8;
  Col_VDVALOR=9;
  Col_VDPercIVANDed=10;
  Col_VDVALORIVANDed=11;
  Col_VDNatureza=12;

  COL_StockImgEstado=13;
  Col_StockEstado=14;

  COL_VDID_VndCabdocumento=15;

  Col_VDMaxCols=16;


Function  TFRMERPExportacaoCBLCompras.DaDataInicioExportacao(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
var Ano, Mes, Dias: Integer;
    data:tdatetime;
     Listaex:Tsbbetabeladados;
Begin
  FPrimeiraExportacao:=true;
  If pObjInterface.DATAInicioExportacao>0 then
  begin
         result := pObjInterface.DATAInicioExportacao;
     If ERPPrimaveraCBLCompras.FOBJInterface.TipoPeriodExportacao=2 then
     begin
       If ERPPrimaveraCBLCompras.FOBJInterface.DATAUltimaExportacao>0 then
         Result:=ERPPrimaveraCBLCompras.FOBJInterface.DATAUltimaExportacao+1;
       lbsbFim.Visible:=true;
       DtDatafim.Visible:=true;
       DtDatafim.Date:=DateUtils.EndOfTheMonth(Result);
      end         
  end;
  Listaex:=sb.sbbd.abrirlv('select * from ERP_CBLCmpCabec');
  If Not(Listaex.vazia) then
  begin

    If pObjInterface.DATAInicioExportacao>0 then
    begin
       FPrimeiraExportacao:=false;
       If ERPPrimaveraCBLCompras.FOBJInterface.TipoPeriodExportacao=2 then
        begin
        If ERPPrimaveraCBLCompras.FOBJInterface.DATAUltimaExportacao>0 then
          Result:=ERPPrimaveraCBLCompras.FOBJInterface.DATAUltimaExportacao+1;
        lbsbFim.Visible:=true;
        DtDatafim.Visible:=true;
        DtDatafim.Date:=DateUtils.EndOfTheMonth(Result);
       end
      else
      begin
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

Procedure TFRMERPExportacaoCBLCompras.ColocaImagemEstado(pEstado, pLinha: Integer);
Var
  Index: Integer;
Begin
  Case pEstado Of
    0 : Index := 78;
    1 : Index := 79;
  End;

  Grelha.AddImageIdx(COL_StockImgEstado, pLinha, Index, haCenter, vaCenter);
End;


procedure TFRMERPExportacaoCBLCompras.RemoveNodes;
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



Procedure TFRMERPExportacaoCBLCompras.FormataGrelha;

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
    ColWidths[Col_VDTDiario] := 35;



    ColWidths[Col_VDContaOrigem] := 80;

    ColWidths[Col_VDClasseIVA] := 80;
    ColWidths[Col_VDClasseIVAAL] := 80;

      ColWidths[Col_VDPercIVANDed] := 45;
      ColWidths[Col_VDValorIVANDed] := 60;


    ColWidths[Col_VDVALOR] := 80;
    ColWidths[Col_VDNatureza] := 30;
    ColWidths[Col_StockEstado] := 0;
    ColWidths[COL_StockImgEstado] := 0;

    ColWidths[COL_StockImgEstado] := 30;
    ColWidths[Col_StockEstado] := 0;


    ColWidths[COL_VDID_VndCabdocumento] := 0;
    ColWidths[Col_VDsubfamilia] := 150;


    ColWidths[COL_VDDescricao]:= Width -ColWidths[Col_VDClasseIVAAL]- ColWidths[Col_VDsubfamilia]-ColWidths[Col_VDTLinha]-ColWidths[Col_VDArv]
    -ColWidths[Col_VDClasseIVA]-ColWidths[Col_VDCONTACBL]- ColWidths[Col_VDVALOR]-
                            ColWidths[Col_VDNatureza] - ColWidths[COL_VDID_VndCabdocumento]-
                              ColWidths[COL_StockImgEstado] -
            ColWidths[Col_StockEstado]- ColWidths[Col_VDContaOrigem]-
      ColWidths[Col_VDPercIVANDed] -
      ColWidths[Col_VDValorIVANDed] -

            21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine]+[goColsizing]-[goEditing];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;

    ControlLook.NoDisabledButtonLook:=True;


    Cells[Col_VDTDiario, 0] := SB.Idioma.daTraducao(0, 'Diario');
    Cells[Col_VDsubfamilia, 0] := SB.Idioma.daTraducao(0, 'Sub.Família');
    Cells[Col_VDDESCricao, 0] := SB.Idioma.daTraducao(42, 'Descrição');
    Cells[Col_VDCONTACBL, 0] := SB.Idioma.daTraducao(0, 'Conta CBL');
    Cells[Col_VDClasseIVA, 0] := SB.Idioma.daTraducao(0, 'Classe IVA');
    Cells[Col_VDClasseIVAAL, 0] := SB.Idioma.daTraducao(0, 'IVA AutoLiq.');

    Cells[Col_VDNatureza, 0] := SB.Idioma.daTraducao(0, 'Nat.');
    Cells[Col_VDvalor, 0] := SB.Idioma.daTraducao(0, 'Valor');
    Cells[Col_VDTLinha, 0] := SB.Idioma.daTraducao(0, 'T.Linha');
    Cells[Col_VDContaOrigem, 0] := SB.Idioma.daTraducao(0, 'Conta Origem');
    Cells[Col_VDValorIVANDed, 0] := SB.Idioma.daTraducao(0, 'V.IVA n/Ded.');
    Cells[Col_VDPercIVANDed, 0] := SB.Idioma.daTraducao(0, '%IVA n/Ded.');


    EndUpdate;
  end;
End;


Procedure TFRMERPExportacaoCBLCompras.AbreFormulario;
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

Procedure TFRMERPExportacaoCBLCompras.InicializaForm;

Begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  Top:=150;
  left:=15;
  Width:=FrmIERPPrincipal.Width-5;
  FcontasPorConfigurar:=false;
  Formatagrelha;
  ERPPrimaveraCBLCompras.FIDInterface:=FIDInterface;
  ERPPrimaveraCBLCompras.PreencheVariavaisConfGerais;
  If ERPPrimaveraCBLCompras.FOBJInterface<>nil then
  begin
          dtdataInicio.Date:=DaDataInicioExportacao(ERPPrimaveraCBLCompras.FOBJInterface);


  end;
  If ERPPrimaveraCBLCompras.FConnectionString<>'' then
  begin
        Try
          FListaContasMercado:=sb.SBBD.AbrirLV(FConnectionString,'Select ID_Pais,id_Mercado from PMSPaisMercado');
        Except
        end;
  end;

end;




Function TFRMERPExportacaoCBLCompras.PreenchegrelhaCompras():TSBBETabelaDados;
var
   filtro:string;
   DadosNos : TDadosnos;
   i:Integer;
   strexportado:string;
   TotDocs:integer;
   dataInicio,DataFim:Tdatetime;
   Contacbl:string;
   strmensagemDocSemIdFornecedor,DescDoc:string;

begin
   dataInicio:=0;
   DataFim:=0;
   If  ListaDocsIVANDedutivel<>nil then
     freeandnil(ListaDocsIVANDedutivel);
   ListaDocsIVANDedutivel:=tstringlist.create;
   strmensagemDocSemIdFornecedor:='';
   If filtraMaskData(dtdataInicio)>0 Then
      DataInicio:= dtdataInicio.date;
   If filtraMaskData(dtdatafim)>0 Then
      DataFim:= dtdatafim.date;

  FcontasPorConfigurar:=false;
  FComprasEstadoAberto:=0;
  FTotDocsDataDocInferior:=0;
  stTotalDoCCmpAnt.Caption:='0';
  StTotalDocmp.caption:='0';
  TotDocs:=0;
  Filtro:='  FntInterFaceCenExp.ID_InterFaceCenExp='+IntTostr(FID_InterfaceCenExp);
  IF edidsInternos.text<>'' then
      Filtro:=Filtro+' and MovimentoStock.id_Movimento in('+edidsInternos.text+')';

  If FOmitirValoresZero then
  begin
     filtro:= filtro + ifthen(Length(Filtro)>0,' And','') + ' MovimentoStock.ValorTotal<>0';
  end;
  Result:=ERPPrimaveraCBLCompras.DaListaDocumentosCompras1(filtro,DataInicio,DataFim);
  Btexportar.enabled:=Result.numlinhas>0;

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
            If  (Not(ExisteNo(result.davalor('ID_Movimento').asstring,DadosNos))) Then
            Begin
              strexportado:='';
              IncrementaNos(result.davalor('ID_Movimento').asstring, i, DadosNos);
              RowHeights[i]:=30;
              DescDoc:=  result.davalor('Tipodoc').asstring+
                      ' Nº '+ result.davalor('ID_documento').asstring+
                      ' NºInterno '+ result.davalor('ID_Movimento').asstring+
                      ' Data Doc:'+ result.davalor('Data').asstring+' '+
                      ' Data Mov:'+ result.davalor('DataMov').asstring+' '+
                      result.davalor('descricaoEntidade').asstring;
              cells[Col_VDsubfamilia,i]:=result.davalor('Tipodoc').asstring+
                      ' Nº '+ result.davalor('ID_documento').asstring+
                      ' NºInterno '+ result.davalor('ID_Movimento').asstring+
                      ' Data Doc:'+ result.davalor('Data').asstring+' '+
                      ' Data Mov:'+ result.davalor('DataMov').asstring+' '+
                      result.davalor('descricaoEntidade').asstring;
              If result.davalor('id_entidade').asinteger<=0 then
              begin
                 AddComment(Col_VDsubfamilia,i,'Atenção Documento sem Fornecedor');
                 RowColor[i] := clyellow;
                 If strmensagemDocSemIdFornecedor<>'' then
                     strmensagemDocSemIdFornecedor:=strmensagemDocSemIdFornecedor+#13;
                 strmensagemDocSemIdFornecedor:=strmensagemDocSemIdFornecedor+ '->'+cells[Col_VDsubfamilia,i];

              end;

              cells[Col_VDCONTACBL,i]:=result.davalor('VNDCONTACBL').asstring;
              Ints[COL_VDID_VndCabdocumento,i]:=result.davalor('ID_Movimento').asinteger;

               Ints[Col_StockEstado,i]:=result.davalor('Estado').asinteger;
             If  result.davalor('Estado').asinteger=0 then
                  Inc(FComprasEstadoAberto);
              ColocaImagemEstado(result.daValor('Estado').AsInteger, i);

             removeComment(Col_VDDESCricao,i);
             If result.davalor('CBLExportado').asboolean then
             begin
                  strexportado:= 'Já exportado por: '+result.davalor('CBLExportadoPor').asstring
                  +' em :'+result.davalor('CBLExportadoDTHora').asstring;
                AddComment(Col_VDDESCricao,i,strexportado);
             end;
             RowColor[i] := clInfoBk;
             If result.davalor('Data').asdatetime<dtdataInicio.Date then
             begin
                inc(FTotDocsDataDocInferior);
                RowColor[i] := clyellow;
             end;

             MergeCells(Col_VDsubfamilia, i, 3, 1);
             inc(TotDocs);
             rowcount:=rowcount+1;
             Inc(i);
            end;

            If ((Not(FOmitirValoresZero)) or   (result.davalor('valor').asFloat<>0)) then
            begin
              IncrementaNos(result.davalor('ID_Movimento').asstring, i, DadosNos);
              If result.davalor('tipolinha').asstring='4' then  //pagamento
              begin
                cells[Col_VDsubfamilia,i]:=result.davalor('DescricaoLinha').asstring;
                FontStyles[Col_VDsubfamilia,i]:=[fsbold];
                MergeCells(Col_VDsubfamilia,i,2,1);
              end
              else
              begin
                cells[Col_VDDESCricao,i]:=result.davalor('DescricaoLinha').asstring;
                cells[Col_VDsubfamilia,i]:=result.davalor('subfamilia').asstring;
                If   result.davalor('tipolinha').asstring='0' then
                begin
                  Floats[Col_VDValorIVANDed, i] :=result.davalor('ValorIvaNaoDedutivel').asfloat;
                  cells[Col_VDPercIVANDed, i] :=result.davalor('percIvaNaoDedutivel').asstring+'%';
                  If result.davalor('percIvaNaoDedutivel').asfloat<>0 then
                  begin
                   If  ListaDocsIVANDedutivel.IndexOf(DescDoc) =-1 then
                       ListaDocsIVANDedutivel.add(DescDoc);
                    FontStyles[Col_VDPercIVANDed,i]:=[fsbold];
                   Fontcolors[Col_VDPercIVANDed,i]:=clgreen;                    
                   colors[Col_VDPercIVANDed,i]:=clBLUE;
                  end;

                end;
              end;

              cells[Col_VDNatureza,i]:=result.davalor('Natureza').asstring;
              cells[Col_VDTLinha,i]:=result.davalor('LinhaFich').asstring ;

              cells[Col_VDTDiario,i]:=result.davalor('DiarioDoc').asstring ;
              cells[Col_VDCONTACBL,i]:=result.davalor('CONTA').asstring;

              Contacbl:= result.davalor('CONTA').asstring;
              Contacbl:=TrimLeft(Contacbl);
              Contacbl:=TrimRight(Contacbl);

              If Length(Contacbl)<=0 then
              begin
               rowcolor[i]:=clred;
               fcontasPorconfigurar:=true;
              end;
              cells[Col_VDClasseIVA,i]:=result.davalor('ClasseIVA').asstring;
              cells[Col_VDClasseIVAAL,i]:=result.davalor('ClasseIVAAL').asstring;


              Floats[Col_VDVALOR,i]:=result.davalor('valor').asFloat;
              cells[Col_VDCONTAOrigem,i]:=result.davalor('CONTAOrigem').asstring;
              Ints[COL_VDID_VndCabdocumento,i]:=result.davalor('ID_Movimento').asinteger;
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
    stTotalDoCCmpAnt.Caption:=inttostr(FTotDocsDataDocInferior);
    StTotalDocmp.caption:=inttostr(TotDocs);
    If strmensagemDocSemIdFornecedor<>'' then
    begin
     sb.Dialogos.SBAviso('Os seguintes Documentos não tem ID de Fornecedor!'+#13+strmensagemDocSemIdFornecedor
     +'Por favor Verifique!');
    end;





end;




procedure TFRMERPExportacaoCBLCompras.BtsairClick(Sender: TObject);
begin
 SELF.CLOSE;
end;

procedure TFRMERPExportacaoCBLCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If assigned(FListaContasMercado) then
  begin
    FListaContasMercado.Fecha;
    freeandnil(FListaContasMercado);
  end;
 ACTION:=CAFREE;
end;


Function TFRMERPExportacaoCBLCompras.DaMercado(pID_Pais:integer):integer;
begin
  Result:=1;
  if FListaContasMercado<>nil then
  If FListaContasMercado.dataset.locate('ID_Pais',pID_Pais,[]) then
   Result:=FListaContasMercado.dataset.fieldbyname('id_mercado').asinteger;
end;

procedure TFRMERPExportacaoCBLCompras.BtActualizarClick(Sender: TObject);
var
strmensagem:string;
begin
    screen.cursor:=crhourglass;
    Try
        FListaDocs:= PreenchegrelhaCompras;
        If ListaDocsIVANDedutivel.Count>0 then
        begin
            strmensagem:='<P align="center"> <FONT color="#00FF40" ><B>INFORMAÇÃO: Existem '+Inttostr(listaDocsIVANDedutivel.Count)+' documentos, com IVA NÃO DEDUTIVEL</B></P>'
            +#13+' <BR>Antes de Exportar verifique se estes dados estão corretos!';
            MostraMensagemInformacao(strmensagem);

        end;
    Finally
      screen.cursor:=crdefault;
    end;
end;



procedure TFRMERPExportacaoCBLCompras.AdicionaLinhaCentroCusto(pListaDados:TSBBETabelaDados; var pid_Linha:integer);
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
    //  cells[Col_VDClasseIVA,i]:=pListaDados.davalor('ClasseIva').asstring;
      cells[Col_VDCONTACBL,i]:=pListaDados.davalor('ContaCCusto').asstring;
      cells[Col_VDContaOrigem,i]:=pListaDados.davalor('ProdContCBL').asstring;
      Colors [Col_VDCONTACBL,i]:=clWindow;
      Colors [Col_VDClasseIVA,i]:=clWindow;



      If cells[Col_VDCONTACBL,i]='' then
      begin
       Colors [Col_VDCONTACBL,i]:=clred;
       FcontasPorConfigurar:=true;
      end;



      Floats[Col_VDVALOR,i]:=pListaDados.davalor('valor').asFloat;
      Ints[COL_VDID_VndCabdocumento,i]:=pListaDados.davalor('ID_Movimento').asinteger;



      If  pListaDados.davalor('TipoOperacao').asstring='0' then
          cells[Col_VDNatureza,i]:='C'
      else
            cells[Col_VDNatureza,i]:='D';
   end;
end;


procedure TFRMERPExportacaoCBLCompras.AdicionaLinhaContaAnalitica(pListaDados:TSBBETabelaDados; var pid_Linha:integer);
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
    //  cells[Col_VDClasseIVA,i]:=pListaDados.davalor('ClasseIva').asstring;
      cells[Col_VDCONTACBL,i]:=pListaDados.davalor('ContaAnalitica').asstring;

      Colors [Col_VDCONTACBL,i]:=clWindow;         
      Colors [Col_VDClasseIVA,i]:=clWindow;

      If cells[Col_VDCONTACBL,i]='' then
      begin
       Colors [Col_VDCONTACBL,i]:=clred;
       FcontasPorConfigurar:=true;
      end;



      Floats[Col_VDVALOR,i]:=pListaDados.davalor('valor').asFloat;
      Ints[COL_VDID_VndCabdocumento,i]:=pListaDados.davalor('ID_Movimento').asinteger;



      If  pListaDados.davalor('TipoOperacao').asstring='0' then
          cells[Col_VDNatureza,i]:='C'
      else
            cells[Col_VDNatureza,i]:='D';
   end;
end;


procedure TFRMERPExportacaoCBLCompras.MenuItem1Click(Sender: TObject);
begin
 Grelha.ContractAll;
end;

procedure TFRMERPExportacaoCBLCompras.MenuItem2Click(Sender: TObject);
begin
 Grelha.ExpandAll;
end;

procedure TFRMERPExportacaoCBLCompras.Contrair1Click(Sender: TObject);
begin
    Grelha.ContractAll;
end;

procedure TFRMERPExportacaoCBLCompras.Expandir1Click(Sender: TObject);
begin
 Grelha.ExpandAll;
end;


Function TestaConexaoBDExterna(pConexao:string):boolean;

begin
    Result:=false;
    If assigned(FConexao) then
     FreeAndnil(FConexao);
    FConexao:=TADOConnection.Create(nil);
    FConexao.ConnectionString:=pConexao;
    FConexao.LoginPrompt:=False;
    Try
        FConexao.Open;
       If FConexao.Connected then
          Result:=true;

    except
        result:=false;
    end;
    If  Not(result) then
    begin
        FConexao.Close;
        Freeandnil(FConexao);
    end
    else
    begin
    end;
end;








procedure TFRMERPExportacaoCBLCompras.acExportarExecute(Sender: TObject);
var
exportou:boolean;
ID_Interface:integer;
begin
  BtExportar.enabled:=false;
  exportou:=false;
  screen.cursor:=crhourglass;
  ID_Interface:=0;
  Try
      If  assigned(FListaDocs) then
      begin
       If FListaDocs.numLinhas>0 then
       begin
        FcontasPorConfigurar:=false;
        If Not(FcontasPorConfigurar) then
        begin
            If ERPPrimaveraCBLCompras.ExportarComprasManual(FListaDocs) then
            begin
                 exportou:=true;
                 If   FPrimeiraExportacao=true  then
                 begin
                   sb.SBBD.Executa('update ERP_EMPRESAINTERFACE set DATAInicioExportacao='+sb.UtilSQL.DataToSQLData(dtdataInicio.date)
                    +' where id='+inttostr(FOBJInterface.id));
                 end;
                   sb.SBBD.Executa('update ERP_EMPRESAINTERFACE set DATAUltimaExportacao='+sb.UtilSQL.DataToSQLData(dtdataFim.date)
                    +' where id='+inttostr(FOBJInterface.id));



                 MarcaMovimentosComoExportados(dtdataInicio.date,dtdatafim.date,FListaDocs,'ERP_CBL_COMPRAS');
                 RegistaLogOperacao('Operação:Exportação CBL Compras SYSController');
                 sb.Dialogos.SBMessage('Exportação efetuada com Sucesso!'+#13
                 +' Entre:'+datetimetostr(dtdatainicio.date) +' a '+datetimetostr(dtdatafim.date));
                 RemoveNodes;
                 If ERPPrimaveraCBLCompras.FOBJInterface<>nil then
                 begin
                    ID_Interface:=  ERPPrimaveraCBLCompras.FOBJInterface.ID;
                    ERPPrimaveraCBLCompras.FOBJInterface:=nil;
                    ERPPrimaveraCBLCompras.FOBJInterface:=MotorERP.ERPInterface.Edita(ID_Interface);
                    dtdataInicio.Date:=DaDataInicioExportacao(ERPPrimaveraCBLCompras.FOBJInterface);
                    if ERPPrimaveraCBLCompras.FOBJInterface.TipoPeriodExportacao=1 then
                           gbData.enabled:=false;
                 end;
            end;
        end
        else
        begin
          screen.cursor:=crdefault;
          sb.Dialogos.SBMessage('Não é possível exportar!'+#13+'Verifique as Contas ERP.');
        end;
       end;
     end;
   Finally
     screen.cursor:=crdefault;
   end;

end;



procedure TFRMERPExportacaoCBLCompras.Button1Click(Sender: TObject);
begin
  FListaDocs.dataset.filtered:=false;
  FListaDocs.dataset.filter:='id_movimento=1';
  FListaDocs.dataset.filtered:=true;
end;

procedure TFRMERPExportacaoCBLCompras.GrelhaGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ARow>0) And (ACOL=Col_VDVALOR) then
    HAlign:=taRightJustify;
end;

procedure TFRMERPExportacaoCBLCompras.GrelhaGridHint(Sender: TObject; ARow,
  ACol: Integer; var hintstr: String);
begin

 If (Acol in [Col_VDsubfamilia,Col_VDDESCricao]) then
  Begin
    Grelha.IsComment(Acol,ARow,hintstr);
    If hintstr<>'' then
       Grelha.HTMLHint:=true
    Else
       Grelha.HTMLHint:=False;
 End;
end;

procedure TFRMERPExportacaoCBLCompras.btLimparClick(Sender: TObject);
begin
    edidsInternos.clear;
    RemoveNodes;
    FListaDocs.Fecha;
    Freeandnil(FListaDocs);
    BtExportar.enabled:=false;
end;


Procedure TFRMERPExportacaoCBLCompras.MostraMensagemInformacao(pMensagem:string);
begin
    MensagemInformacao.HTMLText.Text:=pMensagem;
    MensagemInformacao.execute;

end;

end.
