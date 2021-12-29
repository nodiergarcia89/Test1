SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 16/03/2015
-- Description:	Analisis Precio Medio por cliente
-- ========================================================
CREATE view [dbo].[vstgF3PrecioMedioCliente] as

 select	  coalesce(tt1.CodCliente, tt4.CodCliente) CodCliente
		 , coalesce(tt1.KilosAM, 0) KilosAM									-- Kilos acumulados año movil
		 , coalesce(tt3.KilosAA, 0) KilosAA									-- Kilos acumulados año actual
		 , coalesce(tt4.KilosAAA, 0) KilosAAA								-- Kilos acumulados año anterior
		 , convert(money,coalesce(tt1.VentaNetaAM, 0)) VentaNetaAM      	-- Venta neta año movil
		 , convert(money,coalesce(tt3.VentaNetaAA, 0)) VentaNetaAA      	-- Venta neta año actual
		 , convert(money,coalesce(tt4.VentaNetaAAA, 0)) VentaNetaAAA      	-- Venta neta año anterior
		 , convert(money,coalesce(tt1.VentaEstAM, 0)) VentaEstAM			-- Venta estadistica año movil
		 , convert(money,coalesce(tt3.VentaEstAA, 0)) VentaEstAA			-- Venta estadistica año actual
		 , convert(money,coalesce(tt4.VentaEstAAA, 0)) VentaEstAAA			-- Venta estadistica año anterior
		 , convert(money,coalesce(case when tt1.KilosAM<>0 
									then tt1.VentaNetaAM/tt1.KilosAM
									else 0 end, 0)) PrecioMedioVNAM			-- Precio Medio venta neta año movil
		 , convert(money,coalesce(case when tt3.KilosAA<>0 
									then tt3.VentaNetaAA/tt3.KilosAA
									else 0 end, 0)) PrecioMedioVNAA			-- Precio Medio venta neta año actual
		 , convert(money,coalesce(case when tt4.KilosAAA<>0 
									then tt4.VentaNetaAAA/tt4.KilosAAA
									else 0 end, 0)) PrecioMedioVNAAA		-- Precio Medio venta neta año anterior
		 , convert(money,coalesce(case when tt1.KilosAM<>0
									then tt1.VentaEstAM/tt1.KilosAM
									else 0 end, 0)) PrecioMedioVEAM			-- Precio Medio venta estadistica año movil
		 , convert(money,coalesce(case when tt3.KilosAA<>0
									then tt3.VentaEstAA/tt3.KilosAA
									else 0 end, 0)) PrecioMedioVEAA			-- Precio Medio venta estadistica año actual
		 , convert(money,coalesce(case when tt4.KilosAAA<>0
									then tt4.VentaEstAAA/tt4.KilosAAA
									else 0 end, 0)) PrecioMedioVEAAA		-- Precio Medio venta estadistica año anterior
		 , coalesce(tt2.KilosMA, 0) KilosMA									-- Kilos Mes anterior
		 , convert(money,coalesce(tt2.VentaNetaMA, 0)) VentaNetaMA			-- Venta neta mes anterior
		 , convert(money,coalesce(tt2.VentaEstMA, 0)) VentaEstMA			-- Venta estadistica mes anterior
		 , convert(money,coalesce(case when tt2.KilosMA<>0 
		 									then tt2.VentaNetaMA/tt2.KilosMA
									else 0 end, 0)) PrecioMedioVNMA			-- Precio medio Venta neta mes anterior
		 , convert(money,coalesce(case when tt2.KilosMA<>0 
									then tt2.VentaEstMA/tt2.KilosMA
									else 0 end, 0))  PrecioMedioVEMA		-- Precio medio Venta estadistica mes anterior

from 
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.Cantidad_Standard) KilosAM
		, SUM(t1.VentaNeta) VentaNetaAM
		, SUM(t1.VentaEst) VentaEstAM
from	stgF2FacturasVentasSAP t1
		inner join stgF2ArticulosSAP t2
			on t1.CodEmpresa=t2.CodEmpresa
				and t1.CodArticulo=t2.CodArticulo
		inner join dim_Fecha t3
			on t1.FechaFactura=t3.Fecha_key
		inner join stgF3Clientes t4
			on t1.CodEmpresa=t4.CodEmpresa
				and t1.CodCliente=t4.CodCliente
				and t4.CodCanal='01' -- HOSTELERIA
where t3.PeriodoSAP between dbo.ufPeriodo('InicioAñoMovil') and dbo.ufPeriodo('FinAñoMovil') -- Periodo movil 12 meses atras
	  and t2.CodNivel1=1 -- CAFE
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt1 -- ACUMULADOS AÑO MOVIL
left outer join 
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.Cantidad_Standard) KilosMA
		, SUM(t1.VentaNeta) VentaNetaMA
		, SUM(t1.VentaEst) VentaEstMA
from	stgF2FacturasVentasSAP t1
		inner join stgF2ArticulosSAP t2
			on t1.CodEmpresa=t2.CodEmpresa
				and t1.CodArticulo=t2.CodArticulo
		inner join dim_Fecha t3
			on t1.FechaFactura=t3.Fecha_key
		inner join stgF3Clientes t4
			on t1.CodEmpresa=t4.CodEmpresa
				and t1.CodCliente=t4.CodCliente
				and t4.CodCanal='01' -- HOSTELERIA
where t3.PeriodoSAP=dbo.ufPeriodo('PeriodoAnterior') --Periodo Anterior
	  and t2.CodNivel1=1 -- CAFE
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt2 -- PERIODO ANTERIOR
on tt1.CodEmpresa=tt2.CodEmpresa
	and tt1.CodCliente=tt2.CodCliente
left outer join 
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.Cantidad_Standard) KilosAA
		, SUM(t1.VentaNeta) VentaNetaAA
		, SUM(t1.VentaEst) VentaEstAA
from	stgF2FacturasVentasSAP t1
		inner join stgF2ArticulosSAP t2
			on t1.CodEmpresa=t2.CodEmpresa
				and t1.CodArticulo=t2.CodArticulo
		inner join dim_Fecha t3
			on t1.FechaFactura=t3.Fecha_key
		inner join stgF3Clientes t4
			on t1.CodEmpresa=t4.CodEmpresa
				and t1.CodCliente=t4.CodCliente
				and t4.CodCanal='01' -- HOSTELERIA
where	t3.PeriodoSAP between dbo.ufPeriodo('InicioAñoActual') and  dbo.ufPeriodo('PeriodoAnterior') -- Acumulado año actual
		and t2.CodNivel1=1 -- CAFE
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt3 -- ACUMULADOS AÑO ACTUAL
on tt1.CodEmpresa=tt3.CodEmpresa
	and tt1.CodCliente=tt3.CodCliente
full outer join
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.Cantidad_Standard) KilosAAA
		, SUM(t1.VentaNeta) VentaNetaAAA
		, SUM(t1.VentaEst) VentaEstAAA
from	stgF2FacturasVentasSAP t1
		inner join stgF2ArticulosSAP t2
			on t1.CodEmpresa=t2.CodEmpresa
				and t1.CodArticulo=t2.CodArticulo
		inner join dim_Fecha t3
			on t1.FechaFactura=t3.Fecha_key
		inner join stgF3Clientes t4
			on t1.CodEmpresa=t4.CodEmpresa
				and t1.CodCliente=t4.CodCliente
				and t4.CodCanal='01' -- HOSTELERIA
where t3.PeriodoSAP between dbo.ufPeriodo('InicioAñoAnterior') and  dbo.ufPeriodo('PeriodoAnteriorAñoAnterior') -- Acumulado año anterior
	  and t2.CodNivel1=1 -- CAFE
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt4 -- ACUMULADOS AÑO ANTERIOR
on tt1.CodEmpresa=tt4.CodEmpresa
	and tt1.CodCliente=tt4.CodCliente
GO
