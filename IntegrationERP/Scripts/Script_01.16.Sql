--criado em 04-07-2019
--versão Setup ERPInterf 05.08.02
UPDATE VersaoERP Set Versao='01.16'
GO
alter table ERP_EMPRESAINTERFACE add DATAUltimaExportacao datetime null
,tipoPeriodExportacao int not null default 1
GO
alter table 
[ERP_EMPRESAINTERFACE]
add IDSHoteis Varchar(200) null
GO


 

