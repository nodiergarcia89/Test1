SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO





-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 22/12/2014
-- Description:	Traspaso tablas inaCatalog. iSectores
-- Pagina 52
-- ======================================================
CREATE view [dbo].[vIna_iSectores] as
select	2 as CodEmpresa
		,convert(int,SPART) as CodSector
		,upper(vtext) as Sector
from TSPAT
where MANDT=100
union all
select 2, 0, 'NO APLICABLE'


GO
