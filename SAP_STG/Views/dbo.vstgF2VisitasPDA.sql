SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- ====================================================
-- Author:		Ramon Villanueva
-- Create date: 02/03/2015
-- Description:	Visitas PDA
-- ====================================================
CREATE view [dbo].[vstgF2VisitasPDA] as
SELECT	 t1.VLCNDO AS CodVendedor  -- Obtener clave subrrogada en siguiente fase
		, convert(char(1),t1.VCTIDE) AS CodTipoVisita
		, convert(int,t1.VCNNOR) AS NumVisita
		, coalesce(convert(smallint, t2.VLNND0),0) LinVisita -- Visitas sin lineas
		,convert(int,t1.VCFEVI) AS FechaVisita_Key
		, CAST(convert(date,t1.VCFEVI) AS datetime) + CAST(STUFF(REPLACE(STR(t1.VCHOVI, 4), ' ', '0'), 3, 0, ':') AS datetime) FechaHoraVisita
		, coalesce(convert(char(1),t2.VLDESN),'') AS CodTipoLinea
		--, case CodTipo
		--		when '0' then 'Linea normal. No esta en tarifa o esta a cero en tarifa'
		--		when '1' then 'Devolucion'
		--		when '2' then 'Regalo normal'
		--		when '3' then 'Dto. comercial'
		--		when '4' then 'Oferta'
		--		when '5' then 'Obsequio oferta'
		--		when '6' then 'Oferta con limite'
		--		when '7' then 'Solo dto escalado'
		--		when '8' then 'Oferta y dto escalado'
		--		when '9' then 'dto. escalado y comercial'
		--		when 'B'
		--		when 'L'
		--		else 'N/A'
		--	 end Tipo
		, t1.VBELN_P AS NumPedido
		, t1.VBELN_E AS NumAlbaran
		, t1.VBELN_F AS NumFactura
		, t1.BUKRS   AS CodSociedad
		, t1.BELNR   AS NumDocContable
		, t1.NUMLIQ	 AS NumLiquidacion
		, t1.VCTCOB  AS CodTipoCobro
		, convert(smallint, t1.VCNRIM) AS NumImpresiones
		, t1.VCCOCL AS CodCliente   -- Obtener clave subrrogada en siguiente fase
		, coalesce(t2.VLCND1,0) AS CodArticulo  -- Obtener clave subrrogada en siguiente fase
		, coalesce(t2.VLCADE,0) AS Cantidad
		-- Cantidad Kilos
		, coalesce(convert(money,t2.VLCADE * t2.VLPRUN),0) AS ImporteVenta
		, t1.ERSDA AS FechaAlta
		, CAST(convert(date,t1.ERSDA) AS datetime) + CAST(STUFF(STUFF(REPLACE(STR(t1.UZBER, 6), ' ', '0'), 3, 0, ':'),6, 0, ':') AS datetime) FechaHoraAlta
		, 0 AS Origen -- Origen del registro 0=Antigua, 1=Nueva
FROM    ZCABVIS_SAP AS t1 
		LEFT OUTER JOIN ZLINVIS_SAP AS t2 
			ON	t1.CodEmpresa=t2.CodEmpresa
				AND t1.MANDT = t2.MANDT 
				AND t1.VLCNDO = t2.VLCNDO 
				AND t1.VCTIDE = t2.VLTIDE 
				AND t1.VCNNOR = t2.VLNNOR 



GO
