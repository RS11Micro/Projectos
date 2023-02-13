unit ERP_FRMPMSAreasContasLanc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Grids, AdvObj, BaseGrid, AdvGrid, AdvToolBar,
  SBEditProcura,inifiles,sblista,SBControlos,adodb, StdCtrls, ExtCtrls,
  AdvPanel,ERPBEEMPRESAINTERFACE;


type
  TFRM_ERPPMSAreasContasLanc = class(TForm)
    a: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btSair: TAdvToolBarButton;
    btConfirmar: TAdvToolBarButton;
    AdvPanel1: TAdvPanel;
    Grelha: TAdvStringGrid;
    epimagem: TSBEditProcura;
    ActionList1: TActionList;
    AcSeltodos: TAction;
    AcDesTodos: TAction;
    acAtribuirArea: TAction;
    AcRemoveArea: TAction;
    procedure GrelhaButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure GrelhaCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure GrelhaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure GrelhaRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSairClick(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure AcSeltodosExecute(Sender: TObject);
    procedure AcDesTodosExecute(Sender: TObject);
    procedure acAtribuirAreaExecute(Sender: TObject);
    procedure AcRemoveAreaExecute(Sender: TObject);
  private
    { Private declarations }
    FOBJInterface:TERPBEEMPRESAINTERFACE;
    Procedure FormataGrelha(pGrelha:TadvStringGrid);
    procedure PreencheGrelha;
    procedure GravaDadosGrelha;
    Procedure SeleccionaAreaNegocio(Sender :TObject);
    Procedure SeleccionaAreaNegocioAtribGrelha(Sender :TObject);

    Procedure MudaEstado(pEstado: Boolean);

  public
    { Public declarations }
  end;

var
  FRM_ERPPMSAreasContasLanc: TFRM_ERPPMSAreasContasLanc;

implementation

uses IERPOGLOBAIS,SBBotoes,SBBETabelaDados, SBBaseDados, SBBSSistemaBase,IERPFrmPrincipal;

{$R *.dfm}
Const

  COL_ID_UKTO = 0;
  COL_KTO = 1;
  COL_UKTODESC = 2;
  COL_AreaNegocio = 3;
  COL_AreaContaERP = 4;
  COL_id_area= 5;
  COL_check= 6;
  COL_MAx = 7;



Procedure TFRM_ERPPMSAreasContasLanc.FormataGrelha(pGrelha:TadvStringGrid);
var
  i: Integer;
  Item: TMenuItem;
Begin
  with pGrelha do
  begin
    ShowHint := True;  
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 1;
    RowCount := 2;
    ColCount := COL_Max;


    ColWidths[COL_ID_UKTO] := 70;
    ColWidths[COL_UKTODESC] := 150;
    ColWidths[COL_KTO] := 70;


    ColWidths[COL_AreaNegocio] := 150;
    ColWidths[COL_AreaContaERP] := 85;
    ColWidths[COL_check] := 25;
    ColWidths[COL_id_area] := 0;



    ColWidths[COL_UKTODESC]:= Width -ColWidths[COL_ID_UKTO]-ColWidths[COL_KTO]-
    ColWidths[COL_AreaNegocio]-   ColWidths[COL_AreaContaERP] -
    ColWidths[COL_id_area]-     ColWidths[COL_check] - 21;

    Options:=  [goFixedVertLine]+[goColSizing]+[goFixedHorzLine] + [goHorzLine] + [goVertLine] + [goEditing];
    With Navigation do
    begin
      AllowDeleteRow:=True;
      AllowInsertRow:=True;
    end;

    Cells[COL_ID_UKTO, 0] := SB.Idioma.daTraducao(0, 'KTONR');
    Cells[COL_KTO, 0] := SB.Idioma.daTraducao(0, 'KTO');
    Cells[COL_UKTODESC, 0] := SB.Idioma.daTraducao(0, 'Conta Lanç.');

    Cells[COL_AreaNegocio, 0] := SB.Idioma.daTraducao(0, 'Área Negócio');
    Cells[COL_AreaContaERP, 0] := SB.Idioma.daTraducao(0, 'Conta Area ERP');

    Item := TMenuItem.Create(Grelha);
    Item.Action := AcSeltodos;
    PopupMenu.Items.Insert(0, item);

    Item := TMenuItem.Create(Grelha);
    Item.Action := AcDesTodos;
    PopupMenu.Items.Insert(1, item);

    Item := TMenuItem.Create(Grelha);
    Item.Action := acAtribuirArea;
    PopupMenu.Items.Insert(2, item);



    Item := TMenuItem.Create(Grelha);
    Item.Action := AcRemoveArea;
    PopupMenu.Items.Insert(3, item);

                                          

    EndUpdate;
  end;
End;


procedure TFRM_ERPPMSAreasContasLanc.PreencheGrelha;
var
  strsql:string;
  Listaexterna:tsbbetabeladados;
  ListaErp:tsbbetabeladados;
  i:integer;
begin
 strsql:='Select * from '+FOBJInterface.BDSchema+'UKTO order by bez';
 Listaexterna:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,strsql);
 
 strsql:='Select ERP_AreaNegocioContaLancPMS.ID_AreaNegocio,ErP_AreaNegocio.DescricaoArea,'
 +' ErP_AreaNegocio.Contaerp,ERP_AreaNegocioContaLancPMS.KTO,ERP_AreaNegocioContaLancPMS.KTONR'
 +' from ERP_AreaNegocioContaLancPMS '
 +' inner join ErP_AreaNegocio on ErP_AreaNegocio.Id_areanegocio=ERP_AreaNegocioContaLancPMS.id_areanegocio'
 +' where ID_InternoInterface='+Inttostr(FOBJInterface.ID);
 ListaErp:= sb.SBBD.AbrirLV(strsql);

 i:=1;
 If  Not(Listaexterna.Vazia) then
 begin
  Grelha.ClearNormalCells;
  Grelha.RowCount:=Grelha.FixedRows+ Listaexterna.NumLinhas;
  while not Listaexterna.nofim do
  begin
    Grelha.ints[COL_ID_UKTO,i] :=Listaexterna.davalor('KTONR').asinteger ;
    Grelha.cells[COL_KTO,i] :=Listaexterna.davalor('KTO').asstring ;
    Grelha.cells[COL_UKTODESC,i] :=Listaexterna.davalor('Bez').asstring ;
    Grelha.AddCheckBox(COL_check,i,false,false);
    If Not(ListaErp.Vazia) then
    begin
      If ListaErp.DataSet.Locate('KTONR',Listaexterna.davalor('KTONR').asinteger,[])then
      begin
          Grelha.cells[COL_AreaNegocio,i] :=ListaErp.davalor('DescricaoArea').asstring ;
          Grelha.cells[COL_AreaContaERP,i] :=ListaErp.davalor('Contaerp').asstring ;
          Grelha.ints[COL_id_area,i] :=ListaErp.davalor('ID_AreaNegocio').asinteger ;
      end;
    end;
    Inc(i);
    Listaexterna.seguinte;
   end;
 end;
 If ListaErp<>nil then
  freeandnil(ListaErp);
 If Listaexterna<>nil then
  freeandnil(Listaexterna);

end;

procedure TFRM_ERPPMSAreasContasLanc.GravaDadosGrelha;
var
  strsql:string;
  Listaexterna:tsbbetabeladados;
  ListaErp:tsbbetabeladados;
  i:integer;
begin
 strsql:= 'delete from  ERP_AreaNegocioContaLancPMS '
         +' where ID_InternoInterface='+Inttostr(FOBJInterface.ID);
 sb.SBBD.Executa(strsql);

 For i:=grelha.FixedRows to Grelha.rowcount-1 do
 begin
  If Grelha.ints[COL_id_area,i]>0 then
  begin
      strsql:= ' INSERT INTO [ERP_AreaNegocioContaLancPMS]'
             +' ([ID_InternoInterface]'
             +' ,[ID_AreaNegocio]'
             +' ,[KTONR]'
             +' ,[KTO]'
             +' ,[DescUKTO])'
             +'  VALUES ('  + Inttostr(FOBJInterface.ID)
             +','+   Grelha.cells[COL_id_area,i]
             +','+   Grelha.cells[COL_ID_UKTO,i]
             +','+#39+   Grelha.cells[col_KTO,i]+#39
             +','+#39+   Grelha.cells[COL_UKTODESC,i]+#39
             +')';
        sb.SBBD.Executa(strsql);

  end;
 end;
end;


Procedure TFRM_ERPPMSAreasContasLanc.SeleccionaAreaNegocio(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        Grelha.Ints[COL_id_area,Grelha.Row]:=Obj.Chave;
        Grelha.Cells[COL_AreaNegocio,Grelha.Row]:=Obj.ValorDescricao;
        Grelha.Cells[COL_AreaContaERP,Grelha.Row]:=Obj.ListaValores.AtributoValor['ContaErp'].Asstring;

      End;
   Finally
     FreeAndNil(Obj);
   end;
end;



procedure TFRM_ERPPMSAreasContasLanc.GrelhaButtonClick(Sender: TObject;
  ACol, ARow: Integer);
begin
  
  If Acol = COL_AreaNegocio then
    Listas.AbrirSQL('ListaAreaNegocio','', Grelha, SeleccionaAreaNegocio)

end;

procedure TFRM_ERPPMSAreasContasLanc.GrelhaCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
 canedit:=acol in [COL_AreaNegocio,COL_check];
end;

procedure TFRM_ERPPMSAreasContasLanc.GrelhaClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
    AdicionaBotaoGrelha(Grelha, COL_AreaNegocio, ARow, epimagem.BtListaGlyph);
end;

procedure TFRM_ERPPMSAreasContasLanc.GrelhaRowChanging(Sender: TObject;
  OldRow, NewRow: Integer; var Allow: Boolean);
begin
  RemoveBotaoGrelha(Grelha, COL_AreaNegocio, OldRow);

  if (NewRow >= Grelha.FixedRows) then
  begin
    If  Grelha.cells[COL_AreaNegocio, NewRow]='' then
            AdicionaBotaoGrelha(Grelha, COL_AreaNegocio, NewRow, epimagem.BtListaGlyph);
  end;

end;

procedure TFRM_ERPPMSAreasContasLanc.FormCreate(Sender: TObject);
var
ID_ERP_VENDASPMS:Integer;
segue:boolean;
begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  FormataGrelha(grelha);
  segue:=true;
  FOBJInterface:=nil;
  ID_ERP_VENDASPMS:=0;
  ID_ERP_VENDASPMS:=FrmIERPPrincipal.TbExportacaovendasPMS.tag;
  If ID_ERP_VENDASPMS<=0 then
   segue:=false;

  If segue=true then
  begin
   FOBJInterface:=MotorERP.ERPInterface.Edita(ID_ERP_VENDASPMS);
   If FOBJInterface=nil then
   begin
    segue:=false;
   end
  end;
  If    segue=false then
  begin
   sb.Dialogos.SBAviso(' O Interface de ERP Vendas PMS não está configurado');
   btConfirmar.enabled:=false;
  end;

  IF segue=true then
  begin
   PreencheGrelha;
  end;
end;



procedure TFRM_ERPPMSAreasContasLanc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFRM_ERPPMSAreasContasLanc.btSairClick(Sender: TObject);
begin
 self.close;
end;

procedure TFRM_ERPPMSAreasContasLanc.btConfirmarClick(Sender: TObject);
begin
 GravaDadosGrelha;
 sb.Dialogos.SBMessage('Gravado com Sucesso');
end;

procedure TFRM_ERPPMSAreasContasLanc.AcSeltodosExecute(Sender: TObject);
begin
   MudaEstado(true);
end;

Procedure TFRM_ERPPMSAreasContasLanc.MudaEstado(pEstado: Boolean);
Var
  i: Integer;
begin
  inherited;
  With Grelha Do
  Begin
    For i:=FixedRows To RowCount - 1 Do
      SetCheckBoxState(col_check,i,pEstado)

  End;
End;


procedure TFRM_ERPPMSAreasContasLanc.AcDesTodosExecute(Sender: TObject);
begin
   MudaEstado(false);
end;

procedure TFRM_ERPPMSAreasContasLanc.acAtribuirAreaExecute(
  Sender: TObject);
begin
   Listas.AbrirSQL('ListaAreaNegocio','', Grelha, SeleccionaAreaNegocioAtribGrelha)
end;

Procedure TFRM_ERPPMSAreasContasLanc.SeleccionaAreaNegocioAtribGrelha(Sender :TObject);
var
  Obj:TSBSelecaoLista;
  check:Boolean;
  I:integer;
  ContaErp:string;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
       ContaErp:= Obj.ListaValores.AtributoValor['ContaErp'].Asstring;
       For i:=Grelha.FixedRows to Grelha.RowCount-1 do
       begin
        check:=false;
        Grelha.GetCheckBoxState(Col_Check,i,check);
        If check then
        begin
          Grelha.Ints[COL_id_area,i]:=Obj.Chave;
          Grelha.Cells[COL_AreaNegocio,i]:=Obj.ValorDescricao;
          Grelha.Cells[COL_AreaContaERP,i]:=ContaErp;
        end;
       end;

      End;
   Finally
     FreeAndNil(Obj);
   end;
end;

procedure TFRM_ERPPMSAreasContasLanc.AcRemoveAreaExecute(Sender: TObject);
var   check:Boolean;
  I:integer;
  ContaErp:string;
Begin
       For i:=Grelha.FixedRows to Grelha.RowCount-1 do
       begin
        check:=false;
        Grelha.GetCheckBoxState(Col_Check,i,check);
        If check then
        begin
          Grelha.Ints[COL_id_area,i]:=0;
          Grelha.Cells[COL_AreaNegocio,i]:='';
          Grelha.Cells[COL_AreaContaERP,i]:='';
        end;
      end;  
end;

end.
