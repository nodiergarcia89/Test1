SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =================================================================================================
-- Author:		Ramon Villanueva
-- Create date: 10/01/2015
-- Description:	Completar Agentes
-- De momento, hasta el deploy completo se mantiene a mano, luego lo cogere del campo Tablet
-- Modificacion: 22/05/2015
--    Tener en cuenta las actualizaciones desde SAP
-- Modificacion: 26/05/2015
--    Cojo el catalogo de la delegacion y no del codigo de delegacion
--    Uso el min para que funcione en el caso de un catalogo por delegacion o uno general
-- Modificacion: 14/10/2015
--   Incluir el campo Race.
-- Modificacion 09/09/2020
--   Un catalogo general para cada Race que reemplazara al
--   catalogo general 2100.
-- Prueba
-- =================================================================================================
CREATE procedure [dbo].[usp_inaAgentes]
as

BEGIN
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************
	-- Altas
	insert into inaAgentes
	SELECT	  2 CodEmpresa
			, t1.CodVendedor CodAgente
			, iif(isnumeric(t1.Telefono)=1
				    --,concat(t1.NombreCompleto, CHAR(13)+CHAR(10),' (',rtrim(t1.Telefono),')') 
				    ,concat(t1.NombreCompleto, ' (',rtrim(t1.Telefono),')') 
				    , t1.NombreCompleto) Nombre
			, t1.Promotor
			, t1.ATC
			, t1.Delegado
			, t1.AreaManager
			, t1.Central
			, t1.RACE
			, case 
				when t1.AreaManager=1 or t1.Central=1 then '2100'
				else 
					(select min(convert(int,CodCatalogo))
					from inaCatalogosDelegacion 
					where CodEmpresa=2
						  and CodDelegacion=t1.CodDelegacion) 
			  end CodCatalogo
			, 0 Ina -- De momento, hasta el deploy completo se mantiene a mano, luego lo cogere del campo Tablet
			, t1.Tablet
			, 0 
	from	stgF2Vendedores t1
	where --(t1.atc=1 or t1.Promotor=1) -- Faltan Delegado/Area Manager/DirCentral 
		 t1.CodVendedor not in
			(select CodAgente from inaAgentes where CodEmpresa=2)

	-- Desactivar bajas. Los agentes de baja no llevan tablet.
	update inaAgentes
	set Ina=0
	where codAgente in (select CodVendedor from vstgF2Vendedores where Baja='S')

	-- Modificaciones en SAP y en parametros de catalogo
	UPDATE inaAgentes
		SET Nombre = iif(isnumeric(Telefono)=1
				    --,concat(NombreCompleto, CHAR(13)+CHAR(10),' (',rtrim(Telefono),')') 
				    ,concat(NombreCompleto, ' (',rtrim(Telefono),')') 
				    , NombreCompleto)
			, Promotor = t2.Promotor
			, ATC = t2.ATC
			, Delegado = t2.Delegado
			, AreaManager = t2.AreaManager
			, DirCentral = t2.Central
			, Race = t2.RACE
			, Tablet = t2.Tablet
			, CodCatalogo=(case when t2.AreaManager=1 or t2.Central=1 then '2100'
							WHEN t2.RACE =1 THEN 2000 + t2.CodVendedor
							else (select min(convert(int,CodCatalogo))
									from inaCatalogosDelegacion 
									where CodEmpresa=2
									and CodDelegacion=t2.CodDelegacion) 
						   end) 
	FROM inaAgentes INNER JOIN
		 stgF2Vendedores AS t2 
			ON	inaAgentes.CodEmpresa = 2 
				AND inaAgentes.CodAgente = t2.CodVendedor

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
