--criado em 11-06-2019
--verso Setup ERPInterf 05.08.01
UPDATE VersaoERP Set Versao='01.15'
GO
alter table
ERP_EMPRESAINTERFACE
add  descricao varchar(50) null,
ID_InterfaceIMC int null
GO
insert into erp_interface(ID_Interface,NomeInterface,Descricao)
Values(5,'ERP_CBLVENDASFNT','Exportao de Vendas CBL SYSPOS|WELLSYS')
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CBL_PMSClientesCC]') AND type in (N'U'))
DROP TABLE [dbo].[CBL_PMSClientesCC]
GO
insert into erp_interface(ID_Interface,NomeInterface,Descricao)
Values(6,'ERP_CBLCOMPRASFNT','Exportao de CMP CBL SYSPOS|SYSCONTROLLER')
GO



/****** Object:  Table [dbo].[LOGALTERP_CBLCMPCabec]    Script Date: 06/12/2019 14:20:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LOGALTERP_CBLCMPCabec]') AND type in (N'U'))
DROP TABLE [dbo].[LOGALTERP_CBLCMPCabec]
GO

CREATE TABLE [dbo].[LOGALTERP_CBLCMPCabec](
	[ID_Interno] [int] NOT NULL,
	[ID_DOCInterno] [int] NOT NULL,
	[Origem] [int] NULL,
	[Modulo] [varchar](5) NULL,
	[Ano] [int] NULL,
	[Mes] [int] NULL,
	[Dia] [int] NULL,
	[Data] [datetime] NULL,
	[Analitica] [varchar](1) NULL,
	[CCustos] [varchar](1) NULL,
	[Diario] [varchar](5) NULL,
	[Documento] [varchar](20) NULL,
	[NumDocumento][varchar](30) NULL,
	[Descricao] [varchar](50) NULL,
	[DataHoraRegisto] [datetime] NULL,
	[TotalLinhas] [int] NULL,
	[UtilizadorRegisto] [varchar](30) NULL,
	[Integrado] [bit] NULL,
	[DataHoraIntegracao] [datetime] NULL,
	[PRIMAVERA_ID] [uniqueidentifier] NULL,
	[PRIMAVERA_Diario] [varchar](10) NULL,
	[PRIMAVERA_NumDiario] [int] NULL,
	[PRIMAVERA_Documento] [varchar](10) NULL,
	[PRIMAVERA_NumDocumento] [int] NULL,
	[ErroIntegracao] [varchar](max) NULL,
	[NIF] [varchar](20) NULL,
	[TipoEntidade] [varchar](1) NULL,
	[Entidade] [varchar](50) NULL,
	[NumeroDocumentoExterno] [varchar](100) NULL,
	[Nome] [varchar](200) NULL,
	[Morada] [varchar](200) NULL,
	[Localidade] [varchar](200) NULL,
	[CodigoPostal] [varchar](200) NULL,
	[Telefone] [varchar](200) NULL,
	[DataVencimento] [date] NULL,
	[PRIMAVERA_CCT_ID] [uniqueidentifier] NULL,
	[PRIMAVERA_CCT_TipoDoc] [varchar](5) NULL,
	[PRIMAVERA_CCT_NumDoc] [int] NULL,
	[PRIMAVERA_CCT_Serie] [varchar](10) NULL
) ON [PRIMARY]

GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ERP_CBLCM__ID_In__2B0A656D]') AND parent_object_id = OBJECT_ID(N'[dbo].[ERP_CBLCMPLinhas]'))
ALTER TABLE [dbo].[ERP_CBLCMPLinhas] DROP CONSTRAINT [FK__ERP_CBLCM__ID_In__2B0A656D]
GO

/****** Object:  Table [dbo].[ERP_CBLCMPLinhas]    Script Date: 06/12/2019 14:07:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ERP_CBLCMPLinhas]') AND type in (N'U'))
DROP TABLE [dbo].[ERP_CBLCMPLinhas]
GO

/****** Object:  Table [dbo].[ERP_CBLCMPCabec]    Script Date: 06/12/2019 14:08:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ERP_CBLCMPCabec]') AND type in (N'U'))
DROP TABLE [dbo].[ERP_CBLCMPCabec]
GO


CREATE TABLE [dbo].[ERP_CBLCMPCabec](
	[ID_Interno] [int] NOT NULL,
	[ID_DOCInterno] [int] NOT NULL,
	[Origem] [int] NULL,
	[Modulo] [varchar](5) NULL,
	[Ano] [int] NULL,
	[Mes] [int] NULL,
	[Dia] [int] NULL,
	[Data] [datetime] NULL,
	[Analitica] [varchar](1) NULL,
	[CCustos] [varchar](1) NULL,
	[Diario] [varchar](5) NULL,
	[Documento] [varchar](20) NULL,
	[NumDocumento] [varchar](30) NULL,
	[Descricao] [varchar](50) NULL,
	[DataHoraRegisto] [datetime] NULL,
	[TotalLinhas] [int] NULL,
	[UtilizadorRegisto] [varchar](30) NULL,
	[Integrado] [bit] NULL,
	[DataHoraIntegracao] [datetime] NULL,
	[PRIMAVERA_ID] [uniqueidentifier] NULL,
	[PRIMAVERA_Diario] [varchar](10) NULL,
	[PRIMAVERA_NumDiario] [int] NULL,
	[PRIMAVERA_Documento] [varchar](10) NULL,
	[PRIMAVERA_NumDocumento] [int] NULL,
	[ErroIntegracao] [varchar](max) NULL,
	[NIF] [varchar](20) NULL,
	[TipoEntidade] [varchar](1) NULL,
	[Entidade] [varchar](50) NULL,
	[NumeroDocumentoExterno] [varchar](100) NULL,
	[Nome] [varchar](200) NULL,
	[Morada] [varchar](200) NULL,
	[Localidade] [varchar](200) NULL,
	[CodigoPostal] [varchar](200) NULL,
	[Telefone] [varchar](200) NULL,
	[DataVencimento] [date] NULL,
	[PRIMAVERA_CCT_ID] [uniqueidentifier] NULL,
	[PRIMAVERA_CCT_TipoDoc] [varchar](5) NULL,
	[PRIMAVERA_CCT_NumDoc] [int] NULL,
	[PRIMAVERA_CCT_Serie] [varchar](10) NULL,
	[mpehotel] [int] NULL,
	[NomeBaseDados] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Interno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[ERP_CBLCMPLinhas](
	[ID_Interno] [int] NULL,
	[ID_DOCInterno] [int] NOT NULL,
	[NumLinha] [int] NULL,
	[TipoLinha] [varchar](1) NULL,
	[Conta] [varchar](20) NULL,
	[Descricao] [varchar](200) NULL,
	[Valor] [float] NULL,
	[TaxaIva] [float] NULL,
	[PercIvaNDev] [float] NULL,
	[IvaNDed] [float] NULL,
	[Natureza] [varchar](1) NULL,
	[TipoEntidade] [varchar](20) NULL,
	[Entidade] [varchar](12) NULL,
	[ClasseIva] [varchar](10) NULL,
	[ContaOrigem] [varchar](20) NULL,
	[TipoOperacao] [varchar](1) NULL,
	[Moeda] [varchar](3) NULL,
	[Cambio] [float] NULL,
	[ClasseIvaAutofaturacao] [varchar](10) NULL,
	[DataEmissaoDocumento] [date] NULL,
	[NumeroDocumentoExterno] [varchar](20) NULL,
	[Observacoes] [varchar](50) NULL,
	[mpehotel] [int] NULL
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[ERP_CBLCMPLinhas]  WITH CHECK ADD FOREIGN KEY([ID_Interno])
REFERENCES [dbo].[ERP_CBLCMPCabec] ([ID_Interno])
GO


CREATE TABLE [dbo].[CBL_PMSClientesCC](

                [ID_ClientePMS] [int] NOT NULL,

                [ContaCBL] [varchar](20) NULL,

                [Nome] [varchar](250) NULL,

                [Apelido] [varchar](250) NULL,

                [Morada] [varchar](250) NULL,

                [Localidade] [varchar](250) NULL,

                [CodPostal] [varchar](250) NULL,

                [Telefone] [varchar](250) NULL,

                [ID_Pais] [int] NULL,

                [Pais] [varchar](250) NULL,

                [PAISISO] [varchar](50) NULL,

                [Ncontribuinte] [varchar](250) NULL,

CONSTRAINT [PK_ERP_PMSClientesCC] PRIMARY KEY CLUSTERED 

(

                [ID_ClientePMS] ASC

)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

 

GO

alter Table

[CBL_TipoDocPMS]

add NotaCreditoControlaPeriodoIVA Bit not null

default 0

GO

alter table

ERP_EMPRESAINTERFACE 

add  PeriodoIVA int not null default-1

GO

 

alter table[CBL_ContaFamiliaPMS]

add

                [ContaCBLFamiliaNCperIVAdifFACT] [varchar](20) NULL,

                [ContaCBLIVANCperIVAdifFACT] [varchar](20) NULL,

                [ClasseIVANCperIVAdifFACT] [varchar](10) NULL,

                [ContaCCustoNCperIVAdifFACT] [varchar](20) NULL,

                [ContaAnaliticaNCperIVAdifFACT] [varchar](20) NULL

                

GO

 


INSERT INTO [Contadores]

           ([Nome_tabela]

           ,[ID_Corrente]

           ,[Descricao])

     VALUES

           ('ERP_CBLCOMPCAB'

           ,0

           ,'ERP_CBLCOMPCAB')

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LOGALTERP_CBLCMPLinhas]') AND type in (N'U'))
DROP TABLE [dbo].[LOGALTERP_CBLCMPLinhas]
GO
CREATE TABLE [dbo].[LOGALTERP_CBLCMPLinhas](
	[ID_Interno] [int] NULL,
	[ID_DOCInterno] [int] NOT NULL,
	[NumLinha] [int] NULL,
	[TipoLinha] [varchar](1) NULL,
	[Conta] [varchar](20) NULL,
	[Descricao] [varchar](200) NULL,
	[Valor] [float] NULL,
	[TaxaIva] [float] NULL,
	[PercIvaNDev] [float] NULL,
	[IvaNDed] [float] NULL,
	[Natureza] [varchar](1) NULL,
	[TipoEntidade] [varchar](20) NULL,
	[Entidade] [varchar](12) NULL,
	[ClasseIva] [varchar](10) NULL,
	[ContaOrigem] [varchar](20) NULL,
	[TipoOperacao] [varchar](1) NULL,
	[Moeda] [varchar](3) NULL,
	[Cambio] [float] NULL,
	[ClasseIvaAutofaturacao] [varchar](10) NULL,
	[DataEmissaoDocumento] [date] NULL,
	[NumeroDocumentoExterno] [varchar](20) NULL,
	[Observacoes] [varchar](50) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[ERP_CBLLinhas]    Script Date: 06/12/2019 15:21:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ERP_CBLLinhas]') AND type in (N'U'))
DROP TABLE [dbo].[ERP_CBLLinhas]
GO

/****** Object:  Table [dbo].[ERP_CBLCabec]    Script Date: 06/12/2019 15:20:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ERP_CBLCabec]') AND type in (N'U'))
DROP TABLE [dbo].[ERP_CBLCabec]
GO
CREATE TABLE [dbo].[ERP_CBLCabec](
	[ID_Interno] [int] NOT NULL,
	[ID_DOCInterno] [int] NOT NULL,
	[Origem] [int] NULL,
	[Modulo] [varchar](5) NULL,
	[Ano] [int] NULL,
	[Mes] [int] NULL,
	[Dia] [int] NULL,
	[Data] [datetime] NULL,
	[Analitica] [varchar](1) NULL,
	[CCustos] [varchar](1) NULL,
	[Diario] [varchar](5) NULL,
	[Documento] [varchar](20) NULL,
	[NumDocumento] [int] NULL,
	[Descricao] [varchar](50) NULL,
	[DataHoraRegisto] [datetime] NULL,
	[TotalLinhas] [int] NULL,
	[UtilizadorRegisto] [varchar](30) NULL,
	[Integrado] [bit] NULL,
	[DataHoraIntegracao] [datetime] NULL,
	[PRIMAVERA_ID] [uniqueidentifier] NULL,
	[PRIMAVERA_Diario] [varchar](10) NULL,
	[PRIMAVERA_NumDiario] [int] NULL,
	[PRIMAVERA_Documento] [varchar](10) NULL,
	[PRIMAVERA_NumDocumento] [int] NULL,
	[ErroIntegracao] [varchar](max) NULL,
	[NIF] [varchar](20) NULL,
	[TipoEntidade] [varchar](1) NULL,
	[Entidade] [varchar](50) NULL,
	[NumeroDocumentoExterno] [varchar](100) NULL,
	[Nome] [varchar](200) NULL,
	[Morada] [varchar](200) NULL,
	[Localidade] [varchar](200) NULL,
	[CodigoPostal] [varchar](200) NULL,
	[Telefone] [varchar](200) NULL,
	[DataVencimento] [date] NULL,
	[PRIMAVERA_CCT_ID] [uniqueidentifier] NULL,
	[PRIMAVERA_CCT_TipoDoc] [varchar](5) NULL,
	[PRIMAVERA_CCT_NumDoc] [int] NULL,
	[PRIMAVERA_CCT_Serie] [varchar](10) NULL,
	[mpehotel] [int] NULL,
	[NomeBaseDados] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Interno] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__ERP_CBLLi__ID_In__19DFD96B]') AND parent_object_id = OBJECT_ID(N'[dbo].[ERP_CBLLinhas]'))
ALTER TABLE [dbo].[ERP_CBLLinhas] DROP CONSTRAINT [FK__ERP_CBLLi__ID_In__19DFD96B]
GO

/****** Object:  Table [dbo].[ERP_CBLLinhas]    Script Date: 06/12/2019 15:21:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ERP_CBLLinhas]') AND type in (N'U'))
DROP TABLE [dbo].[ERP_CBLLinhas]
GO
CREATE TABLE [dbo].[ERP_CBLLinhas](
	[ID_Interno] [int] NULL,
	[ID_DOCInterno] [int] NOT NULL,
	[NumLinha] [int] NULL,
	[TipoLinha] [varchar](1) NULL,
	[Conta] [varchar](20) NULL,
	[Descricao] [varchar](200) NULL,
	[Valor] [float] NULL,
	[TaxaIva] [float] NULL,
	[PercIvaNDev] [float] NULL,
	[IvaNDed] [float] NULL,
	[Natureza] [varchar](1) NULL,
	[TipoEntidade] [varchar](20) NULL,
	[Entidade] [varchar](12) NULL,
	[ClasseIva] [varchar](10) NULL,
	[ContaOrigem] [varchar](20) NULL,
	[TipoOperacao] [varchar](1) NULL,
	[Moeda] [varchar](3) NULL,
	[Cambio] [float] NULL,
	[ClasseIvaAutofaturacao] [varchar](10) NULL,
	[DataEmissaoDocumento] [date] NULL,
	[NumeroDocumentoExterno] [varchar](20) NULL,
	[Observacoes] [varchar](50) NULL,
	[mpehotel] [int] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[ERP_CBLLinhas]  WITH CHECK ADD FOREIGN KEY([ID_Interno])
REFERENCES [dbo].[ERP_CBLCabec] ([ID_Interno])
GO






 