--criado em 25-02-2022
--versão Setup ERPInterf 05.09.05
UPDATE VersaoERP Set Versao='01.28'
GO
alter TABLE [ERP_Detalhes]
add [valoriva] [decimal](19, 2)  NULL
GO
alter TABLE [ERP_Pagamentos]
add Integrado bit NOT NULL CONSTRAINT DF_ERP_Pagamentos_integrado Default 0
GO

 

