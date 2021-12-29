SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO




-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 22/12/2014
-- Description:	Traspaso tablas inaCatalog. iZonas
-- Pagina 15
-- ======================================================
CREATE view [dbo].[vIna_iZonas] as
select CodEmpresa
		, BZIRK CodZonaVentas
		, dbo.ProperCase(BZTXT )as ZonaVentas
from T171T -- Zona de Ventas
where MANDT=100
union all
select 2, 'XX', 'NO APLICABLE'


GO
