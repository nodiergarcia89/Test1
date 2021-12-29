SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO





-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 23/12/2014
-- Description:	Traspaso tablas inaCatalog. iAgentes
-- Pagina 13
-- Modificacion: 08/02/2017
--   Incluir un agente por delegacion para potenciales
-- ======================================================
CREATE view [dbo].[vIna_iAgentes] as
-- Agentes con o sin Tablet
SELECT	  2 CodEmpresa
		, t1.CodVendedor CodAgente
			, iif(isnumeric(t1.Telefono)=1
				    --,left(concat(t1.NombreCompleto, CHAR(13)+CHAR(10),' (',rtrim(t1.Telefono),')'),50)
				    ,left(concat(t1.NombreCompleto, ' (',rtrim(t1.Telefono),')'),50)
				    , t1.NombreCompleto) Nombre
from stgF2Vendedores t1
inner join inaAgentes t2
	on t2.CodEmpresa=2
		and t1.CodVendedor=t2.CodAgente
where CodAgente<>53
UNION ALL
select 2,53,'VILLANUEVA GOMEZ, RAMON'
UNION ALL
select 2,0,'NO ASIGNADO'
UNION ALL
SELECT
	  2 AS                         CodEmpresa
	, CodDelegacion * 1000 + 1 AS  CodAgente
	, 'POTENCIALES '+ Delegacion COLLATE DATABASE_DEFAULT AS Nombre
FROM   inaDelegaciones
WHERE  Ina = 1

GO
