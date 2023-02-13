--criado em 09-10-2018
--versão Setup ERPInterf 05.07.07
UPDATE VersaoERP Set Versao='01.05'
GO
alter table ERP_EMPRESAINTERFACE 
add ExpApenasComprasFechadas Bit not null default 0
GO
alter table ERP_EMPRESAINTERFACE 
alter column BDSchema varchar(50)
GO

