unit ERPDSEmpresaInterface;



Interface

Uses SBBETabelaDados, SBDSEntidade, SBBEEntidade, SBBEUpdateSQL, SBBEChaves,
ERPBEEMPRESAINTERFACE;

Type

  TERPDSEmpresaInterface=Class(TSBDSEntidade)
  Protected

     Function PreencheObjBE(ObjLista: TSBBETabelaDados): TSBBEEntidade; override;
     Procedure PreencheObjUpdateSQL(pObjBE: TSBBEEntidade; pObjUpdateSQL: TSBBEUpdateSQL); override;

  Public
    Constructor Create; override;

    Function Edita(pID: Integer): TERPBEEMPRESAINTERFACE;
     Function DAID_InterfaceActivo(pNomeInterface:string):integer;    
    Function ERPInterfaces: TERPBEEMPRESAINTERFACEs;
    Procedure Actualiza(ObjInterface: TERPBEEMPRESAINTERFACE; Erros: String);
    Procedure Remove(pID: Integer);
     Function InterfaceActivo(pNomeInterface:string): TERPBEEMPRESAINTERFACE;
    Function ExisteInterfaceActivo(pNomeInterface:string): boolean;
  End;

Implementation

Uses ERPDS, SBBEConsTipos, SysUtils, SBDSSistemaBase;


Constructor TERPDSEmpresaInterface.Create;
Begin            
  inherited;
                     
  Tabela := 'ERP_EMPRESAINTERFACE';
  ChaveNome := 'ID';
  Titulo:= 'ERP_EMPRESAINTERFACE';
  AtributoDescricao := 'ID_Interface';
  ChaveTipoDados := tdInteger;
  BEEntidadeClass := TERPBEEMPRESAINTERFACE;
End;

Function TERPDSEmpresaInterface.PreencheObjBE(ObjLista: TSBBETabelaDados): TSBBEEntidade;
Begin
  Result := TERPBEEMPRESAINTERFACE.Create;

  With TERPBEEMPRESAINTERFACE(Result) Do
  Begin
    ID := ObjLista.DaValor('ID').AsInteger;
    ID_Interface := ObjLista.DaValor('ID_Interface').AsInteger;
    BDServidor := ObjLista.DaValor('BDServidor').asstring;
    BDUSER := ObjLista.DaValor('BDUSER').asstring;
    BDNOME := ObjLista.DaValor('BDNOME').asstring;
    BDConexao := ObjLista.DaValor('BDConexao').asstring;
    BDPASSWORD:= ObjLista.DaValor('BDPASSWORD').asstring;
    BDSchema:= ObjLista.DaValor('BDSchema').asstring;
    IDSCentrosExploracao:= ObjLista.DaValor('IDSCentrosExploracao').asstring;
    IDSHoteis := ObjLista.DaValor('IDSHoteis').asstring;

    Ativo := ObjLista.DaValor('Ativo').asBoolean;
    ID_clienteIndiferenciado:= ObjLista.DaValor('ID_clienteIndiferenciado').asstring;
    PrefixoContCblAartigo:= ObjLista.DaValor('PrefixoContCblAartigo').asstring;
    ExpApenasComprasFechadas := ObjLista.DaValor('ExpApenasComprasFechadas').asBoolean;
    DATAInicioExportacao := ObjLista.DaValor('DATAInicioExportacao').asdatetime;

    Descricao:= ObjLista.DaValor('Descricao').asstring;
    ID_InterfaceIMC:= ObjLista.DaValor('ID_InterfaceIMC').AsInteger;
    PeriodoIVA:= ObjLista.DaValor('PeriodoIVA').AsInteger;
    NomeInterface:= TERPDS(DSO).SB.daValorAtributo('ERP_INTERFACE','ID_Interface',ID_Interface,'Nomeinterface').asstring;

    DATAUltimaExportacao := ObjLista.DaValor('DATAUltimaExportacao').asdatetime;
    TipoPeriodExportacao:= ObjLista.DaValor('TipoPeriodExportacao').AsInteger;

    TipoCtrlCodClienteCC:= ObjLista.DaValor('TipoCtrlCodClienteCC').AsInteger;
    ID_PagamentoCC:= ObjLista.DaValor('ID_PagamentoCC').AsInteger;
    ExpInventarioAgrpArmProd:= ObjLista.DaValor('ExpInventarioAgrpArmProd').AsBoolean;

    DataIniExpEncomendas:= ObjLista.DaValor('DataIniExpEncomendas').asdatetime;
    ExpEncomendas:=    ObjLista.DaValor('ExpEncomendas').AsBoolean;

    DataIniExpAdiantamentosPMS:= ObjLista.DaValor('DataIniExpAdiantamentosPMS').asdatetime;
    ExportaAdiantamentosPMS:=    ObjLista.DaValor('exportaAdiantamentosPMS').AsBoolean;
    Namelinkedserver:=    ObjLista.DaValor('Namelinkedserver').Asstring;

    ObgLinhaContaERPProd:= ObjLista.DaValor('ObgLinhaContaERPProd').AsBoolean;
    ObgLinhaContaERPIVA:= ObjLista.DaValor('ObgLinhaContaERPIVA').AsBoolean;
    ObgLinhaContaERPAreaNeg:= ObjLista.DaValor('ObgLinhaContaERPAreaNeg').AsBoolean;
    ObgLinhaContaERPModPag:= ObjLista.DaValor('ObgLinhaContaERPModPag').AsBoolean;
    ObgContaERPCliente:= ObjLista.DaValor('ObgContaERPCliente').AsBoolean;
    NaoParaInterfaceAutCompras:= ObjLista.DaValor('NaoParaInterfaceAutCompras').AsBoolean;
    Origem:= ObjLista.DaValor('Origem').AsInteger;



  End;

End;

Procedure TERPDSEmpresaInterface.PreencheObjUpdateSQL(pObjBE: TSBBEEntidade; pObjUpdateSQL: TSBBEUpdateSQL);
Begin
  With TERPBEEMPRESAINTERFACE(pObjBE) Do
  Begin
    If emmodoedicao then
            pObjUpdateSQL.Adiciona('ID', ID, tdInteger, True);
    pObjUpdateSQL.Adiciona('ID_Interface', ID_Interface, tdInteger, True);
    pObjUpdateSQL.Adiciona('BDServidor', BDServidor,TdString);
    pObjUpdateSQL.Adiciona('BDUSER', BDUSER,TdString);
    pObjUpdateSQL.Adiciona('BDNOME', BDNOME,TdString);
    pObjUpdateSQL.Adiciona('BDConexao', BDConexao,TdString);
    pObjUpdateSQL.Adiciona('BDPASSWORD', BDPASSWORD,TdString);
    pObjUpdateSQL.Adiciona('BDSchema', BDSchema,TdString);
    pObjUpdateSQL.Adiciona('IDSCentrosExploracao', IDSCentrosExploracao,TdString);
    pObjUpdateSQL.Adiciona('IDSHoteis', IDSHoteis,TdString);



    pObjUpdateSQL.Adiciona('Ativo', Ativo,TdBoolean);
    pObjUpdateSQL.Adiciona('ID_clienteIndiferenciado', ID_clienteIndiferenciado,TdString);
    pObjUpdateSQL.Adiciona('PrefixoContCblAartigo', PrefixoContCblAartigo,TdString);
    pObjUpdateSQL.Adiciona('ExpApenasComprasFechadas', ExpApenasComprasFechadas,TdBoolean);
    pObjUpdateSQL.Adiciona('DATAInicioExportacao', DATAInicioExportacao,tdData);

    pObjUpdateSQL.Adiciona('ID_InterfaceIMC', ID_InterfaceIMC,Tdinteger,false,tcce);
    pObjUpdateSQL.Adiciona('Descricao', Descricao,TdString);
    pObjUpdateSQL.Adiciona('PeriodoIVA', PeriodoIVA,Tdinteger);

    pObjUpdateSQL.Adiciona('TipoPeriodExportacao', TipoPeriodExportacao,Tdinteger);
    pObjUpdateSQL.Adiciona('TipoCtrlCodClienteCC', TipoCtrlCodClienteCC,Tdinteger);
    pObjUpdateSQL.Adiciona('ID_PagamentoCC', ID_PagamentoCC,Tdinteger);
    pObjUpdateSQL.Adiciona('ExpInventarioAgrpArmProd', ExpInventarioAgrpArmProd,TdBoolean);

    pObjUpdateSQL.Adiciona('ExpEncomendas', ExpEncomendas,TdBoolean);
    pObjUpdateSQL.Adiciona('DataIniExpEncomendas', DataIniExpEncomendas,tdData);


    pObjUpdateSQL.Adiciona('ExportaAdiantamentosPMS', ExportaAdiantamentosPMS,TdBoolean);
    pObjUpdateSQL.Adiciona('DataIniExpAdiantamentosPMS', DataIniExpAdiantamentosPMS,tdData);
    pObjUpdateSQL.Adiciona('Namelinkedserver', Namelinkedserver,TdString);

    pObjUpdateSQL.Adiciona('ObgLinhaContaERPProd', ObgLinhaContaERPProd,TdBoolean);
    pObjUpdateSQL.Adiciona('ObgLinhaContaERPIVA', ObgLinhaContaERPIVA,TdBoolean);
    pObjUpdateSQL.Adiciona('ObgLinhaContaERPAreaNeg', ObgLinhaContaERPAreaNeg,TdBoolean);
    pObjUpdateSQL.Adiciona('ObgLinhaContaERPModPag', ObgLinhaContaERPModPag,TdBoolean);
    pObjUpdateSQL.Adiciona('ObgContaERPCliente', ObgContaERPCliente,TdBoolean);
    pObjUpdateSQL.Adiciona('NaoParaInterfaceAutCompras', NaoParaInterfaceAutCompras,TdBoolean);
    pObjUpdateSQL.Adiciona('Origem', Origem,Tdinteger);



  End;
End;

Procedure TERPDSEmpresaInterface.Actualiza(ObjInterface: TERPBEEMPRESAINTERFACE; Erros: String);
Begin
  Inherited Actualiza(ObjInterface, Erros);
End;

Function TERPDSEmpresaInterface.Edita(pID: Integer): TERPBEEMPRESAINTERFACE;
var
  ObjChaves: TSBBEChaves;
begin
  ObjChaves := TSBBEChaves.Create;

  Try 
    ObjChaves.Adiciona('ID', pID);

    Result := TERPBEEMPRESAINTERFACE(inherited Edita(ObjChaves,'*'));
  Finally
    ObjChaves.Free;
  End;
End;

Function TERPDSEmpresaInterface.ERPInterfaces: TERPBEEMPRESAINTERFACEs;
Begin
  Result := TERPBEEMPRESAINTERFACEs.Create;
  ListaBE(Result);
End;

Procedure TERPDSEmpresaInterface.Remove(pID: Integer);
var
  ObjChaves :TSBBEChaves;
Begin
  ObjChaves := TSBBEChaves.Create;
  Try
    ObjChaves.Adiciona('ID', pID);

    inherited Remove(ObjChaves);
  Finally
    ObjChaves.Free;
  End;
End;



Function TERPDSEmpresaInterface.ExisteInterfaceActivo(pNomeInterface:string): boolean;
 var  ID_InternoInterface:integer;
begin
  Result:=false;
  ID_InternoInterface:=DAID_InterfaceActivo(pNomeInterface);
  If   ID_InternoInterface>0 then
  Begin
   Result:=true;
  end;
end;
Function TERPDSEmpresaInterface.DAID_InterfaceActivo(pNomeInterface:string):integer;
var
  Lista:TSBBETabelaDados;
  StrSql:String;
Begin
  Result:=0;
  StrSql:='SELECT ERP_EMPRESAINTERFACE.ID'
        +'  FROM ERP_EMPRESAINTERFACE'
        +'    inner join ERP_Interface on ERP_Interface.id_interface='
        +'    ERP_EMPRESAINTERFACE.ID_Interface'
        +'  where [ERP_Interface].NomeInterface='+TErpds(dso).sb.UtilSQL.StrToSQLStr(pNomeInterface)
        +'  and ERP_EMPRESAINTERFACE.Ativo=1';
  Lista:=TERPDS(DSO).SB.SBBD.AbrirLV(strSQL);
  Try
   If not(Lista.vazia)then
     Result:=Lista.davalor('ID').asinteger;
  Finally
    FreeAndnil(Lista);
  end;

End;


Function TERPDSEmpresaInterface.InterfaceActivo(pNomeInterface:string): TERPBEEMPRESAINTERFACE;
var
  ObjChaves: TSBBEChaves;
  ID_InternoInterface:integer;
begin
  Result:=nil;
  ID_InternoInterface:=DAID_InterfaceActivo(pNomeInterface);
  If   ID_InternoInterface>0 then
  Begin
    ObjChaves := TSBBEChaves.Create;
    Try
      ObjChaves.Adiciona('ID', ID_InternoInterface);
      Result := TERPBEEMPRESAINTERFACE(inherited Edita(ObjChaves,'*'));
      Result.ID:=ID_InternoInterface;
    Finally
      ObjChaves.Free;
    End;
  end;
End;


End.

