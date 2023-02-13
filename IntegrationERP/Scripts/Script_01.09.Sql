--criado em 31-10-2018
--versão Setup ERPInterf 05.07.12
UPDATE VersaoERP Set Versao='01.09'
GO

 

CREATE TABLE [LOGERP_CompCab](

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

                [UtilizadorRegisto] [varchar](30) NULL,

                [DescTipoMovimento] [varchar](100) NULL,

                [PRIMAVERA_ID] [uniqueidentifier] NULL,

                [PRIMAVERA_TipoDoc] [varchar](5) NULL,

                [PRIMAVERA_Serie] [varchar](5) NULL,

                [PRIMAVERA_NumDoc] [int] NULL

) ON [PRIMARY]

 

GO

 
CREATE TABLE [dbo].[LOGERP_CompDetalhes](

                [ID_Interno] [int] NOT NULL,

                [ID_Movimento] [int] NULL,

                [ID_Linha] [int] NOT NULL,

                [Serie] [varchar](10) NULL,

                [NumDocumento] [varchar](60) NULL,

                [datainv] [datetime] NULL,

                [Data] [datetime] NOT NULL,

                [servico] [varchar](8) NULL,

                [Descritivo] [varchar](150) NULL,

                [qnt] [float]  NULL,

                [ValorUnitSemIVA] [float]  NULL,

                [ValorTotalSemIVA] [float]  NULL,

                [ValorTotalIVA] [float]  NULL,

                [ValorTotalComIVA] [float]  NULL,

                [codiva] [varchar](4) NULL,

                [taxaiva] [decimal](19, 2)  NULL,

                [ID_Armazem] [int] NULL,

                [Armazem] [varchar](200) NULL,

                [ID_ArmazemERP] [varchar](5) NULL,

                [CCusto] [varchar](10) NULL,

                [CodIsencao] [varchar](4) NULL,

                [Descontoperc] [decimal](19, 2)  NULL,

                [DescontoValor] [decimal](19, 2)  NULL,

                [Origem] [int] NOT NULL)

GO

 

CREATE TABLE [dbo].[LOGERP_CompPagamentos](

                [ID_Interno] [int] NOT NULL,

                [ID_Movimento] [int] NOT NULL,

                [ID_linha] [int] NOT NULL,

                [ID_ModoPagamento] [int]  NULL,

                [ContaERP] [varchar](8) NULL,

                [Descricao] [varchar](50) NULL,

                [Valor] [float] NULL)

 
GO

 
