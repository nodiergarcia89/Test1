SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 23/10/2015
-- Description:	Articulos vendidos por cliente
--				Acumulado año anterior
-- ========================================================
CREATE view [dbo].[vVentaArticulosClienteAA] as 
select t1.CodCliente
		, t3.CodNivel1
		, t3.Nivel1
		, t1.CodArticulo
		, t3.Articulo
		, sum(t1.cantidad) Cantidad
		, sum(t1.KilosCafe) KilosCafe
		, sum(t1.importe) Importe
		, sum(t1.ImporteCafe) ImporteCafe
		, sum(t1.ImportePLV) ImportePLV
		, sum(t1.ImporteComplementos) ImporteComplementos
		, iif(sum(t1.KilosCafe)<>0,convert(money,sum(t1.ImporteCafe)/sum(t1.KilosCafe)),0) PrecioMedioCafe
		--, iif(sum(t1.KilosCafe)<>0,convert(money,sum(t1.ImporteComplementos)/sum(t1.KilosCafe)),0) RatioComplementos
from stgF2FacturasVentasSAP t1
	inner join dim_Fecha t2
		on t1.FechaFactura=t2.Fecha_key
	inner join stgF2ArticulosSAP t3
		on t1.CodEmpresa=t3.CodEmpresa
			and t1.CodArticulo=t3.CodArticulo
where t1.CodEmpresa=2
	-- Año anterior:
	and t2.PeriodoSAP between dbo.ufPeriodo('InicioAñoAnterior') and dbo.ufPeriodo('FinAñoAnterior')
group by t1.CodEmpresa
		, t1.CodCliente
		, t3.CodNivel1
		, t3.Nivel1
		, t1.CodArticulo
		, t3.Articulo

GO
