SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ===========================================================
-- Author:		Ramon Villanueva
-- Create date: 30/09/2015
-- Description:	Hashtags de Filtro
-- Crear filtros de busqueda de clientes y meterlos en el campo datFaxCli
--	#ccc clientes con contrato
--	#csc clientes sin contrato
--	#cpo clientes potenciales
--   #cre clientes reales -------------------------- 26/04/2017
--	#ccd clientes con deuda
--	#csd clientes sin deuda
--	#ccv clientes con venta el mes
--	#csv clientes sin venta el mes
--  #ccs cliente cumple contrato al 80% o mas
--  #ccn cliente no cumple
--  #cv0 Visitados esta semana
--  #cv1 Visitados este mes (pero no esta semana)
--  #cv2 Visitados el mes pasado o anteriores
--  #cv3 NO Visitados
--  #c+  Clientes visitados por mas de un agente
-- ===========================================================
-- Modificacion 26/04/2017
--	   Meto el filtro en las observaciones
-- Modificacion 22/06/2018
--	   Por un problema de Inase en la actualizacion
-- Los hashtags tienen que ir separados por blancos
-- Modificacion 08/04/2020
--     Los filtros ya no los meto en observaciones de cliente
--     Los meto en la tabla de Marcas
-- Modificacion 15/04/2020
--     Añado los clientes CON o SIN CoffeeTester
-- ===========================================================
CREATE PROCEDURE [dbo].[uspClteFiltros]  AS
BEGIN

	SET NOCOUNT ON;	

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	-- Recuperar valores de filtro datos de cliente
	    SELECT    
		 t1.CodEmpresa
	    , t1.CodCliente
	    , IIF(t1.CodGrupoClientes = 'Z012', 1, IIF(t1.Baja = 'N', 2, 3)) AS CliPot-- Cliente Potencial (1=Potencial, 2=Normal, 3=Baja)
	    , CASE
			WHEN t1.CodGrupoClientes <> 'Z012'
			THEN IIF(t1.ContratoAct = 1, 2, 3)
			ELSE 1
		 END AS                                                            ContratoAct-- Cliente con contrato (1=Potencial,2=Con contrato,3=Sin contrato)
	    , CASE
			WHEN t1.CodGrupoClientes <> 'Z012'
			THEN IIF(t2.DeudaTotal > 0, 2, 3)
			ELSE 1
		 END AS                                                            CliDeuda	-- Cliente con deuda (1=Potencial,2=Con deuda,3=Sin deuda)
	    , CASE
			WHEN t1.CodGrupoClientes <> 'Z012'
			THEN IIF(
    (
	   SELECT 
			COUNT(*)
	   FROM    stgF2FacturasVentasSAP AS tt1
			 INNER JOIN dim_Fecha AS tt2
			   ON tt1.FechaFactura = tt2.Fecha_key
	   WHERE  tt1.CodEmpresa = t1.CodEmpresa
			AND tt1.CodCliente = t1.CodCliente
			AND tt2.Año = DATEPART(year, GETDATE())
			AND tt2.Mes = DATEPART(month, GETDATE())
    ) > 0, 2, 3)
			ELSE 1 -- Cliente con factura (1=Potencial,2=Con factura,3=Sin factura)
		 END AS                                                            CliFact
	    , IIF(t1.ContratoAct = 1, IIF(PorcCump >= 80, 1, 2), 3) AS          CliCumple -- Cumplimiento (1=Cumple, 2=No cumple, 3=Sin contrato)
	    , COALESCE(CASE
				    WHEN t5.Año = t6.Año
					    AND t5.Semana = t6.Semana
				    THEN 1 -- Esta semana
				    WHEN t5.Año = t6.Año
					    AND t5.Mes = t6.Mes
				    THEN 2 -- Esta mes
				    WHEN t5.Año = t6.Año
					    AND t5.Mes < t6.Mes
					    OR t5.Año < t6.Año
				    THEN 3 -- Mes pasado
				END, 4) AS                                               FechaVta
	    , IIF(COALESCE(t7.CodCliente, 0) > 0, 1, 2) AS                      CliVisMas -- Visitado por mas de un agente (1=Visitado, 2=No)
	    , IIF(COALESCE(t8.CodCliente, 0) > 0, 1, 2) AS                      CliCoffeTester -- Cliente con Coffee Tester Realizado (1=Si, 2=No)
		 INTO  #tmp_Tabla
    FROM stgF3Clientes AS t1
	    LEFT OUTER JOIN stgF3ResumenDeudaClientes AS t2
		 ON t1.CodEmpresa = t2.CodEmpresa
		    AND t1.CodCliente = t2.CodCliente
	    LEFT OUTER JOIN stgF3CumplimientoContrato AS t3
		 ON t1.CodEmpresa = t3.Codempresa
		    AND t1.CodCliente = t3.CodEstablecimiento
	    LEFT OUTER JOIN vUltimaVisitaReportada AS t4
		 ON t1.CodEmpresa = t4.Codempresa
		    AND t1.CodCliente = t4.CodCliente
	    LEFT OUTER JOIN dim_Fecha AS t5
		 ON format(t4.FechaUltVisita, 'yyyyMMdd', 'es-ES') = t5.Fecha_key
	    LEFT OUTER JOIN dim_Fecha AS t6
		 ON format(GETDATE(), 'yyyyMMdd', 'es-ES') = t6.Fecha_key
	    LEFT OUTER JOIN
    (
	   SELECT 
			codcliente
	   FROM   stgF3AnalisisVisitas
	   GROUP BY 
			  CodCliente
	   HAVING COUNT(DISTINCT codagente) > 1
    ) AS t7
		 ON t1.CodCliente = t7.CodCliente
		 LEFT OUTER JOIN
    (
	   SELECT DISTINCT 
		 codEmpresa
	    , codCliente
        FROM   sym_iReportes 
	   WHERE  codPlantillaReportes IN(116, 117)
    ) AS t8  -- Clientes con Coffee Tester realizado
		 ON t1.CodEmpresa=t8.CodEmpresa
			 AND t1.CodCliente = t8.CodCliente

    -- Insertar valores en tabla de ClientesMarcas ---- 08/04/2020
	   DELETE FROM sym_iClientesMarcas
	   DELETE FROM sym_iMarcas
	   	   WHERE codTipo='C'

	   INSERT INTO sym_iMarcas
	   SELECT CodMarca
			 ,DesMarca
			 ,codTipo
	   FROM par.HashClientes
	   WHERE codTipo='C'

	   ;WITH Filtros AS
	   (
	   SELECT *
	   FROM #tmp_Tabla
	   UNPIVOT( Valor FOR Variable IN(CliPot, ContratoAct, CliDeuda, CliFact, CliCumple, FechaVta, CliVisMas, CliCoffeTester))
	   AS tabla
	   )
	   INSERT INTO sym_iClientesMarcas
	   SELECT DISTINCT t1.CodEmpresa
		  , t1.CodCliente
		  , t2.CodMarca
	   FROM Filtros t1
	   INNER JOIN par.HashClientes t2
	   on t1.Variable=t2.Variable
		  and t1.Valor=t2.Valor
	   WHERE t2.CodMarca IS NOT NULL

	
	-- Actualizar tabla iClientes [obsClienteNoEdi] --- Lo quito 08/04/2020
	--	UPDATE sym_iClientes
	--	SET obsClienteNoEdi = 'Filtro: ' +
	--					  left(
	--						coalesce(	
	--								choose(CliPot, ' #cpo',' #cre','') -------------------------- 26/04/2017
	--								+ choose(ContratoAct,'', ' #ccc', ' #csc')
	--								+ choose(CliCumple,' #ccs',' #ccn', '')
	--								+ choose(CliDeuda,'',' #ccd',' #csd')
	--								+ choose(CliFact,'',' #ccv',' #csv')
	--								+ choose(FechaVta,' #cv0',' #cv1', ' #cv2', ' #cv3')
	--								+ choose(CliVisMas, ' #c+', '')
	--								,''),20)
	--FROM sym_iClientes 
	--	 INNER JOIN #tmp_Tabla AS t2 
	--		ON	sym_iClientes.codEmpresa = t2.CodEmpresa 
	--			AND sym_iClientes.codCliente = t2.CodCliente
	--where sym_iClientes.codCliente not like 'ipad%'


	-- Actualizar tabla [iReportes] para reportes de visita
	update sym_iReportes  -- Elimino los filtros previos
	   set desreporte=left(desreporte,PATINDEX('%- Filtro:%',desreporte)-1)
	   where desreporte like '%- Filtro:%'

		UPDATE sym_iReportes -- Meto los filtros
		SET desReporte = left(rtrim(desReporte)
						+ ' - Filtro: '
						+	coalesce(	
									choose(CliPot, ' #cpo',' #cre','') -------------------------- 26/04/2017
									+ choose(ContratoAct,'', ' #ccc', ' #csc')
									+ choose(CliCumple,' #ccs',' #ccn', '')
									+ choose(CliDeuda,'',' #ccd',' #csd')
									+ choose(CliFact,'',' #ccv',' #csv')
									+ choose(FechaVta,' #cv0',' #cv1', ' #cv2', ' #cv3')
									+ choose(CliVisMas, ' #c+', '')
									,''),500)
	FROM sym_iReportes
		 INNER JOIN #tmp_Tabla AS t2 
			ON	sym_iReportes.codEmpresa = t2.CodEmpresa 
				AND sym_iReportes.codCliente = t2.CodCliente
	where sym_iReportes.codCliente not like 'ipad%' 
		and sym_iReportes.nomIPad not in('Central', 'ipad#')
		and sym_iReportes.codPlantillaReportes between 111 and 115 -- Reportes de visita

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************

END



GO
