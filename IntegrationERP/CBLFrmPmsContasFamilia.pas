unit CBLFrmPmsContasFamilia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Grids, AdvObj, BaseGrid, AdvGrid, AdvToolBar,
  SBEditProcura,inifiles,sblista,SBControlos,adodb, StdCtrls, ExtCtrls,
  AdvPanel, AdvOfficePager,CBLOperInterfaceProtel,CBLFrmSeltipodoc;

type
  TFrmCBLPmsContasFamilia = class(TForm)
    epimagem: TSBEditProcura;
    a: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btSair: TAdvToolBarButton;
    btConfirmar: TAdvToolBarButton;
    ActionList1: TActionList;
    acSair: TAction;
    AcConfirmar: TAction;
    PopupNacional: TPopupMenu;
    AdicionaContasGrelha: TMenuItem;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    LDOC: TLabel;
    Replicar1: TMenuItem;
    BtReplicar: TAdvToolBarButton;
    AdvOfficePager1: TAdvOfficePager;
    tssbNAcional: TAdvOfficePage;
    tsbInterComunitario: TAdvOfficePage;
    tbextraComunitario: TAdvOfficePage;
    Grelha: TAdvStringGrid;
    Grelha1: TAdvStringGrid;
    popGrelhaComunitario: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    popmenuIntercomunitario: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Grelha2: TAdvStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GrelhaRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure GrelhaCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure GrelhaButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure GrelhaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure AcConfirmarExecute(Sender: TObject);
    procedure acSairExecute(Sender: TObject);
    procedure AdicionaContasGrelhaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Replicar1Click(Sender: TObject);
    procedure BtReplicarClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Grelha1RowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure Grelha2RowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure Grelha1ButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure Grelha2ButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure Grelha1ClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure Grelha2ClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Grelha1CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure Grelha2CanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);

  private
    { Private declarations }
    FShemaProtel:string;
    FContasPorMercado:boolean;
    FPOSID_TipoDocPMs:Integer;
    FPOSTipoDocPMs:string;
    FConfPorTipoDoc:Boolean;
    FlinhaSageCNC,FTipodocNotacredito:Boolean;
    FconexaoProtel:string;    
    procedure AtivaSeparadoresMercados;
    Function ConfiguracaoContasServicoPorTipoDoc():Boolean;
    procedure Replicar(pGrelha:TadvStringGrid;pColuna:Integer; plinha:Integer;pvalor:string);
    Procedure FormataGrelha(pGrelha:TadvStringGrid);
    Procedure SeleccionaContaFamiliaProtel(Sender :TObject);
    Procedure SeleccionaContaFamiliaProtel1(Sender :TObject);
    Procedure SeleccionaContaFamiliaProtel2(Sender :TObject);
    Procedure ObterConexao;

    Function  ProximaLinha(pGrelha:TadvStringGrid):Integer;
    Function  dacontasSeleccionados(pGrelha:TadvStringGrid):string;
    procedure AdicionaContasFamilias();
    procedure AdicionaContasFamilias1();

    procedure AdicionaContasFamilias2();
    procedure MostraPmsContasFamilia(pMercado:Integer;pGrelha:Tadvstringgrid);
    Function  GravaPmsContasFamilia(pMercado:Integer;pGrelha:Tadvstringgrid):Boolean;
    procedure AjustaColunasGrelha(pgrelha:Tadvstringgrid);
  public
    { Public declarations }

  Property  POSID_TipoDocPMs:Integer read    FPOSID_TipoDocPMs write FPOSID_TipoDocPMs;
  Property  POSTipoDocPMs:string read    FPOSTipoDocPMs write FPOSTipoDocPMs;
  Property  ConfPorTipoDoc:Boolean read    FConfPorTipoDoc write FConfPorTipoDoc;
   Property linhaSageCNC:boolean read FlinhaSageCNC write FlinhaSageCNC;
   Property TipodocNotacredito:boolean read FTipodocNotacredito write FTipodocNotacredito;


  end;

var
  FrmCBLPmsContasFamilia: TFrmCBLPmsContasFamilia;


implementation
uses IERPOGLOBAIS,SBBotoes,SBBETabelaDados, SBBaseDados, SBBSSistemaBase;

{$R *.dfm}
Const

  COL_ID_PmsContafamilia = 0;
  COL_PmsContaFamilia = 1;
  COL_ContaCblFamilia= 2;
  COL_ContaCbLIva = 3;
  COL_ClasseIVA = 4;
  COL_ContaCCusto = 5;
  COL_ContaAnalitica = 6;

  COL_ContaCblFamiliaD= 7;
  COL_ContaCbLIvaD = 8;
  COL_ClasseIVAD = 9;
  COL_ContaCCustoD = 10;
  COL_ContaAnaliticaD = 11;

  //contas cbl notas d credito com periodo de IVA diferente da fatura que creditam
  COL_ContaCBLFamiliaNCperIVAdifFACT = 12;
  COL_ContaCBLIVANCperIVAdifFACT = 13;
  COL_ClasseIVANCperIVAdifFACT = 14;
  COL_ContaCCustoNCperIVAdifFACT = 15;
  COL_ContaAnaliticaNCperIVAdifFACT = 16;
  Col_Max = 17;


Procedure TFrmCBLPmsContasFamilia.FormataGrelha(pGrelha:TadvStringGrid);
var
  i: Integer;
Begin
  with pGrelha do
  begin
    ShowHint := True;  
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 2;
    RowCount := 3;
    ColCount := COL_Max;


    ColWidths[COL_ID_PmsContafamilia] := 70;
    ColWidths[COL_PmsContaFamilia] := 100;
    If   Not (FlinhaSageCNC) then
    begin
        ColWidths[COL_ClasseIVA] := 80;
    end
    else
    begin
        ColWidths[COL_ClasseIVA] := 0;

    end;
    ColWidths[COL_ContaCbLIva] := 80;


    ColWidths[COL_ContaCblFamiliaD] := 70;
    ColWidths[COL_ContaCbLIvaD] := 80;
    ColWidths[COL_ClasseIVAD] := 80;

    ColWidths[COL_ContaCCusto] := 80;
    ColWidths[COL_ContaAnalitica] := 80;
    ColWidths[COL_ContaCCustoD] := 80;
    ColWidths[COL_ContaAnaliticaD] := 80;


    If TipodocNotacredito then
    begin
      ColWidths[COL_ContaCBLFamiliaNCperIVAdifFACT] := 80;
      ColWidths[COL_ContaCBLIVANCperIVAdifFACT] := 80;
      ColWidths[COL_ClasseIVANCperIVAdifFACT] := 80;
      ColWidths[COL_ContaCCustoNCperIVAdifFACT] := 80;
      ColWidths[COL_ContaAnaliticaNCperIVAdifFACT] := 80;
    end
    else
    begin
      ColWidths[COL_ContaCBLFamiliaNCperIVAdifFACT] := 0;
      ColWidths[COL_ContaCBLIVANCperIVAdifFACT] := 0;
      ColWidths[COL_ClasseIVANCperIVAdifFACT] := 0;
      ColWidths[COL_ContaCCustoNCperIVAdifFACT] := 0;
      ColWidths[COL_ContaAnaliticaNCperIVAdifFACT] := 0;
    end;

    ColWidths[COL_PmsContaFamilia]:= Width -ColWidths[COL_ContaCblFamiliaD]-
    ColWidths[COL_ContaCbLIvaD]-   ColWidths[COL_ClasseIVAD] -
    ColWidths[COL_ClasseIVA]- ColWidths[COL_ID_PmsContafamilia]- ColWidths[COL_ContaCblFamilia]
                             - ColWidths[COL_ContaCbLIva] -    ColWidths[COL_ContaCCusto]-
    ColWidths[COL_ContaAnalitica]-    ColWidths[COL_ContaCCustoD] -
    ColWidths[COL_ContaAnaliticaD]-
    ColWidths[COL_ContaCBLFamiliaNCperIVAdifFACT] -
    ColWidths[COL_ContaCBLIVANCperIVAdifFACT]-
    ColWidths[COL_ClasseIVANCperIVAdifFACT] -
    ColWidths[COL_ContaCCustoNCperIVAdifFACT] -
    ColWidths[COL_ContaAnaliticaNCperIVAdifFACT] -   21;

    Options:=  [goFixedVertLine]+[goColSizing]+[goFixedHorzLine] + [goHorzLine] + [goVertLine] + [goEditing];
    With Navigation do
    begin
      AllowDeleteRow:=True;
      AllowInsertRow:=True;
    end;
    If FlinhaSageCNC =true   then
       MergeCells(COL_ContaCblFamiliaD, 0, 2,1)
    else
      MergeCells(COL_ContaCblFamiliaD, 0, 5,1);

    MergeCells(COL_PmsContaFamilia, 0, 1,2);


    Alignments[COL_ContaCblFamilia, 0]:=taCenter;
    Alignments[COL_ContaCblFamiliaD, 0]:=taCenter;
    Cells[COL_ID_PmsContafamilia, 0] := SB.Idioma.daTraducao(0, 'Cod.Pms');
    Cells[COL_PmsContaFamilia, 0] := SB.Idioma.daTraducao(0, 'Desc.Pms');





     Cells[COL_ContaCblFamilia, 0] := SB.Idioma.daTraducao(0, 'Documento Crédito');
     Cells[COL_ContaCblFamiliaD, 0] := SB.Idioma.daTraducao(0, 'Documento Débito');

     If Not (FlinhaSageCNC) then
     begin
        MergeCells(COL_ContaCblFamilia, 0, 5,1);
     end
     else
     begin
        MergeCells(COL_ContaCblFamilia, 0, 2,1);
        Cells[COL_ContaCblFamilia, 0] := SB.Idioma.daTraducao(0, 'Contas Linhas Valor>=0');
        Cells[COL_ContaCblFamiliaD, 0] := SB.Idioma.daTraducao(0, 'Contas Linhas Valor<0');

     end;

    Cells[COL_ContaCblFamilia, 1] := SB.Idioma.daTraducao(0, 'Conta CBL');
    Cells[COL_ContaCbLIva, 1] := SB.Idioma.daTraducao(0, 'Conta IVA CBL');
    Cells[COL_ClasseIVA, 1] := SB.Idioma.daTraducao(0, 'Classe IVA');

    Cells[COL_ContaCblFamiliaD, 1] := SB.Idioma.daTraducao(0, 'Conta CBL');
    Cells[COL_ContaCbLIvaD, 1] := SB.Idioma.daTraducao(0, 'Conta IVA CBL');
    Cells[COL_ClasseIVAD, 1] := SB.Idioma.daTraducao(0, 'Classe IVA');

    Cells[COL_ContaCCusto, 1] := SB.Idioma.daTraducao(0, 'Conta C.Custo');
    Cells[COL_ContaAnalitica, 1] := SB.Idioma.daTraducao(0, 'Conta C.Anal.');

    Cells[COL_ContaCCustoD, 1] := SB.Idioma.daTraducao(0, 'Conta C.Custo');
    Cells[COL_ContaAnaliticaD, 1] := SB.Idioma.daTraducao(0, 'Conta C.Anal.');

    If TipodocNotacredito then
       Cells[COL_ContaCBLFamilia, 0] := SB.Idioma.daTraducao(0, 'Contas CBL IVAS N.Credito mesmo  periodo IVA FAturas');

    Cells[COL_ContaCBLFamiliaNCperIVAdifFACT, 0] := SB.Idioma.daTraducao(0, 'Contas CBL IVAS N.Credito periodo IVA Dif. FAturas');
    MergeCells(COL_ContaCBLFamiliaNCperIVAdifFACT, 0, 5,1);

    Cells[COL_ContaCBLFamiliaNCperIVAdifFACT, 1] := SB.Idioma.daTraducao(0, 'Conta CBL');

    Cells[COL_ContaCBLIVANCperIVAdifFACT, 1] := SB.Idioma.daTraducao(0, 'Conta IVA CBL');
    Cells[COL_ClasseIVANCperIVAdifFACT, 1] := SB.Idioma.daTraducao(0, 'Classe IVA');


    Cells[COL_ContaCCustoNCperIVAdifFACT, 1] := SB.Idioma.daTraducao(0, 'Conta C.Custo');
    Cells[COL_ContaAnaliticaNCperIVAdifFACT, 1] := SB.Idioma.daTraducao(0, 'Conta C.Anal.');






    EndUpdate;
  end;
End;


procedure TFrmCBLPmsContasFamilia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;



Procedure TFrmCBLPmsContasFamilia.ObterConexao;
var
  IDInterface:integer;
  Listaconf:tsbbetabeladados;
begin
   FContasPorMercado:=false;
   FShemaProtel:=DevolvechemaPms(IDInterface,FconexaoProtel);
   If IDInterface>0 then
   begin
      Listaconf:=sb.SBBD.AbrirLV('select ContasPorMercado from ERP_CBLParametros where ID_EmpresaInteraface='+Inttostr(IDInterface));
      If not Listaconf.Vazia then
        FContasPorMercado:= Listaconf.daValor('ContasPorMercado').asboolean;
      Listaconf.Fecha;
      Freeandnil(Listaconf);

   end
   else
   sb.Dialogos.SBMessage('Interface "CBLPROTEL"  não se encontra ativo!');

end;

Procedure TFrmCBLPmsContasFamilia.SeleccionaContaFamiliaProtel(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        Grelha.Ints[COL_ID_PmsContaFamilia,Grelha.Row]:=Obj.Chave;
        Grelha.Cells[COL_PmsContaFamilia,Grelha.Row]:=Obj.ValorDescricao;
         Grelha.rowcount:=Grelha.rowcount+1;
      End;
   Finally
     FreeAndNil(Obj);
   end;
end;

Procedure TFrmCBLPmsContasFamilia.SeleccionaContaFamiliaProtel1(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        Grelha1.Ints[COL_ID_PmsContaFamilia,Grelha1.Row]:=Obj.Chave;
        Grelha1.Cells[COL_PmsContaFamilia,Grelha1.Row]:=Obj.ValorDescricao;
         Grelha1.rowcount:=Grelha1.rowcount+1;
      End;
   Finally
     FreeAndNil(Obj);
   end;
end;


Procedure TFrmCBLPmsContasFamilia.SeleccionaContaFamiliaProtel2(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        Grelha2.Ints[COL_ID_PmsContaFamilia,Grelha2.Row]:=Obj.Chave;
        Grelha2.Cells[COL_PmsContaFamilia,Grelha2.Row]:=Obj.ValorDescricao;
         Grelha2.rowcount:=Grelha2.rowcount+1;
      End;
   Finally
     FreeAndNil(Obj);
   end;
end;


Function   TFrmCBLPmsContasFamilia.ProximaLinha(pgrelha:Tadvstringgrid):Integer;
var
   i:integer;
Begin
   Result:=-1;
   i:=1;
   While (i<= pgrelha.Rowcount-1) and (Result=-1) do
   begin
      If pgrelha.cells[COL_PmsContaFamilia,i]='' then
         Result:=i;
      Inc(i);
   end;
   If Result=-1 then
   Begin
      pgrelha.rowcount:=pgrelha.rowcount+1;
      Result:=pgrelha.rowcount-1
   end;
end;


procedure TFrmCBLPmsContasFamilia.GrelhaRowChanging(Sender: TObject;
  OldRow, NewRow: Integer; var Allow: Boolean);
begin

  RemoveBotaoGrelha(Grelha, COL_PmsContaFamilia, OldRow);

  if (NewRow >= Grelha.FixedRows) then
  begin
    If  Grelha.cells[COL_PmsContaFamilia, NewRow]='' then
            AdicionaBotaoGrelha(Grelha, COL_PmsContaFamilia, NewRow, epimagem.BtListaGlyph);
  end;
end;

procedure TFrmCBLPmsContasFamilia.GrelhaCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
canedit:=Acol in[COL_ContaCblFamilia,COL_ContaCbLIva,COL_ClasseIva,
                COL_ContaCblFamiliaD,COL_ContaCbLIvaD,
                COL_ClasseIvaD, COL_ContaCCusto, COL_ContaAnalitica,  COL_ContaCCustoD,
                COL_ContaAnaliticaD,  COL_ContaCBLFamiliaNCperIVAdifFACT,
                COL_ContaCBLIVANCperIVAdifFACT ,
                COL_ClasseIVANCperIVAdifFACT,
                COL_ContaCCustoNCperIVAdifFACT ,
                 COL_ContaAnaliticaNCperIVAdifFACT ];
end;

procedure TFrmCBLPmsContasFamilia.FormCreate(Sender: TObject);
begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  FPOSID_TipoDocPMs:=0;
  FlinhaSageCNC:=false;

  ObterConexao;
  AtivaSeparadoresMercados;



end;

Function  TFrmCBLPmsContasFamilia.dacontasSeleccionados(pGrelha:TadvStringGrid):string;
var i:integer;
begin
  Result:='';
  For i:=1 to pGrelha.RowCount-1 do
  begin
     If pGrelha.Cells[COL_ID_PmsContafamilia,i]<>'' then
     Begin
       If Length(result)>0 then
               Result:=Result+',';
       Result:=Result+#39+pGrelha.Cells[COL_ID_PmsContafamilia,i]+#39;
     end;
  end;
  If Length(result)>0 then
        Result:='('+Result+')';

end;

procedure TFrmCBLPmsContasFamilia.GrelhaButtonClick(Sender: TObject; ACol,
  ARow: Integer);
  var filtro:string;
begin

 filtro:=dacontasSeleccionados(Grelha);
 If Length(filtro)>0 then
    filtro:=' ukto.kto not in'+ filtro;
  If Acol = COL_PmsContaFamilia then
    Listas.AbrirSQL('ListaArmazemSapB1',filtro, Grelha, SeleccionaContaFamiliaProtel)
end;

procedure TFrmCBLPmsContasFamilia.FormDestroy(Sender: TObject);
begin
 FrmCBLPmsContasFamilia:=Nil;
end;

procedure TFrmCBLPmsContasFamilia.GrelhaClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  If Grelha.Cells[COL_PmsContaFamilia,Grelha.Row]='' then
    AdicionaBotaoGrelha(Grelha, COL_PmsContaFamilia, ARow, epimagem.BtListaGlyph);

end;







procedure TFrmCBLPmsContasFamilia.AcConfirmarExecute(Sender: TObject);
begin

    screen.cursor:=CrHourGlass;
    Try
     if GravaPmsContasFamilia(1,Grelha) and GravaPmsContasFamilia(2,Grelha1)
     and  GravaPmsContasFamilia(3,Grelha2) then
     begin
       // RegistoLogOperacao(3);
         sb.Dialogos.SBMessage('Dados Gravados com sucesso!');
     end;
    Finally
       screen.cursor:=CrDefault;
   end;
end;

procedure TFrmCBLPmsContasFamilia.acSairExecute(Sender: TObject);
begin
 self.Close;
end;



procedure TFrmCBLPmsContasFamilia.AdicionaContasFamilias();
var
   Lista:TSBBETabelaDados;
   sql:string;
   i:integer;
    filtro:string;
var
 schema:string;
begin


   i:= ProximaLinha(grelha);

   sql:='Select * from '+FShemaProtel+'ukto';
   filtro:=dacontasSeleccionados(grelha);
   If Length(filtro)>0 then
    sql:=sql +' Where ukto.kto not in'+ filtro;
    sql:=sql +' order by ukto.kto' ;
   Lista:=SB.SBBD.AbrirLV(sql);
   If not(Lista.vazia) then
     Grelha.Rowcount:=Grelha.rowcount+Lista.NumLinhas;
   Try
    while not(Lista.NoFim) do
    begin
        With Grelha do
        begin
           Grelha.cells[COL_ID_PmsContaFamilia,i]:=Lista.Davalor('kto').asstring;
           Grelha.Cells[COL_PmsContaFamilia,i]:=Lista.Davalor('bez').asString;
           inc(i);
        end;
        Lista.seguinte;
    end;
   Finally
     FreeAndNil(Lista);
   end;
   Grelha.SortByColumn(COL_ID_PmsContaFamilia);
   Grelha.row:=Grelha.rowcount-1;

end;

procedure TFrmCBLPmsContasFamilia.AdicionaContasFamilias1();
var
   Lista:TSBBETabelaDados;
   sql:string;
   i:integer;
    filtro:string;
begin

   i:= ProximaLinha(grelha1);
   sql:='Select * from '+FShemaProtel+'ukto';
   filtro:=dacontasSeleccionados(grelha1);
   If Length(filtro)>0 then
    sql:=sql +' Where  ukto.kto not in'+ filtro;
  sql:=sql +' order by ukto.kto' ;

   Lista:=SB.SBBD.AbrirLV(sql);
   If not(Lista.vazia) then
     Grelha1.Rowcount:=Grelha1.rowcount+Lista.NumLinhas;
   Try
    while not(Lista.NoFim) do
    begin
        With Grelha1 do
        begin
           Grelha1.cells[COL_ID_PmsContaFamilia,i]:=Lista.Davalor('kto').asstring;
           Grelha1.Cells[COL_PmsContaFamilia,i]:=Lista.Davalor('bez').asString;
           inc(i);
        end;
        Lista.seguinte;
    end;
   Finally
     FreeAndNil(Lista);
   end;
   Grelha1.SortByColumn(COL_ID_PmsContaFamilia);
   Grelha1.row:=Grelha1.rowcount-1;

end;
procedure TFrmCBLPmsContasFamilia.AdicionaContasFamilias2();
var
   Lista:TSBBETabelaDados;
   sql:string;
   i:integer;
   filtro:string;
begin


   i:= ProximaLinha(grelha2);

   sql:='Select * from '+FShemaProtel+'ukto';
   filtro:=dacontasSeleccionados(grelha2);
   If Length(filtro)>0 then
      sql:=sql +' Where ukto.kto not in'+ filtro;
  sql:=sql +' order by ukto.kto' ;      
   Lista:=SB.SBBD.AbrirLV(sql);

   If not(Lista.vazia) then
     Grelha2.Rowcount:=Grelha2.rowcount+Lista.NumLinhas;
   Try
    while not(Lista.NoFim) do
    begin
        With Grelha2 do
        begin
           Grelha2.cells[COL_ID_PmsContaFamilia,i]:=Lista.Davalor('kto').asstring;
           Grelha2.Cells[COL_PmsContaFamilia,i]:=Lista.Davalor('bez').asString;
           inc(i);
        end;
        Lista.seguinte;
    end;
   Finally
     FreeAndNil(Lista);
   end;
   Grelha2.SortByColumn(COL_ID_PmsContaFamilia);
   Grelha2.row:=Grelha2.rowcount-1;

end;


procedure TFrmCBLPmsContasFamilia.AdicionaContasGrelhaClick(Sender: TObject);
begin
   AdicionaContasFamilias;
end;

procedure TFrmCBLPmsContasFamilia.AjustaColunasGrelha(pgrelha:Tadvstringgrid);
begin
 With pgrelha do
      begin
            ColWidths[COL_ClasseIVAD] := 0;
            If FlinhaSageCNC=false then
            begin
                ColWidths[COL_ContaCblFamiliaD] := 0;
                ColWidths[COL_ContaCbLIvaD] := 0;
                ColWidths[COL_ContaCCustoD]:=0;
                ColWidths[COL_ContaAnaliticaD] := 0;
            end;
            ColWidths[COL_PmsContaFamilia]:= Width -ColWidths[COL_ContaCblFamiliaD]
                                        - ColWidths[COL_ContaCbLIvaD]
                                        - ColWidths[COL_ClasseIVAD]
                                        - ColWidths[COL_ClasseIVA]
                                        - ColWidths[COL_ID_PmsContafamilia]
                                        - ColWidths[COL_ContaCblFamilia]
                                        - ColWidths[COL_ContaCbLIva]
                                        - ColWidths[COL_ContaCCusto]
                                        - ColWidths[COL_ContaAnalitica]
                                        - ColWidths[COL_ContaCCustoD]
                                        - ColWidths[COL_ContaAnaliticaD]-21;
      end;
end;

procedure TFrmCBLPmsContasFamilia.FormShow(Sender: TObject);
begin
  FormataGrelha(Grelha);
  FormataGrelha(Grelha1);
  FormataGrelha(Grelha2);

  if FShemaProtel<>'' then
  begin

      MostraPmsContasFamilia(1,grelha);//mercado Nacional
      MostraPmsContasFamilia(2,grelha1);//mercado intercomunitario
      MostraPmsContasFamilia(3,grelha2);//mercado Extracomunitario
      AjustaColunasGrelha(Grelha);
      AjustaColunasGrelha(Grelha1);
      AjustaColunasGrelha(Grelha2);
      BtReplicar.Visible:=ConfiguracaoContasServicoPorTipoDoc;
  end
  Else
      sb.Dialogos.SBAviso('A Coneção para a Base de Dados CBL, não se encontra Configurada!')

end;

procedure TFrmCBLPmsContasFamilia.Replicar(pGrelha:TadvStringGrid;pColuna:Integer; plinha:Integer;pvalor:string);
var
   i:Integer;
begin
  For i:=plinha to pGrelha.rowcount-1 do
  begin
     pGrelha.cells[pColuna,i]:=pvalor;
  end;
end;
procedure TFrmCBLPmsContasFamilia.Replicar1Click(Sender: TObject);
var
strsconta:string;
begin
  If Grelha.col in[COL_ContaCblFamilia,COL_ContaCbLIva,COL_ClasseIVA,COL_ContaCCusto,COL_ContaAnalitica,
    COL_ContaCBLFamiliaNCperIVAdifFACT,  COL_ContaCBLIVANCperIVAdifFACT,  COL_ClasseIVANCperIVAdifFACT,  COL_ContaCCustoNCperIVAdifFACT,
      COL_ContaAnaliticaNCperIVAdifFACT] then
  begin
      If Grelha.Cells[Grelha.col,Grelha.row]<>'' then
      begin
         strsconta:=  Grelha.Cells[Grelha.col,1]+': '+ Grelha.Cells[Grelha.col,Grelha.row];
         If sb.dialogos.SBConfirmacao(0,'Tem a certeza que deseja Replicar a '+strsconta )then
            Replicar(Grelha,Grelha.col, Grelha.row, Grelha.Cells[Grelha.col,Grelha.row]);
      end
      ELSE
       If sb.dialogos.SBConfirmacao(0,'Tem a certeza que deseja limpar?')then
            Replicar(Grelha,Grelha.col, Grelha.row, Grelha.Cells[Grelha.col,Grelha.row]);

  end;
end;

procedure TFrmCBLPmsContasFamilia.BtReplicarClick(Sender: TObject);
var
FrmCBLSeltipodoc:TFrmCBLSeltipodoc;
begin
    FrmCBLSeltipodoc:=TFrmCBLSeltipodoc.Create(self);
    FrmCBLSeltipodoc.POSID_TipoDocPMs:= POSID_TipoDocPMs;
    FrmCBLSeltipodoc.POSTipoDocPMs:= POSTipoDocPMs;
    FrmCBLSeltipodoc.ShowModal;
end;



Function TFrmCBLPmsContasFamilia.ConfiguracaoContasServicoPorTipoDoc():Boolean;
Var
Lista:TSBBETabeladados;
strsql:string;
begin
{ObterConexao;
strsql:='select ConfContasPorTipoDoc from ConfPrimaveraCBL';
Lista:=SB.SBBD.AbrirLV(FConnectionString,strsql);
Result:=Lista.daValor('ConfContasPorTipoDoc').asboolean;
Freeandnil(Lista);}

end;



procedure TFrmCBLPmsContasFamilia.MenuItem1Click(Sender: TObject);
begin
AdicionaContasFamilias1;
end;


procedure TFrmCBLPmsContasFamilia.MenuItem2Click(Sender: TObject);
var
        strsconta:string;
begin
  If Grelha1.col in[COL_ContaCblFamilia,COL_ContaCbLIva,COL_ClasseIVA,COL_ContaCCusto,COL_ContaAnalitica,
    COL_ContaCBLFamiliaNCperIVAdifFACT,  COL_ContaCBLIVANCperIVAdifFACT,  COL_ClasseIVANCperIVAdifFACT,  COL_ContaCCustoNCperIVAdifFACT,
      COL_ContaAnaliticaNCperIVAdifFACT] then
  begin
      If Grelha1.Cells[Grelha1.col,Grelha1.row]<>'' then
      begin
      strsconta:=  Grelha1.Cells[Grelha.col,1]+': '+ Grelha1.Cells[Grelha1.col,Grelha1.row];
       If sb.dialogos.SBConfirmacao(0,'Tem a certeza que deseja Replicar a '+strsconta )then
            Replicar(Grelha1,Grelha1.col, Grelha1.row, Grelha1.Cells[Grelha1.col,Grelha1.row]);
      end;
  end;
end;


procedure TFrmCBLPmsContasFamilia.Grelha1RowChanging(Sender: TObject;
  OldRow, NewRow: Integer; var Allow: Boolean);
begin

  RemoveBotaoGrelha(Grelha1, COL_PmsContaFamilia, OldRow);

  if (NewRow >= Grelha1.FixedRows) then
  begin
    If  Grelha1.cells[COL_PmsContaFamilia, NewRow]='' then
            AdicionaBotaoGrelha(Grelha1, COL_PmsContaFamilia, NewRow, epimagem.BtListaGlyph);
  end;
end;

procedure TFrmCBLPmsContasFamilia.Grelha2RowChanging(Sender: TObject;
  OldRow, NewRow: Integer; var Allow: Boolean);
begin
  RemoveBotaoGrelha(Grelha2, COL_PmsContaFamilia, OldRow);

  if (NewRow >= Grelha2.FixedRows) then
  begin
    If  Grelha2.cells[COL_PmsContaFamilia, NewRow]='' then
            AdicionaBotaoGrelha(Grelha2, COL_PmsContaFamilia, NewRow, epimagem.BtListaGlyph);
  end;
end;

procedure TFrmCBLPmsContasFamilia.Grelha1ButtonClick(Sender: TObject; ACol,
  ARow: Integer);
var

 filtro:string;
begin

 filtro:=dacontasSeleccionados(Grelha1);
 If Length(filtro)>0 then
    filtro:=' ukto.kto not in'+ filtro;
  If Acol = COL_PmsContaFamilia then
    Listas.AbrirSQL('ListaContasFamilia',filtro, Grelha1, SeleccionaContaFamiliaProtel1)
end;

procedure TFrmCBLPmsContasFamilia.Grelha2ButtonClick(Sender: TObject; ACol,
  ARow: Integer);
var

 filtro:string;
begin

 filtro:=dacontasSeleccionados(Grelha1);
 If Length(filtro)>0 then
    filtro:=' ukto.kto not in'+ filtro;
  If Acol = COL_PmsContaFamilia then
    Listas.AbrirSQL('ListaContasFamilia',filtro, Grelha2, SeleccionaContaFamiliaProtel1)
end;

procedure TFrmCBLPmsContasFamilia.Grelha1ClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  If Grelha1.Cells[COL_PmsContaFamilia,Grelha1.Row]='' then
    AdicionaBotaoGrelha(Grelha1, COL_PmsContaFamilia, ARow, epimagem.BtListaGlyph);

end;

procedure TFrmCBLPmsContasFamilia.Grelha2ClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  If Grelha2.Cells[COL_PmsContaFamilia,Grelha2.Row]='' then
    AdicionaBotaoGrelha(Grelha2, COL_PmsContaFamilia, ARow, epimagem.BtListaGlyph);

end;

procedure TFrmCBLPmsContasFamilia.MenuItem3Click(Sender: TObject);
begin
AdicionaContasFamilias2;
end;

procedure TFrmCBLPmsContasFamilia.MenuItem4Click(Sender: TObject);
var
strsconta:string;
begin
If grelha2.col in[COL_ContaCblFamilia,COL_ContaCbLIva,COL_ClasseIVA,COL_ContaCCusto,COL_ContaAnalitica,
    COL_ContaCBLFamiliaNCperIVAdifFACT,  COL_ContaCBLIVANCperIVAdifFACT,  COL_ClasseIVANCperIVAdifFACT,  COL_ContaCCustoNCperIVAdifFACT,
      COL_ContaAnaliticaNCperIVAdifFACT] then
begin

    If grelha2.Cells[grelha2.col,grelha2.row]<>'' then
    begin
    strsconta:=  grelha2.Cells[Grelha.col,1]+': '+ grelha2.Cells[grelha2.col,grelha2.row];
     If sb.dialogos.SBConfirmacao(0,'Tem a certeza que deseja Replicar a '+strsconta )then
          Replicar(grelha2,grelha2.col, grelha2.row, grelha2.Cells[grelha2.col,grelha2.row]);
    end;


end;
end;

procedure TFrmCBLPmsContasFamilia.AtivaSeparadoresMercados;
var
strsql:string;
begin
    tbextraComunitario.tabvisible:=false;
    tsbInterComunitario.tabvisible:=false;
    tssbNAcional.caption:='Contas';
    if FContasPorMercado=true then
     begin
      tbextraComunitario.tabvisible:=true;
      tsbInterComunitario.tabvisible:=true;
      tssbNAcional.caption:='Mercado:Nacional';
     end;


end;



Function TFrmCBLPmsContasFamilia.GravaPmsContasFamilia(pMercado:Integer;pGrelha:Tadvstringgrid):Boolean;
var
   i:integer;

   strsql:string;

   Connection:TadoConnection;
   PmsContaFamilia,ID_PmsContaFamilia:string;
   ContaCbl,ContaCBLIVA,ClasseIVA,ContaCCusto,ContaAnalitica:string;
   ContaCblD,ContaCBLIVAD,ClasseIVAD,ContaCCustoD,ContaAnaliticaD:string;
   ContaCBLFamiliaNCperIVAdifFACT,
   ContaCBLIVANCperIVAdifFACT,
   ClasseIVANCperIVAdifFACT,
   ContaCCustoNCperIVAdifFACT,
   ContaAnaliticaNCperIVAdifFACT:string;

begin
   result:=true;

   Try
    sb.sbbd.IniciaTransacao;
     Try

          strsql:='';

          strsql:='Delete from [CBL_ContaFamiliaPMS] where Mercado='+Inttostr(pMercado);
          if FPOSID_TipoDocPMs>0 then
          begin
             strsql:=strsql+' and  PMS_ID_TipoDoc='+IntToStr(FPOSID_TipoDocPMs);
          end;
          sb.sbbd.Executa(strsql);

         for i:=2 to pGrelha.RowCount-1 do
         Begin

             If  pGrelha.Cells[COL_PmsContaFamilia,i]<>'' then
             Begin
              strsql:='';

              ID_PmsContaFamilia:=pGrelha.cells[COL_ID_PmsContafamilia,i];
              PmsContaFamilia:=pGrelha.Cells[COL_PmsContaFamilia,i];
              ContaCbl:=pGrelha.Cells[COL_ContaCblFamilia,i];
              ContaCBLIVA:=pGrelha.Cells[COL_ContaCbLIva,i];
              ClasseIVA:=pGrelha.Cells[COL_ClasseIVA,i];

              ContaCCusto:=pGrelha.Cells[COL_ContaCCusto,i];
              ContaAnalitica:=pGrelha.Cells[COL_ContaAnalitica,i];

              ContaCCustoD:=pGrelha.Cells[COL_ContaCCustoD,i];
              ContaAnaliticaD:=pGrelha.Cells[COL_ContaAnaliticaD,i];

              ContaCblD:=pGrelha.Cells[COL_ContaCblFamiliaD,i];
              ContaCBLIVAD:=pGrelha.Cells[COL_ContaCbLIvaD,i];
              ClasseIVAD:=pGrelha.Cells[COL_ClasseIVAD,i];
              If  ContaCblD='' then
                ContaCblD:=pGrelha.Cells[COL_ContaCblFamilia,i];
              If ContaCBLIVAD='' then
                ContaCBLIVAD:=pGrelha.Cells[COL_ContaCbLIva,i];
              If ClasseIVAD=''  then
                ClasseIVAD:=pGrelha.Cells[COL_ClasseIVA,i];


             ContaCBLFamiliaNCperIVAdifFACT:=pGrelha.Cells[COL_ContaCBLFamiliaNCperIVAdifFACT,i];
             ContaCBLIVANCperIVAdifFACT:=pGrelha.Cells[COL_ContaCBLIVANCperIVAdifFACT,i];
             ClasseIVANCperIVAdifFACT:=pGrelha.Cells[COL_ClasseIVANCperIVAdifFACT,i];
             ContaCCustoNCperIVAdifFACT:=pGrelha.Cells[COL_ContaCCustoNCperIVAdifFACT,i];
             ContaAnaliticaNCperIVAdifFACT:=pGrelha.Cells[COL_ContaAnaliticaNCperIVAdifFACT,i];


             If ContaCBLFamiliaNCperIVAdifFACT='' then
               ContaCBLFamiliaNCperIVAdifFACT:=pGrelha.Cells[COL_ContaCBLFamilia,i];

             If ContaCBLIVANCperIVAdifFACT='' then
               ContaCBLIVANCperIVAdifFACT:=pGrelha.Cells[col_ContaCBLIVA,i];

             If ClasseIVANCperIVAdifFACT='' then
               ClasseIVANCperIVAdifFACT:=pGrelha.Cells[COL_ClasseIVA,i];

             If ContaCCustoNCperIVAdifFACT='' then
               ContaCCustoNCperIVAdifFACT:=pGrelha.Cells[COL_ContaCCusto,i];

             If ContaAnaliticaNCperIVAdifFACT='' then
               ContaAnaliticaNCperIVAdifFACT:=pGrelha.Cells[COL_ContaAnalitica,i];



              strsql:= 'INSERT INTO [CBL_ContaFamiliaPMS]'
                   +' ([PMS_ID_ContaFamilia]'
                   +' ,[PMS_ContaFamilia]'
                   +' ,[ContaCBLFamilia]'
                   +' ,[ContaCBLIVA],ClasseIVA'
                   +' ,[ContaCBLFamiliaD]'
                   +' ,[ContaCBLIVAD],ClasseIVAD,PMS_ID_TipoDoc,Mercado,ContaCCusto,ContaCCustoD,'
                   +' ContaAnalitica,ContaAnaliticaD,'
                   +'   ContaCBLFamiliaNCperIVAdifFACT,'
                   +'    ContaCBLIVANCperIVAdifFACT,'
                   +'    ClasseIVANCperIVAdifFACT,'
                   +'    ContaCCustoNCperIVAdifFACT,'
                   +'    ContaAnaliticaNCperIVAdifFACT'


                   +' )'
                   +' VALUES('
                   +#39+ID_PmsContaFamilia+#39
                   +','+#39+ PmsContaFamilia+#39
                   +','+#39+ ContaCbl+#39
                   +','+#39+ ContaCBLIVA+#39
                   +','+#39+ ClasseIVA+#39
                   +','+#39+ ContaCblD+#39
                   +','+#39+ ContaCBLIVAD+#39
                   +','+#39+ ClasseIVAD+#39
                   +','+Inttostr(FPOSID_TipoDocPMs)
                   +','+Inttostr(pmercado)
                   +','+#39+ ContaCCusto+#39
                   +','+#39+ ContaCCustoD+#39
                   +','+#39+ ContaAnalitica+#39
                   +','+#39+ ContaAnaliticaD+#39

                   +','+#39+  ContaCBLFamiliaNCperIVAdifFACT+#39
                   +','+#39+ ContaCBLIVANCperIVAdifFACT+#39
                   +','+#39+ ClasseIVANCperIVAdifFACT+#39
                   +','+#39+  ContaCCustoNCperIVAdifFACT+#39
                   +','+#39+ ContaAnaliticaNCperIVAdifFACT+#39

                   +')';
                 sb.sbbd.executa(strsql);

             end;
         end;
        sb.sbbd.terminatransacao;
        Except

             On E: Exception Do
             Begin
                 sb.sbbd.DesfazTransacao;
                raise SB.ErroNormal(0,'PMS_ContaFamilia','PMS_ContaFamilia_Nacional','Não Foi possivel efectuar a Gravação ' + E.Message);
                            Result:=false;
             End;
        end;
    Finally


    end;

end;


procedure TFrmCBLPmsContasFamilia.MostraPmsContasFamilia(pMercado:Integer;pGrelha:Tadvstringgrid);
var
   i:integer;
   strsql:string;
   Connection:TadoConnection;
   ListaContasFamilia:Tsbbetabeladados;
begin
   i:=2;
   Try
      strsql:='';
      strsql:='Select * from CBL_ContaFamiliaPMS'
      +' Where mercado= '+Inttostr(pMercado);
      If FPOSID_TipoDocPMs>0 then
       strsql:=strsql+' and PMS_ID_TipoDoc='+Inttostr(FPOSID_TipoDocPMs);
      ListaContasFamilia:=sb.SBBD.AbrirLV(strsql);
      If Not(ListaContasFamilia.vazia) then
                  pGrelha.rowcount:= ListaContasFamilia.numlinhas+2;
      ListaContasFamilia.Inicio;
      while Not(ListaContasFamilia.NoFim) do
      begin

          pGrelha.cells[COL_ID_PmsContafamilia,i]:=ListaContasFamilia.davalor('PMS_ID_ContaFamilia').asstring;
          pGrelha.cells[COL_PmsContaFamilia,i]:=ListaContasFamilia.davalor('PMS_ContaFamilia').asstring;
          pGrelha.Cells[COL_ContaCblFamilia,i]:=ListaContasFamilia.davalor('ContaCBLFamilia').asstring;
          pGrelha.Cells[COL_ContaCbLIva,i]:=ListaContasFamilia.davalor('ContaCBLIVA').asstring;
          pGrelha.Cells[COL_ClasseIVA,i]:=ListaContasFamilia.davalor('ClasseIVA').asstring;

          pGrelha.Cells[COL_ContaCCusto,i]:=ListaContasFamilia.davalor('ContaCCusto').asstring;
          pGrelha.Cells[COL_ContaCCustoD,i]:=ListaContasFamilia.davalor('ContaCCustoD').asstring;

          pGrelha.Cells[COL_ContaAnalitica,i]:=ListaContasFamilia.davalor('ContaAnalitica').asstring;
          pGrelha.Cells[COL_ContaAnaliticaD,i]:=ListaContasFamilia.davalor('ContaAnaliticaD').asstring;

          pGrelha.Cells[COL_ContaCBLFamiliaNCperIVAdifFACT,i]:=ListaContasFamilia.davalor('ContaCBLFamiliaNCperIVAdifFACT').asstring;
          pGrelha.Cells[COL_ContaCBLIVANCperIVAdifFACT,i]:=ListaContasFamilia.davalor('ContaCBLIVANCperIVAdifFACT').asstring;
          pGrelha.Cells[COL_ClasseIVANCperIVAdifFACT,i]:=ListaContasFamilia.davalor('ClasseIVANCperIVAdifFACT').asstring;
          pGrelha.Cells[COL_ContaCCustoNCperIVAdifFACT,i]:=ListaContasFamilia.davalor('ContaCCustoNCperIVAdifFACT').asstring;
          pGrelha.Cells[COL_ContaAnaliticaNCperIVAdifFACT,i]:=ListaContasFamilia.davalor('ContaAnaliticaNCperIVAdifFACT').asstring;


          If  ((FPOSID_TipoDocPMs=0)or (FlinhaSageCNC=true)) then
          begin
              pGrelha.Cells[COL_ContaCblFamiliaD,i]:=ListaContasFamilia.davalor('ContaCBLFamiliaD').asstring;
              pGrelha.Cells[COL_ContaCbLIvaD,i]:=ListaContasFamilia.davalor('ContaCBLIVAD').asstring;
              pGrelha.Cells[COL_ClasseIVAD,i]:=ListaContasFamilia.davalor('ClasseIVAD').asstring;
          end;


          inc(i);
          ListaContasFamilia.seguinte;
      end;
    Finally
       ListaContasFamilia.Fecha;
       FreeAndNil(ListaContasFamilia);
    end;
end;

procedure TFrmCBLPmsContasFamilia.Grelha1CanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
canedit:=Acol in[COL_ContaCblFamilia,COL_ContaCbLIva,COL_ClasseIva,
                COL_ContaCblFamiliaD,COL_ContaCbLIvaD,
                COL_ClasseIvaD, COL_ContaCCusto, COL_ContaAnalitica,  COL_ContaCCustoD,
                COL_ContaAnaliticaD,  COL_ContaCBLFamiliaNCperIVAdifFACT,
                COL_ContaCBLIVANCperIVAdifFACT ,
                COL_ClasseIVANCperIVAdifFACT,
                COL_ContaCCustoNCperIVAdifFACT ,
                 COL_ContaAnaliticaNCperIVAdifFACT ];
end;

procedure TFrmCBLPmsContasFamilia.Grelha2CanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
canedit:=Acol in[COL_ContaCblFamilia,COL_ContaCbLIva,COL_ClasseIva,
                COL_ContaCblFamiliaD,COL_ContaCbLIvaD,
                COL_ClasseIvaD, COL_ContaCCusto, COL_ContaAnalitica,  COL_ContaCCustoD,
                COL_ContaAnaliticaD,  COL_ContaCBLFamiliaNCperIVAdifFACT,
                COL_ContaCBLIVANCperIVAdifFACT ,
                COL_ClasseIVANCperIVAdifFACT,
                COL_ContaCCustoNCperIVAdifFACT ,
                 COL_ContaAnaliticaNCperIVAdifFACT ];
end;

end.
