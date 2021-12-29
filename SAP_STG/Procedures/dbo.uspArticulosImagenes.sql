SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 28/01/15
-- Description:	Articulos e Imagenes
--test
-- =============================================
CREATE PROCEDURE [dbo].[uspArticulosImagenes] AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	-- Imagenes para articulos
	select 
		  t1.codCatalogo
	     , t4.desCatalogo
		, t1.codFamilia
		, t1.codSubFamilia
		, t3.desFamilia
		, t1.CodArticulo
		, t1.desArticulo
		, coalesce(t2.nomImagenArt + '.jpg','N/A') as Imagen
		, case t2.flaHayImg when 1 then 'S' else 'N' end HayImagen
		, row_number() over (order by t1.CodArticulo) RecordCount
	from sym_iArticulos  t1
	left outer join sym_iArticulosLImg t2
		on t1.CodEmpresa=2
		and t1.codArticulo=t2.CodArticulo
	inner join sym_iFamilias t3
		on t1.codFamilia=t3.codFamilia
			and t1.codSubFamilia=t3.codSubFamilia
			and t3.codEmpresa=2
			and t3.codCatalogo=2100
     inner join dbo.sym_iCatalogos t4
	    on t1.codEmpresa=t4.codEmpresa
		  and t1.codCatalogo=t4.codCatalogo
	order by t3.codFamilia, t3.codSubFamilia, t1.codArticulo

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END

GO
