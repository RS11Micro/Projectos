unit ERP_FRMConfTipoMovStocks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, StdCtrls,
  SBEditProcura,FntBetipoMovimento;

type
  TFRMERPConfTipoMovStocks = class(TFrmFntTabelas40)
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
  FRMERPConfTipoMovStocks: TFRMERPConfTipoMovStocks;

implementation
    Uses  iERPOGlobais, SBLista, SBBotoes, SBControlos,ERPLogOperacoes;
{$R *.dfm}


procedure TFRMERPConfTipoMovStocks.edtDescricaoBtListaClick(
  Sender: TObject);
begin
  inherited;
   Listasfnt.AbrirSQL('ListaTiposDocsComprasSemContaERP','',edtDescricao, SeleccionaTipodocCMP);
end;

Procedure TFRMERPConfTipoMovStocks.SeleccionaTipodocCMP(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj:=TSBSelecaoLista(Sender);
  edtDescricao.ID_Chave:=Obj.Chave;
  edtDescricao.text:=Obj.ValorDescricao;
  Obj.Free;
end;



procedure TFRMERPConfTipoMovStocks.edtDescricaoBtEliminarClick(
  Sender: TObject);
begin
  inherited;
    edtDescricao.ID_Chave:=0;
end;


Procedure TFRMERPConfTipoMovStocks.MostraBE;
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

Procedure TFRMERPConfTipoMovStocks.Limpa;
Begin
  edtDescricao.Limpa;
  edtDescricao.ID_Chave:=0;
  EdcontaERP.Clear;
End;

Procedure TFRMERPConfTipoMovStocks.CfInserir;
var
 strsql:string;
Begin
  FechaForm:=false;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update TipoMovimento set contaERP='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  TipoMovimento.id_TipoMovimento='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
          RegistaLogOperacao('Interface Compras: Associar Tipo Mov.:'+edtDescricao.text+' a Conta ERP:'+EdcontaERP.text);

     Limpa;
 end
 else
 begin
  FechaForm:=false;
  sb.Dialogos.SBMessage('Selecione o Tipo de documento de Compra!');
 end;
End;

Procedure TFRMERPConfTipoMovStocks.CfAlterar;
var
 strsql:string;
Begin
  FechaFormAlteracao:=true;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update TipoMovimento set contaERP='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  TipoMovimento.id_TipoMovimento='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
     RegistaLogOperacao('Interface Compras: Associar Tipo Mov.:'+edtDescricao.text+' a Conta ERP:'+EdcontaERP.text);
 end
 else
 begin
  FechaFormAlteracao:=false;
  sb.Dialogos.SBMessage('Selecione o Tipo de documento de Compra!');
 end;
End;

Procedure TFRMERPConfTipoMovStocks.CfAnular;
var
 strsql:string;
Begin
 strsql:='update TipoMovimento set contaERP='+sb.UtilSQL.StrToSQLStrpelica('')
 +' where  TipoMovimento.id_TipoMovimento='+Inttostr(edtDescricao.ID_Chave);
 sb.SBBD.Executa(strsql);
RegistaLogOperacao('Interface Compras: Remover conta ERP do:  Tipo Mov.:'+edtDescricao.text+' Conta ERP:'+EdcontaERP.text);

End;



procedure TFRMERPConfTipoMovStocks.FormCreate(Sender: TObject);
begin
  inherited;
 top:=20;
end;

end.
