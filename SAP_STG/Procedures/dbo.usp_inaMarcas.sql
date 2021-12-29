SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 06/03/2015
-- Description:	Completar Marcas
-- Modificacion: 03/12/2015
--   Ahora los parametros vienen de SAP. ZSD034
-- =============================================
CREATE procedure [dbo].[usp_inaMarcas]
as
begin
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	--insert into inaMarcas
	--select 	MVGR1 as CodMarca
	--		, BEZEI as Marca 
	--		,  '#' + replace(rtrim(BEZEI),' ','_') as Hashtag
	--		, 0 as Ina
	--		, 0 as Folleto
	--		, '' as Logo
	--from TVM1T
	--where MVGR1 collate database_default not in
	--	(select CodMarca from inaMarcas)

	-- Datos de SAP
	MERGE INTO inaMarcas t1
	USING vSAP_Marcas t2
	ON (t1.CodMarca COLLATE DATABASE_DEFAULT=t2.CodMarca)
	WHEN MATCHED
		--AND
		--	(t1.Marca COLLATE DATABASE_DEFAULT != t2.Marca
		--	 OR t1.Hashtag COLLATE DATABASE_DEFAULT != t2.Hashtag
		--	 OR t1.Ina != t2.Ina
		--	 OR t1.Folleto != t2.Folleto
		--	 OR t1.Complementos != t2.Complementos)
		THEN UPDATE
			SET t1.Marca=t2.Marca
				, t1.Hashtag=t2.Hashtag
				, t1.Ina=t2.Ina
				, t1.Folleto=t2.Folleto
				, t1.Complementos=t2.Complementos
    WHEN NOT MATCHED BY TARGET
    THEN INSERT				
	   (
		CodMarca,
		Marca,
		Hashtag,
		Ina,
		Folleto,
		Complementos,
		Logo
		)
		VALUES
		(
		t2.CodMarca,
		t2.Marca,
		t2.Hashtag,
		t2.Ina,
		t2.Folleto,
		t2.Complementos,
		NULL
		);
		  
	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
end

GO
