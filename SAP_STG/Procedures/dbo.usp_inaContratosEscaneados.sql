SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 28/10/2015
-- Description: Contratos escaneados
-- Hay escaneados que no se cargan al estar finalizados
-- Modificacion 07/11/2017
--    Para los clientes de tipo '26' y '31' no
-- Modificacion 18/04/2020
--    Para los clientes de tipo '13' y '23' no
-- =============================================
CREATE procedure [dbo].[usp_inaContratosEscaneados] AS
BEGIN

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	set LANGUAGE SPANISH

	-- Lista de contratos escaneados
	select NumDoc NumContrato
			--,ModifyDate
			,dateadd(hour,2,ModifyDate) ModifyDate -- Le SUMO dos horas para ajustar
	into #Tabla1
	from stgIna_Archivos
	where Tipo='Contrato'
	
	-- Todos los clientes se envian a los iPads y tienen contrato escaneado y no son baja
	SELECT distinct t1.CodEmpresa
			, t1.CodCliente
			, t3.NumContrato
			, t4.ModifyDate
    INTO #tmp_Tabla2
	FROM    stgF3Clientes AS t1 
			INNER JOIN sym_iClientes AS t2 
				ON	convert(varchar,t1.CodCliente) = t2.CodCliente 
					AND t1.CodEmpresa = t2.CodEmpresa
			inner join vstgF3ClientesContratoAct as t3
				on t1.CodCliente=t3.CodCliente 
			inner join #Tabla1 as t4
				on t3.NumContrato=t4.NumContrato
		where t1.CodTipoCliente not in ('13','23','26','31') -- 07/11/2017

	-- Recuperar datos y aplicar las sustituciones
	INSERT INTO sym_iReportesLAdjuntos
		(codEmpresa, nomIPad, codReporte, adjunto, rutaAdjunto, comentario, numReferencia, fechaUltModifAdjunto, flaDescargado, flaModificado)
	SELECT  t1.CodEmpresa
			, 'Central' nomIPad
			, (t1.CodCliente * 100 + 7) codReporte
			, 'C' + rtrim(convert(char,t1.NumContrato)) + '.PDF' adjunto
			,'' rutaAdjunto
			, 'Contrato Firmado' comentario
			, 'C' + rtrim(convert(char,t1.NumContrato)) numReferencia
			, t1.ModifyDate fechaUltModifAdjunto
			, 1 flaDescargado
			, 1 flaModificado
	FROM    #tmp_Tabla2 AS t1 
		inner join sym_iReportes as t2 -- Solo los que generan reporte
			on t1.CodEmpresa=t2.codEmpresa
				and (t1.CodCliente * 100 + 7) =t2.codReporte
	
	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************

END
GO
