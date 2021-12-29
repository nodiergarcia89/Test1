SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================
-- Author:		Ramon Villanueva
-- Create date: 21/07/2015
-- Description:	Devolver tipo de usuario
-- Recibo el id de usuario 
-- Devuelvo el tipo de usuario:
--		1: Central
--		2: Area Manager
--		3: Delegado
--		4: ATC
--		5: Promotor
--		6: Autoventa
--		7: Almacenero
--		8: Vending
--		9: RACE
--		10: SAT
-- ===========================================================
CREATE FUNCTION [dbo].[ufGetTipoUsuario] 
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
			,@Autoventa int
			,@Vending int
			,@SAT int
			,@Almacenero int
			,@Promotor int
			,@RACE int
			,@Delegado int
			,@AreaManager int
			,@Central int

	-- Declare the return variable here
	DECLARE @Result int

	-- Recuperar tipo de usuario
	select 
			 @ATC=ATC
			,@Autoventa=Autoventa
			,@Vending=Vending
			,@SAT=SAT
			,@Almacenero=Almacenero
			,@Promotor=Promotor
			,@RACE=RACE
			,@Delegado=Delegado
			,@AreaManager=AreaManager
			,@Central=Central
	from stgF2Vendedores
	where	CodEmpresa=@CodEmpresa
			and CodVendedor=@CodVendedor
	
	-- Componer el resultado
	select @Result=(
		  case	when @Central=1		then 1 
				when @AreaManager=1 then 2
				when @Delegado=1	then 3
				when @ATC=1			then 4
				when @Promotor=1	then 5
				when @Autoventa=1	then 6
				when @Almacenero=1	then 7
				when @Vending=1		then 8
				when @RACE=1		then 9
				when @SAT=1			then 10
				else 0
		 end)
	
	-- Return the result of the function
	RETURN @Result

END
GO
