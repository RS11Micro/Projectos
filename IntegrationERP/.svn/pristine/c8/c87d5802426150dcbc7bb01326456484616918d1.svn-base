unit IERP_FrmInterface;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FntFrmTabelas40, AdvPanel, AdvToolBar, ExtCtrls, StdCtrls,
  pngimage, AdvGroupBox,ERPBEEMPRESAINTERFACE,ADODB,sbbeconstipos,SBBEExcepcoes,sbcontrolos,
  AdvOfficeButtons, AdvOfficePager, HTMLChkList,iErpListasdef, Mask,
  AdvEdit, AdvMEdBtn, PlannerMaskDatePicker, AdvCombo, SBEditProcura;

type
  TFrm_IERPInterface = class(TFrmFntTabelas40)
    PanelCabecalho: TAdvPanel;
    Label2: TLabel;
    AdvToolBarButton1: TAdvToolBarButton;
    cbInterface: TComboBox;
    cbativo: TAdvOfficeCheckBox;
    PageOFFICE: TAdvOfficePager;
    tbgeral1: TAdvOfficePage;
    tbInTecnicaPms: TAdvOfficePage;
    panelDetalhe: TAdvPanel;
    GrpBd: TAdvGroupBox;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label77: TLabel;
    Label1: TLabel;
    EdServer1: TEdit;
    EDBaseDados1: TEdit;
    Eduser1: TEdit;
    EdPassword1: TEdit;
    edShema: TEdit;
    gbclienteIndiferenciado: TAdvGroupBox;
    EdclienteIndeferenciadoPrimCBLTabelas: TEdit;
    Label3: TLabel;
    memInfProtel: TMemo;
    Label4: TLabel;
    tbInformacaoTecnicafnt: TAdvOfficePage;
    Memo1: TMemo;
    TbInfTecCompras: TAdvOfficePage;
    Memo2: TMemo;
    gbData: TAdvGroupBox;
    lbsbInicio: TLabel;
    dtdataInicio: TPlannerMaskDatePicker;
    TbCBL: TAdvOfficePage;
    AdvPanel3: TAdvPanel;
    AdvGroupBox1: TAdvGroupBox;
    Label8: TLabel;
    cbsbRefleteClasseIva: TLabel;
    Label19: TLabel;
    cbsbRefleteCentroCusto: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    CbModoloVnd: TAdvComboBox;
    CbCentroCustos: TAdvComboBox;
    cbRefleteAnalitica: TAdvComboBox;
    CbRefleteClassesIVA: TAdvComboBox;
    cbReflecteClassesSelo: TAdvComboBox;
    cbReflecteFluxos: TAdvComboBox;
    cbReflecteCOPE: TAdvComboBox;
    cbReflectePlanoFuncional: TAdvComboBox;
    EdDiario: TEdit;
    edNcasasDecimais: TEdit;
    cbExportaVendas: TAdvOfficeCheckBox;
    cbtipoafetacao: TAdvComboBox;
    AdvGroupBox2: TAdvGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    CbModoloRec: TAdvComboBox;
    CbCentroCustosRec: TAdvComboBox;
    cbRefleteAnaliticaRec: TAdvComboBox;
    CbRefleteClassesIVARec: TAdvComboBox;
    cbReflecteClassesSeloRec: TAdvComboBox;
    cbReflecteFluxosRec: TAdvComboBox;
    cbReflecteCOPEREC: TAdvComboBox;
    cbReflectePlanoFuncionalRec: TAdvComboBox;
    EdDiarioRec: TEdit;
    AdvGroupBox7: TAdvGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    CbNaturezaCC: TComboBox;
    CbNaturezaPag: TComboBox;
    cbsbLoteNdocumento: TAdvOfficeCheckBox;
    cbConfContasPorTipodoc: TAdvOfficeCheckBox;
    cbContasPorMercado: TAdvOfficeCheckBox;
    cbExportaRecibos: TAdvOfficeCheckBox;
    Label18: TLabel;
    eddescricao: TEdit;
    cbperiodoIVA: TComboBox;
    Label31: TLabel;
    dataUltExp: TPlannerMaskDatePicker;
    Label32: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    edprefixo: TEdit;
    tbPropriedadespms: TAdvOfficePage;
    AdvGroupBox4: TAdvGroupBox;
    Label7: TLabel;
    eppagamentoCc: TSBEditProcura;
    rbControloCodClienteCC: TAdvOfficeRadioGroup;
    Grphoteis: TGroupBox;
    ChLstHoteis: THTMLCheckList;
    tbPropriedadesSyscon: TAdvOfficePage;
    gbsbCentroExploracao: TGroupBox;
    ChLstCentroExploracoes: THTMLCheckList;
    tbPropriedadescompras: TAdvOfficePage;
    GrpEstados: TAdvOfficeRadioGroup;
    AdvGroupBox5: TAdvGroupBox;
    cbsbEnviaLinhaIVA: TAdvOfficeCheckBox;
    CbExcluirDocsAnulados: TAdvOfficeCheckBox;
    Label22: TLabel;
    cbsbOmitirLinhasZero: TAdvOfficeCheckBox;
    AdvGroupBox6: TAdvGroupBox;
    cbsFibudebTabMetadata: TAdvOfficeCheckBox;
    cbOmitorLinhaIVA0: TAdvOfficeCheckBox;
    Edit1: TEdit;
    tbtipoexpcomp: TAdvOfficeRadioGroup;
    gbinventario: TAdvGroupBox;
    cbexpInvArmProduto: TAdvOfficeCheckBox;
    GrpIMC: TAdvGroupBox;
    Label10: TLabel;
    epInterface: TSBEditProcura;
    AdvGroupBox3: TAdvGroupBox;
    Label33: TLabel;
    DtInicioExpEnc: TPlannerMaskDatePicker;
    checkexpEncomendas: TAdvOfficeCheckBox;
    AdvGroupBox8: TAdvGroupBox;
    Label34: TLabel;
    DataIniExpAdiantamentos: TPlannerMaskDatePicker;
    cbexportaAdiantamentos: TAdvOfficeCheckBox;
    EdLinkedServer: TEdit;
    Label35: TLabel;
    AdvOfficePage1: TAdvOfficePage;
    AdvGroupBox9: TAdvGroupBox;
    CbObgContaErpProd: TAdvOfficeCheckBox;
    CbObgContaErpIvas: TAdvOfficeCheckBox;
    CbObgContaErpAreaNegocio: TAdvOfficeCheckBox;
    CbObgContaErpModPag: TAdvOfficeCheckBox;
    CbObgContaErpCliente: TAdvOfficeCheckBox;
    cbExpComprasAutNaoInterrompe: TAdvOfficeCheckBox;
    cmbOrigem: TAdvComboBox;
    Label36: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure AdvToolBarButton1Click(Sender: TObject);
    procedure cbInterfaceChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure eppagamentoCcBtListaClick(Sender: TObject);
    procedure epInterfaceBtListaClick(Sender: TObject);
  private
      Procedure SeleccionaOpcoesHoteis(pIDS: String);
      Procedure SeleccionaModosPagamentoProtel(Sender :TObject);
      Procedure SeleccionaOpcoesCenExP(pIDS: String);
      Function ValidaAlteracao():Boolean;
      procedure FAntesAbrir(Sender: TObject);
      procedure formataFormTipoInterface;
      Procedure LibertaMemoria;
      Procedure CarregaCentrosExploracao(Items :TStrings);
      procedure CarregaModulo(Items :TStrings);
      function daFiltroStr(CheckList:THTMLCheckList):String;
      Function TemmovimentosExportados(pnomeinterface:string):boolean;
      Function GravaDadosParametrosCBL(pID_IDempInterface:integer):Boolean;
      Procedure MostradadosERCBL(pID_EmpresaInteraface:Integer);
      Procedure SeleccionaInterfaceIMC(Sender :TObject);
      procedure DescricaoInterfaceIMC;
      procedure PreencheHoteis;
    { Private declarations }
  public
    { Public declarations }
    Function PreencheBE:TERPBEEMPRESAINTERFACE;
    Procedure MostraBE;override;

    Procedure CfAlterar;override;
    Procedure Limpa;override;

    Procedure CfInserir;override;

    Procedure CfAnular;override;
  end;

var
  Frm_IERPInterface: TFrm_IERPInterface;

implementation
Uses  IERPOGlobais, SBLista, SBBotoes, ERPBS,
  SBBSSistemaBase, ERPBSEMPRESAINTERFACE,IERPFrmPrincipal,sbbetabeladados,
  SBBaseDados;


{$R *.dfm}


function StringConection(Servidor,BaseDados,Utilizador,Password:String):String;
begin

    result:='Provider=SQLOLEDB.1;Password='+Password+';Persist Security Info=False;User ID='
    + Utilizador +';Initial Catalog='+ BaseDados +';Data Source=' + Servidor;
end;



Function TestaConexaoBDExterna(pConexao:string):boolean;
var
  Conexao:TADOConnection;
begin
    Result:=false;
    Conexao:=TADOConnection.Create(nil);
    Conexao.ConnectionString:=pConexao;
    Conexao.LoginPrompt:=False;
    Try
        Conexao.Open;
       If Conexao.Connected then
          Result:=true;

    except
              On E:EErroDetalhe Do
              Begin
                   result:=false;
                raise EErroDetalhe.Create('Interface ERP','Conexão com BD ERP EXTERNA','Não foi possível conectar.',E.Detalhe);
              End;

              On E :Exception Do
              Begin
              result:=false;
                raise EErroDetalhe.Create('Interface ERP','Conexão com BD ERP EXTERNA','Não foi possível conectar.',E.Message);
              End;
    end;
    If  result then
    begin
        Conexao.Close;
        Freeandnil(Conexao);
    end;
end;

Procedure TFrm_IERPInterface.Limpa;
Begin
End;


procedure TFrm_IERPInterface.CarregaModulo(Items :TStrings);
var
    ObjItemLista:TSBItemLista;

begin
      LimpaLista(Items);
      ObjItemLista:=TSBItemLista.Create;
      ObjItemLista.Chave := 0;
      ObjItemLista.Valor1:='V';
      ObjItemLista.Descricao:='V - Vendas';
      Items.AddObject('V - Vendas',ObjItemLista);

      ObjItemLista:=TSBItemLista.Create;
      ObjItemLista.Chave := 0;
      ObjItemLista.Valor1:='S';
      ObjItemLista.Descricao:='S - Stocks';
      Items.AddObject('S - Stocks',ObjItemLista);

      ObjItemLista:=TSBItemLista.Create;
      ObjItemLista.Chave := 0;
      ObjItemLista.Valor1:='C';
      ObjItemLista.Descricao:='C - Compras';
      Items.AddObject('C - Compras',ObjItemLista);


      ObjItemLista:=TSBItemLista.Create;
      ObjItemLista.Chave := 0;
      ObjItemLista.Valor1:='M';
      ObjItemLista.Descricao:='M - Contas Correntes';
      Items.AddObject('M - Contas Correntes',ObjItemLista);

      ObjItemLista:=TSBItemLista.Create;
      ObjItemLista.Chave := 0;
      ObjItemLista.Valor1:='B';
      ObjItemLista.Descricao:='B - Bancos';
      Items.AddObject('B - Bancos',ObjItemLista);

      ObjItemLista:=TSBItemLista.Create;
      ObjItemLista.Chave := 0;
      ObjItemLista.Valor1:='P';
      ObjItemLista.Descricao:='P - Recursos Humanos';
      Items.AddObject('P - Recursos Humanos',ObjItemLista);


      ObjItemLista:=TSBItemLista.Create;
      ObjItemLista.Chave := 0;
      ObjItemLista.Valor1:='I';
      ObjItemLista.Descricao:='I - Imobilizado';
      Items.AddObject('I - Imobilizado',ObjItemLista);


      ObjItemLista:=TSBItemLista.Create;
      ObjItemLista.Chave := 0;
      ObjItemLista.Valor1:='L';
      ObjItemLista.Descricao:=' L- Contabilidade (Sempre que forem documentos de módulos terceiros)';
      Items.AddObject(' L- Contabilidade (Sempre que forem documentos de módulos terceiros)',ObjItemLista);

end;


Function TFrm_IERPInterface.PreencheBE:TERPBEEMPRESAINTERFACE;
var    ObjItemLista :TSBItemLista;
      mconexao:string;
Begin
  Result := TERPBEEMPRESAINTERFACE.Create;

  With Result Do
  Begin
        ObjItemLista := DaItemLista(cbInterface.Items, cbInterface.ItemIndex);
        Result.ID_Interface:=ObjItemLista.Chave;
        Result.BDNOME:=EDBaseDados1.Text;
        Result.BDUSER:=Eduser1.Text;
        Result.BDPASSWORD:=EdPassword1.text;
        Result.BDServidor:=EdServer1.text;
        Result.BDSchema:=edShema.text;
        Result.PrefixoContCblAartigo:=edprefixo.text;
        Result.Ativo:=cbativo.Checked;
        Result.ID_clienteIndiferenciado:=EdclienteIndeferenciadoPrimCBLTabelas.text;
        result.IDSCentrosExploracao:=daFiltroStr(ChLstCentroExploracoes);
        result.IDSHoteis:=daFiltroStr(ChLstHoteis);
        result.ExpApenasComprasFechadas:=(GrpEstados.ItemIndex=1);
        result.DATAInicioExportacao:=dtdataInicio.Date;
        result.ExportaAdiantamentosPMS:=cbexportaAdiantamentos.checked;
        result.DataIniExpAdiantamentosPMS:=DataIniExpAdiantamentos.Date;

        mconexao:=StringConection(Result.BDServidor,Result.BDnome,Result.BDUSER,Result.BDPASSWORD);
        Result.bdconexao:=mconexao;

        result.descricao:=eddescricao.text;

        result.Origem:= cmbOrigem.ItemIndex;

        result.ID_InterfaceIMC:=epInterface.id_chave;
        result.PeriodoIVA:=cbperiodoIVA.ItemIndex;
        If tbtipoexpcomp.itemindex=0 then
         result.tipoPeriodExportacao:=1
        else
            result.tipoPeriodExportacao:=2;

        result.TipoCtrlCodClienteCC:=rbControloCodClienteCC.ItemIndex;
        result.ID_PagamentoCC:=eppagamentoCc.id_chave;
        result.ExpInventarioAgrpArmProd:=cbexpInvArmProduto.checked;
        Result.ExpEncomendas:=checkexpEncomendas.checked;
        Result.DataIniExpEncomendas:=DtInicioExpEnc.date;
        Result.Namelinkedserver:= EdLinkedServer.Text;

        Result.ObgLinhaContaERPProd:=CbObgContaErpProd.checked;
        Result.ObgLinhaContaERPIVA:=CbObgContaErpIVAS.checked;
        Result.ObgLinhaContaERPAreaNeg:=CbObgContaErpAreaNegocio.checked;
        Result.ObgLinhaContaERPModPag:=CbObgContaErpModPag.checked;

        Result.ObgContaERPCliente:=CbObgContaErpCliente.checked;
        Result.NaoParaInterfaceAutCompras:=cbExpComprasAutNaoInterrompe.checked;



  end;
end;

Procedure TFrm_IERPInterface.MostraBE;
var
 Obj :TERPBEEMPRESAINTERFACE;
 stridshoteis,strIdscenexp,Shema:string;

Begin
  Obj:=MotorERP.ERPInterface.Edita(ValorChave);
  If Assigned(Obj) Then
  Begin
    Try
        cbexportaAdiantamentos.checked:=obj.ExportaAdiantamentosPMS;
        DataIniExpAdiantamentos.Date:=obj.DataIniExpAdiantamentosPMS;

        cbInterface.ItemIndex:=DaPosicaoLista(cbInterface.Items, obj.id_interface);
        EDBaseDados1.Text:=obj.BDNOME;
        Eduser1.Text:=obj.BDUSER;
        EdPassword1.text:=obj.BDPASSWORD;
        EdServer1.text:= obj.BDServidor;
        edShema.text:=obj.BDSchema;
         EdLinkedServer.Text:= obj.Namelinkedserver;        
        If  obj.PeriodoIVA> 0 then
         cbperiodoIVA.ItemIndex:=obj.PeriodoIVA;

         PreencheHoteis;
        edprefixo.text:= obj.PrefixoContCblAartigo;
        EdclienteIndeferenciadoPrimCBLTabelas.text:=obj.ID_clienteIndiferenciado;
        cbativo.Checked:=obj.Ativo;

       If obj.ExpApenasComprasFechadas=true then
            GrpEstados.itemindex:=1;

        If  obj.IDSCentrosExploracao<>''  then
        begin
            strIdscenexp:= obj.IDSCentrosExploracao;
            SeleccionaOpcoesCenExP(strIdscenexp);
        end;

        If  obj.IDSHoteis<>''  then
        begin
            strIdsHoteis:= obj.IDSHoteis;
            SeleccionaOpcoesHoteis(strIdsHoteis);
        end;




        gbData.Visible:=true;
        if obj.DATAInicioExportacao>0 then
        begin
            dtdataInicio.Date:=obj.DATAInicioExportacao;
            dtdataInicio.readonly:=true;
        end;

        If obj.DATAUltimaExportacao>0 then
          dataUltExp.Date:=obj.DATAUltimaExportacao;

        tbtipoexpcomp.itemindex:=obj.TipoPeriodExportacao-1;

        eddescricao.text:=obj.descricao;
        cmbOrigem.ItemIndex:=obj.Origem;
        If obj.ID_InterfaceIMC>0 then
        begin
           epInterface.id_chave:=obj.ID_InterfaceIMC;
           DescricaoInterfaceIMC;

        end;
        rbControloCodClienteCC.ItemIndex:=obj.TipoCtrlCodClienteCC;

        cbexpInvArmProduto.checked:=obj.ExpInventarioAgrpArmProd;

        FormataFormTipoInterface;

        MostradadosERCBL(ValorChave);
       If obj.ID_PagamentoCC>0 then
       begin
         eppagamentoCc.id_chave :=  obj.ID_PagamentoCC;
         Shema:=obj.BDSchema;
         iF EdLinkedServer.Text<>'' THEN
            Shema:=EdLinkedServer.Text+'.'+ Shema;
         eppagamentoCc.text:=sb.daValorAtributo(Shema+'zahlart','za',inttostr(eppagamentoCc.id_chave),'bez').asstring;
       end;
       checkexpEncomendas.checked:=obj.ExpEncomendas;
       DtInicioExpEnc.date:=obj.DataIniExpEncomendas;

       CbObgContaErpProd.checked:= obj.ObgLinhaContaERPProd;
       CbObgContaErpIVAS.checked:= obj.ObgLinhaContaERPIVA;
       CbObgContaErpAreaNegocio.checked:= obj.ObgLinhaContaERPAreaNeg;
       CbObgContaErpModPag.checked:=  obj.ObgLinhaContaERPModPag;
       CbObgContaErpCliente.checked:=  obj.ObgContaERPCliente;

       cbExpComprasAutNaoInterrompe.checked:= obj.NaoParaInterfaceAutCompras;

    Finally
      Obj.Free;
    End;
  End
  Else raise SB.ErroNormal(0,'C.Exploração Interface','MostraBE','O registo não existe. Foi removido por outro posto.');

End;


Procedure TFrm_IERPInterface.MostradadosERCBL(pID_EmpresaInteraface:Integer);
var
  strsql,Shema:string;
  Lstdados:TSBBETabelaDados;
begin


    strsql:='Select * from ERP_CBLParametros where ID_EmpresaInteraface='+Inttostr(pID_EmpresaInteraface);
    Lstdados:=sb.SBBD.AbrirLV(strsql);
    If Not(Lstdados.Vazia) then
    begin

      cbsbOmitirLinhasZero.checked:=Lstdados.daValor('OmiteLinhaZero').asboolean;

      cbsbEnviaLinhaIVA.checked:=Lstdados.daValor('EnviaLinhaIVA').asboolean;
      If cbsbEnviaLinhaIVA.checked then
      begin
        cbOmitorLinhaIVA0.enabled:=true;
        cbOmitorLinhaIVA0.checked:=Lstdados.daValor('OmitirLinhaIVA0perc').asboolean;
      end
      else
      begin
        cbOmitorLinhaIVA0.enabled:=false;
      end;

      cbsbLoteNdocumento.checked:=Lstdados.daValor('LoteIgualNDocumento').asboolean;
      cbConfContasPorTipodoc.checked:=Lstdados.daValor('ConfContasPorTipoDoc').asboolean;
      cbsFibudebTabMetadata.checked:=Lstdados.daValor('FibudebMetaData').asboolean;
      edNcasasDecimais.Text:=Lstdados.daValor('NumCasaDecimaisVL').asstring;

      CbExcluirDocsAnulados.checked:=Lstdados.daValor('ExcluirDocsVndAnulados').asboolean;
      cbContasPorMercado.checked:=Lstdados.daValor('ContasPorMercado').asboolean;
      cbExportaVendas.Checked:=Lstdados.daValor('ExportaVendas').asboolean;
      cbExportaRecibos.Checked:=Lstdados.daValor('ExportaRecibos').asboolean;


    If Lstdados.daValor('RecNatPAGCC').asstring='C' then
       CbNaturezaCC.itemindex:=0
     else
     If  Lstdados.daValor('RecNatPAGCC').asstring='D' then
       CbNaturezaCC.itemindex:=1;


    If Lstdados.daValor('RecNatPAG').asstring='C' then
       CbNaturezaPag.itemindex:=0
    else
    If Lstdados.daValor('RecNatPAG').asstring='D' then
       CbNaturezaPag.itemindex:=1;






      If Lstdados.daValor('RefleteClasseIva').asstring='S' then
        CbRefleteClassesIVA.itemindex:=0
      else
        CbRefleteClassesIVA.itemindex:=1;

      If Lstdados.daValor('RefleteAnalitica').asstring='S' then
          cbRefleteAnalitica.itemindex:=0
      else
          cbRefleteAnalitica.itemindex:=1;


      If Lstdados.daValor('RefleteCentroCustos').asstring='S' then
          CbCentroCustos.itemindex:=0
      else
          CbCentroCustos.itemindex:=1;

      If Lstdados.daValor('ReflecteClassesSelo').asstring='S' then
          cbReflecteClassesSelo.itemindex:=0
      else
          cbReflecteClassesSelo.itemindex:=1;

      If Lstdados.daValor('ReflectePlanoFuncional').asstring='S' then
          cbReflectePlanoFuncional.itemindex:=0
      else
          cbReflectePlanoFuncional.itemindex:=1;


      If Lstdados.daValor('ReflecteFluxos').asstring='S' then
          cbReflecteFluxos.itemindex:=0
      else
          cbReflecteFluxos.itemindex:=1;

      If Lstdados.daValor('ReflecteCOPE').asstring='S' then
          cbReflecteCOPE.itemindex:=0
      else
          cbReflecteCOPE.itemindex:=1;



      EdDiario.text:=Lstdados.daValor('diario').asstring;


      If Lstdados.daValor('RefleteClasseIvaRec').asstring='S' then
        CbRefleteClassesIVARec.itemindex:=0
      else
        CbRefleteClassesIVARec.itemindex:=1;

      If Lstdados.daValor('RefleteAnaliticaRec').asstring='S' then
        cbRefleteAnaliticaRec.itemindex:=0
      else
        cbRefleteAnaliticaRec.itemindex:=1;

      If Lstdados.daValor('RefleteCentroCustosRec').asstring='S' then
        CbCentroCustosRec.itemindex:=0
      else
        CbCentroCustosRec.itemindex:=1;


      cbtipoafetacao.itemindex:=  Lstdados.daValor('TipoAfetacao').asinteger;

      If Lstdados.daValor('ReflecteClassesSeloRec').asstring='S' then
        cbReflecteClassesSeloRec.itemindex:=0
      else
        cbReflecteClassesSeloRec.itemindex:=1;

      If Lstdados.daValor('ReflectePlanoFuncionalRec').asstring='S' then
        cbReflectePlanoFuncionalRec.itemindex:=0
      else
        cbReflectePlanoFuncionalRec.itemindex:=1;


      If Lstdados.daValor('ReflecteFluxosRec').asstring='S' then
        cbReflecteFluxosRec.itemindex:=0
      else
        cbReflecteFluxosRec.itemindex:=1;

      If Lstdados.daValor('ReflecteCOPERec').asstring='S' then
        cbReflecteCOPERec.itemindex:=0
      else
        cbReflecteCOPERec.itemindex:=1;

      EdDiarioRec.text:=Lstdados.daValor('diarioRec').asstring;



      CbModoloVnd.ItemIndex := DaPosicaoLista(CbModoloVnd.Items, Lstdados.daValor('ModuloVND').asstring);
      CbModoloRec.ItemIndex := DaPosicaoLista(CbModoloRec.Items, Lstdados.daValor('ModuloRec').asstring);


      If Lstdados.daValor('ID_PagamentoCC').asinteger>0 then
      begin
         eppagamentoCc.id_chave :=  Lstdados.daValor('ID_PagamentoCC').asinteger;
         Shema:=edShema.text;
         iF EdLinkedServer.Text<>'' THEN
            Shema:=EdLinkedServer.Text+'.'+ Shema;

         eppagamentoCc.text:=sb.daValorAtributo(Shema+'zahlart','za',inttostr(eppagamentoCc.id_chave),'bez').asstring;
      end;

    end;

    FreeAndnil(lstdados);
end;                                                  





Function TFrm_IERPInterface.ValidaAlteracao():Boolean;
var
  conexaoString:string;
begin
  result:=false;
  //  and (EdclienteIndeferenciadoPrimCBLTabelas.text<>'')
  If (EDBaseDados1.Text<>'') and   (Eduser1.Text<>'') and
       (EdServer1.text<>'') and (EdPassword1.text<>'')   and  (cmbOrigem.ItemIndex>0)
 then
  begin
        conexaoString:= StringConection(EdServer1.text,EDBaseDados1.Text,Eduser1.Text,EdPassword1.text);
        If Not(TestaConexaoBDExterna(conexaoString)) then
        begin
          Result:=sb.Dialogos.SBConfirmacao('Não foi possível conectar com a Base de Dados Externa!'+#13+'Deseja Continuar?')
        end
        else
         Result:=true;
  end
  else
  begin
   sb.Dialogos.sbaviso('Por favor preencha os Dados!');
   result:=false;
  end;





end;



Function TFrm_IERPInterface.GravaDadosParametrosCBL(pID_IDempInterface:integer):Boolean;
var
    strsql:string;
    moduloVnd,
    moduloRec:String;
   OmitirLinhaIVA0perc, ExportaVendas,ExportaRecibos:boolean;
Begin
If pID_IDempInterface>0 then
begin
 result:=true;


 moduloVnd:='';
 moduloRec:='';
 If CbModoloVnd.ItemIndex>-1  then
     moduloVnd:=TSBItemLista(DaItemLista(CbModoloVnd.Items, CbModoloVnd.ItemIndex)).Valor1;
 If CbModoloRec.ItemIndex>-1  then
     moduloRec:=TSBItemLista(DaItemLista(CbModoloRec.Items, CbModoloRec.ItemIndex)).Valor1;

if   ((moduloVnd='') and (moduloRec='')) then
begin
  sb.Dialogos.SBMessage('Por favor selecione o Módulo(Vendas e ou Recebimentos!)');
  result:=false;
end
else
begin
Try
 sb.SBBD.Executa('delete from ERP_CBLParametros where ID_EmpresaInteraface='+Inttostr(pID_IDempInterface));

 ExportaVendas:=cbExportaVendas.Checked;
 ExportaRecibos:=cbExportaRecibos.Checked;
 OmitirLinhaIVA0perc:=false;
 If  cbsbEnviaLinhaIVA.checked then
     OmitirLinhaIVA0perc:=cbOmitorLinhaIVA0.checked;
       
 strsql:=' INSERT INTO [ERP_CBLParametros]'
        +'   (ID_EmpresaInteraface'
        +'  ,[ID_clienteDefeito]'
        +' ,[OmiteLinhaZero]'
        +' ,[RefleteClasseIva]'
        +' ,[RefleteAnalitica]'
        +' ,[RefleteCentroCustos]'
        +' ,[diario]'
        +' ,[ReflecteClassesSelo]'
        +' ,[ReflectePlanoFuncional]'
        +' ,[ReflecteFluxos]'
        +' ,[ReflecteCOPE],ID_PagamentoCC'

        +' ,[ModuloVND]'
        +' ,[ModuloRec]'
        +' ,[RefleteClasseIvaRec]'
        +' ,[RefleteAnaliticaRec]'
        +' ,[RefleteCentroCustosRec]'
        +' ,[diarioRec]'
        +' ,[ReflecteClassesSeloRec]'
        +' ,[ReflectePlanoFuncionalRec]'
        +' ,[ReflecteFluxosRec]'
        +' ,[ReflecteCOPERec]'
        +', EnviaLinhaIVA'
        +', LoteIgualNDocumento,ConfContasPorTipoDoc,FibudebMetaData,RecNatPAGCC,RecNatPAG,'
        +'NumCasaDecimaisVL,ExcluirDocsVndAnulados,ContasPorMercado'
        +', ExportaVendas,ExportaRecibos,OmitirLinhaIVA0perc,tipoafetacao'
        +')'

        +' VALUES ('+inttostr(pID_IDempInterface)
        +' ,'+ #39+EdclienteIndeferenciadoPrimCBLTabelas.text+#39
        +' ,'+ Sb.UtilSQL.BoolToSQLStr(cbsbOmitirLinhasZero.checked)
        +' ,'+ #39+CbRefleteClassesIVA.text+#39
        +' ,'+ #39+cbRefleteAnalitica.text+#39
        +' ,'+ #39+CbCentroCustos.text+#39
        +' ,'+ #39+EdDiario.text+#39
        +' ,'+ #39+cbReflecteClassesSelo.text+#39
        +' ,'+ #39+cbReflectePlanoFuncional.text+#39
        +' ,'+ #39+cbReflecteFluxos.text+#39
        +' ,'+ #39+cbReflecteCOPE.text+#39
        +','+inttostr(eppagamentoCc.id_chave)
        +','+#39+ moduloVnd+#39
        +','+#39+ moduloRec+#39

        +' ,'+ #39+CbRefleteClassesIVARec.text+#39
        +' ,'+ #39+cbRefleteAnaliticaRec.text+#39
        +' ,'+ #39+CbCentroCustosRec.text+#39
        +' ,'+ #39+EdDiarioRec.text+#39
        +' ,'+ #39+cbReflecteClassesSeloRec.text+#39
        +' ,'+ #39+cbReflectePlanoFuncionalRec.text+#39
        +' ,'+ #39+cbReflecteFluxosRec.text+#39
        +' ,'+ #39+cbReflecteCOPERec.text+#39
        +' ,'+sb.UtilSQL.BoolToSQLStr(cbsbEnviaLinhaIVA.checked)
        +' ,'+sb.UtilSQL.BoolToSQLStr(cbsbLoteNdocumento.checked)
        +' ,'+sb.UtilSQL.BoolToSQLStr(cbConfContasPorTipodoc.checked)
        +' ,'+sb.UtilSQL.BoolToSQLStr(cbsFibudebTabMetadata.checked)
        +' ,'+ #39+CbNaturezaCC.text+#39
        +' ,'+ #39+CbNaturezaPag.text+#39
        +', '+edNcasasDecimais.text
        +' ,'+sb.UtilSQL.BoolToSQLStr(CbExcluirDocsAnulados.checked)
        +' ,'+sb.UtilSQL.BoolToSQLStr(cbContasPorMercado.checked)
        +' ,'+sb.UtilSQL.BoolToSQLStr(ExportaVendas)
        +' ,'+sb.UtilSQL.BoolToSQLStr(ExportaRecibos)
        +' ,'+sb.UtilSQL.BoolToSQLStr(OmitirLinhaIVA0perc)
        +','+inttostr(cbtipoafetacao.itemindex)


        +')';
 sb.SBBD.Executa(strsql);
// RegistoLogOperacao(1);

 except
 raise;
  result:=falsE;
 end;
end;
end;
end;


Function daIDInterface(pID_Interface:Integer):Integer;
var strsql:string;
 listcod:tsbbetabeladados;
begin
   result:=0;
   strsql:=' SELECT MAX(id) as ID'
   +' From  ERP_EMPRESAINTERFACE '
   +' where   ID_Interface='+Inttostr(pID_Interface);
   listcod:=sb.sbbd.abrirlv(strsql);
   Result:= listcod.davalor('ID').asinteger;
   listcod.Fecha;
   Freeandnil(listcod);

end;
Procedure TFrm_IERPInterface.Cfinserir;
var
  Obj :tERPBEEMPRESAINTERFACE;
  strErros :String;
  ObjItemLista :TSBItemLista;
begin
  ObjItemLista := DaItemLista(cbInterface.Items, cbInterface.ItemIndex);
  Obj := PreencheBE;

  If Assigned(Obj) Then
  Begin
    Try
     MotorERP.SB.SBBD.IniciaTransacao;
        Try

          MotorERP.ERPInterface.Actualiza(Obj, strErros);
          If strErros='' then
          If uppercase(ObjItemLista.Descricao)='ERP_CBLPROTEL' then
              GravaDadosParametrosCBL(daIDInterface(Obj.ID_interface));

        Finally
          Obj.Free;
        End;
  MotorERP.SB.SBBD.TerminaTransacao;
  Except
   MotorERP.SB.SBBD.DesfazTransacao;
    raise;
  End;
  End;
End;

Procedure TFrm_IERPInterface.Cfanular;
begin
if sb.Dialogos.SBConfirmacao('Tem a certeza que deseja remover o interface?') then
 MotorERP.ERPInterface.Remove(ValorChave);
end;



Procedure TFrm_IERPInterface.CfAlterar;
var
 strsql:string;
 BaseDadosRecepcao,
 User,
 PassWord,
 Server,
 Conexao:string;
 ID_clienteIndiferenciado:Integer;

  Obj :tERPBEEMPRESAINTERFACE;
  strErros :String;
  conexaoanterior:string;
  ObjItemLista:TSBItemLista;


Begin
 If ValidaAlteracao then
 begin
  ObjItemLista := DaItemLista(cbInterface.Items, cbInterface.ItemIndex);
  Obj:=MotorERP.ERPInterface.Edita(valorchave);
   conexaoanterior:=Obj.BDConexao;
  Obj := PreencheBE;
  Obj.id:=valorchave;

  If Assigned(Obj) Then
  Begin
    Try                                           
      Obj.EmModoEdicao := True;
      MotorERP.ERPInterface.Actualiza(Obj, strErros);
      If strErros='' then
      If uppercase(ObjItemLista.Descricao)='ERP_CBLPROTEL' then
              GravaDadosParametrosCBL(valorchave);


      If conexaoanterior<>Obj.BDConexao then
      begin

       If AbreMotorSyscontroller then
       begin
               MotorFnt.SB.SBBD.Con.Close;
               MotorFnt.SB.SBBD.Con.ConnectionString:=Obj.BDConexao;
               MotorFnt.SB.SBBD.Con.Open;
               MotorFnt.SB.SBBD.ConnectionString:=Obj.BDConexao;
               FormulariosFnt.SB.SBBD.ConnectionString:=Obj.BDConexao;
               ListasFnt.SB.SBBD.ConnectionString:=Obj.BDConexao;
       end;
      end;
    Finally
      Obj.Free;
    End
  End;


 end
 else
 begin
  FechaFormalteracao:=false;
 end;
End;


procedure TFrm_IERPInterface.FAntesAbrir(Sender: TObject);
begin
  PreencheStringList(cbInterface.Items,Motorerp.SB,'SELECT * FROM erp_interface','nomeinterface','id_interface',true);
  if  Not(Uppercase(sb.UtilizadorActual.Grupo)='MICRONET') then
     EdPassword1.PasswordChar:='*';
  If TipoOperacao=toalterar then
  begin
   cbInterface.enabled:=false;
  end;
  if MotorFnt<>nil then
  begin
      CarregaCentrosExploracao(ChLstCentroExploracoes.Items);
  end;
  PreencheHoteis;
  CarregaModulo(CbModoloVnd.items);
  CarregaModulo(CbModoloRec.items);
  tbPropriedadespms.TabVisible:=falsE;
  tbPropriedadesSyscon.TabVisible:=falsE;
  tbPropriedadescompras.TabVisible:=falsE;
  TbCBL.TabVisible:=false;
  PageOFFICE.ActivePageIndex:=0;
end;




procedure TFrm_IERPInterface.FormCreate(Sender: TObject);
begin
  inherited;
    Self.OnAntesAbrir:=FAntesAbrir;
    top:=0;
end;

procedure TFrm_IERPInterface.AdvToolBarButton1Click(Sender: TObject);
var
  conexaoString:string;
begin

  If (EDBaseDados1.Text<>'') and   (Eduser1.Text<>'') and
       (EdServer1.text<>'') and (EdPassword1.text<>'')
   then
  begin
        conexaoString:= StringConection(EdServer1.text,EDBaseDados1.Text,Eduser1.Text,EdPassword1.text);
//        Edit1.TEXT:=conexaoString;
        If TestaConexaoBDExterna(conexaoString) then
        begin
          PreencheHoteis;
          sb.Dialogos.SBMessage('Conexão á Base de dados Externa ERP, efetuada com SUCESSO!');
        end;

  end
  else
  begin
    sb.Dialogos.SBMessage('Para Efetuar o Teste de conexão:'+#13+' Por favor preencha os Dados da Base de DADOS Externa ERP!');
  end;
end;

Function   TFrm_IERPInterface.TemmovimentosExportados(pnomeinterface:string):boolean;
var
  strsql:string;
  ListaBD:Tsbbetabeladados;
begin
  Result:=false;
  If pnomeinterface='ERP_VENDASPROTEL' then
    strsql:='select * from erp_cab where origem=1'
  else
  If pnomeinterface='ERP_VENDASSYSCONTROLLER' then
    strsql:='select * from erp_cab where origem=2'
  else
  If pnomeinterface='ERP_ComprasSYSCONTROLLER' then
    strsql:='select * from ERP_CompCab '

  else
  If pnomeinterface='ERP_CBLCOMPRASFNT' then
    strsql:='select * from ERP_CBLCMPCabec '
  else
  If ((pnomeinterface='ERP_CBLVENDASFNT') or (pnomeinterface='ERP_CBLVENDASProtel'))then
    strsql:='select * from ERP_CBLCabec Where origem= '+IntTostr(Valorchave);


  If strsql<>'' then
  begin
    ListaBD:=sb.sbbd.AbrirLV(strsql);
    Try
     if not(ListaBD.Vazia) then
      result:=true;
    Finally
      ListaBD.Fecha;
      freeandnil(ListaBD);
    end;
  end;

end;

procedure TFrm_IERPInterface.FormataFormTipoInterface;
var
  ObjItemLista:TSBItemLista;
begin
      tbPropriedadespms.TabVisible:=falsE;
      tbPropriedadesSyscon.TabVisible:=falsE;
      tbPropriedadescompras.TabVisible:=falsE;

     tbInTecnicaPms.TabVisible:=false;
     tbInformacaoTecnicafnt.TabVisible:=false;
     TbInfTecCompras.TabVisible:=false;
     GrpEstados.Visible:=false;
     tbtipoexpcomp.Visible:=false;

     ObjItemLista := DaItemLista(cbInterface.Items, cbInterface.ItemIndex);
     TbCBL.TabVisible:=uppercase(ObjItemLista.Descricao)='ERP_CBLPROTEL';
  //   Grphoteis.visible:=uppercase(ObjItemLista.Descricao)='ERP_VENDASPROTEL';
     gbinventario.visible:=uppercase(ObjItemLista.Descricao)='ERP_COMPRASSYSCONTROLLER';
     tbPropriedadespms.TabVisible:= ((uppercase(ObjItemLista.Descricao)='ERP_CBLPROTEL')
                             or (uppercase(ObjItemLista.Descricao)='ERP_VENDASPROTEL'));

     tbPropriedadesSyscon.TabVisible:=((uppercase(ObjItemLista.Descricao)='ERP_VENDASSYSCONTROLLER')
                             or (uppercase(ObjItemLista.Descricao)='ERP_CBLVENDASFNT'));

     tbPropriedadescompras.TabVisible:=((uppercase(ObjItemLista.Descricao)='ERP_CBLCOMPRASFNT')
     or (uppercase(ObjItemLista.Descricao)='ERP_COMPRASSYSCONTROLLER'));



     GrpIMC.Visible:=false;
     gbsbCentroExploracao.Visible:= ((uppercase(ObjItemLista.Descricao)<>'ERP_CBLPROTEL')
                             and (uppercase(ObjItemLista.Descricao)<>'ERP_CBLVENDASFNT')
                             and (uppercase(ObjItemLista.Descricao)<>'ERP_CBLCOMPRASFNT'));

     gbclienteIndiferenciado.Visible:= ((uppercase(ObjItemLista.Descricao)<>'ERP_CBLVENDASFNT')
                                            and (uppercase(ObjItemLista.Descricao)<>'ERP_CBLCOMPRASFNT'));


   If   (uppercase(ObjItemLista.Descricao)='ERP_CBLCOMPRASFNT')or
            (uppercase(ObjItemLista.Descricao)='ERP_CBLVENDASFNT')or
                (uppercase(ObjItemLista.Descricao)='ERP_CBLPROTEL')
            then
            begin
               GrpEstados.Visible:=true;
               tbtipoexpcomp.Visible:=true;
            end;                                            

    If  ((uppercase(ObjItemLista.Descricao)='ERP_CBLVENDASFNT')
            or (uppercase(ObjItemLista.Descricao)='ERP_CBLCOMPRASFNT')) then
    begin
            GrpBd.caption:='Base de dados SysController';
            GrpIMC.Visible:=true;

    end


    else
    If uppercase(ObjItemLista.Descricao)='ERP_VENDASPROTEL' then
    begin
      gbclienteIndiferenciado.Visible:=false;
      tbInTecnicaPms.TabVisible:=true;
      tbInformacaoTecnicafnt.TabVisible:=false;
      gbsbCentroExploracao.Visible:=false;
      GrpBd.caption:='Base de dados Protel';
      
    end
    else
    If uppercase(ObjItemLista.Descricao)='ERP_VENDASSYSCONTROLLER' then
    begin
          GrpBd.caption:='Base de dados SysController';
      gbclienteIndiferenciado.Visible:=true;
      tbInTecnicaPms.TabVisible:=false;
      tbInformacaoTecnicafnt.TabVisible:=true;
      gbsbCentroExploracao.Visible:=true;
    end
    else
    If uppercase(ObjItemLista.Descricao)='ERP_COMPRASSYSCONTROLLER' then
    begin
         GrpBd.caption:='Base de dados SysController';
         GrpEstados.Visible:=true;
         TbInfTecCompras.TabVisible:=true;
         gbsbCentroExploracao.Visible:=false;
    end;

    If TemmovimentosExportados(ObjItemLista.Descricao) then
      dtdataInicio.ReadOnly:=true
    Else
    begin
        dtdataInicio.color:=clwhite;
        dtdataInicio.ReadOnly:=false;
    end;
   PreencheHoteis;

end;
procedure TFrm_IERPInterface.cbInterfaceChange(Sender: TObject);
begin
  inherited;
 if TipoOperacao=toinserir then
         FormataFormTipoInterface;
end;

Procedure TFrm_IERPInterface.LibertaMemoria;
Begin
  LimpaLista(ChLstCentroExploracoes.Items);
end;

Procedure TFrm_IERPInterface.CarregaCentrosExploracao(Items :TStrings);
Begin
try
 If   MotorFnt<>nil then
  If MotorFnt.sb<>nil then
   PreencheStringList(Items,Motorfnt.SB,'select * from tab_cenexp','vdesc','icodi');
 except
 end;  
End;

function TFrm_IERPInterface.daFiltroStr(CheckList:THTMLCheckList):String;
var
  i:Integer;
  objListaItem:TSBItemLista;
  strFiltro:String;
begin
  for i:=0 to CheckList.Items.Count-1 do
  begin
    if CheckList.Checked[i] then
    begin
      objListaItem:=TSBItemLista(CheckList.Items.Objects[i]);
      if strFiltro='' then
        strFiltro:= IntToStr(objListaItem.Chave)
      else strFiltro:= strFiltro + ','+ IntToStr(objListaItem.Chave);

    end;
  end;
  result:=strFiltro;

end;


Procedure TFrm_IERPInterface.SeleccionaOpcoesCenExP(pIDS: String);
Var

  Valor: String;
  i,id_chave: Integer;
  objListaItem:TSBItemLista;
Begin
      While (Length(pIDS) > 0) Do
      Begin
        Valor := SB.UtilStr.Da_Palavra_Ate(pids, ',');
        If Valor <> '' Then
        Begin
          ID_Chave := StrToInt(Valor);

          for i:=0 to ChLstCentroExploracoes.Items.Count-1 do
          begin
              objListaItem:=TSBItemLista(ChLstCentroExploracoes.Items.Objects[i]);
              If objListaItem.Chave=ID_Chave then
                 ChLstCentroExploracoes.Checked[i]:=true;
          End;
        end;
      end;
end;

procedure TFrm_IERPInterface.FormDestroy(Sender: TObject);
begin
  inherited;
        FrmIERPPrincipal.FormaFormInterfaces;
end;

procedure TFrm_IERPInterface.eppagamentoCcBtListaClick(Sender: TObject);
begin
  inherited;
    Listas.AbrirSQL('ListaPmsPagamentos','', eppagamentoCc, SeleccionaModosPagamentoProtel)
end;

Procedure TFrm_IERPInterface.SeleccionaModosPagamentoProtel(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        eppagamentoCc.id_chave:=Obj.Chave;
        eppagamentoCc.text:=Obj.ValorDescricao;

      End;
   Finally
     FreeAndNil(Obj);
   end;
end;
Procedure TFrm_IERPInterface.SeleccionaInterfaceIMC(Sender :TObject);
var
  Obj:TSBSelecaoLista;
Begin
  Obj := TSBSelecaoLista(Sender);
  Try
      If Assigned(Sender) Then
      Begin
        epInterface.id_chave:=Obj.Chave;
        epInterface.text:=Obj.ValorDescricao;

      End;
   Finally
     FreeAndNil(Obj);
   end;
end;

procedure TFrm_IERPInterface.DescricaoInterfaceIMC;
var
 ObjItemLista:TSBItemLista;
begin
  inherited;
    ObjItemLista := DaItemLista(cbInterface.Items, cbInterface.ItemIndex);
    If  (uppercase(ObjItemLista.Descricao)='ERP_CBLVENDASFNT') then
            epInterface.text:='ERPPrimavera_CBL_VND';
    If  (uppercase(ObjItemLista.Descricao)='ERP_CBLCOMPRASFNT') then
              epInterface.text:='ERPPrimavera_CBL_CMP';
end;

procedure TFrm_IERPInterface.epInterfaceBtListaClick(Sender: TObject);
var
 conexaoString,Filtro:string;
 ObjItemLista:TSBItemLista;
begin
  inherited;
    Filtro:='';
    ObjItemLista := DaItemLista(cbInterface.Items, cbInterface.ItemIndex);
    If  (uppercase(ObjItemLista.Descricao)='ERP_CBLVENDASFNT') then
      Filtro:= ' (Fntinterface.Nome=''ERPPrimavera_CBL_VND'')';
    If  (uppercase(ObjItemLista.Descricao)='ERP_CBLCOMPRASFNT') then
      Filtro:= '  (Fntinterface.Nome=''ERPPrimavera_CBL_CMP'')';
  conexaoString:= StringConection(EdServer1.text,EDBaseDados1.Text,Eduser1.Text,EdPassword1.text);
  If TestaConexaoBDExterna(conexaoString) then
  begin
   If Filtro<>'' then
      Listas.AbrirSQL('ListaFntInterfaceCenExp',Filtro,conexaoString, epInterface, SeleccionaInterfaceIMC)
  end;
end;


procedure TFrm_IERPInterface.PreencheHoteis;
var
  ObjItemLista:TSBItemLista;
  conexaoString:string;
begin

  If (EDBaseDados1.Text<>'') and   (Eduser1.Text<>'') and
       (EdServer1.text<>'') and (EdPassword1.text<>'')
   then
  begin
        conexaoString:= StringConection(EdServer1.text,EDBaseDados1.Text,Eduser1.Text,EdPassword1.text);
        If TestaConexaoBDExterna(conexaoString) then
        begin
           ObjItemLista := DaItemLista(cbInterface.Items, cbInterface.ItemIndex);
           If ((uppercase(ObjItemLista.Descricao)='ERP_VENDASPROTEL')
            or (uppercase(ObjItemLista.Descricao)='ERP_CBLPROTEL')) then
           begin
            if ChLstHoteis.Items.Count=0 then
            begin
                 PreencheStringListConnection(ChLstHoteis.Items,sb,'select * from '+edShema.text+'lizenz ','short','mpehotel',conexaoString,false);
            end;
           end;
        end;
  end;
end;


Procedure TFrm_IERPInterface.SeleccionaOpcoesHoteis(pIDS: String);
Var

  Valor: String;
  i,id_chave: Integer;
  objListaItem:TSBItemLista;
Begin
      While (Length(pIDS) > 0) Do
      Begin
        Valor := SB.UtilStr.Da_Palavra_Ate(pids, ',');
        If Valor <> '' Then
        Begin
          ID_Chave := StrToInt(Valor);

          for i:=0 to ChLstHoteis.Items.Count-1 do
          begin
              objListaItem:=TSBItemLista(ChLstHoteis.Items.Objects[i]);
              If objListaItem.Chave=ID_Chave then
                 ChLstHoteis.Checked[i]:=true;
          End;
        end;
      end;
end;


end.
