SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [bi].[inaTiposArticulos] AS
SELECT 
	  t.CodTipoMaterial pkCodTipoMaterial
	, t.TipoMaterial
	, t.Ina
FROM   dbo.inaTiposArticulos AS t
GO
