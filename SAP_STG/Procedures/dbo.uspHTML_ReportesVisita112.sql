SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 21/04/2020
-- Description: Transformar Reportes 112 a HTML
-- =============================================
CREATE   PROCEDURE [dbo].[uspHTML_ReportesVisita112] 
AS
BEGIN
    declare @CodPlantillaReportes nvarchar(20)
    declare @Proceso int 
    declare @TipoProceso int

    select @Proceso=0	   -- 1 desde la copia 0 normal
    select @TipoProceso=1   -- 1 desde Central con lo que borro en _Modificados

    	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @html NVARCHAR(MAX)
 
    -- Plantilla HTML
    SELECT @CodPlantillaReportes=112

     SELECT @html='<html><style>' +
	   '.tab td {border: 1px solid #dddddd;font-family: verdana;padding:6px;font-size:8pt;border-collapse: collapse;} ' +
	   '.tab th {border: 1px solid #000000;font-family: verdana;font-size:8pt;color: #FFFFFF;text-align: center;background-color: #D81E05;padding: 8px}' +
	   '.tab tr:nth-child(even) {background-color: #dddddd}' +
	   '.tab {width:100%}' +
	   '</style>' +
	   '<table class="tab" cellpadding=1 cellspacing=0 border=1>' +
	   '<TR><TH colspan="2"><B>Resumen Semanal de Visitas</B></TH></TR>' +
	   '<TR><TD><B><span style="color:#B8312F;">Agente:</B></TD>' +
	   '<TD><Agente></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Semana:</b></TD>' +
	   '<TD><Semana></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Resumen:</b></TD>' +
	   '<TD><Resumen></TD></TR>' +
	   '</table><br>En el PDF adjunto esta el Resumen'

    -- Borrar si se genera en central
    IF @TipoProceso=1
     DELETE iReportesLin_Modificados
        WHERE codPlantillaReportes=@CodPlantillaReportes

    -- Insertar Filas Reportes
    INSERT INTO iReportesLin_Modificados
    SELECT 
		 codEmpresa
	    , nomIPad
	    , codReporte
	    , codPlantillaReportes
	    , linReportesLin
	    , desCampo
	    , codTipoCampo
	    , desLista
	    , flaObligado
	    , ordReportesLin
	    , datRespuesta
	    , 0 AS         Procesado
	    , GETDATE() AS FecProceso
    FROM   sym_iReportesLin AS t
    WHERE  linReportesLin <> 99 -- La 99 la generaré
        AND t.codPlantillaReportes=@CodPlantillaReportes

    -- Borrar lineas insertadas
    DELETE sym_iReportesLin
    FROM sym_iReportesLin t1
	    INNER JOIN iReportesLin_Modificados t2
		 ON t1.CodEmpresa = t2.CodEmpresa
		    AND t1.nomIPad = t2.nomIPad
		    AND t1.codReporte = t2.codReporte
    WHERE t2.Procesado=@Proceso	-- Borro tambien la 99
	   AND t1.codPlantillaReportes=@CodPlantillaReportes

    -- Componer reporte HTML en linea 99
    ;WITH Tabla AS
	   (
	   SELECT 
			ir.codEmpresa
		   , ir.nomIPad
		   , ir.codReporte
		   , ir.fecReporte
		   , ir.desReporte
		   , ir.codPlantillaReportes
		   , ir.codCliente
		   , ir.codAgente
		   , ir.codTipoPlantilla
		   , irl.linReportesLin
		   , irl.desCampo
		   , irl.codTipoCampo
		   , irl.flaObligado
		   , irl.datRespuesta
	   FROM   sym_iReportes AS ir
			INNER JOIN iReportesLin_Modificados AS irl
			  ON ir.codEmpresa = irl.codEmpresa
				AND ir.nomIPad = irl.nomIPad
				AND ir.codReporte = irl.codReporte
	   WHERE  irl.Procesado=@Proceso
		  AND ir.codPlantillaReportes=@CodPlantillaReportes
	   )
	   , PivotTable AS
	   (
	   select codEmpresa,nomIPad,codReporte,codPlantillaReportes,99 linReportesLin,
			   [001],[002],[003],[004]
		   FROM
		   (select L.codEmpresa,L.nomIPad,L.codReporte,L.codPlantillaReportes,L.linReportesLin, L.datRespuesta 
		   from Tabla L) as pvt 
		   pivot (MAX(datRespuesta) FOR linReportesLin IN	
			   ([001],[002],[003],[004])
			   ) as C
	   )

	   -- Insertar registros
	   INSERT INTO sym_iReportesLin
	   SELECT   t1.CodEmpresa
			 , t1.nomIPad
			 , t1.CodReporte
			 , t1.codPlantillaReportes
			 , t1.linReportesLin
			 , '' desCampo
			 , 'H' codTipoCampo
			 , '' desLista
			 , 0 flaObligado
			 , 0 ordReportesLin
			 , REPLACE(REPLACE(REPLACE(@html
				,'<Agente>',COALESCE(TRIM([001]),''))
				,'<Semana>',COALESCE(TRIM([002]),''))
				,'<Resumen>',CONCAT(TRIM([003]),' visitas a ',TRIM([004]),' clientes')) datRespuesta
	   FROM PivotTable t1
	   INNER JOIN sym_iPlantillaReportes t1a
		  on t1.codEmpresa=t1a.codEmpresa
			 and t1.codPlantillaReportes=t1a.codPlantillaReportes
	   INNER JOIN sym_iReportes t2
		  on t1.codEmpresa=t2.codEmpresa
			 and t1.nomIPad=t2.nomIPad
			 and t1.codReporte=t2.codReporte

    -- Marcar Registros como procesados
    UPDATE iReportesLin_Modificados
    SET Procesado=1
	   , FecProceso=GETDATE()
    FROM iReportesLin_Modificados t1
    WHERE Procesado=0
    AND t1.CodPlantillaReportes=@CodPlantillaReportes

END
GO
