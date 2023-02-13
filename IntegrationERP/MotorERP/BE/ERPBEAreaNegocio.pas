unit ERPBEAreaNegocio;

interface

Uses SBBEEntidade,SBBEListaObjAbs, vcl.Controls;
Type
  TERPBEAreaNegocio=Class(TSBBEEntidade)
  private
      FID_AreaNegocio:Integer;
      FDescricaoArea:string;
      FContaERP:string;


  Published
    Property ID_AreaNegocio: Integer Read FID_AreaNegocio Write FID_AreaNegocio;
    Property DescricaoArea:string  Read FDescricaoArea Write FDescricaoArea;
    Property ContaERP:string  Read FContaERP Write FContaERP;



  End;

  TERPBEAreasNegocio= Class(TSBBEEntidades)
    Private
      Function GetERPAreaNegocioIdx(Idx :LongInt): TERPBEAreaNegocio;
      Function GetERPAreaNegocio(pID: Integer): TERPBEAreaNegocio;

    Public
      Procedure Adiciona(pObjtInterface: TERPBEAreaNegocio);
      Procedure Remove(pID: Integer);

      Property Elem[Idx :Longint]: TERPBEAreaNegocio Read GetERPAreaNegocioIdx;
      Property ERPAreaNegocio[pID: Integer]: TERPBEAreaNegocio Read GetERPAreaNegocio;
  End;

Implementation

Function TERPBEAreasNegocio.GetERPAreaNegocioIdx(Idx :LongInt): TERPBEAreaNegocio;
Begin
  If Idx < Self.Num  Then
    Result := TERPBEAreaNegocio(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TERPBEAreasNegocio.Adiciona(pObjtInterface: TERPBEAreaNegocio);
Begin
  Self.AdicionaObj(pObjtInterface);
End;

Function TERPBEAreasNegocio.GetERPAreaNegocio(pID: Integer): TERPBEAreaNegocio;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjAreaNegocio: TERPBEAreaNegocio;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjAreaNegocio := TERPBEAreaNegocio(Elemento[Posicao]);

    If (ObjAreaNegocio.ID_AreaNegocio = pID) Then
      Result := ObjAreaNegocio;

    Inc(Posicao);
  End;
End;

Procedure TERPBEAreasNegocio.Remove(pID: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjAreaNegocio: TERPBEAreaNegocio;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjAreaNegocio := TERPBEAreaNegocio(Elemento[Posicao]);

    If (ObjAreaNegocio.ID_AreaNegocio = pID) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
