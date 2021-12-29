SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO




 -- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 18/03/2015
-- Description:	Analisis Facturacion por cliente
-- ========================================================
CREATE view [dbo].[vstgF3FacturacionCliente] as

 select --coalesce(tt1.CodEmpresa, tt4.CodEmpresa) CodEmpresa
		  coalesce(tt1.CodCliente, tt4.CodCliente) CodCliente
		 , convert(money,coalesce(tt1.VentaNetaAM, 0)) VentaNetaAM	-- Venta neta año movil
		 , convert(money,coalesce(tt2.VentaNetaMA, 0)) VentaNetaMA	-- Venta neta mes anterior
		 , convert(money,coalesce(tt4.VentaNetaAAA, 0)) VentaNetaAAA	-- Venta neta año anterior
		 , tt1a.FechaDatos
from 
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaAM
from	stgF2FacturasVentasSAP t1
		--inner join stgF2ArticulosSAP t2
		--	on t1.CodEmpresa=t2.CodEmpresa
		--		and t1.CodArticulo=t2.CodArticulo
		inner join dim_Fecha t3
			on t1.FechaFactura=t3.Fecha_key
where t3.PeriodoSAP
		between dbo.ufPeriodo('InicioAñoMovil') and dbo.ufPeriodo('FinAñoMovil') -- Periodo movil 12 meses atras
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt1
left outer join
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaMA
from	stgF2FacturasVentasSAP t1
		--inner join stgF2ArticulosSAP t2
		--	on t1.CodEmpresa=t2.CodEmpresa
		--		and t1.CodArticulo=t2.CodArticulo
		inner join dim_Fecha t3
			on t1.FechaFactura=t3.Fecha_key
where t3.PeriodoSAP=dbo.ufPeriodo('PeriodoAnterior')
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt2
on tt1.CodEmpresa=tt2.CodEmpresa
	and tt1.CodCliente=tt2.CodCliente
full outer join
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaAAA -- Acumulado año anterior
from	stgF2FacturasVentasSAP t1
		inner join dim_Fecha t3
			on t1.FechaFactura=t3.Fecha_key
where t3.PeriodoSAP between dbo.ufPeriodo('InicioAñoAnterior') and dbo.ufPeriodo('FinAñoAnterior')
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt4
on tt1.CodEmpresa=tt4.CodEmpresa
	and tt1.CodCliente=tt4.CodCliente
inner join  -- Fecha de la última factura
	(select CodEmpresa
			, CodCliente
			, convert (date, convert( char(8 ),max(FechaFactura)), 112) FechaDatos
		from stgF2FacturasVentasSAP
		group by CodEmpresa, CodCliente) as tt1a
on	tt1a.CodEmpresa=coalesce(tt1.CodEmpresa, tt2.CodEmpresa, tt4.CodEmpresa)
	and tt1a.CodCliente=coalesce(tt1.CodCliente, tt2.CodCliente, tt4.CodCliente) 


GO
