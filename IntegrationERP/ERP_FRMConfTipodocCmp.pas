unit ERP_FRMConfTipodocCmp;

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, StdCtrls,FntBetipoMovimento,
  SBEditProcura;

type
  TFRMERPConfTipodocCmp = class(TFrmFntTabelas40)
    edtDescricao: TSBEditProcura;
    Label5: TLabel;
    Label6: TLabel;
    EdcontaERP: TEdit;
    procedure edtDescricaoBtListaClick(Sender: TObject);
    procedure edtDescricaoBtEliminarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    Procedure SeleccionaTipodocCMP(Sender :TObject);
    Procedure MostraBE;override;
    Procedure Limpa;override;

    Procedure CfInserir;override;
    Procedure CfAlterar;override;
    Procedure CfAnular;override;
  end;

var
  FRMERPConfTipodocCmp: TFRMERPConfTipodocCmp;

implementation
Uses  iERPOGlobais, SBLista, SBBotoes, SBControlos;
{$R *.dfm}


Procedure TFRMERPConfTipodocCmp.MostraBE;
var
 Obj :TFntBetipoMovimento;
Begin
  Obj := MotorFnt.TipoMovimento.Edita(ValorChave);
  If Assigned(Obj) Then
  Begin
    Try
      edtDescricao.Text := Obj.Descricao;
      edtDescricao.ID_Chave:= ValorChave;
      EdcontaERP.text:= Obj.ContaERP;
      edtDescricao.BtListaVisivel:=false;
      edtDescricao.enabled:=false;

    Finally
      Obj.Free;
    End;
  End
  Else raise SB.ErroNormal(0,'Tipo DOC.CMP/CONTA ERP','MostraBE','O registo não existe. Foi removido por outro posto.');
End;

Procedure TFRMERPConfTipodocCmp.Limpa;
Begin
  edtDescricao.Limpa;
  edtDescricao.ID_Chave:=0;
  EdcontaERP.Clear;
End;

Procedure TFRMERPConfTipodocCmp.CfInserir;
var
 strsql:string;
Begin
  FechaForm:=false;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update TipoMovimento set contaERP='+sb.UtilSQL.StrToSQLStr(EdcontaERP.text)
     +' where  TipoMovimento.id_TipoMovimento='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
     Limpa;
 end
 else
 begin
  FechaForm:=false;
  sb.Dialogos.SBMessage('Selecione o Tipo de documento de Compra!');
 end;
End;

Procedure TFRMERPConfTipodocCmp.CfAlterar;
var
 strsql:string;
Begin
  FechaFormAlteracao:=true;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update TipoMovimento set contaERP='+sb.UtilSQL.StrToSQLStr(EdcontaERP.text)
     +' where  TipoMovimento.id_TipoMovimento='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
 end
 else
 begin
  FechaFormAlteracao:=false;
  sb.Dialogos.SBMessage('Selecione o Tipo de documento de Compra!');
 end;
End;

Procedure TFRMERPConfTipodoccmp.CfAnular;
var
 strsql:string;
Begin
 strsql:='update TipoMovimento set contaERP='+sb.UtilSQL.StrToSQLStr('')
 +' where  TipoMovimento.id_TipoMovimento='+Inttostr(edtDescricao.ID_Chave);
 sb.SBBD.Executa(strsql);
End;




Procedure TFRMERPConfTipodocCmp.SeleccionaTipodocCMP(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj:=TSBSelecaoLista(Sender);
  edtDescricao.ID_Chave:=Obj.Chave;
  edtDescricao.text:=Obj.ValorDescricao;
  Obj.Free;
end;

procedure TFRMERPConfTipodocCmp.edtDescricaoBtListaClick(Sender: TObject);
begin
  inherited;
   Listasfnt.AbrirSQL('ListaTiposDocsComprasSemContaERP','',edtDescricao, SeleccionaTipodocCMP);
end;

procedure TFRMERPConfTipodocCmp.edtDescricaoBtEliminarClick(
  Sender: TObject);
begin
  inherited;
  edtDescricao.ID_Chave:=0;
end;

procedure TFRMERPConfTipodocCmp.FormCreate(Sender: TObject);
begin
  inherited;
 top:=20;
end;

end.
