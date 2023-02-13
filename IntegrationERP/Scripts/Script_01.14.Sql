--criado em 02-41-2019
--versão Setup ERPInterf 05.07.20
UPDATE VersaoERP Set Versao='01.14'
GO

 alter table 

ErpParametros

add ModuloPrimavera int not null default 0

GO

insert into erp_interface(ID_Interface,NomeInterface,Descricao)

Values(4,'ERP_CBLPROTEL','Exportação de Vendas Protel-CBL')

GO

 

CREATE TABLE [dbo].[ERP_CBLParametros](

     ID_EmpresaInteraface int  NOT NULL,

                [CaminhoFicheiro] [varchar](250) NULL,

                [ID_clienteDefeito] [varchar](20) NULL,

                [OmiteLinhaZero] [varchar](1) NULL,

                [RefleteClasseIva] [varchar](1) NULL,

                [RefleteAnalitica] [varchar](1) NULL,

                [RefleteCentroCustos] [varchar](1) NULL,

                [diario] [varchar](5) NULL,

                [ReflecteClassesSelo] [varchar](1) NULL,

                [ReflectePlanoFuncional] [varchar](1) NULL,

                [ReflecteFluxos] [varchar](1) NULL,

                [ReflecteCOPE] [varchar](1) NULL,

                [id_PagamentoCC] [int] NULL,

                [ModuloVND] [varchar](1) NULL,

                [ModuloRec] [varchar](1) NULL,

                [RefleteClasseIvaRec] [varchar](1) NULL,

                [RefleteAnaliticaRec] [varchar](1) NULL,

                [RefleteCentroCustosRec] [varchar](1) NULL,

                [diarioRec] [varchar](5) NULL,

                [ReflecteClassesSeloRec] [varchar](1) NULL,

                [ReflectePlanoFuncionalRec] [varchar](1) NULL,

                [ReflecteFluxosRec] [varchar](1) NULL,

                [ReflecteCOPERec] [varchar](1) NULL,

                [EnviaLinhaIVA] [bit] NOT NULL,

                [LoteIgualNDocumento] [bit] NOT NULL,

                [ConfContasPorTipoDoc] [bit] NOT NULL,

                [FibudebMetaData] [bit] NOT NULL,

                [IDImportacao] [varchar](8) NULL,

                [ID_Empresa] [varchar](3) NULL,

                [NumCasaDecimaisVL] [int] NULL,

                [ExcluirDocsVndAnulados] [bit] NOT NULL,

                [RecNatPAGCC] [varchar](1) NULL,

                [RecNatPAG] [varchar](1) NULL,

                [sector] [varchar](3) NULL,

                [ContasPorMercado] [bit] NOT NULL,

                [ExportaVendas] [bit] NOT NULL,

                [ExportaRecibos] [bit] NOT NULL,

                [OmitirLinhaIVA0perc] [bit] NOT NULL,

                [TipoAfetacao] [int] NOT NULL,

CONSTRAINT [PK_ERP_CBLParametros] PRIMARY KEY CLUSTERED 

(

                ID_EmpresaInteraface ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

 

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((1)) FOR [EnviaLinhaIVA]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((0)) FOR [LoteIgualNDocumento]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((0)) FOR [ConfContasPorTipoDoc]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((0)) FOR [FibudebMetaData]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((0)) FOR [ExcluirDocsVndAnulados]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((0)) FOR [ContasPorMercado]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((1)) FOR [ExportaVendas]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((1)) FOR [ExportaRecibos]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((0)) FOR [OmitirLinhaIVA0perc]

GO

 

ALTER TABLE [dbo].[ERP_CBLParametros] ADD  DEFAULT ((0)) FOR [TipoAfetacao]

GO

CREATE TABLE [dbo].[CBL_ModoPagamentoPMS](

                [PMS_ID_ModoPagamento] [int] NOT NULL,

                [PMS_ModoPagamento] [varchar](50) NULL,

                [ContaCBL] [varchar](10) NULL,

                [ID_Hotel] [int] NOT NULL,

                [Hotel] [varchar](150) NULL,

CONSTRAINT [PK_PmsModoPagamento1] PRIMARY KEY CLUSTERED 

(

                [PMS_ID_ModoPagamento] ASC,

                [ID_Hotel] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

 

GO

 

 

CREATE TABLE [dbo].[CBL_TipoDocPMS](

                [PMS_ID_TipoDoc] [int] NOT NULL,

                [PMS_TipoDoc] [varchar](50) NULL,

                [ContaCBL] [varchar](20) NULL,

                [Natureza] [varchar](1) NULL,

                [NaturezaNeg] [varchar](1) NULL,

                [NaturezaPag] [varchar](1) NULL,

                [NaturezaPagNeg] [varchar](1) NULL,

                [NaturezaTipoDoc] [varchar](1) NOT NULL,

                [abrevserie] [varchar](2) NULL,

                [serieERP] [varchar](1) NULL,

                [ID_Hotel] [int] NOT NULL,

CONSTRAINT [PK_PMS_TipoDocCBL] PRIMARY KEY CLUSTERED 

(

                [PMS_ID_TipoDoc] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

 

GO

 

SET ANSI_PADDING OFF

GO

 

ALTER TABLE [dbo].[CBL_TipoDocPMS] ADD  DEFAULT ('D') FOR [NaturezaTipoDoc]

GO

 

ALTER TABLE [dbo].[CBL_TipoDocPMS] ADD  DEFAULT ((0)) FOR [ID_Hotel]

GO

 

 

 

CREATE TABLE [dbo].[CBL_ContaFamiliaPMS](

                [PMS_ID_ContaFamilia] [varchar](10) NOT NULL,

                [PMS_ContaFamilia] [varchar](150) NULL,

                [ContaCBLFamilia] [varchar](20) NULL,

                [ContaCBLIVA] [varchar](20) NULL,

                [ClasseIVA] [varchar](10) NULL,

                [ContaCBLFamiliaD] [varchar](20) NULL,

                [ContaCBLIVAD] [varchar](20) NULL,

                [ClasseIVAD] [varchar](10) NULL,

                [PMS_ID_TipoDoc] [int] NOT NULL,

                [Mercado] [int] NOT NULL,

                [ContaCCusto] [varchar](20) NULL,

                [ContaCCustoD] [varchar](20) NULL,

                [ContaAnalitica] [varchar](20) NULL,

                [ContaAnaliticaD] [varchar](20) NULL,

CONSTRAINT [PK_Pms_ContaFamiliaCBL] PRIMARY KEY CLUSTERED 

(

                [PMS_ID_TipoDoc] ASC,

                [PMS_ID_ContaFamilia] ASC,

                [Mercado] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

 

GO

 

SET ANSI_PADDING OFF

GO

 

ALTER TABLE [dbo].[CBL_ContaFamiliaPMS] ADD  DEFAULT ((1)) FOR [Mercado]

GO

 

INSERT INTO [Contadores]

           ([Nome_tabela]

           ,[ID_Corrente]

           ,[Descricao])

     VALUES

           ('NomeTempDB'

           ,0

           ,'acExpVendasCBLPMS')

GO

 

 

INSERT INTO [Contadores]

           ([Nome_tabela]

           ,[ID_Corrente]

           ,[Descricao])

     VALUES

           ('ERP_CBLCAB'

           ,0

           ,'ERP_CBLCAB')

GO

 

CREATE TABLE [dbo].[PMSPaisMercado](

                [ID_Pais] [int] NOT NULL,

                [Descricao] [varchar](150) NULL,

                [CodISO] [varchar](30) NULL,

                [ID_Mercado] [int] NULL,

                [DescMercado] [varchar](200) NULL,

CONSTRAINT [PK_PMSPaisMercado] PRIMARY KEY CLUSTERED 

(

                [ID_Pais] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

 

GO



