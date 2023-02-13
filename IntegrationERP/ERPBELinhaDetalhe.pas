unit ERPBELinhaDetalhe;

interface

Uses SBBEEntidade, FntBEEntidadeBase,SBBEListaObjAbs, Controls;
Type
  TERPBELinha=Class(TFntBEEntidadeBase)
  private
    Fmpehotel: Integer;
      FID_internoDoc: Integer;
    FID_VNDCABDOCUMENTO:integer;
    FID_Linha: Integer;
    FSerie: string;
    Fnumero: Integer;
    Fdatainv:tdatetime;
    FData:tdatetime;
    FDataDoc:tdatetime;
    Fservico:string;
    FDescritivo:string;
    Fqnt:extended;
    Fprecounit:extended;
    Fcodiva:string;
    Ftaxaiva:extended;
    Ftotal:extended;

    FCCusto:string;
    FCodIsencao:string;
    FDescontoperc:extended;
    FDescontoValor:extended;
    FOrigem:Integer;
    FValorIVA:Extended;
    FValorSemIVA:Extended;
    FValorCOMIVA:Extended;
    FprecounitsemIVA:Extended;
    FArmazem:string;
    Fid_armazem:integer;
    FID_ArmazemERP:string;
    FNumDocumento:string;
    Fid_ProdutoOrigem:integer;
    FTipoArtigo:string;

    FCODIGOUNIDADEVENDA:string;
    FCODIGOUNIDADEBASE:string;
    FDESCRICAOUNIDADEVENDA:string;
    FDESCRICAOUNIDADEBASE :string;
    FFATORCONVERSAO:Extended;
    FAreaNegocio :string;
    FDescAreaNegocio :string;

    FID_GrupoProduto:integer;
    FGrupoProduto :string;
    FID_FamiliaProduto:integer;
    FFamiliaProduto  :string;
    FID_SubFamiliaProduto:integer;
    FSubFamiliaProduto :string;
    FID_InternoOrigem:integer;
    FID_MovimentoOrigem:integer;
    FID_linhaOrigem:integer;
    FID_EncomendaOrigem ,FID_linhaEncOrigem:integer;
    Fid_encomenda:integer;
    FRef:integer;
    FDataMovimento:tdatetime;
    FID_GrupoServico :string;
    FTaxCode :string;
    FTaxCountryRegion:String;




  Published
    Constructor Create;
    Property ID_internoDoc: Integer Read FID_internoDoc Write FID_internoDoc;
    Property mpehotel: Integer Read Fmpehotel Write Fmpehotel;
    Property ID_VNDCABDOCUMENTO: Integer Read FID_VNDCABDOCUMENTO Write FID_VNDCABDOCUMENTO;
    Property ID_encomenda: Integer Read fid_encomenda Write FID_Encomenda;
    Property ID_Linha: Integer Read FID_Linha Write FID_Linha;
    Property Serie: string Read FSerie Write FSerie;
    Property numero: Integer Read Fnumero Write Fnumero;
    Property datainv: tdatetime Read Fdatainv Write Fdatainv;
    Property Data: tdatetime Read FData Write FData;
    Property DataDoc: tdatetime Read FDataDoc Write FDataDoc;
    Property servico: string Read Fservico Write Fservico;
    Property Descritivo: string Read FDescritivo Write FDescritivo;
    Property qnt: extended Read Fqnt Write Fqnt;
    Property codiva: string Read Fcodiva Write Fcodiva;
    Property taxaiva: extended Read Ftaxaiva Write Ftaxaiva;
    Property total: extended Read Ftotal Write Ftotal;
    Property precounit: extended Read Fprecounit Write Fprecounit;
    Property precounitsemIVA: extended Read FprecounitsemIVA Write FprecounitsemIVA;
    Property ValorIVA: extended Read FValorIVA Write FValorIVA;
    Property ValorSemIVA: extended Read FValorSemIVA Write FValorSemIVA;
    Property ValorCOMIVA: extended Read FValorCOMIVA Write FValorCOMIVA;





    Property Armazem:  string Read FArmazem Write FArmazem;
    Property CCusto:string  Read FCCusto  Write FCCusto;
    Property CodIsencao:string  Read FCodIsencao Write FCodIsencao;
    Property Descontoperc:extended  Read FDescontoperc Write FDescontoperc;
    Property DescontoValor: extended Read FDescontoValor Write FDescontoValor;
    Property Origem: Integer Read FOrigem Write FOrigem;
    Property id_armazem: Integer Read Fid_armazem Write Fid_armazem;
    Property ID_ArmazemERP:string  Read FID_ArmazemERP Write FID_ArmazemERP;
    Property NumDocumento:string  Read FNumDocumento Write FNumDocumento;
    Property Id_ProdutoOrigem: Integer Read Fid_ProdutoOrigem Write Fid_ProdutoOrigem;

    Property TipoArtigo:string  Read FTipoArtigo Write FTipoArtigo;
    Property CODIGOUNIDADEVENDA:string  Read FCODIGOUNIDADEVENDA Write FCODIGOUNIDADEVENDA;
    Property CODIGOUNIDADEBASE:string  Read FCODIGOUNIDADEBASE Write FCODIGOUNIDADEBASE;
    Property DESCRICAOUNIDADEVENDA:string  Read FDESCRICAOUNIDADEVENDA Write FDESCRICAOUNIDADEVENDA;
    Property DESCRICAOUNIDADEBASE:string  Read FDESCRICAOUNIDADEBASE Write FDESCRICAOUNIDADEBASE;
    Property FATORCONVERSAO:extended  Read FFATORCONVERSAO Write FFATORCONVERSAO;

    Property AreaNegocio:string  Read FAreaNegocio Write FAreaNegocio;
    Property DescAreaNegocio:string  Read FDescAreaNegocio Write FDescAreaNegocio;

    Property ID_GrupoProduto: Integer Read FID_GrupoProduto Write FID_GrupoProduto;
    Property GrupoProduto: string Read FGrupoProduto Write FGrupoProduto;

    Property ID_FamiliaProduto: Integer Read FID_FamiliaProduto Write FID_FamiliaProduto;
    Property FamiliaProduto: string Read FFamiliaProduto Write FFamiliaProduto;


    Property ID_SubFamiliaProduto: Integer Read FID_SubFamiliaProduto Write FID_SubFamiliaProduto;
    Property SubFamiliaProduto: string Read FSubFamiliaProduto Write FSubFamiliaProduto;

    Property ID_InternoOrigem: Integer Read FID_InternoOrigem Write FID_InternoOrigem;
    Property ID_MovimentoOrigem: Integer Read FID_MovimentoOrigem Write FID_MovimentoOrigem;
    Property ID_linhaOrigem: Integer Read FID_linhaOrigem Write FID_linhaOrigem;

    Property ID_EncomendaOrigem: Integer Read FID_EncomendaOrigem Write FID_EncomendaOrigem;
    Property ID_linhaEncOrigem: Integer Read FID_linhaEncOrigem Write FID_linhaEncOrigem;


    Property Ref: Integer Read FRef Write FRef ;
    Property DataMovimento: tdatetime Read FDataMovimento Write FDataMovimento;
    Property ID_GrupoServico :string read FID_GrupoServico Write FID_GrupoServico ;
    Property TaxCode :string read FTaxCode Write FTaxCode ;
    Property TaxCountryRegion :string read FTaxCountryRegion Write FTaxCountryRegion ;


  End;

  TERPBELinhas= Class(TSBBEEntidades)
    Private
      Function GetERPLinhaIdx(Idx :LongInt): TERPBELinha;
      Function GetERPLinha(pId_Vndcabdocumento: Integer): TERPBELinha;
      Function GetERPLinhaPorlinha(pId_Vndcabdocumento,pID_Linha: Integer): TERPBELinha;

    Public
      Procedure Adiciona(pObjERPLinha: TERPBELinha);
      Procedure Remove(pId_Vndcabdocumento: Integer);

      Property Elem[Idx :Longint]: TERPBELinha Read GetERPLinhaIdx;
      Property ERPLinha[pId_Vndcabdocumento: Integer]: TERPBELinha Read GetERPLinha;
      Property ERPLinhaPorLinha[pId_Vndcabdocumento,pID_Linha: Integer]: TERPBELinha Read GetERPLinhaPorlinha;
  End;

Implementation

constructor TERPBELinha.Create;
begin
    inherited;
    Fqnt:=0;
    Fprecounit:=0;
    FDescontoperc:=0;
    FDescontoValor:=0;
    Ftotal:=0;
    Ftaxaiva:=0;

    FValorIVA:=0;
    FValorSemIVA:=0;
    FValorCOMIVA:=0;
    FprecounitsemIVA:=0;
    FId_ProdutoOrigem:=0;
    FValorIVA:=0;
    FTipoArtigo:='';
    FID_InternoOrigem:=0;
    FID_MovimentoOrigem:=0;
    FID_linhaOrigem:=0;

   FID_EncomendaOrigem:=0;
   FID_linhaEncOrigem:=0;
   Fid_encomenda:=0;

end;


Function TERPBELinhas.GetERPLinhaIdx(Idx :LongInt): TERPBELinha;
Begin
  If Idx < Self.Num  Then
    Result := TERPBELinha(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TERPBELinhas.Adiciona(pObjERPLinha: TERPBELinha);
Begin
  Self.AdicionaObj(pObjERPLinha);
End;


Function TERPBELinhas.GetERPLinhaPorlinha(pId_Vndcabdocumento,pID_Linha: Integer): TERPBELinha;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjERPLinha: TERPBELinha;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPLinha := TERPBELinha(Elemento[Posicao]);

    If (ObjERPLinha.Id_Vndcabdocumento = pId_Vndcabdocumento)and
     (ObjERPLinha.ID_Linha = pID_Linha) Then
      Result := ObjERPLinha;

    Inc(Posicao);
  End;
End;

Function TERPBELinhas.GetERPLinha(pId_Vndcabdocumento: Integer): TERPBELinha;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjERPLinha: TERPBELinha;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPLinha := TERPBELinha(Elemento[Posicao]);

    If (ObjERPLinha.Id_Vndcabdocumento = pId_Vndcabdocumento) Then
      Result := ObjERPLinha;

    Inc(Posicao);
  End;
End;

Procedure TERPBELinhas.Remove(pId_Vndcabdocumento: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjERPLinha: TERPBELinha;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPLinha := TERPBELinha(Elemento[Posicao]);

    If (ObjERPLinha.Id_Vndcabdocumento = pId_Vndcabdocumento) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
