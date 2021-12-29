SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- Prueba de comentario
CREATE view [bi].[inaAgentesSuperv] as
SELECT
	  t1.CodEmpresa pkCodEmpresa
	, t1.CodAgenteS pkCodAgenteS
	, t1.CodAgente	 pkCodAgente
	, t1.Observaciones
FROM   dbo.inaAgentesSuperv AS t1
GO
