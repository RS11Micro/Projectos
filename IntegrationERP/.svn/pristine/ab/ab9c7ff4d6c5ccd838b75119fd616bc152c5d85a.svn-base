unit IERPFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvOfficeStatusBar,sbbeconstipos,dateutils,sbcontrolos,SBdmRecursos,
  AdvShapeButton, AdvToolBar, AdvGlowButton,IERPDMRecursos, pngimage,
  ExtCtrls, StdCtrls, AdvSmoothMessageDialog,ERPLogOperacoes,ERPBEEMPRESAINTERFACE,inifiles,ERP_FRMProgresso,ERPIntegracaoAutomatica,
  AdvPanel, AdvPicture, ActnList, AdvGroupBox,ERP_FrmGerarContasCBLClientes,IERP_FrmPmsPrimveraCBL,
  ERP_FRMExportacaoCBLCompras,ERPPrimaveraCBLCompras, System.Actions;

type
  TFrmIERPPrincipal = class(TForm)
    imgFundo: TImage;
    stBar: TAdvOfficeStatusBar;
    MenuOpcoes: TAdvToolBarPager;
    tssbConfiguracoes: TAdvPage;
    AdvToolBar1: TAdvToolBar;
    Btutilizadores: TAdvGlowButton;
    TbExportacaovendasPMS: TAdvPage;
    TbDocsExportados: TAdvPage;
    AdvGlowButton4: TAdvGlowButton;
    AdvQuickAccessToolBar1: TAdvQuickAccessToolBar;
    AdvGlowButton105: TAdvGlowButton;
    AdvGlowButton106: TAdvGlowButton;
    bAlterarUtilizador: TAdvGlowButton;
    BtMaxjanela: TAdvGlowButton;
    BtMinimizeJan: TAdvGlowButton;
    AdvShapeButton2: TAdvShapeButton;
    btinterfaces: TAdvGlowButton;
    AdvToolBar2: TAdvToolBar;
    BtExpVendas: TAdvGlowButton;
    AdvToolBar3: TAdvToolBar;
    AdvGlowButton18: TAdvGlowButton;
    AdvGlowButton19: TAdvGlowButton;
    AdvGlowButton20: TAdvGlowButton;
    AdvGlowButton21: TAdvGlowButton;
    tbexportacaoVendasFnt: TAdvPage;
    AdvToolBar4: TAdvToolBar;
    AdvGlowButton9: TAdvGlowButton;
    AdvGlowButton10: TAdvGlowButton;
    AdvGlowButton12: TAdvGlowButton;
    Btarmazens: TAdvGlowButton;
    AdvToolBar5: TAdvToolBar;
    BTHoteisContaSaco: TAdvGlowButton;
    AdvGlowButton22: TAdvGlowButton;
    AdvToolBar6: TAdvToolBar;
    AdvGlowButton23: TAdvGlowButton;
    AdvGlowButton14: TAdvGlowButton;
    AdvGlowButton13: TAdvGlowButton;
    MessageDialogQueston: TAdvSmoothMessageDialog;
    AdvGlowButton24: TAdvGlowButton;
    AdvToolBar7: TAdvToolBar;
    BtExpCompras: TAdvGlowButton;
    btexportaInventarios: TAdvGlowButton;
    tbexpAutomatica: TAdvPage;
    AdvGlowButton25: TAdvGlowButton;
    btAPIIntegrador: TAdvGlowButton;
    AdvGlowButton26: TAdvGlowButton;
    AdvGlowButton27: TAdvGlowButton;
    TprocessaVendas: TTimer;
    ActionList1: TActionList;
    acReiniciar: TAction;
    painelIntegracaoAutomatica: TAdvGroupBox;
    ImageTransf: TAdvPicture;
    BtParar: TAdvGlowButton;
    tsbbExportacaoPMSCBL: TAdvPage;
    TbexportacaoPmsCbl: TAdvPage;
    AdvToolBar9: TAdvToolBar;
    AdvGlowButton32: TAdvGlowButton;
    AdvGlowButton35: TAdvGlowButton;
    AdvGlowButton33: TAdvGlowButton;
    tssbExportacaoCBLFNTvendas: TAdvPage;
    AdvToolBar10: TAdvToolBar;
    AdvGlowButton34: TAdvGlowButton;
    AdvToolBar8: TAdvToolBar;
    AdvGlowButton15: TAdvGlowButton;
    AdvToolBar11: TAdvToolBar;
    Bt3: TAdvGlowButton;
    GRP1: TAdvToolBar;
    Bt2: TAdvGlowButton;
    Bt1: TAdvGlowButton;
    TbListasDocsExportadosCBL: TAdvPage;
    AdvGlowButton36: TAdvGlowButton;
    AdvGlowButton37: TAdvGlowButton;
    btcontaemail: TAdvGlowButton;
    AdvGlowButton39: TAdvGlowButton;
    AdvGlowButton40: TAdvGlowButton;
    AdvGlowButton17: TAdvGlowButton;
    BtReiniciarBD: TAdvGlowButton;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure BtMaxjanelaClick(Sender: TObject);
    procedure BtMinimizeJanClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtReiniciarBDClick(Sender: TObject);
    procedure atualizaContacblProdutosProtel;
    procedure AdvGlowButton24Click(Sender: TObject);
    procedure TprocessaVendasTimer(Sender: TObject);
    procedure BtPararClick(Sender: TObject);
    procedure acReiniciarExecute(Sender: TObject);
    procedure AdvGlowButton15Click(Sender: TObject);
    procedure BtVendasExpCBLFNTClick(Sender: TObject);
    procedure BtComprasExpCBLCMPClick(Sender: TObject);

    procedure AdvGlowButton34Click(Sender: TObject);
  private
    { Private declarations }
    FMenuExpandido: Boolean;
    FAbriu: Boolean;
    FConfirmaSair: Boolean;
    //dados conta email para reportar os erros
    FPOP3ServerConta:string;
    FPOP3ServerNameConta:string;
    FPOP3FromUser:string;
    FPOP3FromMail:string;
    FPOP3EMailTO:string;
    FSMTPAuthenticationType:integer;
    FSMTPUSERAutenticacao:string;
    FSMTPServerPassword:string;

    FIntegracaoentreHoras:Boolean;
    FHoraInicioIntAut,
    FHoraFimIntAut:tdatetime;
    FperguntaFecha:boolean;

    procedure PreencheDadosProcAutomatico;

    procedure GestaoMenu(pativa:boolean);

    Function MensagemQuestao(pMensagem:string):boolean;
    Procedure LimparTabelasExportacao();
    procedure ReadConfigurationMail;
    Procedure RegistaInicioAutoAplicacao;
    Procedure GestaodeReinicioAutoAplicacao(pintervaloHoras:integer);
    Procedure FormataBotoesExpCBLFNT;
    Procedure FormataBotoesExpCBLCMPFNT;
  public
    { Public declarations }
      FProcessamentoAutomatico:Boolean;
      FIntervalotemporizador:Integer;
      FIntervaloHoraParaReinicio :Integer;
      FPararExportacaoAutomatica:Boolean;

      FInterfaceSyscontrollerOK,
      FInterfacePMSOK,
      FInterfaceCBLPMSOK,
      FInterfaceCMPOK:Boolean;
      FMODULOEXPORTACAOCBL:Boolean;
       FEMailHotel:string;

       Procedure FormaFormInterfaces();
       procedure ColocaDadosNaStatusBar(Nome,STGutil,DataTrab:string);
       Function QuestaoConfirmaSairAplicacao: Boolean;
       property ConfirmaSair: boolean read FConfirmaSair write FConfirmaSair;
       property Abriu: boolean read FAbriu write FAbriu;


       property POP3ServerConta:string read FPOP3ServerConta write FPOP3ServerConta;
       property POP3ServerNameConta:string read FPOP3ServerNameConta write FPOP3ServerNameConta;
       property POP3FromUser:string read FPOP3FromUser write FPOP3FromUser;
       property POP3FromMail:string read FPOP3FromMail write FPOP3FromMail;
       property POP3EMailTO:string read FPOP3EMailTO write FPOP3EMailTO;
       property SMTPAuthenticationType:integer read FSMTPAuthenticationType write FSMTPAuthenticationType;
       property SMTPUSERAutenticacao:string read FSMTPUSERAutenticacao write FSMTPUSERAutenticacao;
       property SMTPServerPassword:string read FSMTPServerPassword write FSMTPServerPassword;
       property EMailHotel:string read FEMailHotel write FEMailHotel;






  end;

var
  FrmIERPPrincipal: TFrmIERPPrincipal;

implementation
uses Ierpoglobais,strutils,math, SBBSSistemaBase, SBBEUtilizador,ERPOperInterfaceFNTCMP,sbbetabeladados,
  SBBaseDados,FntFrmIntPrimaveraCBL,ERPOperInterfaceFNT;

{$R *.dfm}



procedure TFrmIERPPrincipal.PreencheDadosProcAutomatico;
var
 strsql:string;
 Lista:Tsbbetabeladados;
begin
  FMODULOEXPORTACAOCBL:=false;
  strsql:=' select * from  ErpParametros ';
  Lista:=   sb.SBBD.AbrirLV(strsql);
  Try
  If Lista.Davalor('ModuloPrimavera').asinteger=1 then
  begin
     FMODULOEXPORTACAOCBL:=true;
  end;

  FIntervalotemporizador:= Lista.Davalor('temporizadorProcessamento').asinteger;
  ERPIntegracaoAutomatica.FMintemporizador:=FIntervalotemporizador;
  FIntervaloHoraParaReinicio:= Lista.Davalor('IntervaloHoraParaReinicio').asinteger;
  FProcessamentoAutomatico:= Lista.Davalor('exportacaoautomatica').asboolean;
  FIntegracaoentreHoras:= Lista.Davalor('IntegracaoentreHoras').asboolean;
  FHoraInicioIntAut:= Lista.Davalor('HoraInicio').asDatetime;
  FHoraFimIntAut:= Lista.Davalor('HoraFim').asDatetime;
  Finally
   freeandnil(Lista);
  end;

end;



procedure TFrmIERPPrincipal.ReadConfigurationMail;
var
  MailIni,MailIni1: TiniFile;
  passencriptada:string;
  strSMTPAuthenticationTyp:string;
begin
  MailIni := TiniFile.Create(ExtractFilePath(ParamStr(0)) + 'Mail.ini');
  with MailIni do
  begin


    FPOP3ServerConta:= ReadString('Pop3', 'ServerConta', 'ServerConta');
    FPOP3ServerNameConta:= ReadString('Pop3', 'ServerNameConta', 'ServerNameConta');
    FPOP3FromUser:= ReadString('Pop3', 'FromUser', 'FromUser');
    FPOP3FromMail:= ReadString('Pop3', 'FromMail', 'FromMail');
    FPOP3EMailTO:= ReadString('Pop3', 'EMailTO', 'EMailTO');
    FEMailHotel:= ReadString('Pop3', 'EMailHotel', 'EMailHotel');
    strSMTPAuthenticationTyp:=Readstring('Smtp', 'SMTPAuthenticationType', 'SMTPAuthenticationType');
    If strSMTPAuthenticationTyp<>'' then
    begin
     Try
            FSMTPAuthenticationType:= strtoint(strSMTPAuthenticationTyp);
     except
     end;
    end;
    FSMTPUSERAutenticacao:= ReadString('Smtp', 'USERAutenticacao', 'USERAutenticacao');
    FSMTPServerPassword:= ReadString('Smtp', 'ServerPassword', 'ServerPassword');
    passencriptada:=ReadString('Pop3', 'ServerPassword', 'your_password');

  end;
  MailIni.Free;

end;


Function TFrmIERPPrincipal.MensagemQuestao(pMensagem:string):boolean;
begin
    MessageDialogQueston.HTMLText.Text:=pMensagem;
    Result:=MessageDialogQueston.Execute;
end;

Procedure TFrmIERPPrincipal.LimparTabelasExportacao();
var
   strmensagem:string;
begin

    strmensagem:='Esta operação limpa os dados exportados para as Tabelas de Exportação:<BR>'
     +'<BR>-> Exportação de VENDAS PMS <BR>'
     +'<BR>-> Exportação de Adiantamentos PMS <BR>'
     +' <BR>-> Exportação de Vendas SysPos/Syscontroller <BR>'
     +' <BR>-> Exportação de Compras  SysPos/Syscontroller<BR>'
     +' <BR>   - Log de exportação Syscontroller e remoção da a marca de movimento exportado<BR>'
     +' <BR>-> Exportação de Inventários  SysPos/Syscontroller<BR>'
     +' <BR>-> Os contadores são inicializados!<BR>'

     +'<P align="center">'+'Tem a certeza que deseja continuar'+'?</P><BR>';
    If MensagemQuestao(strmensagem) then
    begin
       sb.sbbd.Executa('Delete from ERP_Pagamentos');
       sb.sbbd.Executa('Delete from ERP_Detalhes');
       sb.sbbd.Executa('Delete from ERP_Cab');
       sb.sbbd.Executa('Delete from ERP_compPagamentos');
       sb.sbbd.Executa('Delete from ERP_compDetalhes');
       sb.sbbd.Executa('Delete from ERP_compCab');
       sb.sbbd.Executa('Delete from ERP_Adiantamentos');

       sb.sbbd.Executa('Delete from ERP_CBLLinhas');       
       sb.sbbd.Executa('Delete from ERP_CBLCabec');


       sb.sbbd.Executa('Delete from ERP_CBLCMPlinhas');
       sb.sbbd.Executa('Delete from ERP_CBLCMPCabec');





       sb.sbbd.Executa('delete from Erp_LinhasInventario');
       sb.sbbd.Executa('delete from ERP_CabInventario');

       sb.sbbd.Executa('delete from LOGALTERP_CBLCMPLinhas');
       sb.sbbd.Executa('delete from LOGALTERP_CBLCMPCabec');
       sb.sbbd.Executa('delete from LOGERP_CompCab');
       sb.sbbd.Executa('delete from LOGERP_CompDetalhes');
       sb.sbbd.Executa('delete from LOGERP_CompPagamentos');





       sb.sbbd.Executa('update contadores set id_corrente=0 where Nome_tabela=''ERP_CBLCOMPCAB''');
       sb.sbbd.Executa('update contadores set id_corrente=0 where Nome_tabela=''ERP_CBLCAB''');

       sb.sbbd.Executa('update contadores set id_corrente=0 where Nome_tabela=''ERP_CAB''');
       sb.sbbd.Executa('update contadores set id_corrente=0 where Nome_tabela=''ERP_CompCAB''');
       sb.sbbd.Executa('update contadores set id_corrente=0 where Nome_tabela=''ERP_CabInventario''');
       sb.sbbd.Executa('update ERP_EMPRESAINTERFACE set DATAInicioExportacao=null where id_interface=2');       
       sb.sbbd.Executa('update ERP_EMPRESAINTERFACE set DATAUltimaExportacao=null');


       ERPLogOperacoes.RegistaLogOperacao('Operação: Limpar Tabelas de Exportação');
       ERPPrimaveraCBLCompras.RemoveMarcaExportacaoFNT;
       LIMPAEXportacoes;
     end;
end;



Procedure TFrmIERPPrincipal.FormaFormInterfaces();
var
  ID_ERP_VENDASSYSCONTROLLER,ID_ERP_ComprasSYSCONTROLLER,
  ID_ERP_VENDASPMS:Integer;

begin
   Bt1.visible:=false;
   Bt2.visible:=false;
   ID_ERP_VENDASSYSCONTROLLER:=0;
   ID_ERP_VENDASPMS:=0;
   ID_ERP_ComprasSYSCONTROLLER:=0;
 //Controlo Exportação Gestão
   ID_ERP_VENDASPMS:=MotorERP.ERPInterface.DAID_InterfaceActivo('ERP_VENDASPROTEL');
   TbExportacaovendasPMS.TabVisible:= (ID_ERP_VENDASPMS>0);
   TbExportacaovendasPMS.tag:= ID_ERP_VENDASPMS;


   ID_ERP_VENDASSYSCONTROLLER:=MotorERP.ERPInterface.DAID_InterfaceActivo('ERP_VENDASSYSCONTROLLER');
   ID_ERP_ComprasSYSCONTROLLER:=MotorERP.ERPInterface.DAID_InterfaceActivo('ERP_ComprasSYSCONTROLLER');

   //este separador cotem opção d eexportacao de VEndas/compras e inventarios do syscontroller
   tbexportacaoVendasFnt.TabVisible:=((ID_ERP_VENDASSYSCONTROLLER>0)or (ID_ERP_ComprasSYSCONTROLLER>0));
   tbexportacaoVendasFnt.tag:= ID_ERP_VENDASSYSCONTROLLER;
   TbDocsExportados.TabVisible:=  ((TbExportacaovendasPMS.TabVisible=true) or  (tbexportacaoVendasFnt.TabVisible=true));


 //Controlo Exportação Contabilidade
   tssbExportacaoCBLFNTvendas.TabVisible:=
     ((MotorERP.ERPInterface.ExisteInterfaceActivo('ERP_CBLVENDASFNT'))or
    (MotorERP.ERPInterface.ExisteInterfaceActivo('ERP_CBLCOMPRASFNT'))) ;
   tsbbExportacaoPMSCBL.TabVisible:=tssbExportacaoCBLFNTvendas.TabVisible;
   tsbbExportacaoPMSCBL.TabVisible:=  MotorERP.ERPInterface.ExisteInterfaceActivo('ERP_CBLPROTEL');

   If  tssbExportacaoCBLFNTvendas.TabVisible=true then
   begin
    FormataBotoesExpCBLFNT;
    FormataBotoesExpCBLCMPFNT;
   end;

   If tsbbExportacaoPMSCBL.TabVisible=true then
   begin
    if ((Bt1.visible=false) and  (Bt2.visible=false)) then
    begin
     GRP1.Height:=0;
     GRP1.Width:=0;
    end;
   end;
   TbListasDocsExportadosCBL.TabVisible:= (( tsbbExportacaoPMSCBL.TabVisible=true) or  (tssbExportacaoCBLFNTvendas.TabVisible=true));

end;

Procedure TFrmIERPPrincipal.FormataBotoesExpCBLFNT;
var
SQL:string;
Lista:tsbbetabeladados;
begin
   SQL := ' select ERP_EMPRESAINTERFACE.ID,ERP_EMPRESAINTERFACE.descricao'
    +' from ERP_EMPRESAINTERFACE'
    +' inner join ERP_INTERFACE on '
    +' ERP_INTERFACE.id_interface=ERP_EMPRESAINTERFACE.id_interface'
    +' where  ERP_INTERFACE.NomeInterface=''ERP_CBLVENDASFNT'''
    + ' and ERP_EMPRESAINTERFACE.ativo=1';
   Lista:=sb.SBBD.AbrirLV(SQL);
   Try
     if not Lista.Vazia then
     begin
        Bt1.Tag:=Lista.davalor('id').asinteger;
        Bt1.Caption:=Lista.davalor('descricao').asstring;
        Bt1.Visible:=true;
        Bt1.onClick:=BtVendasExpCBLFNTclick;
        If  Lista.NumLinhas>1 then
        begin
          Lista.seguinte;
          Bt2.Tag:=Lista.davalor('id').asinteger;
          Bt2.Caption:=Lista.davalor('descricao').asstring;
          Bt2.onClick:=BtVendasExpCBLFNTclick;
          Bt2.Visible:=true;
        end;
    end;
   Finally
    lista.Fecha;
    Freeandnil(lista);
   end;
end;


Procedure TFrmIERPPrincipal.FormataBotoesExpCBLCMPFNT;
var
SQL:string;
Lista:tsbbetabeladados;
begin
   SQL := ' select ERP_EMPRESAINTERFACE.ID,ERP_EMPRESAINTERFACE.descricao'
    +' from ERP_EMPRESAINTERFACE'
    +' inner join ERP_INTERFACE on '
    +' ERP_INTERFACE.id_interface=ERP_EMPRESAINTERFACE.id_interface'
    +' where  ERP_INTERFACE.NomeInterface=''ERP_CBLCOMPRASFNT'''
    + ' and ERP_EMPRESAINTERFACE.ativo=1';
   Lista:=sb.SBBD.AbrirLV(SQL);
   Try
     if not Lista.Vazia then
     begin
        Bt3.Tag:=Lista.davalor('id').asinteger;
        Bt3.Caption:=Lista.davalor('descricao').asstring;
        Bt3.Visible:=true;
        Bt3.onClick:=BtComprasExpCBLCMPClick;

    end;
   Finally
    lista.Fecha;
    Freeandnil(lista);
   end;
end;


Function TFrmIERPPrincipal.QuestaoConfirmaSairAplicacao: Boolean;
Begin
  Result := SB.Dialogos.SBConfirmacao(1044,'Deseja abandonar a aplicação?');
End;

procedure TFrmIERPPrincipal.ColocaDadosNaStatusBar(Nome,STGutil,DataTrab:string);
var
StrDiaSemana,
StrMesSemana:string;
dia,ano:integer;
begin
 stBar.Panels[0].Text := Nome;
 stBar.Panels[1].Text := STGutil;
 StrDiaSemana:= SB.DataHoraStr.NomeDiaSemana(DayOfWeek(strtodate(DataTrab)));
 StrMesSemana:= SB.DataHoraStr.NomeMesLongo(monthof(strtodate(DataTrab)));
 dia:=DayOf(strtodate(DataTrab));
 ano:=yearof(strtodate(DataTrab));
 stBar.Panels[2].Text :=StrDiaSemana+', '+inttostr(dia)+' de '+StrMesSemana +' de '+Inttostr(ano);
     BtReiniciarBD.visible:=sb.UtilizadorActual.Login='MICRONET';
// LDATA.caption:= stBar.Panels[2].Text;


end;

procedure TFrmIERPPrincipal.FormCreate(Sender: TObject);
begin

   FMenuExpandido:=true;
   abriu:=false;
   FperguntaFecha:=true;
   FPararExportacaoAutomatica:=false;
   dmSBRecursos:=TdmSBRecursos.Create(self);
   if IERPOGLOBAIS.Abre  then
   begin
     PreencheDadosProcAutomatico;
     RegistaLogOperacao('Entrar no Programa');
     BtReiniciarBD.visible:=sb.UtilizadorActual.Login='MICRONET';
     Abriu:=true;
     FormataFormPorDefeito(self);
     FormaFormInterfaces;
     MenuOpcoes.ActivePageIndex:=0;
     ReadConfigurationMail;
     If SB.Aplicacao.LicencaDemo then
            Self.Caption :=Self.Caption +' V. '+ SB.Aplicacao.Versao+' Aplicação sem licença'
      else
      If assigned(SB.Aplicacao.Licenca) then
          Self.Caption :=Self.Caption +' V. '+ SB.Aplicacao.Versao+' Licenciado a:  '+ SB.Aplicacao.Licenca.Nome
          +' - '+ SB.Aplicacao.Licenca.Localidade
      else
                Self.Caption :=Self.Caption +' V. '+ SB.Aplicacao.Versao+' Aplicação sem licença'
   end
   else
   Abriu:=false;

end;

procedure TFrmIERPPrincipal.BtMaxjanelaClick(Sender: TObject);
begin
  MenuOpcoes.Expand;
end;

procedure TFrmIERPPrincipal.BtMinimizeJanClick(Sender: TObject);
begin
  MenuOpcoes.Collaps;
end;

procedure TFrmIERPPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Abriu:=false;
  IERPOGlobais.Fecha;
  action:=cafree;
end;

procedure TFrmIERPPrincipal.FormResize(Sender: TObject);
begin
      imgFundo.Top := 0;
      imgFundo.Left := 0;
      imgFundo.Height := stBar.Top - IfThen(FMenuExpandido, 146, 53) - 4;
      imgFundo.Width := stBar.Width;

      imgFundo.Refresh;
      imgFundo.Repaint;
      ImageTransf.Refresh;

      self.Refresh;
      self.Repaint;
end;

procedure TFrmIERPPrincipal.FormShow(Sender: TObject);
var
Form:TFRMERPProgresso;
begin
 IF Fabriu=true then
 begin
      atualizaContacblProdutosProtel;
      FMenuExpandido:=false;
      imgFundo.Top := 0;
      imgFundo.Left := 0;
      imgFundo.Height := stBar.Top - IfThen(FMenuExpandido, 146, 53) - 4;
      imgFundo.Width := stBar.Width;

      imgFundo.Refresh;
      imgFundo.Repaint;

      self.Refresh;
      self.Repaint;

      If FProcessamentoAutomatico =true then
      begin
        iF ValidaExportacaoAutomatica THEN
        Begin
          Form := TFRMERPProgresso.Create(Self);
          Form.Caption:='Integration-ERP-Ativação'+SB.Aplicacao.Versao;
          Form.ShowModal;

          if Form.FativaInterface then
          begin
             painelIntegracaoAutomatica.visible:=true;
             MenuOpcoes.visible:=false;
             BtMinimizeJan.visible:=false;
             BtMaxjanela.visible:=false;
             Application.Minimize;
             ImageTransf.Animate:=true ;
             ImageTransf.Refresh;
              RegistaInicioAutoAplicacao;
             DMIERPRecursos.acExportAutomatica.Execute
         end;    
        end
        else
        begin
           painelIntegracaoAutomatica.visible:=false;
           MenuOpcoes.visible:=true;
           BtMinimizeJan.visible:=true;
           BtMaxjanela.visible:=true;
        end;
     end;
  end
  else
  begin
   FperguntaFecha:=false;
   self.close;
  end;
end;

procedure TFrmIERPPrincipal.GestaoMenu(pativa:boolean);
begin
end;


procedure TFrmIERPPrincipal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
if FperguntaFecha then
 canclose:=SB.Dialogos.SBConfirmacao(0,'Deseja abandonar a aplicação?')
else
canclose:=true;
end;

procedure TFrmIERPPrincipal.BtReiniciarBDClick(Sender: TObject);
begin
 screen.cursor:=crhourglass;
 Try
    LimparTabelasExportacao;
 Finally
  screen.cursor:=crdefault;
 end;
end;

procedure TFrmIERPPrincipal.atualizaContacblProdutosProtel;
var strsql:string;
  ProtelObjInterface,
  SysObjInterface:TERPBEEMPRESAINTERFACE;
  DescSchemaPms,
  DescSchemaSys:string;
begin
   ProtelObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
   SysObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');

  if ((assigned(ProtelObjInterface))and(assigned(SysObjInterface))) then
  begin
     If TestaConexaoBDExterna(ProtelObjInterface.BDConexao)
     and  TestaConexaoBDExterna(SysObjInterface.BDConexao) then
     begin
          DescSchemaPms:=ProtelObjInterface.BDSchema;
          If  ProtelObjInterface.Namelinkedserver<>'' then
          begin
           DescSchemaPms:=ProtelObjInterface.Namelinkedserver+'.'+DescSchemaPms;
          end;

          DescSchemaSys:= SysObjInterface.BDSchema;
          If  SysObjInterface.Namelinkedserver<>'' then
          begin
           DescSchemaSys:=SysObjInterface.Namelinkedserver+'.'+DescSchemaSys;
          end;

          strsql :='update artpms set artpms.gvkonto=artsys.ContaCbl  '
          +' from '+DescSchemaPms+'ArticlesPMSSYS as artpms inner join '+DescSchemaSys+'TAB_PRODUTO as artsys'
          +' on  artpms.Id_ProdutoSYS=artsys.vproduto ';
          sb.sbbd.Executa(strsql);

          if assigned(ProtelObjInterface) then
           FreeAndNil(ProtelObjInterface);
          if assigned(SysObjInterface) then
           FreeAndNil(SysObjInterface);
     end
     else
     sb.Dialogos.SBMessage('Não foi possivel conetar com as base de dados do Hotel e Syscontroller')      
   end;
end;

procedure TFrmIERPPrincipal.AdvGlowButton24Click(Sender: TObject);
begin
  //dssadfd
end;

procedure TFrmIERPPrincipal.TprocessaVendasTimer(Sender: TObject);
var
 segue:boolean;
begin


If FPararExportacaoAutomatica then
begin
  BtParar.Click;
  self.WindowState:=wsMaximized;
end
else
begin

  If  FIntervaloHoraParaReinicio>0 then
     GestaodeReinicioAutoAplicacao(FIntervaloHoraParaReinicio);

  self.WindowState:=wsMinimized;
  TprocessaVendas.Interval:=1000 * FMintemporizador;
  TprocessaVendas.Enabled:=false;
  segue:=true;
  If FIntegracaoentreHoras=true then
  begin
   segue:=((time>=FHoraInicioIntAut) and (time<=FHoraFimIntAut));
  end;

  If segue then
  begin
    ImageTransf.Animate:=true ;
    ImageTransf.Refresh;
    ERPIntegracaoAutomatica.ExportacaoAutomatica;
    ImageTransf.Animate:=false ;
    ImageTransf.Refresh;
  end
  else
  begin
    ImageTransf.Animate:=false ;
    ImageTransf.Refresh;

  end;

  TrimAppMemorySize;
  TprocessaVendas.Enabled:=True;
end;
end;

procedure TFrmIERPPrincipal.BtPararClick(Sender: TObject);
begin
   TprocessaVendas.Enabled:=false;
   painelIntegracaoAutomatica.visible:=false;
   ImageTransf.Animate:=false ;
   MenuOpcoes.visible:=true;
   BtMinimizeJan.visible:=true;
   BtMaxjanela.visible:=true;
   ERPLogOperacoes.RegistaLogOperacao('Operação:Paragem manual da Exp.Automática');

end;




 

Procedure TFrmIERPPrincipal.GestaodeReinicioAutoAplicacao(pintervaloHoras:integer);
var HoraAtual,mUltimaHora:integer;
strsql:string;
lst:tsbbetabeladados;
begin
   HoraAtual:=hourof(time);
   strsql:=' SELECT max(Hora) as UltimaHora FROM ERP_regReinicioAutomatico '
   +' where data='+sb.UtilSQL.DataToSQLData(date);
   lst:=sb.SBBD.AbrirLV(strsql);
   if lst.Vazia then
   begin
     RegistaInicioAutoAplicacao;
     acreiniciar.Execute;
   end
   else
   begin
      mUltimaHora:=lst.daValor('UltimaHora').AsInteger;
      if mUltimaHora+pintervaloHoras<=HoraAtual then
      begin
        RegistaInicioAutoAplicacao;
        acreiniciar.Execute;
      end;

   end;
   if assigned(lst) then
   freeandnil(lst);

end;


Procedure TFrmIERPPrincipal.RegistaInicioAutoAplicacao;
var HoraAtual:integer;
strsql:string;
lst:tsbbetabeladados;
begin
  HoraAtual:=hourof(time);
  strsql:=' Insert into ERP_regReinicioAutomatico(Data,Hora)'
  +' values(' +sb.UtilSQL.DataToSQLData(date)
  +','+ inttostr(HoraAtual)+')';
  sb.SBBD.Executa(strsql);
end;


procedure TFrmIERPPrincipal.acReiniciarExecute(Sender: TObject);
var CaminhoFicheiroBAT,
NomeApl,
CaminhoAplicacoesServidor,
CaminhoAplicacaoLocal,
PathAplicacoes:string;
begin
       PathAplicacoes:=ExtractFilePath(Application.ExeName);
        NomeApl := sb.UtilStr.Inverte(Application.ExeName);
        NomeApl := sb.UtilStr.Da_Palavra_Ate(NomeApl, '\');

        NomeApl := sb.UtilStr.Inverte(NomeApl);
        NomeApl := sb.UtilStr.Da_Palavra_Ate(NomeApl, '.');

        CaminhoFicheiroBAT := PathAplicacoes  +'reinicia.bat';
          CaminhoAplicacoesServidor := PathAplicacoes ;
                CaminhoAplicacaoLocal :=CaminhoAplicacoesServidor;
               sb.windows.SBRunEXE(CaminhoFicheiroBAT + ' ' +
                  CaminhoAplicacaoLocal + ' ' + PathAplicacoes + ' '
                  + NomeApl);
end;

procedure TFrmIERPPrincipal.AdvGlowButton15Click(Sender: TObject);
var
FrmERPGerarContasCBLClientes:TFrmERPGerarContasCBLClientes;
begin
FrmERPGerarContasCBLClientes:=tFrmERPGerarContasCBLClientes.create(self);
FrmERPGerarContasCBLClientes.showmodal;
end;


procedure TFrmIERPPrincipal.BtVendasExpCBLFNTClick(Sender: TObject);
var
FrmFntIntPrimaveraCBL:TFrmFntIntPrimaveraCBL;
begin
FrmFntIntPrimaveraCBL:=TFrmFntIntPrimaveraCBL.create(self);
FrmFntIntPrimaveraCBL.IDInterface:=TAdvGlowButton(Sender).tag;
FrmFntIntPrimaveraCBL.Caption:='Exportação CBL Vendas:'+ tAdvGlowButton(Sender).Caption;
FrmFntIntPrimaveraCBL.AbreFormulario;
end;

procedure TFrmIERPPrincipal.BtComprasExpCBLCMPClick(Sender: TObject);
var
FrmFntIntPrimaveraCBL:TFRMERPExportacaoCBLCompras;
begin
FrmFntIntPrimaveraCBL:=TFRMERPExportacaoCBLCompras.create(self);
FrmFntIntPrimaveraCBL.IDInterface:=TAdvGlowButton(Sender).tag;
FrmFntIntPrimaveraCBL.Caption:='Exportação CBL Compras:'+ tAdvGlowButton(Sender).Caption;
FrmFntIntPrimaveraCBL.AbreFormulario;
end;

procedure TFrmIERPPrincipal.AdvGlowButton34Click(Sender: TObject);
var
FrmERPGerarContasCBLClientes:TFrmERPGerarContasCBLClientes;
begin
FrmERPGerarContasCBLClientes:=tFrmERPGerarContasCBLClientes.create(self);
FrmERPGerarContasCBLClientes.showmodal;
end;
end.

