SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bi].[inaFamilias] AS
SELECT 
	  t.codFamilia pkCodFamilia
	, t.codSubFamilia pkCodSubFamilia
	, t.desFamilia
	, t.ordFamilia
	, t.JerarquiaSAP
	, t.NuevaDescripcion
	, t.nomIcoFamilia
	, t.NumArticulos
	, t.Ina
FROM   dbo.inaFamilias AS t
WHERE  t.CodEmpresa = 2
GO
