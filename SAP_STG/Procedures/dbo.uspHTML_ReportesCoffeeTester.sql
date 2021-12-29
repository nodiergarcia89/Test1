SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 22/04/2020
-- Description: Transformar Reportes 116 y 117 a HTML
-- =============================================
CREATE   PROCEDURE [dbo].[uspHTML_ReportesCoffeeTester] 
AS
BEGIN
    declare @Proceso int 

    select @Proceso=0 -- 1 desde la copia 0 normal

    	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @html NVARCHAR(MAX)
 
    -- Plantilla HTML

     SELECT @html='<html><style>' +
	   '.tab td {border: 1px solid #dddddd;font-family: verdana;padding:6px;font-size:8pt;border-collapse: collapse;} ' +
	   '.tab th {border: 1px solid #000000;font-family: verdana;font-size:8pt;color: #FFFFFF;text-align: center;background-color: #D81E05;padding: 8px}' +
	   '.tab tr:nth-child(even) {background-color: #dddddd}' +
	   '.tab {width:100%}' +
	   '</style>' +
	   '<table class="tab" cellpadding=1 cellspacing=0 border=1>' +
	   '<TR><TH colspan="2"><B>Coffee Tester Realizado</B></TH></TR>' +
	   '<TR><TD><B><span style="color:#B8312F;">Cliente:</B></TD>' +
	   '<TD><Cliente> (<Poblacion>)</TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Fecha:</b></TD>' +
	   '<TD><Fecha></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Agente:</b></TD>' +
	   '<TD><Agente></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Observaciones:</b></TD>' +
	   '<TD><Observaciones></TD></TR>' +
	   '</table><br>En el PDF adjunto esta el Coffee Tester realizado'

    -- Insertar Filas Reportes
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
    LEFT JOIN iReportesLin_Modificados AS s
	   ON   t.codEmpresa	  =s.codEmpresa
	    AND t.nomIPad		  =s.nomIPad
	    AND t.codReporte	  =s.codReporte
	    AND t.linReportesLin	  =s.linReportesLin
    WHERE  t.linReportesLin <> 99 -- La 99 la generaré
        AND t.codPlantillaReportes IN('116','117')
	   AND s.codEmpresa IS NULL

    -- Borrar lineas insertadas
    DELETE sym_iReportesLin
    FROM sym_iReportesLin t1
	    INNER JOIN iReportesLin_Modificados t2
		 ON t1.CodEmpresa = t2.CodEmpresa
		    AND t1.nomIPad = t2.nomIPad
		    AND t1.codReporte = t2.codReporte
    WHERE t1.codPlantillaReportes IN('116','117')
	   AND t2.Procesado=@Proceso

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
		  AND ir.codPlantillaReportes IN('116','117')
	   )
	   , PivotTable AS
	   (
	   select codEmpresa,nomIPad,codReporte,codPlantillaReportes,99 linReportesLin,
			   [001],[002],[003],[004],[061]
		   FROM
		   (select L.codEmpresa,L.nomIPad,L.codReporte,L.codPlantillaReportes,L.linReportesLin, L.datRespuesta 
		   from Tabla L) as pvt 
		   pivot (MAX(datRespuesta) FOR linReportesLin IN	
			   ([001],[002],[003],[004],[061])
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
				,'<Agente>',t4.nomAgente)
				,'<Poblacion>',t5.datPoblacionDirCli)
				,'<Cliente>',CONCAT(t3.CodCliente,'.-',t3.nomCliente)) 
				,'<Fecha>',FORMAT(t2.fecReporte,'dd/MM/yyyy HH:mm'))
				,'<Observaciones>',UPPER([061])) datRespuesta
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
    AND t1.CodPlantillaReportes IN('116','117')

END
GO
