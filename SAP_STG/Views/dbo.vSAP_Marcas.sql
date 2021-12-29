SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 03/05/2015
-- Description:	Marcas SAP
-- Modificacion: 03/12/2015
--   Ahora los parametros vienen de SAP. ZSD034
-- =============================================
CREATE VIEW [dbo].[vSAP_Marcas] as
select	t1.MVGR1 as CodMarca
				, t1.BEZEI as Marca
				, t2.ZZHAS as Hashtag
				, iif(t2.ZZCRM='X', 1, 0) as Ina
				, iif(t2.ZZFOL='X', 1, 0) as Folleto
				, iif(t2.ZZB2B='X', 1, 0) as Complementos
		from TVM1T t1
			inner join ZSD034 t2
				on t1.MANDT=t2.MANDT
					and t1.MVGR1=t2.MVGR1
GO
