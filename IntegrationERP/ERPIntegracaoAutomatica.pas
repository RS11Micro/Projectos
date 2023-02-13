unit ERPIntegracaoAutomatica;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, AdvToolBar,ERPLogOperacoes,ERPOperInterfaceFnt,ERPOperInterfaceProtel,
  ERPOperInterfaceFNTCMP, ExtCtrls, AdvPanel,ERPEnvioEmail,IERPListasDef,sbbetabeladados,dateutils,
  RxNotify, AdvPicture,PMSIntfPrimaveraCBL0900;

    Procedure TrimAppMemorySize;
    Function ValidaInterfaceSyscontroller(var mensagem:string):Boolean;
    Function ValidaInterfacePMS(var mensagem:string):Boolean;
    Function ValidaInterfaceCMP(var mensagem:string):Boolean;
    Procedure ExportacaoAutomatica();
    Function ValidaExportacaoAutomatica:Boolean;
var
    FMintemporizador:Integer;
    FIntervaloHoraParaReinicio :Integer;
    FcarregouListasSyscontroller,
    FcarregouListasPMS:boolean;


implementation
uses ERPBEEMPRESAINTERFACE,IERPOGLOBAIS,IERPFrmPrincipal;



Function  ValidaInterfaceSyscontroller(var mensagem:string):Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;

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
         mensagem:='Falta Conexão  Base de Dados do SYSCONTROLLER!' ;
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
         mensagem:=mensagem+'Falta Configurar o cliente indeferenciado!';
         Result:=false;
       end;


 
       If ObjInterface.DATAInicioExportacao=0 then
       begin
        Result:=false;
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar a Data início de exportação!'
       end;
  end;
  if result=false then
  begin
    ERPEnvioEmail.EnviaEmail('Exportação Vendas-Syscontroller','Não é possivel inicializar a exportação:'+#13+mensagem);
    mensagem:= ' -> Exportação Vendas-Syscontroller'+#13+' '+mensagem;
  end;

end;

Function  ValidaInterfacePMS(var mensagem:string):Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
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
         mensagem:='Falta Conexão á Base de Dados do PMS!';
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

       If ObjInterface.DATAInicioExportacao=0 then
       begin
           Result:=false;
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar a Data início de exportação!'
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
        ERPEnvioEmail.EnviaEmail('Exportação Vendas-PMS','Não é possivel inicializar a exportação:'+#13+mensagem);
        mensagem:= ' -> ExportaçãoVendas-PMS'+#13+' '+ mensagem;
      end;

  end
  else
  begin
          mensagem:='Interface :"ExportaçãoVendas-PMS não está ativo'
  end;


end;



Function  ValidaInterfaceCBLPMS(var mensagem:string):Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
begin
  result:=false;
  ObjInterface:=nil;
  ObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_CBLPROTEL');
  If assigned(ObjInterface) then
  begin
       Result:=True;
       ERPOperInterfaceProtel.FOBJInterface:=MotorERP.ERPInterface.Clone(ObjInterface);
       If ObjInterface.BDConexao='' then
       begin
         mensagem:='Falta Conexão á Base de Dados do PMS!';
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

       If ObjInterface.DATAInicioExportacao=0 then
       begin
           Result:=false;
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar a Data início de exportação!'
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
        ERPEnvioEmail.EnviaEmail('Exportação CBL-Vendas-PMS','Não é possivel inicializar a exportação:'+#13+mensagem);
        mensagem:= ' -> Exportação CBL-Vendas-PMS'+#13+' '+ mensagem;
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
   If pObjInterface.DATAInicioExportacao>0 then
   begin
       Result:= pObjInterface.DATAInicioExportacao;
   end;
end;

Function  ValidaInterfaceCMP(var mensagem:string):Boolean;
var
 ObjInterface:TERPBEEMPRESAINTERFACE;
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
         mensagem:=mensagem+'Falta Configurar o cliente indeferenciado!';
         Result:=false;
       end;

       If ObjInterface.DATAInicioExportacao=0 then
       begin
           Result:=false;
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar a Data início de exportação!'
       end;

        If ObjInterface.ExpEncomendas=true then
       If ObjInterface.DataIniExpEncomendas=0 then
       begin
           Result:=false;
        If mensagem<>'' then
        begin
         mensagem:=mensagem+#13;
        end;
         mensagem:=mensagem+'Falta Configurar a Data início de exportação! de ENCOMENDAS!'
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
        ERPEnvioEmail.EnviaEmail('Exportação Mov.Stocks-Syscontroller','Não é possivel inicializar a exportação:'+#13+mensagem);
        mensagem:= ' -> Exportação Vendas-Syscontroller'+#13+' '+ mensagem;
      end;

  end
  else
  Result:=true;


end;



Procedure  TrimAppMemorySize;
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

Function ValidaExportacaoAutomatica:Boolean;
var
  segue:Boolean;
  InterfaceSyscontrollerOK,
  InterfacePMSOK,
  InterfaceCMPOK:Boolean;
  MensagemValidacao:string;
  mensg1,mensg2,mensg3,mensg4:string;

begin
  Result:=false;
  FrmIERPPrincipal.FInterfaceSyscontrollerOK:=false;
  FrmIERPPrincipal.FInterfacePMSOK:=false;
  FrmIERPPrincipal.FInterfaceCMPOK:=false;
  FrmIERPPrincipal.FInterfaceCBLPMSOK:=false;

  mensg1:='';
  mensg2:='';
  mensg3:='';
  mensg4:='';



  If FrmIERPPrincipal.FMODULOEXPORTACAOCBL=false then
  begin
    FrmIERPPrincipal.FInterfaceSyscontrollerOK:= ValidaInterfaceSyscontroller(mensg1);
    FrmIERPPrincipal.FInterfacePMSOK:= ValidaInterfacePMS(mensg2);
    FrmIERPPrincipal.FInterfaceCMPOK:=ValidaInterfaceCMP(mensg3);
    Result:= (FrmIERPPrincipal.FInterfaceSyscontrollerOK) and
          (FrmIERPPrincipal.FInterfacePMSOK) and  (FrmIERPPrincipal.FInterfaceCMPOK);

  end
  else
  begin
     FrmIERPPrincipal.FInterfaceCBLPMSOK:= ValidaInterfaceCBLPMS(mensg4);
     Result:= FrmIERPPrincipal.FInterfaceCBLPMSOK;
  end;

 If Result=false then
 begin
  If mensg1<>'' then
      MensagemValidacao:=mensg1;
  If mensg2<>'' then
  begin
    If MensagemValidacao<>'' then
          MensagemValidacao:=MensagemValidacao+#13;
    MensagemValidacao:=MensagemValidacao+mensg2;
  end;
  If mensg3<>'' then
  begin
    If MensagemValidacao<>'' then
          MensagemValidacao:=MensagemValidacao+#13;
    MensagemValidacao:=MensagemValidacao+mensg3;
  end;


  If mensg4<>'' then
  begin
    If MensagemValidacao<>'' then
          MensagemValidacao:=MensagemValidacao+#13;
    MensagemValidacao:=MensagemValidacao+mensg4;
  end;

  sb.Dialogos.SBMessage('Não foi possível ativar a exportação automática!'+#13
                        +'Por favor verifique as configurações:'+#13+MensagemValidacao);
 end;                        
end;


Procedure ExportacaoAutomatica();
begin
        If FrmIERPPrincipal.FInterfaceSyscontrollerOK then
                ERPOperInterfaceFNT.ExportarAutomatica;

        If FrmIERPPrincipal.FInterfacePMSOK then
            ERPOperInterfaceProtel.ExportarAutomatica;

        If FrmIERPPrincipal.FInterfaceCMPOK then
        begin
          If ERPOperInterfaceFNTCMP.FOBJInterface<>nil then
          begin

           If ERPOperInterfaceFNTCMP.FOBJInterface.ExpEncomendas =true then
               ERPOperInterfaceFNTCMP.ExportarencomendasAutomatico(ERPOperInterfaceFNTCMP.FOBJInterface.DataIniExpEncomendas);
            ERPOperInterfaceFNTCMP.ExportarcomprasAutomatico(ERPOperInterfaceFNTCMP.FOBJInterface.DATAInicioExportacao);
            ERPOperInterfaceFNTCMP.ExportarInventariosAutomatico(ERPOperInterfaceFNTCMP.FOBJInterface.ExpInventarioAgrpArmProd);
          end;


        end;


        TrimAppMemorySize;

end;

end.
