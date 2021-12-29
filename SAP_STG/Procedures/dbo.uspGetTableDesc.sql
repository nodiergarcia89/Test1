SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 15/07/2011
-- Description:	Obtener descripcion de tabla
-- =============================================
CREATE PROCEDURE [dbo].[uspGetTableDesc] 
AS
BEGIN
	
	-- Actualizar estadisticas
	DECLARE @SQL VARCHAR(255) 
    SET @SQL = 'DBCC UPDATEUSAGE (' + DB_NAME() + ')' 
    EXEC(@SQL) 
	 
	-- Tabla temporal para tamaños de tabla
    CREATE TABLE #tmp_Tabla1 
    (TablaName VARCHAR(255),
     NumRows varchar(255),
     TamReserved varchar(255),
     TamData varchar(255),
     TamIndex varchar(255),
     TamUnused varchar(255)    ) 

    INSERT #tmp_Tabla1 
        EXEC sp_msForEachTable 
            'exec sp_spaceused ''?'''

	-- Devolver datos
	SELECT    t.object_id 
			,t.Name as Tabla,
		     s.NumRows,
		     s.TamReserved,
			 s.TamData,
             s.TamIndex,
             s.TamUnused, 
		     c.column_id as IdColumna,
			 CONVERT (CHAR (50), c.name) as Columna,
			 CONVERT (CHAR (250), ep.value) as Descripcion,
			 CASE 
				WHEN ty.name IN ('char', 'varchar') THEN ty.name + '(' + CONVERT (VARCHAR, c.max_length) + ')' 
			  ELSE CASE 
				WHEN ty.name IN ('decimal', 'float') THEN ty.name + '(' + CONVERT (VARCHAR, c.precision) + ',' + CONVERT (VARCHAR, c.scale) + ')' 
			  ELSE ty.name 
			 END 
			 END AS Tipo,
			 c.max_length as Tamaño,
			 CASE COALESCE (a.column_id, 0) 
				WHEN 0 THEN ' ' ELSE 'S' 
			 END AS Clave,
			 CASE c.is_nullable 
				WHEN 0 THEN 'N' ELSE 'S' 
			 END AS [NULL]
	FROM     sys.tables AS t
			 INNER JOIN
			 #tmp_Tabla1 AS s
			 ON t.name=s.TablaName
			 INNER JOIN
			 sys.columns AS c
			 ON t.object_id = c.object_id
			 LEFT OUTER JOIN
			 sys.extended_properties AS ep
			 ON c.object_id = ep.major_id
				AND c.column_id = ep.minor_id
			 INNER JOIN
			 sys.types AS ty
			 ON c.system_type_id = ty.system_type_id
			 LEFT OUTER JOIN
			 (SELECT i.object_id,
					 ic.column_id
			  FROM   sys.indexes AS i
					 INNER JOIN
					 sys.index_columns AS ic
					 ON i.object_id = ic.object_id
						AND i.index_id = ic.index_id
						AND i.is_primary_key = 1) AS a
			 ON t.object_id = a.object_id
				AND c.column_id = a.column_id
	WHERE    ty.name <> 'sysname'
	ORDER BY t.name, c.column_id;
END

GO
