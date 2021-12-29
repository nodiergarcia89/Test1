SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 22/10/2015
-- Description:	Articulos vendidos por cliente año movil
-- ========================================================
CREATE view [dbo].[vVentaArticulosCliente] as 
select t1.CodEmpresa
		, t1.CodCliente
		, t1.CodArticulo
		, sum(t1.cantidad) Cantidad
		, sum(t1.KilosCafe) KilosCafe
		, sum(t1.importe) Importe
		, sum(t1.ImporteCafe) ImporteCafe
		, sum(t1.ImporteComplementos) ImporteComplementos
		, iif(sum(t1.KilosCafe)<>0,convert(money,sum(t1.ImporteCafe)/sum(t1.KilosCafe)),0) PrecioMedioCafe
		--, iif(sum(t1.KilosCafe)<>0,convert(money,sum(t1.ImporteComplementos)/sum(t1.KilosCafe)),0) RatioComplementos
from stgF2FacturasVentasSAP t1
	inner join dim_Fecha t2
		on t1.FechaFactura=t2.Fecha_key
where CodEmpresa=2
	-- Año movil:
	and t2.PeriodoSAP>=datepart (year, DATEADD(MONTH , DATEDIFF (MONTH, '19000101', GETDATE()) - 13 , '19000101'))*100 
					 + datepart (month, DATEADD(MONTH , DATEDIFF (MONTH, '19000101', GETDATE()) - 13, '19000101'))
group by t1.CodEmpresa
		, t1.CodCliente
		, t1.CodArticulo

GO
