SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 18/01/2016 fact_StockDiario
-- =============================================
CREATE PROCEDURE [dbo].[uspCargaFactStockAct] AS
BEGIN
	SET NOCOUNT ON;

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	exec uspStockDiario
	exec SVW2K12VM01.SAP_DW.dbo.uspCargaFactStockDiario


	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************

END

GO
