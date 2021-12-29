SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 19/05/2020
-- Description: Generar datos para B2B
-- =============================================
CREATE PROCEDURE [dbo].[uspB2BGenerarDatos]
AS
    BEGIN

	   -- Crear Catalogos
	   EXEC uspB2BCatalogos

	   -- Cargar Banners desde SAP
	   EXEC uspB2BBanners

	   -- Articulos del catalogo - InaSAP.dbo.iArticulosLFamB2B
	   EXEC uspB2BCatalogoArticulos
	   EXEC uspAjustarMarcasArticulosB2B

	   -- Articulos por cliente (Excepciones ZUL) - iArticulosLClientes
	   EXEC dbo.uspB2BArticulosLClientes

	   -- Las Familias inicialmente son las mismas con Articulos
	   EXEC uspB2BFamiliasSubFamilias

	   -- Clientes del catalogo - inaSAP.dbo.iClientesLCatB2B
	   EXEC uspB2BClientesCatalogo

	   -- Ajustar tarifas
	   EXEC uspB2BAjustarTarifas

	   -- Acceso del cliente a la plataforma - inaSAP.dbo.iClientesCredenciales
	   EXEC uspB2BClientesPlataforma

	   -- Facturas y Albaranes en PDF a Archivo
	   EXEC uspB2BFacturasAlbaranes

	   -- Direcciones de Clientes
	   EXEC uspB2BDireccionesClientes
    END
GO
