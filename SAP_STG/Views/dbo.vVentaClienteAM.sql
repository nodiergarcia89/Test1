SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 24/10/2015
-- Description:	Venta por cliente
--				Acumulado año anterior. Hasta mes anterior
-- ========================================================
CREATE view [dbo].[vVentaClienteAM] as 
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
	-- Desde primer periodo del año anterior hasta el periodo del mes anterior al actual:
	and t2.PeriodoSAP between dbo.ufPeriodo('InicioAñoAnterior') and dbo.ufPeriodo('PeriodoAnteriorAñoAnterior')
group by t1.CodEmpresa
		, t1.CodCliente


GO
