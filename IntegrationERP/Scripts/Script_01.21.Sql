--criado em 11-03-2020
--versão Setup ERPInterf 05.08.26
UPDATE VersaoERP Set Versao='01.21'
GO

alter table ERP_EMPRESAINTERFACE

add  ExpInventarioAgrpArmProd  bit not null  default 0

GO

alter table  ERP_LinhasInventario

add 

id_armazem int not  null default 0,

Armazem varchar(200) null,

ID_ArmazemERP varchar(10) null

GO

 IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Erp_LinhasInventario]') AND name = N'PK_Erp_LinhasInventario')

ALTER TABLE [dbo].[Erp_LinhasInventario] DROP CONSTRAINT [PK_Erp_LinhasInventario]

GO

 

/****** Object:  Index [PK_Erp_LinhasInventario]    Script Date: 03/10/2020 12:23:08 ******/

ALTER TABLE [dbo].[Erp_LinhasInventario] ADD  CONSTRAINT [PK_Erp_LinhasInventario] PRIMARY KEY CLUSTERED 

(

                [ID_Inventario] ASC,

                ID_armazem asc,

                [ID_Produto] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]

GO

alter table ERP_CompDetalhes

add ID_InternoOrigem int null

, ID_movimentoOrigem int null

, ID_LinhaOrigem int null

GO

 
