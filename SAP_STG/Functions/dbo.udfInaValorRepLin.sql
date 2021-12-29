SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 09/04/2015
-- Description:	Devolver valor campo reporte
-- =============================================
CREATE FUNCTION [dbo].[udfInaValorRepLin] 
(
	-- Parametros de la funcion
	@CodEmpresa int
	,@CodCliente nvarchar(20)
	,@Plantilla nvarchar(20)
	,@LineaReporte int
	,@Tipo int -- 1: minimo, 2: maximo
	,@Len int -- Longitud a devolver
)
RETURNS varchar(max)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result nvarchar(max)
	declare @CodReporte int

	-- Add the T-SQL statements to compute the return value here
	-- Recoger el valor minimo o maximo del reporte
	select @CodReporte=choose(@Tipo, min(CodReporte),  max(CodReporte))
		from iReportes_Pot
		where	codEmpresa=@CodEmpresa
				and codCliente=@CodCliente
				and codPlantillaReportes=@Plantilla

	-- Recoger el valor para el campo
	select @Result=datRespuesta
	from iReportesLin_Pot
	where	codEmpresa=@CodEmpresa 
			and codReporte = @CodReporte
			and codPlantillaReportes=@Plantilla
			and linReportesLin=@LineaReporte

	-- Devolver el resultado con la longitud pedida
	RETURN left(coalesce(@Result,''),@Len)

END
GO
