SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 24/10/2015
-- Description:	Ventas por cliente
--				Mes actual año anterior
-- ========================================================
CREATE view [dbo].[vVentaClienteMA] as 
select t1.CodCliente
		, sum(t1.cantidad) Cantidad
		, sum(t1.KilosCafe) KilosCafe
		, sum(t1.importe) Importe
		, sum(t1.ImporteCafe) ImporteCafe
		, sum(t1.ImportePLV) ImportePLV
		, sum(t1.ImporteComplementos) ImporteComplementos
		, iif(sum(t1.KilosCafe)<>0,convert(money,sum(t1.ImporteCafe)/sum(t1.KilosCafe)),0) PrecioMedioCafe
		, iif(sum(t1.KilosCafe)<>0,convert(money,sum(t1.ImporteComplementos)/sum(t1.KilosCafe)),0) RatioComplementos
from stgF2FacturasVentasSAP t1
	inner join dim_Fecha t2
		on t1.FechaFactura=t2.Fecha_key
where t1.CodEmpresa=2
	-- Mismo Periodo Año anterior:
	and t2.PeriodoSAP = dbo.ufPeriodo('PeriodoActualAñoAnterior')
group by t1.CodEmpresa
		, t1.CodCliente

GO
