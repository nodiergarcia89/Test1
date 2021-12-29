SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE     FUNCTION [dbo].[udfCentroSuministro_Cliente](
			 @CodCliente   NVARCHAR(50)
)
RETURNS NVARCHAR(8)
AS
	BEGIN
	    DECLARE @Result NVARCHAR(8) -- Devuelvo WERKS & LGORT
	    DECLARE @Central NVARCHAR(8)='02000001'
	    DECLARE @Carreras NVARCHAR(8)='02909001'
	    DECLARE @Centro NVARCHAR(4)
	    DECLARE @Almacen NVARCHAR(4)

	    -- Obtener el centro de suministro del cliente
	    SELECT @Centro=VWERK
		  FROM   KNVV
		  WHERE  VKORG = '0200'
			    AND VTWEG = '01'
			    AND SPART = '01'
			    AND VWERK != ''
			    AND CONVERT(INT, KUNNR) = CONVERT(INT, @CodCliente)

	   --Si no existe almacen devuelvo Carreras
	   SELECT TOP 1 @Almacen=t.LGORT
	   FROM   T001L AS t
	   WHERE  XLONG = 'X'
			 AND WERKS = @Centro
	   ORDER BY LGORT
	   		
	   IF @@ROWCOUNT=0 OR @Almacen=''
		  SELECT @Result=@Carreras
	   ELSE
		 SELECT @Result=CONCAT(@Centro,@Almacen)

	    -- Devolver resultado
	    RETURN @Result
	END
GO
