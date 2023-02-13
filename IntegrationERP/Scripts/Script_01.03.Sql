--criado em 31-07-2018
--versão Setup ERPInterf 05.07.05
UPDATE VersaoERP Set Versao='01.03'
GO
 

INSERT INTO [ERP_Interface]

           ([ID_Interface]

           ,[NomeInterface]

           ,[Descricao])

     VALUES

           (3,

           'ERP_ComprasSYSCONTROLLER'

           ,'Exportação de Compras SYSCONTROLLER')

GO

INSERT INTO [Contadores]

           ([Nome_tabela]

           ,[ID_Corrente]

           ,[Descricao])

     VALUES

           ('ERP_CompCAB'

           ,0

           ,'Id Interno da Tabela de compras')

GO

 

 

 

CREATE TABLE [dbo].[ERP_CompCab](

                [ID_Interno] [int] NOT NULL,

                [typedoc] [varchar](5) NULL,

                [Serie] [varchar](10) NULL,

                [ID_Movimento] [int] NULL,

                [NumDocumento] [varchar](60) NULL,

                [Data] [datetime] NOT NULL,

                [DataVenc] [datetime] NOT NULL,

                [IDCliente] [int] NOT NULL,

                [Nrcliente] [varchar](15) NULL,

                [Status] [varchar](1) NULL,

                [Assinatura] [varchar](255) NULL,

                [Chave] [varchar](255) NULL,

                [Nome] [varchar](150) NULL,

                [Morada] [varchar](150) NULL,

                [localidade] [varchar](150) NULL,

                [CodPostal] [varchar](150) NULL,

                [NIF] [varchar](25) NULL,

                [TotalIVA] [decimal](19, 2) NOT NULL,

                [TotalSEMIVA] [decimal](19, 2) NOT NULL,

                [TotalCOMIVA] [decimal](19, 2) NOT NULL,

                [Integrado] [bit] NULL,

                [DataHoraIntegracao] [datetime] NULL,

                [Origem] [int] NOT NULL,

                [DataHoraRegisto] [datetime] NULL,

                [TotalLinhas] [int] NULL,

                [UtilizadorRegisto] [varchar](30) NULL

) ON [PRIMARY]

SET ANSI_PADDING ON

ALTER TABLE [dbo].[ERP_CompCab] ADD [DescTipoMovimento] [varchar](100) NULL

/****** Object:  Index [PK_ERP_CabComp]    Script Date: 10/04/2018 16:57:44 ******/

ALTER TABLE [dbo].[ERP_CompCab] ADD  CONSTRAINT [PK_ERP_CabComp] PRIMARY KEY CLUSTERED 

(

                [ID_Interno] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

 

GO

 

CREATE TABLE [dbo].[ERP_CompDetalhes](

                [ID_Interno] [int] NOT NULL,

                [ID_Movimento] [int] NULL,

                [ID_Linha] [int] NOT NULL,

                [Serie] [varchar](10) NULL,

                [NumDocumento] [varchar](60) NULL,

                [datainv] [datetime] NULL,

                [Data] [datetime] NOT NULL,

                [servico] [varchar](8) NULL,

                [Descritivo] [varchar](150) NULL,

                [qnt] [float] NOT NULL,

                [ValorUnitSemIVA] [float] NOT NULL,

                [ValorTotalSemIVA] [float] NOT NULL,

                [ValorTotalIVA] [float] NOT NULL,

                [ValorTotalComIVA] [float] NOT NULL,

                [codiva] [varchar](4) NULL,

                [taxaiva] [decimal](19, 2) NOT NULL,

                [ID_Armazem] [int] NULL,

                [Armazem] [varchar](200) NULL,

                [ID_ArmazemERP] [varchar](5) NULL,

                [CCusto] [varchar](10) NULL,

                [CodIsencao] [varchar](4) NULL,

                [Descontoperc] [decimal](19, 2) NOT NULL,

                [DescontoValor] [decimal](19, 2) NOT NULL,

                [Origem] [int] NOT NULL,

CONSTRAINT [PK_ERP_DetalhesComp1] PRIMARY KEY CLUSTERED 

(

                [ID_Interno] ASC,

                [ID_Linha] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

 

GO

 

ALTER TABLE [dbo].[ERP_CompDetalhes]  WITH CHECK ADD  CONSTRAINT [FK_CompDetalhes_Cabecalho] FOREIGN KEY([ID_Interno])

REFERENCES [dbo].[ERP_CompCab] ([ID_Interno])

GO

 

ALTER TABLE [dbo].[ERP_CompDetalhes] CHECK CONSTRAINT [FK_CompDetalhes_Cabecalho]

GO

 

ALTER TABLE [dbo].[ERP_CompDetalhes]  WITH CHECK ADD  CONSTRAINT [FK_ERP_CompDetalhes_ERP_CompCab1] FOREIGN KEY([ID_Interno])

REFERENCES [dbo].[ERP_CompCab] ([ID_Interno])

GO

 

ALTER TABLE [dbo].[ERP_CompDetalhes] CHECK CONSTRAINT [FK_ERP_CompDetalhes_ERP_CompCab1]

GO

CREATE TABLE [dbo].[ERP_CompPagamentos](

                [ID_Interno] [int] NOT NULL,

                [ID_Movimento] [int] NOT NULL,

                [ID_linha] [int] NOT NULL,

                [ID_ModoPagamento] [int] NOT NULL,

                [ContaERP] [varchar](8) NULL,

                [Descricao] [varchar](50) NULL,

                [Valor] [float] NULL,

CONSTRAINT [PK_ERP_PagamentosComprras_1] PRIMARY KEY CLUSTERED 

(

                [ID_Interno] ASC,

                [ID_linha] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

 

GO

 

 

ALTER TABLE [dbo].[ERP_CompPagamentos]  WITH CHECK ADD  CONSTRAINT [FK_CompPagamentos_Cabecalho] FOREIGN KEY([ID_Interno])

REFERENCES [dbo].[ERP_CompCab] ([ID_Interno])

GO

 

ALTER TABLE [dbo].[ERP_CompPagamentos] CHECK CONSTRAINT [FK_CompPagamentos_Cabecalho]

GO

 

ALTER TABLE [dbo].[ERP_CompPagamentos]  WITH CHECK ADD  CONSTRAINT [FK_ERP_CompPagamentos_ERP_CompCab] FOREIGN KEY([ID_Interno])

REFERENCES [dbo].[ERP_CompCab] ([ID_Interno])

GO

 

ALTER TABLE [dbo].[ERP_CompPagamentos] CHECK CONSTRAINT [FK_ERP_CompPagamentos_ERP_CompCab]

GO

 

