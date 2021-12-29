SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- ====================================================
-- Author:		Ramon Villanueva
-- Create date: 19/02/2015
-- Description:	Detalle de Ordenes de SAT con coste
-- ====================================================
CREATE view [dbo].[vstgF2CosteSAT] as
SELECT	convert(int,t1.AUFNR) NumOrdenSAT
		, convert(date, convert(char(8),t2.ERDAT), 112) FechaOrden
		, convert(int,t1.KUNUM) CodCliente
		, (t3.WTG001 + t3.WTG002 + t3.WTG003 + t3.WTG004 + t3.WTG005 + t3.WTG006 + t3.WTG007 + t3.WTG008
		   + t3.WTG009 + t3.WTG010 + t3.WTG011 + t3.WTG012 + t3.WTG013 + t3.WTG014 + t3.WTG015 + t3.WTG016 ) CosteSAT
	     , t4.PARNR CodTecnicoSAT
FROM	AFIH t1
		inner join CAUFV t2
			on t1.AUFNR=t2.AUFNR
		inner join COSP t3
			on t2.OBJNR=t3.OBJNR 
	     left outer join IHPA t4
			on t2.OBJNR=t4.OBJNR
where --(t3.WTG001 + t3.WTG002 + t3.WTG003 + t3.WTG004 + t3.WTG005 + t3.WTG006 + t3.WTG007 + t3.WTG008
		--   + t3.WTG009 + t3.WTG010 + t3.WTG011 + t3.WTG012 + t3.WTG013 + t3.WTG014 + t3.WTG015 + t3.WTG016 ) <>0
t3.VRGNG='COIN'
GO
