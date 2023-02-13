unit CBLOperInterfaceProtel;


interface
uses ERPBEEMPRESAINTERFACE,IDGlobal,SysUtils;


Function TemExportacoes(var mensagem:string):Boolean;
Function DevolvechemaPms(var pIDInterface:Integer;var pConnectionstring:string):string;

 Function DevolveInterfaceCBL():TERPBEEMPRESAINTERFACE;
implementation
uses Ierpoglobais,sbbetabeladados;



Function TemExportacoes(var mensagem:string):Boolean;
var
   Listaex:Tsbbetabeladados;
begin
 mensagem:='';
 result:=false;
 Listaex:=sb.sbbd.abrirlv('select Top 1 id_interno  from ERP_CBLCabec where origem=1');
 Result:=not (Listaex.vazia);
 Listaex.fecha;
 Freeandnil(Listaex);
end;

Function DevolvechemaPms(var pIDInterface:Integer;var pConnectionstring:string):string;
var strsql:string;
  ProtelObjInterface,
  SysObjInterface:TERPBEEMPRESAINTERFACE;
  DescSchemaPms,
  DescSchemaSys:string;
begin
  result:='';
  ProtelObjInterface:=nil;
  pIDInterface:=0;
  ProtelObjInterface:= MotorERP.ERPInterface.InterfaceActivo('ERP_CBLPROTEL');
  If ProtelObjInterface<>nil then
  begin
   pConnectionstring:=ProtelObjInterface.BDConexao;
    Result:= ProtelObjInterface.BDSchema;
    pIDInterface:= ProtelObjInterface.id;
  end
  else
  sb.Dialogos.SBMessage('Não existe Interface CBLProtel ativo!');

end;


Function DevolveInterfaceCBL():TERPBEEMPRESAINTERFACE;
begin

  Result:=nil;
  Result:= MotorERP.ERPInterface.InterfaceActivo('ERP_CBLPROTEL');
  If Result=nil then
  sb.Dialogos.SBMessage('Não existe Interface CBLProtel ativo!');


end;
end.
