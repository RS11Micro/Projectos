unit ERPBECBLCab;


interface

Uses SBBEEntidade, FntBEEntidadeBase,SBBEListaObjAbs, Controls,ERPBECBLLinhaDetalhe,ERPBELinhaPagamento;
Type
  TERPBECBLCab=Class(TFntBEEntidadeBase)
  private
       FID_interno: Integer;
       Fmpehotel: Integer;
       FID_DOCInterno:integer;
       FOrigem:integer;
       FModulo:string;
       FAno:integer;
       FMes:integer;
       FDia:integer;
       FData:tdatetime;

       FAnoMov:integer;
       FMesMov:integer;
       FDiaMov:integer;
       FDataMov:tdatetime;

       FAnalitica:string;
       FCCustos:string;
       FDiario:string;
       FDocumento:String;//doccbl
       FNumDocumento:string;
       FDescricao:string;
       FDataHoraRegisto:Tdatetime;
       FTotalLinhas:integer;
       FUtilizadorRegisto:string;
       FIntegrado:boolean;
       FDataHoraIntegracao:tdatetime;
       FNIF:string;
       FTipoEntidade:string;
       FEntidade:string;
       FID_cliente:integer;
       FNome:string;
       FMorada:string;
       FLocalidade:string;
       FCodigoPostal:string;
       FTelefone:string;

       FDataVencimento:tdatetime;
       FCodPais:string;
       FDescPais:string;
       FMercado:Integer;
       FDescMercado:string;


       FLinhas:TERPBECBLLinhas;
       Fobrigacentrocusto:boolean;


  Published
    Constructor Create;
    Destructor Destroy;override;


    Property ID_interno: Integer Read FID_interno Write FID_interno;
    Property ID_DOCInterno: Integer Read FID_DOCInterno Write FID_DOCInterno;
    Property tipoentidade: string Read Ftipoentidade Write Ftipoentidade;
    Property entidade: string Read Fentidade Write Fentidade;
    Property Origem: Integer Read FOrigem Write FOrigem;
    Property Modulo :string read FModulo write FModulo;
    Property mpehotel: Integer Read Fmpehotel Write Fmpehotel;
    Property NumDocumento :string read FNumDocumento write FNumDocumento;
    Property Data: TDateTime Read FData Write FData;

    Property Ano: Integer Read FAno Write FAno;
    Property Mes: Integer Read FMes Write FMes;
    Property Dia: Integer Read FDia Write FDia;


    Property DataMOv: TDateTime Read FDataMOv Write FDataMOv;

    Property AnoMov: Integer Read FAnoMov Write FAnoMov;
    Property MesMov: Integer Read FMesMov Write FMesMov;
    Property DiaMov: Integer Read FDiaMov Write FDiaMov;

    Property Analitica :string read FAnalitica write FAnalitica;

    Property CCustos: string Read FCCustos Write FCCustos;
    Property Diario: string Read FDiario Write FDiario;
    Property Documento: string Read FDocumento Write FDocumento;
    Property Descricao: string Read FDescricao Write FDescricao;



    Property DataVencimento: TDateTime Read FDataVencimento Write FDataVencimento;

    Property Nome :String read FNome write FNome;
    Property Morada :String read FMorada write FMorada;

    Property localidade :String read Flocalidade write Flocalidade;
    Property CodigoPostal :String read FCodigoPostal write FCodigoPostal;
    Property Telefone :String read FTelefone write FTelefone;

    Property NIF :String read FNIF write FNIF;


    Property ID_cliente :integer read FID_cliente write FID_cliente;

    Property Integrado :boolean read FIntegrado write FIntegrado;

    Property DataHoraRegisto: TDateTime Read FDataHoraRegisto Write FDataHoraRegisto;
    Property TotalLinhas: Integer Read FTotalLinhas Write FTotalLinhas;
    Property UtilizadorRegisto :String read FUtilizadorRegisto write FUtilizadorRegisto;
    Property Obrigacentrocusto :boolean read Fobrigacentrocusto write Fobrigacentrocusto;

    Property  CodPais :String read FCodPais write FCodPais;
    Property  DescPais :String read FDescPais write FDescPais;
    Property  DescMercado :String read FDescMercado write FDescMercado;
    Property  Mercado: Integer Read FMercado Write FMercado;



    property Linhas:TERPBECBLLinhas read FLinhas write FLinhas;


  End;

  TERPBEcblCabecalhos= Class(TSBBEEntidades)
    Private
      Function GetERPCBLCabIdx(Idx :LongInt): TERPBECBLCab;
      Function GetERPCBLCab(pID_Vndcabdocumento: Integer): TERPBECBLCab;

    Public
      Procedure Adiciona(pObjERPCBLCab: TERPBECBLCab);
      Procedure Remove(pID_Vndcabdocumento: Integer);

      Property Elem[Idx :Longint]: TERPBECBLCab Read GetERPCBLCabIdx;
      Property ERPCBLCab[pID_Vndcabdocumento: Integer]: TERPBECBLCab Read GetERPCBLCab;
  End;

Implementation


constructor TERPBECBLCab.Create;
begin
    inherited;
    FID_Interno:=0;
    FObrigacentrocusto:=false;
    FLinhas:= TERPBECBLLinhas.Create;

end;


Destructor TERPBECBLCab.Destroy;
Begin
  If assigned(FLinhas) then
       FLinhas.Free;

  inherited;

End;

Function TERPBECBLCabecalhos.GetERPCBLCabIdx(Idx :LongInt): TERPBECBLCab;
Begin
  If Idx < Self.Num  Then
    Result := TERPBECBLCab(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TERPBECBLCabecalhos.Adiciona(pObjERPCBLCab: TERPBECBLCab);
Begin
  Self.AdicionaObj(pObjERPCBLCab);
End;

Function TERPBECBLCabecalhos.GetERPCBLCab(pID_Vndcabdocumento: Integer): TERPBECBLCab;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjERPCBLCab: TERPBECBLCab;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPCBLCab := TERPBECBLCab(Elemento[Posicao]);

    If (ObjERPCBLCab.ID_DOCInterno = pID_Vndcabdocumento) Then
      Result := ObjERPCBLCab;

    Inc(Posicao);
  End;
End;

Procedure TERPBECBLCabecalhos.Remove(pID_Vndcabdocumento: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjERPCBLCab: TERPBECBLCab;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjERPCBLCab := TERPBECBLCab(Elemento[Posicao]);

    If (ObjERPCBLCab.ID_DOCInterno = pID_Vndcabdocumento) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
