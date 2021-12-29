SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 14/01/2016
-- Description:	KPI. TablesVisitasAyer
-- =============================================
CREATE PROCEDURE [dbo].[uspKPI_TablesVisitasAyer] 
	-- Add the parameters for the stored procedure here
	@Tipo int = 1 -- 1: Valor, 2: Objetivo, 3: Status, 4: Tendencia
AS
BEGIN
	SET NOCOUNT ON;

	-- Declarar variables
	declare @NumTabsVisit int
	declare @NumTabsIna int
	
	-- Parametros del KPI
	declare @Valor int
	declare @Objetivo int
	declare @Status int

	-- Variables auxiliares
	declare @PStatus int
	declare @PeriodoInicio int
	declare @PeriodoActual int
		
	-- Calcular valores
	select @NumTabsVisit=count(distinct nomIPad)
		from sym_iReportes
		where convert(date,fecReporte)=convert(date,DATEADD(d,-1,GETDATE())) -- Ayer
				and codPlantillaReportes in(113, 114, 115)

	select @Valor=@NumTabsVisit

	-- Objetivo
	SELECT @NumTabsIna=count(*)
		from inaAgentes
		where Tablet=1
	select @Objetivo=@NumTabsIna

	-- Status
	select @PStatus=(@Valor*100)/@Objetivo

	-- -1: <33%, 0: entre 33 y 66%, 1: mas 66%
	select @Status=(case 
				when @PStatus<33 then -1
				when @PStatus between 33 and 66 then 0
				else 1
			   end)
	
	-- Devolver resultado segun tipo de llamada
	if @Tipo=1 select @Valor
	if @Tipo=2 select @Objetivo
	if @Tipo=3 select @Status

END
GO
