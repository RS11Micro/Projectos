unit sysCERTDSINTERFACE;

Interface

Uses SBBETabelaDados, SBDSEntidade, SBBEEntidade, SBBEUpdateSQL, SBBEChaves, sysCERTBEINTERFACE,ERPBETipoCons;

Type

  TsysCERTDSINTERFACE=Class(TSBDSEntidade)
  Protected

     Function PreencheObjBE(ObjLista: TSBBETabelaDados): TSBBEEntidade; override;
     Procedure PreencheObjUpdateSQL(pObjBE: TSBBEEntidade; pObjUpdateSQL: TSBBEUpdateSQL); override;

  Public
    Constructor Create; override;

    Function Edita(pID: Integer): TsysCERTBEINTERFACE;
    Function Interfaces: tsysCERTBEINTERFACES;
    Procedure Actualiza(ObjInterface: TsysCERTBEINTERFACE; Erros: String);
    Procedure Remove(pID_Interface: Integer);


  End;

Implementation

Uses ERPDS, SBBEConsTipos, SysUtils;


Constructor TsysCERTDSINTERFACE.Create;
Begin
  inherited;

  Tabela := 'INTERFACE';
  ChaveNome := 'ID';
  Titulo:= 'INTERFACE';
  AtributoDescricao := 'Descricao';
  ChaveTipoDados := tdInteger;
  BEEntidadeClass := tsysCERTBEINTERFACE;
End;

Function TsysCERTDSINTERFACE.PreencheObjBE(ObjLista: TSBBETabelaDados): TSBBEEntidade;
Begin

  Result := tsysCERTBEINTERFACE.Create;

  With tsysCERTBEINTERFACE(Result) Do
  Begin
    ID := ObjLista.DaValor('ID').AsInteger;
    ID_Interface := ObjLista.DaValor('ID_Interface').AsInteger;
    BDServidor := ObjLista.DaValor('BDServidor').asstring;
    BDUSER := ObjLista.DaValor('BDUSER').asstring;
    BDNOME := ObjLista.DaValor('BDNOME').asstring;
    BDConexao := ObjLista.DaValor('BDConexao').asstring;
    BDPASSWORD:= ObjLista.DaValor('BDPASSWORD').asstring;
    BDSchema:= ObjLista.DaValor('BDSchema').asstring;

    Ativo := ObjLista.DaValor('Ativo').asBoolean;
    TipoRegistoDados:=BD2TipoRegistoDados(ObjLista.DaValor('TipoRegistoDados').asinteger);
    TipoProjecto:=BD2TipoProjecto(ObjLista.DaValor('TipoProjecto').asinteger);

    CaminhoXML:=ObjLista.DaValor('CaminhoXML').asstring;
    CaminhoXMLSaphety:=ObjLista.DaValor('CaminhoXMLSaphety').asstring;
    CaminhoPDF:=ObjLista.DaValor('CaminhoPDF').asstring;
    MapaNomeFisicoFT:=ObjLista.DaValor('MapaNomeFisicoFT').asstring;
    MapaNomeFisicoNC:=ObjLista.DaValor('MapaNomeFisicoNC').asstring;
    Descricao:=ObjLista.DaValor('Descricao').asstring;
    DATAInicioExportacao:=ObjLista.DaValor('DATAInicioExportacao').asDatetime;
    TipoExportacao:= ObjLista.DaValor('TipoExportacao').Asinteger;
    AdditionalDocRef:= ObjLista.DaValor('AdditionalDocRef').asboolean;

    BrokerYet:= ObjLista.DaValor('BrokerYet').asboolean;
    BrokerSaphety:= ObjLista.DaValor('BrokerSaphety').asboolean;
    CiusPTPDFBS64:= ObjLista.DaValor('CiusPTPDFBS64').asboolean;

  End;

End;

Procedure TsysCERTDSINTERFACE.PreencheObjUpdateSQL(pObjBE: TSBBEEntidade; pObjUpdateSQL: TSBBEUpdateSQL);
Begin

    With tsysCERTBEINTERFACE(pObjBE) Do
  Begin
    If emmodoedicao then
            pObjUpdateSQL.Adiciona('ID', ID, tdInteger, True);
    pObjUpdateSQL.Adiciona('ID_Interface', ID_Interface, tdInteger, false);
    pObjUpdateSQL.Adiciona('BDServidor', BDServidor,TdString);
    pObjUpdateSQL.Adiciona('BDUSER', BDUSER,TdString);
    pObjUpdateSQL.Adiciona('BDNOME', BDNOME,TdString);
    pObjUpdateSQL.Adiciona('BDConexao', BDConexao,TdString);
    pObjUpdateSQL.Adiciona('BDPASSWORD', BDPASSWORD,TdString);
    pObjUpdateSQL.Adiciona('BDSchema', BDSchema,TdString);
    pObjUpdateSQL.Adiciona('Ativo', Ativo,TdBoolean);
    pObjUpdateSQL.Adiciona('TipoRegistoDados', ord(TipoRegistoDados),TdInteger);
    pObjUpdateSQL.Adiciona('TipoProjecto',  ord(TipoProjecto),TdInteger);
    pObjUpdateSQL.Adiciona('CaminhoXML', CaminhoXML,TdString);
    pObjUpdateSQL.Adiciona('CaminhoXMLSaphety', CaminhoXMLSaphety,TdString);

    pObjUpdateSQL.Adiciona('CaminhoPDF', CaminhoPDF,TdString);
    pObjUpdateSQL.Adiciona('Descricao', Descricao,TdString);
    pObjUpdateSQL.Adiciona('MapaNomeFisicoFT', MapaNomeFisicoFT,TdString);
    pObjUpdateSQL.Adiciona('MapaNomeFisicoNC', MapaNomeFisicoNC,TdString);
    pObjUpdateSQL.Adiciona('AdditionalDocRef', AdditionalDocRef,TdString);
    pObjUpdateSQL.Adiciona('DATAInicioExportacao', DATAInicioExportacao,tdData);
    pObjUpdateSQL.Adiciona('TipoExportacao', TipoExportacao,tdinteger);
    pObjUpdateSQL.Adiciona('BrokerYet', BrokerYet,TdBoolean);
    pObjUpdateSQL.Adiciona('BrokerSaphety', BrokerSaphety,TdBoolean);
    pObjUpdateSQL.Adiciona('CiusPTPDFBS64', CiusPTPDFBS64,TdBoolean);



  End;

End;

Procedure TsysCERTDSINTERFACE.Actualiza(ObjInterface: TsysCERTBEINTERFACE; Erros: String);
Begin
  Inherited Actualiza(ObjInterface, Erros);
End;

Function TsysCERTDSINTERFACE.Edita(pID: Integer): TsysCERTBEINTERFACE;
var
  ObjChaves: TSBBEChaves;
begin
  ObjChaves := TSBBEChaves.Create;

  Try
    ObjChaves.Adiciona('ID', pID);

    Result := TsysCERTBEINTERFACE(inherited Edita(ObjChaves,'*'));
  Finally
    ObjChaves.Free;
  End;
End;

Function TsysCERTDSINTERFACE.Interfaces: tsysCERTBEINTERFACES;
Begin
  Result := tsysCERTBEINTERFACES.Create;
  ListaBE(Result);
End;

Procedure TsysCERTDSINTERFACE.Remove(pID_InTerface: Integer);
var
  ObjChaves :TSBBEChaves;
Begin
  ObjChaves := TSBBEChaves.Create;
  Try
    ObjChaves.Adiciona('ID_InTerface', pID_InTerface);

    inherited Remove(ObjChaves);
  Finally
    ObjChaves.Free;
  End;
End;

end.

