--criado em 11-10-2018
--vers?o Setup ERPInterf 05.07.09
UPDATE VersaoERP Set Versao='01.06'
GO
alter table 
erp_detalhes
drop constraint DF_ERP_Detalhes1_precounit
GO
alter table 
erp_detalhes
alter column PrecoUnit Float null
GO


