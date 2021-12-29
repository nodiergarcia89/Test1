SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- =================================================================
-- Author:		Ramon Villanueva
-- Create date: 28/07/2015
-- Description:	Traspaso tablas inaCatalog. iArticulosLMultimedia
--				Articulos
-- =================================================================
CREATE PROCEDURE [dbo].[usp_inaArtLMult1] AS
BEGIN
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************
		-- Declarar variables
		declare @CodEmpresa int
		declare @ID int
		declare @CodFamilia int
		declare @CodSubFamilia int
		declare @CodTipoArticulo nvarchar(20)
		declare @CodMarca char(3)
		declare @CodArticulo nvarchar(30)
		declare @MaxLin int
		declare @SQL nvarchar(MAX)
	     DECLARE @CarpetaUsuarios NVARCHAR(100)
	     DECLARE @CarpetaMultimedia NVARCHAR(100)

		
		-- Tabla de salida
		create table #tmp_Tabla2
			(CodEmpresa int
			 ,ID  int 
			 ,CodArticulo nvarchar(30)
			 ,CodFamilia int
			 ,CodSubFamilia int
			 ,CodTipoArticulo nvarchar(30)
			 ,CodMarca char(3)
			 )

		
		-- Todos los articulos que se envian a los iPads
		SELECT distinct t1.CodEmpresa
				, 0 ID
				, convert(nvarchar(30),t1.CodArticulo) CodArticulo
				, t2.CodFamilia
				, t2.CodSubFamilia
				, t2.CodTipoArticulo
				, t1.CodMarca
		INTO #tmp_Tabla1
		FROM    stgF2ArticulosSAP AS t1 
				INNER JOIN sym_iArticulos AS t2 
					ON	t1.CodEmpresa = t2.CodEmpresa
						AND convert(nvarchar(30),t1.CodArticulo) = t2.CodArticulo 
				INNER JOIN sym_iArticulos AS t3
					ON	t1.CodEmpresa=t3.codEmpresa
						AND convert(nvarchar(30),t1.CodArticulo) = t3.CodArticulo 
		
		-- Recorrer tabla de parametros
		declare c cursor for
			SELECT CodEmpresa, ID, CodFamilia
					,CodSubFamilia, CodTipoArticulo, CodMarca, CodArticulo
		  FROM inaArticulosLMultimedia

		-- Bucle para cada registro
		open c
			fetch c into  @CodEmpresa, @ID, @CodFamilia
					,@CodSubFamilia, @CodTipoArticulo, @CodMarca, @CodArticulo

		while (@@FETCH_STATUS=0)
		begin
			-- Determinar la seleccion de registros
			SELECT @SQL='WHERE '

			select @SQL=rtrim(@SQL) + ' CodEmpresa=' + rtrim(convert(char,@CodEmpresa)) -- La empresa es obligatoria
			if @CodFamilia <> 0
				select @SQL=rtrim(@SQL) + ' and CodFamilia=' + rtrim(convert(char,@CodFamilia))
			if @CodSubFamilia<>0
				select @SQL=rtrim(@SQL) + ' and CodSubFamilia=' + rtrim(convert(char,@CodSubFamilia))
			if @CodTipoArticulo<>''
				select @SQL=rtrim(@SQL) + ' and CodTipoArticulo=' + '''' + rtrim(@CodTipoArticulo) + ''''
			if @CodMarca<>''
				select @SQL=rtrim(@SQL) + ' and CodMarca=' + '''' + rtrim(@CodMarca) + ''''
			
			-- Insertar registros en tabla
			select @SQL='INSERT INTO #tmp_Tabla2 SELECT CodEmpresa,' +  convert(char,@ID) 
							+ ', CodArticulo, CodFamilia, CodSubFamilia, CodTipoArticulo, CodMarca FROM #tmp_Tabla1 ' 
							+ rtrim(@SQL)
	
			exec (@SQL)
			
			-- Siguiente registro
			fetch c into  @CodEmpresa, @ID, @CodFamilia
					,@CodSubFamilia, @CodTipoArticulo, @CodMarca, @CodArticulo
		end

		-- Cierre del cursor
		CLOSE c
		-- Liberar los recursos
		DEALLOCATE c

		-- Recuperar datos y aplicar las sustituciones
		INSERT INTO sym_iArticulosLMultimedia
			(codEmpresa, codArticulo, linMultimedia, hipMultimedia, desMultimedia, flaModificado)
		SELECT  t1.CodEmpresa
				, t1.CodArticulo
				, ROW_NUMBER() OVER(PARTITION BY t1.CodEmpresa, t1.CodArticulo ORDER BY t2.ID)
				, replace(
					replace(
						replace(
							replace(
								replace(t2.hipMultimedia, '%Articulo%', t1.CodArticulo)
								, '%Familia%', t1.CodFamilia)
							, '%SubFamilia%', t1.CodSubFamilia)
						,'%TipoArticulo%',t1.CodTipoArticulo) 
					, '%Marca%', t1.CodMarca) hipMultimedia
				, t2.desMultimedia
				, t2.BajoDemanda 
		FROM    #tmp_Tabla2 AS t1 
				INNER JOIN inaArticulosLMultimedia AS t2
					ON	t1.ID = t2.ID

	   -- Borrar registros previos de Fichas Tecnicas
	   SELECT @CarpetaUsuarios='D:\Catalogo\Imagenes\Multimedia'
	   SELECT @CarpetaMultimedia='D:\Catalogo\Multimedia'

	   DELETE FROM inaArticulosMultimediaFijo
	   WHERE       
		    hipMultimedia LIKE 'FT%.PDF'
		    OR hipMultimedia LIKE 'FT%.JPG'

	   -- Insertarlos en la tabla de valores La maquinaria NO
	   SET IDENTITY_INSERT inaArticulosMultimediaFijo ON;
	   WITH Archivos
		   AS (SELECT 
				    SUBSTRING(name, 3, IIF(PATINDEX('%[_]%', name) = 0, PATINDEX('%.%', name), PATINDEX('%[_]%', name)) - 3) AS CodArticulo
				  , name AS                                                                                                     hipMultimedia
				  , 'Ficha Tecnica Proveedor' AS                                                                                desMultimedia
				  , 1 AS                                                                                                        BajoDemanda
			  FROM   dbo.Dir(@CarpetaMultimedia) 
			  WHERE  name LIKE 'FT%.PDF'
				    OR name LIKE 'FT%.JPG'),
		   Datos
		   AS (SELECT 
				    CodArticulo
				  , ROW_NUMBER() OVER(PARTITION BY CodArticulo
				    ORDER BY 
						   hipMultimedia) AS ID
				  , hipMultimedia
				  , desMultimedia
				  , BajoDemanda
			  FROM   Archivos)
		   -- Insertar los registros
		   INSERT INTO inaArticulosMultimediaFijo
				(
				CodArticulo
			   , ID
			   , hipMultimedia
			   , desMultimedia
			   , BajoDemanda
				)
		   SELECT 
				t1.CodArticulo
			   , t1.ID
			   , t1.hipMultimedia
			   , t1.desMultimedia + IIF(t1.ID > 1, CONCAT(' (', t1.ID - 1, ')'), '') AS desMultimedia
			   , t1.BajoDemanda
		   FROM   Datos t1
		   INNER JOIN sym_iArticulos t2
			 ON t2.CodEmpresa=2
				AND t1.CodArticulo=t2.CodArticulo
		   WHERE t2.CodFamilia<>3
	   SET IDENTITY_INSERT inaArticulosMultimediaFijo OFF

	   -- Copiarlos a la carpeta Multimedia
	   -- Primero los PDFs
	  -- SELECT 
			--@sql='exec master..xp_cmdshell ' + CHAR(39) + 'xcopy ' + CHAR(34) + @CarpetaUsuarios + '\*.PDF' + CHAR(34) +' ' + @CarpetaMultimedia + ' /D /Y' + CHAR(39)
	  -- FROM   inaArticulosMultimediaFijo AS t1
			--INNER JOIN vIna_iArticulos AS t2
			--  ON t2.CodEmpresa = 2
			--	AND t1.CodArticulo = t2.CodArticulo
	  -- WHERE  hipMultimedia LIKE 'FT%.pdf'

	  -- EXEC sp_executesql @sql

	  -- -- Ahora los JPGs
	  -- SELECT 
			--@sql='exec master..xp_cmdshell ' + CHAR(39) + 'xcopy ' + CHAR(34) + @CarpetaUsuarios + '\*.JPG' + CHAR(34) +' ' + @CarpetaMultimedia + ' /D /Y' + CHAR(39) 
	  -- FROM   inaArticulosMultimediaFijo AS t1
			--INNER JOIN vIna_iArticulos AS t2
			--  ON t2.CodEmpresa = 2
			--	AND t1.CodArticulo = t2.CodArticulo
	  -- WHERE  hipMultimedia LIKE 'FT%.JPG'

	  -- EXEC sp_executesql @sql

		-- Obtener el maximo de linMultimedia
		select @MaxLin=coalesce(max(linMultimedia),0) from sym_iArticulosLMultimedia
		
		-- Insertar los datos fijos de articulos traspasados
		INSERT INTO sym_iArticulosLMultimedia
			(codEmpresa, codArticulo, linMultimedia, hipMultimedia, desMultimedia, flaModificado)
		SELECT	2 CodEmpresa
				, t1.CodArticulo
				, @MaxLin + ID
				, t1.hipMultimedia
				, coalesce(t1.desMultimedia,'Ficha Técnica') desMultimedia
				, t1.BajoDemanda flaModificado
		FROM inaArticulosMultimediaFijo t1
		INNER JOIN vIna_iArticulos AS t2 
			ON	t2.CodEmpresa=2
				AND t1.CodArticulo = t2.CodArticulo 

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END





GO
