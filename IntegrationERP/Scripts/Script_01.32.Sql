--criado em 30-05-2022
--versão Setup ERPInterf 05.09.16
UPDATE VersaoERP Set Versao='01.32'
GO
 alter table ERP_EMPRESAINTERFACE
 add NaoParaInterfaceAutCompras bit not null default 0 

GO
IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='PRIMAVERA_ID'and

sys.objects.object_id= OBJECT_ID(N'[dbo].ERP_CompCab') AND type in (N'U'))

alter table ERP_CompCab

add [PRIMAVERA_ID] [uniqueidentifier] NULL

GO

 

IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='PRIMAVERA_NumDoc'and

sys.objects.object_id= OBJECT_ID(N'[dbo].ERP_CompCab') AND type in (N'U'))

alter table ERP_CompCab

add [PRIMAVERA_NumDoc] [int] NULL

GO    

IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='PRIMAVERA_TipoDoc'and

sys.objects.object_id= OBJECT_ID(N'[dbo].ERP_CompCab') AND type in (N'U'))

alter table ERP_CompCab

add PRIMAVERA_TipoDoc [varchar](5) NULL

GO

IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='PRIMAVERA_Serie'and

sys.objects.object_id= OBJECT_ID(N'[dbo].ERP_CompCab') AND type in (N'U'))

alter table ERP_CompCab

add PRIMAVERA_Serie [varchar](5) NULL

GO

 

IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='EncomendaAutorizacao'and

sys.objects.object_id= OBJECT_ID(N'[dbo].tab_util') AND type in (N'U'))

alter table tab_util

add EncomendaAutorizacao bit NOT NULL 

GO

 

IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='EncomendaPladFondAut'and

sys.objects.object_id= OBJECT_ID(N'[dbo].tab_util') AND type in (N'U'))

alter table tab_util

add EncomendaPladFondAut float not null default 0

GO

  




 

