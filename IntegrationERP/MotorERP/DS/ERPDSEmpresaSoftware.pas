
Unit ERPDSEmpresaSoftware;

Interface

Uses SBBETabelaDados, SBDSEntidade, SBBEEntidade, SBBEUpdateSQL, SBBEChaves, ERPBEEmpresaSoftware;

Type

  TERPDSEmpresaSoftware=Class(TSBDSEntidade)
  Protected

     Function PreencheObjBE(ObjLista: TSBBETabelaDados): TSBBEEntidade; override;
     Procedure PreencheObjUpdateSQL(pObjBE: TSBBEEntidade; pObjUpdateSQL: TSBBEUpdateSQL); override;

  Public
    Constructor Create; override;

    Function Edita(pID_Empresa: Integer): TERPBEEmpresaSoftware;
    Function EmpresasSoftware: TERPBEEmpresasSoftware;
    Procedure Actualiza(ObjEmpresaSoftware: TERPBEEmpresaSoftware; Erros: String);
    Procedure Remove(pID_Empresa: Integer);
    Function DaID_Empresa:integer;

  End;

Implementation

Uses ERPDS, SBBEConsTipos, SysUtils;


Constructor TERPDSEmpresaSoftware.Create;
Begin
  inherited;

  Tabela := 'EmpresaSoftware';
  ChaveNome := 'ID_Empresa';
  Titulo:= 'Empresa Software';
  AtributoDescricao := '';
  ChaveTipoDados := tdInteger;
  BEEntidadeClass := TERPBEEmpresaSoftware;
End;

Function TERPDSEmpresaSoftware.PreencheObjBE(ObjLista: TSBBETabelaDados): TSBBEEntidade;
Begin
  Result := TERPBEEmpresaSoftware.Create;

  With TERPBEEmpresaSoftware(Result) Do
  Begin
    ID_Empresa := ObjLista.DaValor('ID_Empresa').AsInteger;
    Nome := ObjLista.DaValor('Nome').AsString;
    Morada := ObjLista.DaValor('Morada').AsString;
    CodigoPostal := ObjLista.DaValor('CodigoPostal').AsString;
    Rua := ObjLista.DaValor('Rua').AsString;
    Localidade := ObjLista.DaValor('Localidade').AsString;
    ID_Distrito := ObjLista.DaValor('ID_Distrito').AsInteger;
    NIPC := ObjLista.DaValor('NIPC').AsString;
    CapitalSocial := ObjLista.DaValor('CapitalSocial').asFloat;
    Telefone := ObjLista.DaValor('Telefone').AsString;
    Fax := ObjLista.DaValor('Fax').AsString;
    Telemovel := ObjLista.DaValor('Telemovel').AsString;
    MatriculaCRC := ObjLista.DaValor('MatriculaCRC').AsString;
    TelemovelProprietario := ObjLista.DaValor('TelemovelProprietario').AsString;
    NomeProprietario := ObjLista.DaValor('NomeProprietario').AsString;
    MoradaProprietario := ObjLista.DaValor('MoradaProprietario').AsString;
    ID_DistritoProprietario := ObjLista.DaValor('ID_DistritoProprietario').AsInteger;
    CodigoPostalProprietario := ObjLista.DaValor('CodigoPostalProprietario').AsString;
    RuaProprietario := ObjLista.DaValor('RuaProprietario').AsString;
    LocalidadeProprietario := ObjLista.DaValor('LocalidadeProprietario').AsString;
    TelefoneProprietario := ObjLista.DaValor('TelefoneProprietario').AsString;
    FaxProprietario := ObjLista.DaValor('FaxProprietario').AsString;
    DataTrabalho := ObjLista.DaValor('DataTrabalho').AsDateTime;
    IDG_Anexo := ObjLista.DaValor('IDG_Anexo').AsString;
    PathAplicacoes := ObjLista.DaValor('PathAplicacoes').AsString;
    PathLicenca := ObjLista.DaValor('PathLicenca').AsString;

    Certificado := ObjLista.DaValor('Certificado').AsString;
    NomeProduto := ObjLista.DaValor('NomeProduto').AsString;
    VersaoProduto := ObjLista.DaValor('VersaoProduto').AsString;





  End;
End;

Procedure TERPDSEmpresaSoftware.PreencheObjUpdateSQL(pObjBE: TSBBEEntidade; pObjUpdateSQL: TSBBEUpdateSQL);
Begin
  With TERPBEEmpresaSoftware(pObjBE) Do
  Begin
    pObjUpdateSQL.Adiciona('ID_Empresa', ID_Empresa, tdInteger, True);
    pObjUpdateSQL.Adiciona('Nome', Nome, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('Morada', Morada, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('CodigoPostal', CodigoPostal, tdString,false,TCCE);;
    pObjUpdateSQL.Adiciona('Rua', Rua, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('Localidade', Localidade, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('ID_Distrito', ID_Distrito, tdInteger,false,TCCE);
    pObjUpdateSQL.Adiciona('NIPC', NIPC, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('CapitalSocial', CapitalSocial,tdextended);
    pObjUpdateSQL.Adiciona('Telefone', Telefone, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('Fax', Fax, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('Telemovel', Telemovel, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('MatriculaCRC', MatriculaCRC, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('TelemovelProprietario', TelemovelProprietario, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('NomeProprietario', NomeProprietario, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('MoradaProprietario', MoradaProprietario, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('ID_DistritoProprietario', ID_DistritoProprietario, tdInteger,false,TCCE);
    pObjUpdateSQL.Adiciona('CodigoPostalProprietario', CodigoPostalProprietario, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('RuaProprietario', RuaProprietario, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('LocalidadeProprietario', LocalidadeProprietario, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('TelefoneProprietario', TelefoneProprietario, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('FaxProprietario', FaxProprietario, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('DataTrabalho', DataTrabalho, tdDataHora,false,TCCE);
    pObjUpdateSQL.Adiciona('IDG_Anexo', IDG_Anexo, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('PathAplicacoes', PathAplicacoes, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('PathLicenca', PathLicenca, tdString,false,TCCE);


    pObjUpdateSQL.Adiciona('Certificado', Certificado, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('NomeProduto', NomeProduto, tdString,false,TCCE);
    pObjUpdateSQL.Adiciona('VersaoProduto', VersaoProduto, tdString,false,TCCE);

  End;
End;

Procedure TERPDSEmpresaSoftware.Actualiza(ObjEmpresaSoftware: TERPBEEmpresaSoftware; Erros: String);
Begin
  Inherited Actualiza(ObjEmpresaSoftware, Erros);
End;

Function TERPDSEmpresaSoftware.Edita(pID_Empresa: Integer): TERPBEEmpresaSoftware;
var
  ObjChaves: TSBBEChaves;
begin
  ObjChaves := TSBBEChaves.Create;

  Try
    ObjChaves.Adiciona('ID_Empresa', pID_Empresa);

    Result := TERPBEEmpresaSoftware(inherited Edita(ObjChaves,'*'));
  Finally
    ObjChaves.Free;
  End;
End;

Function TERPDSEmpresaSoftware.EmpresasSoftware: TERPBEEmpresasSoftware;
Begin
  Result := TERPBEEmpresasSoftware.Create;
  ListaBE(Result);
End;

Procedure TERPDSEmpresaSoftware.Remove(pID_Empresa: Integer);
var
  ObjChaves :TSBBEChaves;
Begin
  ObjChaves := TSBBEChaves.Create;
  Try
    ObjChaves.Adiciona('ID_Empresa', pID_Empresa);

    inherited Remove(ObjChaves);
  Finally
    ObjChaves.Free;
  End;
End;

Function TERPDSEmpresaSoftware.DaID_Empresa:integer;
var
   Lista:TSBBETabeladados;
   StrSql:string;
Begin
    Result:=-1;
    StrSql:='Select ID_empresa from empresaSoftware' ;
    Lista:=TERPDS(DSO).SB.SBBD.AbrirLV(strSQL);
    Try
     Result:= Lista.davalor('ID_Empresa').asinteger;
    Finally
      FreeAndnil(Lista);
    end;
End;
End.

