SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 14/01/2016
-- Description:	KPI. TablesActualizadasHoy
-- =============================================
CREATE PROCEDURE [dbo].[uspKPI_TablesActualizadasHoy] 
	-- Add the parameters for the stored procedure here
	@Tipo int = 1 -- 1: Valor, 2: Objetivo, 3: Status, 4: Tendencia
AS
BEGIN
	SET NOCOUNT ON;

	-- Declarar variables
	declare @NumTabsAct int
	declare @NumTabsIna int

	-- Parametros del KPI
	declare @Valor int
	declare @Objetivo int
	declare @Status int
	declare @Tendencia as table
		(Id int IDENTITY(1,1) NOT NULL,
		 Valor nvarchar(100) NOT NULL)

	-- Variables auxiliares
	declare @PStatus int
	declare @PeriodoInicio int
	declare @PeriodoActual int

	-- Calcular valores
	select @NumTabsAct=count(distinct codvendedor)
		FROM [SAP_STG].[dbo].[vUltimaActualizacionDatos]
		where [FechaUltActividad]>convert(date,getdate())

	select @Valor=@NumTabsAct

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

	-- Tendencia (7 meses atras)
	select @PeriodoActual=datepart(year,getdate())*100+datepart(month,getdate())
	select @PeriodoInicio=(DATEPART(year, GETDATE())-1) * 100 + datepart (month, DATEADD(MONTH , DATEDIFF (MONTH, '19000101', GETDATE()) - 7, '19000101'))

	insert into @Tendencia
	select count(*) Rango
	FROM vrptUltimaActualizacion
	group by Rango

	-- Devolver resultado segun tipo de llamada
	if @Tipo=1 select @Valor
	if @Tipo=2 select @Objetivo
	if @Tipo=3 select @Status
	if @Tipo=4 select Valor from @Tendencia order by Id

END
GO
