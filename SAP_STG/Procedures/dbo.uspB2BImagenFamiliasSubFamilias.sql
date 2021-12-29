SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================
-- Author:	 Ramon Villanueva
-- Create date: 29/05/2020
-- Description: B2B. Imagen Dinamica Familias y Subfamilias
-- ==========================================================
CREATE PROCEDURE [dbo].[uspB2BImagenFamiliasSubFamilias] AS
    BEGIN

	   -- Unidades de Medida
	   SELECT 
			t.CodEmpresa
		   , t.CodArticulo
		   , t.Conversion_U_KG
	   INTO 
		   #ConvKilos
	   FROM   vConversionUM AS t
	   WHERE  UVenta_U <> 'KG'
			AND UVenta_KG = 'KG'

	   -- Datos de ventas
	   SELECT 
			t1.codEmpresa
		   , t2.codCliente
		   , t4.codFamilia
		   , t4.codSubFamilia
		   , t1.codArticulo
		   , SUM(t1.canLinPed / COALESCE(t5.Conversion_U_KG, 1)) AS Cantidad
	   INTO 
		   #Tabla
	   FROM     sym_iPedidosCentralLin AS t1
			  INNER JOIN sym_iPedidosCentral AS t2
			    ON t1.codEmpresa = t2.codEmpresa
				  AND t1.codPedido = t2.codPedido
			  INNER JOIN sym_par_inaClientes AS t3
			    ON t1.codEmpresa = t3.codEmpresa
				  AND t2.codCliente = t3.CodCliente
				  AND t3.Ina = 1
			  INNER JOIN sym_iArticulos AS t4
			    ON t1.codEmpresa = t4.codEmpresa
				  AND t1.codArticulo = t4.codArticulo
				  AND t4.codCatalogo = 2100
			  LEFT JOIN #ConvKilos AS t5
			    ON t1.codEmpresa = t5.codEmpresa
				  AND t1.codArticulo = t5.codArticulo
	   WHERE   DATEDIFF(month, t2.FecPedido, GETDATE()) <= 12 -- Ultimos 12 meses de ventas
	   GROUP BY 
			  t1.codEmpresa
			, t2.codCliente
			, t4.codFamilia
			, t4.codSubFamilia
			, t1.codArticulo
	   -- Articulos en  condiciones
	   UNION
	   SELECT DISTINCT 
			t2.codEmpresa
		   , t2.codCliente
		   , t1.codFamilia
		   , t1.codSubFamilia
		   , t2.codArticulo
		   , 1 AS Cantidad
	   FROM   sym_iPreciosEspLin AS t2
			INNER JOIN sym_par_inaClientes AS t3
			  ON t2.codEmpresa = t3.codEmpresa
				AND t2.codCliente = t3.CodCliente
				AND t3.Ina = 1
			INNER JOIN sym_iArticulos AS t1
			  ON t2.CodEmpresa = t1.codEmpresa
				AND t2.codArticulo = t1.codArticulo

	   -- Datos agrupados
	   SELECT 
			codEmpresa
		   , codCliente
		   , codFamilia
		   , codSubFamilia
		   , codArticulo
		   , Cantidad
		   , ROW_NUMBER() OVER(PARTITION BY codEmpresa
								    , codCliente
								    , codFamilia
								    , codSubFamilia
			ORDER BY 
				    Cantidad DESC) AS RowNumSubFamilia
		   , ROW_NUMBER() OVER(PARTITION BY codEmpresa
								    , codCliente
								    , codFamilia
			ORDER BY 
				    Cantidad DESC) AS RowNumFamilia
	   INTO 
		   #Datos
	   FROM   #Tabla

	   -- Imagenes
	   SELECT 
			codEmpresa
		   , codCliente AS codCatalogo
		   , codFamilia
		   , codSubFamilia
		   , codArticulo
	   INTO 
		   #Imagenes
	   FROM     #Datos
	   WHERE   RowNumSubFamilia = 1 -- El mas vendido de cada subfamilia
	   UNION
	   SELECT 
			codEmpresa
		   , codCliente AS codCatalogo
		   , codFamilia
		   , 0 AS          codSubFamilia
		   , codArticulo
	   FROM   #Datos
	   WHERE  RowNumFamilia = 1 -- El mas vendido de cada familia
	   -- ArticulosConImagen AS
	   SELECT 
			codEmpresa
		   , codArticulo
		   , nomImagenArt
	   INTO 
		   #ArticulosConImagen
	   FROM   sym_iArticulosLImg AS t
	   WHERE  t.flaHayImg = 1
			AND t.linImgArt = 0

	   -- Actualizar la imagen de las familias y subfamilias
	   UPDATE sym_iFamiliasB2B
		SET  
		    nomImagenFam=COALESCE(t3.nomImagenArt, 'sinimagen')
	   FROM   #Imagenes AS t1
			INNER JOIN sym_iFamiliasB2B AS t2
			  ON t1.codEmpresa = t2.codEmpresa
				AND t1.codCatalogo = t2.codCatalogo
				AND t1.codFamilia = t2.codFamilia
				AND t1.codSubfamilia = t2.codSubFamilia
			LEFT JOIN #ArticulosConImagen AS t3
			  ON t1.codEmpresa = t3.codEmpresa
				AND t1.codArticulo = t3.codArticulo

	   -- Actualizo las imagenes fijas: Complementos y PLV
	   UPDATE sym_iFamiliasB2B
		SET  
		    nomImagenFam=CONCAT('sub', t1.codFamilia, '_', t1.codSubfamilia)
	   FROM   sym_iFamiliasB2B t1
			INNER JOIN sym_par_inaClientes AS t2
			  ON t1.codEmpresa = t2.codEmpresa
				AND ISNUMERIC(t1.CodCatalogo)=1
				AND t1.codCatalogo = t2.codCliente
				AND t2.Ina = 1
	   WHERE  
		    t1.codFamilia IN(2, 6)
    END
GO
