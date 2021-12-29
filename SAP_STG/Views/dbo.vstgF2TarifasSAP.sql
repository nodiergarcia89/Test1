SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- Vista de Tarifas SAP
-- Autor: Ramon Villanueva
-- Fecha: 22/12/14
-- Determinacion de datos de tarifa
-- Nos encontramos 5 tipos de registro.
-- ZTAR= Tarifa Maestro
-- ZTDI= Importe
-- ZTD1= % Descuento 1
-- ZTD2= % Descuento 2
-- ZTD3= % Descuento 3
-- Unimos 5 tablas derivadas

CREATE VIEW [dbo].[vstgF2TarifasSAP] AS
SELECT tt1.CodTarifa, tt1.CodCanal, tt1.CodArticulo_SAP, tt1.FechaTDesde, tt1.FechaTHasta, tt1.PrecioTarifa
		,coalesce(tt2.ImporteDto, 0) as ImporteDto
		,coalesce(tt3.PorDto1, 0) as PorDto1
		,coalesce(tt4.PorDto2, 0) as PorDto2
		,coalesce(tt5.PorDto2, 0) as PorDto3
		,(tt1.PrecioTarifa + coalesce(tt2.ImporteDto, 0)) * (1 + coalesce(tt3.PorDto1, 0)/100) 
		 * (1 + coalesce(tt4.PorDto2, 0)/100) * (1+ coalesce(tt5.PorDto2, 0)/100) as PrecioTarifaFinal
FROM
(SELECT	t1.PLTYP as CodTarifa, t1.VTWEG as CodCanal
		,convert(int, t1.MATNR) as CodArticulo_SAP
		,convert(datetime, t1.DATAB) as FechaTDesde
		,convert(datetime, t1.DATBI) as FechaTHasta
		,t3.KBETR as PrecioTarifa
FROM	A950 AS t1 INNER JOIN
        KONP AS t3 
			ON	t1.KNUMH = t3.KNUMH 
				AND t1.MANDT = t3.MANDT 
				AND t1.KAPPL = t3.KAPPL 
				AND t1.KSCHL = t3.KSCHL 
WHERE	t1.KAPPL = 'V' 
		and t1.KSCHL='ZTAR'
) as tt1 LEFT OUTER JOIN
(SELECT	t1.PLTYP as CodTarifa
		,convert(int, t1.MATNR) as CodArticulo_SAP
		,convert(datetime, t1.DATBI) as FechaTHasta
		,t3.KBETR as ImporteDto
FROM	A950 AS t1 INNER JOIN
        KONP AS t3 
			ON	t1.KNUMH = t3.KNUMH 
				AND t1.MANDT = t3.MANDT 
				AND t1.KAPPL = t3.KAPPL 
				AND t1.KSCHL = t3.KSCHL 
WHERE	t1.KAPPL = 'V' 
		and t1.KSCHL='ZTDI'
) as tt2
ON	tt1.CodTarifa=tt2.CodTarifa
	and tt1.CodArticulo_SAP=tt2.CodArticulo_SAP
	and tt1.FechaTHasta=tt2.FechaTHasta LEFT OUTER JOIN
(SELECT	t1.PLTYP as CodTarifa
		,convert(int, t1.MATNR) as CodArticulo_SAP
		,convert(datetime, t1.DATBI) as FechaTHasta
		,t3.KBETR /10 as PorDto1
FROM	A950 AS t1 INNER JOIN
        KONP AS t3 
			ON	t1.KNUMH = t3.KNUMH 
				AND t1.MANDT = t3.MANDT 
				AND t1.KAPPL = t3.KAPPL 
				AND t1.KSCHL = t3.KSCHL 
WHERE	t1.KAPPL = 'V' 
		and t1.KSCHL='ZTD1'
) as tt3
ON	tt1.CodTarifa=tt3.CodTarifa
	and tt1.CodArticulo_SAP=tt3.CodArticulo_SAP
	and tt1.FechaTHasta=tt3.FechaTHasta LEFT OUTER JOIN
(SELECT	t1.PLTYP as CodTarifa
		,convert(int, t1.MATNR) as CodArticulo_SAP
		,convert(datetime, t1.DATBI) as FechaTHasta
		,t3.KBETR /10 as PorDto2
FROM	A950 AS t1 INNER JOIN
        KONP AS t3 
			ON	t1.KNUMH = t3.KNUMH 
				AND t1.MANDT = t3.MANDT 
				AND t1.KAPPL = t3.KAPPL 
				AND t1.KSCHL = t3.KSCHL 
WHERE	t1.KAPPL = 'V' 
		and t1.KSCHL='ZTD2'
) as tt4
ON	tt1.CodTarifa=tt4.CodTarifa
	and tt1.CodArticulo_SAP=tt4.CodArticulo_SAP
	and tt1.FechaTHasta=tt4.FechaTHasta LEFT OUTER JOIN
(SELECT	t1.PLTYP as CodTarifa
		,convert(int, t1.MATNR) as CodArticulo_SAP
		,convert(datetime, t1.DATBI) as FechaTHasta
		,t3.KBETR /10 as PorDto2
FROM	A950 AS t1 INNER JOIN
        KONP AS t3 
			ON	t1.KNUMH = t3.KNUMH 
				AND t1.MANDT = t3.MANDT 
				AND t1.KAPPL = t3.KAPPL 
				AND t1.KSCHL = t3.KSCHL 
WHERE	t1.KAPPL = 'V' 
		and t1.KSCHL='ZTD3'
) as tt5
ON	tt1.CodTarifa=tt5.CodTarifa
	and tt1.CodArticulo_SAP=tt5.CodArticulo_SAP
	and tt1.FechaTHasta=tt5.FechaTHasta 


GO
