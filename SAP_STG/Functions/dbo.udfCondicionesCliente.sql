SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		RamonVillanueva
-- Create date: 27/03/2015
-- Description:	Condiciones Cliente
-- Esta funcion no va bien si la tabla 
-- stgF3CondicionesCliente tiene claves o indices
-- =============================================
CREATE FUNCTION [dbo].[udfCondicionesCliente]
(
	-- Add the parameters for the function here
	@Cliente int,
	@CodNivel int
)
RETURNS varchar(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result varchar(MAX)

	-- Add the T-SQL statements to compute the return value here
	DECLARE @combinedString VARCHAR(MAX)

	select	@combinedString = COALESCE(@combinedString + CHAR(13)+CHAR(10), '') 
			--+ rtrim(CodArticulo) + '.-' 
			+ rtrim(Articulo)
			+ CHAR(13)+CHAR(10)
			--+ '  Precio Clte: ' 
			+ '   '
			+ case when CondEsp='N' then '*' else '' end -- A tarifa *
			+ format(PrecioCliente,'#,###.##€/') + rtrim(Unidad_Medida)
			+ case -- Promocion
				when Base<>0 then ' ' + format(Base,'#,###.##') + '+' + format(Regalo,'#,###.##')
			    else ''
			  end
			+ case -- Importe en €
				when Importe<>0 then ' ' + format(Importe,'#,###.##€')
			    else ''
			  end
	from stgF3CondicionesCliente
	where	CodNivel1=@CodNivel
			and codcliente=@Cliente
			and NumReg < 5 -- Los 4 articulos que mas vende
	order by CantMes2 desc

	SELECT @Result = coalesce(rtrim(@combinedString), 'NO HAY CONDICIONES ESPECIALES')
	
	-- Return the result of the function
	RETURN rtrim(substring(@Result,1,500))


END
GO
