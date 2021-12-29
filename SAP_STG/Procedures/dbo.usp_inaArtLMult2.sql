SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


-- =================================================================
-- Author:		Ramon Villanueva
-- Create date: 28/07/2015
-- Description:	Traspaso tablas inaCatalog. iArticulosLMultimedia
--				Agentes como articulos
-- Modificacion: 11/11/15
--   Controlar los races
-- Modificacion: 16/11/15
--   Controlar los de central
-- Modificacion: 17/11/15
-- Tratar procesos habilitados o no y exclusiones
-- =================================================================
CREATE PROCEDURE [dbo].[usp_inaArtLMult2] AS
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
		declare @CodAreaManager int
		declare @CodDelegacion smallint
		declare @CodAgente int
		declare @Race bit
		declare @DirCentral bit
		declare @MaxLin int
		declare @SQL char(2000)
		
		-- Tabla de salida
		create table #tmp_Tabla2
			(CodEmpresa int
			 ,ID  int 
			 ,CodAreaManager int
			 ,CodDelegacion smallint
			 ,CodAgente int
			 ,Race bit
			 ,DirCentral bit
			 )

		
		-- Todos los articulos que se envian a los iPads
		SELECT distinct t1.CodEmpresa
				, 0 ID
				, t3.CodAreaManager
				, t2.CodDelegacion
				, t1.CodAgente
				, t1.Race
				, t1.DirCentral
		INTO #tmp_Tabla1
		FROM    inaAgentes AS t1 
				INNER JOIN stgF2Vendedores AS t2 
					ON	t1.CodEmpresa = t2.CodEmpresa
						AND t1.CodAgente = t2.CodVendedor
				INNER JOIN inaDelegaciones as t3
					ON t3.CodDelegacion=t2.CodDelegacion
						and t2.CodEmpresa=2
		WHERE t1.Ina=1 -- Agentes con tablet
			and t1.CodAgente<>53 -- el mio no
		
		-- Recorrer tabla de parametros
		declare c cursor for
			SELECT CodEmpresa, ID, CodAreaManager, CodDelegacion, CodAgente, Race, DirCentral
		  FROM inaArticulosLMultimediaAgente
		where Tratar=1

		-- Bucle para cada registro
		open c
			fetch c into  @CodEmpresa, @ID, @CodAreaManager, @CodDelegacion, @CodAgente, @Race, @DirCentral

		while (@@FETCH_STATUS=0)
		begin
			-- Determinar la seleccion de registros
			SELECT @SQL='WHERE '

			select @SQL=rtrim(@SQL) + ' CodEmpresa=' + rtrim(convert(char,@CodEmpresa)) -- La empresa es obligatoria
			if @CodAreaManager <> 0
				select @SQL=rtrim(@SQL) + ' and (CodAreaManager=' + rtrim(convert(char,@CodAreaManager)) + ' or CodAgente=' + rtrim(convert(char,@CodAreaManager)) + ')'
			if @CodDelegacion <> 0
				select @SQL=rtrim(@SQL) + ' and CodDelegacion=' + rtrim(convert(char,@CodDelegacion))
			if @CodAgente<>0
				select @SQL=rtrim(@SQL) + ' and CodAgente=' + rtrim(convert(char,@CodAgente))
			if @Race=1
				select @SQL=rtrim(@SQL) + ' and Race=1'
			if @Race=0
				select @SQL=rtrim(@SQL) + ' and Race=0'
			if @DirCentral=1
				select @SQL=rtrim(@SQL) + ' and DirCentral=1'
			if @DirCentral=0
				select @SQL=rtrim(@SQL) + ' and DirCentral=0'

			
			-- Insertar registros en tabla
			select @SQL='INSERT INTO #tmp_Tabla2 SELECT CodEmpresa,' +  convert(char,@ID) 
							+ ', CodAreaManager, CodDelegacion, CodAgente, Race, DirCentral FROM #tmp_Tabla1 ' 
							+ rtrim(@SQL)
	
			exec (@SQL)
			
			-- Siguiente registro
			fetch c into  @CodEmpresa, @ID, @CodAreaManager, @CodDelegacion, @CodAgente, @Race, @DirCentral
		end

		-- Cierre del cursor
		CLOSE c
		-- Liberar los recursos
		DEALLOCATE c

		select @MaxLin=coalesce(max(linMultimedia),0) from sym_iArticulosLMultimedia


		-- Recuperar datos y aplicar las sustituciones
		INSERT INTO sym_iArticulosLMultimedia
			(codEmpresa, codArticulo, linMultimedia, hipMultimedia, desMultimedia, flaModificado)
		SELECT  t1.CodEmpresa
				, convert(nvarchar(30),t1.CodAgente)
				, ROW_NUMBER() OVER(PARTITION BY t1.CodEmpresa, t1.CodAgente ORDER BY t2.ID) + @MaxLin
				, replace(
					 replace(
						replace(t2.hipMultimedia, '%Agente%', t1.CodAgente)
						, '%AreaManager%', t1.CodAreaManager) 
				, '%Delegacion%', t1.CodDelegacion) hipMultimedia
				, t2.desMultimedia
				, t2.BajoDemanda flaModificado -- A 1 me aseguro que el elemento multimedia se suba siempre
		FROM    #tmp_Tabla2 AS t1 
				INNER JOIN inaArticulosLMultimediaAgente AS t2
					ON	t1.ID = t2.ID
		
		-- Tratar las exclusiones
		DELETE FROM sym_iArticulosLMultimedia
		FROM  sym_iArticulosLMultimedia
			  INNER JOIN inaArticulosLMultimediaAgenteExclusion AS t2 
				ON sym_iArticulosLMultimedia.codEmpresa = t2.CodEmpresa 
					AND sym_iArticulosLMultimedia.codArticulo = convert(nvarchar(30),t2.CodAgente)
					AND sym_iArticulosLMultimedia.hipMultimedia = t2.hipMultimedia

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END





GO
