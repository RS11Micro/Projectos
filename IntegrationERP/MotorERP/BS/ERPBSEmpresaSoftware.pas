unit ERPBSEmpresaSoftware;



Interface

Uses ERPBEEmpresaSoftware, SBBSEntidade;

Type

  TERPBSEmpresaSoftware=Class(TSBBSEntidade)
  Public
    Function Edita(pID_Empresa: Integer): TERPBEEmpresaSoftware;
    Function EmpresasSoftware(): TERPBEEmpresasSoftware;
    Procedure Actualiza(pObjEmpresaSoftware : TERPBEEmpresaSoftware; Erros: String);
    Procedure Remove(pID_Empresa: Integer);
    Function ValidaActualizacao(pObjEmpresaSoftware : TERPBEEmpresaSoftware; var strErros: String): Boolean;
    Function DaID_Empresa:integer;
  End;

Implementation

Uses ERPBS, SysUtils, SBBEAtributoObrigatorio, SBBEExcepcoes;

Const
  Separador=',';

Procedure TERPBSEmpresaSoftware.Actualiza(pObjEmpresaSoftware :TERPBEEmpresaSoftware; Erros :String);
Begin
  With TERPBS(BSO) Do
  Begin
    If ValidaActualizacao(pObjEmpresaSoftware, Erros) Then
    Begin
      SB.SBBD.IniciaTransacao;
      Try

         if not pObjEmpresaSoftware.EmModoEdicao then
         begin
            //Atribuir o ID se estiver a actualizar novo
            pObjEmpresaSoftware.ID_EMpresa := SB.ProximoID(DSO.EmpresaSoftware.Tabela,true);
         end;
        DSO.EmpresaSoftware.Actualiza(pObjEmpresaSoftware, Erros);

        SB.SBBD.TerminaTransacao;
      Except
        SB.SBBD.DesfazTransacao;
        raise;
      End;
    End
    Else
      Raise EErroDetalhe.Create('ERPBSEmpresaSoftware', 'Actualiza', SB.Idioma.daTraducao(603, 'Validação'), Erros);
  End
End;

Procedure TERPBSEmpresaSoftware.Remove(pID_Empresa: Integer);
Begin
  With TERPBS(BSO) Do
  Begin
    SB.SBBD.IniciaTransacao;
    Try
      DSO.EmpresaSoftware.Remove(pID_Empresa);

      SB.SBBD.TerminaTransacao;
    Except
      On E :Exception Do
      Begin
        SB.SBBD.DesfazTransacao;
        Raise EErroNormal.Create('ERPBSEmpresaSoftware', 'Remove', E.Message);
      End;
    End;
  End;
End;

Function TERPBSEmpresaSoftware.Edita(pID_Empresa: Integer):TERPBEEmpresaSoftware;
Begin
  Result := TERPBS(BSO).DSO.EmpresaSoftware.Edita(pID_Empresa);
End;

Function TERPBSEmpresaSoftware.EmpresasSoftware(): TERPBEEmpresasSoftware;
Begin
  Result := TERPBS(BSO).DSO.EmpresaSoftware.EmpresasSoftware;
End;

Function TERPBSEmpresaSoftware.ValidaActualizacao(pObjEmpresaSoftware :TERPBEEmpresaSoftware; var strErros: String): Boolean;
Var
  i: longInt;
  FAtributo: TSBBEAtributoObrigatorio;
  FAtributos: TSBBEAtributosObrigatorios;
Begin
  strErros := '';

  With pObjEmpresaSoftware Do
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

    If pObjEmpresaSoftware.Nome = '' Then
      strErros := strErros + TERPBS(BSO).SB.Idioma.DaTraducao(73, 'Nome') + Separador;

  End;

  Result := (strErros = '');
  strErros := strErros + '.';
End;

Function TERPBSEmpresaSoftware.DaID_Empresa():integer;
Begin
  Result := TERPBS(BSO).DSO.EmpresaSoftware.DaID_Empresa;
End;
End.

