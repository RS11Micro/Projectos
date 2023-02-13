unit ERP_FRMIntegracaoAutomatica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, AdvToolBar,ERPLogOperacoes,ERPOperInterfaceFnt,ERPOperInterfaceProtel,
  ERPOperInterfaceFNTCMP, ExtCtrls, AdvPanel,ERPEnvioEmail,IERPListasDef,sbbetabeladados,dateutils,
  RxNotify, AdvPicture;

type
  TFRMERPIntegracaoAutomatica = class(TForm)
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    Btsair: TAdvToolBarButton;
    tbSepIcons: TAdvToolBarSeparator;
    BtAtivar: TAdvToolBarButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    ActionList1: TActionList;
    AcexportarAutomatico: TAction;
    acsair: TAction;
    AdvPanel1: TAdvPanel;
    TprocessaVendas: TTimer;
    AdvPicture1: TAdvPicture;
    procedure AcexportarAutomaticoExecute(Sender: TObject);
    procedure BtsairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TprocessaVendasTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
      FMintemporizador:Integer;
      FIntervaloHoraParaReinicio :Integer;
     FcarregouListasSyscontroller,

        FcarregouListasPMS:boolean;
     Procedure TrimAppMemorySize;
    Function ValidaInterfaceSyscontroller():Boolean;
    Function ValidaInterfacePMS():Boolean;
    Function ValidaInterfaceCMP():Boolean;

  public
    { Public declarations }
  end;

var
  FRMERPIntegracaoAutomatica: TFRMERPIntegracaoAutomatica;

implementation
uses ERPBEEMPRESAINTERFACE,IERPOGLOBAIS,IERPFrmPrincipal;

{$R *.dfm}


Function TFRMERPIntegracaoAutomatica.ValidaInterfaceSyscontroller():Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
 mensagem:string;
begin
  result:=false;
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
  If assigned(ObjInterface) then
  begin
       Result:=True;
       ERPOperInterfaceFNT.FOBJInterface:=MotorERP.ERPInterface.Clone(ObjInterface);
       If ObjInterface.BDConexao='' then
       begin
         mensagem:='Falta Conexão á Base de Dados do SYSCONTROLLER!' ;
         result:=false;
       end
       else
       begin
        If not(ERPOperInterfaceFNT.TestaConexaoBDExterna( ERPOperInterfaceFNT.FOBJInterface.BDConexao)) then
        begin
           Mensagem:='Não é possivel conectar com a  Base de Dados do Syscontroller';
           Result:=false;
        end;
       end;

 
       If ObjInterface.ID_clienteIndiferenciado='' then
       begin
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar o cliente indeferenciado!'
       end;
  end;
  if result=false then
  begin
   ERPEnvioEmail.EnviaEmail('Exportação Vendas-Syscontroller',mensagem);
  end;

end;

Function TFRMERPIntegracaoAutomatica.ValidaInterfacePMS():Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
 mensagem:string;
begin
  result:=false;
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASPROTEL');
  If assigned(ObjInterface) then
  begin
       Result:=True;
       ERPOperInterfaceProtel.FOBJInterface:=MotorERP.ERPInterface.Clone(ObjInterface);
       If ObjInterface.BDConexao='' then
       begin
         mensagem:='Falta Conexão á Base de Dados do Hotel!';
         result:=false;
       end
       else
       begin
        If not(ERPOperInterfaceProtel.TestaConexaoBDExterna( ERPOperInterfaceProtel.FOBJInterface.BDConexao)) then
        begin
           Mensagem:='Não é possivel conectar com a  Base de Dados do PMS';
           Result:=false;
        end;
       end;
       if result=true then
       begin
         If Not(FcarregouListasPMS) then
         begin
                CarregaListasProtel(ObjInterface.BDConexao,ObjInterface.BDSchema,ObjInterface.Namelinkedserver);
                FcarregouListasPMS:=true;
         end;
       end;
       freeandnil(ObjInterface);

    if result=false then
      begin
        ERPEnvioEmail.EnviaEmail('Exportação Vendas-PMS',mensagem);
      end;

  end;


end;


Function  DaDataInicioExportacaoCMP(pObjInterface:TERPBEEMPRESAINTERFACE):tdatetime;
var Ano, Mes, Dias: Integer;
    data:tdatetime;
     Listaex:tsbbetabeladados;
Begin
  Data := SB.Empresa.DataTrabalho;
  Ano:=YearOf(data);
  Result:= EncodeDate(Ano,1,1);
  Listaex:=sb.sbbd.abrirlv('select * from ERP_CompCab');
  If Not(Listaex.vazia) then
  begin

    If pObjInterface.DATAInicioExportacao>0 then
    begin
       Result:= pObjInterface.DATAInicioExportacao;
    end;
  end;
 Listaex.fecha;
 Freeandnil(Listaex);
end;

Function TFRMERPIntegracaoAutomatica.ValidaInterfaceCMP():Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
 mensagem:string;
begin
  result:=false;
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_COMPRASSYSCONTROLLER');
  If assigned(ObjInterface) then
  begin
       Result:=True;
       ERPOperInterfaceFNTcmp.FOBJInterface:=MotorERP.ERPInterface.Clone(ObjInterface);       
       ERPOperInterfaceFNTcmp.FOBJInterface.DATAInicioExportacao:=DaDataInicioExportacaoCMP(ObjInterface);

       FID_clienteIndiferenciado:= ObjInterface.ID_clienteIndiferenciado;
       FExpApenasComprasFechadas:= ObjInterface.ExpApenasComprasFechadas;
       FCONNECTIONSTRING := ObjInterface.BDConexao;

       If ObjInterface.BDConexao='' then
       begin
         result:=false;
         mensagem:='Falta Conexão á Base de Dados do SYSCONTROLLER!'
       end
       else
       begin
        If not(ERPOperInterfaceProtel.TestaConexaoBDExterna( ERPOperInterfaceFNTcmp.FOBJInterface.BDConexao)) then
        begin
           Mensagem:='Não é possivel conectar com a  Base de Dados do Syscontroller';
           Result:=false;
        end;
       end;

       If ObjInterface.ID_clienteIndiferenciado='' then
       begin
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar o cliente indeferenciado!'
       end;

       if result=true then
       begin
         If Not(FcarregouListasSyscontroller) then
         begin
            CarregaListasSyscontroller(ObjInterface.BDConexao);
            FcarregouListasSyscontroller:=true;
         end;
       end;


        freeandnil(ObjInterface);

      if result=false then
      begin
        ERPEnvioEmail.EnviaEmail('Exportação Mov.Stocks-Syscontroller',mensagem);
      end;

  end;


end;

procedure TFRMERPIntegracaoAutomatica.AcexportarAutomaticoExecute(Sender: TObject);
begin
   TprocessaVendas.Interval:=2000 ;
   TprocessaVendas.enabled:=true;
end;

procedure TFRMERPIntegracaoAutomatica.BtsairClick(Sender: TObject);
begin
 self.close;
end;

procedure TFRMERPIntegracaoAutomatica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action:=cafree;
end;

procedure TFRMERPIntegracaoAutomatica.FormCreate(Sender: TObject);
begin
  FcarregouListasSyscontroller:=false;
  FcarregouListasPMS:=false;

  FMintemporizador:=FrmIERPPrincipal.FIntervalotemporizador;
end;

procedure TFRMERPIntegracaoAutomatica.TprocessaVendasTimer(
  Sender: TObject);
begin
  //GestaodeReinicioAutoAplicacao(FIntervaloHoraParaReinicio);
  Application.Minimize;
  self.WindowState:=wsMinimized;
  TprocessaVendas.Interval:=1000 * FMintemporizador;
  //EnviaParaLog;



  TprocessaVendas.Enabled:=false;

 If ValidaInterfaceSyscontroller then
        ERPOperInterfaceFNT.ExportarAutomatica;

 If ValidaInterfacePMS then
    ERPOperInterfaceProtel.ExportarAutomatica;


 If ValidaInterfaceCMP then
         ERPOperInterfaceFNTCMP.ExportarcomprasAutomatico(ERPOperInterfaceFNTCMP.FOBJInterface.DATAInicioExportacao);

  TrimAppMemorySize;
  TprocessaVendas.Enabled:=True;
end;


Procedure TFRMERPIntegracaoAutomatica.TrimAppMemorySize;
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  except
  end;
  Application.ProcessMessages;
end;
procedure TFRMERPIntegracaoAutomatica.FormShow(Sender: TObject);
begin
        AcexportarAutomatico.Execute;
end;

end.
