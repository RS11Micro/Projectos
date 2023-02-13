--criado em 15-12-2020
--versão Setup ERPInterf 05.09.03
UPDATE VersaoERP Set Versao='01.26'
GO
IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='Email'and

sys.objects.object_id= OBJECT_ID(N'[dbo].tab_util') AND type in (N'U'))

alter table tab_util

add Email varchar(500)

GO

