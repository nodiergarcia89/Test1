SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 26/12/2014
-- Description:	Resumen. Deuda de clientes
-- =============================================
CREATE view [dbo].[vIna_DeudaClientes] AS
select	t1.CodEmpresa
		,t1.CodCliente
		,t1.DeudaAsegurada
		,t1.TotalDeuda
		,t1.DeudaComprometida
		,t1.DeudaTotal
		,t1.DeudaVencida
		,t1.DeudaNoVencida
		,t1.DeudaImpagada
from stgF3ResumenDeudaClientes t1







GO
