SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- ==================================================================
-- Author:		Ramon Villanueva
-- Create date: 08/01/15
-- Fase 2
-- Description:	Vista de generacion de Facturas de SAP
--    Depende de tablas de F1 y F2. Se carga en un proceso 
-- independiente [uspFacturasVSAP]
-- Modificacion: 23/10/2015
--  Incluir campos IdRegistro, KilosCafe, ImporteCafe e ImporteComplementos
--  Para eso meto la tabla de fase 2 stgF2ArticulosSAP
-- Modificacion: 18/1/2016
--  Incluir campos de tarifa y ajustar signo
-- Modificacion: 12/2/2016
--  Incluir campos:
--		ImporteCafeNeto
--		ImportePLVNeto
--		ImporteComplementosNeto
--		ImporteMaquinariaNeto
--		ImporteSATNeto
-- Modificacion: 08/06/2016
--    El campo Num_Factura no lo cambio de tipo de datos
-- ==================================================================

CREATE VIEW [dbo].[vstgF2FacturasVentasSAP] AS
SELECT   
		convert(nvarchar,'2-' + t1.VBELN + '-' + t2.POSNR) collate DATABASE_DEFAULT as IdRegistro
		, t1.VBELN AS Num_Factura
		,convert(int,t2.POSNR) AS Linea_Factura
		,t1.FKDAT as FechaFactura
		,t1.VTWEG CodCanal
		,convert(int, t1.KUNAG) as CodCliente
		,convert(int, t1.KUNRG) as CodPagador
		,convert(int,t2.MATNR) as CodArticulo
		,t2.VKBUR as CodDelegacion
		,t2.WERKS as CodCentro
		,t2.LGORT as CodAlmacen
		,convert(tinyint,t1.BUKRS) as Empresa
		,(case t2.SHKZG when 'X' then -1 else 1 end) AS Signo
		,t2.FKIMG * (case t2.SHKZG when 'X' then -1 else 1 end)					   Cantidad
		,t2.FKIMG * (case t2.SHKZG when 'X' then -1 else 1 end) * t6.ConversionKG  Cantidad_Standard
		,iif(t6.CodNivel1=1 and t6.CodTipoMaterial not in('Z005', 'Z007'), -- Los Kilos de cafe expresados en cantidad Standard que afectan a stock
				(case t3.ETERL 
					WHEN 'X' THEN t2.FKIMG * (case t2.SHKZG when 'X' then -1 else 1 end) * t6.ConversionKG 
					else 0 
				 end)
		 ,0) as KilosCafe
		,case t3.ETERL WHEN 'X' then 1 else 0 end as Afecta_Stock
		,convert(money,t2.WAVWR) * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end) as ImporteCoste

	   --************************************************************************ Importe de Coste
		,iif(t6.CodNivel1=1, -- Importe de cafe
				convert(money,t2.WAVWR) * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteCosteCafe
		,iif(t6.CodNivel1=6, -- Importe de PLV
				convert(money,t2.WAVWR) * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteCostePLV
		,iif(t6.CodNivel1=2, -- Importe de complementos
				convert(money,t2.WAVWR) * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteCosteComplementos
		,iif(t6.CodNivel1=3, -- Importe de maquinaria
				convert(money,t2.WAVWR) * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteCosteMaquinaria
		,iif(t6.CodNivel1=5, -- Importe de SAT
				convert(money,t2.WAVWR) * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteCosteSAT
	   --*****************************************************************************************
	    ,convert(money,ISNULL((t2.WAVWR/NULLIF(t2.FKIMG, 0)), 0)) * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end) as PrecioCoste
	    ,convert(money,ISNULL((t2.NETWR/NULLIF(t2.FKIMG, 0)), 0)) * (case t2.SHKZG when 'X' then -1 else 1 end) as Precio
		,t2.NETWR * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end) AS Importe
		,iif(t6.CodNivel1=1, -- Importe de cafe
				t2.NETWR * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteCafe
		,iif(t6.CodNivel1=6, -- Importe de PLV
				t2.NETWR * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImportePLV
		,iif(t6.CodNivel1=2, -- Importe de complementos
				t2.NETWR * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteComplementos
		,iif(t6.CodNivel1=3, -- Importe de maquinaria
				t2.NETWR * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteMaquinaria
		,iif(t6.CodNivel1=5, -- Importe de SAT
				t2.NETWR * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteSAT
		-- *************************************************Venta Neta
		,iif(t6.CodNivel1=1, -- Importe de cafe
				t2.KZWI6 * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteCafeNeto
		,iif(t6.CodNivel1=6, -- Importe de PLV
				t2.KZWI6 * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImportePLVNeto
		,iif(t6.CodNivel1=2, -- Importe de complementos
				t2.KZWI6 * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteComplementosNeto
		,iif(t6.CodNivel1=3, -- Importe de maquinaria
				t2.KZWI6 * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteMaquinariaNeto
		,iif(t6.CodNivel1=5, -- Importe de SAT
				t2.KZWI6 * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end)
			,0) as ImporteSATNeto
		-- *************************************************************
		,t2.KZWI6 * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end) AS VentaNeta
		,t2.KZWI5 * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end) AS VentaEst
		--,(t2.NETWR * (case t2.SHKZG when 'X' then -1 else 1 end)) - convert(money,t2.WAVWR) * (case t2.SHKZG when 'X' then -1 else 1 end) as ImporteMargen
		-- Para la tarifa, si es cero en la fecha cojo la de la carga
		,t1.PLTYP CodTarifa
		,iif(coalesce(t4.PrecioTarifa,0)<>0,t4.PrecioTarifa,coalesce(t4a.PrecioTarifa,0)) as PrecioTarifa
		,iif(coalesce(t4.PrecioTarifaFinal,0)<>0,t4.PrecioTarifaFinal,coalesce(t4a.PrecioTarifaFinal,0)) as PrecioTarifaFinal
		,(case t3.ETERL 
			WHEN 'X' THEN t2.FKIMG * (case t2.SHKZG when 'X' then -1 else 1 end) 
			else 0 
		 end) 
			* iif(coalesce(t4.PrecioTarifa,0)<>0,t4.PrecioTarifa,coalesce(t4a.PrecioTarifa,0)) as ImporteTarifa 
		,(case t3.ETERL 
			WHEN 'X' THEN t2.FKIMG * (case t2.SHKZG when 'X' then -1 else 1 end) 
			else 0 
		 end) 
			* iif(coalesce(t4.PrecioTarifaFinal,0)<>0,t4.PrecioTarifaFinal,coalesce(t4a.PrecioTarifaFinal,0)) as ImporteTarifaFinal 
		,t2.MWSBP * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end) AS ImporteIVA
		,(t2.NETWR + t2.MWSBP) * (case when t1.VBTYP='O' or t1.VBTYP='N' then -1 else 1 end) as ImporteTotalConIVA
		, case -- Si la factura se modifica porteriormente a la creacion cojo la fecha de modificacion
			WHEN t1.AEDAT>t1.ERDAT THEN convert(datetime, t1.AEDAT)
			ELSE
				convert(datetime, convert(varchar, convert(datetime, t1.ERDAT), 111)
					+ ' ' + substring(t1.ERZET, 1, 2)
					+ ':' + substring(t1.ERZET, 3, 2)
					+ ':' + substring(t1.ERZET, 5, 2)) 
			END as Factura_timestamp
		,0 as audit_key
		,1 as source_system_code
FROM    VBRK AS t1 LEFT OUTER JOIN
        VBRP AS t2 
			ON	t1.MANDT collate DATABASE_DEFAULT = t2.MANDT 
				AND t1.VBELN collate DATABASE_DEFAULT= t2.VBELN 
		LEFT OUTER JOIN TVAP as t3
			ON	t2.MANDT collate DATABASE_DEFAULT= t3.MANDT 
				AND t2.PSTYV collate DATABASE_DEFAULT=t3.PSTYV
		LEFT OUTER JOIN stgF2TarifasSAP as t4 -- Tarifa del cliente
			on  t1.PLTYP COLLATE DATABASE_DEFAULT=t4.CodTarifa
				and t1.VTWEG COLLATE DATABASE_DEFAULT=t4.CodCanal
				and convert(int,t2.MATNR)=t4.CodArticulo_SAP
				and ISDATE(t1.FKDAT)=1
				and convert(datetime, convert(char(8),t1.FKDAT), 112) 
					BETWEEN t4.FechaTDesde AND t4.FechaTHasta
		LEFT OUTER JOIN stgF2TarifasSAP as t4a -- Tarifa actual
			on  t1.PLTYP COLLATE DATABASE_DEFAULT=t4a.CodTarifa
				and t1.VTWEG COLLATE DATABASE_DEFAULT=t4a.CodCanal
				and convert(int,t2.MATNR)=t4a.CodArticulo_SAP
				and CONVERT(datetime, CONVERT(varchar, getdate(), 112)) 
					BETWEEN t4a.FechaTDesde AND t4a.FechaTHasta
		LEFT OUTER JOIN stgF2ArticulosSAP as t6 -- Articulos Fase 2
			on convert(tinyint,t1.BUKRS)=t6.CodEmpresa
				and convert(int,t2.MATNR)=t6.CodArticulo
WHERE ISDATE(t1.FKDAT)=1
GO
