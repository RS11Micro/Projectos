--criado em 18-05-2022
--vers?o Setup ERPInterf 05.09.06
UPDATE VersaoERP Set Versao='01.29'
GO
alter table
ERP_EMPRESAINTERFACE
add namelinkedserver varchar(20) null
GO

 



 

