unit ERPLogOperacoes;

interface
Procedure RegistaLogOperacao(pDescricao:string);
implementation
uses Ierpoglobais,strutils,math, SBBSSistemaBase, SBBEUtilizador,
  SBBSUtilSQL,SysUtils;

Procedure RegistaLogOperacao(pDescricao:string);
var
strsql:string;
begin
        strsql:='INSERT INTO[LogOperacoes]'
                   +'([Utilizador]'
                   +',[Data]'
                   +',[Hora]'
                   +',[NomeBD]'
                   +',[Descricao])'
        +'     VALUES('
        + sb.UtilSQL.StrToSQLStrpelica(sb.UtilizadorActual.Login)
        +','+ sb.UtilSQL.DataToSQLData(sb.DataSistema)
        +','+ sb.UtilSQL.DateTimeToSQLDataHora(time)
        +','+ sb.UtilSQL.StrToSQLStrpelica(sb.SBBD.NomeBD)
        +','+sb.UtilSQL.StrToSQLStrpelica(pDescricao)
        +')';
        sb.SBBD.Executa(strsql);

end;


end.
 