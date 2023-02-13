--criado em 14-10-2020
--versão Setup ERPInterf 05.08.27
UPDATE VersaoERP Set Versao='01.23'
GO
alter table ERP_CBLCMPCabec

add CODPais [varchar](30) NULL,

DescPais [varchar](100) NULL, 

Mercado [int] NULL,

DescMercado [varchar](200) NULL

GO

alter table ERP_CompCab

add CODPais [varchar](30) NULL,

DescPais [varchar](100) NULL, 

Mercado [int] NULL,

DescMercado [varchar](200) NULL

GO

