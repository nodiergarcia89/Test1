SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

 -- ========================================================
-- Author:		Ramon Villanueva
-- Create date:	16/03/2016
-- Description:	Condiciones de cliente vs Ventas
-- ========================================================
CREATE VIEW [dbo].[vVentaArticulosCliente2] AS
SELECT
	  COALESCE(t1.CodEmpresa, t2.CodEmpresa) AS   CodEmpresa
	, COALESCE(t1.CodCliente, t2.CodCliente) AS   CodCliente
	, COALESCE(t1.CodArticulo, t2.CodArticulo) AS CodArticulo
	, COALESCE(t1.Cantidad, 0) AS                 Cantidad
	, COALESCE(t1.KilosCafe, 0) AS                KilosCafe
	, COALESCE(t1.Importe, 0) AS                  Importe
	, COALESCE(t1.ImporteCafe, 0) AS              ImporteCafe
	, COALESCE(t1.ImporteComplementos, 0) AS      ImporteComplementos
	, COALESCE(t1.PrecioMedioCafe, 0) AS          PrecioMedioCafe
	, COALESCE(t2.CodTarifa,'N/A')			 CodTarifa
	, COALESCE(t2.PrecioTarifaFinal,0) PrecioTarifaFinal
	, COALESCE(t2.FechaIni,0) FechaIni
	, COALESCE(t2.FechaFin,0) FechaFin
	, COALESCE(t2.ImpPorc,0) ImpPorc
	, COALESCE(t2.IndPorc,0) IndPorc
	, COALESCE(t2.Neto,0) Neto							   
	, COALESCE(t2.CodArtObs,0) CodArtObs
	, COALESCE(t2.CantBase,0) CantBase
	, COALESCE(t2.CantRegalo,0) CantRegalo
	, case 
		when t2.CodCliente IS NULL THEN 'N'
		else 'S'
	  end CondEsp
FROM   vVentaArticulosCliente AS t1
	  FULL OUTER JOIN stgF3CondEspeciales AS t2
	    ON t1.CodCliente = t2.CodCliente
		  AND t1.codArticulo = t2.CodArticulo
		  AND t2.CodCanal = 1
GO
