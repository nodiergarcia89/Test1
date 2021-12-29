SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =========================================================
-- Author:		Ramon Villanueva
-- Create date: 21/01/2015
-- Description:	Traspaso datos SAP->InaCatalog
-- Este proceso se llama desde el Automator de inaCatalog
-- =========================================================
CREATE PROCEDURE [dbo].[usp_TraspasoDatos] 

AS
BEGIN
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************
  
  BEGIN TRY

	 -- Actualizar datos de AD en SAP
	 exec uspUpdateZPERSONAL
	 -- Traer datos de SAP
	 exec uspGetSAPTablas
	 -- Guardar cumplimiento de inversiones mensual
	 exec uspCargaCumpInversiones
	 -- Carga de Tablas de visitas
	 exec uspCargastgF2VisitasXONE
	 -- Funciones de interlocutor
	 exec uspDocInterlocutores
	 -- Actualizar Facturas modificadas
	 exec uspFacturasVSAP
	 -- Actualizar factura en visitas
	 exec uspAlbaranesFactura
	 -- Foto diaria del Stock
	 exec uspStockDiario
	 -- Pedidos Pendientes de Venta
	 exec uspPedidosPendientes
	 -- Albaranes Pendientes de Venta
	 exec uspAlbaranesPendientes
	 -- Foto diaria de la Deuda
	 exec uspDeudaDiaria
	 -- Recoger archivos en tabla
	 exec usp_ArchivosDirectorios
	 -- Carga del Forecast de ventas desde hoja Excel
	 --EXEC uspCargaForecastXLS 3/10/2019
	 -- Carga del Budget de ventas desde hoja Excel
	 --EXEC uspCargaBudgetXLS
	 -- Carga InaCatalog
	 exec uspCargaInacatalog
	 -- Carga asincrona del DW
	 --EXEC SVW2K12VM01.msdb.dbo.sp_start_job 'Carga del DW-SAP'

	 -- Comprobar clientes potenciales
	 EXEC usp_ComprobarAltaPotenciales

	 -- Borrar Logs
	 --EXEC msdb.dbo.sp_start_job 'Truncar logs'

  END TRY

  BEGIN CATCH
 
        DECLARE @ErrorMessage NVARCHAR(4000)
        DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
		EXEC utility.Log_ProcedureCall @ObjectID = @@PROCID;
        
		SELECT  @ErrorMessage = ERROR_MESSAGE(),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE()
 
        RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState)
 
    END CATCH

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
