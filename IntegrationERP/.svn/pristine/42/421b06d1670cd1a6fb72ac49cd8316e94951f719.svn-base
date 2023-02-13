unit ERP_FRMConfGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,sbcontrolos,sbbotoes, StdCtrls, Mask, AdvSpin, AdvGroupBox,
  ExtCtrls, AdvPanel, AdvToolBar, AdvOfficeButtons,sbbetabeladados,inifiles;

type
  TFRMERP_ConfGeral = class(TForm)
    AdvDockPanel2: TAdvDockPanel;
    sbPanelLateral: TAdvToolBar;
    btConfirmar: TAdvToolBarButton;
    btCancelar: TAdvToolBarButton;
    AdvPanel1: TAdvPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    spinreinicioHoras: TAdvSpinEdit;
    spintemporizador: TAdvSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbexportacaoautomatica: TAdvOfficeCheckBox;
    AdvGroupBox2: TAdvGroupBox;
    edHoraInicio: TAdvSpinEdit;
    lbsbHoraInicio: TLabel;
    lbsbHoraFim: TLabel;
    edHoraFim: TAdvSpinEdit;
    cbIntegracaoEntreHoras: TAdvOfficeCheckBox;
    gbmodulo: TAdvOfficeRadioGroup;
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GravaParametrosGerais;
    procedure MostraParametrosGerais;
    procedure GravaConfigExpAutomatica;
    
  public
    { Public declarations }
    Procedure AbreFormulario;
  end;

var
  FRMERP_ConfGeral: TFRMERP_ConfGeral;

implementation
 uses iERPOglobais,FNTUTILGrelha, SBBSSistemaBase, SBBSUtilSQL,IERPFrmPrincipal,
  SBBaseDados;
{$R *.dfm}
Procedure TFRMERP_ConfGeral.AbreFormulario;
begin
  FormataFormPorDefeito(self);
  FormataBotoes(self);
  showmodal;
end;

procedure TFRMERP_ConfGeral.btCancelarClick(Sender: TObject);
begin
 self.close;
end;

procedure TFRMERP_ConfGeral.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFRMERP_ConfGeral.GravaParametrosGerais;
var strsql:string;
begin
  strsql:=' update ErpParametros '
 +' set temporizadorProcessamento='+inttostr(spintemporizador.Value)
 +',IntervaloHoraParaReinicio='+inttostr(spinreinicioHoras.Value)
  +' ,exportacaoautomatica='+sb.UtilSQL.BoolToSQLStr(cbexportacaoautomatica.Checked)
  +' ,IntegracaoentreHoras='+sb.UtilSQL.BoolToSQLStr(cbIntegracaoEntreHoras.Checked)
  +', ModuloPrimavera='+Inttostr(gbmodulo.itemIndex);
 If   cbIntegracaoEntreHoras.Checked= true then
 begin
   strsql:=strsql+', HoraInicio='+ sb.UtilSQL.DateTimeToSQLDataHora(edHoraInicio.TimeValue);
   strsql:=strsql+', HoraFim='+ sb.UtilSQL.DateTimeToSQLDataHora(edHorafim.timevalue);
 end;

  sb.SBBD.Executa(strsql);
end;

procedure TFRMERP_ConfGeral.MostraParametrosGerais;
var
 strsql:string;
 Lista:Tsbbetabeladados;
begin                                         
  strsql:=' select * from  ErpParametros ';
  Lista:=   sb.SBBD.AbrirLV(strsql);
  Try
   spintemporizador.Value:= Lista.Davalor('temporizadorProcessamento').asinteger;
   spinreinicioHoras.Value:= Lista.Davalor('IntervaloHoraParaReinicio').asinteger;
   cbexportacaoautomatica.Checked:= Lista.Davalor('exportacaoautomatica').asboolean;
   cbIntegracaoEntreHoras.Checked:= Lista.Davalor('IntegracaoentreHoras').asboolean;
   edHoraInicio.timevALUE:= Lista.Davalor('HoraInicio').asdatetime;
   edHorafim.timevalue:= Lista.Davalor('HoraFim').asdatetime;
   gbmodulo.itemIndex:=Lista.Davalor('ModuloPrimavera').asinteger;

  Finally
   freeandnil(Lista);
  end;

end;


procedure TFRMERP_ConfGeral.btConfirmarClick(Sender: TObject);
begin
 GravaParametrosGerais;
 GravaConfigExpAutomatica;
 self.close;
end;

procedure TFRMERP_ConfGeral.FormCreate(Sender: TObject);
begin
MostraParametrosGerais;
end;

procedure TFRMERP_ConfGeral.GravaConfigExpAutomatica;
var
    strErros :String;
    ConfigIniR : TIniFile;
Begin
  ConfigIniR := TIniFile.Create(SB.Aplicacao.Dados.PathAplicacao+'Config.ini');
  If cbexportacaoautomatica.checked=true then
    ConfigIniR.WriteString('Config', 'UtilizadorAutomatico', '1')
  else
      ConfigIniR.WriteString('Config', 'UtilizadorAutomatico', '0');
End;

end.
