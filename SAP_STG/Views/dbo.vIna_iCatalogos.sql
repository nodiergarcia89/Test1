SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 12/01/2015
-- Description:	Traspaso tablas inaCatalog. iCatalogos
-- Pagina 29
-- Modificacion: 05/06/2015
--   Catalogos de equipo y personal
-- Modificacion: 14/10/2015
--   Para central no genero catalogo.
--   Genero el Catalogo 5000 para Horeca Indirecta.
-- Modificacion 08/04/2020
--   Catalogo Historico para meter los articulos que estan
--   en iPedidosCentralLin y no en iArticulos
-- Modificacion 09/09/2020
--   Un catalogo general para cada Race que reemplazara al
--   catalogo general 2100.
-- ======================================================
CREATE VIEW [dbo].[vIna_iCatalogos]
AS
	SELECT DISTINCT 
		  t1.CodEmpresa
		, LTRIM(RTRIM(t1.CodCatalogo)) AS CodCatalogo
		, t1.desCatalogo
		, t1.obsCatalogo
		, '' AS                           nomImagenCat
		, '' AS                           nomIconoCat
		, 0 AS                            flaIcoModificado
		, 0 AS                            flaImgModificado
		, 0 AS                            ordCatalogo
	FROM     inaCatalogos AS t1
		    INNER JOIN inaAgentes AS t2
			 ON t1.CodEmpresa = t2.CodEmpresa
			    AND t1.CodCatalogo = t2.CodCatalogo
			    AND t2.Ina = 1
	UNION ALL ----------- 05/06/2015
	-- Un catalogo por delegacion para el equipo
	-- Excepto para central
	SELECT 
		  2 AS                         CodEmpresa
		, CodDelegacion + 3000 AS      CodCatalogo
		, Delegacion AS                desCatalogo
		, 'Catalogo para el equipo' AS obsCatalogo
		, '' AS                        nomImagenCat
		, '' AS                        nomIconoCat
		, 0 AS                         flaIcoModificado
		, 0 AS                         flaImgModificado
		, 0 AS                         ordCatalogo
	FROM     inaDelegaciones
	WHERE   Ina = 1
		   AND CodDelegacion <> 200
	UNION ALL 
	-- Un catalogo por cada vendedor 
	SELECT 
		  CodEmpresa
		, CodAgente + 4000 AS                CodCatalogo
		, Nombre COLLATE DATABASE_DEFAULT AS desCatalogo
		, 'Catalogo personal' AS             obsCatalogo
		, '' AS                              nomImagenCat
		, '' AS                              nomIconoCat
		, 0 AS                               flaIcoModificado
		, 0 AS                               flaImgModificado
		, 0 AS                               ordCatalogo
	FROM     inaAgentes
	WHERE   Ina = 1
		   AND CodAgente <> 53 -- El mio no
		   AND CodAgente <> 374 -- Viruete 
	UNION ALL
	-- Un catalogo para Horeca Indirecta
	SELECT DISTINCT 
		  CodEmpresa
		, 5000 AS                        CodCatalogo
		, 'HORECA INDIRECTA' AS          desCatalogo
		, 'Catalogo Horeca Indirecta' AS obsCatalogo
		, '' AS                          nomImagenCat
		, '' AS                          nomIconoCat
		, 0 AS                           flaIcoModificado
		, 0 AS                           flaImgModificado
		, 0 AS                           ordCatalogo
	FROM     inaAgentes
	WHERE   Ina = 1
		   AND Race = 1
	-- Catalogo de videos y manuales
	UNION ALL
	SELECT 
		  2 AS                               CodEmpresa
		, 1000 AS                            CodCatalogo
		, 'MANUALES Y VIDEOS' AS             desCatalogo
		, 'Catalogo de Manuales y Videos' AS obsCatalogo
		, '' AS                              nomImagenCat
		, '' AS                              nomIconoCat
		, 0 AS                               flaIcoModificado
		, 0 AS                               flaImgModificado
		, 0 AS                               ordCatalogo
	-- Catalogo de otros materiales
	UNION ALL
	SELECT 
		  2 AS                                CodEmpresa
		, 1001 AS                             CodCatalogo
		, 'MATERIAL ADICIONAL' AS             desCatalogo
		, 'Catalogo de Material adicional' AS obsCatalogo
		, '' AS                               nomImagenCat
		, '' AS                               nomIconoCat
		, 0 AS                                flaIcoModificado
		, 0 AS                                flaImgModificado
		, 0 AS                                ordCatalogo
	-- Catalogo Historico 08/04/2020
	UNION ALL
	SELECT 
		  2 AS                                                            CodEmpresa
		, 1002 AS                                                         CodCatalogo
		, 'HISTORICO' AS                                                  desCatalogo
		, 'Articulos en iPedidosCentralLin que no estan en iArticulos' AS obsCatalogo
		, '' AS                                                           nomImagenCat
		, '' AS                                                           nomIconoCat
		, 0 AS                                                            flaIcoModificado
		, 0 AS                                                            flaImgModificado
		, 0 AS                                                            ordCatalogo
	-- Un catalogo general para cada Race de Indirecta 09/09/2020
	UNION ALL
	SELECT DISTINCT 
		  CodEmpresa
		, 2000 + t.CodAgente AS                                 CodCatalogo
		, CONCAT('CATALOGO GENERAL', ' (', t.CodAgente, ')') AS desCatalogo
		, CONCAT('Catalogo Horeca Indirecta ', t.CodAgente) AS  obsCatalogo
		, '' AS                                                 nomImagenCat
		, '' AS                                                 nomIconoCat
		, 0 AS                                                  flaIcoModificado
		, 0 AS                                                  flaImgModificado
		, 0 AS                                                  ordCatalogo
	FROM   inaAgentes AS t
	WHERE  Ina = 1
		  AND Race = 1
GO
