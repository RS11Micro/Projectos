unit ERP_FrmGerarContasCBLClientes;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, StdCtrls,
  pngimage, AdvGroupBox,ERPBEEMPRESAINTERFACE,ADODB,sbbeconstipos,SBBEExcepcoes,sbcontrolos,
  AdvOfficeButtons, AdvOfficePager, HTMLChkList,iErpListasdef, Mask,
  AdvEdit, AdvMEdBtn, PlannerMaskDatePicker, AdvCombo, SBEditProcura,
  Grids, AdvObj, BaseGrid, AdvGrid, AdvSmoothMessageDialog;

type
  TFrmERPGerarContasCBLClientes = class(TForm)
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    BtExportarclientes: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtActualizar: TAdvToolBarButton;
    btLimpar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    Grelha: TAdvStringGrid;
    cbInterface: TComboBox;
    Label2: TLabel;
    Label1: TLabel;
    MessageDialogQueston: TAdvSmoothMessageDialog;
    procedure FormCreate(Sender: TObject);
    procedure BtActualizarClick(Sender: TObject);
    procedure BtExportarclientesClick(Sender: TObject);
  private
    { Private declarations }
    FObjinterface: TERPBEEMPRESAINTERFACE;
    Function DaIDInterface():Integer;
    Procedure AtualizaClientesPMS;
    Procedure FormataGrelha;
    Function  MensagemQuestao(pMensagem:string):boolean;
  public
    { Public declarations }
  end;


var
  FrmERPGerarContasCBLClientes: TFrmERPGerarContasCBLClientes;

implementation

Uses  IERPOGlobais, SBLista, SBBotoes, ERPBS,
  SBBSSistemaBase, ERPBSEMPRESAINTERFACE,IERPFrmPrincipal,sbbetabeladados,
  SBBaseDados;
{$R *.dfm}


  var

    FContadorLote,
  FEnviaLinhaIva,
  FOmitirLinhaIVA0perc,
  FOmitirValoresZero:Boolean;
  FRefleteClasseIva,
  FCONTACBLPAGCC,
  FReflecteFluxos,
  FRefleteAnalitica,
  FRefleteCentroCusto,
  FDiario,
  FTipoAfetacao:string;
  FcaminhoFicheiro,
  FModulo:string;
  ID_Pagamentocc:integer;
  FNumCasaDecimaisVL:integer;
  FVendasProtel,FVendasPrimavera:string;
  FFormatDecimalSQl:string;
  FShemaProtel:string;
  FContasIVASPorMercado:boolean;
  FClienteTabMETADATA:boolean;
  FExcluirDocsVndAnulados:boolean;
  FListaContasMercado:TSBBETabelaDados;

  Const
   Col_Nome=0;
   Col_Apelido=1;
   Col_NIPC=2;
   Col_Pais=3;
   COL_Mercado=4;

   COL_ContaCC=5;
   Col_ContaCCGerado=6;
   Col_Morada=7;
   Col_localidade=8;
   Col_Cpostal=9;
   Col_CTelefone=10;

   COL_ID_Cliente=11;
   COL_IDpais=12;
COL_paisISO=13;


   COL_Max=14;





Procedure TFrmERPGerarContasCBLClientes.FormataGrelha;
Var

  i:integer;
  strEstado:string;
Begin
  with Grelha do
  begin
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 2;
    RowCount := FixedRows + 1;
    ColCount := COL_Max;



    ColWidths[Col_Nome] := 120;
    ColWidths[Col_Apelido] := 120;
    ColWidths[Col_mercado] := 80;
    ColWidths[Col_NIPC] := 90;

    ColWidths[Col_localidade] := 80;
    ColWidths[Col_Cpostal] := 100;
    ColWidths[Col_CTelefone] := 100;

    ColWidths[Col_IDPais] := 50;
    ColWidths[Col_Pais] := 120;
    ColWidths[COL_ContaCC] := 80;
    ColWidths[Col_ContaCCGerado] := 80;
    ColWidths[Col_Morada] := 120;

    ColWidths[COL_ID_Cliente] := 0;


{    ColWidths[Col_Morada]:= Width -  ColWidths[Col_Nome] -
    ColWidths[Col_Apelido] - ColWidths[Col_ContaCCGerado] -
    ColWidths[Col_NIPC]-
    ColWidths[Col_localidade]-
    ColWidths[Col_mercado] -
    ColWidths[Col_Cpostal] -
    ColWidths[Col_CTelefone] -

    ColWidths[Col_IDPais] -
    ColWidths[Col_Pais] -
    ColWidths[COL_ContaCC] -
    ColWidths[COL_ID_Cliente]
- 21;        }

    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;
    ControlLook.NoDisabledButtonLook:=True;

    Cells[Col_Nome, 0] := SB.Idioma.daTraducao(0, 'Nome');
    Cells[Col_Apelido, 0] := SB.Idioma.daTraducao(0, 'Apelido');
    Cells[Col_NIPC, 0] := SB.Idioma.daTraducao(0, 'Contribuinte');
    Cells[Col_localidade, 0] := SB.Idioma.daTraducao(0, 'Localidade');
    Cells[Col_Cpostal, 0] := SB.Idioma.daTraducao(0, 'C.Postal');
    Cells[Col_Mercado, 0] := SB.Idioma.daTraducao(0, 'Mercado');
    Cells[Col_Pais, 0] := SB.Idioma.daTraducao(0, 'País');
    Cells[Col_Morada, 0] := SB.Idioma.daTraducao(0, 'Morada');
    Cells[Col_CTelefone, 0] := SB.Idioma.daTraducao(0, 'Telefone');

    MergeCells(Col_Nome,0,1,2);
    MergeCells(Col_Apelido,0,1,2);
    MergeCells(Col_NIPC,0,1,2);
    MergeCells(Col_localidade,0,1,2);
    MergeCells(Col_Cpostal,0,1,2);
    MergeCells(Col_Mercado,0,1,2);
    MergeCells(Col_Pais,0,1,2);
    MergeCells(Col_Morada,0,1,2);
    MergeCells(Col_CTelefone,0,1,2);

    Cells[COL_ContaCC, 0] := SB.Idioma.daTraducao(0, 'Conta CBL Cliente ');
    MergeCells(COL_ContaCC,0,2,1);
    Cells[COL_ContaCC, 1] := SB.Idioma.daTraducao(0, 'Atual');
    Cells[Col_ContaCCGerado, 1] := SB.Idioma.daTraducao(0, 'Nova');





    EndUpdate;
  end;
End;

Procedure PreencheVariavaisConfGerais(Pid:Integer);
var
  strsql:string;
    FConnectionString:string;
  Lstdados:TSBBETabelaDados;
begin
    id_Pagamentocc:=0;
    strsql:='Select * from ERP_CBLParametros where ID_EmpresaInteraface= '+Inttostr(pID);
    Lstdados:=sb.SBBD.AbrirLV(strsql);
    If Not(Lstdados.Vazia) then
    begin
      FModulo:=Lstdados.daValor('ModuloVnd').asstring;
      FOmitirValoresZero:=Lstdados.daValor('OmiteLinhaZero').asboolean;
      FNumCasaDecimaisVL:=Lstdados.daValor('NumCasaDecimaisVL').asinteger;
      FRefleteClasseIva:=Lstdados.daValor('RefleteClasseIva').asstring;
      FReflecteFluxos:=Lstdados.daValor('ReflecteFluxos').asstring;
      FRefleteAnalitica:=Lstdados.daValor('RefleteAnalitica').asstring;
      FRefleteCentroCusto:=Lstdados.daValor('RefleteCentroCustos').asstring;
      FDiario:=Lstdados.daValor('Diario').asstring;
      id_Pagamentocc:=Lstdados.daValor('id_Pagamentocc').asInteger;
      FContadorLote:=Lstdados.daValor('LoteIgualNDocumento').asBoolean;
      FTipoAfetacao  :=Lstdados.daValor('TipoAfetacao').asstring;

      FEnviaLinhaIva:=Lstdados.daValor('EnviaLinhaIVA').asBoolean;
      FOmitirLinhaIVA0perc:=Lstdados.daValor('OmitirLinhaIVA0perc').asboolean;
      If id_Pagamentocc>0 then
      begin
           strsql:='SELECT ContaCBL  FROM cBL_ModoPagamentoPMS '
            +' where PMS_ID_ModoPagamento='+Inttostr(id_Pagamentocc);
           Lstdados:=sb.SBBD.AbrirLV(strsql);
           FCONTACBLPAGCC:=Lstdados.davalor('ContaCBL').asstring;
      end;


    end;
    FreeAndnil(lstdados);
end;

procedure TFrmERPGerarContasCBLClientes.FormCreate(Sender: TObject);
var
SQL:string;
begin
 FObjinterface:=nil;
 FListaContasMercado:=sb.SBBD.AbrirLV('Select ID_Pais,id_Mercado from PMSPaisMercado');
 SQL := ' select ERP_EMPRESAINTERFACE.ID,'
          +' ERP_INTERFACE.nomeinterface+'' BD:''+ERP_EMPRESAINTERFACE.BDNOME as nomeinterface'
          +' from ERP_EMPRESAINTERFACE'
          +' inner join ERP_INTERFACE on '
          +' ERP_INTERFACE.id_interface=ERP_EMPRESAINTERFACE.id_interface'
          +' where  ERP_EMPRESAINTERFACE.ativo=1';
   PreencheStringList(cbInterface.Items,Motorerp.SB,SQL,'nomeinterface','ID',true);
FormataGrelha ;
end;


Function TFrmERPGerarContasCBLClientes.DaIDInterface():Integer;
var
        ObjItemLista:TSBItemLista;
begin
     ObjItemLista := DaItemLista(cbInterface.Items, cbInterface.ItemIndex);
     result:= ObjItemLista.Chave;
     If result>0 then
     begin
        If assigned(FObjinterface) then
            Freeandnil(FObjinterface);
        FObjinterface:=MotorERP.ERPInterface.Edita(result);

     end;

end;


Function DaMercado(pID_Pais:integer):integer;
begin
  Result:=1;
  if FListaContasMercado<>nil then
  If FListaContasMercado.dataset.locate('ID_Pais',pID_Pais,[]) then
   Result:=FListaContasMercado.dataset.fieldbyname('id_mercado').asinteger;
end;

Procedure TFrmERPGerarContasCBLClientes.AtualizaClientesPMS;
var
    SQL:string;
var
 schema:string;
 ListaClientes:Tsbbetabeladados;
 mercado,i,j,ttZeros:integer;
 ContaCBLClienteSug:string;
 CodClientePMS:string;
begin
    schema:=FObjinterface.BDSchema;
    SQL:=' select distinct kunden.kdnr, kunden.fibudeb as ContaCC'
         +', kunden.landkz as ID_Pais'
        +' ,Kunden.vatno as Ncontribuinte,'
         +' Kunden.vorname as Nome, Kunden.name1  as apelido,isnull(Kunden.strasse,'' '')as MoradaEntidade,'
        +' isnull(Kunden.ort,'' '') as localidadeEntidade,'
        + ' isnull(Kunden.plz,'' '') as codigopostalentidade,'
        + ' isnull(Kunden.telefonnr,'' '') as TelefoneEntidade,N.land as Pais,N.isocode'


        + ' from '+schema+'Leisthis '
        + ' inner join '+schema+'RECHHIST on '
        + schema+'RECHHIST.rechnr ='+schema+'Leisthis.rechnr '
        + '  and '+schema+'RECHHIST.Fisccode = '+schema+'Leisthis.Fisccode '
        + '   inner join '+schema+'kunden on kunden.kdnr=RECHHIST.kdnr '
        + 'inner  join '+schema+'zahlart  on zahlart.zanr=Leisthis.rkz '
        +' left join  '+schema+'natcode N on N.codenr=kunden.landkz '
        + ' where Leisthis.rkz='+Inttostr(ID_Pagamentocc)
        +' order by  Kunden.vorname , Kunden.name1';

    ListaClientes:=sb.SBBD.AbrirLV(SQL);
    Grelha.RowCount:= Grelha.FixedRows+ ListaClientes.NumLinhas;
    i:= Grelha.FixedRows;
    while Not(listaclientes.NoFim) do
    begin
       mercado:=1;
       CodClientePMS:=listaclientes.davalor('kdnr').asstring;
       If Length(CodClientePMS)<6 then
       begin
          ttZeros:=6-Length(CodClientePMS);
          For j:=0 to  ttZeros-1 do
            CodClientePMS:='0'+CodClientePMS;
       end;
       grelha.cells[Col_Nome,i]:= listaclientes.davalor('Nome').asstring;
       grelha.cells[Col_Apelido,i]:=listaclientes.davalor('apelido').asstring;
       grelha.cells[Col_NIPC,i]:=listaclientes.davalor('Ncontribuinte').asstring;
       grelha.cells[Col_Morada,i]:=listaclientes.davalor('MoradaEntidade').asstring;
       grelha.cells[Col_localidade,i]:= listaclientes.davalor('localidadeEntidade').asstring;
       grelha.cells[Col_Cpostal,i]:= listaclientes.davalor('codigopostalentidade').asstring;
       grelha.cells[Col_CTelefone,i]:= listaclientes.davalor('TelefoneEntidade').asstring;
       grelha.cells[Col_Pais,i]:=listaclientes.davalor('pais').asstring;
       grelha.cells[Col_ContaCC,i]:= listaclientes.davalor('ContaCC').asstring;
       grelha.Colors[Col_ContaCC,i]:=clInfoBk;
       grelha.Colors[Col_ContaCCGerado,i]:=clInfoBk;
       grelha.cells[Col_ID_Cliente,i]:= listaclientes.davalor('kdnr').asstring;
       grelha.cells[Col_IDpais,i]:=listaclientes.davalor('ID_Pais').asstring;
       grelha.cells[Col_paisISO,i]:=listaclientes.davalor('isocode').asstring;

       grelha.cells[Col_mercado,i]:='1';
       mercado:=DaMercado(listaclientes.davalor('ID_Pais').asinteger);
       If mercado>0 then
              grelha.cells[Col_mercado,i]:=inttostr(mercado);

       ContaCBLClienteSug:=  FCONTACBLPAGCC+inttostr(Mercado)+  CodClientePMS;
       grelha.cells[Col_ContaCCGerado,i]:= ContaCBLClienteSug;



       inc(i);
       listaclientes.seguinte;
    end;


end;

procedure TFrmERPGerarContasCBLClientes.BtActualizarClick(Sender: TObject);
var
id:integer;
begin
 id:=DaIDInterface;
 PreencheVariavaisConfGerais(id);
 If ID_Pagamentocc>0 then
 begin
         AtualizaClientesPMS;
 end
 else
  sb.Dialogos.SBAviso('Não é possível Listar os clientes!'+#13+'Por favor selecione o Interface, e certifique-se que este tem associado o Pagamento de conta corrente.');
end;

Function TFrmERPGerarContasCBLClientes.MensagemQuestao(pMensagem:string):boolean;
begin
    MessageDialogQueston.HTMLText.Text:=pMensagem;
    Result:=MessageDialogQueston.Execute;
end;


procedure TFrmERPGerarContasCBLClientes.BtExportarclientesClick(
  Sender: TObject);
var
 strmensagem:string;
 stsql:string;
 i:integer;
begin
  strmensagem:='Esta opção executa 2 operações:  <BR>'
            +'1->Exporta para a tabela "ERPCLIENTECC" a lista de clientes<BR>'
            +'2->Grava na Base e dados do Protel na Tabela "Kunden.Fibudeb" <BR>o novo Codigo CBL gerado'
            +' <BR>'
            +'<P align="center">'+'Deseja Continuar?'+'?</P><BR>';
  If MensagemQuestao(strmensagem) then
  begin
     for i:=grelha.fixedrows  to grelha.rowcount-1 do
     begin
     stsql:= ' INSERT INTO [CBL_PMSClientesCC] '
           +'([ID_ClientePMS] '
           +',[ContaCBL]  '
           +',[Nome] '
           +',[Apelido] '
           +',[Morada]'
           +',[Localidade]'
           +',[CodPostal]'
           +',[Telefone]'
           +',[ID_Pais]'
           +',[Pais]'
           +',[PAISISO]'
           +',[Ncontribuinte])'
           +' VALUES ('
           +  grelha.cells[COL_ID_Cliente,i] +','
           +   sb.UtilSQL.StrToSQLStrpelica(grelha.cells[Col_ContaCCGerado,i])+','
           +  sb.UtilSQL.StrToSQLStrpelica(grelha.cells[Col_Nome,i]) +','
           +  sb.UtilSQL.StrToSQLStrpelica(grelha.cells[Col_Apelido,i]) +','
           +  sb.UtilSQL.StrToSQLStrpelica(grelha.cells[Col_Morada,i]) +','
           + sb.UtilSQL.StrToSQLStrpelica( grelha.cells[Col_localidade,i]) +','
           + sb.UtilSQL.StrToSQLStrpelica( grelha.cells[Col_Cpostal,i]) +','
           +  sb.UtilSQL.StrToSQLStrpelica(grelha.cells[Col_CTelefone,i]) +','

           +  grelha.cells[COL_IDpais,i] +','
           +  sb.UtilSQL.StrToSQLStrpelica(grelha.cells[Col_Pais,i] )+','
           +  sb.UtilSQL.StrToSQLStrpelica(grelha.cells[COL_paisISO,i]) +','
           +  sb.UtilSQL.StrToSQLStrpelica(grelha.cells[Col_NIPC,i]) +')';

       sb.SBBD.Executa(stsql);
{       stsql:=' Update '+FObjinterface.BDSchema+'Kunden '
              +' set fibudeb='+sb.UtilSQL.StrToSQLStrpelica(grelha.cells[Col_ContaCCGerado,i])
              +' where Kunden.kdnr='+ sb.UtilSQL.StrToSQLStrpelica(grelha.cells[COL_ID_Cliente,i]);
       SB.SBBD.Executa(stsql);}
      end;

  end;

end;

end.
