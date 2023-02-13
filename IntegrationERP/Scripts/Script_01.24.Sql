--criado em 29-10-2020
--versão Setup ERPInterf 05.08.39
UPDATE VersaoERP Set Versao='01.24'
GO
alter table
Erp_LinhasInventario
add ID_GrupoProduto int null,
GrupoProduto varchar(150) null
, ID_FamiliaProduto int null,
FamiliaProduto varchar(150) null
, ID_SubFamiliaProduto int null,
SubFamiliaProduto varchar(150) null
GO



