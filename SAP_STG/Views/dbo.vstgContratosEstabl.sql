SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date:	16/03/16
-- Description:	Vista de Stage para la Bridge_ContratosEstabl
-- ==================================================================
CREATE view [dbo].[vstgContratosEstabl] as
SELECT
	   convert(int,t1.VBELN) NumContrato
	, convert(int,t1.KUNNR) CodCliente
FROM   dbo.ZCAH003 AS t1
GO
