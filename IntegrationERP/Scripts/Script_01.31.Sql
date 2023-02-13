--criado em 23-06-2021
--versão Setup ERPInterf 05.09.13
UPDATE VersaoERP Set Versao='01.31'
GO
alter table tab_util
add EncomendaAutorizacao bit NOT NULL 
CONSTRAINT DF_tab_util_encaut Default 0,
EncomendaPladFondAut float not null default 0
GO



 

