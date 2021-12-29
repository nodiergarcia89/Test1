SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ====================================================
-- Author:		Ramon Villanueva
-- Create date: 22/12/2014
-- Description:	Traspaso tablas inaCatalog. iArticulos
-- Pagina 4
-- Modificacion: 14/12/2021
--  No se admiten decimales en los campos:
--	   valMinVenta, valUniXCaja y valUniIncSencillo 
-- ====================================================
CREATE VIEW [dbo].[vIna_iArticulos]
AS
	SELECT 
		  t1.codEmpresa
		, t1.codArticulo
		, LEFT(t1.desArticulo, 200) AS                                                 desArticulo
		, LEFT(t1.codEAN13, 13) AS                                                     codEAN13
		, LEFT(t1.datMedidas, 50) AS                                                   datMedidas
		, LEFT(t1.datPeso, 50) AS                                                      datPeso
		, LEFT(t1.datVolumen, 50) AS                                                   datVolumen
		, LEFT(dbo.udfObsArticulo(t1.CodEmpresa, t1.CodArticulo, t4.Hashtag), 1000) AS obsArticulo
		, LEFT(t1.hipArticulo, 250) AS                                                 hipArticulo
		, CEILING(t1.valMinVenta) AS                                                   valMinVenta
		, CEILING(t1.valUniXCaja) AS                                                   valUniXCaja
		, t1.valUniXPalet
		, CEILING(t1.valUniIncSencillo) AS                                             valUniIncSencillo
		, LEFT(t1.codTipoArticulo, 20) AS                                              codTipoArticulo
		, 2100 AS                                                                      codCatalogo-- Catalogo General
	--,t4.codCatalogo -- Catalogo General
		, t1.codFamilia
		, t1.codSubFamilia
		, LEFT(t1.codGrupoPreciosArticulo, 20) AS                                      codGrupoPreciosArticulo
		, t1.tpcIva
		, t1.tpcRe
		, t1.tpcIGIC
		, LEFT(t1.codModeloTyC, 30) AS                                                 codModeloTyC
		, LEFT(t1.desModeloTyC, 50) AS                                                 desModeloTyC
		, t1.stoDisponible
		, t1.stoPteRecibir
		, LEFT(t1.datFechaEntradaPrevista, 50) AS                                      datFechaEntradaPrevista
		, t1.ordArticulo
		, t1.preArticuloGen
		, LEFT(t1.datNivel1, 50) AS                                                    datNivel1
		, LEFT(t1.datNivel2, 50) AS                                                    datNivel2
		, t1.codEmpSuministradora
		, t1.flaNoAplicarDtoPP
		, LEFT(t1.datMarcas, 20) AS                                                    datMarcas
		, t1.prePuntos
		, t1.flaMuestra
	FROM     stgIna_iArticulosF1 AS t1
		    INNER JOIN inaFamilias AS t2 --Familias a traspasar
			 ON t1.codFamilia = t2.codFamilia
			    AND t1.codSubFamilia = t2.codSubFamilia
			    AND t2.Ina = 1
		    INNER JOIN inaTiposArticulos AS t3 -- Tipos de Articulo a traspasar
			 ON t1.codTipoArticulo = t3.CodTipoMaterial
			    AND t3.Ina = 1
		    INNER JOIN inaMarcas AS t4 -- Marcas a traspasar
			 ON t1.CodMarca = t4.CodMarca
			    AND t4.Ina = 1
	WHERE   t1.ExcluirInacatalog = 0 -- 16/09/2020

	UNION ALL
	-- Vendedores como Articulos
	SELECT 
		  *
	FROM     vIna_iArticulosVend
	-- Manuales y videos como articulos
	UNION ALL
	SELECT 
		  *
	FROM   InaArticulos
	WHERE  CodCatalogo <> 'MULTIMEDIA'
GO
