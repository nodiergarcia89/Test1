SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- Vista de seleccion de Maestro de Clientes SAP
-- Fase 2
-- Ramon Villanueva
-- Fecha: 06/06/11

CREATE VIEW [dbo].[vstgF2Clientes] AS

SELECT 
      convert(int, t1.KUNNR) as CodCliente
	  ,case when t1.NAME1='' then UPPER(t1.NAME2) 
		else UPPER(t1.NAME1) end as NombreCliente
      ,UPPER(t1.STRAS) as Direccion
      ,UPPER(t1.ORT01) as Poblacion
      ,t1.PSTLZ as CP
      ,t1.LAND1 as CodPais
	  ,upper(t4.LANDX) as Pais
      ,case t1.REGIO when '' then '00'  else t1.REGIO end as CodProvincia
	  ,coalesce(upper(t2.BEZEI), 'N/D') as Provincia
      ,case t1.TELF1 when '' then 'N/A' else t1.TELF1 end as Telefono
      ,case t1.TELFX when '' then 'N/A' else t1.TELFX end as Fax
      ,convert(date, t1.ERDAT,112) AS FechaCreacionRegistro
      ,t1.KTOKD as CodGrupoClientes
      ,coalesce(UPPER(t3.TXT30), 'NO ASIGNADO') as GrupoClientes  
	  ,coalesce(UPPER(t5.smtp_addr), 'N/A') as DireccionEmail     	                                 
	  ,case  
			when t1.CASSD ='X' then 'S' 
			when t1.LOEVM ='X' then 'S'
			when t1.AUFSD='01'  then 'S' -- Bloqueo para los de HI
			else 'N' 
		end Baja
    ,t1.KATR2 CodDelegacionOrigen
    ,UPPER(coalesce(t33.VTEXT,'N/A')) DelegacionOrigen

  FROM KNA1 as t1 -- Datos del Maestro de clientes
 LEFT OUTER JOIN ZT077X as t3  -- Grupos de Clientes SAP
	on t1.MANDT=t3.MANDT  collate DATABASE_DEFAULT
	and t1.KTOKD=t3.KTOKD collate DATABASE_DEFAULT
 LEFT OUTER JOIN T005U as t2
	on	t1.MANDT=t2.MANDT COLLATE DATABASE_DEFAULT
		and t1.LAND1=t2.LAND1 COLLATE DATABASE_DEFAULT
		and t1.REGIO=t2.BLAND COLLATE DATABASE_DEFAULT
 LEFT OUTER JOIN T005T as t4
	on t1.MANDT =t4.MANDT COLLATE DATABASE_DEFAULT
		and t1.LAND1 =t4.LAND1  COLLATE DATABASE_DEFAULT
left outer join 
	(select client, addrnumber, smtp_addr 
		from adr6
			where consnumber='001' 
				  and PERSNUMBER=0) as t5
 		on t1.MANDT=t5.client  COLLATE DATABASE_DEFAULT
		and t1.ADRNR=t5.addrnumber  COLLATE DATABASE_DEFAULT
	LEFT OUTER JOIN TVK2T AS T33
		    ON t1.MANDT=t33.MANDT  COLLATE DATABASE_DEFAULT
				and t1.KATR2=t33.KATR2  COLLATE DATABASE_DEFAULT
--where 
---- Ignoro clientes marcados para borrado
--t1.LOEVM<>'X'




		







GO
