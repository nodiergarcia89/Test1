SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ==============================================================
-- Author:	 Ramon Villanueva
-- Create date: 06/07/2020
-- Description: Preparar archivo con las facturas y albaranes de
--			 los clientes a trapasar.
-- Modificacion: 26/11/2020
--	   Cambiar la descripcion de Albaranes y facturar para añadir
--	   La fecha.
-- Modificacion: 14/12/2020
--	   Añadir situacion de deuda
-- Modificacion: 07/04/2021
--	   Añadir declaracion 347. Resumen de Facturacion año anterior.
-- ==============================================================
CREATE PROCEDURE [dbo].[uspB2BFacturasAlbaranes]
AS
    BEGIN
	   DECLARE 
			@SourceFolder NVARCHAR(50)='\\svvm04\Carreras$\'
	   DECLARE 
			@DestinationFolder NVARCHAR(50)='\\svvm04\MultIna$\'
	   DECLARE 
			@sql NVARCHAR(MAX)
	   DECLARE 
			@ArchivosCopiados INT

	   -- Ficheros en el destino 
	   SELECT 
			*
	   INTO 
		   #Destino
	   FROM   SAP_STG.dbo.Dir(@DestinationFolder)
	   SELECT 
			t.name
		   , t.path
		   , t.ModifyDate
		   , CONVERT(INT, SUBSTRING(t.name, 4, PATINDEX('%[_]%', t.name) - 4)) AS                         CodCliente
		   , t.name AS                                                                                    hipMultimedia
		   , SUBSTRING(t.name, PATINDEX('%[_]%', t.name) + 1, LEN(t.name) - PATINDEX('%[_]%', t.name)) AS desMultimedia
		   , CONCAT(LEFT(t.name, 3), SUBSTRING(t.name, 15, 10)) AS                                        NumDocumento
	   INTO 
		   #FilesInDestination
	   FROM   #Destino AS t
	   WHERE  PATINDEX('%[_]%', t.name) > 4
			AND (name LIKE 'ALB%.PDF'
				OR name LIKE 'FAC%.PDF')

	   -- Ficheros en el Origen
	   SELECT 
			*
	   INTO 
		   #Origen
	   FROM   SAP_STG.dbo.Dir(@SourceFolder)
	   SELECT 
			t.name
		   , t.path
		   , t.ModifyDate
		   , CONVERT(INT, SUBSTRING(t.name, 4, PATINDEX('%[_]%', t.name) - 4)) AS                         CodCliente
		   , t.name AS                                                                                    hipMultimedia
		   , SUBSTRING(t.name, PATINDEX('%[_]%', t.name) + 1, LEN(t.name) - PATINDEX('%[_]%', t.name)) AS desMultimedia
		   , CONCAT(LEFT(t.name, 3), SUBSTRING(t.name, 15, 10)) AS                                        NumDocumento
	   INTO 
		   #FilesInSource
	   FROM   #Origen AS t
			INNER JOIN dbo.sym_par_inaClientes AS s
			  ON s.CodEmpresa = 2
				AND CONVERT(INT, SUBSTRING(t.name, 4, PATINDEX('%[_]%', t.name) - 4)) = s.CodCliente
	   WHERE  PATINDEX('%[_]%', t.name) > 4
			AND LEFT(name, 3) = 'ALB'

	   -- Ficheros a copiar (de 20 en 20 por problemas de la STING_AGG). Ultimos 6 meses
	   SELECT TOP 20 
			t1.path
		   , CONVERT(INT, SUBSTRING(t1.name, 4, PATINDEX('%[_]%', t1.name) - 4)) AS CodCliente
	   INTO 
		   #FicherosACopiar
	   FROM   #FilesInSource AS t1
			LEFT JOIN #FilesInDestination AS t2
			  ON t1.name = t2.name
	   WHERE  DATEDIFF(month, t1.ModifyDate, GETDATE()) <= 6 -- Los de los últimos 6 meses
			AND (t1.ModifyDate > t2.ModifyDate
				OR t2.name IS NULL)

	   -- Copiar Albaranes de Carreras a carpeta multimedia;
	   SELECT 
			@ArchivosCopiados=@@ROWCOUNT
	   IF @ArchivosCopiados > 0
		  BEGIN
			 -- Copiar Albaranes de Carreras a carpeta multimedia;
			 WITH CmdSQL
				 AS (SELECT 
						  'EXEC master.dbo.xp_cmdshell ''' + 'COPY "' + t.path + '" "' + @DestinationFolder + '"' + '''' AS Comando
					FROM   #FicherosACopiar AS t)
				 -- Ejecutar el comando
				 SELECT 
					   @sql=STRING_AGG(TRIM(Comando), ';  ' + CHAR(13))
				 FROM   CmdSQL
			 EXEC sp_executesql 
				 @sql
		  END
	   -- Resumen deuda
	   SELECT 
			t.name
		   , t.path
		   , t.ModifyDate
		   , CONVERT(INT, SUBSTRING(t.name, 7, LEN(t.name) - 10)) AS CodCliente
		   , t.name AS                                               hipMultimedia
		   , 'Resumen Deuda' AS                                      desMultimedia
	   INTO 
		   #FilesDeuda
	   FROM   #Destino AS t
	   --INNER JOIN dbo.sym_par_inaClientes AS s
	   --  ON s.CodEmpresa = 2
	   --	AND CONVERT(INT, SUBSTRING(t.name, 4, PATINDEX('%[_]%', t.name) - 4)) = s.CodCliente
	   WHERE  LEFT(name, 6) = 'Deuda_'

	   -- 07/04/2021 Resumen de Facturacion
	   DECLARE @Año INT
	   SELECT @Año=2020
	   SELECT 
			  t1.CodPagador AS CodCliente
			 , CONCAT('D347_', t1.Año, '_',RTRIM(CONVERT(CHAR, CodPagador)), '.pdf') AS hipMultimedia
			 , CONCAT('Resumen Facturacion ' , t1.Año) AS desMultimedia
	   INTO #FilesD347
	   FROM   rpt.v347ClientesB2B AS t1
	   WHERE  t1.Año >= @Año
	   GROUP BY  t1.CodPagador
			 , t1.Año
	   HAVING COUNT(t1.Num_Factura) > 0
	   ORDER BY t1.CodPagador

	   -- Archivos multimedia de clientes
	   DELETE FROM sym_AchivosClientesB2B;
	   WITH Archivos
		   AS (SELECT 
				    CodCliente
				  , hipMultimedia
				  , desMultimedia
				  , NULL NumDocumento
				  , 1 Tipo
			  FROM   #FilesD347
			  UNION ALL
			  SELECT 
				    CodCliente
				  , hipMultimedia
				  , desMultimedia
				  , NumDocumento
				  , 2 Tipo
			  FROM     #FilesInDestination
			  UNION ALL
			  SELECT 
				    CodCliente
				  , hipMultimedia
				  , desMultimedia
				  , NumDocumento
				  , 3 Tipo
			  FROM     #FilesInSource
			  UNION ALL
			  SELECT 
				    CodCliente
				  , hipMultimedia
				  , desMultimedia
				  , NULL
				  , 4 Tipo
			  FROM   #FilesDeuda
			  ),
		   Documentos
		   AS (SELECT 
				    CONCAT('FAC', VBELN) AS NumDocumento
				  , FKDAT AS                FechaDocumento
			  FROM     dbo.sym_SAP_VBRK
			  WHERE   MANDT = 100
			  UNION
			  SELECT 
				    CONCAT('ALB', VBELN)
				  , WADAT AS FechaDocumento
			  FROM   dbo.sym_SAP_LIKP
			  WHERE  MANDT = 100)
		   INSERT INTO sym_AchivosClientesB2B
		   SELECT 
				2 AS                                                                                                                                                                 codEmpresa
			   , CONVERT(NVARCHAR(20), t.codCliente) AS                                                                                                                               codCliente
			   , 100 + ROW_NUMBER() OVER(PARTITION BY t.CodCliente
		   ORDER BY 
				  t.hipMultimedia DESC) AS                                                                                                                                           linMultimedia
			   , t.hipMultimedia
			   , IIF(t.Tipo IN(1,4), t.desMultimedia, CONCAT(LEFT(t.hipMultimedia, 3), LEFT(t.desMultimedia, LEN(t.desMultimedia) - 4), '_', s.FechaDocumento)) AS desMultimedia
			   , 0 AS                                                                                                                                                                 flaModificado
		   FROM   Archivos AS t
				LEFT JOIN Documentos AS s
				  ON t.NumDocumento = s.NumDocumento COLLATE DATABASE_DEFAULT
    END
GO
