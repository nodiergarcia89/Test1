SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		RamonVillanueva
-- Create date: 25/03/2015
-- Description:	Material Cedido
-- =============================================
CREATE FUNCTION [dbo].[udfMaterialCedido] 
(
	-- Add the parameters for the function here
	@Cliente nvarchar(10),
	@Contrato nvarchar(10)
)
RETURNS varchar(500)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result varchar(MAX)

	-- Add the T-SQL statements to compute the return value here
	DECLARE @combinedString VARCHAR(MAX)

	select	@combinedString = COALESCE(@combinedString + '<br>', '') +
			Articulo 
			+ '<br>&nbsp;&nbsp'
			+ '    Coste: ' 
			+ format(Importe,'#,###.## €')
	from vstgF2MaterialCedidoContrato
	where Borrado='N'
	and NumContrato=@Contrato
	and codcliente=@Cliente

	SELECT @Result = '<html>' + coalesce(rtrim(@combinedString), 'NO HAY MATERIAL CEDIDO') + '<br></html>'
	
	-- Return the result of the function
	RETURN rtrim(substring(@Result,1,500))

END
GO
