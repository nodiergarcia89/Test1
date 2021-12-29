SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 13/11/2015
-- Description:	Periodos de calculo
-- ======================================================
CREATE FUNCTION [dbo].[ufPeriodo] 
(
	-- Add the parameters for the function here
	@Tipo char(30) -- Tipo de periodo a devolver
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultVar int

	-- devolver periodo
	if @Tipo='InicioAñoMovil'
		SELECT @ResultVar=DATEPART(year, DATEADD(mm, -12, GETDATE())) * 100 + DATEPART(month, DATEADD(mm, -12, GETDATE()))
	if @Tipo='Inicio6mMovil'
		SELECT @ResultVar=DATEPART(year, DATEADD(mm, -6, GETDATE())) * 100 + DATEPART(month, DATEADD(mm, -6, GETDATE()))
	if @Tipo='FinAñoMovil'
		select @ResultVar=datepart (year, DATEADD(MONTH , DATEDIFF (MONTH, '19000101', GETDATE()) - 1 , '19000101'))*100 + datepart (month, DATEADD(MONTH , DATEDIFF (MONTH, '19000101', GETDATE()) - 1, '19000101')) 
	if @Tipo='InicioAñoActual'
		select @ResultVar=DATEPART(year, GETDATE()) * 100 + 1 
	if @Tipo='PeriodoActual'
		select @ResultVar=(datepart(year,getdate()))*100 +datepart(month,getdate())
	if @Tipo='PeriodoActualAñoAnterior'
		select @ResultVar=(datepart(year,getdate())-1)*100 +datepart(month,getdate())
	if @Tipo='PeriodoAnterior'
		select @ResultVar=datepart(year,DATEADD(mm,-1,getdate())) * 100 + datepart(month,DATEADD(mm,-1,getdate()))
	if @Tipo='InicioAñoAnterior'
	   select @ResultVar=(DATEPART(year, GETDATE())-1) * 100 + 1 
	if @Tipo='FinAñoAnterior'
		select @ResultVar=(datepart(year,getdate())-1)*100 +12
	if @Tipo='PeriodoAnteriorAñoAnterior'
	   select @ResultVar=(DATEPART(year, GETDATE())-1) * 100 + datepart (month, DATEADD(MONTH , DATEDIFF (MONTH, '19000101', GETDATE()) - 1, '19000101'))
	if @Tipo='FechaHoyAAAAMMDD'
		select @ResultVar=CONVERT (varchar( 8), getdate(), 112 )
	
	-- Return the result of the function
	RETURN @ResultVar
				
END
GO
