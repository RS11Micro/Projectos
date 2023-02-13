--criado em 01-08-2019
--versão Setup ERPInterf 05.08.07
UPDATE VersaoERP Set Versao='01.17'
GO
Alter table
ERP_CBLCMPCabec
add DataMov  Datetime NULL
GO
Alter table
ERP_CBLCMPCabec
add AnoMov int null
GO
Alter table
ERP_CBLCMPCabec
add MesMov int null
GO
Alter table
ERP_CBLCMPCabec
add DiaMov int null
GO


