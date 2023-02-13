unit ERP_FRMConfArmazem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, StdCtrls,FntBeArmazem,
  SBEditProcura;


type
  TFRMERPConfArmazem = class(TFrmFntTabelas40)
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
   Procedure SeleccionaArmazem(Sender :TObject);
    Procedure MostraBE;override;
    Procedure Limpa;override;

    Procedure CfInserir;override;
    Procedure CfAlterar;override;
    Procedure CfAnular;override;
  end;

var
  FRMERPConfArmazem: TFRMERPConfArmazem;

implementation
Uses  iERPOGlobais, SBLista, SBBotoes, SBControlos;

{$R *.dfm}



Procedure TFRMERPConfArmazem.MostraBE;
var
 Obj :TFNTBEArmazem;
Begin
  Obj := MotorFnt.Armazem.Edita(ValorChave);
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
  Else raise SB.ErroNormal(0,'Armazem/CONTA ERP','MostraBE','O registo não existe. Foi removido por outro posto.');
End;

Procedure TFRMERPConfArmazem.Limpa;
Begin
  edtDescricao.Limpa;
  edtDescricao.ID_Chave:=0;
  EdcontaERP.Clear;
End;

Procedure TFRMERPConfArmazem.CfInserir;
var
 strsql:string;
Begin
  FechaForm:=false;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update Armazem set contaERP='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  Armazem.id_Armazem='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
     Limpa;
 end
 else
 begin
  FechaForm:=false;
  sb.Dialogos.SBMessage('Selecione o Armazem de Compra!');
 end;
End;

Procedure TFRMERPConfArmazem.CfAlterar;
var
 strsql:string;
Begin
  FechaFormAlteracao:=true;
 If edtDescricao.ID_Chave>0 then
 begin
     strsql:='update Armazem set contaERP='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  Armazem.id_Armazem='+Inttostr(edtDescricao.ID_Chave);
     sb.SBBD.Executa(strsql);
 end
 else
 begin
  FechaFormAlteracao:=false;
  sb.Dialogos.SBMessage('Selecione o Armazem!');
 end;
End;

Procedure TFRMERPConfArmazem.CfAnular;
var
 strsql:string;
Begin
 strsql:='update Armazem set contaERP='+sb.UtilSQL.StrToSQLStrpelica('')
 +' where  Armazem.id_Armazem='+Inttostr(edtDescricao.ID_Chave);
 sb.SBBD.Executa(strsql);
End;




Procedure TFRMERPConfArmazem.SeleccionaArmazem(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj:=TSBSelecaoLista(Sender);
  edtDescricao.ID_Chave:=Obj.Chave;
  edtDescricao.text:=Obj.ValorDescricao;
  Obj.Free;
end;

procedure TFRMERPConfArmazem.edtDescricaoBtListaClick(Sender: TObject);
begin
  inherited;
   Listasfnt.AbrirSQL('ListaArmazemSemContaERP','',edtDescricao, SeleccionaArmazem);
end;

procedure TFRMERPConfArmazem.edtDescricaoBtEliminarClick(
  Sender: TObject);
begin
  inherited;
  edtDescricao.ID_Chave:=0;
end;


procedure TFRMERPConfArmazem.FormCreate(Sender: TObject);
begin
  inherited;
 top:=20;
end;

end.
