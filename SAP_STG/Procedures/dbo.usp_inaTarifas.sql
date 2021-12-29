SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 03/12/2015
-- Description:	Completar Tarifas
--   LOs parametros vienen de SAP. ZSD035
-- =============================================
CREATE procedure [dbo].[usp_inaTarifas]
as
begin
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

		-- Datos de SAP
	MERGE INTO inaTarifas t1
	USING vSAP_Tarifas t2
	ON (t1.CodTarifa COLLATE DATABASE_DEFAULT=t2.CodTarifa)
	WHEN MATCHED
		AND
			(t1.Tarifa COLLATe DATABASE_DEFAULT != t2.Tarifa
			 OR t1.Folleto != t2.Folleto)
		THEN UPDATE
			SET t1.Tarifa=t2.Tarifa
				, t1.Folleto=t2.Folleto;

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
end

GO
