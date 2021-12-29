SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date:	20/04/2016
-- Description:	Foto Deuda diaria
-- =============================================
CREATE PROCEDURE [dbo].[uspDeudaDiaria]
AS
BEGIN
	SET NOCOUNT ON;
	
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	declare @Fecha_key int
	select @Fecha_key= format (@FechaProceso, 'yyyyMMdd', 'es-ES') -- AAAAMMDD
	
	-- Borrar registros del mismo periodo
	DELETE FROM stgFactDeudaDiaria
		WHERE FechaProceso_key=@Fecha_key

	-- Salida de datos
    INSERT INTO stgFactDeudaDiaria
    SELECT
	    @Fecha_key AS FechaProceso_key
         , t1.CodSociedad AS CodEmpresa
	    , t1.CodCliente
	    , t1.CodPagador
	    , t1.NumFactura
	    , t1.Visita
	    , t1.FechaFactura
	    , t1.FechaVto
	    , t1.DeudaAsegurada
	    , t1.TotalDeuda
	    , t1.DeudaComprometida
	    , t1.ImpTotFactura
	    , t1.Impagado
	    , t1.ImpPenFactura
	    , GETDATE() AS      create_timestamp
    FROM   vstgF2DeudaClientes AS t1

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************

END
GO
