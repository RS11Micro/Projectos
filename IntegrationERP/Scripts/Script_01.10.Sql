--criado em 26-11-2018
--versão Setup ERPInterf 05.07.14
UPDATE VersaoERP Set Versao='01.10'
GO
alter table
ERP_Detalhes
add TipoArtigo Varchar(1) null
GO
alter table
ERP_CompDetalhes
add TipoArtigo Varchar(1) null
GO
INSERT INTO Contadores(Nome_tabela,ID_Corrente,Descricao)
VALUES('ERP_CabInventario',0,'Imp.Inventarios')
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ERP_CabInventario]') AND type in (N'U'))
DROP TABLE [dbo].[ERP_CabInventario]
GO
CREATE TABLE [dbo].[ERP_CabInventario](

      [ID_Inventario] [int] NOT NULL,

      [DataExportacao] [datetime] NOT NULL,

      [DataInicio] [datetime] NOT NULL,

      [DataFim] [datetime] NOT NULL,

      [Id_interno] [int] NULL,

      [Descricao] [varchar](200) NULL,

      [Integrado] [bit] NULL,

      [DataHoraIntegracao] [datetime] NULL,

CONSTRAINT [PK_Erp_CabInventario] PRIMARY KEY CLUSTERED 

(

      [ID_Inventario] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]

) ON [PRIMARY]

 

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Erp_LinhasInventario]') AND type in (N'U'))

DROP TABLE [dbo].[Erp_LinhasInventario]

GO

CREATE TABLE [dbo].[Erp_LinhasInventario](

      [ID_Inventario] [int] NOT NULL,

      [ID_Produto] [int] NOT NULL,

      [ID_Unidade] [int] NULL,

      [Qtd] [float] NULL,

      [PrecoMedioProduto] [float] NULL,

      [ValorLinhaSemIVA] [float] NULL,

      [ContaERP] [varchar](50) NULL,

      [Id_interno] [int] NULL,

      [DescricaoProduto] [varchar](250) NULL,

CONSTRAINT [PK_Erp_LinhasInventario] PRIMARY KEY CLUSTERED 

(

      [ID_Inventario] ASC,

      [ID_Produto] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]

) ON [PRIMARY]

GO

 

