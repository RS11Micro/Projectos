unit ERPBEEMPRESAINTERFACE;

interface

Uses SBBEEntidade,SBBEListaObjAbs, vcl.Controls;
Type
  TERPBEEMPRESAINTERFACE=Class(TSBBEEntidade)
  private
       FID:Integer;
       FID_Interface:integer;
       FBDServidor:string;
       FBDUSER:string;
       FBDPASSWORD:string;
       FBDNOME:string;
       FBDConexao:string;
       FBDSchema:string;
       FID_clienteIndiferenciado:string;
       FIDSCentrosExploracao:String;
       FIDSHoteis:string;
       FAtivo:Boolean;
       FPrefixoContCblAartigo:String;
       FExpApenasComprasFechadas:Boolean;
       FDATAInicioExportacao:Tdatetime;
       FDATAUltimaExportacao:Tdatetime;
       FtipoPeriodExportacao:integer;
       Fdescricao:string;
       FID_InterfaceIMC:integer;
       FnomeInterface:string;//apoio
       FPeriodoIVA:Integer;
       FTipoCtrlCodClienteCC:Integer;
        { FTipoCtrlCodClienteCC:
          0=exporta "nrcliente"= "Conta Saco"
          1=exporta sem preencher "nrcliente"
          2=não exporta e avisa}
       FID_PagamentoCC:integer;//pagamento conta corrente pms
       FExpInventarioAgrpArmProd:Boolean;
       FExpEncomendas:Boolean;
       FDataIniExpEncomendas:TDatetime;
       FexportaAdiantamentosPMS:boolean;
       FDataIniExpAdiantamentosPMS:Tdatetime;
       FNamelinkedserver:string;

       FObgLinhaContaERPProd:Boolean;
       FObgLinhaContaERPIVA:Boolean;
       FObgLinhaContaERPAreaNeg:Boolean;
       FObgLinhaContaERPModPag:Boolean;
       FObgContaERPCliente:Boolean;
       FNaoParaInterfaceAutCompras:boolean;
       FOrigem:Integer;




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
    Property ID_clienteIndiferenciado: string Read FID_clienteIndiferenciado Write FID_clienteIndiferenciado;
    Property IDSCentrosExploracao:string  Read FIDSCentrosExploracao Write FIDSCentrosExploracao;
    Property IDSHoteis:string  Read FIDSHoteis Write FIDSHoteis;

    Property PrefixoContCblAartigo:string  Read FPrefixoContCblAartigo Write FPrefixoContCblAartigo;
    Property ExpApenasComprasFechadas:Boolean  Read FExpApenasComprasFechadas Write FExpApenasComprasFechadas;
    Property DATAInicioExportacao:Tdatetime read FDATAInicioExportacao  write FDATAInicioExportacao;

    Property ID_InterfaceIMC:integer  Read FID_InterfaceIMC Write FID_InterfaceIMC;
    Property Descricao:string  Read Fdescricao Write Fdescricao;
    Property nomeInterface:string  Read FnomeInterface Write FnomeInterface;

    Property PeriodoIVA:integer  Read FPeriodoIVA Write FPeriodoIVA;

    Property DATAUltimaExportacao:Tdatetime read FDATAUltimaExportacao  write FDATAUltimaExportacao;
    Property TipoPeriodExportacao:integer  Read FtipoPeriodExportacao Write FtipoPeriodExportacao;
    Property TipoCtrlCodClienteCC:integer  Read FTipoCtrlCodClienteCC Write FTipoCtrlCodClienteCC;
    Property ID_PagamentoCC:integer  Read FID_PagamentoCC Write FID_PagamentoCC;
    Property ExpInventarioAgrpArmProd:Boolean  Read FExpInventarioAgrpArmProd Write FExpInventarioAgrpArmProd;
    Property ExpEncomendas:Boolean  Read FExpEncomendas Write FExpEncomendas;
    Property DataIniExpEncomendas:Tdatetime read FDataIniExpEncomendas  write FDataIniExpEncomendas;

    Property exportaAdiantamentosPMS:Boolean  Read FexportaAdiantamentosPMS Write FexportaAdiantamentosPMS;
    Property DataIniExpAdiantamentosPMS:Tdatetime read FDataIniExpAdiantamentosPMS  write FDataIniExpAdiantamentosPMS;
    Property Namelinkedserver:string  Read FNamelinkedserver Write FNamelinkedserver;


    Property ObgContaERPCliente:Boolean  Read FObgContaERPCliente Write FObgContaERPCliente;
    Property ObgLinhaContaERPProd:Boolean  Read FObgLinhaContaERPProd Write FObgLinhaContaERPProd;
    Property ObgLinhaContaERPIVA:Boolean  Read FObgLinhaContaERPIVA Write FObgLinhaContaERPIVA;
    Property ObgLinhaContaERPAreaNeg:Boolean  Read FObgLinhaContaERPAreaNeg Write FObgLinhaContaERPAreaNeg;
    Property ObgLinhaContaERPModPag:Boolean  Read FObgLinhaContaERPModPag Write FObgLinhaContaERPModPag;
    Property NaoParaInterfaceAutCompras:Boolean  Read FNaoParaInterfaceAutCompras Write fNaoParaInterfaceAutCompras;
    Property Origem: Integer Read FOrigem Write FOrigem;





  End;

  TERPBEEmpresaInterfaces= Class(TSBBEEntidades)
    Private
      Function GetERPInterfaceIdx(Idx :LongInt): TERPBEEmpresaInterface;
      Function GetERPInterface(pID: Integer): TERPBEEmpresaInterface;

    Public
      Procedure Adiciona(pObjtInterface: TERPBEEmpresaInterface);
      Procedure Remove(pID: Integer);

      Property Elem[Idx :Longint]: TERPBEEmpresaInterface Read GetERPInterfaceIdx;
      Property ERPInterface[pID: Integer]: TERPBEEmpresaInterface Read GetERPInterface;
  End;

Implementation

Constructor TERPBEEMPRESAINTERFACE.Create;
begin
  inherited;

   FObgLinhaContaERPProd:=true;
   FObgLinhaContaERPIVA:=true;
   FObgLinhaContaERPAreaNeg:=true;
   FObgLinhaContaERPModPag:=true;
   FObgContaERPCliente:=true;
   FNaoParaInterfaceAutCompras:=false;


end;


Function TERPBEEmpresaInterfaces.GetERPInterfaceIdx(Idx :LongInt): TERPBEEmpresaInterface;
Begin
  If Idx < Self.Num  Then
    Result := TERPBEEmpresaInterface(Self.Elemento[Idx])
  Else
    Result := nil;
End;

Procedure TERPBEEmpresaInterfaces.Adiciona(pObjtInterface: TERPBEEmpresaInterface);
Begin
  Self.AdicionaObj(pObjtInterface);
End;

Function TERPBEEmpresaInterfaces.GetERPInterface(pID: Integer): TERPBEEmpresaInterface;
Var
  Posicao,
  TotalPosicoes :LongInt;
  ObjInterface: TERPBEEmpresaInterface;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;
  Result := nil;

  While (Result = nil) And (Posicao < TotalPosicoes) Do
  Begin
    ObjInterface := TERPBEEmpresaInterface(Elemento[Posicao]);

    If (ObjInterface.ID = pID) Then
      Result := ObjInterface;

    Inc(Posicao);
  End;
End;

Procedure TERPBEEmpresaInterfaces.Remove(pID: Integer);
Var
  Posicao,
  TotalPosicoes :LongInt;
  Enc :Boolean;
  ObjInterface: TERPBEEmpresaInterface;
Begin
  Posicao := 0;
  TotalPosicoes := Self.Num;

  Enc := False;

  While (not Enc) And (Posicao < TotalPosicoes) Do
  Begin
    ObjInterface := TERPBEEmpresaInterface(Elemento[Posicao]);

    If (ObjInterface.id = pID) Then
    Begin
      Enc := True;
      RemoveObj(Posicao);
    End;

    Inc(Posicao);
  End;
End;

End.
