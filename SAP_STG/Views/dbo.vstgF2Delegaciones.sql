SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

--*************************************************************
--Fecha: 11/12/2014
--Descripcion: Vista de delegaciones. F2
--Autor: Ramon Villanueva
--*************************************************************
CREATE VIEW [dbo].[vstgF2Delegaciones] AS
SELECT  T1.VKBUR AS CodDelegacion
		, UPPER(t2.BEZEI) AS Delegacion
		, UPPER(t3.NAME1) AS Delegacion_Completo
		, UPPER(t3.STREET) AS Direccion
		, UPPER(t3.STR_SUPPL3) AS DireccionAdicional
		, UPPER(t3.CITY1) AS Poblacion
		, t3.POST_CODE1 AS CP
		, t3.REGION AS CodProvincia
		, UPPER(t5.BEZEI) AS Provincia
		, t3.TEL_NUMBER AS Telefono
		, t3.TEL_EXTENS AS Extension
		, t3.FAX_NUMBER AS Fax
		, t6.CodArea
		, t6.Area
		, t6.CodDelegado
		, t6.CodAreaManager
FROM    TVBUR AS T1 
		INNER JOIN TVKBT AS t2 
			ON	T1.MANDT = t2.MANDT 
				AND T1.VKBUR = t2.VKBUR 
		INNER JOIN ADRC AS t3 
			ON T1.MANDT = t3.CLIENT 
				AND T1.ADRNR = t3.ADDRNUMBER 
		LEFT OUTER JOIN T005U AS t5 
			ON t3.COUNTRY = t5.LAND1 
				AND t2.SPRAS = t5.SPRAS 
				AND t3.REGION = t5.BLAND 
				AND t3.CLIENT = t5.MANDT
		LEFT OUTER JOIN inaDelegaciones t6
			ON T1.VKBUR=t6.CodDelegacion

GO
