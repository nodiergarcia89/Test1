SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 08/04/2015
-- Description:	Analisis Visitas
-- ======================================================
CREATE view [dbo].[vAnalisisVisitas] as
SELECT	t3.CodDelegacion
		, t4.Delegacion
		, t6.FechaCompleta
		, t6.Año
		, t6.Mes
		, t6.MesTxt
		, t6.DiaSemana
		, t6.DiaSemanaTxt
		, t6.Estacion
		, t1.CodVendedor
		, t3.NombreCompleto
		, t1.NumVisita
		, t1.NumFactura
		, t1.CodTipoVisita
		, t1.CodCliente
		, coalesce(t5.NombreCliente, 'NO EXISTE') NombreCliente
		, coalesce(t5.CodVendedor,0) AS CodVendedorAct
		, sum(case when t2.CodNivel1=1 
			then t1.Cantidad * t2.ConversionKG 
			else 0.00
		  end) AS KGCafe
		, sum(case when t2.CodNivel1=1 
			then coalesce(t7.VentaNeta,0)
			else 0.00
		  end) AS FacturacionCafe
		, sum(case when t2.CodNivel1=2 
			then coalesce(t7.VentaNeta,0) 
			else 0.00
		  end) AS FacturacionComplementos
		, sum(case when t2.CodNivel1=6
			then coalesce(t7.VentaNeta,0) 
			else 0.00
		  end) AS FacturacionPLV
		, sum(case when t2.CodNivel1=1 
			then coalesce(t7.ImporteCoste,0)
			else 0.00
		  end) AS CosteCafe
		, sum(case when t2.CodNivel1=2 
			then coalesce(t7.ImporteCoste,0) 
			else 0.00
		  end) AS CosteComplementos
		, sum(case when t2.CodNivel1=6
			then coalesce(t7.ImporteCoste,0)
			else 0.00
		  end) AS CostePLV

FROM    [stgF2VisitasPDA] AS t1 
		left outer join stgF2ArticulosSAP AS t2 
			ON t1.CodArticulo = t2.CodArticulo 
		left outer join stgF2Vendedores AS t3 
			ON t1.CodVendedor = t3.CodVendedor 
		left outer join vstgF2Delegaciones AS t4 
			ON t3.CodDelegacion = t4.CodDelegacion 
		left outer join stgF3Clientes AS t5 
			ON t1.CodCliente = t5.CodCliente 
		INNER JOIN dim_Fecha AS t6 
			ON t1.FechaVisita_Key = t6.Fecha_key
		left outer join stgF2FacturasVentasSAP as t7
			on t1.NumFactura=t7.Num_Factura
				and t1.LinVisita=t7.Linea_Factura
where t6.Año>=2014
GROUP BY  t1.NumVisita
		, t1.NumFactura
		, t1.CodTipoVisita
		, t1.CodVendedor
		, t3.NombreCompleto
		, t6.Año
		, t6.Mes
		, t6.MesTxt
		, t6.DiaSemana
		, t6.DiaSemanaTxt
		, t6.Estacion
		, t6.FechaCompleta
		, t3.CodDelegacion
		, t4.Delegacion
		, t1.CodCliente
		, t5.NombreCliente
		, t5.CodVendedor

GO
