SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 29/05/2020
-- Description: B2B. Crear Articulos de los catalogos
-- Modificacion: 19/04/2021
--   Las imagenes deben añadirse a iarticuloslimg para que se generen 
--  las miniaturas.
-- =============================================
CREATE PROCEDURE [dbo].[uspB2BCatalogoArticulos]
AS
    BEGIN
    
        -- Borrar tablas (No hay FK) 
	   DELETE sym_iArticulosLFamB2B;

	   -- Articulos del catalogo - InaSAP.dbo.iArticulosLFamB2B
	   WITH Articulos
		   AS (
		   -- Articulos en  condiciones
		   SELECT DISTINCT 
				t1.codEmpresa
			   , t1.codCliente
			   , t1.CodFamilia
			   , t1.CodSubFamilia
			   , t1.codArticulo
		   FROM     vCondicionesClienteArticulo AS t1
		   UNION 
		   -- Articulos en Ventas
		   SELECT 
				t1.codEmpresa
			   , t1.codCliente
			   , t1.CodFamilia
			   , t1.CodSubFamilia
			   , t1.codArticulo
		   FROM     vVentasClienteArticulo AS t1
		   -- Articulos a Incluir Siempre para TODOS los Clientes
		   UNION
		   SELECT 
				codEmpresa
			   , CodCliente
			   , CodFamilia
			   , CodSubFamilia
			   , CodArticulo
		   FROM   vIncluirClienteArticulo)

	   -- Llenar la tabla con los articulos de cada cliente
	   -- manteniendo la estructura del catalogo, excepto para el cafe que todo va a la
	   -- subfamilia 1
	   INSERT INTO sym_iArticulosLFamB2B
	   SELECT 
			t1.codEmpresa
		   , t1.codArticulo
		   , t1.codCliente AS                               codCatalogo
		   , t1.codFamilia
		   , IIF(t1.codFamilia = 1, 1, t1.codSubFamilia) AS codSubFamilia
		   , 0 AS                                           ordArticulo
	   FROM   Articulos AS t1

	   -- Modificar el orden segun Ventas
	   UPDATE sym_iArticulosLFamB2B
		SET  
		    ordArticulo=COALESCE(t2.RowNum, 999)
	   FROM   sym_iArticulosLFamB2B AS t1
			LEFT JOIN vVentasClienteArticulo AS t2
			  ON t1.codEmpresa = t2.codEmpresa
				AND t1.codCatalogo = t2.codCliente
				AND t1.codArticulo = t2.codArticulo
	   WHERE  
		    t1.codCatalogo <> 'COMPLEMENTOS'
		    AND t1.codCatalogo <> 'MULTIMEDIA'

	   -- Llenar el catalogo general de complementos
	   INSERT INTO sym_iArticulosLFamB2B
	   SELECT 
			t1.codEmpresa
		   , t1.codArticulo
		   , 'COMPLEMENTOS' AS codCatalogo
		   , t1.codFamilia
		   , t1.codSubFamilia
		   , 0 AS              ordArticulo
	   FROM   dbo.vIna_iArticulosB2B AS t1
	   WHERE  t1.CodCatalogo = 2100
			AND t1.CodFamilia = 2 -- Complementos
			AND t1.Complementos = 1 -- Marcas a traspasar
	   -- Eliminar articulos a Excluir de TODOS los catalogos
	   DELETE sym_iArticulosLFamB2B
	   WHERE  
		    CodArticulo IN  -- Articulos a Excluir
	   (
		  SELECT 
			    CONVERT(INT, MATNR)
		  FROM   sym_SAP_ZB2MATERIAL
		  WHERE  MANDT = 100
			    AND EXB2B = 'X'
	   )

	   -- Imagenes articulos B2B
	   SELECT 
			2 AS                     CodEmpresa --pk
		   , t1.codarticulo AS        CodArticulo --pk
		   , 0 AS                     linImgArt --pk
		   , 0 AS                     sliImgArt --pk
		   , LOWER(t1.CodArticulo) AS nomImagenArt
		   , 0 AS                     flaImgModificada
		   , 1 AS                     flaHayImg
	   INTO 
		   #Tabla
	   FROM   inaSAM.dbo.V_Web_iArticulos_Perso AS t1

	   -- Borrar previamente
	   DELETE dbo.sym_iArticulosLImg
	   FROM dbo.sym_iArticulosLImg t1
		   INNER JOIN #Tabla t2
			ON t1.CodEmpresa = t2.CodEmpresa
			   AND t1.CodArticulo = t2.CodArticulo
			   AND t1.linImgArt = t2.linImgArt
			   AND t1.sliImgArt = t2.sliImgArt

	   -- Insertarlos
	   INSERT INTO dbo.sym_iArticulosLImg
	   SELECT 
			*
	   FROM   #Tabla
    END
GO
