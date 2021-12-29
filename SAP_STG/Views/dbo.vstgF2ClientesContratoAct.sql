SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 04/03/2015
-- Description:	Clientes con contrato activo hoy
-- Modificacion 24/10/2016
--  Controlo los kilos pdtes de amortizar desde el cumplimiento
-- Modificacion 04/12/2018
--  Cambio KgsPteAmort a condicion and
-- ========================================================
CREATE view [dbo].[vstgF2ClientesContratoAct] as
select distinct convert(int,t2.KUNNR) CodCliente
				, convert(int, t1.VBELN) NumContrato
from ZCAH001 t1 -- Establecimientos
	left outer join ZCAH003 t2
		on t1.MANDT collate DATABASE_DEFAULT=t2.MANDT
			and t1.VBELN collate DATABASE_DEFAULT=t2.VBELN
    LEFT OUTER JOIN stgF3CumplimientoContrato t3
	   on t2.CodEmpresa=t3.CodEmpresa
		  and t2.KUNNR=t3.CodEstablecimiento COLLATE DATABASE_DEFAULT
where convert(date,t1.FECHA_FIN)>getdate()
and t1.STATUS in('5','6','7') and t1.LOEKZ<>'X' 
--or t3.KgsPteAmort>0   -- 04/12/2018
AND t3.KgsPteAmort>0    -- 04/12/2018
UNION
select distinct convert(int,t1.KUNNR) CodCliente
				, convert(int, t1.VBELN) NumContrato
from ZCAH001 t1 -- Pagadores
    LEFT OUTER JOIN stgF3CumplimientoContrato t3
	   on t1.CodEmpresa=t3.CodEmpresa
		  and t1.KUNNR=t3.CodEstablecimiento COLLATE DATABASE_DEFAULT
where convert(date,t1.FECHA_FIN)>getdate()
and t1.STATUS in('5','6','7') and t1.LOEKZ<>'X'
--or t3.KgsPteAmort>0   -- 04/12/2018
AND t3.KgsPteAmort>0    -- 04/12/2018

GO
