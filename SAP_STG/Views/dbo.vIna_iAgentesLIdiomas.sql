SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 27/10/2015
-- Description:	Traspaso tablas inaCatalog. iAgentesLIdiomas
-- ======================================================
CREATE view [dbo].[vIna_iAgentesLIdiomas] as
	SELECT	t1.codEmpresa
			, t1.codAgente
			, 'es' codIdiomaDestino
FROM inaAgentes t1
where t1.Ina=1

GO
