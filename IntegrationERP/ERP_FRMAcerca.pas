unit ERP_FRMAcerca;

interface


uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,SBBSSistemaBase, SBControlos, AdvGlowButton,
  AdvGroupBox, AdvReflectionLabel, AdvReflectionImage, Shader, rtflabel;
type
  TFRMERPAcerca = class(TForm)
    Imagem: TAdvReflectionImage;
    gbsbBaseDados: TAdvGroupBox;
    lbsbNomeBD: TLabel;
    lbsbVersaoActual: TLabel;
    lbsbVersaoAconselhada: TLabel;
    lbBaseDados: TLabel;
    lbVActual: TLabel;
    lbAconselhada: TLabel;
    AdvGlowButton1: TAdvGlowButton;
    AdvGroupBox1: TAdvGroupBox;
    lbsbLicenca: TLabel;
    lbsbVersaoAp: TLabel;
    lbVersao: TLabel;
    lbLicenca: TLabel;
    AdvGlowButton3: TAdvGlowButton;
    procedure FormShow(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure AdvGlowButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
       Aberto: Boolean;


    Procedure CarregaImagemFundo;
  public
    { Public declarations }
  end;

var
  FRMERPAcerca: TFRMERPAcerca;

implementation

uses ERPOglobais, SBBEAplicacao;
{$R *.dfm}

Procedure TFRMERPAcerca.CarregaImagemFundo;
Var
  CaminhoImagem: AnsiString;
Begin
  CaminhoImagem := SB.Aplicacao.Dados.PathImagens + 'Img_Geral.png';

  If FileExists(CaminhoImagem) Then
    Imagem.Picture.LoadFromFile(CaminhoImagem);

End;
procedure TFRMERPAcerca.FormShow(Sender: TObject);
begin
 Aberto := True;
  self.Height := 200;

  CarregaImagemFundo;

  lbVersao.Caption := SB.Aplicacao.Versao;

  self.Caption := SB.Aplicacao.NomeAplicacao;

  lbVActual.Caption :=SB.Aplicacao.VersaoBD;
  lbAconselhada.Caption := SB.Aplicacao.VersaoBD;
  lbBaseDados.Caption := SB.SBBD.NomeBaseDados;
  lbLicenca.Width:=286;
  If Assigned(SB.Aplicacao.Licenca) Then
    lbLicenca.Caption := SB.Aplicacao.Licenca.Nome
  Else
    lbLicenca.Caption := SB.Idioma.DaTraducao(4455, 'Licença Demonstração');

   FormataFormPorDefeito(Self);
end;

procedure TFRMERPAcerca.AdvGlowButton1Click(Sender: TObject);
begin
  if Aberto Then
    self.Height := 254
  Else
    self.Height := 200;

  AdvGroupBox1.Visible := Aberto;

  Aberto := not Aberto;
end;

procedure TFRMERPAcerca.AdvGlowButton3Click(Sender: TObject);
begin
  self.close;
end;

procedure TFRMERPAcerca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

end.
