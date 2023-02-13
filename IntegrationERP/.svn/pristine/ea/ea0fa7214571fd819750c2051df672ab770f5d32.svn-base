unit ERPBECab;


interface

Uses SBBEEntidade, FntBEEntidadeBase,SBBEListaObjAbs, Controls,ERPBELinhaDetalhe,ERPBELinhaPagamento;
Type
  TERPBECab=Class(TFntBEEntidadeBase)
  private
       FID_internoDoc: Integer;
       Fmpehotel: Integer;
       Ftypedoc: string;
       FSerie: string;
       FNumero: Integer;
       FData: Tdatetime;
       FDataDoc: Tdatetime;
       FDataVenc: Tdatetime;
       FIDCliente:integer;
       FNrcliente:string;
       FTotalBruto:extended;
       FStatus:string;
       FAssinatura:string;
       FChave:string;
       FNome:string;
       FMorada:string;
       Flocalidade:string;
       FCodPostal:string;
       FNIF:string;
       FTotalPago:extended;
       FIntegrado:boolean;
       FOrigem:integer;
       FDataHoraRegisto:Tdatetime;
       FID_VNDCABDOCUMENTO:Integer;
       FTotalLinhas:integer;
       FUtilizadorRegisto:string;
       FTotalIVA:Extended;
       FTotalCOMIVA:Extended;
       FTotalSEMIVA:Extended;
       FNumDocumento:string;
       FLinhas:TERPBELinhas;
       FDescTipoMovimento:string;
       FComERROSConfig:Boolean;
       FPagamentos:TERPBELinhasPagamento;
       FID_InternoERP:Integer;//controlos de Edição
       FTipoMov:integer;
       FCodPais:string;
       FDescPais:string;
       FMercado:Integer;
       FDescMercado:string;
       FID_encomenda:integer;
       Fencomenda:boolean;
       FInvoicetype:string;
  Published
    Constructor Create;
    Destructor Destroy;override;

    Property ID_internoDoc: Integer Read FID_internoDoc Write FID_internoDoc;
    Property mpehotel: Integer Read Fmpehotel Write Fmpehotel;
    Property typedoc: string Read Ftypedoc Write Ftypedoc;
    Property Serie: string Read FSerie Write FSerie;
    Property Numero: Integer Read FNumero Write FNumero;
    Property Data: TDateTime Read FData Write FData;
    Property DataDoc: TDateTime Read FDataDoc Write FDataDoc;
    Property DataVenc: TDateTime Read FDataVenc Write FDataVenc;
    Property IDCliente: Integer Read FIDCliente Write FIDCliente;
    Property Nrcliente :String read FNrcliente write FNrcliente;
    Property TotalBruto :extended read FTotalBruto write FTotalBruto;
    Property Status :String read FStatus write FStatus;


    Property Assinatura :String read FAssinatura write FAssinatura;
    Property Chave :String read FChave write FChave;
    Property Nome :String read FNome write FNome;
    Property Morada :String read FMorada write FMorada;

    Property localidade :String read Flocalidade write Flocalidade;
    Property CodPostal :String read FCodPostal write FCodPostal;

    Property NIF :String read FNIF write FNIF;
    Property TotalPago :extended read FTotalPago write FTotalPago;
    Property Integrado :boolean read FIntegrado write FIntegrado;
    Property Origem: Integer Read FOrigem Write FOrigem;

    Property DataHoraRegisto: TDateTime Read FDataHoraRegisto Write FDataHoraRegisto;
    Property ID_VNDCABDOCUMENTO: Integer Read FID_VNDCABDOCUMENTO Write FID_VNDCABDOCUMENTO;
    Property TotalLinhas: Integer Read FTotalLinhas Write FTotalLinhas;
    Property UtilizadorRegisto :String read FUtilizadorRegisto write FUtilizadorRegisto;

    Property TotalIVA :extended read FTotalIVA write FTotalIVA;
    Property TotalCOMIVA :extended read FTotalCOMIVA write FTotalCOMIVA;
    Property TotalSEMIVA :extended read FTotalSEMIVA write FTotalSEMIVA;
    Property NumDocumento :string read FNumDocumento write FNumDocumento;
    Property DescTipoMovimento :string read FDescTipoMovimento write FDescTipoMovimento;
    Property ComERROSConfig :Boolean read FComERROSConfig write FComERROSConfig;

    Property ID_InternoERP: Integer Read FID_InternoERP Write FID_InternoERP;
    Property TipoMov: integer Read FTipoMov Write FTipoMov;

    Property  CodPais :String read FCodPais write FCodPais;
    Property  DescPais :String read FDescPais write FDescPais;
    Property  DescMercado :String read FDescMercado write FDescMercado;
    Property  Mercado: Integer Read FMercado Write FMercado;
    Property  ID_encomenda: Integer Read FID_encomenda Write FID_encomenda;

    Property  Encomenda: boolean Read Fencomenda Write Fencomenda;

    Property  Invoicetype :String read FInvoicetype write FInvoicetype;



    property Linhas:TERPBELinhas read FLinhas write FLinhas;
    property Pagamentos:TERPBELinhasPagamento read FPagamentos write FPagamentos;

  End;

  TERPBECabecalhos= Class(TSBBEEntidades)
    Private
      Function GetERPCabIdx(Idx :LongInt): TERPBECab;
      Function GetERPCab(pID_Vndcabdocumento: Integer): TERPBECab;

    Public
      Procedure Adiciona(pObjERPCab: TERPBECab);
      Procedure Remove(pID_Vndcabdocumento: Integer);

      Property Elem[Idx :Longint]: TERPBECab Read GetERPCabIdx;
      Property ERPCab[pID_Vndcabdocumento: Integer]: TERPBECab Read GetERPCab;
  End;

Implementation


constructor TERPBECab.Create;
begin
    inherited;
    FTotalIVA:=0;
    FTotalCOMIVA:=0;
    FTotalSEMIVA:=0;
    FID_InternoERP:=0;
    FComERROSConfig:=false;
    FMercado:=0;
    fencomenda:=false;
    fid_encomenda:=0;
   
    FLinhas:= TERPBELinhas.Create;
    FPagamentos:=TERPBELinhasPagamento.Create;
end;


Destructor TERPBECab.Destroy;
Begin
   If assigned(FLinhas) then
       FLinhas.Free;
   If assigned(FPagamentos) then
       FPagamentos.free;

  inherited;

End;

Function TERPBECabecalhos.GetERPCabIdx(Idx :LongInt): TERPBECab;
Begin
  If Idx < Self.Num  Then
    Result := TERPBECab(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TERPBECabecalhos.Adiciona(pObjERPCab: TERPBECab);
Begin
  Self.AdicionaObj(pObjERPCab);
End;

Function TERPBECabecalhos.GetERPCab(pID_Vndcabdocumento: Integer): TERPBECab;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjERPCab: TERPBECab;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPCab := TERPBECab(Elemento[Posicao]);

    If (ObjERPCab.ID_Vndcabdocumento = pID_Vndcabdocumento) Then
      Result := ObjERPCab;

    Inc(Posicao);
  End;
End;

Procedure TERPBECabecalhos.Remove(pID_Vndcabdocumento: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjERPCab: TERPBECab;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPCab := TERPBECab(Elemento[Posicao]);

    If (ObjERPCab.ID_Vndcabdocumento = pID_Vndcabdocumento) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
