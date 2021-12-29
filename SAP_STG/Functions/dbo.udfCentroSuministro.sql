SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[udfCentroSuministro](
			 @CodArticulo   NVARCHAR(18)
)
RETURNS NVARCHAR(8)
AS
	BEGIN
	    DECLARE @Result NVARCHAR(8) -- Devuelvo WERKS & LGORT
	    DECLARE @Central NVARCHAR(8)='02000001'
	    DECLARE @Carreras NVARCHAR(8)='02909001'

	    -- Si no existe en MARD o esta de baja devuelvo @Central si no @Carreras
	    IF EXISTS (SELECT TOP 1 1 
				    FROM MARD 
				    WHERE CONVERT(INT,MATNR) = CONVERT(INT,@CodArticulo) 
					   AND WERKS='0290'
					   AND LVORM = '')
		  SELECT @Result=@Carreras
	    ELSE 
		  SELECT @Result=@Central

	    -- Devolver resultado
	    RETURN @Result
	END
GO
