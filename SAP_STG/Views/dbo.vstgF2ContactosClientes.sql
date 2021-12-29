SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- Vista de seleccion de Maestro de Clientes SAP. Contactos
-- Fase 2
-- Ramon Villanueva
-- Fecha: 26/12/14

CREATE VIEW [dbo].[vstgF2ContactosClientes] AS

SELECT CodEmpresa
      ,convert(int, t1.KUNNR) as CodCliente
	  ,PARNR NumContacto
	  ,UPPER(t1.NAMEV) as NombrePila
	  ,UPPER(t1.NAME1) as NombreCliente
      ,case t1.TELF1 when '' then 'N/A' else t1.TELF1 end as Telefono
	  ,PARAU as Observaciones
	  ,UPPER(TITEL_AP) as Titulo
  FROM KNVK as t1 -- Datos de Contactos de cliente
 	










GO
