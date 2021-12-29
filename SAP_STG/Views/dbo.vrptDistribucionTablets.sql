SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO




-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 03/08/2015
-- Description:	DistribucionTablets
-- ======================================================
CREATE view [dbo].[vrptDistribucionTablets] as
	select	t1.CodVendedor, t1.email
		, t4.Email EmailDelegado
		, t5.Email EmailAreaManager
	from stgF2Vendedores t1
		inner join inaAgentes t2
			on t1.CodEmpresa=t2.CodEmpresa
				and t1.CodVendedor=t2.CodAgente
		inner join inaDelegaciones t3
			on	t1.CodDelegacion=t3.CodDelegacion
		left outer join stgF2Vendedores t4
			on t3.CodDelegado=t4.CodVendedor
		left outer join stgF2Vendedores t5
			on t3.CodAreaManager=t5.CodVendedor
	where t2.Tablet=1 and t1.email<>'N/A'

GO
