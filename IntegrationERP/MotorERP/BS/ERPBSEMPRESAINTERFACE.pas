unit ERPBSEMPRESAINTERFACE;

Interface
Uses  SBBSEntidade,ERPBEEMPRESAINTERFACE;

Type

  TERPBSEMPRESAINTERFACE=Class(TSBBSEntidade)
  Public
    Function Edita(pID: Integer): TERPBEEMPRESAINTERFACE;
    Function ERPInterfaces(): TERPBEEMPRESAINTERFACEs;
    Procedure Actualiza(pObjInterface : TERPBEEMPRESAINTERFACE; Erros: String);
    Procedure Remove(pID: Integer);
    Function ValidaActualizacao(pObjInterface : TERPBEEMPRESAINTERFACE; var strErros: String): Boolean;
    Function InterfaceActivo(pNomeInterface:string): TERPBEEMPRESAINTERFACE;
    Function ExisteInterfaceActivo(pNomeInterface:string): boolean;
    Function DAID_InterfaceActivo(pNomeInterface:string):integer;
    Function Clone(pObjInterface: TERPBEEMPRESAINTERFACE): TERPBEEMPRESAINTERFACE;

  End;

Implementation

Uses ERPBS, SysUtils, SBBEAtributoObrigatorio, SBBEExcepcoes,
  ERPDS;

Const
  Separador=',';


Function TERPBSEMPRESAINTERFACE.Clone(pObjInterface: TERPBEEMPRESAINTERFACE): TERPBEEMPRESAINTERFACE;
Begin
  Result := TERPBEEMPRESAINTERFACE.Create;
  Result.ID:=pObjInterface.ID;
 Result.ID_Interface:=pObjInterface.ID_Interface;
 Result.BDServidor:=pObjInterface.BDServidor;
 Result.BDUSER:=pObjInterface.BDUSER;
 Result.BDPASSWORD:=pObjInterface.BDPASSWORD;
 Result.BDNOME:=pObjInterface.BDNOME;
 Result.BDConexao:=pObjInterface.BDConexao;
 Result.BDSchema:=pObjInterface.BDSchema;
 Result.ID_clienteIndiFerenciado:=pObjInterface.ID_clienteIndiFerenciado;
 Result.Ativo:=pObjInterface.Ativo;
 Result.IDSCentrosExploracao:=pObjInterface.IDSCentrosExploracao;
 Result.ExpApenasComprasFechadas:=pObjInterface.ExpApenasComprasFechadas;
 Result.DATAInicioExportacao:= pObjInterface.DATAInicioExportacao;
 Result.IDSHoteis:= pObjInterface.IDSHoteis;


 Result.Ativo:= pObjInterface.Ativo;
 Result.PrefixoContCblAartigo:= pObjInterface.PrefixoContCblAartigo;
 Result.ExpApenasComprasFechadas:= pObjInterface.ExpApenasComprasFechadas;
 Result.DATAInicioExportacao:= pObjInterface.DATAInicioExportacao;
 Result.DATAUltimaExportacao:= pObjInterface.DATAUltimaExportacao;
 Result.tipoPeriodExportacao:= pObjInterface.tipoPeriodExportacao;
 Result.TipoCtrlCodClienteCC:= pObjInterface.TipoCtrlCodClienteCC;
 Result.descricao:= pObjInterface.descricao;
 Result.ID_InterfaceIMC:= pObjInterface.ID_InterfaceIMC;
 Result.nomeInterface:= pObjInterface.nomeInterface;
 Result.PeriodoIVA:= pObjInterface.PeriodoIVA;
 Result.ID_PagamentoCC:= pObjInterface.ID_PagamentoCC;
 Result.ExpEncomendas:= pObjInterface.ExpEncomendas;
 Result.ExpInventarioAgrpArmProd:= pObjInterface.ExpInventarioAgrpArmProd;
 Result.DataIniExpEncomendas:= pObjInterface.DataIniExpEncomendas;

 Result.DataIniExpAdiantamentosPMS:= pObjInterface.DataIniExpAdiantamentosPMS;
 Result.exportaAdiantamentosPMS:= pObjInterface.exportaAdiantamentosPMS;
 Result.Namelinkedserver:= pObjInterface.Namelinkedserver;

 Result.ObgLinhaContaERPProd:= pObjInterface.ObgLinhaContaERPProd;
 Result.ObgLinhaContaERPIVA:= pObjInterface.ObgLinhaContaERPIVA;
 Result.ObgLinhaContaERPAreaNeg:= pObjInterface.ObgLinhaContaERPAreaNeg;
 Result.ObgLinhaContaERPModPag:= pObjInterface.ObgLinhaContaERPModPag;
 Result.ObgContaERPCliente:= pObjInterface.ObgContaERPCliente;
 Result.NaoParaInterfaceAutCompras:= pObjInterface.NaoParaInterfaceAutCompras;


End;




Function TERPBSEMPRESAINTERFACE.DAID_InterfaceActivo(pNomeInterface:string):integer;
 begin
 result:=TERPBS(BSO).DSO.EMPRESAINTERFACE.DAID_InterfaceActivo(pNomeInterface);
end;


Function TERPBSEMPRESAINTERFACE.ExisteInterfaceActivo(pNomeInterface:string): boolean;
begin
 result:=TERPBS(BSO).DSO.EMPRESAINTERFACE.ExisteInterfaceActivo(pNomeInterface);
end;

Function TERPBSEMPRESAINTERFACE.InterfaceActivo(pNomeInterface:string): TERPBEEMPRESAINTERFACE;
begin
 result:=TERPBS(BSO).DSO.EMPRESAINTERFACE.InterfaceActivo(pNomeInterface);
end;

Procedure TERPBSEMPRESAINTERFACE.Actualiza(pObjInterface :TERPBEEMPRESAINTERFACE; Erros :String);
Begin
  With TERPBS(BSO) Do
  Begin
    If ValidaActualizacao(pObjInterface, Erros) Then
    Begin
      SB.SBBD.IniciaTransacao;
      Try

        DSO.EMPRESAINTERFACE.Actualiza(pObjInterface, Erros);

        SB.SBBD.TerminaTransacao;
      Except
        SB.SBBD.DesfazTransacao;
        raise;
      End;
    End
    Else
      Raise EErroDetalhe.Create('FntBSFntInterface', 'Actualiza', SB.Idioma.daTraducao(603, 'Validação'), Erros);
  End
End;

Procedure TERPBSEMPRESAINTERFACE.Remove(pID:Integer);
Begin
  With Terpbs(BSO) Do
  Begin
    SB.SBBD.IniciaTransacao;
    Try
      DSO.EMPRESAINTERFACE.Remove(pID);

      SB.SBBD.TerminaTransacao;
    Except
      On E :Exception Do
      Begin
        SB.SBBD.DesfazTransacao;
        Raise EErroNormal.Create('FntERpEmpresaInterface', 'Remove', E.Message);
      End;
    End;
  End;
End;

Function TERPBSEMPRESAINTERFACE.Edita(pID: Integer):TERPBEEMPRESAINTERFACE;
Begin
  Result := TERPBS(BSO).DSO.EMPRESAINTERFACE.Edita(pID);
End;

Function TERPBSEMPRESAINTERFACE.ERPInterfaces(): TERPBEEMPRESAINTERFACEs;
Begin
  Result := TERPBS(BSO).DSO.EMPRESAINTERFACE.ERPInterfaces;
End;

Function TERPBSEMPRESAINTERFACE.ValidaActualizacao(pObjInterface :TERPBEEMPRESAINTERFACE; var strErros: String): Boolean;
Var
  i: longInt;
  FAtributo: TSBBEAtributoObrigatorio;
  FAtributos: TSBBEAtributosObrigatorios;
Begin
  strErros := '';

  With pObjInterface Do
  Begin
    FAtributos := AtributosObrigatorios;
    If Assigned(FAtributos) Then
    Begin
      For i:=0 to FAtributos.Num-1 Do
      Begin
          FAtributo := FAtributos.ElemAtributoObrigatorio[i];
          If Not TemValorPropriedade(FAtributo.Nome) Then
              strErros := strErros + TERPBS(BSO).SB.Idioma.daTraducao(FAtributo.ID_Idioma,FAtributo.Descricao) + Separador;
      End;
    End;
    If  BDSchema='' then
    begin
      strErros := strErros + 'Schema da base de dados' + Separador;
    end;
    If  BDNOME='' then
    begin
      strErros := strErros + 'Nome da base de dados' + Separador;
    end;
    If  BDServidor='' then
    begin
      strErros := strErros + 'Servidor da base de dados' + Separador;
    end;
    If  BDUSER='' then
    begin
      strErros := strErros + 'Utilizador da base de dados' + Separador;
    end;




  End;

  Result := (strErros = '');
  strErros := strErros + '.';
End;

End.

