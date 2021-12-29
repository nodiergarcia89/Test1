SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 13/01/2016
-- Description:	KPI. visitas realizadas
-- =============================================
CREATE PROCEDURE [dbo].[uspKPI_VisitasRealizadas] 
	-- Add the parameters for the stored procedure here
	@Tipo int = 1 -- 1: Valor, 2: Objetivo, 3: Status, 4: Tendencia
AS
BEGIN
	SET NOCOUNT ON;

	-- Declarar variables
	declare @NumVisitas int
	declare @MaxVisitas int
	
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
	select @NumVisitas=count(*) 
		  FROM [SAP_STG].[dbo].[stgF3AnalisisVisitas]
		  where Año=datepart(year,getdate())
			  and Mes=datepart(month,getdate())
	select @Valor=@NumVisitas

	-- Objetivo
	SELECT @MaxVisitas=avg(NumVisitas)
		from(
		SELECT año, mes,count(*) NumVisitas
		  FROM [SAP_STG].[dbo].[stgF3AnalisisVisitas]
		group by año,mes
		) t1
	select @Objetivo=@MaxVisitas

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
	select count(*) NumVisitas
		from [SAP_STG].[dbo].[stgF3AnalisisVisitas]
	where (Año*100 + Mes) >= @PeriodoInicio and (Año*100 + Mes)<@PeriodoActual
	group by Año*100 + Mes 
	order by Año*100 + Mes 

	-- Devolver resultado segun tipo de llamada
	if @Tipo=1 select @Valor
	if @Tipo=2 select @Objetivo
	if @Tipo=3 select @Status
	if @Tipo=4 select Valor from @Tendencia order by Id

END
GO
