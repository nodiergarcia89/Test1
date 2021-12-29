SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 29/07/2015
-- Description:	Clientes Delegado ATC
-- =============================================
CREATE PROCEDURE [dbo].[uspClientesDelegadoATC]
	@Tipo int=0 -- Si 0: ATC , 1: AreaManager
	,@IdUsuario int
AS
BEGIN
	
	if @Tipo=0 
			-- Datos para el ATC
			select *
			from vrptCltesDelegATC
			where CodAgente=@IdUsuario
	else
			-- Datos para el Area Manager
			select *
			from vrptCltesDelegATC 
			where CodAreaManager=@IdUsuario
	
	-- Con esto controlo que si no hay datos no envie los emails de una suscripcion
	IF @@ROWCOUNT =0 RAISERROR ('No hay datos', 16, 1 )
END
GO
