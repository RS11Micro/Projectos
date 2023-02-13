unit ERPBECBLLinhaDetalhe;

interface

Uses SBBEEntidade, FntBEEntidadeBase,SBBEListaObjAbs, Controls;
Type
  TERPBECBLLinha=Class(TFntBEEntidadeBase)
  private
    FID_interno: Integer;
    FID_DOCInterno:integer;
    FNumLinha:integer;
    FTipoLinha:string;
    FConta:string;
    FDescricao:string;
    FValor:extended;
    FTaxaIva:string;
    FPercIvaNDev:extended;
    FIvaNDed:extended;
    FNatureza:string;
    FTipoEntidade:string;
    FEntidade:string;
    FClasseIva:string;
    FContaOrigem:string;
    FTipoOperacao:string;
    FMoeda:string;
    FCambio:extended;
    FClasseIvaAutofaturacao:string;
    FObservacoes:string;
    FTipoLinhaInt:integer;
    FID_LinhaMoV:integer;


  Published
     Constructor Create;
    Property ID_interno: Integer Read FID_interno Write FID_interno;
    Property ID_DOCInterno: Integer Read FID_DOCInterno Write FID_DOCInterno;
    Property NumLinha: Integer Read FNumLinha Write FNumLinha;
    Property TipoLinha: string Read FTipoLinha Write FTipoLinha;
    Property Conta: string Read FConta Write FConta;
    Property Descricao: string Read FDescricao Write FDescricao;

    Property Valor: extended Read FValor Write FValor;
    Property TaxaIva: string Read FTaxaIva Write FTaxaIva;


    Property PercIvaNDev: extended Read FPercIvaNDev Write FPercIvaNDev;
    Property IvaNDed: extended Read FIvaNDed Write FIvaNDed;


    Property Natureza: string Read FNatureza Write FNatureza;
    Property TipoEntidade: string Read FTipoEntidade Write FTipoEntidade;
    Property ClasseIva: string Read FClasseIva Write FClasseIva;


    Property Entidade: string Read FEntidade Write FEntidade;
    Property ContaOrigem: string Read FContaOrigem Write FContaOrigem;

    Property TipoOperacao: string Read FTipoOperacao Write FTipoOperacao;
    Property Moeda: string Read FMoeda Write FMoeda;

    Property Cambio: extended Read FCambio Write FCambio;
    Property ClasseIvaAutofaturacao: string Read FClasseIvaAutofaturacao Write FClasseIvaAutofaturacao;
    Property Observacoes: string Read FObservacoes Write FObservacoes;
    Property TipoLinhaInt: integer Read FTipoLinhaInt Write FTipoLinhaInt;
    Property ID_LinhaMov: integer Read FID_LinhaMov Write FID_LinhaMov;

  End;


  TERPBECBLLinhas= Class(TSBBEEntidades)
    Private
      Function GetERPCBLLinhaIdx(Idx :LongInt): TERPBECBLLinha;
      Function GetERPCBLLinha(pId_Vndcabdocumento: Integer): TERPBECBLLinha;
      Function GetERPCBLLinhaPorlinha(pId_Vndcabdocumento,pID_Linha: Integer): TERPBECBLLinha;

    Public
      Procedure Adiciona(pObjERPCBLLinha: TERPBECBLLinha);
      Procedure Remove(pId_Vndcabdocumento: Integer);

      Property Elem[Idx :Longint]: TERPBECBLLinha Read GetERPCBLLinhaIdx;
      Property ERPCBLLinha[pId_Vndcabdocumento: Integer]: TERPBECBLLinha Read GetERPCBLLinha;
      Property ERPCBLLinhaPorLinha[pId_Vndcabdocumento,pID_Linha: Integer]: TERPBECBLLinha Read GetERPCBLLinhaPorlinha;
  End;

Implementation

constructor TERPBECBLLinha.Create;
begin
    inherited;
     FPercIvaNDev:=0;
     FIvaNDed:=0;
end;


Function TERPBECBLLinhas.GetERPCBLLinhaIdx(Idx :LongInt): TERPBECBLLinha;
Begin
  If Idx < Self.Num  Then
    Result := TERPBECBLLinha(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TERPBECBLLinhas.Adiciona(pObjERPCBLLinha: TERPBECBLLinha);
Begin
  Self.AdicionaObj(pObjERPCBLLinha);
End;


Function TERPBECBLLinhas.GetERPCBLLinhaPorlinha(pId_Vndcabdocumento,pID_Linha: Integer): TERPBECBLLinha;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjERPCBLLinha: TERPBECBLLinha;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPCBLLinha := TERPBECBLLinha(Elemento[Posicao]);

    If (ObjERPCBLLinha.ID_DOCInterno = pId_Vndcabdocumento)and
     (ObjERPCBLLinha.NumLinha = pID_Linha) Then
      Result := ObjERPCBLLinha;

    Inc(Posicao);
  End;
End;

Function TERPBECBLLinhas.GetERPCBLLinha(pId_Vndcabdocumento: Integer): TERPBECBLLinha;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjERPCBLLinha: TERPBECBLLinha;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPCBLLinha := TERPBECBLLinha(Elemento[Posicao]);

    If (ObjERPCBLLinha.ID_DOCInterno = pId_Vndcabdocumento) Then
      Result := ObjERPCBLLinha;

    Inc(Posicao);
  End;
End;

Procedure TERPBECBLLinhas.Remove(pId_Vndcabdocumento: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjERPCBLLinha: TERPBECBLLinha;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPCBLLinha := TERPBECBLLinha(Elemento[Posicao]);

    If (ObjERPCBLLinha.ID_DOCInterno = pId_Vndcabdocumento) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
 