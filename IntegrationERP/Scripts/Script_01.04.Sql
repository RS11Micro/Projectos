--criado em 08-10-2018
--versão Setup ERPInterf 05.07.06
UPDATE VersaoERP Set Versao='01.04'
GO
 

 CREATE TABLE [dbo].[LogOperacoes](

      [Utilizador] [varchar](50) NULL,

      [Data] [datetime] NULL,

      [Hora] [datetime] NULL,

      [NomeBD] [varchar](150) NULL,

 

      [Descricao] [nvarchar](max) NULL

) ON [PRIMARY]

 

GO



 

