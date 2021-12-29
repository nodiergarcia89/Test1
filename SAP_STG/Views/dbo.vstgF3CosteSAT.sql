SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 19/02/2015
-- Description:	Resumen de Ordenes de SAT por cliente TAM
-- ========================================================
CREATE view [dbo].[vstgF3CosteSAT] as
SELECT   CodCliente
		, count(NumOrdenSAT) Ordenes
      , sum([CosteSAT]) as Coste
	  , sum([CosteSAT])/count(NumOrdenSAT) as CosteM
  FROM [SAP_STG].[dbo].[vstgF2CosteSAT]
	where FechaOrden >= dbo.ufDiasAtras()
  group by codcliente

GO
