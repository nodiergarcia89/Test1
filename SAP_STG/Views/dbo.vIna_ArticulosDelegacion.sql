SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO








-- ========================================================
-- Author:		Ramon Villanueva
-- Create date: 11/01/2015
-- Description:	Articulos por Delegacion
--	  26/05/15. Añado al catalogo central los articulos que
--    estan en el resto de centros y no en central.
-- ========================================================
CREATE view [dbo].[vIna_ArticulosDelegacion] AS
select t1.CodEmpresa
		, convert(int, t1.MATNR) CodArticulo
		, ltrim(rtrim(t4.CodCatalogo ))  CodCatalogo
from marc t1
inner join inaDelegaciones t3
	on t1.WERKS=t3.CodDelegacion
	and t3.Ina=1
inner join inaCatalogosDelegacion t4
	on convert(int, t1.WERKS)=t4.CodDelegacion
where t1.MMSTA=''  -- No de Baja
--and ltrim(rtrim(t4.CodCatalogo ))<>'2100' -- todos menos el general
UNION
-- Articulos que no estan en central
select distinct t1.CodEmpresa
		, convert(int, t1.MATNR) CodArticulo
		, '2100' CodCatalogo
from marc t1
where t1.WERKS<>'0200'
and convert(int, t1.MATNR)
	not in(select convert(int, MATNR)
				from marc where WERKS='0200')
and t1.MMSTA=''  -- No de Baja





GO
