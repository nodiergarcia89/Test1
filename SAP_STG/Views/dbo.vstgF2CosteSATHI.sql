SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- ====================================================
-- Author:		Ramon Villanueva
-- Create date: 17/11/2015
-- Description:	Condiciones de SAT Horeca Indirecta
-- ====================================================
CREATE view [dbo].[vstgF2CosteSATHI] as
select convert(int,t1.KUNNR) CodCliente
		,t2.KBETR ImpCondicion
		,t2.KONWA CodMonCondicion
		,t2.KPEIN PorCantCondicion
		,t2.KMEIN UMCondicion
from A831 t1
inner join KONP t2
	on t1.MANDT=t2.MANDT
		and t1.KNUMH=t2.KNUMH
where t1.KSCHL='Z215'
and dbo.ufPeriodo('FechaHoyAAAAMMDD') between t1.DATAB and t1.DATBI
--and CONVERT (varchar( 8), getdate(), 112 ) between t1.DATAB and t1.DATBI
GO
