SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


 -- ========================================================
-- Author:		Ramon Villanueva
-- Create date:	16/03/2016
-- Description:	Condiciones de cliente
-- Modificacion: 26/10/2016
--	   Si no tiene condiciones especiales el Neto a tarifa
-- Modificacion: 10/06/2020
--   Elcampo IndPorc no es Importe de descuento unitario
-- ========================================================
CREATE view [dbo].[vstgF3CondicionesCliente2] as
select	t5.CodCliente
		, t3.NombreCliente
		, t2.CodNivel1
		, t2.Nivel1
		, ROW_NUMBER() OVER(partition by t5.CodCliente, t2.CodNivel1 order by t5.Cantidad desc) as NumReg
		, t2.CodArticulo
		, t2.Articulo
		, t2.Unidad_Medida
		, convert(money,coalesce(t4.PrecioTarifaFinal,0)) PrecioTarifaFinal
		, round(iif(t5.Neto<>0,t5.Neto,convert(money,coalesce(t4.PrecioTarifaFinal,0))),2)  PrecioCliente -- 26/10/2016
		, t5.CondEsp
		, coalesce(t5.CantBase,0) Base
		, coalesce(t5.CantRegalo,0) Regalo
		, 0 Importe -- 10/06/2020
		--, iif(coalesce(t5.IndPorc,0)=1,t5.IndPorc,0) Importe -- 10/06/2020
		, t5.Cantidad CantMes1
		, 0 CantMes2
		, 0 CantMes3
		, 0 CantMes4
from	vVentaArticulosCliente2  t5				-- Historial. Consulta basada en consumos 
		inner join stgF2ArticulosSAP t2
			on t5.CodArticulo=t2.CodArticulo
		inner join stgF3Clientes as t3
			on t5.CodCliente=t3.CodCliente
		left join stgF2TarifasSAP as t4
			on t3.CodTarifa=t4.CodTarifa
				and t5.CodArticulo=t4.CodArticulo_SAP
				and getdate() <= t4.FechaTHasta
				AND GETDATE()>=t4.FechaTDesde
--where	t4.FechaTHasta>=getdate()
GO
