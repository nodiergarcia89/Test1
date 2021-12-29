SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO




-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 29/06/2015
-- Description:	Ultimo contrato de cada cliente por fecha
-- Modificacion: 14/06/2016
--  06/09/2016 Contratos anulados
-- Modificacion: 24/01/2019
--  No tener en cuenta los Contratos anulados
-- ========================================================
CREATE view [dbo].[vstgF2UltimoContratoClte] as
WITH TodosContratos AS
(
SELECT	t1.MANDT		   -- PAGADORES
		    ,t1.KUNNR 
		    , t1.VBELN
		    , t1.IMPORTE
		    , t1.MESES
		    , t1.INDEMNIZ1 
		    , t1.INDEMNIZ2 
		    , t1.RAPPEL_SIN_AVAL 
		    , t1.IMPORTE_RAPPEL_A 
		    , t1.FECHA_RAPPEL 
		    , t1.DUR_AVAL_RAPPEL
		    , t1.FECHA_INI	FechaInicio_key    -- 14/06/2016
		    , t1.FECHA_FIN	FechaFin_key	    -- 14/06/2016
		    , t1.STATUS CodStatusContrato     -- 14/06/2016
		    , t1.LOEKZ CodAnulado		   -- 06/09/2016
		    , t1.MESES MesesDuracion		    -- 14/06/2016
		    , t1.FECHA_ANU FechaAnulacion_key -- 14/06/2016
		    , t1.VTWEG CodCanal			    -- 14/06/2016
		    , convert(int,t1.KUNNR) CodCliente-- 14/06/2016
		    , convert(int,t1.VBELN) NumContrato  -- 14/06/2016
		    , FECHA FechaAlta
	  FROM ZCAH001 t1
	    where t1.KUNNR<>''
		  AND t1.LOEKZ <>'X' -- 24/01/2019
    UNION  -- 24/01/2019
    SELECT	t1.MANDT	    -- ESTABLECIMIENTOS
		    ,t2.KUNNR collate DATABASE_DEFAULT
		    , t1.VBELN
		    , t1.IMPORTE
		    , t1.MESES
		    , t1.INDEMNIZ1 
		    , t1.INDEMNIZ2 
		    , t1.RAPPEL_SIN_AVAL 
		    , t1.IMPORTE_RAPPEL_A 
		    , t1.FECHA_RAPPEL 
		    , t1.DUR_AVAL_RAPPEL
		    , t1.FECHA_INI	FechaInicio_key    -- 14/06/2016
		    , t1.FECHA_FIN	FechaFin_key	    -- 14/06/2016
		    , t1.STATUS CodStatusContrato     -- 14/06/2016
		    , t1.LOEKZ CodAnulado		   -- 06/09/2016
		    , t1.MESES MesesDuracion		    -- 14/06/2016
		    , t1.FECHA_ANU FechaAnulacion_key -- 14/06/2016
		    , t1.VTWEG CodCanal			    -- 14/06/2016
		    , convert(int,t2.KUNNR) CodCliente-- 14/06/2016
		    , convert(int,t1.VBELN) NumContrato  -- 14/06/2016
		    , FECHA FechaAlta
	  FROM ZCAH001 t1
		    inner join ZCAH003 t2
			    on t1.MANDT collate DATABASE_DEFAULT=t2.MANDT
				    and t1.VBELN collate DATABASE_DEFAULT=t2.VBELN
	  where t2.KUNNR<>''
		  AND t1.LOEKZ <>'X' -- 24/01/2019
)
, UnContratoCliente As
(
SELECT *
    , row_number () over (partition by CodCanal, CodCliente  order by FechaAlta desc) AS RowNum
  FROM TodosContratos
)
SELECT *
FROM UnContratoCliente
WHERE RowNum=1
GO
