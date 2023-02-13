--criado em 26-11-2018
--versão Setup ERPInterf 05.07.15
UPDATE VersaoERP Set Versao='01.11'
GO
alter table ERP_CompCab
add TipoMov  int not null default 1
GO

