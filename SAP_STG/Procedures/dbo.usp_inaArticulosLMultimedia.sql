SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- =================================================================
-- Author:		Ramon Villanueva
-- Create date: 30/06/2015
-- Description:	Traspaso tablas inaCatalog. iArticulosLMultimedia
-- =================================================================
CREATE PROCEDURE [dbo].[usp_inaArticulosLMultimedia] AS
BEGIN
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

		-- La tabla de destino ha de estar vacia.
		-- La borro aqui pero se borra en el proceso de InaSources
		delete from sym_iArticulosLMultimedia
		
		-- Articulos multimedia
		exec usp_inaArtLMult1

		-- Agentes como Articulos multimedia
		exec usp_inaArtLMult2

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END



GO
