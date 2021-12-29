SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- ====================================================
-- Author:		Ramon Villanueva
-- Create date:	12/04/2016
-- Description:	Condiciones especiales de SAT
-- ====================================================
CREATE view [dbo].[vstgCondVentaSAT] as
select	 2 CodEmpresa
		  , 1 CodCanal
	     , convert(int,t1.KUNNR) CodCliente
		,'' CodTarifa
		,t1.KSCHL CodClaseCondicion
		, 0 CodArticulo
		, 0 PrecioTarifaFinal
		, t1.DATAB FechaIni
		, t1.DATBI FechaFin
		,t2.KBETR ImpPorc
		, 0 IndPorc
		,t2.KBETR Neto
		,'' CodArtObs
		,0 CantBase
		,0 CantRegalo
from A831 t1
inner join KONP t2
	on t1.MANDT=t2.MANDT
		and t1.KNUMH=t2.KNUMH
where t1.KSCHL='Z215'
GO
