SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 21/04/2020
-- Description: Transformar Reportes 111 a HTML
-- =============================================
CREATE     PROCEDURE [dbo].[uspHTML_ReportesVisita111] 
AS
BEGIN
    declare @CodPlantillaReportes nvarchar(20)

    	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @html NVARCHAR(MAX)
 
    -- Plantilla HTML
    SELECT @CodPlantillaReportes=111

     SELECT @html='<html><style>' +
	   '.tab td {border: 1px solid #dddddd;font-family: verdana;padding:6px;font-size:8pt;border-collapse: collapse;} ' +
	   '.tab th {border: 1px solid #000000;font-family: verdana;font-size:8pt;color: #FFFFFF;text-align: center;background-color: #D81E05;padding: 8px}' +
	   '.tab tr:nth-child(even) {background-color: #dddddd}' +
	   '.tab {width:100%}' +
	   '</style>' +
	   '<table class="tab" cellpadding=1 cellspacing=0 border=1>' +
	   '<TR><TH colspan="2"><B>Planificacion de Visita</B></TH></TR>' +
	   '<TR><TD><B><span style="color:#B8312F;">Cliente:</B></TD>' +
	   '<TD><Cliente> (<Poblacion>)</TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Fecha Visita Planificada:</b></TD>' +
	   '<TD><FechaVisita> (<Vendedor>)</TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Objetivos de la Visita:</b></TD>' +
	   '<TD><ComentarioVisita></TD></TR>' 

    -- Insertar Filas Reporte
	INSERT INTO iReportesLin_Modificados
	   SELECT 
			t.codEmpresa
		   , t.nomIPad
		   , t.codReporte
		   , t.codPlantillaReportes
		   , t.linReportesLin
		   , t.desCampo
		   , t.codTipoCampo
		   , t.desLista
		   , t.flaObligado
		   , t.ordReportesLin
		   , t.datRespuesta
		   , 0 AS         Procesado
		   , GETDATE() AS FecProceso
	   FROM   sym_iReportesLin AS t
	   LEFT JOIN iReportesLin_Modificados s
	   ON t.codEmpresa=s.codEmpresa
	   AND t.nomIPad=s.nomIPad
	   AND t.codReporte=s.codReporte
	   AND t.linReportesLin=s.linReportesLin
	   WHERE  t.linReportesLin <> 99 -- La 99 la generaré
		  AND t.codPlantillaReportes=@CodPlantillaReportes
		  AND s.codEmpresa IS NULL --- Que no existan ya

    -- Borrar lineas insertadas
    DELETE sym_iReportesLin
    FROM sym_iReportesLin t1
	    INNER JOIN iReportesLin_Modificados t2
		 ON t1.CodEmpresa = t2.CodEmpresa
		    AND t1.nomIPad = t2.nomIPad
		    AND t1.codReporte = t2.codReporte
    WHERE t2.Procesado=0		-- Borro tambien la 99
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
	   WHERE  irl.Procesado=0
		  AND ir.codPlantillaReportes=@CodPlantillaReportes
	   )
	   , PivotTable AS
	   (
	   select codEmpresa,nomIPad,codReporte,codPlantillaReportes,99 linReportesLin,
			   [001],[002]
		   FROM
		   (select L.codEmpresa,L.nomIPad,L.codReporte,L.codPlantillaReportes,L.linReportesLin, L.datRespuesta 
		   from Tabla L) as pvt 
		   pivot (MAX(datRespuesta) FOR linReportesLin IN	
			   ([001],[002])
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
			 , REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@html
				,'<ComentarioVisita>',COALESCE(UPPER([001]),''))
				,'<FechaVisita>',COALESCE([002],''))
				,'<Vendedor>',t4.nomAgente)
				,'<Poblacion>',t5.datPoblacionDirCli)
				,'<Cliente>',CONCAT(t3.CodCliente,'.-',t3.nomCliente)) datRespuesta
	   FROM PivotTable t1
	   INNER JOIN sym_iPlantillaReportes t1a
		  on t1.codEmpresa=t1a.codEmpresa
			 and t1.codPlantillaReportes=t1a.codPlantillaReportes
	   INNER JOIN sym_iReportes t2
		  on t1.codEmpresa=t2.codEmpresa
			 and t1.nomIPad=t2.nomIPad
			 and t1.codReporte=t2.codReporte
	   INNER JOIN sym_iClientes t3
		  on t2.codEmpresa=t3.codEmpresa
			 and t2.codCliente=t3.codCliente
	   INNER JOIN sym_iAgentes t4
		  on t2.codEmpresa=t4.codEmpresa
			 and t2.codAgente=t4.CodAgente
	   INNER JOIN sym_iClientesLDir t5
		  on t2.codEmpresa=t5.codEmpresa
			 and t2.codCliente=t5.codCliente
			 and t5.linDirCli=1

    -- Marcar Registros como procesados
    UPDATE iReportesLin_Modificados
    SET Procesado=1
	   , FecProceso=GETDATE()
    FROM iReportesLin_Modificados t1
    WHERE Procesado=0
    AND t1.CodPlantillaReportes=@CodPlantillaReportes

END
GO
