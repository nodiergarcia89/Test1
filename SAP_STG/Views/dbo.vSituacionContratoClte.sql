SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ===============================================================
-- Author:		Ramon Villanueva
-- Create date:	18/03/2016
-- Description:	Ultima situación contrato de cliente
-- Modificacion: 14/06/2016
-- ===============================================================
CREATE VIEW [dbo].[vSituacionContratoClte] as
SELECT  tt.CodCanal
	 , tt.CodCliente
	 , tt.NumContrato
	, tt.FechaInicio_key AS              FechaInicioContrato_key
	, tt.FechaFin_key AS                 FechaFinContrato_key
	, tt.MesesDuracion AS                DuracionContrato
	, tt.CodStatusContrato
	, case 
		  when tt.CodAnulado='X'
			 then 9 -- Anulado
		  when tt.FechaInicio_key <= format(getdate(),'yyyyMMdd')
			 and tt.FechaFin_key >= format(getdate(),'yyyyMMdd')
			 and tt.CodStatusContrato in('5','6','7') 
			 then 1 -- Activo
		  when tt.FechaInicio_key < format(getdate(),'yyyyMMdd')
			 and tt.FechaFin_key < format(getdate(),'yyyyMMdd')
			 then 2 -- Vencido
		  when tt.CodStatusContrato in('1','2','3','4') 
			 then 4
		  when tt.CodStatusContrato='Z' --14/06/2016
			 then 9 -- Anulado
		  else 0 -- N/A
	   end Bit_ContratoActivo
	, case 
		  when tt.CodAnulado='X'
			 then 'ANULADO' -- Anulado
		  when tt.FechaInicio_key <= format(getdate(),'yyyyMMdd')
			 and tt.FechaFin_key >= format(getdate(),'yyyyMMdd')
			 and tt.CodStatusContrato in('5','6','7') 
			 then 'ACTIVO'  -- Activo
		  when tt.FechaInicio_key < format(getdate(),'yyyyMMdd')
			 and tt.FechaFin_key < format(getdate(),'yyyyMMdd')
			 then 'VENCIDO' -- Vencido
		  when tt.CodStatusContrato in('1','2','3','4') 
			 then 'PENDIENTE APROBACION'
		  when tt.CodStatusContrato='Z' --14/06/2016
			 then 'ANULADO' -- Anulado
		  else 'N/A' -- N/A
	   end ContratoActivo
		  
FROM
vstgF2UltimoContratoClte as tt --14/06/2016
/* -- Modificacion: 14/06/2016
(
    SELECT -- Pagadores
		 fsc.Cliente_key
	    , fsc.FechaInicio_key
	    , fsc.FechaFin_key
	    , fsc.MesesDuracion
	    , djsc.Estado
	    , djsc.CodStatusContrato
	    , ROW_NUMBER() OVER(PARTITION BY fsc.Cliente_key ORDER BY fsc.FechaInicio_key DESC) AS RowNum
    FROM   dbo.fact_SeguimientoContratos AS fsc
		 INNER JOIN dbo.dim_junk_SegContratos AS djsc
		   ON fsc.CodJunkSegContratos_key = djsc.CodJunkSegContratos_key
    UNION 
    SELECT -- Establecimientos
		 bce.Cliente_key
	    , fsc.FechaInicio_key
	    , fsc.FechaFin_key
	    , fsc.MesesDuracion
	    , djsc.Estado
	    , djsc.CodStatusContrato
	    , ROW_NUMBER() OVER(PARTITION BY bce.Cliente_key ORDER BY fsc.FechaInicio_key DESC) AS RowNum
    FROM   dbo.fact_SeguimientoContratos AS fsc
		 INNER JOIN dbo.dim_junk_SegContratos AS djsc
		   ON fsc.CodJunkSegContratos_key = djsc.CodJunkSegContratos_key
	      INNER JOIN dbo.Bridge_ContratosEstabl bce	 
		   ON fsc.CodContrato_key=bce.CodContrato_key
) AS tt
WHERE tt.RowNum = 1
*/
GO
