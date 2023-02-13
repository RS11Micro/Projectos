unit sysCERTBEINTERFACE;



interface

Uses SBBEEntidade,SBBEListaObjAbs, vcl.Controls,ERPBETipoCons;
Type
  tsysCERTBEINTERFACE=Class(TSBBEEntidade)
  private
       FID:Integer;
       FID_Interface:integer;
       FBDServidor:string;
       FBDUSER:string;
       FBDPASSWORD:string;
       FBDNOME:string;
       FBDConexao:string;
       FBDSchema:string;
       FAtivo:Boolean;
       FTipoRegistoDados:TFntBETipoRegistoDados;
       FTipoProjecto:TFntBETipoProjecto;
       FCaminhoXML:string;
       FCaminhoXMLSaphety:string;
	   FCaminhoPDF:string;
       Fdescricao:string;
       FMapaNomeFisicoFT:string;
       FMapaNomeFisicoNC:string;
       FDATAInicioExportacao:TdateTime;
       FTipoExportacao:Integer;
       FAdditionalDocRef:boolean;
       FBrokerYet:boolean;
       FBrokerSaphety:boolean;
       FCiusPTPDFBS64:boolean;


  Published
    Constructor Create;


    Property ID: Integer Read FID Write FID;
    Property ID_Interface: Integer Read FID_Interface Write FID_Interface;
    Property BDServidor:string  Read FBDServidor Write FBDServidor;
    Property BDUSER:string  Read FBDUSER Write FBDUSER;
    Property BDPASSWORD:string  Read FBDPASSWORD Write FBDPASSWORD;
    Property BDNOME:string  Read FBDNOME Write FBDNOME;
    Property BDConexao:string  Read FBDConexao Write FBDConexao;
    Property BDSchema:string  Read FBDSchema Write FBDSchema;
    Property Ativo:Boolean  Read FAtivo Write FAtivo;
    Property TipoRegistoDados:TFntBETipoRegistoDados  Read FTipoRegistoDados Write FTipoRegistoDados;
    Property TipoProjecto:TFntBETipoProjecto  Read FTipoProjecto Write FTipoProjecto;
    Property CaminhoXML:string  Read FCaminhoXML Write FCaminhoXML;
    Property CaminhoXMLSaphety:string  Read FCaminhoXMLSaphety Write FCaminhoXMLSaphety;
    Property CaminhoPDF:string  Read FCaminhoPDF Write FCaminhoPDF;
    Property Descricao:string  Read Fdescricao Write Fdescricao;
    Property DATAInicioExportacao:tdatetime  Read FDATAInicioExportacao Write FDATAInicioExportacao;

    Property MapaNomeFisicoFT:string  Read FMapaNomeFisicoFT Write FMapaNomeFisicoFT;
    Property MapaNomeFisicoNC:string  Read FMapaNomeFisicoNC Write FMapaNomeFisicoNC;

    Property TipoExportacao:Integer  Read FTipoExportacao Write FTipoExportacao;
    Property AdditionalDocRef:boolean  Read FAdditionalDocRef Write FAdditionalDocRef;
    Property BrokerYet:boolean  Read FBrokerYet Write FBrokerYet;
    Property BrokerSaphety:boolean  Read FBrokerSaphety Write FBrokerSaphety;
    Property CiusPTPDFBS64:boolean  Read FCiusPTPDFBS64 Write FCiusPTPDFBS64;




  End;

  tsysCERTBEINTERFACES= Class(TSBBEEntidades)
    Private
      Function GetsysCERTInterfaceIdx(Idx :LongInt): TsysCERTBEInterface;
      Function GetsysCERTInterface(pID: Integer): TsysCERTBEInterface;

    Public
      Procedure Adiciona(pObjtInterface: TsysCERTBEInterface);
      Procedure Remove(pID: Integer);

      Property Elem[Idx :Longint]: TsysCERTBEInterface Read GetsysCERTInterfaceIdx;
      Property sysCERTInterface[pID: Integer]: TsysCERTBEInterface Read GetsysCERTInterface;
  End;

Implementation

Constructor TsysCERTBEINTERFACE.Create;
begin
  inherited;
  FCiusPTPDFBS64:=false;


end;


Function TsysCERTBEInterfaces.GetsysCERTInterfaceIdx(Idx :LongInt): TsysCERTBEInterface;
Begin
  If Idx < Self.Num  Then
    Result := TsysCERTBEInterface(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TsysCERTBEInterfaces.Adiciona(pObjtInterface: TsysCERTBEInterface);
Begin
  Self.AdicionaObj(pObjtInterface);
End;

Function TsysCERTBEInterfaces.GetsysCERTInterface(pID: Integer): TsysCERTBEInterface;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjInterface: TsysCERTBEInterface;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjInterface := TsysCERTBEInterface(Elemento[Posicao]);

    If (ObjInterface.ID = pID) Then
      Result := ObjInterface;

    Inc(Posicao);
  End;
End;

Procedure TsysCERTBEInterfaces.Remove(pID: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjInterface: TsysCERTBEInterface;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjInterface := TsysCERTBEInterface(Elemento[Posicao]);

    If (ObjInterface.id = pID) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
