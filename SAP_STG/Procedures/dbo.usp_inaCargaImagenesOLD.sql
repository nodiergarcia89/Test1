SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 07/01/2015
-- Description:	Cargar Imagenes
-- Pagina 30
-- =============================================
CREATE procedure [dbo].[usp_inaCargaImagenesOLD]
AS
BEGIN

-- Borrar tabla de imagenes
delete from inaSAM.dbo.iArticulosLImg

-- IMAGENES ALTERNATIVAS
-- Declaramos variables

DECLARE @Path   varchar(50)
		,@Wildcard varchar(10)
		,@Cmd varchar(150)

-- Directorio donde buscar las imagenes
SET @Path='D:\Catalogo\Imagenes'

-- Separador que usamos para imagenes alternativas
SET @Wildcard ='*_*.jpg'

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

insert into inaSAM.dbo.iArticulosLImg
select 2, codarticulo,Imagen, 0, nomimagen, 0, 1 from (
	select distinct A.codArticulo,isnull(B.line,replace(A.codArticulo,'-','')) nomimagen, ROW_NUMBER() over (partition by codarticulo order by codarticulo) as Imagen
	from inaSAM.dbo.iArticulos A left outer join #tmpBuscaFiles B
	on replace(A.codArticulo,'-','') collate SQL_Latin1_General_CP1_CI_AS=left(B.line,charindex('_',B.line)-1) where B.line like '%_%'
) tabla 

drop table #tmpBuscaFiles

insert into inaSAM.dbo.iArticulosLImg (codEmpresa, codArticulo, linImgArt, sliImgArt, nomImagenArt)
select codEmpresa, codArticulo,0 ,0 , replace(replace(replace(codArticulo,'/',''),'ç',''),'ñ','') collate modern_spanish_ci_as from inaSAM.dbo.iArticulos 

--insert into inaSAM.dbo.iArticulosLImg (codempresa, codArticulo, linImgArt, sliImgArt, nomimagenArt)
--select codEmpresa, codArticulo,0 ,0 , codmodelotyc+'.'+codcolor from inaSAM.dbo.iArticulosTYC

END
GO
