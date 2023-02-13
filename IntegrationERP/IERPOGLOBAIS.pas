unit IERPOGLOBAIS;








interface
uses SBBSSistemaBase,IERPVersao,SBBaseDados,SBListasFac40,SBFormulariosFac40,
SBControlos,SBBEExcepcoes,SysUtils,
SBListasFormulariosDef40, AdvToolBar
,SBListaDef40,IniFiles,ERPBS,fntbs,dialogs,ERPBEEMPRESAINTERFACE,classes;

type

  TeBCOGlobal=Class
    SB:TSBBSSistemaBase;
    procedure PreencheObjEmpresa(Obj:Tobject;pParcial:boolean);
    procedure AppException(Sender: TObject; E: Exception);
  end;


var
SB:TSBBSSistemaBase;
SB1:TSBBSSistemaBase;
SBBD:TSBBaseDados;
SBBDFnt:TSBBaseDados;
MotorERP:TERPBS;
MotorFnt:TFntBS;
Formularios:TSBFormulariosDefFac40;
FormulariosFnt:TSBFormulariosDefFac40;
Listas:TSBListasDefFac40;
ListasFnt:TSBListasDefFac40;
function AbreMotorSyscontroller:boolean;
function Abre:boolean;
procedure Fecha;
Procedure ToolBarResize(pToolBar: TAdvToolBar; pAdvSeparator: TAdvToolBarSeparator);
Function DecConexaoString():String;


//procedure ConfigMenuPrincipalConParametros;


implementation

uses SBBEAplicacao,Forms,SBBETabelaDados,SBBEEmpresa,
Controls, SBValor,SBBEConsTipos,SBBSExceptions,IERPDMRecursos,
 SBBESistemaBaseParams,IERPFrmPrincipal,IERPListasDef,IERPListasFormulariosDef;

var
  ObjGlobal:TeBCOGlobal;



procedure TeBCOGlobal.AppException(Sender: TObject;E:Exception);
begin
 If SB<>nil then
 If  SB.Dialogos<>nil then
    SB.Dialogos.SBException(E);
end;

procedure TeBCOGlobal.PreencheObjEmpresa(Obj:Tobject;pParcial:boolean);
var
  SBLista:TSBBETabelaDados;
begin
  SBLista:=SB.SBBD.AbrirLV('SELECT [ID_Empresa], Nomeservidor,[Nome], [Morada], [CodigoPostal],'
    +' [Rua], [Localidade], [ID_Distrito], [NIPC], [CapitalSocial], [Telefone],'
    +' [Fax], [Telemovel], [MatriculaCRC], [TelemovelProprietario], [NomeProprietario],'
    +' [MoradaProprietario], [ID_DistritoProprietario], [CodigoPostalProprietario],'
    +' [RuaProprietario], [LocalidadeProprietario], [TelefoneProprietario], [FaxProprietario],'
    +' [DataTrabalho], [IDG_Anexo] ,[PathAplicacoes],[PathLicenca],[Certificado],[NomeProduto],[VersaoProduto] FROM [EmpresaSoftware]');

try
  try
    With TSBBEEmpresa(Obj) Do
    Begin
      if not SBLista.Vazia then
      begin
        Codigo:=SBLista.daValor('ID_Empresa').AsString;
        ID_Distrito:=SBLista.daValor('ID_Distrito').AsLongint;
        Nome:=SBLista.daValor('Nome').AsString;
        Morada:=SBLista.daValor('Morada').AsString;
        NumContribuinte:=SBLista.daValor('NIPC').AsString;
        CapitalSocial:=SBLista.daValor('CapitalSocial').Valor;
        MatriculaCRC:=SBLista.daValor('MatriculaCRC').AsString;

        Telefone:=SBLista.daValor('Telefone').AsString;
        Fax:=SBLista.daValor('Fax').AsString;
        Telemovel:=SBLista.daValor('Telemovel').AsString;
        CodPostal:=SBLista.daValor('CodigoPostal').AsString;
        CodPostalRua:=SBLista.daValor('Rua').AsString;
        Localidade:=SBLista.daValor('Localidade').AsString;
        PathAplicacoes:=SBLista.daValor('PathAplicacoes').AsString;
        PathLicenca:=SBLista.daValor('PathLicenca').AsString;
        Certificado:=SBLista.daValor('Certificado').AsString;
        NomeProduto:=SBLista.daValor('NomeProduto').AsString;
        VersaoProduto:=SBLista.daValor('VersaoProduto').AsString;
        DataTrabalho:=date;

      end;
    End;
  except
    on E:Exception do
        raise EErroNormal.Create('IRPOGlobais','PreencheObjEmpresa',E.Message);
  end;

finally
  SBLista.Free;
end;
end;



Function UtilizadorAutomatico():boolean;
var
  AppDir:string;
  Tem:string;
begin
   result:=false;
   AppDir := ExtractFilePath(Application.ExeName);
   With TIniFile.Create(AppDir+'Config.ini') Do
   Try
    Tem := ReadString('Config', 'UtilizadorAutomatico', '');
    result:=tem='1';
   Finally
    Free;
   End;
end;

Function ExportacaoAutomatica():boolean;
begin
  ExportacaoAutomatica:=UtilizadorAutomatico;

end;

function AbreMotorSyscontroller:boolean;
var
 OBJInterface:TERPBEEMPRESAINTERFACE;
begin

  Result:=true;
  OBJInterface:=nil;
  OBJInterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_VENDASSYSCONTROLLER');
  If OBJInterface=NIL then
   OBJInterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_ComprasSYSCONTROLLER');

  If OBJInterface=NIL then
    OBJInterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_CBLVENDASFNT');

  If OBJInterface=NIL then
   OBJInterface:=MotorERP.ERPInterface.InterfaceActivo('ERP_CBLCOMPRASFNT');





  If assigned(OBJInterface) then
  begin
     Result:=false;
    if assigned(SB1) then
        SB1.FechaMotor
    else
        SB1:=TSBBSSistemaBase.create;
    sb1.Aplicacao.VersaoInterna:=SB.Aplicacao.VersaoInterna;
    Try
        SBBDFnt:=SB1.AbreMotor2(OBJInterface.BDServidor,OBJInterface.BDNOME,OBJInterface.BDUSER,OBJInterface.BDPASSWORD);
        MotorFnt:=TFntBS.create;
        MotorFnt.SB:=SB1;
        Result:= MotorFnt<>nil;
        If ListasFnt<>nil then
          ListasFnt.SB:=SB1;
        If FormulariosFnt<>nil then
        begin
          FormulariosFnt.sb:=SB1;
        SBCarregaFormularios40(FormulariosFnt);
        SBCarregaListas40(ListasFnt);
        Result:=true;

    end;
    except
         result:=false;
    end;

    Freeandnil(OBJInterface);
  end;

end;

function Abre:boolean;
var
  Login:string;
  Valido:boolean;
  aplicacao2:TSBBEAplicacao;
  MensagemAviso:boolean;
begin
  MensagemAviso:=false;
  result:=true;
  SB:=TSBBSSistemaBase.Create;
  SB.IDMotor:='{2C3FE9C9-A5F2-414F-A90F-D55ED42B859F}';


  ObjGlobal:=TeBCOGlobal.Create;
  ObjGlobal.SB:=SB;

  aplicacao2:=TSBBEAplicacao.create;

  Application.OnException:=ObjGlobal.AppException;

  MotorFnt:=nil;
  With  SB.Aplicacao do
  begin
    VerificaVersaoBD:=true;
    NomeAplicacao:='INTEGRATION-ERP';
    Abv:='ERP';
    FormatoAntigo:=False;
    Versao:=cVersao;
    VersaoBD:=cBDVersao;
    VersaoInterna:=cVersaoInterna;
    VersaoBDIdioma:=cBDIdiomaVersao;
    Denominacao:='Micro-Net';
    SubDenominacao:='ERP';
    Dados.PathAplicacao:=ExtractFilePath(Application.ExeName);
    Dados.PathImagens:=Dados.PathAplicacao + 'Imagens\';
    Dados.PathScripts:=Dados.PathAplicacao + 'Scripts\';
    Dados.PathMapas:=Dados.PathAplicacao + 'Mapas\';
    Dados.PathDocumentos:=Dados.PathAplicacao + 'Documentos\';


    PermiteLicencaDemo:=false;
    //A aplicação tem licença?
    TemLicenca:=true;
    TipoLicenca:=tlMAC;
  end;

  With SB.SistemaBaseParams do
  begin
    //Controla acessos? (Permissões)
    Acessos:=true;

    Login:=true;
    If  ExportacaoAutomatica=true then
        Login:=false;

    TipoUpgradeBD:=tugNormal;
    ConLoginInterno:=true;

    
  end;

  SB.OnPreencheEmpresa:=ObjGlobal.PreencheObjEmpresa;



  SBBD:=SB.Abre;


  MotorERP:=TERPBS.Create;
  MotorERP.SB:=SB;


  MensagemAviso:=Not(AbreMotorSyscontroller);

  //If  then
  //begin
   try
              DMIERPRecursos:=TDMIERPRecursos.Create(nil);


                //Temporário
              SBControlos.FSB:=SB;


              //Criar Listas e Formularios
              ///controlos para MotorFNt
              If sb1<>nil then
              begin
                  sb1.Formularios:=TSBFormulariosDefFac40.Create;
                  SB1.Listas:=TSBListasDefFac40.Create;
                  TSBListasDefFac40(SB1.Listas).SB:=SB1;
                  TSBListasDefFac40(SB1.Listas).Formularios:=TSBFormulariosDefFac40(SB1.Formularios);
                  ListasFnt:=TSBListasDefFac40(SB1.Listas);
                  FormulariosFnt:=TSBFormulariosDefFac40(SB1.Formularios);
                  SBCarregaListas40(ListasFnt);
                  SBCarregaFormularios40(FormulariosFnt);
              end;
              ///controlos para Motorerp
              SB.Formularios:=TSBFormulariosDefFac40.Create;
              SB.Listas:=TSBListasDefFac40.Create;
              TSBListasDefFac40(SB.Listas).SB:=SB;
              TSBListasDefFac40(SB.Listas).Formularios:=TSBFormulariosDefFac40(SB.Formularios);
              Listas:=TSBListasDefFac40(SB.Listas);


              Formularios:=TSBFormulariosDefFac40(SB.Formularios);


              CarregaFormularios;

              //Carrega definição dos formulários e listas
              SBCarregaFormularios40(Formularios);
              SBCarregaListas40(Listas);



              CarregaListas;
              If SB.SistemaBaseParams.Login=false then
                      SB.UtilizadorActual:=SB.Utilizador.Edita('SUPERVISOR');

              If SB.UtilizadorActual<>nil then
           //--- Escreve o utilizador numa das posições da StatusBar do form principal
              FRMIERPPrincipal.ColocaDadosNaStatusBar(SB.UtilizadorActual.Login,'SUPERVISOR',datetostr(date));


          //    FrmSplash;
            except

                on e:ESBSair do
                begin
                  result:=false;
                  Fecha;
                  Application.Terminate;
                end;

                on e:ESBBSLicenca do
                begin
                  result:=false;
                  SB.Dialogos.SBDetalhe(sb.Idioma.daTraducao(1275,'Erro na licença.'),e.Message);
                  Fecha;
                  Application.Terminate;
                end;

                on e:EErroDetalhe do
                begin
                  result:=false;
                  SB.Dialogos.SBException(sb.Idioma.daTraducao(1276,'Erro ao abrir o sistema base.'),e);
                  Fecha;
                  Application.Terminate;
                end;

                on e:Exception do
                begin
                  result:=false;
                  //*JM* Não se pode utilizar aqui a tradução
                  //sb.Idioma.daTraducao(1276,
                  SB.Dialogos.SBDetalhe('Erro ao abrir o sistema base.',e.Message);
                  Fecha;
                  Application.Terminate;
                end;
            end;
    //   end;
 {  else
   begin
      result:=false;
      SB.Dialogos.SBDetalhe('Erro ao abrir o MotorFNT_Syscontroller','');
      Fecha;
      Application.Terminate;
   end;}

   If MensagemAviso=true then
         SB.Dialogos.SBDetalhe('Erro ao abrir o MotorFNT_Syscontroller','Verifique os Interfaces');



end;

procedure Fecha;
begin

  if Assigned(Formularios) then
    Formularios.Free;

  if Assigned(Listas) then
    Listas.free;

  if Assigned(FormulariosFNT) then
    FormulariosFnt.Free;

  if Assigned(ListasFnt) then
    ListasFNT.free;

  if Assigned(SB) then
  begin
    SB.Fecha;
    SB.Free;
  end;


  if Assigned(SB1) then
  begin
    SB1.Fecha;
  
  end;


  if Assigned(ObjGlobal) then
    ObjGlobal.Free;


end;

Procedure ToolBarResize(pToolBar: TAdvToolBar; pAdvSeparator: TAdvToolBarSeparator);
var
    tamanho, i: integer;
begin
    tamanho:=0;
    for i:=0 to pToolBar.ControlCount-1 do
    begin
      if (pToolBar.Controls[i].Visible) And (pToolBar.Controls[i]<>pAdvSeparator) then
         tamanho:=tamanho + pToolBar.Controls[i].Width;

    end;
    pAdvSeparator.Width:=pToolBar.Width-tamanho-40;
end;

Function DecConexaoString():String;
Var stNomeIniL :String;
Begin
  stNomeIniL := ExtractFilePath(Application.ExeName)+'ConfigExpVendas.ini';

  With TIniFile.Create(stNomeIniL) Do
  Try
    Result := ReadString('Config', 'Conexao', '');
  Finally
    Free;
  End;
End;

end.
