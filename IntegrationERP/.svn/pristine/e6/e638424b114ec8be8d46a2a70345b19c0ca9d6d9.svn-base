unit ERP_FRMConfPagamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, StdCtrls,FntBeMetodoPagamento,
  SBEditProcura;

type
  TFRMERPConfPagamentos = class(TFrmFntTabelas40)
    edtDescricao: TSBEditProcura;
    EdcontaERP: TEdit;
    Label6: TLabel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtDescricaoBtListaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure SelecionaPagamentosSemContaERP(Sender :TObject);
    Procedure MostraBE;override;
    Procedure Limpa;override;

    Procedure CfInserir;override;
    Procedure CfAlterar;override;
    Procedure CfAnular;override;
  end;

var
  FRMERPConfPagamentos: TFRMERPConfPagamentos;

implementation
Uses  iERPOGlobais, SBLista, SBBotoes, SBControlos, FntBS;

{$R *.dfm}

procedure TFRMERPConfPagamentos.FormCreate(Sender: TObject);
begin
  inherited;
 top:=20;
end;

Procedure TFRMERPConfPagamentos.MostraBE;
var
 Obj :TFntBeMetodoPagamento;
Begin
  Obj := MotorFnt.Metodopagamento.Edita(ValorChave);
  If Assigned(Obj) Then
  Begin
    Try
      edtDescricao.Text := Obj.Descricao;
      edtDescricao.ID_Chave:= ValorChave;
      edtDescricao.enabled:=false;
      EdcontaERP.text:= Obj.ContaCbl;
      edtDescricao.BtListaVisivel:=false;
      edtDescricao.ReadOnly:=true;
    Finally
      Obj.Free;
    End;
  End
  Else raise SB.ErroNormal(0,'Modo Pagamento/CONTA ERP','MostraBE','O registo não existe. Foi removido por outro posto.');
End;

Procedure TFRMERPConfPagamentos.Limpa;
Begin
  edtDescricao.Limpa;
  edtDescricao.ID_Chave:=0;
  EdcontaERP.Clear;
End;



Procedure TFRMERPConfPagamentos.CfInserir;
var
 strsql:string;
Begin
  FechaForm:=false;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update tab_metodopag set contaCBL='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  tab_metodopag.VCODPAG='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
     Limpa;
 end
 else
 begin
  FechaForm:=false;
  sb.Dialogos.SBMessage('Selecione o Modo de Pagamento!');
 end;
End;

Procedure TFRMERPConfPagamentos.CfAlterar;
var
 strsql:string;
Begin
  FechaFormAlteracao:=true;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update tab_metodopag set contaCBL='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  tab_metodopag.VCODPAG='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);

 end
 else
 begin
  FechaFormAlteracao:=false;
  sb.Dialogos.SBMessage('Selecione o Modo de Pagamento!');;
 end;
End;

Procedure TFRMERPConfPagamentos.CfAnular;
var
 strsql:string;
Begin
     strsql:='update tab_metodopag set contaCBL='+sb.UtilSQL.StrToSQLStrpelica('')
     +' where  tab_metodopag.VCODPAG='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
End;


procedure TFRMERPConfPagamentos.edtDescricaoBtListaClick(Sender: TObject);
begin
  inherited;
ListasFNT.AbrirSQL('ListaPagamentosSemContaERP','',edtDescricao, SelecionaPagamentosSemContaERP);
end;

Procedure TFRMERPConfPagamentos.SelecionaPagamentosSemContaERP(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj:=TSBSelecaoLista(Sender);
  edtDescricao.ID_Chave:=Obj.Chave;
  edtDescricao.text:=Obj.ValorDescricao;
  Obj.Free;
end;


end.
