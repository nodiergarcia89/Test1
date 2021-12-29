SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================================
-- Author:		Ramon Villanueva
-- Create date: 09/01/2015
-- Description:	Crear estructura catalogos
--  Se utiliza sólo para generar la estructura de catalogos por delegacion
--  No se llama desde ningun sitio.
--  Desde aqui decidimos si se lleva un catalogo por delegacion y uno central
--  O sólo un catalogo general
-- =========================================================================
CREATE PROCEDURE [dbo].[usp_inaEstructuraCatalogos] 
	@Tipo int=0
		 --Tipo=0 Un catalogo por delegacion y uno central
		 --Tipo=1 Sólo un catalogo central
AS
BEGIN
	SET NOCOUNT ON;

    -- Borrado
	delete from inaCatalogosDelegacion

	if @Tipo=0
		-- Un catalogo por delegacion
		insert into inaCatalogosDelegacion
		SELECT [CodEmpresa]
			  ,[CodCatalogo]
			  ,[CodCatalogo] CodDelegacion
		  FROM [SAP_STG].[dbo].[inaCatalogos]
		  where CodCatalogo<1000

	-- Un catalogo general con todas las delegaciones
	insert into inaCatalogosDelegacion
	SELECT [CodEmpresa]
		  ,2100 [CodCatalogo]
		  ,[CodCatalogo] CodDelegacion
	  FROM [SAP_STG].[dbo].[inaCatalogos]
	  where CodCatalogo<1000

	-- Central al catalogo general
	insert into inaCatalogosDelegacion
		values(2, '2100', 200)
END
GO
