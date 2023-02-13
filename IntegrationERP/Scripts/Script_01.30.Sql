--criado em 23-06-2021
--versão Setup ERPInterf 05.09.07
UPDATE VersaoERP Set Versao='01.30'
GO
alter table ERP_EMPRESAINTERFACE
add  ObgLinhaContaERPProd  bit NOT NULL CONSTRAINT DF_ERP_ObgContaERPProd Default 1,
ObgLinhaContaERPIVA  bit NOT NULL CONSTRAINT DF_ERP_ObgContaERPIVA Default 1, 
ObgContaERPCliente  bit NOT NULL CONSTRAINT DF_ERP_ObgContaERPCliente Default 1,
ObgLinhaContaERPAreaNeg  bit NOT NULL CONSTRAINT DF_ERP_ObgContaERPAreaNeg Default 1,
ObgLinhaContaERPModPag  bit NOT NULL CONSTRAINT DF_ERP_ObgContaERPModoPag Default 1
GO



 

