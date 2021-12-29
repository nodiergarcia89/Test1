SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 03/08/2015
-- Description:	Control Actualizacion
-- =============================================

CREATE PROCEDURE [dbo].[uspControlActualizacion]
	@IdUsuario int
AS
BEGIN
	
	set language english

	-- declarar variables
	declare @DiasDif int
	declare @DiasMargen int
	declare @DiaSemana int=1

	---- Calcular dias margen en funcion del dia actual
	select @DiaSemana=DATEPART(w, getdate())

	---- Los lunes, jueves y viernes 4 dias, martes 5 y miercoles 6
	select @DiasMargen=CHOOSE(@DiaSemana,4,4,5,6,4,4,3)

	select @DiasDif=DiasDif
	FROM    vrptUltimaActualizacion
	WHERE   CodVendedor = @IdUsuario

	SELECT CodVendedor
			, NombreCompleto
			, CodDelegacion
			, Delegacion
			, CodAreaManager
			, AreaManager
			, CodDelegado
			, Delegado
			, FechaUltActividad
			, DiasDif
	FROM    vrptUltimaActualizacion
	WHERE   CodVendedor = @IdUsuario


	-- Con esto controlo que si no hay datos no envie los emails de una suscripcion
	IF @DiasDif<@DiasMargen RAISERROR ('No hay datos', 16, 1 )
END
GO
