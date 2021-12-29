SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 06/10/2021
-- Description: 
--	   La tabla para controlar ZUL por cliente es iArticulosLClientes 
--	   datCustom2 --> valMinVenta
--	   datCustom3 --> valUniIncSencillo 
-- =============================================
CREATE   PROCEDURE [dbo].[uspB2BArticulosLClientes]
AS
BEGIN
    DECLARE 
		 @Carreras NVARCHAR(4)='0290'

    -- Borrar tabla destino
    DELETE sym_iArticulosLClientes
    --Llenar la tabla por cliente si el centro de suministro no es Carreras
    INSERT INTO sym_iArticulosLClientes
		 (
		 CodEmpresa
	    , codArticulo
	    , CodCliente
	    , datCustom2
	    , datCustom3
		 )
    SELECT 
		 t.codEmpresa
	    , t.codArticulo
	    , t.codCatalogo AS                                                              codCliente
	    , IIF(UVenta_U = 'KG'
			AND Conversion_U_ST IS NOT NULL, Conversion_U_KG / Conversion_U_ST, 1) AS datCustom2 --valMinVenta
	    , IIF(UVenta_U = 'KG'
			AND Conversion_U_ST IS NOT NULL, Conversion_U_KG / Conversion_U_ST, 1) AS datCustom3 --valUniIncSencillo
    FROM   sym_iArticulosLFamB2B AS t
		 INNER JOIN dbo.KNVV AS s
		   ON CONVERT(INT, t.codCatalogo) = CONVERT(INT, s.KUNNR)
		 INNER JOIN dbo.vConversionUM AS r
		   ON t.CodEmpresa = t.codEmpresa
			 AND t.codArticulo = r.codArticulo
    WHERE  s.VKORG = '0200'
		 AND s.VTWEG = '01'
		 AND s.SPART = '01'
		 AND s.VWERK NOT IN('', @Carreras)
		 AND ISNUMERIC(t.codCatalogo) = 1
END
GO
