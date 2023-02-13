unit IERP_FrmTab_Util;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls,
  AdvOfficeButtons, StdCtrls, AdvGroupBox, Mask, AdvEdit, AdvMEdBtn,
  PlannerMaskDatePicker, SBEditProcura, AdvOfficePager,SBBEUtilizador,SBBEExcepcoes;

type
  TFrm_IERPTab_Util = class(TFrmFntTabelas40)
    AdvOfficePager1: TAdvOfficePager;
    tssbGeral: TAdvOfficePage;
    lbsbUtilizador: TLabel;
    lbsbChave: TLabel;
    lbsbGrupoUtilizadores: TLabel;
    lbsbFimActividade: TLabel;
    lbsbDataNasc: TLabel;
    edtLogin: TEdit;
    edtNome: TEdit;
    edtSenha: TEdit;
    epGrpUtilizador: TSBEditProcura;
    edtDataExpiracao: TPlannerMaskDatePicker;
    edtDataNascimento: TPlannerMaskDatePicker;
    gbsbUltimoLogin: TAdvGroupBox;
    LbsbHora: TLabel;
    lbsbData: TLabel;
    edtHoraLogin: TEdit;
    edtDataUltimoLogin: TEdit;
    procedure epGrpUtilizadorBtListaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Private
  FID_Util:Integer;
  FID_Utilizador: String;

  { Private declarations }
   Procedure LimpaEdits(pControlo :TWinControl);
  procedure FAntesAbrir(Sender: TObject);
  procedure SeleccionaGrupoUtilizador(Sender: TObject);
    Procedure AntesabrirLista(Sender :TObject;var pAbreLista:boolean);
  Public

  { Public declarations }

  Procedure CfInserir; Override;
  Procedure CfAlterar; Override;
  Procedure CfAnular; Override;
  Function  PreencheBE: TSBBEUtilizador;
  Procedure Limpa; Override;
  Procedure MostraBE; Override;
  end;

var
  Frm_IERPTab_Util: TFrm_IERPTab_Util;

implementation
Uses SBLista, IERPOGlobais, SBControlos, SBBEEntidade, SBBEChaves,SBBETabelaDados;

{$R *.dfm}
Function TFrm_IERPTab_Util.PreencheBE():TSBBEUtilizador;
Begin
  Result  := TSBBEUtilizador.Create;

  With Result Do
  Begin
    Nome            := edtNome.Text;
    Login           := edtLogin.Text;
    Senha           := edtSenha.Text;
    Grupo           := epGrpUtilizador.IDG_Chave;
    DataExpiracao   := filtraMaskData(edtDataExpiracao);
    HoraLogin       := edtHoraLogin.Text;
    DataNascimento  := edtDataNascimento.Date;
    ID_Utilizador   := FID_Util;
    If not(edtDataUltimoLogin.Text = '') Then
      DataUltimoLogin := SB.DataHoraStr.StringData(edtDataUltimoLogin.Text);

  End;
End;

Procedure TFrm_IERPTab_Util.MostraBE;
var
  Obj :TSBBEUtilizador;
Begin
  FID_Utilizador := ValoresChaves.AtributoValor['vUtil'].AsString;

  Obj := SB.Utilizador.Edita(FID_Utilizador);

  If Assigned(Obj) Then
  Begin
    Try
      edtNome.Text            := Obj.Nome;
      edtLogin.Text           := Obj.Login;
      edtSenha.Text           := Obj.Senha;
      edtDataExpiracao.Date   := Obj.DataExpiracao;
      edtDataUltimoLogin.Text := SB.DataHoraStr.DataString(Obj.DataUltimoLogin);
      edtHoraLogin.Text       := Obj.HoraLogin;
      edtDataNascimento.Date  := Obj.DataNascimento;


      If Obj.Grupo <> '' Then
      Begin
        epGrpUtilizador.IDG_Chave := Obj.Grupo;
        epGrpUtilizador.Text :=  SB.daValorAtributo('GrupoUtilizador', 'ID_GrupoUtilizador', Obj.Grupo, 'Descricao').AsString;
      End;



    Finally
      Obj.Free;
    End;
  End
  Else raise SB.ErroNormal(819,'F_Uti_M1','MostraBE','O registo não existe. Foi removido por outro posto.');


End;

Procedure TFrm_IERPTab_Util.CfInserir;
var
  strErros :String;
  Obj :TSBBEUtilizador;
Begin
  ActiveControl := FindNextControl(ActiveControl,True,True,False);
  Obj := PreencheBE;

  If Assigned(Obj) Then
  Begin
    Try
      SB.SBBD.IniciaTransacao;
      Try
        SB.Utilizador.Actualiza(Obj, strErros);
        SB.SBBD.TerminaTransacao;
      Except
        On E :Exception Do
        Begin
          SB.SBBD.DesfazTransacao;
          Raise EErroDetalhe.Create('FrmBSPTab_Util', 'Inserir', SB.Idioma.daTraducao(603,'Validação'), strErros);
        End;
      End;
    Finally
      Obj.Free;
    End
  End;
End;


Procedure TFrm_IERPTab_Util.CfAlterar;
var
  strErros :String;
  Obj :TSBBEUtilizador;
Begin
   ActiveControl := FindNextControl(ActiveControl,True,True,False);
  Obj := PreencheBE;

  If Assigned(Obj) Then
  Begin
    Try
      SB.SBBD.IniciaTransacao;
      Try
        Obj.EmModoEdicao := True;
        SB.Utilizador.Actualiza(Obj, strErros);
        SB.SBBD.TerminaTransacao;
      Except
        On E :Exception Do
        Begin
          SB.SBBD.DesfazTransacao;
          raise EErroDetalhe.Create('FrmBSPTab_Util','Alterar',SB.Idioma.daTraducao(603,'Validação'),strErros);
        End;
      End;
    Finally
      Obj.Free;
    End
  End;
End;


Procedure TFrm_IERPTab_Util.CfAnular;
var
  ID_Utilizador,
  Mensg :String;
Begin
  ID_Utilizador := ValoresChaves.AtributoValor['vUtil'].AsString;
  SB.Utilizador.RemoveGeral(ID_Utilizador);
End;

Procedure TFrm_IERPTab_Util.Limpa;
Begin
  FID_Utilizador:= '';
  LimpaEdits(Self);
End;

Procedure TFrm_IERPTab_Util.LimpaEdits(pControlo :TWinControl);
var
  Posicao :Longint;
Begin
  For Posicao := 0 To (pControlo.ComponentCount - 1) Do
  Begin
    If (Self.Components[Posicao] Is TCustomEdit) Then
      TCustomEdit(pControlo.Components[Posicao]).Clear;
  End;
End;

procedure TFrm_IERPTab_Util.FAntesAbrir(Sender: TObject);
begin
  Self.Width := 572;
  Self.Height := 281;
end;





procedure TFrm_IERPTab_Util.epGrpUtilizadorBtListaClick(Sender: TObject);
begin
  inherited;
  Listas.AbrirSQL('ListaGrupoUtilizador','',SeleccionaGrupoUtilizador,antesabrirLista);
end;


procedure TFrm_IERPTab_Util.SeleccionaGrupoUtilizador(Sender: TObject);
var
  Obj :TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
    epGrpUtilizador.IDg_Chave:=Obj.ChaveStr;
    epGrpUtilizador.Text := Obj.ValorDescricao;

  Finally
    Obj.Free;
  End;
End;
procedure TFrm_IERPTab_Util.FormCreate(Sender: TObject);
begin
  inherited;
  Self.OnAntesAbrir := FAntesAbrir;
end;

Procedure TFrm_IERPTab_Util.AntesAbrirLista(Sender :TObject;var pAbreLista:boolean);
var
     FsbLista:TSBBETabelaDados;
    i:Integer;
    enc:boolean;
    Linha:integer;
Begin
    FsbLista:= TSBBETabelaDados(Sender);
    If FsbLista.NumLinhas=1 then
    Begin
        pAbreLista := False;
        epGrpUtilizador.ID_Chave:=FsbLista.daValor('ID_GrupoUtilizador').asinteger;
        epGrpUtilizador.Text := FsbLista.daValor('Descricao').AsString;
    end;
end;

end.


