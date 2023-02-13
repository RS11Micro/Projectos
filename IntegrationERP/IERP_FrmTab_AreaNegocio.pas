unit IERP_FrmTab_AreaNegocio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls,
  AdvOfficeButtons, StdCtrls, AdvGroupBox, Mask, AdvEdit, AdvMEdBtn,
  PlannerMaskDatePicker, SBEditProcura, AdvOfficePager,SBBEExcepcoes,ERPBEAreaNegocio;

type
  TFrm_IERPTab_AreaNegocio = class(TFrmFntTabelas40)
    AdvOfficePager1: TAdvOfficePager;
    AdvPanel1: TAdvPanel;
    Label1: TLabel;
    Eddescricao: TEdit;
    Label2: TLabel;
    edcontaerp: TEdit;

    procedure FormCreate(Sender: TObject);
    Private
    FID_AreaNegocio:Integer;

  { Private declarations }
   Procedure LimpaEdits(pControlo :TWinControl);
  procedure FAntesAbrir(Sender: TObject);

    Procedure AntesabrirLista(Sender :TObject;var pAbreLista:boolean);
  Public

  { Public declarations }

  Procedure CfInserir; Override;
  Procedure CfAlterar; Override;
  Procedure CfAnular; Override;
  Function  PreencheBE: TERPBEAreaNegocio;
  Procedure Limpa; Override;
  Procedure MostraBE; Override;
  end;

var
  Frm_IERPTab_AreaNegocio: TFrm_IERPTab_AreaNegocio;

implementation
Uses SBLista, IERPOGlobais, SBControlos, SBBEEntidade, SBBEChaves,SBBETabelaDados;

{$R *.dfm}
Function TFrm_IERPTab_AreaNegocio.PreencheBE():TERPBEAreaNegocio;
Begin
  Result  := TERPBEAreaNegocio.Create;

  With Result Do
  Begin
      ID_AreaNegocio:=FID_AreaNegocio;
      DescricaoArea:=Eddescricao.text;
      ContaERP:=edcontaerp.text;
  End;
End;

Procedure TFrm_IERPTab_AreaNegocio.MostraBE;
var
  Obj :TERPBEAreaNegocio;
begin
  Obj := MotorERP.AreaNegocio.Edita(ValorChave);
  If Assigned(Obj) Then
  Begin
    Try
      FID_AreaNegocio          := Obj.ID_AreaNegocio;
      Eddescricao.Text         := Obj.DescricaoArea;
      edcontaerp.Text          := Obj.ContaERP;
    Finally
      Obj.Free;
    End;
  End
  Else raise SB.ErroNormal(0,'AreaNegocio','MostraBE','O registo não existe. Foi removido por outro posto.');


End;

Procedure TFrm_IERPTab_AreaNegocio.CfInserir;
var
  strErros :String;
  Obj :TERPBEAreaNegocio;
Begin
  ActiveControl := FindNextControl(ActiveControl,True,True,False);
  Obj := PreencheBE;

  If Assigned(Obj) Then
  Begin
    Try
      SB.SBBD.IniciaTransacao;
      Try
        MotorERP.AreaNegocio.Actualiza(Obj, strErros);
        SB.SBBD.TerminaTransacao;
      Except
        On E :Exception Do
        Begin
          SB.SBBD.DesfazTransacao;
          Raise EErroDetalhe.Create('AreaNegocio', 'Inserir', SB.Idioma.daTraducao(603,'Validação'), strErros);
        End;
      End;
    Finally
      Obj.Free;
    End
  End;
End;


Procedure TFrm_IERPTab_AreaNegocio.CfAlterar;
var
  strErros :String;
  Obj :TERPBEAreaNegocio;
Begin
   ActiveControl := FindNextControl(ActiveControl,True,True,False);
  Obj := PreencheBE;

  If Assigned(Obj) Then
  Begin
    Try
      SB.SBBD.IniciaTransacao;
      Try
        Obj.EmModoEdicao := True;
        MotorERP.AreaNegocio.Actualiza(Obj, strErros);
        SB.SBBD.TerminaTransacao;
      Except
        On E :Exception Do
        Begin
          SB.SBBD.DesfazTransacao;
          raise EErroDetalhe.Create('AreaNegocio','Alterar',SB.Idioma.daTraducao(603,'Validação'),strErros);
        End;
      End;
    Finally
      Obj.Free;
    End
  End;
End;


Procedure TFrm_IERPTab_AreaNegocio.CfAnular;
Begin

End;

Procedure TFrm_IERPTab_AreaNegocio.Limpa;
Begin

  LimpaEdits(Self);
End;

Procedure TFrm_IERPTab_AreaNegocio.LimpaEdits(pControlo :TWinControl);
var
  Posicao :Longint;
Begin
  For Posicao := 0 To (pControlo.ComponentCount - 1) Do
  Begin
    If (Self.Components[Posicao] Is TCustomEdit) Then
      TCustomEdit(pControlo.Components[Posicao]).Clear;
  End;
End;

procedure TFrm_IERPTab_AreaNegocio.FAntesAbrir(Sender: TObject);
begin
  Self.Width := 485;
  Self.Height := 168;
end;








procedure TFrm_IERPTab_AreaNegocio.FormCreate(Sender: TObject);
begin
  inherited;
  Self.OnAntesAbrir := FAntesAbrir;
end;

Procedure TFrm_IERPTab_AreaNegocio.AntesAbrirLista(Sender :TObject;var pAbreLista:boolean);
var

    i:Integer;
    enc:boolean;
    Linha:integer;
Begin


end;

end.


