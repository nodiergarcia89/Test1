SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 29/05/2020
-- Description: B2B. Crear Familias y Subfamilias
-- Para el cafe no hay desglose de Subfamilias
-- =============================================
CREATE   PROCEDURE [dbo].[uspB2BFamiliasSubFamilias]
AS
    BEGIN
	   -- Borrar tablas (No hay FK) 
	   DELETE sym_iFamiliasB2B

	   -- Las Familias inicialmente son las mismas con Articulos
	   ;
	   WITH Familias
		   AS (SELECT DISTINCT 
				    codEmpresa
				  , codCatalogo
				  , codFamilia
				  , codSubFamilia
			  FROM   sym_iArticulosLFamB2B)
		   INSERT INTO sym_iFamiliasB2B
		   SELECT 
				t1.codEmpresa
			   , t2.codCatalogo
			   , t1.codFamilia
			   , t1.codSubFamilia
			   , t1.desFamilia
			   , t1.nomIcoFamilia
			   , t1.ordFamilia
			   , t1.flaIcoModificado
			   , t1.obsFamilia
			   , t1.nomImagenFam
			   , t1.flaImgModificado
		   FROM     sym_iFamilias AS t1
				  INNER JOIN Familias AS t2
				    ON t1.codEmpresa = t2.codEmpresa
					  AND t1.codFamilia = t2.codFamilia
					  AND t1.codSubFamilia = t2.codSubFamilia
		   WHERE   t1.codEmpresa = 2
				 AND t1.codCatalogo = 2100
		   UNION
		   SELECT 
				t1.codEmpresa
			   , t2.codCatalogo
			   , t1.codFamilia
			   , t1.codSubFamilia
			   , t1.desFamilia
			   , t1.nomIcoFamilia
			   , t1.ordFamilia
			   , t1.flaIcoModificado
			   , t1.obsFamilia
			   , t1.nomImagenFam
			   , t1.flaImgModificado
		   FROM   sym_iFamilias AS t1
				INNER JOIN Familias AS t2
				  ON t1.codEmpresa = t2.codEmpresa
					AND t1.codFamilia = t2.codFamilia
					AND t1.codSubFamilia = 0
		   WHERE  t1.codEmpresa = 2
				AND t1.codCatalogo = 2100

	   	   -- Actualizar las imagenes de las familias con la del mas vendido (supongo que existe)
		   EXEC uspB2BImagenFamiliasSubFamilias
		   EXEC uspB2BImagenFamiliasSubFamiliasCOMPLEMENTOS


		  -- Elimino el desglose de subfamilias de Cafe
		  DELETE sym_iFamiliasB2B
		  WHERE codFamilia=1
		  AND codSubfamilia NOT IN(0,1)

		  -- Renombro la Familia Cafe
		  UPDATE sym_iFamiliasB2B
		  SET desFamilia='CAFÉ'
		  WHERE codFamilia=1

		  -- Añado las familias para el catalogo multimedia
		  INSERT INTO sym_iFamiliasB2B
			    (
			    t1.codEmpresa
			  , t2.codCatalogo
			  , t1.codFamilia
			  , t1.codSubFamilia
			  , t1.desFamilia
			  , t1.nomIcoFamilia
			  , t1.ordFamilia
			  , t1.flaIcoModificado
			  , t1.obsFamilia
			  , t1.nomImagenFam
			  , t1.flaImgModificado
			    )
		  SELECT 2, 'MULTIMEDIA', 1, 0, 'Un  dia con…', '', 1, 0, 'Videos actividad', 'subM1_0', 0
		  UNION ALL
		  SELECT 2, 'MULTIMEDIA', 2, 0, 'Recetas', '', 2, 0, 'Videos recetas', 'subM2_0', 0
		  UNION ALL
		  SELECT 2, 'MULTIMEDIA', 3, 0, 'Ferias o Eventos', '', 3, 0, 'Videos ferias', 'subM3_0', 0
		  UNION ALL
		  SELECT 2, 'MULTIMEDIA', 4, 0, 'Spots', '', 4, 0, 'Videos Spots', 'subM4_0', 0
		  UNION ALL
		  SELECT 2, 'MULTIMEDIA', 1, 1, 'Un  dia con…', '', 1, 0, 'Videos actividad', '', 0
		  UNION ALL
		  SELECT 2, 'MULTIMEDIA', 2, 1, 'Recetas', '', 2, 0, 'Videos recetas', '', 0
		  UNION ALL
		  SELECT 2, 'MULTIMEDIA', 3, 1, 'Ferias o Eventos', '', 3, 0, 'Videos ferias', '', 0
		  UNION ALL
		  SELECT 2, 'MULTIMEDIA', 4, 1, 'Spots', '', 4, 0, 'Videos Spots', '', 0
    END
GO
