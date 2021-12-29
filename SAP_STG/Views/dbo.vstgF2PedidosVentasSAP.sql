SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date: 16/02/16
-- Fase 2
-- Description:	Vista de generacion de Pedidos de SAP
-- ==================================================================

CREATE VIEW [dbo].[vstgF2PedidosVentasSAP] AS
SELECT   
		convert(nvarchar,'2-' + t1.VBELN + '-' + coalesce(t2.POSNR,'000001')) as IdRegistro
		, convert(nvarchar,t1.VBELN) AS NumPedido
		,convert(int,t2.POSNR) AS Linea_Pedido
		,t2.PSTYV as CodTipoPosicion
		,UPPER(coalesce(t4.VTEXT,'N/A')) as TipoPosicion
		,t1.AUART as CodClasePedido
		,UPPER(coalesce(t10.BEZEI,'N/A')) as ClasePedido
		,iif(t1.BSARK='','SAP',t1.BSARK) as OrigenPedido
		,t1.BSTDK as FechaPedido
		,t1.VDATU as FechaPrevEntrega
		,UPPER(t1.BSTNK) as RefCliente
		,convert(int,t1.VTWEG) CodCanal
        ,convert(int, t1.KUNNR) as CodCliente
		-- Funciones de Interlocutor ----------------------------------------
		,coalesce(convert(int,t5.PERNR) , 0) as CodVendedor
		,coalesce(convert(int,t7.PERNR) , 0) as CodRespAlta
		,coalesce(convert(int,t8.PERNR) , 0) as CodRespAltaAd
		,coalesce(convert(int,t9.PERNR) , 0) as CodRespCuenta
		,coalesce(convert(int,t11.LIFNR) , 0) as CodComisionista
		,coalesce(convert(int,t12.LIFNR) , 0) as CodComisionistaAd
		,coalesce(convert(int,t13.KUNNR) , 0) as CodSolicitante
		,coalesce(convert(int,t14.KUNNR) , 0) as CodDestMercancia
		,coalesce(convert(int,t15.KUNNR) , 0) as CodDestFactura
		,coalesce(convert(int,t16.KUNNR) , 0) as CodRespPago
		,coalesce(convert(int,t17.LIFNR) , 0) as CodTransportista
		,coalesce(convert(int,t18.PERNR) , 0) as CodATC
		,coalesce(convert(int,t19.KUNNR) , 0) as CodFondoComercio
		,coalesce(convert(int,t20.KUNNR) , 0) as CodCadena
		------------------------------------------------------------------------
		,convert(int,t2.MATNR) as CodArticulo
		,t1.VKBUR as CodDelegacion
		,t2.WERKS as CodCentro
		,t2.LGORT as CodAlmacen
		,2 as Empresa
		,(case t2.SHKZG when 'X' then -1 else 1 end) AS Signo
		,t2.KWMENG * (case t2.SHKZG when 'X' then -1 else 1 end)	CantidadPedida
		,t2.KWMENG * (case t2.SHKZG when 'X' then -1 else 1 end) * t6.ConversionKG  Cantidad_StandardPedida
		,iif(t6.CodNivel1=1 and t6.CodTipoMaterial not in('Z005', 'Z007'), -- Los Kilos de cafe expresados en cantidad Standard que afectan a stock
				(case t3.ETERL 
					WHEN 'X' THEN t2.KWMENG * (case t2.SHKZG when 'X' then -1 else 1 end) * t6.ConversionKG 
					else 0 
				 end)
		 ,0) as KilosCafePedido
		,case t3.ETERL WHEN 'X' then 1 else 0 end as Afecta_Stock
	    ,convert(money,ISNULL((t2.NETWR/NULLIF(t2.KWMENG, 0)), 0)) * (case t2.SHKZG when 'X' then -1 else 1 end) as PrecioPedido
		,t2.NETWR * (case t2.SHKZG when 'X' then -1 else 1 end) AS ImportePedido
		, case -- Si el pedido se modifica porteriormente a la creacion cojo la fecha de modificacion
			WHEN t1.AEDAT>t1.ERDAT THEN convert(datetime, t1.AEDAT)
			ELSE
				convert(datetime, convert(varchar, convert(datetime, t1.ERDAT), 111)
					+ ' ' + substring(t1.ERZET, 1, 2)
					+ ':' + substring(t1.ERZET, 3, 2)
					+ ':' + substring(t1.ERZET, 5, 2)) 
			END as Pedido_timestamp
		, convert(int,iif(t1.ERDAT > t2.ERDAT, t1.ERDAT, t2.ERDAT)) FechaCreacion
		, iif(iif(t1.AEDAT > t2.AEDAT, t1.AEDAT, t2.AEDAT)=iif(t1.ERDAT > t2.ERDAT, t1.ERDAT, t2.ERDAT),0,convert(int,iif(t1.AEDAT > t2.AEDAT, t1.AEDAT, t2.AEDAT)))  FechaModificacion
		--,t2.ZZVBELN NumContrato
		--,t2.ZZALBARAN_UT NumAlbaranUCC
		--,0 as audit_key
		--,1 as source_system_code
FROM    VBAK AS t1 LEFT OUTER JOIN
        VBAP AS t2 
			ON	t1.MANDT = t2.MANDT 
				AND t1.VBELN = t2.VBELN 
		LEFT OUTER JOIN TVAP as t3
			ON	t2.MANDT = t3.MANDT 
				AND t2.PSTYV=t3.PSTYV
		LEFT OUTER JOIN stgF2ArticulosSAP as t6 -- Articulos Fase 2
			on  t6.CodEmpresa=2
				and convert(int,t2.MATNR)=t6.CodArticulo
		left join TVAPT as t4 -- Tipos de Posicion
			on t2.MANDT=t4.MANDT
				and t2.PSTYV=t4.PSTYV
		left join TVAKT as t10 -- Clase de Pedido
			on t1.MANDT=t10.MANDT
				and t1.AUART=t10.AUART
		-- Funciones de interlocutor ***********************************
		LEFT OUTER JOIN VBPA as t5
			ON	t1.MANDT=t5.MANDT
				and t1.VBELN=t5.VBELN
				--and t5.POSNR=0
				and t5.PARVW='ZV' -- Vendedor
		LEFT OUTER JOIN VBPA as t7
			ON	t1.MANDT=t7.MANDT
				and t1.VBELN=t7.VBELN
				--and t7.POSNR=0
				and t7.PARVW='ZR' -- Responsable de alta
		LEFT OUTER JOIN VBPA as t8
			ON	t1.MANDT=t8.MANDT
				and t1.VBELN=t8.VBELN
				--and t8.POSNR=0
				and t8.PARVW='ZS' -- Responsable de alta adicional
		LEFT OUTER JOIN VBPA as t9
			ON	t1.MANDT=t9.MANDT
				and t1.VBELN=t9.VBELN
				--and t9.POSNR=0
				and t9.PARVW='ZB' -- Responsable de cuenta
		LEFT OUTER JOIN VBPA as t11
			ON	t1.MANDT=t11.MANDT
				and t1.VBELN=t11.VBELN
				--and t11.POSNR=0
				and t11.PARVW='ZC' -- Comisionista
		LEFT OUTER JOIN VBPA as t12
			ON	t1.MANDT=t12.MANDT
				and t1.VBELN=t12.VBELN
				--and t12.POSNR=0
				and t12.PARVW='ZH' -- Comisionista adicional
		LEFT OUTER JOIN VBPA as t13
			ON	t1.MANDT=t13.MANDT
				and t1.VBELN=t13.VBELN
				--and t13.POSNR=0
				and t13.PARVW='AG' -- Solicitante
		LEFT OUTER JOIN VBPA as t14
			ON	t1.MANDT=t14.MANDT
				and t1.VBELN=t14.VBELN
				--and t14.POSNR=0
				and t14.PARVW='WE' -- Destinatario de mercancia
		LEFT OUTER JOIN VBPA as t15
			ON	t1.MANDT=t14.MANDT
				and t1.VBELN=t15.VBELN
				--and t15.POSNR=0
				and t15.PARVW='RE' -- Destinatario de factura
		LEFT OUTER JOIN VBPA as t16
			ON	t1.MANDT=t16.MANDT
				and t1.VBELN=t16.VBELN
				--and t16.POSNR=0
				and t16.PARVW='RG' -- Responsable de pago
		LEFT OUTER JOIN VBPA as t17
			ON	t1.MANDT=t17.MANDT
				and t1.VBELN=t17.VBELN
				--and t17.POSNR=0
				and t17.PARVW='SP' -- Transportista
		LEFT OUTER JOIN VBPA as t18
			ON	t1.MANDT=t18.MANDT
				and t1.VBELN=t18.VBELN
				--and t18.POSNR=0
				and t18.PARVW='ZA' -- ATC
		LEFT OUTER JOIN VBPA as t19
			ON	t1.MANDT=t19.MANDT
				and t1.VBELN=t19.VBELN
				--and t19.POSNR=0
				and t19.PARVW='ZF' -- Fondo de comercio
		LEFT OUTER JOIN VBPA as t20
			ON	t1.MANDT=t20.MANDT
				and t1.VBELN=t20.VBELN
				--and t20.POSNR=0
				and t20.PARVW='ZJ' -- Cadena



GO
