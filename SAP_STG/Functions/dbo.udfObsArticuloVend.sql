SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 05/06/2015
-- Description:	Observaciones Articulo-Vendedor
-- =============================================
CREATE FUNCTION [dbo].[udfObsArticuloVend] 
(
	-- Parameters for the function
	@CodEmpresa int
	,@CodArticulo nvarchar(18)
)
RETURNS varchar(8000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result varchar(8000)=''

	-- Devuelve sólo un registro por Vendedor
	SELECT @Result = COALESCE(@Result + CHAR(13)+CHAR(10), '') + 'Movil: ' + ltrim(rtrim(Telefono))
		+ CHAR(13)+CHAR(10) + case
						when Promotor=1 Then 'Promotor'
						when ATC=1 then 'ATC'
						when Delegado=1 Then 'Delegado'
						when AreaManager=1 Then 'Area Manager'
						else ''
					end
		FROM stgF2Vendedores
		where	CodEmpresa=@CodEmpresa
				and CodVendedor=@CodArticulo

	-- Return the result of the function
	RETURN @Result

END
GO
