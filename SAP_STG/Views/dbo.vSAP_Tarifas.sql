SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 03/05/2015
-- Description:	Tarifas SAP
-- Modificacion: 03/12/2015
--   Ahora los parametros vienen de SAP. ZSD035
-- =============================================
CREATE VIEW [dbo].[vSAP_Tarifas] as
select t1.PLTYP CodTarifa
		, t1.PTEXT Tarifa
		, IIF(ZZFOL='X',1,0) Folleto
from T189T t1
inner join ZSD035 t2
	on t1.MANDT=t2.MANDT
		and t1.PLTYP=t2.PLTYP
GO
