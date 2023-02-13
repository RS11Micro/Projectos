--criado em 12-01-2019
--versão Setup ERPInterf 05.07.16
UPDATE VersaoERP Set Versao='01.12'
GO
IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='TipoMov'and

sys.objects.object_id= OBJECT_ID(N'[dbo].LOGERP_CompCab') AND type in (N'U'))

alter table LOGERP_CompCab

add TipoMov  int not null  CONSTRAINT DF_LOGERP_CompCab_TipoMov Default 1

GO
 

CREATE TABLE [dbo].[ErpParametros](

exportacaoautomatica bit not null default 0,

                [temporizadorProcessamento] [int] NULL,

[IntervaloHoraParaReinicio] [int]  NULL,              

                

) ON [PRIMARY]

 

GO

insert into ErpParametros

(exportacaoautomatica,temporizadorProcessamento,IntervaloHoraParaReinicio)

values(0,10, 0)

GO

update

ERP_EMPRESAINTERFACE

set DATAInicioExportacao= (select min(erp_cab.Data) from erp_cab

where Origem=2)

where ID_Interface=2

GO

update

ERP_EMPRESAINTERFACE

set DATAInicioExportacao= (select min(erp_cab.Data) from erp_cab

where Origem=1)

where ID_Interface=1

GO

CREATE TABLE [dbo].ERP_regReinicioAutomatico(

    [Data] [datetime]  NULL,

                [Hora] int  NULL)

GO

 

CREATE TABLE [ERP_LogMail](

                [id] [int] IDENTITY(1,1) NOT NULL,

                [TipoInterface] [int] NOT NULL,

    [DescInterface] varchar(150) NULL,   

                [Data] datetime NULL,

                [ID_Movimento] [int] NOT NULL,

                DescMovimento varchar(250) NOT NULL,           

    [mensagem] varchar(500) NULL,                         

                ) ON [PRIMARY]

GO

 

 

alter table

ErpParametros

add IntegracaoentreHoras bit not null default 0

GO

alter table

ErpParametros

add HoraInicio datetime null

GO

alter table

ErpParametros

add HoraFim datetime null

GO


 




