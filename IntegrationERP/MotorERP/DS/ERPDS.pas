unit ERPDS;
interface
uses
  SBDS,
  SBBaseDados,
  SysUtils,
  SBBSSistemaBase,
  ERPDSEMPRESAINTERFACE,
  ERPDSEmpresaSoftware,
  ERPDSAreaNegocio,
  sysCERTDSINTERFACE
;//UNIT

type


  EERODS=class (Exception);

  TERPDS=Class(TSBDS)
  private
    FEMPRESAINTERFACE:TERPDSEMPRESAINTERFACE;
    FEmpresaSoftware:TERPDSEmpresaSoftware;
    FAreaNegocio:TERPDSAreaNegocio;
    FsysCERTInterface:tsysCERTDSINTERFACE;


//VARIAVEL

    function GetEMPRESAINTERFACE:TERPDSEMPRESAINTERFACE;
    function GetEmpresaSoftware:TERPDSEmpresaSoftware;
    function GetAreaNegocio:TERPDSAreaNegocio;
    function GetsysCERTInterface:tsysCERTDSINTERFACE;




//FUNCAO

  public
  published
    constructor Create;
    destructor Destroy;override;

    property EMPRESAINTERFACE:TERPDSEMPRESAINTERFACE read GetEMPRESAINTERFACE write FEMPRESAINTERFACE;
    property EmpresaSoftware:TERPDSEmpresaSoftware read GetEmpresaSoftware write FEmpresaSoftware;
    property AreaNegocio:TERPDSAreaNegocio read GetAreaNegocio write FAreaNegocio;
    property sysCERTInterface:tsysCERTDSINTERFACE read GetsysCERTInterface write FsysCERTInterface;


//PROPRIEDADE
  end;

implementation

uses SBBETabelaDados;

destructor TERPDS.Destroy;
begin
  FreeAndNil(FEMPRESAINTERFACE);
  FreeAndNil(FAreaNegocio);
 FreeAndNil(FsysCERTInterface);

//LIVERTAROBJECTOS
  inherited;
end;

constructor TERPDS.Create;
begin
  inherited;

end;

function TERPDS.GetEMPRESAINTERFACE:TERPDSEMPRESAINTERFACE;
begin
  if not Assigned(FEMPRESAINTERFACE) then
  begin
    FEMPRESAINTERFACE:=TERPDSEMPRESAINTERFACE.Create;
    FEMPRESAINTERFACE.DSO:=Self;
  end;

  result:=FEMPRESAINTERFACE;
end;


function TERPDS.GetEmpresaSoftware:tERPDSEmpresaSoftware;
begin
  if not Assigned(FEmpresaSoftware) then
  begin
    FEmpresaSoftware:=tERPDSEmpresaSoftware.Create;
    FEmpresaSoftware.DSO:=Self;
  end;

  result:=FEmpresaSoftware;
end;


function TERPDS.GetAreaNegocio:TERPDSAreaNegocio;
begin
  if not Assigned(FAreaNegocio) then
  begin
    FAreaNegocio:=TERPDSAreaNegocio.Create;
    FAreaNegocio.DSO:=Self;
  end;

  result:=FAreaNegocio;
end;

function TERPDS.GetsysCERTInterface:tsysCERTDSINTERFACE;
begin
  if not Assigned(FsysCERTInterface) then
  begin
    FsysCERTInterface:=tsysCERTDSINTERFACE.Create;
    FsysCERTInterface.DSO:=Self;
  end;

  result:=FsysCERTInterface;

end;

end.












