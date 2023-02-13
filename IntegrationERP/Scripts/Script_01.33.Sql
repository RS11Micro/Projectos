--criado em 12-01-2023
--versão Setup ERPInterf 05.09.18
UPDATE VersaoERP Set Versao='01.33'
GO
alter table ERP_CompCab
add DataDoc datetime Null
GO
alter table ERP_CompDetalhes
add DataDoc datetime Null
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ERP_Detalhes1_qnt]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ERP_Detalhes] DROP CONSTRAINT [DF_ERP_Detalhes1_qnt]
end
GO
alter table
ERP_Detalhes
alter column [qnt] [float] NULL
GO







 

