unit ERP_FRMConfTipodoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, StdCtrls,FntBetipodocVnd,
  SBEditProcura;

type
  TFRMERPConfTipodoc = class(TFrmFntTabelas40)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    AdvPanel1: TAdvPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edAbreviatura: TEdit;
    EdcontaERP: TEdit;
    edtDescricao: TSBEditProcura;
    procedure edtDescricaoBtListaClick(Sender: TObject);
    procedure edtDescricaoBtEliminarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
//    Function PreencheBE:TFntBEPais;
    Procedure SeleccionaTipodocVnd(Sender :TObject);
    Procedure MostraBE;override;
    Procedure Limpa;override;

    Procedure CfInserir;override;
    Procedure CfAlterar;override;
    Procedure CfAnular;override;

  end;

var
  FRMERPConfTipodoc: TFRMERPConfTipodoc;

implementation
Uses  iERPOGlobais, SBLista, SBBotoes, SBControlos,ERPLogOperacoes;
{$R *.dfm}





Procedure TFRMERPConfTipodoc.MostraBE;
var
 Obj :TFntBetipodocVnd;
Begin
  Obj := MotorFnt.TipodocVnd.Edita(ValorChave);
  If Assigned(Obj) Then
  Begin
    Try
      edtDescricao.Text := Obj.Descricao;
      edtDescricao.ID_Chave:= ValorChave;
      edAbreviatura.Text := Obj.Abreviatura;
      EdcontaERP.text:= Obj.ContaERP;
      edtDescricao.BtListaVisivel:=false;
      edtDescricao.enabled:=false;
      edAbreviatura.enabled:=false;

    Finally
      Obj.Free;
    End;
  End
  Else raise SB.ErroNormal(0,'Tipo DOC.Vnd/CONTA ERP','MostraBE','O registo não existe. Foi removido por outro posto.');
End;

Procedure TFRMERPConfTipodoc.Limpa;
Begin
  edtDescricao.Limpa;
  edtDescricao.ID_Chave:=0;
  edAbreviatura.clear;
  EdcontaERP.Clear;
End;

Procedure TFRMERPConfTipodoc.CfInserir;
var
 strsql:string;
Begin
  FechaForm:=false;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update Tipodocvnd set contaERP='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  Tipodocvnd.id_TipodocVnd='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
     RegistaLogOperacao('Interface VD SYSPOS: Associar Tipo Doc.:'+edtDescricao.text+' a Conta ERP:'+EdcontaERP.text);
     Limpa;
 end
 else
 begin
  FechaForm:=false;
  sb.Dialogos.SBMessage('Selecione o Tipo de documento de Venda!');
 end;
End;

Procedure TFRMERPConfTipodoc.CfAlterar;
var
 strsql:string;
Begin
  FechaFormAlteracao:=true;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update Tipodocvnd set contaERP='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  Tipodocvnd.id_TipodocVnd='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
     RegistaLogOperacao('Interface VD SYSPOS: Associar Tipo Doc.:'+edtDescricao.text+' a Conta ERP:'+EdcontaERP.text);
 end
 else
 begin
  FechaFormAlteracao:=false;
  sb.Dialogos.SBMessage('Selecione o Tipo de documento de Venda!');
 end;
End;

Procedure TFRMERPConfTipodoc.CfAnular;
var
 strsql:string;
Begin
 strsql:='update Tipodocvnd set contaERP='+sb.UtilSQL.StrToSQLStrpelica('')
 +' where  Tipodocvnd.id_TipodocVnd='+Inttostr(edtDescricao.ID_Chave);
 sb.SBBD.Executa(strsql);
     RegistaLogOperacao('Interface VD SYSPOS: Remover Conta ERP do Tipo Doc.:'+edtDescricao.text+' a Conta ERP:'+EdcontaERP.text); 
End;






procedure TFRMERPConfTipodoc.edtDescricaoBtListaClick(Sender: TObject);
begin
  inherited;

Listasfnt.AbrirSQL('ListaTiposDocsSemContaERP','',edtDescricao, SeleccionaTipodocVnd);
end;

Procedure TFRMERPConfTipodoc.SeleccionaTipodocVnd(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj:=TSBSelecaoLista(Sender);
  edtDescricao.ID_Chave:=Obj.Chave;
  edtDescricao.text:=Obj.ValorDescricao;
 edAbreviatura.text:=Obj.ListaValores.AtributoValor['abreviatura'].asstring;
  Obj.Free;
end;
procedure TFRMERPConfTipodoc.edtDescricaoBtEliminarClick(Sender: TObject);
begin
  inherited;
  edtDescricao.ID_Chave:=0;
  edAbreviatura.clear;

end;

procedure TFRMERPConfTipodoc.FormCreate(Sender: TObject);
begin
  inherited;
 top:=20;
end;

end.
