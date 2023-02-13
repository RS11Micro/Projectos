unit ERPBSAreaNegocio;


Interface
Uses  SBBSEntidade,ERPBEAreaNegocio;

Type

  TERPBSAreaNegocio=Class(TSBBSEntidade)
  Public
    Function Edita(pID: Integer): TERPBEAreaNegocio;
    Function ERPAreasNegocio(): TERPBEAreasNegocio;
    Procedure Actualiza(pObjAreaNegocio : TERPBEAreaNegocio; Erros: String);
    Procedure Remove(pID: Integer);
    Function ValidaActualizacao(pObjAreaNegocio : TERPBEAreaNegocio; var strErros: String): Boolean;

    Function Clone(pObjAreaNegocio: TERPBEAreaNegocio): TERPBEAreaNegocio;

  End;

Implementation

Uses ERPBS, SysUtils, SBBEAtributoObrigatorio, SBBEExcepcoes,
  ERPDS;

Const
  Separador=',';

Function TERPBSAreaNegocio.Clone(pObjAreaNegocio: TERPBEAreaNegocio): TERPBEAreaNegocio;
Begin
  Result := TERPBEAreaNegocio.Create;
  Result.ID_AreaNegocio:=pObjAreaNegocio.ID_AreaNegocio;
  Result.DescricaoArea:=pObjAreaNegocio.DescricaoArea;
  Result.ContaERP:=pObjAreaNegocio.ContaERP;
End;





Procedure TERPBSAreaNegocio.Actualiza(pObjAreaNegocio :TERPBEAreaNegocio; Erros :String);
Begin
  With TERPBS(BSO) Do
  Begin
    If ValidaActualizacao(pObjAreaNegocio, Erros) Then
    Begin
      SB.SBBD.IniciaTransacao;
      Try
        If Not pObjAreaNegocio.EmModoEdicao Then
          pObjAreaNegocio.ID_AreaNegocio := SB.ProximoID('ERPAreaNegocio', True);

        DSO.AreaNegocio.Actualiza(pObjAreaNegocio, Erros);

        SB.SBBD.TerminaTransacao;
      Except
        SB.SBBD.DesfazTransacao;
        raise;
      End;
    End
    Else
      Raise EErroDetalhe.Create('FntBSAreaNegocio', 'Actualiza', SB.Idioma.daTraducao(603, 'Validação'), Erros);
  End
End;

Procedure TERPBSAreaNegocio.Remove(pID:Integer);
Begin
  With Terpbs(BSO) Do
  Begin
    SB.SBBD.IniciaTransacao;
    Try
      DSO.AreaNegocio.Remove(pID);

      SB.SBBD.TerminaTransacao;
    Except
      On E :Exception Do
      Begin
        SB.SBBD.DesfazTransacao;
        Raise EErroNormal.Create('FntERpAreaNegocio', 'Remove', E.Message);
      End;
    End;
  End;
End;

Function TERPBSAreaNegocio.Edita(pID: Integer):TERPBEAreaNegocio;
Begin
  Result := TERPBS(BSO).DSO.AreaNegocio.Edita(pID);
End;

Function TERPBSAreaNegocio.ERPAreasNegocio(): TERPBEAreasNegocio;
Begin
  Result := TERPBS(BSO).DSO.AreaNegocio.ERPAreasNegocio;
End;

Function TERPBSAreaNegocio.ValidaActualizacao(pObjAreaNegocio :TERPBEAreaNegocio; var strErros: String): Boolean;
Var
  i: longInt;
  FAtributo: TSBBEAtributoObrigatorio;
  FAtributos: TSBBEAtributosObrigatorios;
Begin
  strErros := '';

  With pObjAreaNegocio Do
  Begin
    FAtributos := AtributosObrigatorios;
    If Assigned(FAtributos) Then
    Begin
      For i:=0 to FAtributos.Num-1 Do
      Begin
          FAtributo := FAtributos.ElemAtributoObrigatorio[i];
          If Not TemValorPropriedade(FAtributo.Nome) Then
              strErros := strErros + TERPBS(BSO).SB.Idioma.daTraducao(FAtributo.ID_Idioma,FAtributo.Descricao) + Separador;
      End;
    End;
    If  ContaERP='' then
    begin
      strErros := strErros + 'Conta ERP' + Separador;
    end;
   
  End;

  Result := (strErros = '');
  strErros := strErros + '.';
End;

End.

