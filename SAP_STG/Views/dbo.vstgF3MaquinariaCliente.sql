SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


 -- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 13/11/2015
-- Description:	Analisis Maquinaria por cliente
-- ========================================================
CREATE view [dbo].[vstgF3MaquinariaCliente] as

 select --coalesce(tt1.CodEmpresa, tt2.CodEmpresa) CodEmpresa
		  coalesce(tt1.CodCliente, tt2.CodCliente) CodCliente
		 , convert(money,coalesce(tt1.VentaNetaMaqAM, 0)) VentaNetaMaqAM	-- Venta neta año movil
		 , convert(money,coalesce(tt2.VentaNetaMaqMA, 0)) VentaNetaMaqMA	-- Venta neta mes anterior
 		 , convert(money,coalesce(tt3.VentaNetaMaqAA, 0)) VentaNetaMaqAA    -- Venta neta año actual
 		 , convert(money,coalesce(tt3.GastoMaqAA, 0))	  GastoMaqAA		-- Gasto año actual
from 
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaMaqAM
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
	  and t2.CodNivel1=3 -- Maquinaria
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt1 -- ACUMULADOS AÑO MOVIL
left outer join
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaMaqMA
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
	  and t2.CodNivel1=3 -- Maquinaria
group by t1.CodEmpresa, t1.CodCliente
having sUM(t1.VentaNeta)>0
) as tt2 -- PERIODO ANTERIOR
on tt1.CodEmpresa=tt2.CodEmpresa
	and tt1.CodCliente=tt2.CodCliente
left outer join
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaMaqAA
		, SUM(t1.ImporteTarifa) GastoMaqAA
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
		and t2.CodNivel1=3 -- Maquinaria
group by t1.CodEmpresa, t1.CodCliente
having SUM(t1.VentaNeta)>0
) as tt3 -- ACUMULADOS AÑO ACTUAL
on tt1.CodEmpresa=tt3.CodEmpresa
	and tt1.CodCliente=tt3.CodCliente
GO
