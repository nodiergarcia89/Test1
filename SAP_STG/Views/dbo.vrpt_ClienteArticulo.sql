SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 22/12/2015
-- Description:	Vista reporte. Cliente/Articulo
-- ======================================================
CREATE view [dbo].[vrpt_ClienteArticulo] as
select coalesce(tt1.CodCliente,t3.CodCliente) CodCliente
	  ,t6.nomCliente
	  ,t6.Baja
	  ,t6.codAgente
	  ,t7.Nombre
      ,coalesce(tt1.CodNivel1,t3.CodNivel1) CodNivel1
      ,coalesce(tt1.Nivel1, t3.Nivel1) Nivel1
      ,coalesce(tt1.CodArticulo,t3.CodArticulo) CodArticulo
      ,coalesce(tt1.Articulo,t3.Articulo) Articulo
	  -- Cantidades
	  ,coalesce(t3.Cantidad,0) CantidadM
	  ,coalesce(t5.Cantidad,0) CantidadMA
	  ,case 
		when coalesce(t3.Cantidad,0)>coalesce(t5.Cantidad,0) Then 1 --Positivo
		when coalesce(t3.Cantidad,0)<coalesce(t5.Cantidad,0) Then 2 --Negativo
		when coalesce(t3.Cantidad,0)=coalesce(t5.Cantidad,0) Then 3 --Igual
	   end IncCantidad1
	  ,tt1.CantidadA
	  ,coalesce(t4.Cantidad,0) CantidadAM
	  ,case 
		when tt1.CantidadA>coalesce(t4.Cantidad,0) Then 1 --Positivo
		when tt1.CantidadA<coalesce(t4.Cantidad,0) Then 2 --Negativo
		when tt1.CantidadA=coalesce(t4.Cantidad,0) Then 3 --Igual
	   end IncCantidad2
      ,tt1.CantidadAA
	  -- Kilos Cafe
	  ,coalesce(t3.KilosCafe,0) KilosCafeM
	  ,coalesce(t5.KilosCafe,0) KilosCafeMA
	  ,case 
		when coalesce(t3.KilosCafe,0)>coalesce(t5.KilosCafe,0) Then 1 --Positivo
		when coalesce(t3.KilosCafe,0)<coalesce(t5.KilosCafe,0) Then 2 --Negativo
		when coalesce(t3.KilosCafe,0)=coalesce(t5.KilosCafe,0) Then 3 --Igual
	   end IncKilosCafe1
	  ,tt1.KilosCafeA
	  ,coalesce(t4.KilosCafe,0) KilosCafeAM
	  ,case 
		when tt1.KilosCafeA>coalesce(t4.KilosCafe,0) Then 1 --Positivo
		when tt1.KilosCafeA<coalesce(t4.KilosCafe,0) Then 2 --Negativo
		when tt1.KilosCafeA=coalesce(t4.KilosCafe,0) Then 3 --Igual
	   end IncKilosCafe2
      ,tt1.KilosCafeAA
	  -- Importes
      ,coalesce(t3.Importe,0) ImporteM
      ,coalesce(t5.Importe,0) ImporteMA
	  ,case 
		when coalesce(t3.Importe,0)>coalesce(t5.Importe,0) Then 1 --Positivo
		when coalesce(t3.Importe,0)<coalesce(t5.Importe,0) Then 2 --Negativo
		when coalesce(t3.Importe,0)=coalesce(t5.Importe,0) Then 3 --Igual
	   end IncImporte1
      ,tt1.ImporteA
      ,coalesce(t4.Importe,0) ImporteAM
	  ,case 
		when tt1.ImporteA>coalesce(t4.Importe,0) Then 1 --Positivo
		when tt1.ImporteA<coalesce(t4.Importe,0) Then 2 --Negativo
		when tt1.ImporteA=coalesce(t4.Importe,0) Then 3 --Igual
	   end IncImporte2
	   ,tt1.ImporteAA
	  -- Precios Medios
      ,iif(coalesce(t3.Cantidad,0)=0,0,coalesce(t3.Importe,0)/coalesce(t3.Cantidad,0)) PrecioMedioM
      ,iif(coalesce(t5.Cantidad,0)=0,0,coalesce(t5.Importe,0)/coalesce(t5.Cantidad,0)) PrecioMedioMA
	  ,case 
		when iif(coalesce(t3.Cantidad,0)=0,0,coalesce(t3.Importe,0)/coalesce(t3.Cantidad,0))>iif(coalesce(t5.Cantidad,0)=0,0,coalesce(t5.Importe,0)/coalesce(t5.Cantidad,0)) Then 1 --Positivo
		when iif(coalesce(t3.Cantidad,0)=0,0,coalesce(t3.Importe,0)/coalesce(t3.Cantidad,0))<iif(coalesce(t5.Cantidad,0)=0,0,coalesce(t5.Importe,0)/coalesce(t5.Cantidad,0)) Then 2 --Negativo
		when iif(coalesce(t3.Cantidad,0)=0,0,coalesce(t3.Importe,0)/coalesce(t3.Cantidad,0))=iif(coalesce(t5.Cantidad,0)=0,0,coalesce(t5.Importe,0)/coalesce(t5.Cantidad,0)) Then 3 --Igual
	   end IncPrecioMedio1
      ,iif(tt1.CantidadA=0,0,tt1.ImporteA/tt1.CantidadA) PrecioMedioA
	  ,iif(coalesce(t4.Cantidad,0)=0,0,coalesce(t4.Importe,0)/coalesce(t4.Cantidad,0)) PrecioMedioAM
	  ,case 
		when iif(tt1.CantidadA=0,0,tt1.ImporteA/tt1.CantidadA)>iif(coalesce(t4.Cantidad,0)=0,0,coalesce(t4.Importe,0)/coalesce(t4.Cantidad,0)) Then 1 --Positivo
		when iif(tt1.CantidadA=0,0,tt1.ImporteA/tt1.CantidadA)<iif(coalesce(t4.Cantidad,0)=0,0,coalesce(t4.Importe,0)/coalesce(t4.Cantidad,0)) Then 2 --Negativo
		when iif(tt1.CantidadA=0,0,tt1.ImporteA/tt1.CantidadA)=iif(coalesce(t4.Cantidad,0)=0,0,coalesce(t4.Importe,0)/coalesce(t4.Cantidad,0)) Then 3 --Igual
	   end IncPrecioMedio2      
	  ,iif(tt1.CantidadAA=0,0,tt1.ImporteAA/tt1.CantidadAA) PrecioMedioAA
FROM
(SELECT coalesce(t1.CodEmpresa, t2.CodEmpresa) CodEmpresa
	  ,coalesce(t1.CodCliente, t2.CodCliente) CodCliente
      ,coalesce(t1.CodNivel1, t2.CodNivel1) CodNivel1
      ,coalesce(t1.Nivel1, t2.Nivel1) Nivel1
      ,coalesce(t1.CodArticulo, t2.CodArticulo) CodArticulo
      ,coalesce(t1.Articulo, t2.Articulo) Articulo
      ,coalesce(t1.Cantidad,0) CantidadAA
      ,coalesce(t1.KilosCafe,0) KilosCafeAA
      ,coalesce(t1.Importe,0) ImporteAA
	  ,coalesce(t2.Cantidad,0) CantidadA
	  ,coalesce(t2.KilosCafe,0) KilosCafeA
      ,coalesce(t2.Importe,0) ImporteA
FROM stgVentaArticulosClienteAA t1
FULL OUTER JOIN stgVentaArticulosClienteA t2
	on t1.CodEmpresa=t2.CodEmpresa
		and t1.CodCliente=t2.CodCliente
		and t1.CodArticulo=t2.CodArticulo
) AS tt1
FULL OUTER JOIN stgVentaArticulosClienteM t3
	on tt1.CodEmpresa=t3.CodEmpresa
		and tt1.CodCliente=t3.CodCliente
		and tt1.CodArticulo=t3.CodArticulo
LEFT OUTER JOIN stgVentaArticulosClienteAM t4
	on tt1.CodEmpresa=t4.CodEmpresa
		and tt1.CodCliente=t4.CodCliente
		and tt1.CodArticulo=t4.CodArticulo
LEFT OUTER JOIN stgVentaArticulosClienteMA t5
	on tt1.CodEmpresa=t5.CodEmpresa
		and tt1.CodCliente=t5.CodCliente
		and tt1.CodArticulo=t5.CodArticulo
INNER JOIN stgClientesCustom as t6
	on tt1.CodEmpresa=t6.CodEmpresa
		and tt1.CodCliente=t6.CodCliente
		and ISNUMERIC(t6.CodCliente)=1
INNER JOIN inaAgentes AS t7
	ON	t6.CodEmpresa = t7.CodEmpresa 
		AND t6.CodAgente = t7.CodAgente 
GO
