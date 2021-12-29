SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	 Ramon Villanueva
-- Create date: 22/04/2020
-- Description: Transformar Reportes 107 a HTML
-- =============================================
CREATE     PROCEDURE [dbo].[uspHTML_ReportesContrato107] 
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
    SELECT @CodPlantillaReportes=107

     SELECT @html='<html><style>' +
	   '.tab td {border: 1px solid #dddddd;font-family: verdana;padding:6px;font-size:8pt;border-collapse: collapse;} ' +
	   '.tab th {border: 1px solid #000000;font-family: verdana;font-size:8pt;color: #FFFFFF;text-align: center;background-color: #D81E05;padding: 8px}' +
	   '.tab tr:nth-child(even) {background-color: #dddddd}' +
	   '.tab {width:100%}' +
	   '</style>' +
	   '<table class="tab" cellpadding=1 cellspacing=0 border=1>' +
	   '<TR><TH colspan="2"><B>Detalle del Contrato</B></TH></TR>' +
	   '<TR><TD><B><span style="color:#B8312F;">Cliente:</B></TD>' +
	   '<TD><Cliente></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Contrato:</b></TD>' +
	   '<TD><Contrato></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Duracion:</b></TD>' +
	   '<TD><Duracion></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Kilos:</b></TD>' +
	   '<TD><Kilos></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Maquinaria:</b></TD>' +
	   '<TD><Maquinaria></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Valor de la Maquinaria:</b></TD>' +
	   '<TD><ValorMaq></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Rappel Anticipado:</b></TD>' +
	   '<TD><Rappel></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Total Inversion:</b></TD>' +
	   '<TD><TotalV></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Kgs. pendientes amortizar:</b></TD>' +
	   '<TD><KgsPdtes></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">€ Amortizados:</b></TD>' +
	   '<TD><ImpAmor></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">€ Pte Amortizar:</b></TD>' +
	   '<TD><ImpPdte></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Indemnizacion:</b></TD>' +
	   '<TD><Indemnizacion></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Indemnizacion por Kg. (rappel):</b></TD>' +
	   '<TD><IndRapp></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Indemnizacion por K. (material cedido):</b></TD>' +
	   '<TD><IndMat></TD></TR>' +
	   '<TR><TD><b><span style="color:#B8312F;">Aval:</b></TD>' +
	   '<TD><Aval></TD></TR>' +
	   '</table><br>En el PDF adjunto esta el contrato firmado si se ha escaneado'

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
			   [001],[002],[003],[004],[005],[006],[007],[008],[009],[010],[011],[012],[013],[014],[015],[016],[017],[018],[019],[020],[021],[022]
		   FROM
		   (select L.codEmpresa,L.nomIPad,L.codReporte,L.codPlantillaReportes,L.linReportesLin, L.datRespuesta 
		   from Tabla L) as pvt 
		   pivot (MAX(datRespuesta) FOR linReportesLin IN	
			   ([001],[002],[003],[004],[005],[006],[007],[008],[009],[010],[011],[012],[013],[014],[015],[016],[017],[018],[019],[020],[021],[022])
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
			 , REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@html
				,'<Contrato>',CONCAT([003],' (','<B>',[004],'</B>',')'))
				,'<Duracion>', [005] + ' - ' + [006] + '        ' + [007])
				,'<Kilos>',CONCAT([008],' (',[009],'/Periodo)'))
				,'<Maquinaria>',[010])
				,'<Cliente>',CONCAT([001],'.-',[002]))
				,'<ValorMaq>',[011])
				,'<Rappel>',[012])
				,'<TotalInv>',[013])
				,'<KgsPdtes>',[014])
				,'<ImpAmor>',[015])
				,'<ImpPdte>',[016])
				,'<Indemnizacion>',[017])
				,'<IndRapp>',[018])
				,'<IndMat>',[019])
				,'<Aval>',IIF([020]='Sin Aval','',CONCAT([020],' Vencimiento: ',[021],' (',[022],' años)'))
				) datRespuesta
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
