SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 10/01/2015
-- Description:	Resumen. Deuda de clientes
-- Modificacion: 20/11/2015
-- La deuda vencida o no vencida que no este impagada
-- =============================================
CREATE view [dbo].[vstgF3ResumenDeudaClientes] AS
select	t1.CodCliente
		--, t1.CodPagador
		,max(t1.DeudaAsegurada) DeudaAsegurada
		,max(t1.TotalDeuda) TotalDeuda
		,max(t1.DeudaComprometida) DeudaComprometida
		,SUM(t1.ImpPenFactura) DeudaTotal
		,SUM(case when t1.FechaVto < getdate() and t1.Impagado=0 then t1.ImpPenFactura else 0 end) DeudaVencida
		,SUM(case when t1.FechaVto >= getdate() and t1.Impagado=0 then t1.ImpPenFactura else 0 end) DeudaNoVencida
		,SUM(t1.Impagado) DeudaImpagada
from vstgF2DeudaClientes t1
where t1.CodCliente<>'' -- Deuda de Establecimientos por eso no cojo el pagador
-- El group by lo hago porque un cliente puede tener deuda con mas de un pagador
group by CodSociedad, CodCliente
--, CodPagador




GO
