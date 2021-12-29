SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- ====================================================
-- Author:		Ramon Villanueva
-- Create date: 05/06/2015
-- Description:	Vendedores como articulos
-- Modificacion: 22/10/2015
--               Viruete a huevo
-- ====================================================
CREATE VIEW [dbo].[vIna_iArticulosVend] as
SELECT t1.codEmpresa
      ,convert(nvarchar(30),t1.codAgente) codArticulo
      ,left(t1.Nombre,200) COLLATE DATABASE_DEFAULT desArticulo
      ,'' codEAN13
      ,'' datMedidas
      ,'' datPeso
      ,'' datVolumen
      ,left(dbo.udfObsArticuloVend(t1.CodEmpresa,t1.codAgente), 1000) obsArticulo
      ,'' hipArticulo
      ,0 valMinVenta
      ,1 valUniXCaja
      ,1 valUniXPalet
      ,0 valUniIncSencillo
      ,'' codTipoArticulo
      , case 
			when t1.CodAgente=374 then		-- Viruete
				5000
			when t1.Delegado=0 then
				4000 + CodAgente		-- Catalogo Personal
			when t1.Delegado=1 then 
				3000 + t2.CodDelegacion -- Catalogo Delegacion
		end codCatalogo
      ,1 codFamilia
      ,1 codSubFamilia
      ,'' codGrupoPreciosArticulo
      ,0 tpcIva
      ,0 tpcRe
      ,0 tpcIGIC
      ,'' codModeloTyC
      ,'' desModeloTyC
      ,0 stoDisponible
      ,0 stoPteRecibir
      ,'' datFechaEntradaPrevista
      ,0 ordArticulo
      ,0 preArticuloGen
      ,'' datNivel1
      ,'' datNivel2
      ,1 codEmpSuministradora
      ,0 flaNoAplicarDtoPP
      ,'' datMarcas
      ,0 prePuntos
      ,0 flaMuestra
FROM	inaAgentes as t1
	left outer join stgF2Vendedores as t2
		on t1.CodAgente=t2.CodVendedor
where Ina=1
		and t1.CodAgente<>53 -- el mio no

GO
