--criado em 11-03-2020
--versão Setup ERPInterf 05.08.26
UPDATE VersaoERP Set Versao='01.22'
GO
alter table ERP_EMPRESAINTERFACE
add ExpEncomendas bit not null default 0,
DataIniExpEncomendas datetime null            
GO
alter table ERP_CompCab
add ID_encomenda int null,
encomenda bit not null default 0
GO
alter table ERP_CompDetalhes
add ID_encomenda int null, 
ID_EncomendaOrigem int null, 
ID_linhaEncOrigem int null
GO

