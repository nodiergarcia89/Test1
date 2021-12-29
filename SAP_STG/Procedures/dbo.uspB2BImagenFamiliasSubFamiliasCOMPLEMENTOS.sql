SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ==========================================================
-- Author:	 Ramon Villanueva
-- Create date: 01/06/2020
-- Description: B2B. Imagen Dinamica Familias y Subfamilias
--  Catalogo Generico: COMPLEMENTOS
-- ==========================================================
CREATE PROCEDURE [dbo].[uspB2BImagenFamiliasSubFamiliasCOMPLEMENTOS]
AS
    BEGIN

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

	   -- Datos de ventas. Los mas vendidos con imagen
	   SELECT 
			t1.codEmpresa
		   , t4.codFamilia
		   , t4.codSubFamilia
		   , t1.codArticulo
		   , COUNT(*) AS Cantidad
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
			  INNER JOIN #ArticulosConImagen AS t5
			    ON t1.codEmpresa = t5.codEmpresa
				  AND t1.codArticulo = t5.codArticulo
	   WHERE   t4.codFamilia = 2 -- Complementos
	   --AND DATEDIFF(month, t2.FecPedido, GETDATE()) <= 12 -- Ultimos 12 meses de ventas
	   GROUP BY 
			  t1.codEmpresa
			, t4.codFamilia
			, t4.codSubFamilia
			, t1.codArticulo
	   -- Mas todos los articulos con imagenes (por si no se han vendido)
	   UNION
	   SELECT 
			t1.codEmpresa
		   , t2.codFamilia
		   , t2.codSubFamilia
		   , t1.codArticulo
		   , 1 AS Cantidad
	   FROM   #ArticulosConImagen AS t1
			INNER JOIN sym_iArticulos AS t2
			  ON t1.codEmpresa = t2.codEmpresa
				AND t1.codArticulo = t2.codArticulo

	   -- Datos agrupados
	   SELECT 
			codEmpresa
		   , codFamilia
		   , codSubFamilia
		   , codArticulo
		   , Cantidad
		   , ROW_NUMBER() OVER(PARTITION BY codEmpresa
								    , codFamilia
								    , codSubFamilia
			ORDER BY 
				    Cantidad DESC) AS RowNumSubFamilia
		   , ROW_NUMBER() OVER(PARTITION BY codEmpresa
								    , codFamilia
			ORDER BY 
				    Cantidad DESC) AS RowNumFamilia
	   INTO 
		   #Datos
	   FROM   #Tabla

	   -- Imagenes
	   SELECT 
			codEmpresa
		   , 'COMPLEMENTOS' AS codCatalogo
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
		   , 'COMPLEMENTOS' AS codCatalogo
		   , codFamilia
		   , 0 AS              codSubFamilia
		   , codArticulo
	   FROM   #Datos
	   WHERE  RowNumFamilia = 1 -- El mas vendido de cada familia
	   -- Actualizar la imagen de las familias y subfamilias
	   UPDATE sym_iFamiliasB2B
		SET  
		    nomImagenFam=COALESCE(t2.codArticulo, 'sinimagen')
	   FROM   sym_iFamiliasB2B AS t1
			LEFT JOIN #Imagenes AS t2
			  ON t1.codEmpresa = t2.codEmpresa
				AND t1.codCatalogo = t2.codCatalogo
				AND t1.codFamilia = t2.codFamilia
				AND t1.codSubfamilia = t2.codSubFamilia
	   WHERE  
		    t1.CodCatalogo = 'COMPLEMENTOS'

	   -- Actualizo las imagenes fijas: Complementos y PLV
	   UPDATE sym_iFamiliasB2B
		SET  
		    nomImagenFam=CONCAT('sub', t1.codFamilia, '_', t1.codSubfamilia)
	   FROM   sym_iFamiliasB2B t1
	   WHERE  
		    t1.codCatalogo = 'COMPLEMENTOS'
		    AND t1.codFamilia IN(2, 6)
    END
GO
