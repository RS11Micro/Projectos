unit ERPBEEmpresaSoftware;



interface

Uses SBBEEntidade,SBBEListaObjAbs, vcl.Controls;
Type
  TERPBEEmpresaSoftware=Class(TSBBEEntidade)
  private
    FID_Empresa: Integer;
    FNome: String;
    FMorada: String;
    FCodigoPostal: String;
    FRua: String;
    FLocalidade: String;
    FID_Distrito: Integer;
    FNIPC: String;
    FCapitalSocial:extended ;
    FTelefone: String;
    FFax: String;
    FTelemovel: String;
    FMatriculaCRC: String;
    FTelemovelProprietario: String;
    FNomeProprietario: String;
    FMoradaProprietario: String;
    FID_DistritoProprietario: Integer;
    FCodigoPostalProprietario: String;
    FRuaProprietario: String;
    FLocalidadeProprietario: String;
    FTelefoneProprietario: String;
    FFaxProprietario: String;
    FDataTrabalho: TDateTime;
    FIDG_Anexo: String;
    FPathAplicacoes: String;
    FPathLicenca: String;
    FCertificado: String;
    FNomeProduto: String;
    FVersaoProduto: String;



  Published
    Property ID_Empresa: Integer Read FID_Empresa Write FID_Empresa;
    Property Nome: String Read FNome Write FNome;
    Property Morada: String Read FMorada Write FMorada;
    Property CodigoPostal: String Read FCodigoPostal Write FCodigoPostal;
    Property Rua: String Read FRua Write FRua;
    Property Localidade: String Read FLocalidade Write FLocalidade;
    Property ID_Distrito: Integer Read FID_Distrito Write FID_Distrito;
    Property NIPC: String Read FNIPC Write FNIPC;
    Property CapitalSocial: extended Read FCapitalSocial Write FCapitalSocial;
    Property Telefone: String Read FTelefone Write FTelefone;
    Property Fax: String Read FFax Write FFax;
    Property Telemovel: String Read FTelemovel Write FTelemovel;
    Property MatriculaCRC: String Read FMatriculaCRC Write FMatriculaCRC;
    Property TelemovelProprietario: String Read FTelemovelProprietario Write FTelemovelProprietario;
    Property NomeProprietario: String Read FNomeProprietario Write FNomeProprietario;
    Property MoradaProprietario: String Read FMoradaProprietario Write FMoradaProprietario;
    Property ID_DistritoProprietario: Integer Read FID_DistritoProprietario Write FID_DistritoProprietario;
    Property CodigoPostalProprietario: String Read FCodigoPostalProprietario Write FCodigoPostalProprietario;
    Property RuaProprietario: String Read FRuaProprietario Write FRuaProprietario;
    Property LocalidadeProprietario: String Read FLocalidadeProprietario Write FLocalidadeProprietario;
    Property TelefoneProprietario: String Read FTelefoneProprietario Write FTelefoneProprietario;
    Property FaxProprietario: String Read FFaxProprietario Write FFaxProprietario;
    Property DataTrabalho: TDateTime Read FDataTrabalho Write FDataTrabalho;
    Property IDG_Anexo: String Read FIDG_Anexo Write FIDG_Anexo;
    Property PathAplicacoes: String Read FPathAplicacoes Write FPathAplicacoes;
    Property PathLicenca: String Read FPathLicenca Write FPathLicenca;
    Property Certificado: String Read FCertificado Write FCertificado;
    Property NomeProduto: String Read FNomeProduto Write FNomeProduto;
    Property VersaoProduto: String Read FVersaoProduto Write FVersaoProduto;


  End;

  TERPBEEmpresasSoftware= Class(TSBBEEntidades)
    Private
      Function GetEmpresaSoftwareIdx(Idx :LongInt): TERPBEEmpresaSoftware;
      Function GetEmpresaSoftware(pID_Empresa: Integer): TERPBEEmpresaSoftware;

    Public
      Procedure Adiciona(pObjEmpresaSoftware: TERPBEEmpresaSoftware);
      Procedure Remove(pID_Empresa: Integer);

      Property Elem[Idx :Longint]: TERPBEEmpresaSoftware Read GetEmpresaSoftwareIdx;
      Property EmpresaSoftware[pID_Empresa: Integer]: TERPBEEmpresaSoftware Read GetEmpresaSoftware;
  End;

Implementation

Function TERPBEEmpresasSoftware.GetEmpresaSoftwareIdx(Idx :LongInt): TERPBEEmpresaSoftware;
Begin
  If Idx < Self.Num  Then
    Result := TERPBEEmpresaSoftware(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TERPBEEmpresasSoftware.Adiciona(pObjEmpresaSoftware: TERPBEEmpresaSoftware);
Begin
  Self.AdicionaObj(pObjEmpresaSoftware);
End;

Function TERPBEEmpresasSoftware.GetEmpresaSoftware(pID_Empresa: Integer): TERPBEEmpresaSoftware;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjEmpresaSoftware: TERPBEEmpresaSoftware;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjEmpresaSoftware := TERPBEEmpresaSoftware(Elemento[Posicao]);

    If (ObjEmpresaSoftware.ID_Empresa = pID_Empresa) Then
      Result := ObjEmpresaSoftware;

    Inc(Posicao);
  End;
End;

Procedure TERPBEEmpresasSoftware.Remove(pID_Empresa: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjEmpresaSoftware: TERPBEEmpresaSoftware;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjEmpresaSoftware := TERPBEEmpresaSoftware(Elemento[Posicao]);

    If (ObjEmpresaSoftware.ID_Empresa = pID_Empresa) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
