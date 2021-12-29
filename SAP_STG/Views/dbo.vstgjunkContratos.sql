SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date:	15/03/16
-- Description:	Vista de Junk para contratos
-- ==================================================================
CREATE VIEW [dbo].[vstgjunkContratos] as
SELECT distinct
	 iif(t1.JURID='','0',JURID)		CodJuridico
	,iif(t1.JURID_TXT='','N/A',UPPER([JURID_TXT]))	Juridico
     ,t1.STATUS					CodStatusContrato
    , choose(t1.STATUS
			 ,'PENDIENTE'
			 ,'ANALISIS OK'
			 ,'PENDIENTE CONFIRMACION PROPUESTA'
			 ,'CONFIRMACION DELEGACION' 
			 ,'APROBADO'
			 ,'CONFIRMACION INSTALACION'
			 ,'FIRMA VERIFICADA'
			 ,'JURIDICO'
			 ,'RECHAZADO'
			 ,'N/A'
			 )					StatusContrato
      ,iif(t1.ZBAJA='BAJA','BAJA','ACTIVO') Estado
     ,iif(t1.CADUCADO='X','CADUCADO','VIGENTE') EstVigencia
	, IIF(t2.NumDoc IS NULL, 0, 1) AS                                                  Bit_ContratoAdjunto
	, IIF(t2.NumDoc IS NULL, 'NO HAY CONTRATO ESCANEADO', 'HAY CONTRATO ESCANEADO') AS ContratoAdjunto
FROM   dbo.stgF2CumpInversiones t1
	  LEFT OUTER JOIN stgIna_Archivos AS t2
	    ON CONVERT( INT, t1.VBELN) = t2.NumDoc
		  AND t2.Tipo = 'Contrato'
GO
