unit ERPBS;


interface

uses
  Classes,
  ERPDS,
  sysutils,
  SBBSSistemaBase,
  SBBS,
  ERPBSEMPRESAINTERFACE,
  ERPBSEMPRESASOFTWARE,
  ERPBSAreaNegocio,
  sysCERTBSINTERFACE
  ;//UNIT

type
  EERPBS=Class(Exception);

  TERPBS=Class(TSBBS)
  private
    FDSO: TERPDS;
    FERPInterface:TERPBSEMPRESAINTERFACE;
    FEMPRESASOFTWARE:tERPBSEMPRESASOFTWARE;
    FAreaNegocio:TERPBSAreaNegocio;
    FsysCERTINTERFACE:TsysCERTBSINTERFACE;
    //VARIAVEL
    Function GetERPInterface: TERPBSEMPRESAINTERFACE;
    Function GetEMPRESASOFTWARE: TERPBSEMPRESASOFTWARE;
    Function GetAreaNegocio: TERPBSAreaNegocio;
    Function GetsysCERTBSINTERFACE: TsysCERTBSINTERFACE;


    //FUNCAO

  protected
    procedure SetSistemaBase(pValor:TSBBSSistemaBase);override;

  public
    constructor Create;
    destructor Destroy;override;

    property DSO: TERPDS read FDSO write FDSO;


    Property ERPInterface: TERPBSEMPRESAINTERFACE Read GetERPInterface Write FERPInterface;
    Property EMPRESASOFTWARE: TERPBSEMPRESASOFTWARE Read GetEMPRESASOFTWARE Write FEMPRESASOFTWARE;

    Property AreaNegocio: TERPBSAreaNegocio Read GetAreaNegocio Write FAreaNegocio;

    Property sysCERTINTERFACE: TsysCERTBSINTERFACE Read GetsysCERTBSINTERFACE Write FsysCERTINTERFACE;





    //PROPRIEDADE

  end;

implementation

uses SBBSExceptions;

procedure TERPBS.SetSistemaBase(pValor:TSBBSSistemaBase);
begin
    FSistemaBase:=pValor;
    FDSO.SB:=FSistemaBase.DSO;
end;

constructor TERPBS.Create;
begin
    inherited;
    FDSO:=TERPDS.Create;

end;

destructor TERPBS.Destroy;
begin
  inherited;
  FDSO.Free;
  FreeAndNil(FERPInterface);
  FreeAndNil(FAreaNegocio);
  //LIVERTAROBJECTOS

end;





Function TERPBS.GetERPInterface: TERPBSEMPRESAINTERFACE;
Begin
  If Not Assigned(FERPInterface) Then
  Begin
    FERPInterface := TERPBSEMPRESAINTERFACE.Create;
    FERPInterface.BSO := Self;
    FERPInterface.DSE := DSO.EMPRESAINTERFACE;
  End;
  Result := FERPInterface;
End;

Function TERPBS.GetEMPRESASOFTWARE: TERPBSEMPRESASOFTWARE;
Begin
  If Not Assigned(FEMPRESASOFTWARE) Then
  Begin
    FEMPRESASOFTWARE := TERPBSEMPRESASOFTWARE.Create;
    FEMPRESASOFTWARE.BSO := Self;
    FEMPRESASOFTWARE.DSE := DSO.EmpresaSoftware;
  End;
  Result := FEMPRESASOFTWARE;
End;

Function TERPBS.GetAreaNegocio: TERPBSAreaNegocio;
Begin
  If Not Assigned(FAreaNegocio) Then
  Begin
    FAreaNegocio := TERPBSAreaNegocio.Create;
    FAreaNegocio.BSO := Self;
    FAreaNegocio.DSE := DSO.AreaNegocio;
  End;
  Result := FAreaNegocio;
End;


Function TERPBS.GetsysCERTBSINTERFACE: TsysCERTBSINTERFACE;
Begin
  If Not Assigned(FsysCERTINTERFACE) Then
  Begin
    FsysCERTINTERFACE := TsysCERTBSINTERFACE.Create;
    FsysCERTINTERFACE.BSO := Self;
    FsysCERTINTERFACE.DSE := DSO.sysCERTINTERFACE;
  End;
  Result := FsysCERTINTERFACE;
End;

//DEFFUNCAO


end.

