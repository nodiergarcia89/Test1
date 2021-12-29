SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 26/12/2014
-- Description:	Completar Grupos de Clientes
-- =============================================
CREATE procedure [dbo].[usp_inaGruposClientes]
as
begin
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	insert into inaGruposClientes
	select distinct
		codgrupoclientes
		, grupoclientes
		, 0
	from stgF3Clientes
	where Codgrupoclientes not in
		(select CodGrupoClientes from inagruposclientes)

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
end
GO
