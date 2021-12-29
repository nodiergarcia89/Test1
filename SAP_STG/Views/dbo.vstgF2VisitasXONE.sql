SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date: 18/02/16
-- Description:	Vista de Stage para visitas PDA de XONE
-- ==================================================================
CREATE VIEW [dbo].[vstgF2VisitasXONE] as
select 	convert(nvarchar(33),'2-' + t1.PERNR + '-' + t1.TIPVI + '-' + t1.VISIT + '-' + coalesce(t2.POSNR,'0000001')) IdRegistro
		,t1.CodEmpresa
		,convert(int,t1.PERNR) CodTerminal
		,t1.TIPVI CodTipoVisita
		,convert(int,t1.VISIT) NumVisita
		,coalesce(convert(int,t2.POSNR),1) NumLinVisita
		,iif(t1.FACTC='','N/A',t1.FACTC) FacEnCentral
		,iif(t1.TICKE='','N/A',t1.TICKE) FacturaSN
		,iif(t1.NUMDO='','N/A',t1.NUMDO) NumDoc
		,coalesce(t2.POSAP,0) NumLinDoc
		,iif(t1.TIPDO='','N/A',t1.TIPDO) CodTipoDoc
		,convert(smallint,iif(t1.TIPVI IN ('V','W'), 2, 1)) CodCanal -- 1:Hosteleria, 2:Vending
		,convert(int,t1.KUNNR) CodCliente
		,convert(int,t1.FECVI) FechaVisita_key
		,t1.HORVI HoraVisita_key
		,iif(t1.VKBUR='','0',t1.VKBUR) CodDelegacion
		,iif(t1.LGORT='','0', t1.LGORT) CodAlmacen
		,t1.TOTAL TotalFactura
		,t1.TOCOB TotalCobrado
		,iif(t1.TOCOB>0
				,t1.TOCOB/count(*) OVER(PARTITION BY t1.PERNR,t1.TIPVI,t1.VISIT) 
				,0
			) ImporteCobrado
 		,case
			when t1.TOTAL>0 and t1.TOTAL=t1.TOCOB then 'S'
			when t1.TOTAL>0 and t1.TOCOB=0 then 'N'
			when t1.TOTAL>0 and t1.TOCOB>0 and t1.TOTAL<>t1.TOCOB then 'P'
			else 'N/A'
		 end EstCobro
		,iif(t1.TICOB='','N/A',t1.TICOB) CodTipoCobro 
		,t1.NUMIM NumImpresiones
		,t1.OBSER Observaciones
		,t1.NUMLI NumLiquidacion
		,convert(int,t1.PERCL) CodVendedor
		, convert(datetime, convert(varchar, convert(datetime, t1.ERSDA), 111)
					+ ' ' + substring(t1.ERZET, 1, 2)
					+ ':' + substring(t1.ERZET, 3, 2)
					+ ':' + substring(t1.ERZET, 5, 2)) Visita_timestamp
		,iif(t1.MANUA='X','S','N') VisitaManual
		,t1.VBELN_P NumPedido
		,t1.VBELN_E NumAlbaran
		,t1.MBLNR NumMovto
		,t1.VBELN_F NumFactura
		,iif(t1.TIPVI='F' and t1.VBELN_F<>null,convert(nvarchar,'2-' + t1.VBELN_F + '-' + t2.POSAP),'') as IdRegistroFac
		,t1.BELNR NumDocCtble
		,coalesce(iif(t1.NUMVM='','N/A',t1.NUMVM),'N/A') NumVisitaManual
		,coalesce(convert(int,t2.MATNR),0)	CodArticulo
		-- Si se trata de una devolucion multiplico por -1
		,coalesce(t2.CANTI,0) * iif(t2.TIPOP='1',-1,1)	Cantidad
		,coalesce(t2.PREUN,0) * iif(t2.TIPOP='1',-1,1)	Precio
		,iif(t1.TIPVI='C', t1.TOCOB,coalesce(t2.CANTI * t2.PREUN,0) * iif(t2.TIPOP='1',-1,1)) Importe
		,iif(t2.TIPOP='' or t2.TIPOP is null,'0',t2.TIPOP) CodTipoLinea
		,iif(t2.LOTES=1,'S','N') Lotes
from [ZCABVIS_XONESAP_STG] t1
left outer join [ZLINVIS_XONESAP_STG] t2
	on t1.CodEmpresa=t2.CodEmpresa
		and t1.MANDT=t2.MANDT
		and t1.PERNR=t2.PERNR
		and t1.TIPVI=t2.TIPVI
		and t1.VISIT=t2.VISIT

GO
