SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 26/12/2014
-- Description:	Completar Delegaciones
-- =============================================
CREATE procedure [dbo].[usp_inaDelegaciones]
as
begin
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	insert into inaDelegaciones
	select 
		coddelegacion
		, delegacion
		, 0
		, null
		, null
		, null
		, null
		, CodDelegacion
	from vstgF2Delegaciones
	where CodDelegacion not in
		(select CodDelegacion from inaDelegaciones)

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
end

GO
