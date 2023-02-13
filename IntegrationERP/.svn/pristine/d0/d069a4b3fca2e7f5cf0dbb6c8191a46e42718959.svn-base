unit ERP_FRMConfProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, Grids, AdvObj,
  BaseGrid, AdvGrid, StdCtrls, SBEditProcura,sblista,sbbeConstipos,FntBeProduto;

type
  TFRMERPConfProdutos = class(TFrmFntTabelas40)
    AdvPanel1: TAdvPanel;
    edtDescricao: TSBEditProcura;
    Label1: TLabel;
    painelInsercao: TAdvPanel;
    GrelhaProdutos: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure edtDescricaoBtListaClick(Sender: TObject);
    procedure GrelhaProdutosCanEditCell(Sender: TObject; ARow,
      ACol: Integer; var CanEdit: Boolean);
  private
    { Private declarations }
    Procedure SeleccionaSubfamilia(Sender :TObject);
    procedure FAntesAbrir(Sender: TObject);
    Procedure FormataGrelhaProdutos;
    procedure PrencheGrelhaProdutos;
    procedure GravaContasERPProdutos;

//    Procedure SeleccionaSubfamilia(Sender :TObject);
  //  Procedure SeleccionaProduto(Sender :TObject);
    Procedure MostraBE;override;
    Procedure Limpa;override;

    Procedure CfInserir;override;
    Procedure CfAlterar;override;
    Procedure CfAnular;override;
  public
    { Public declarations }
  end;

var
  FRMERPConfProdutos: TFRMERPConfProdutos;

implementation
uses iERPOGLOBAIS,SBBETABELADADOS, SBBSUtilSQL;


Const
  Col_PRODID_Produto=0;
  Col_PRODDescricao=1;
  Col_PRODCONTAERP=2;
  Col_PRODMax=3;

{$R *.dfm}

procedure TFRMERPConfProdutos.PrencheGrelhaProdutos;
var
strsql:string;
ListaProd:TSBBETABELADADOS;
i:integer;
LinhaProdSelecionado:Integer;
begin
    LinhaProdSelecionado:=0;
    strsql:='select Vproduto,Vdesc1,contacbl '
    +' from tab_Produto '
    +' where Activo=1 and  VSUBFAM='+Inttostr(edtDescricao.id_chave);
    ListaProd:=sb.SBBD.AbrirLV(strsql);
    Try
        i:=GrelhaProdutos.FixedRows;
        GrelhaProdutos.ClearNormalCells;
        GrelhaProdutos.RowCount:=GrelhaProdutos.FixedRows+1;

        If not ListaProd.vazia then
        begin
             GrelhaProdutos.RowCount:=GrelhaProdutos.FixedRows+ListaProd.NumLinhas;
           while  not(ListaProd.NoFim) do
           begin
            with GrelhaProdutos do
            begin
               ints[Col_PRODID_Produto,i]:=ListaProd.davalor('vproduto').asinteger;
               cells[Col_PRODDescricao,i]:=ListaProd.davalor('Vdesc1').asstring;
               cells[Col_PRODCONTAERP,i]:=ListaProd.davalor('contacbl').asstring;
               If  ListaProd.davalor('vproduto').asinteger=ValorChave then
                   LinhaProdSelecionado:=i;
            end;
            inc(i);
            ListaProd.seguinte;
           end;
        end;
    Finally
     ListaProd.fecha;
     Freeandnil(ListaProd);
    end;
    If LinhaProdSelecionado>0 then
    begin
     GrelhaProdutos.Row:= LinhaProdSelecionado;
     GrelhaProdutos.col:=Col_PRODCONTAERP;     
    end;

end;

procedure TFRMERPConfProdutos.FAntesAbrir(Sender: TObject);
begin
FormataGrelhaProdutos;

end;


Procedure TFRMERPConfProdutos.FormataGrelhaProdutos;
Var
//  item: TMenuItem;
  i:integer;
  strEstado:string;
Begin
  with GrelhaProdutos do
  begin
    BeginUpdate;
    Clear;
    FixedCols := 0;
    FixedRows := 1;
    RowCount := FixedRows + 1;
    ColCount := Col_PRODMax;

    ColWidths[Col_PRODID_Produto] := 70;

    ColWidths[Col_PRODCONTAERP] := 80;



    ColWidths[Col_PRODDescricao]:= Width -ColWidths[Col_PRODID_Produto]
     -ColWidths[Col_PRODCONTAERP]-21;


    Options:= [goFixedVertLine] + [goFixedHorzLine] + [goHorzLine] + [goVertLine];
    With Navigation do
    begin
        AllowDeleteRow:=false;
        AllowInsertRow:=False;
    end;

    ControlLook.NoDisabledButtonLook:=True;
    Cells[Col_PRODID_Produto, 0] := SB.Idioma.daTraducao(0, 'Código');
    Cells[Col_PRODCONTAERP, 0] := SB.Idioma.daTraducao(0, 'Conta ERP');
    Cells[Col_PRODDescricao, 0] := SB.Idioma.daTraducao(0, 'Descrição');


    EndUpdate;
  end;
End;

procedure TFRMERPConfProdutos.FormCreate(Sender: TObject);
begin
  inherited;
    Self.OnAntesAbrir:=FAntesAbrir;
    top:=20;
end;

Procedure TFRMERPConfProdutos.MostraBE;
var
 Obj :TFntBeProduto;
 ID_subfamilia:integer;
Begin
  ID_subfamilia:=0;
  ID_subfamilia := MotorFnt.Produto.davaloratributo(ValorChave,'VSUBFAM').asinteger;
  edtDescricao.ID_Chave:=ID_subfamilia;
  edtDescricao.text:=MotorFnt.SubFamiliaProduto.DaValorDescricao(ID_subfamilia);

  PrencheGrelhaProdutos;
End;

Procedure TFRMERPConfProdutos.Limpa;
Begin
    edtDescricao.Limpa;
    GrelhaProdutos.ClearNormalCells;
    GrelhaProdutos.RowCount:=GrelhaProdutos.FixedRows+1;
End;

Procedure TFRMERPConfProdutos.CfInserir;
var
 strsql:string;
Begin
  FechaForm:=false;

 If edtDescricao.ID_Chave>0 then
 begin
       GravaContasERPProdutos;
       Limpa;
 end
 else
 begin
  FechaForm:=false;
  sb.Dialogos.SBMessage('Selecione a Sub.Familia de Produtos!');
 end;
End;

Procedure TFRMERPConfProdutos.CfAlterar;
var
 strsql:string;
Begin

  FechaFormAlteracao:=true;

 If edtDescricao.ID_Chave>0 then
 begin
       GravaContasERPProdutos;
       Limpa;
 end
 else
 begin
  FechaFormAlteracao:=false;
  sb.Dialogos.SBMessage('Selecione a Sub.Familia de Produtos!');
 end;

End;

Procedure TFRMERPConfProdutos.CfAnular;
var
 strsql:string;
Begin
{ strsql:='update Tipodocvnd set contaERP='+sb.UtilSQL.StrToSQLStrpelica('')
 +' where  Tipodocvnd.id_TipodocVnd='+Inttostr(edtDescricao.ID_Chave);
 sb.SBBD.Executa(strsql); }
End;



procedure TFRMERPConfProdutos.edtDescricaoBtListaClick(Sender: TObject);
begin
    Listasfnt.AbrirSQL('ListaSubFamProdutos','',edtDescricao, SeleccionaSubfamilia);
end;

Procedure TFRMERPConfProdutos.SeleccionaSubfamilia(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj:=TSBSelecaoLista(Sender);
  edtDescricao.ID_Chave:=Obj.Chave;
  edtDescricao.text:=Obj.ValorDescricao;
  PrencheGrelhaProdutos;
  Obj.Free;
end;

procedure TFRMERPConfProdutos.GrelhaProdutosCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  canedit:=((arow>0) and (Acol=Col_PRODCONTAERP));
end;

procedure TFRMERPConfProdutos.GravaContasERPProdutos;
var
  i:integer;
  strsql:string;
  ID_Produto:Integer;
  ContaErp:string;
begin
  For i:=GrelhaProdutos.FixedRows to GrelhaProdutos.RowCount-1 do
  begin
   ContaErp:= GrelhaProdutos.Cells[Col_PRODCONTAERP, i];
   ID_Produto:= GrelhaProdutos.ints[Col_PRODID_Produto, i];

   strsql:='Update Tab_Produto set contaCBL='+sb.UtilSQL.StrToSQLStrpelica(ContaErp)
        +' where tab_Produto.vproduto='+Inttostr(ID_Produto);
   sb.SBBD.Executa(strsql);
  end;
end;

end.
