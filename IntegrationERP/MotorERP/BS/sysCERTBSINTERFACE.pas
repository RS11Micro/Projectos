unit sysCERTBSINTERFACE;



Interface
Uses  SBBSEntidade,sysCERTBEINTERFACE,ERPBETipoCons;

Type

  tsysCERTBSINTERFACE=Class(TSBBSEntidade)
  Public
    Function Edita(pID: Integer): tsysCERTBEINTERFACE;
    Function Interfaces(): tsysCERTBEINTERFACES;
    Procedure Actualiza(pObjInterface : tsysCERTBEINTERFACE; Erros: String);
    Procedure Remove(pID: Integer);
    Function ValidaActualizacao(pObjInterface : TsysCERTBEINTERFACE; var strErros: String): Boolean;

    Function Clone(pObjInterface: TsysCERTBEINTERFACE): TsysCERTBEINTERFACE;

  End;

Implementation

Uses ERPBS, SysUtils, SBBEAtributoObrigatorio, SBBEExcepcoes,
  ERPDS;

Const
  Separador=',';


Function TsysCERTBSINTERFACE.Clone(pObjInterface: TsysCERTBEINTERFACE): TsysCERTBEINTERFACE;
Begin
  Result := TsysCERTBEINTERFACE.Create;
  Result.ID:=pObjInterface.ID;
 Result.ID_Interface:=pObjInterface.ID_Interface;
 Result.BDServidor:=pObjInterface.BDServidor;
 Result.BDUSER:=pObjInterface.BDUSER;
 Result.BDPASSWORD:=pObjInterface.BDPASSWORD;
 Result.BDNOME:=pObjInterface.BDNOME;
 Result.BDConexao:=pObjInterface.BDConexao;
 Result.BDSchema:=pObjInterface.BDSchema;

 Result.Ativo:=pObjInterface.Ativo;
 Result.descricao:= pObjInterface.descricao;
 Result.TipoRegistoDados:= pObjInterface.TipoRegistoDados;
 Result.TipoProjecto:= pObjInterface.TipoProjecto;
 Result.CaminhoXML:= pObjInterface.CaminhoXML;
 Result.CaminhoPDF:= pObjInterface.CaminhoXML;

End;






Procedure tsysCERTBSINTERFACE.Actualiza(pObjInterface :TsysCERTBEINTERFACE; Erros :String);
Begin
  With TERPBS(BSO) Do
  Begin
    If ValidaActualizacao(pObjInterface, Erros) Then
    Begin
      SB.SBBD.IniciaTransacao;
      Try
        If Not pObjInterface.EmModoEdicao Then
          pObjInterface.ID_Interface := SB.ProximoID('sysCERTInterface', True);

        DSO.sysCERTInterface.Actualiza(pObjInterface, Erros);

        SB.SBBD.TerminaTransacao;
      Except
        SB.SBBD.DesfazTransacao;
        raise;
      End;
    End
    Else
      Raise EErroDetalhe.Create('FntBSFntInterface', 'Actualiza', SB.Idioma.daTraducao(603, 'Validação'), Erros);
  End
End;

Procedure tsysCERTBSINTERFACE.Remove(pID:Integer);
Begin
  With Terpbs(BSO) Do
  Begin
    SB.SBBD.IniciaTransacao;
    Try
      DSO.sysCERTInterface.Remove(pID);

      SB.SBBD.TerminaTransacao;
    Except
      On E :Exception Do
      Begin
        SB.SBBD.DesfazTransacao;
        Raise EErroNormal.Create('FntERpINTERFACE', 'Remove', E.Message);
      End;
    End;
  End;
End;

Function tsysCERTBSINTERFACE.Edita(pID: Integer):TsysCERTBEINTERFACE;
Begin
  Result := TERPBS(BSO).DSO.sysCERTInterface.Edita(pID);
End;

Function tsysCERTBSINTERFACE.Interfaces(): tsysCERTBEINTERFACES;
Begin
  Result := TERPBS(BSO).DSO.sysCERTInterface.Interfaces;
End;

Function tsysCERTBSINTERFACE.ValidaActualizacao(pObjInterface :TsysCERTBEINTERFACE; var strErros: String): Boolean;
Var
  i: longInt;
  FAtributo: TSBBEAtributoObrigatorio;
  FAtributos: TSBBEAtributosObrigatorios;
Begin
  strErros := '';

  With pObjInterface Do
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
    If   pObjInterface.TipoRegistoDados= trdInterno then
    begin
            If  BDSchema='' then
            begin
              strErros := strErros + 'Schema da base de dados' + Separador;
            end;
            If  BDNOME='' then
            begin
              strErros := strErros + 'Nome da base de dados' + Separador;
            end;
            If  BDServidor='' then
            begin
              strErros := strErros + 'Servidor da base de dados' + Separador;
            end;
            If  BDUSER='' then
            begin
              strErros := strErros + 'Utilizador da base de dados' + Separador;
            end;
       end;




  End;

  Result := (strErros = '');
  strErros := strErros + '.';
End;

End.

