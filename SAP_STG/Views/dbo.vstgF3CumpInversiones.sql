SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date:	16/03/16
-- Description:	Vista de seguimiento de contratos
-- ==================================================================
CREATE VIEW [dbo].[vstgF3CumpInversiones] AS
	SELECT
		  t1.FechaProceso_key
		, t1.CodEmpresa
		, CONVERT( INT, t1.VBELN) AS                                                 NumContrato
		, t1.FECHA_INI AS                                                            FechaInicio_key
		, IIF(t1.JURID = '', '0', JURID) AS                                            CodJuridico
		, t1.FECHA_INI_OR AS                                                         FechaInicioOriginal_key
		, t1.FECHA_APROB AS                                                          FechaAprobacion_key
		, t1.F_APROB30 AS                                                            FechaAprobacion30_key
		, t1.FECHA_FIN AS                                                            FechaFin_key
		, CONVERT( INT, t1.MESES) AS                                                 MesesCumplimientoInt
		, t1.MESES_D AS                                                              MesesCumplimientoDec
		, CONVERT( INT, t1.MESESP) AS                                                MesesContrato
		, t1.STATUS AS                                                               CodStatusContrato
		, t1.VKBUR AS                                                                CodDelegacion
		, CONVERT( INT, t1.KUNNR) AS                                                 CodRespPago
		, t1.RESP_ALTA AS                                                            CodRespAlta
		, t1.KILOS AS                                                                KilosMes
		, t1.PRECIO AS                                                               PrecioPropuesto
		, t1.KILOSM AS                                                               MediaKilosMes
		, t1.PRECIOM AS                                                              PrecioMedio
		, t1.PRIM_VENTA AS                                                           FechaPrimVenta_key
		, t1.ULT_VENTA AS                                                            FechaUltVenta_key
		, t1.DESV_KG AS                                                              DesvPKilos
		, t1.DESV_PREC AS                                                            DesvPPrecio
		, t1.PRVENTA AS                                                              PrecioPropuestoSAP
		, t1.FACT_EST AS                                                             FactEstimada
		, t1.FACT_REAL AS                                                            FactReal
		, t1.INVERSION AS                                                            Inversion
		, t1.RATIO_I AS                                                              RatioInicial
		, t1.RATIO_R AS                                                              RatioReal
		, t1.PMR AS                                                                  PMR
		, IIF(t1.ZBAJA = 'BAJA', 'BAJA', 'ACTIVO') AS                                Estado
		, t1.AMORTIZACION AS                                                         ImpAmortizado
		, IIF(t1.CADUCADO = 'X', 'CADUCADO', 'VIGENTE') AS                           EstVigencia
		, t1.KGTOT AS                                                                KilosPeriodo
		, t1.KGPEND AS                                                               KilosPtes
		, t1.PORC_CUMP AS                                                            PorcCump
		, IIF(t2.NumDoc IS NULL, 0, CONVERT(     VARCHAR(8), t2.ModifyDate, 112)) AS FechaContratoAdjunto_key
		, IIF(t2.NumDoc IS NULL, 0, 1) AS                                            Bit_ContratoAdjunto
	FROM   SAP_STG.dbo.stgF2CumpInversiones AS t1
		  LEFT OUTER JOIN stgIna_Archivos AS t2
		    ON CONVERT( INT, t1.VBELN) = t2.NumDoc
			  AND t2.Tipo = 'Contrato'
GO
