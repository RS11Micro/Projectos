unit ERP_FRMConfIVAS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, StdCtrls,
  SBEditProcura,FntBEIVA;

type
  TFRMERPConfIVAS = class(TFrmFntTabelas40)
    edtIVA: TSBEditProcura;
    Label5: TLabel;
    Label6: TLabel;
    EdcontaERP: TEdit;
    EdPercentagem: TEdit;
    procedure edtIVABtListaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure SeleccionaIVA(Sender :TObject);

    Procedure MostraBE;override;
    Procedure Limpa;override;

    Procedure CfInserir;override;
    Procedure CfAlterar;override;
    Procedure CfAnular;override;

  public
    { Public declarations }
  end;

var
  FRMERPConfIVAS: TFRMERPConfIVAS;

implementation
Uses  iERPOGlobais, SBLista, SBBotoes, SBControlos;

{$R *.dfm}

Procedure TFRMERPConfIVAS.MostraBE;
var
 Obj :TFntBeIVA;
Begin
  Obj := MotorFnt.IVA.Edita(ValorChave);
  If Assigned(Obj) Then
  Begin
    Try
      edtIVA.Text := Obj.DescricaoIva;
      edtIVA.ID_Chave:= ValorChave;
      EdPercentagem.Text:=Floattostr(Obj.PercentagemIva);
      EdcontaERP.text:= Obj.ContaCbl;
      edtIVA.BtListaVisivel:=false;
      edtIVA.Enabled:=false;
        EdPercentagem.Enabled:=false;
    Finally
      Obj.Free;
    End;
  End
  Else raise SB.ErroNormal(0,'IVA/CONTA ERP','MostraBE','O registo não existe. Foi removido por outro posto.');
End;

Procedure TFRMERPConfIVAS.Limpa;
Begin
  edtIVA.Limpa;
  edtIVA.ID_Chave:=0;

  edtIVA.Hint:='';
  edtIVA.id_chave:=0;
  EdcontaERP.Clear;
  EdPercentagem.Clear;
End;


Procedure TFRMERPConfIVAS.CfInserir;
var
 strsql:string;
Begin
  FechaForm:=false;
 If edtIVA.ID_Chave>0 then
 begin
     strsql:='update TAB_IVA set contaCBL='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  TAB_IVA.vcodi='+Inttostr(edtIVA.ID_Chave);
     sb.SBBD.Executa(strsql);
     Limpa;
 end
 else
 begin
  FechaForm:=false;
  sb.Dialogos.SBMessage('Selecione o IVA!');
 end;
End;



Procedure TFRMERPConfIVAS.CfAlterar;
var
 strsql:string;
Begin
  FechaFormAlteracao:=true;
 If edtIVA.ID_Chave>0 then
 begin
  strsql:='update TAB_IVA set contaCBL='+sb.UtilSQL.StrToSQLStrpelica(EdcontaERP.text)
     +' where  TAB_IVA.vcodi='+Inttostr(edtIVA.ID_Chave);
     sb.SBBD.Executa(strsql);

 end
 else
 begin
  FechaFormAlteracao:=false;
  sb.Dialogos.SBMessage('Selecione o IVA!');
 end;
End;

Procedure TFRMERPConfIVAS.CfAnular;
var
 strsql:string;
Begin
  strsql:='update TAB_IVA set contaCBL='+sb.UtilSQL.StrToSQLStrpelica('')
     +' where  TAB_IVA.vcodi='+Inttostr(edtIVA.ID_Chave);
  sb.SBBD.Executa(strsql);
End;


procedure TFRMERPConfIVAS.edtIVABtListaClick(Sender: TObject);
begin
Listasfnt.AbrirSQL('ListaIVASSEMContaERP','',edtIVA, SeleccionaIVA);
end;

Procedure TFRMERPConfIVAS.SeleccionaIVA(Sender :TObject);
var
  Obj:TSBSelecaoLista;
  Percentagem:String;
Begin
  Obj:=TSBSelecaoLista(Sender);
  edtIVA.ID_Chave:=Obj.Chave;
  edtIVA.text:=Obj.ValorDescricao;
  Percentagem:=  MotorFnt.Iva.DaValorAtributo(obj.chave,'NPERC').asstring;
  EdPercentagem.Text:=Percentagem;
  Obj.Free;
end;

procedure TFRMERPConfIVAS.FormCreate(Sender: TObject);
begin
  inherited;
 top:=20;
end;

end.
