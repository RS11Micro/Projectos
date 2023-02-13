--criado em 31-01-2020
--versão Setup ERPInterf 05.08.25
UPDATE VersaoERP Set Versao='01.20'
GO
 Alter table ERP_EMPRESAINTERFACE
add  TipoCtrlCodClienteCC Int not Null
default 2
GO
update 
 ERP_EMPRESAINTERFACE
set TipoCtrlCodClienteCC=0
from 
 ERP_EMPRESAINTERFACE
inner join ERP_Interface on 
 ERP_Interface.ID_Interface=ERP_EMPRESAINTERFACE.ID_Interface
where NomeInterface='ERP_VENDASPROTEL'
GO
alter table erp_cab
add CODPais [varchar](30) NULL,
DescPais [varchar](100) NULL, 
Mercado [int] NULL,
DescMercado [varchar](200) NULL
GO
Alter table ERP_EMPRESAINTERFACE
add  ID_PagamentoCC Int not null default 0
GO


