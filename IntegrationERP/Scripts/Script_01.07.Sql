--criado em 19-10-2018
--versão Setup ERPInterf 05.07.10
UPDATE VersaoERP Set Versao='01.07'
GO
alter table
erp_cab
add TOTALIVA decimal(19,2) null
GO

