--criado em 06-11-2019
--versão Setup ERPInterf 05.08.22
UPDATE VersaoERP Set Versao='01.19'
GO

CREATE TABLE [dbo].[ERP_AreaNegocio](

                [ID_AreaNegocio] [int] NOT NULL,

                [DescricaoArea] [varchar](50) NULL,

                [ContaERP] [varchar](50) NULL,

CONSTRAINT [PK_ERPAreaNegocio] PRIMARY KEY CLUSTERED 

(

                [ID_AreaNegocio] ASC

)

) ON [PRIMARY]

GO

CREATE TABLE [dbo].[ERP_AreaNegocioCPrecosFNT](

                [ID_InternoInterface] [int] NOT NULL,

                [ID_AreaNegocio] [int] NOT NULL,

                [ID_ClassePrecos] [int] NOT NULL,

                [DescClassePrecos] [varchar](150) NULL,

CONSTRAINT [PK_ERP_AreaNegocioCPrecosFNT] PRIMARY KEY CLUSTERED 

(

                [ID_InternoInterface] ASC,

                [ID_AreaNegocio] ASC,

                [ID_ClassePrecos] ASC

)

) ON [PRIMARY]

 

GO

CREATE TABLE [dbo].[ERP_AreaNegocioContaLancPMS](

                [ID_InternoInterface] [int] NOT NULL,

                [ID_AreaNegocio] [int] NOT NULL,         

                [KTONR] [int] NOT NULL,

                 kto varchar(10) null,

                [DescUKTO] [varchar](150) NULL,

CONSTRAINT [PK_ERP_AreaNegocioContaLancPMS] PRIMARY KEY CLUSTERED 

(

                [ID_InternoInterface] ASC,

                [ID_AreaNegocio] ASC,

                [KTONR] ASC

)

) ON [PRIMARY]

 

GO

 

INSERT INTO [Contadores]

 

           ([Nome_tabela]

 

           ,[ID_Corrente]

 

           ,[Descricao])

 

     VALUES

 

           ('ERPAreaNegocio'

 

           ,0

 

           ,'Id Interno AreaNegocio')

 

GO

alter table

ERP_Detalhes

add AreaNegocio varchar(10) null

GO

alter table

ERP_Detalhes

add DescAreaNegocio varchar(50) null

GO

alter table

ERP_Detalhes

add ID_GrupoProduto int null,

GrupoProduto varchar(150) null

, ID_FamiliaProduto int null,

FamiliaProduto varchar(150) null

, ID_SubFamiliaProduto int null,

SubFamiliaProduto varchar(150) null

GO

 
 

alter table

ERP_CompDetalhes

add ID_GrupoProduto int null,

GrupoProduto varchar(150) null

, ID_FamiliaProduto int null,

FamiliaProduto varchar(150) null

, ID_SubFamiliaProduto int null,

SubFamiliaProduto varchar(150) null

GO

 

