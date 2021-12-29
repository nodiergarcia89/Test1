SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 07/01/2015
-- Description:	Cargar Imagenes
-- Pagina 30
-- =============================================
CREATE procedure [dbo].[usp_inaCargaImagenes]
AS
BEGIN

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	-- Borrar tabla de imagenes
	delete from sym_iArticulosLImg

	DECLARE @Path   varchar(50)
			,@Wildcard varchar(10)
			,@Cmd varchar(150)

	-- Directorio donde buscar las imagenes
	SET @Path='D:\Catalogo\Imagenes'

	-- Separador que usamos para imagenes alternativas
	SET @Wildcard ='*.jpg'

	-- Creamos tabla temporal 
	IF EXISTS (SELECT 1
			   FROM INFORMATION_SCHEMA.TABLES
			   WHERE TABLE_TYPE='BASE TABLE'
			   AND TABLE_NAME='#tmpBuscaFiles')
					drop table #tmpBuscaFiles
					CREATE TABLE #tmpBuscaFiles(id int Identity, line varchar(255))            

	-- Busqueda de Archivos
	SET @Cmd = 'DIR "' + @Path + CASE WHEN RIGHT(@Path, 1) = '\' THEN ''
	ELSE '\' END + @WildCard + '" /B /S '

	-- Insertamos dentro de la tabla temporal el resultado
	INSERT INTO #tmpBuscaFiles
	EXEC master..xp_CmdShell @Cmd 

	-- Limpiamos ruta base
	update #tmpBuscaFiles set line=replace(line,'D:\Catalogo\Imagenes\','')
	update #tmpBuscaFiles set line=replace(line,'.jpg','')

	-- Lista de imagenes
	select id, line
			, case 
				when charindex('_',line)>0
					then  left(line,charindex('_',line)-1) 
				else
					line
				end as CodArticulo
				, ROW_NUMBER() over (partition by case 
				when charindex('_',line)>0
					then  left(line,charindex('_',line)-1) 
				else
					line
				end order by case 
				when charindex('_',line)>0
					then  left(line,charindex('_',line)-1) 
				else
					line
				end) as Imagen
	INTO #tmp_Tabla1
	from #tmpBuscaFiles 

	-- Insertar en tabla
	insert into sym_iArticulosLImg
	select 2 CodEmpresa
		, t1.codarticulo CodArticulo
		, coalesce(t2.Imagen-1,0) linImgArt
		, 0 sliImgArt
		, coalesce(t2.line,t1.CodArticulo) nomImagenArt
		, 0 flaImgModificada
		, case 
			when t2.CodArticulo is null then 0
			else 1
		  end flaHayImg
	from sym_iArticulos  t1
	left outer join #tmp_Tabla1 t2
		on t1.CodEmpresa=2
		and t1.codArticulo=t2.CodArticulo

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************

END
GO
