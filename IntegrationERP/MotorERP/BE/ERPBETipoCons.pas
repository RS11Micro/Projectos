unit ERPBETipoCons;



interface

Uses vcl.Graphics;

Type
 TClienteOperacao=(ocliInserir,ocliProcurar,ocliLimpar,ocliAlterar);

  TFntBETipoRegistoDados=(trdInterno,trdExterno);
  TFntBETipoProjecto=(tpFNT, tpOwners, tpProtel, tpOutros);
  TTipoIntegrador=(taNenhum,taToconline);
  TTipoAutenticacao=(taNone, taSimple, taBasic, taOAUTH,taOAUTH2);
  Function BD2TipoRegistoDados(pTipoRegistoDados:Integer):TFntBETipoRegistoDados;
  function BD2TipoProjecto(pTipoProjecto: integer):TFntBETipoProjecto;
  function BD2TipoAutenticacao(pTipoAutenticacao: integer):TTipoAutenticacao;
  function BD2TipoIntegrador(pTipoIntegrador: integer):TTipoIntegrador;






implementation

function BD2TipoIntegrador(pTipoIntegrador: integer):TTipoIntegrador;
begin
  case pTipoIntegrador of
    0 : result := taNenhum;
    1 : result := taToconline;
  end;
end;
function BD2TipoRegistoDados(pTipoRegistoDados: Integer): TFntBETipoRegistoDados;
begin
  case pTipoRegistoDados of
    0 : result := trdInterno;
    1 : result := trdExterno;
  end;
end;

function BD2TipoAutenticacao(pTipoAutenticacao: integer):TTipoAutenticacao;
begin
  case pTipoAutenticacao of
    0 : result := taNone;
    1 : result := taSimple;
    2 : result := taBasic;
    3 : result := taOAUTH;
    4 : result := taOAUTH2;
  end;
end;


function BD2TipoProjecto(pTipoProjecto:Integer):TFntBETipoProjecto;
begin
  case pTipoProjecto of
    0 : result := tpFNT;
    1 : result := tpOwners;
    2 : result := tpProtel;
    3 : result := tpOutros;
  end;
end;

end.



