SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vIpadsAgentes] AS
SELECT 
	  t1.CodEmpresa
	, t1.CodAgente
	, CONCAT('ipad',t1.CodAgente) nomIpad
	, t1.Nombre
FROM   inaAgentes AS t1
WHERE t1.Ina=1
AND t1.Tablet=1
GO
