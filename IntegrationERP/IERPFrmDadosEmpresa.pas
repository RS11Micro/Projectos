unit IERPFrmDadosEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvToolBar, StdCtrls, AdvGroupBox, SBEditProcura, Mask, AdvSpin,
  AdvOfficePager,SBBEConsTipos,ERPBEEmpresaSoftware;

type
  TFrmIERPDadosEmpresa = class(TForm)
    AdvOfficePager1: TAdvOfficePager;
    tssbGeral: TAdvOfficePage;
    lbsbNomeEstancia: TLabel;
    LbsbMorada: TLabel;
    lbsbNContribuinte: TLabel;
    lbsbCapSoc: TLabel;
    lbsbMatricula: TLabel;
    lbsbCPLoc: TLabel;
    LbsbTlf: TLabel;
    LbsbFax: TLabel;
    LbsbTlm: TLabel;
    EdMorada: TEdit;
    EdContribuinte: TEdit;
    EdTelefone: TEdit;
    EdFax: TEdit;
    EdTelemovel: TEdit;
    EdMatricula: TEdit;
    EdLocalidade: TEdit;
    EdRua: TEdit;
    EdCodPostal: TEdit;
    EDDescricao: TEdit;
    edCapitalSocial: TAdvSpinEdit;
    gbsbCaminhoLicenca: TAdvGroupBox;
    edCaminhoLicenca: TEdit;
    gbsbCaminhoAplicacoes: TAdvGroupBox;
    edCaminhoAplicacoes: TEdit;
    tssbproprietario: TAdvOfficePage;
    lbsbNProp: TLabel;
    lbsbCPLoc1: TLabel;
    LbsbMorada1: TLabel;
    lbsbDist1: TLabel;
    LbsbTlf1: TLabel;
    LbsbFax1: TLabel;
    LbsbTlm1: TLabel;
    epDistritoProp: TSBEditProcura;
    EDNomeProp: TEdit;
    EdMoradaProp: TEdit;
    EDCodPostalProp: TEdit;
    EdRuaProp: TEdit;
    EdLocalidadeProp: TEdit;
    EdTelefoneProp: TEdit;
    EdfaxProp: TEdit;
    EdTelemovelProp: TEdit;
    AdvDockPanel2: TAdvDockPanel;
    sbPanelLateral: TAdvToolBar;
    btConfirmar: TAdvToolBarButton;
    btsair: TAdvToolBarButton;
    procedure FormCreate(Sender: TObject);
    procedure btsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btConfirmarClick(Sender: TObject);
  private
    { Private declarations }

    FID_Empresa:integer;
        FTipoOperacao: TTipoOperacao;
  public
    { Public declarations }
  Procedure CfInserir;
  Procedure CfAlterar;
  Procedure CfAnular;
  Function  PreencheBE: TERPBEEmpresaSoftware;
  Procedure Limpa;
  Procedure MostraBE;
  procedure FAntesAbrir(Sender: TObject);
  property ID_Empresa: Integer read FID_Empresa write FID_Empresa;
  Procedure AbreFormulario;
  Procedure Sair;
  end;

var
  FrmIERPDadosEmpresa: TFrmIERPDadosEmpresa;

implementation


Uses SBLista, IERPOGlobais,  SBbotoes,SBControlos, SBBEEntidade,  SBBEChaves,
  SBBSEntidade;

{$R *.dfm}


Procedure TFrmIERPDadosEmpresa.Sair;
Begin
 inherited
End;


Procedure TFrmIERPDadosEmpresa.MostraBE;
Var
  ObjBEEmpresaSoftware: TERPBEEmpresaSoftware;
Begin
  ObjBEEmpresaSoftware:= MotorERP.EmpresaSoftware.Edita(FID_Empresa);

  With ObjBEEmpresaSoftware Do
  Begin
    FID_Empresa := ID_Empresa;

    EDDescricao.Text:=Nome;
    EDMorada.Text:=Morada;
    EDCodPostal.Text:=CodigoPostal;
    edrua.Text:=Rua;
    EDLocalidade.Text:=Localidade;

    EDContribuinte.text:=NIPC;
    edCapitalSocial.FloatValue:=CapitalSocial;
    edTelefone.Text:=Telefone;
    EDfax.Text:=Fax;
    EDTelemovel.Text:=Telemovel;
    EDMatricula.Text:=MatriculaCRC;
    EdTelemovelProp.Text:=TelemovelProprietario;
    EDNomeProp.Text:=NomeProprietario;
    EDMoradaProp.Text:=MoradaProprietario;

    EDCodPostalProp.Text:=CodigoPostalProprietario;
    EdRuaProp.Text:=RuaProprietario;
    EdLocalidadeProp.Text:=LocalidadeProprietario;
    EdTelefoneProp.Text:=TelefoneProprietario;
    EdfaxProp.text:=FaxProprietario;
    edCaminhoLicenca.text:=PathLicenca;
    edCaminhoAplicacoes.text:=PathAplicacoes;


  End;

  ObjBEEmpresaSoftware.Free;
End;

Function TFrmIERPDadosEmpresa.PreencheBE: TERPBEEmpresaSoftware;
Begin
  Result := TERPBEEmpresaSoftware.Create;
  With Result Do
  Begin
    ID_Empresa := FID_Empresa;
    Nome:=EDDescricao.Text;
    Morada:=EDMorada.text;
    CodigoPostal:=EDCodPostal.Text;
    Rua:=edrua.Text;
    Localidade:=EDLocalidade.Text;

    NIPC:=EDContribuinte.text;
    CapitalSocial:=edCapitalSocial.FloatValue;
    Telefone:=edTelefone.Text;
    Fax:=EDfax.Text;
    Telemovel:=EDTelemovel.Text;
    MatriculaCRC:=EDMatricula.Text;

    TelemovelProprietario:=EdTelemovelProp.Text;
    NomeProprietario:=EDNomeProp.Text;
    MoradaProprietario:=EdMoradaProp.Text;
    ID_DistritoProprietario:=epDistritoProp.ID_Chave;
    CodigoPostalProprietario:=EDCodPostalProp.Text;
    RuaProprietario:=EdRuaProp.Text;
    LocalidadeProprietario:=EdLocalidadeProp.Text;
    TelefoneProprietario:=EdTelefoneProp.Text;
    FaxProprietario:=EdfaxProp.text;
    PathLicenca:=edCaminhoLicenca.text;
    PathAplicacoes:=edCaminhoAplicacoes.text;

  End;
End;

Procedure TFrmIERPDadosEmpresa.CfInserir;
Var
  strErros: String;
  Obj: TERPBEEmpresaSoftware;
Begin
  Obj := PreencheBE;
  Obj.EmModoEdicao := False;
  MotorERP.EmpresaSoftware.Actualiza(Obj, strErros);
  Obj.Free;
End;

Procedure TFrmIERPDadosEmpresa.CfAlterar;
Var
  strErros: String;
  Obj: TERPBEEmpresaSoftware;
Begin
  Obj := PreencheBE;
  Obj.EmModoEdicao := True;
  MotorERP.EmpresaSoftware.Actualiza(Obj, strErros);
  Obj.Free;
End;

Procedure TFrmIERPDadosEmpresa.CfAnular;
Begin
  MotorERP.EmpresaSoftware.Remove(FID_Empresa);
End;

Procedure TFrmIERPDadosEmpresa.Limpa;
Begin
  FID_Empresa := 0;
End;



procedure TFrmIERPDadosEmpresa.FAntesAbrir(Sender: TObject);
begin


  
end;



Procedure TFrmIERPDadosEmpresa.AbreFormulario;
Begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  caption:=sb.idioma.datraducao(567,'Dados da Empresa');
  edCapitalSocial.Left:=EdContribuinte.Left;
  FID_Empresa:= MotorERP.EmpresaSoftware.DaID_Empresa;
  If FID_Empresa>0 then
  begin
   FTipoOperacao:=toAlterar;
   MostraBe ;
  end
  Else
   FTipoOperacao:=toInserir;
  self.show;
End;







procedure TFrmIERPDadosEmpresa.FormCreate(Sender: TObject);
begin
  Self.Width := 643;
  Self.Height := 600;


end;

procedure TFrmIERPDadosEmpresa.btsairClick(Sender: TObject);
begin
self.close;
end;

procedure TFrmIERPDadosEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFrmIERPDadosEmpresa.btConfirmarClick(Sender: TObject);
begin
 Screen.cursor:=crhourglass;
 try
     If FTipoOperacao=toinserir then
       cfInserir
     Else
      CfAlterar;
  Finally
   Screen.cursor:=crDefault;
  end;

end;

End.


