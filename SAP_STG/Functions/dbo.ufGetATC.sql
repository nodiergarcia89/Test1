SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================
-- Author:		Ramon Villanueva
-- Create date: 21/07/2015
-- Description:	Devolver el ATC del usuario
-- Recibo el id de usuario 
-- Devuelvo el codigo de usuario de su ATC
-- Si el usuario es ATC entonces devuelvo el mismo
-- ===========================================================
CREATE FUNCTION [dbo].[ufGetATC] 
(
	-- Add the parameters for the function here
	@CodEmpresa int
	, @CodVendedor int
)
RETURNS int
AS
BEGIN

	-- Declarar variables
	DECLARE	 @ATC int
			, @EsATC int

	-- Declare the return variable here
	DECLARE @Result int

	-- Comprobar si el usuario es ATC
	select @EsATC=ATC
		from stgF2Vendedores
		where CodVendedor=@CodVendedor

	-- Comprobar ATC
	if @EsATC=1
		select @ATC=@CodVendedor
	else
		-- Recuperar tipo de usuario
		select @ATC=t1.ATC
		from	ZSD013 t1
				inner join stgF2Vendedores t2
					on	t1.CodEmpresa=t2.CodEmpresa
						and convert(int,t1.ATC)=t2.CodVendedor
		where t1.CodEmpresa=@CodEmpresa
			and t1.MANDT=100
			AND convert(int,t1.AUTOV)=@CodVendedor
			and t2.ATC=1
	
	-- Componer el resultado
	select @Result=(@ATC)
	
	-- Return the result of the function
	RETURN @Result

END
GO
