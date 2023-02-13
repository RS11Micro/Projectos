--criado em 31-07-2018
--versão Fnt05.07.00.02
UPDATE VersaoERP Set Versao='01.02'
GO
alter table 
ERP_Cab alter column typedoc varchar(5) Null
GO
alter table erp_empresainterface
alter column ID_clienteIndiferenciado varchar(100) 
GO
IF NOT EXISTS (select sys.columns.name as campo,sys.columns.max_length,sys.objects.name as tabela from sys.columns
inner join sys.objects on sys.columns.object_id=sys.objects.object_id
where sys.columns.name='PrefixoContCblAartigo'and
sys.objects.object_id= OBJECT_ID(N'[dbo].ERP_EMPRESAINTERFACE') AND type in (N'U'))
alter table ERP_EMPRESAINTERFACE
add PrefixoContCblAartigo varchar(10)
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TrataContaCBLArtigo]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[TrataContaCBLArtigo]
GO
CREATE FUNCTION [dbo].[TrataContaCBLArtigo](@Prefixo varchar(10),@ID_Produto varchar(10))
RETURNS varchar(10)
BEGIN
declare 
@mProduto varchar(10),
@contador int   
  set @mProduto=@ID_Produto

  if len(@ID_Produto)>=4
     set @mProduto=@Prefixo+@mProduto
  else
     begin
        set @contador= len(@ID_Produto)
        while @contador<4 
        begin
           set @mProduto='0'+@mProduto;
           set @contador=@contador+1
        end;
         set @mProduto=@Prefixo+@mProduto
     end;


return(@mProduto)
END
GO