--criado em 12-01-2019
--versão Setup ERPInterf 05.07.17
UPDATE VersaoERP Set Versao='01.13'
GO
alter table

ERP_Detalhes

add CODIGOUNIDADEVENDA varchar(20) null,

CODIGOUNIDADEBASE varchar(20) null,

DESCRICAOUNIDADEVENDA varchar(20) null,

DESCRICAOUNIDADEBASE varchar(20) null,

FATORCONVERSAO Float null 

GO




