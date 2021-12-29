SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 22/07/2015
-- Description:	Analisis Visitas usuario
-- Ejecutar consulta según tipo de usuario
--		1: Central
--		2: Area Manager
--		3: Delegado
--		4: ATC
--		5: Promotor
--		6: Autoventa
--		7: Almacenero
--		8: Vending
--		9: RACE
--		10: SAT
-- =============================================
CREATE PROCEDURE [dbo].[uspVisitasUsuario]
	@Usuario int
AS
BEGIN
	
	-- Declarar variables
	declare @TipoUsuario int
	declare @CodEmpresa int=2
	declare @FechaDesde int

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	-- Recuperar el tipo de usuario mediante llamada a funcion
	select @TipoUsuario=dbo.ufGetTipoUsuario(@CodEmpresa, @Usuario)

	-- Recuperar la fecha desde para los datos (5 semanas atras)
	select @FechaDesde=CONVERT (varchar( 8), dateadd(wk,-5,getdate()), 112 )

	if @TipoUsuario=1
		-- Datos de Central
		select Año
				, Semana
				, SemanaTxt
				, CodAreaManager CodElemento
				, AreaManager Elemento
				, CodTipoVisita
				, TipoVisita
				, count(Clave) NumVisitas 
		from stgF3AnalisisVisitas
		where CodAreaManager<>0
			and Fecha_key>=@FechaDesde
		group by Año
				, Semana
				, SemanaTxt
				, CodAreaManager
				, AreaManager
				, CodTipoVisita
				, TipoVisita

	if @TipoUsuario=2
		-- Datos de Area Manager
		select Año
				, Semana
				, SemanaTxt
				, CodDelegacion CodElemento
				, Delegacion Elemento
				, CodTipoVisita
				, TipoVisita
				, count(Clave) NumVisitas 
		from stgF3AnalisisVisitas
		where CodAreaManager=@Usuario
			and Fecha_key>=@FechaDesde
		group by Año
				, Semana
				, SemanaTxt
				, CodDelegacion
				, Delegacion
				, CodTipoVisita
				, TipoVisita

	if @TipoUsuario=3
		-- Datos de Delegado
		select Año
				, Semana
				, SemanaTxt
				, CodAgente CodElemento
				, NombreCompleto Elemento
				, CodTipoVisita
				, TipoVisita
				, count(Clave) NumVisitas 
		from stgF3AnalisisVisitas
		where CodDelegado=@Usuario
			and Fecha_key>=@FechaDesde
		group by Año
				, Semana
				, SemanaTxt
				, codAgente
				, NombreCompleto
				, CodTipoVisita
				, TipoVisita

				--, dbo.ufGetATC(2, codAgente) CodATC
				--, 'TODOS' ATC

	if @TipoUsuario=4
		-- Datos de ATC
		select Año
				, Semana
				, SemanaTxt
				, codAgente CodElemento
				, NombreCompleto Elemento
				, CodTipoVisita
				, TipoVisita
				, count(Clave) NumVisitas 
		from stgF3AnalisisVisitas
		where dbo.ufGetATC(@CodEmpresa, codAgente)=@Usuario
			and Fecha_key>=@FechaDesde
		group by Año
				, Semana
				, SemanaTxt
				, codAgente
				, NombreCompleto
				, CodTipoVisita
				, TipoVisita

	if @TipoUsuario=5
		-- Datos de Promotor
		select Año
				, Semana
				, SemanaTxt
				, codAgente CodElemento
				, NombreCompleto Elemento
				, CodTipoVisita
				, TipoVisita
				, count(Clave) NumVisitas 
		from stgF3AnalisisVisitas
		where codAgente=@Usuario
			and Fecha_key>=@FechaDesde
		group by Año
				, Semana
				, SemanaTxt
				, codAgente
				, NombreCompleto
				, CodTipoVisita
				, TipoVisita

	if @TipoUsuario=9
		-- Datos de RACE
		select Año
				, Semana
				, SemanaTxt
				, codAgente CodElemento
				, NombreCompleto Elemento
				, CodTipoVisita
				, TipoVisita
				, count(Clave) NumVisitas 
		from stgF3AnalisisVisitas
		where codAgente=@Usuario
			and Fecha_key>=@FechaDesde
		group by Año
				, Semana
				, SemanaTxt
				, codAgente
				, NombreCompleto
				, CodTipoVisita
				, TipoVisita

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
