--criado em 15-12-2020
--versão Setup ERPInterf 05.09.04
UPDATE VersaoERP Set Versao='01.27'
GO
IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns

inner join sys.objects on sys.columns.object_id=sys.objects.object_id

where sys.columns.name='EmProcessamentoFDia'and

sys.objects.object_id= OBJECT_ID(N'[dbo].sbconexoesactivas') AND type in (N'U'))

alter table sbconexoesactivas

add EmProcessamentoFDia bit not null

CONSTRAINT DF_sbconexoesactivas_EmProcFDia Default '0'

GO

