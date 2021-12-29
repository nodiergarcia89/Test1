SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================================
-- Author:		Ramon Villanueva
-- Create date: 20/04/2015
-- Description:	Datos de articulos alternativos
-- Generar los registros en la tabla iArticulosLAlt
-- Modificacion: 09/04/2020
--     Se elimina el acceso a la tabla inaArticulosLAlt que almacena valores
--     Fijos para meter los registros en base a consumos.
-- ========================================================================
CREATE PROCEDURE [dbo].[usp_inaArticulosLAlt] AS
BEGIN
	SET NOCOUNT ON;

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	SET LANGUAGE spanish

	-- Borrar tablas de valores fijos
	delete from sym_iArticulosLAlt

/*   Modificacion: 09/04/2020

	-- Cargar tabla de valores fijos
	select distinct t1.* 
		into #tmp_inaArticulosLAlt
		from inaArticulosLAlt t1
				inner join sym_iArticulos t2 -- Articulos traspasados
					on t1.CodEmpresa=t2.codEmpresa
						and t1.CodArticulo=t2.codArticulo
				inner join sym_iArticulos t3 -- Articulos relacionados traspasados
					on t1.CodEmpresa=t3.codEmpresa
						and t1.CodAlternativo=t3.codArticulo
				inner join sym_iArticulosLImg t4 -- Articulos relacionados con imagen
					on t1.CodEmpresa=t4.codEmpresa
						and t1.CodAlternativo=t4.codArticulo
						and t4.flaHayImg=1

	-- Generar articulos cruzados
	SELECT [codEmpresa]
		  ,[codArticulo]
		  ,linArticulosLAlt		  
		  ,[codAlternativo]
		  ,[flaVtaCruzada]
	into #tmp_Tabla1
	  FROM #tmp_inaArticulosLAlt
	UNION ALL
	SELECT t1.[codEmpresa]
		  ,t1.[codAlternativo]
		  ,0
		  ,t1.[codArticulo]
		  ,t1.[flaVtaCruzada]
	  FROM #tmp_inaArticulosLAlt t1
	  inner join sym_iArticulosLImg t4 -- Articulos relacionados con imagen
					on t1.CodEmpresa=t4.codEmpresa
						and t1.CodArticulo=t4.codArticulo
						and t4.flaHayImg=1;
	
	-- Eliminar duplicados
	WITH cte AS (
					SELECT CodEmpresa, CodArticulo, CodAlternativo, flaVtaCruzada,
						row_number() OVER(PARTITION BY CodEmpresa, CodArticulo, CodAlternativo, flaVtaCruzada ORDER BY CodArticulo, CodAlternativo) AS [rn]
					FROM #tmp_Tabla1
				)
	DELETE cte WHERE [rn] > 1
	
	-- Insertar en tabla
	insert into sym_iArticulosLAlt
		select codEmpresa
			,codArticulo
			,ROW_NUMBER() OVER(partition by codempresa, codArticulo order by flaVtaCruzada, linArticulosLAlt) as linArticulosLAlt
			,codAlternativo
			,flaVtaCruzada
		from #tmp_Tabla1
*/ 
	   -- Articulos cruzados. Son los que mas veces se venden juntos en el último año
	   ;WITH Facturas AS
	   (
	   SELECT [Num_Factura]
		    ,CONVERT(NVARCHAR(30),[CodArticulo]) CodArticulo
		FROM [SAP_STG].[dbo].[stgF2FacturasVentasSAP]
		WHERE FechaFactura>=FORMAT(DATEADD(year,-1,GETDATE()),'yyyyMMdd') 
	   )
	   , Grupos AS
	   (
	   SELECT DISTINCT t1.CodArticulo 
		  , t2.CodArticulo CodArticulo_R
		  , 1 Ocurrencia
	   FROM Facturas t1
	   INNER JOIN Facturas t2
	   ON t1.Num_Factura=t2.Num_Factura
		  and t1.CodArticulo<>t2.CodArticulo
	   )
	   , Agrupaciones AS
	   (
	   SELECT CodArticulo
			 , CodArticulo_R
			 , SUM(Ocurrencia) Ocurrencia
			 , ROW_NUMBER() OVER(PARTITION BY CodArticulo ORDER BY SUM(Ocurrencia) DESC) RowNum
	   FROM Grupos
	   GROUP BY CodArticulo
			 , CodArticulo_R
	   )
	   INSERT INTO [dbo].[sym_iArticulosLAlt]
	   SELECT 2 CodEmpresa
			 , t1.CodArticulo
			 , ROW_NUMBER() OVER(PARTITION BY t1.CodArticulo ORDER BY t1.RowNum)  linArticulosLAlt
			 , t1.CodArticulo_R codAlternativo
			 , 1 flaVtaCruzada
	   FROM Agrupaciones t1
	    inner join sym_iArticulosLImg t2 -- Articulos relacionados con imagen
						   on t2.codEmpresa=2
							   and t1.CodArticulo=t2.codArticulo
							   and t2.flaHayImg=1
							   and t2.linImgArt=0
	    inner join sym_iArticulosLImg t3 -- Articulos relacionados con imagen
						   on t3.codEmpresa=2
							   and t1.CodArticulo_R=t3.codArticulo
							   and t3.flaHayImg=1
							   and t3.linImgArt=0
	   WHERE t1.RowNum<11

	   -- Articulos alternativos. Son los que mas se venden de la misma familia/subfamilia en el ultimo año
	   ;WITH Facturas AS
	   (
	   SELECT t1.Num_Factura
		    ,CONVERT(NVARCHAR(30),t1.CodArticulo) CodArticulo
		    ,t2.CodFamilia
		    ,t2.CodSubFamilia
		FROM [stgF2FacturasVentasSAP] t1
		INNER JOIN sym_iArticulos t2
		  on CONVERT(NVARCHAR(30),t1.CodArticulo)=t2.CodArticulo
		WHERE FechaFactura>=FORMAT(DATEADD(year,-1,GETDATE()),'yyyyMMdd') 
	   )
	   , Grupos AS
	   (
	   SELECT t1.CodArticulo 
		  , t2.CodArticulo CodArticulo_R
		  , CONVERT(BIGINT,1) Ocurrencia
	   FROM Facturas t1
	   INNER JOIN Facturas t2
	   ON t1.CodArticulo<>t2.CodArticulo
		  and t1.CodFamilia=t2.CodFamilia
		  and t1.CodSubFamilia=t2.CodSubFamilia
	   )
	   , Agrupaciones AS
	   (
	   SELECT CodArticulo
			 , CodArticulo_R
			 , SUM(Ocurrencia) Ocurrencia
			 , ROW_NUMBER() OVER(PARTITION BY CodArticulo ORDER BY SUM(Ocurrencia) DESC) RowNum
	   FROM Grupos
	   GROUP BY CodArticulo
			 , CodArticulo_R
	   )
	   INSERT INTO [dbo].[sym_iArticulosLAlt]
	   SELECT 2 CodEmpresa
			 , t1.CodArticulo
			 , ROW_NUMBER() OVER(PARTITION BY t1.CodArticulo ORDER BY t1.RowNum) + 100 linArticulosLAlt
			 , t1.CodArticulo_R codAlternativo
			 , 0 flaVtaCruzada
	   FROM Agrupaciones t1
	    inner join sym_iArticulosLImg t2 -- Articulos relacionados con imagen
						   on t2.codEmpresa=2
							   and t1.CodArticulo=t2.codArticulo
							   and t2.flaHayImg=1
							   and t2.linImgArt=0
	    inner join sym_iArticulosLImg t3 -- Articulos relacionados con imagen
						   on t3.codEmpresa=2
							   and t1.CodArticulo_R=t3.codArticulo
							   and t3.flaHayImg=1
							   and t3.linImgArt=0
	   WHERE t1.RowNum<11

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
