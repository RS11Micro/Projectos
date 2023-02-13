unit ERPDSAreaNegocio;

Interface
Uses SBBETabelaDados, SBDSEntidade, SBBEEntidade, SBBEUpdateSQL, SBBEChaves,
ERPBEAreaNegocio;

Type

  TERPDSAreaNegocio=Class(TSBDSEntidade)
  Protected
     Function PreencheObjBE(ObjLista: TSBBETabelaDados): TSBBEEntidade; override;
     Procedure PreencheObjUpdateSQL(pObjBE: TSBBEEntidade; pObjUpdateSQL: TSBBEUpdateSQL); override;

  Public
    Constructor Create; override;

    Function Edita(pID_AreaNegocio: Integer): TERPBEAreaNegocio;
    Function ERPAreasNegocio: TERPBEAreasNegocio;
    Procedure Actualiza(ObjInterface: TERPBEAreaNegocio; Erros: String);
    Procedure Remove(pID_AreaNegocio: Integer);
  End;

Implementation

Uses ERPDS, SBBEConsTipos, SysUtils, SBDSSistemaBase;


Constructor TERPDSAreaNegocio.Create;
Begin            
  inherited;
                         
  Tabela := 'ERP_AreaNegocio';
  ChaveNome := 'ID_areanegocio';
  Titulo:= 'ERP_AreaNegocio';
  AtributoDescricao := 'DescricaoArea';
  ChaveTipoDados := tdInteger;
  BEEntidadeClass := TERPBEAreaNegocio;
End;

Function TERPDSAreaNegocio.PreencheObjBE(ObjLista: TSBBETabelaDados): TSBBEEntidade;
Begin
  Result := TERPBEAreaNegocio.Create;

  With TERPBEAreaNegocio(Result) Do
  Begin
    ID_AreaNegocio := ObjLista.DaValor('ID_AreaNegocio').AsInteger;
    DescricaoArea := ObjLista.DaValor('DescricaoArea').asstring;
    ContaERP := ObjLista.DaValor('ContaERP').asstring;

  End;

End;

Procedure TERPDSAreaNegocio.PreencheObjUpdateSQL(pObjBE: TSBBEEntidade; pObjUpdateSQL: TSBBEUpdateSQL);
Begin
  With TERPBEAreaNegocio(pObjBE) Do
  Begin

    pObjUpdateSQL.Adiciona('ID_AreaNegocio', ID_AreaNegocio, tdInteger, True);
    pObjUpdateSQL.Adiciona('DescricaoArea', DescricaoArea,TdString);
    pObjUpdateSQL.Adiciona('ContaERP', ContaERP,TdString);




  End;
End;

Procedure TERPDSAreaNegocio.Actualiza(ObjInterface: TERPBEAreaNegocio; Erros: String);
Begin
  Inherited Actualiza(ObjInterface, Erros);
End;

Function TERPDSAreaNegocio.Edita(pID_AreaNegocio: Integer): TERPBEAreaNegocio;
var
  ObjChaves: TSBBEChaves;
begin
  ObjChaves := TSBBEChaves.Create;

  Try 
    ObjChaves.Adiciona('ID_AreaNegocio', pID_AreaNegocio);

    Result := TERPBEAreaNegocio(inherited Edita(ObjChaves,'*'));
  Finally
    ObjChaves.Free;
  End;
End;

Function TERPDSAreaNegocio.ERPAreasNegocio: TERPBEAreasNegocio;
Begin
  Result := TERPBEAreasNegocio.Create;
  ListaBE(Result);
End;

Procedure TERPDSAreaNegocio.Remove(pID_AreaNegocio: Integer);
var
  ObjChaves :TSBBEChaves;
Begin
  ObjChaves := TSBBEChaves.Create;
  Try
    ObjChaves.Adiciona('ID_AreaNegocio', pID_AreaNegocio);

    inherited Remove(ObjChaves);
  Finally
    ObjChaves.Free;
  End;
End;







End.

