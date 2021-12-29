SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


 -- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 17/03/2015
-- Description:	Analisis PLV por cliente
-- Modificacion: 03/11/2016
--	   Si no hay venta neta no salian registros
-- Modificacion: 07/11/2016
--	   Añadir Gasto PLV AM
-- ========================================================
CREATE view [dbo].[vstgF3PLVCliente] as

 select --coalesce(tt1.CodEmpresa, tt2.CodEmpresa) CodEmpresa
		  coalesce(tt1.CodCliente, tt2.CodCliente) CodCliente
		 , convert(money,coalesce(tt1.VentaNetaPLVAM, 0)) VentaNetaPLVAM	-- Venta neta año movil
		 , convert(money,coalesce(tt2.VentaNetaPLVMA, 0)) VentaNetaPLVMA	-- Venta neta mes anterior
 		 , convert(money,coalesce(tt3.VentaNetaPLVAA, 0)) VentaNetaPLVAA    -- Venta neta año actual
 		 , convert(money,coalesce(tt3.GastoPLVAA, 0))	  GastoPLVAA		-- Gasto año actual
 		 , convert(money,coalesce(tt1.GastoPLVAM, 0))	  GastoPLVAM		-- Gasto año movil  07/11/2016
from 
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaPLVAM
		, SUM(t1.ImporteTarifa) GastoPLVAM	   --07/11/2016
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
	  and t2.CodNivel1=6 -- PLV
group by t1.CodEmpresa, t1.CodCliente
--having sUM(t1.VentaNeta)>0    03/11/2016
) as tt1 -- ACUMULADOS AÑO MOVIL
left outer join 
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaPLVMA
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
	  and t2.CodNivel1=6 -- PLV
group by t1.CodEmpresa, t1.CodCliente
--having sUM(t1.VentaNeta)>0		 03/11/2016
) as tt2 -- PERIODO ANTERIOR
on tt1.CodEmpresa=tt2.CodEmpresa
	and tt1.CodCliente=tt2.CodCliente
left outer join 
(select   t1.CodEmpresa
		, t1.CodCliente
		, SUM(t1.VentaNeta) VentaNetaPLVAA
		, SUM(t1.ImporteTarifa) GastoPLVAA
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
		and t2.CodNivel1=6 -- PLV
group by t1.CodEmpresa, t1.CodCliente
--having SUM(t1.VentaNeta)>0	  03/11/2016
) as tt3 -- ACUMULADOS AÑO ACTUAL
on tt1.CodEmpresa=tt3.CodEmpresa
	and tt1.CodCliente=tt3.CodCliente
GO
