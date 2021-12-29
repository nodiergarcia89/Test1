SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO




-- ============================================================
-- Author:		Ramon Villanueva
-- Create date: 10/12/2014
-- Description:	Deuda de clientes
-- Modificacion: 15/10/2015
--    Para indirecta he visto que el campo FILKD que es
--    el establecimiento está vacio.
--    Lo cambio para que si el establecimiento esta en blanco
--    coja el pagador.
-- ============================================================
CREATE VIEW [dbo].[vstgF2DeudaClientes] AS

select	t1.BUKRS CodSociedad
		, iif(t1.FILKD='',t1.KUNNR,t1.FILKD) CodCliente
		, t1.KUNNR CodPagador
		, coalesce(t3.klimk,0) DeudaAsegurada
		, coalesce(t3.skfor,0) TotalDeuda
		, coalesce(t3.ssobl,0) DeudaComprometida
		, t1.ZUONR NumFactura
		, convert(date, t1.BUDAT, 112) FechaFactura
		, coalesce(t2.NETWR + t2.MWSBK,0) ImpTotFactura
		, case t1.UMSKS when 'I' then (t1.DMBTR + t1.WMWST) else 0 end Impagado
		, case t1.SHKZG
			when 'S'
				then t1.DMBTR + t1.WMWST 
			else
				 -(t1.DMBTR + t1.WMWST)  -- Abonos
		  end as ImpPenFactura
		, case t1.SHKZG
			when 'S'
				then t1.XREF1  + (case t1.XREF1 when '' then '' else '/' end) + t1.XREF2
			else
				 t1.XBLNR
		  end as Visita
		, convert(date, t1.ZFBDT, 112) FechaVto
from BSID t1
		left outer join VBRK t2
			on  t1.MANDT COLLATE DATABASE_DEFAULT =t2.MANDT
				and t1.XBLNR COLLATE DATABASE_DEFAULT=t2.VBELN
left outer join knkk t3
	on t1.BUKRS=t3.CodEmpresa
	and t1.KUNNR COLLATE DATABASE_DEFAULT=t3.kunnr
	and t3.kkber='02'
--where	t1.ZLSPR<>'Z'
		-- and DATEDIFF(d,convert(date, t1.ZFBDT, 112),getdate()) < 730 -- Filtro por fecha
		-- and t1.UMSKZ=' ' -- CME






GO
