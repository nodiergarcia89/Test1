SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 11/03/2015
-- Description:	Observaciones Articulo
-- Modificacion: 25/10/2016
--	   Añadir cantidad Minima
-- =============================================
CREATE FUNCTION [dbo].[udfObsArticulo] 
(
	-- Parameters for the function
	@CodEmpresa int
	,@CodArticulo nvarchar(18)
	,@Hashtag nvarchar(40)
)
RETURNS varchar(8000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result varchar(8000)=''
	declare @PlanNecesidades varchar(30)=''
	declare @CantidadMinima varchar(50)=''

	-- Devuelve sólo un registro por articulo
	SELECT @Result = COALESCE(@Result + CHAR(13)+CHAR(10), '') + ltrim(rtrim(Texto))
		FROM inaObsArticulos
		where	CodEmpresa=@CodEmpresa
				and CodArticulo=@CodArticulo
	
	-- Añadir hashtag de la marca de inaMarcas si no esta en las observaciones y la marca no es NO ASIGNADO
	if CHARINDEX('#',@Result)=0 and @Hashtag<>'#NO_ASIGNADO'
		select @Result=rtrim(@Result) + CHAR(13)+CHAR(10) + @Hashtag

     -- Añadir campo de planificación de necesidades
	select @PlanNecesidades=rtrim(PlanNecesidades)
	  from stgF2ArticulosSAP
	  where CodEmpresa=@CodEmpresa
	   and CodArticulo=@CodArticulo
	   and CodPlanNecesidades <>''

    -- Añadir cantidad minima
	select @CantidadMinima=format(CantidadMinima,'#,###.##')
	  from stgF2ArticulosSAP
	  where CodEmpresa=@CodEmpresa
	   and CodArticulo=@CodArticulo
	   and CantidadMinima >0

	select @Result=rtrim(@Result) + CHAR(13)+CHAR(10) + @PlanNecesidades + CHAR(13)+CHAR(10) + 'Cantidad Mínima: ' + @CantidadMinima

	-- Return the result of the function
	RETURN @Result

END
GO
