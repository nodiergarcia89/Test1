SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/* **********************************************************************
Autor:  Ramon Villanueva
Fecha:	30/11/2020 11:25
Descripcion: Con este store procedure arreglo los registros para que se
vuelvan a generar los PDF de coffee tester que salieron vacios.
*************************************************************************
Change History
DATE		  CHANGED BY	   CHANGE CODE	    DESCRIPTION
-------------------------------------------------------------------------
*/

CREATE   PROCEDURE [dbo].[uspArreglarPDF_CoffeeTester]
AS
    BEGIN
	   DECLARE 
			@transtate BIT
	   IF @@TRANCOUNT = 0
		  BEGIN
			 SET @transtate=1
			 BEGIN TRANSACTION transtate
		  END
	   BEGIN TRY

		  -- Deshabilitar el JOB
		  UPDATE MSDB.dbo.sysjobs
		    SET  
			   Enabled=0
		  WHERE  
			   Name = 'Lanzar PDF CoffeeTester'

		  -- Esperar 5 minutos
		  WAITFOR DELAY '00:05'

		  -- Insertar los registros en iReportesLin
		  INSERT INTO sym_iReportesLin
			    (
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
			    )
		  SELECT 
			    t1.codEmpresa
			  , t1.nomIPad
			  , t1.codReporte
			  , t1.codPlantillaReportes
			  , t2.linReportesLin
			  , t2.desCampo
			  , t2.codTipoCampo
			  , t2.desLista
			  , t2.flaObligado
			  , t2.ordReportesLin
			  , t2.datRespuesta
		  FROM   SAP_STG.dbo.iReportesTriggerLog AS t1
			    INNER JOIN dbo.iReportesLin_Modificados AS t2
				 ON t1.CodEmpresa = t2.CodEmpresa
				    AND t1.nomIPad = t2.nomIPad
				    AND t1.codReporte = t2.codReporte
				    AND t2.linReportesLin <> 99
		  WHERE  t1.codPlantillareportes = 117
			    AND t1.[001] IS NULL
			    AND t1.[099] IS NOT NULL

		  -- Borrarlos del Log
		  DELETE FROM SAP_STG.dbo.iReportesTriggerLog
		  WHERE       
			   codPlantillareportes = 117
			   AND [001] IS NULL
			   AND [099] IS NOT NULL

		  -- Llamar al proceso sin notificar
		  EXEC uspIReportes117 
			  0

		  -- Habilitar el JOB
		  UPDATE MSDB.dbo.sysjobs
		    SET  
			   Enabled=1
		  WHERE  
			   Name = 'Lanzar PDF CoffeeTester'
		  IF @transtate = 1
			AND XACT_STATE() = 1
			 COMMIT TRANSACTION transtate
	   END TRY
	   BEGIN CATCH
		  DECLARE 
			    @Error_Message VARCHAR(5000)
		  DECLARE 
			    @Error_Severity INT
		  DECLARE 
			    @Error_State INT
		  SELECT 
			    @Error_Message=ERROR_MESSAGE()
		  SELECT 
			    @Error_Severity=ERROR_SEVERITY()
		  SELECT 
			    @Error_State=ERROR_STATE()
		  IF @transtate = 1
			AND XACT_STATE() <> 0
			 ROLLBACK TRANSACTION
		  RAISERROR(@Error_Message, @Error_Severity, @Error_State)
	   END CATCH
    END
GO
