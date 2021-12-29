SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- ======================================================
-- Author:		Ramon Villanueva
-- Create date: 12/11/2015
-- Description:	Contacto Principal Cliente. KNVK
-- Contacto principal del cliente. Cojo sólo un registro
-- por cliente de la KNVK
-- ======================================================
CREATE view [dbo].[vKNVK_Principal] as

SELECT *
FROM
(select convert(int, h.KUNNR) CodCliente
      ,h.PARNR NumContacto
      ,UPPER(h.NAMEV) NombrePila
      ,UPPER(h.NAME1) NombreCliente
      ,case h.TELF1 when '' then 'N/A' else h.TELF1 end as Telefono
      ,h.PARAU Observaciones
      ,UPPER(h.TITEL_AP) Titulo
	  ,row_number () over (partition by h.CodEmpresa,h.KUNNR order by h.CodEmpresa,h.KUNNR, h.PARNR) AS RowN
from KNVK h) as T  -- Datos de Contactos de cliente
WHERE RowN = 1
GO
