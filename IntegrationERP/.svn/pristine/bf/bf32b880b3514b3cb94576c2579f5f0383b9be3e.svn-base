unit ERP_FRMFntAreasClasses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, Grids, AdvObj, BaseGrid, AdvGrid, AdvToolBar,
  SBEditProcura,inifiles,sblista,SBControlos,adodb, StdCtrls, ExtCtrls,
  AdvPanel,ERPBEEMPRESAINTERFACE;

type
  TFRM_ERPFntAreasClasses = class(TForm)
    a: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    btSair: TAdvToolBarButton;
    btConfirmar: TAdvToolBarButton;
    AdvPanel1: TAdvPanel;
    Grelha: TAdvStringGrid;
    epimagem: TSBEditProcura;
    procedure FormCreate(Sender: TObject);
    procedure btConfirmarClick(Sender: TObject);
    procedure GrelhaRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure GrelhaClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure GrelhaButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure btSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GrelhaCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private
    { Private declarations }
    FOBJInterface:TERPBEEMPRESAINTERFACE;
    Procedure FormataGrelha(pGrelha:TadvStringGrid);
    procedure PreencheGrelha;
    procedure GravaDadosGrelha;
    Procedure SeleccionaAreaNegocio(Sender :TObject);    
  public
    { Public declarations }
  end;

var
  FRM_ERPFntAreasClasses: TFRM_ERPFntAreasClasses;

implementation
uses IERPOGLOBAIS,SBBotoes,SBBETabelaDados, SBBaseDados, SBBSSistemaBase,IERPFrmPrincipal;

{$R *.dfm}
Const

  COL_ID_ClassePrecos = 0;
  COL_ClassePrecos = 1;
  COL_AreaNegocio = 2;
  COL_AreaContaERP = 3;
  COL_id_area= 4;
  COL_MAx = 5;



Procedure TFRM_ERPFntAreasClasses.FormataGrelha(pGrelha:TadvStringGrid);
var
  i: Integer;
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


    ColWidths[COL_ID_ClassePrecos] := 70;
    ColWidths[COL_ClassePrecos] := 150;

    ColWidths[COL_AreaNegocio] := 150;
    ColWidths[COL_AreaContaERP] := 85;
    ColWidths[COL_id_area] := 0;



    ColWidths[COL_ClassePrecos]:= Width -ColWidths[COL_ID_ClassePrecos]-
    ColWidths[COL_AreaNegocio]-   ColWidths[COL_AreaContaERP] -
    ColWidths[COL_id_area]-   21;

    Options:=  [goFixedVertLine]+[goColSizing]+[goFixedHorzLine] + [goHorzLine] + [goVertLine] + [goEditing];
    With Navigation do
    begin
      AllowDeleteRow:=True;
      AllowInsertRow:=True;
    end;

    Cells[COL_ID_ClassePrecos, 0] := SB.Idioma.daTraducao(0, 'Cod.Classe Preços');
    Cells[COL_ClassePrecos, 0] := SB.Idioma.daTraducao(0, 'Desc.Classe Preços');

    Cells[COL_AreaNegocio, 0] := SB.Idioma.daTraducao(0, 'Área Negócio');
    Cells[COL_AreaContaERP, 0] := SB.Idioma.daTraducao(0, 'Conta Area ERP');
    EndUpdate;
  end;
End;

procedure TFRM_ERPFntAreasClasses.PreencheGrelha;
var
  strsql:string;
  Listaexterna:tsbbetabeladados;
  ListaErp:tsbbetabeladados;
  i:integer;
begin
 strsql:='Select * from tab_classe order by vdesc';
 Listaexterna:=sb.SBBD.AbrirLV(FOBJInterface.BDConexao,strsql);
 
 strsql:='Select ERP_AreaNegocioCPrecosFNT.ID_AreaNegocio,ErP_AreaNegocio.DescricaoArea,'
 +' ErP_AreaNegocio.Contaerp,ERP_AreaNegocioCPrecosFNT.ID_ClassePrecos'
 +' from ERP_AreaNegocioCPrecosFNT '
 +' inner join ErP_AreaNegocio on ErP_AreaNegocio.Id_areanegocio=ERP_AreaNegocioCPrecosFNT.id_areanegocio'
 +' where ID_InternoInterface='+Inttostr(FOBJInterface.ID);
 ListaErp:= sb.SBBD.AbrirLV(strsql);

 i:=1;
 If  Not(Listaexterna.Vazia) then
 begin
  Grelha.ClearNormalCells;
  Grelha.RowCount:=Grelha.FixedRows+ Listaexterna.NumLinhas;
  while not Listaexterna.nofim do
  begin
    Grelha.ints[COL_ID_ClassePrecos,i] :=Listaexterna.davalor('vcodi').asinteger ;
    Grelha.cells[COL_ClassePrecos,i] :=Listaexterna.davalor('vdesc').asstring ;
    If Not(ListaErp.Vazia) then
    begin
      If ListaErp.DataSet.Locate('ID_ClassePrecos',Listaexterna.davalor('vcodi').asinteger,[])then
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

procedure TFRM_ERPFntAreasClasses.FormCreate(Sender: TObject);
var
ID_ERP_VENDASSYSCONTROLLER:Integer;
segue:boolean;
begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  FormataGrelha(grelha);
  segue:=true;
  FOBJInterface:=nil;
  ID_ERP_VENDASSYSCONTROLLER:=0;
  ID_ERP_VENDASSYSCONTROLLER:=FrmIERPPrincipal.tbexportacaoVendasFnt.tag;
  If ID_ERP_VENDASSYSCONTROLLER<=0 then
   segue:=false;

  If segue=true then
  begin
   FOBJInterface:=MotorERP.ERPInterface.Edita(ID_ERP_VENDASSYSCONTROLLER);
   If FOBJInterface=nil then
   begin
    segue:=false;
   end
  end;
  If    segue=false then
  begin
   sb.Dialogos.SBAviso(' O Interface de ERP Vendas SysController não está configurado');
   btConfirmar.enabled:=false;
  end;

  IF segue=true then
  begin
   PreencheGrelha;
  end;
end;


procedure TFRM_ERPFntAreasClasses.GravaDadosGrelha;
var
  strsql:string;
  Listaexterna:tsbbetabeladados;
  ListaErp:tsbbetabeladados;
  i:integer;
begin
 strsql:= 'delete from  ERP_AreaNegocioCPrecosFNT '
         +' where ID_InternoInterface='+Inttostr(FOBJInterface.ID);
 sb.SBBD.Executa(strsql);

 For i:=grelha.FixedRows to Grelha.rowcount-1 do
 begin
  If Grelha.ints[COL_id_area,i]>0 then
  begin
      strsql:= ' INSERT INTO [ERP_AreaNegocioCPrecosFNT]'
             +' ([ID_InternoInterface]'
             +' ,[ID_AreaNegocio]'
             +' ,[ID_ClassePrecos]'
             +' ,[DescClassePrecos])'
             +'  VALUES ('  + Inttostr(FOBJInterface.ID)
             +','+   Grelha.cells[COL_id_area,i]
             +','+   Grelha.cells[COL_ID_ClassePrecos,i]
             +','+#39+   Grelha.cells[COL_ClassePrecos,i]+#39
             +')';
        sb.SBBD.Executa(strsql);

  end;
 end;
end;



procedure TFRM_ERPFntAreasClasses.btConfirmarClick(Sender: TObject);
begin
GravaDadosGrelha;
 sb.Dialogos.SBMessage('Gravado com Sucesso');
end;

procedure TFRM_ERPFntAreasClasses.GrelhaRowChanging(Sender: TObject;
  OldRow, NewRow: Integer; var Allow: Boolean);
begin
  RemoveBotaoGrelha(Grelha, COL_AreaNegocio, OldRow);

  if (NewRow >= Grelha.FixedRows) then
  begin
    If  Grelha.cells[COL_AreaNegocio, NewRow]='' then
            AdicionaBotaoGrelha(Grelha, COL_AreaNegocio, NewRow, epimagem.BtListaGlyph);
  end;

end;

procedure TFRM_ERPFntAreasClasses.GrelhaClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin

    AdicionaBotaoGrelha(Grelha, COL_AreaNegocio, ARow, epimagem.BtListaGlyph);

end;

procedure TFRM_ERPFntAreasClasses.GrelhaButtonClick(Sender: TObject; ACol,
  ARow: Integer);
begin

  If Acol = COL_AreaNegocio then
    Listas.AbrirSQL('ListaAreaNegocio','', Grelha, SeleccionaAreaNegocio)

end;


Procedure TFRM_ERPFntAreasClasses.SeleccionaAreaNegocio(Sender :TObject);
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

procedure TFRM_ERPFntAreasClasses.btSairClick(Sender: TObject);
begin
 self.close;
end;

procedure TFRM_ERPFntAreasClasses.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFRM_ERPFntAreasClasses.GrelhaCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
 canedit:=(acol=COL_AreaNegocio);
end;

end.
