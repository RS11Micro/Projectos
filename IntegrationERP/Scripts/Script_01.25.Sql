--criado em 10-12-2020
--versão Setup ERPInterf 05.09.01
UPDATE VersaoERP Set Versao='01.25'
GO
CREATE TABLE [dbo].[ERP_Adiantamentos](

      [ID] [int] IDENTITY(1,1) NOT NULL,

      [Ref] [int] NOT NULL,

      [Mpehotel] [int] NOT NULL,

      [Data] [datetime] NOT NULL,

      [Hora] [varchar](10) NOT NULL,

      [Reserva] [int] NOT NULL,

      [IDCliente] [int] NOT NULL,

      [Nome] [varchar](50) NOT NULL,

      [ID_ModoPagamento] [int] NOT NULL,

      [Descricao] [varchar](40) NOT NULL,

      [Valor] [decimal](19, 2) NOT NULL,

contaerp varchar(8) NULL     

) ON [PRIMARY]
 
GO
alter table
ERP_Pagamentos
add ref int null,
datamovimento datetime null
GO
alter table
ERP_Detalhes
add ref int null,
datamovimento datetime null
GO
alter table ERP_EMPRESAINTERFACE
add ExportaAdiantamentosPMS bit not null default 0,
DataIniExpAdiantamentosPMS datetime null            
GO

