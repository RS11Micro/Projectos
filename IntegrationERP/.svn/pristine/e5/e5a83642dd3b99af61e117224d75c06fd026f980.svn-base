unit ERPBELinhaPagamento;

interface

Uses SBBEEntidade, FntBEEntidadeBase,SBBEListaObjAbs, Controls;
Type
  TERPBELinhaPagamento=Class(TFntBEEntidadeBase)
  private
    FID_internoDoc: Integer;
    FID_VNDCABDOCUMENTO:integer;
    FID_Linha: Integer;
    FID_ModoPagamento: Integer;
    FContaERP:string;
    FDescricao:string;
    FValor:Extended;

    FRef:integer;
    FDataMovimento:tdatetime;



  Published

    Property ID_internoDoc: Integer Read FID_internoDoc Write FID_internoDoc;
    Property ID_VNDCABDOCUMENTO: Integer Read FID_VNDCABDOCUMENTO Write FID_VNDCABDOCUMENTO;
    Property ID_Linha: Integer Read FID_Linha Write FID_Linha;
    Property ID_ModoPagamento: Integer Read FID_ModoPagamento Write FID_ModoPagamento;
    Property ContaERP: string Read FContaERP Write FContaERP;
    Property Descricao: string Read FDescricao Write FDescricao;
    Property Valor: extended Read FValor Write FValor;
    Property Ref: Integer Read FRef Write FRef ;
    Property DataMovimento: tdatetime Read FDataMovimento Write FDataMovimento;

  End;

  TERPBELinhasPagamento= Class(TSBBEEntidades)
    Private
      Function GetERPLinhaPagamentoIdx(Idx :LongInt): TERPBELinhaPagamento;
      Function GetERPLinhaPagamento(pId_Vndcabdocumento: Integer): TERPBELinhaPagamento;
      Function GetERPLinhaPagamentoPorlinha(pId_Vndcabdocumento,pID_Linha: Integer): TERPBELinhaPagamento;

    Public
      Procedure Adiciona(pObjERPLinhaPagamento: TERPBELinhaPagamento);
      Procedure Remove(pId_Vndcabdocumento: Integer);

      Property Elem[Idx :Longint]: TERPBELinhaPagamento Read GetERPLinhaPagamentoIdx;
      Property ERPLinhaPagamento[pId_Vndcabdocumento: Integer]: TERPBELinhaPagamento Read GetERPLinhaPagamento;
      Property ERPLinhaPagamentoPorLinha[pId_Vndcabdocumento,pID_Linha: Integer]: TERPBELinhaPagamento Read GetERPLinhaPagamentoPorlinha;
  End;

Implementation

Function TERPBELinhasPagamento.GetERPLinhaPagamentoIdx(Idx :LongInt): TERPBELinhaPagamento;
Begin
  If Idx < Self.Num  Then
    Result := TERPBELinhaPagamento(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TERPBELinhasPagamento.Adiciona(pObjERPLinhaPagamento: TERPBELinhaPagamento);
Begin
  Self.AdicionaObj(pObjERPLinhaPagamento);
End;


Function TERPBELinhasPagamento.GetERPLinhaPagamentoPorlinha(pId_Vndcabdocumento,pID_Linha: Integer): TERPBELinhaPagamento;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjERPLinhaPagamento: TERPBELinhaPagamento;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPLinhaPagamento := TERPBELinhaPagamento(Elemento[Posicao]);

    If (ObjERPLinhaPagamento.Id_Vndcabdocumento = pId_Vndcabdocumento)and
     (ObjERPLinhaPagamento.ID_Linha = pID_Linha) Then
      Result := ObjERPLinhaPagamento;

    Inc(Posicao);
  End;
End;

Function TERPBELinhasPagamento.GetERPLinhaPagamento(pId_Vndcabdocumento: Integer): TERPBELinhaPagamento;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjERPLinhaPagamento: TERPBELinhaPagamento;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPLinhaPagamento := TERPBELinhaPagamento(Elemento[Posicao]);

    If (ObjERPLinhaPagamento.Id_Vndcabdocumento = pId_Vndcabdocumento) Then
      Result := ObjERPLinhaPagamento;

    Inc(Posicao);
  End;
End;

Procedure TERPBELinhasPagamento.Remove(pId_Vndcabdocumento: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjERPLinhaPagamento: TERPBELinhaPagamento;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPLinhaPagamento := TERPBELinhaPagamento(Elemento[Posicao]);

    If (ObjERPLinhaPagamento.Id_Vndcabdocumento = pId_Vndcabdocumento) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
