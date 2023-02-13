library RSADll;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses

  SysUtils,
  Classes,
  StrUtils,
  CHILKATCERTIFICATELib_TLB,
  CHILKATRSALib_TLB;


//NÃO POSSO FAZER REFERENCIA AO COMPONENTE DENTRO DO BS..
{Function InicializaRSA(pForm: TForm; pChavePrivada: String; var pErro: Integer): TChilkatRsa;
Var
  ChavePrivada: TprivateKey;
Begin
  Result := TChilkatRsa.Create(pForm);
  Result.Charset := 'UTF-8';
  Result.EncodingMode := 'Base-64';
  Result.LittleEndian := 0;
  Result.OaepPadding := 0;

  pErro := Result.UnlockComponent('MICRONRSA_UqpPRP4e4Tud');

  If (pErro = 1) Then
  Begin
    ChavePrivada := TprivateKey.Create(pForm);
    ChavePrivada.LoadXml(pChavePrivada);

    pErro := Result.ImportPrivateKey(ChavePrivada.GetXml);
  End;
End;

Function GeraAssinatura(pRsa: TChilkatRsa; pTexto: String): String;
Begin
  Result := pRsa.SignStringENC(pTexto, 'sha-1');
End;

Procedure FinalizaRSA(pRsa: TChilkatRsa);
Begin
  pRsa.Destroy;

  FreeAndNil(pRsa);
End; }

Function GeraAssinatura(pChavePrivada, pTexto: PChar; Var pErro: Integer): PChar; export; stdcall;
Var
  Rsa: TChilkatRsa;
  Assinatura: String;
  ChavePrivada: TprivateKey;
Begin
  Assinatura := '';
  Rsa := TChilkatRsa.Create(Nil);
  Rsa.Charset := 'utf-8';
  Rsa.LittleEndian := 0;
  Rsa.OaepPadding := 0;

  pErro := Rsa.UnlockComponent('MICRONRSA_UqpPRP4e4Tud');

  If (pErro = 1) Then
  Begin
    ChavePrivada := TprivateKey.Create(Nil);
    ChavePrivada.LoadXml(pChavePrivada);
    pErro := Rsa.ImportPrivateKey(ChavePrivada.GetXml);

    If pErro = 1 Then
    Begin
      Assinatura := Rsa.SignStringENC(pTexto, 'sha-1');
    End;
  End;

  Assinatura := LeftStr(Assinatura, 172);

  Result := PChar(Assinatura);
  Rsa.Destroy;
End;

Function AssinaturaValida(pChavePrivada, pTexto, pAssinatura: PChar; Var pErro: Integer): Boolean; export; stdcall;
Var
  Rsa: TChilkatRsa;
  Assinatura: String;
  ChavePrivada: TprivateKey;
Begin
  Assinatura := '';
  Rsa := TChilkatRsa.Create(Nil);
  Rsa.Charset := 'utf-8';
  Rsa.LittleEndian := 0;
  Rsa.OaepPadding := 0;

  pErro := Rsa.UnlockComponent('MICRONRSA_UqpPRP4e4Tud');

  If (pErro = 1) Then
  Begin
    ChavePrivada := TprivateKey.Create(Nil);
    ChavePrivada.LoadXml(pChavePrivada);
    pErro := Rsa.ImportPrivateKey(ChavePrivada.GetXml);

    If pErro = 1 Then
      Result := (Rsa.VerifyStringENC(pTexto, 'sha-1', pAssinatura) = 1);

  End;

  Rsa.Destroy;
End;

exports GeraAssinatura, AssinaturaValida;

begin

end.

