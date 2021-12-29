SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


 -- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 27/03/2015
-- Description:	Condiciones de cliente
-- Modificacion:	02/03/2016
--	   Elimino la tabla sym_SAP_ZXONE_DESCUENTOS y tiro de
-- stgF3CondEspeciales
-- Ojo las promociones con obsequio no salen.
-- Modificacion: 10/06/2020
--   Elcampo IndPorc no es Importe de descuento unitario
-- ========================================================
CREATE view [dbo].[vstgF3CondicionesCliente] as
select	coalesce(t5.CodCliente,t1.CodCliente) CodCliente
		, t3.NombreCliente
		, t2.CodNivel1
		, t2.Nivel1
		, ROW_NUMBER() OVER(partition by t5.CodCliente, t2.CodNivel1 order by t5.Cantidad desc) as NumReg
		, t2.CodArticulo
		, t2.Articulo
		, t2.Unidad_Medida
		, convert(money,t4.PrecioTarifaFinal) PrecioTarifaFinal
		, round(coalesce(t1.Neto,convert(money,t4.PrecioTarifaFinal)),2)  PrecioCliente
		, case 
			when t1.CodCliente IS NULL THEN 'N'
			else 'S'
		  end CondEsp
		, coalesce(t1.CantBase,0) Base
		, coalesce(t1.CantRegalo,0) Regalo
		--, iif(coalesce(t1.IndPorc,0)=1,t1.IndPorc,0) Importe -- 10/06/2020
		, 0 Importe -- 10/06/2020
		, t5.Cantidad CantMes1
		, 0 CantMes2
		, 0 CantMes3
		, 0 CantMes4
from	vVentaArticulosCliente  t5				-- Historial. Consulta basada en consumos 
		left outer join stgF3CondEspeciales  t1	-- Condiciones 
			on	t5.CodCliente=t1.CodCliente
				and t1.CodCanal=1
				and t5.codArticulo=t1.CodArticulo
		inner join stgF2ArticulosSAP t2
			on t5.CodArticulo=t2.CodArticulo
		inner join stgF3Clientes as t3
			on t5.CodCliente=t3.CodCliente
		inner join stgF2TarifasSAP as t4
			on t3.CodTarifa=t4.CodTarifa
				and t5.CodArticulo=t4.CodArticulo_SAP
				and getdate() <= t4.FechaTHasta
				AND GETDATE()>=t4.FechaTDesde
--where	t4.FechaTHasta>=getdate()
GO
