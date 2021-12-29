SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 13/10/2015
-- Description:	Carga Reportes de Visita
-- =============================================
CREATE PROCEDURE [dbo].[uspCargaReportesVisita]  AS
BEGIN
	SET NOCOUNT ON;	
	

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************	
	-- Borrar datos
	truncate table stgF3AnalisisVisitas
	truncate table stgClientesPotencialesRep
	truncate table stgClientesPotencialesHIRep

	-- Llenar datos
	insert into stgF3AnalisisVisitas
	select 2,*, getdate()
	from vstgF3AnalisisVisitas

	-- Tablas de Reportes potenciales sólo el ultimo reporte por cliente
	insert into stgClientesPotencialesRep
	select * from
	(
	 select *
			, ROW_NUMBER() OVER(partition by CodEmpresa,CodCliente order by fecReporte desc) RowId
	 from [v_ClientesPotencialesRep]
	) tt
	where RowId=1

	-- Recodificar los reportes para los clientes que han pasado de potenciales a reales
	update stgClientesPotencialesRep
	set CodCliente=t3.CodCliente
	from stgClientesPotencialesRep t1
	inner join stgF3Clientes t2
		on t1.CodEmpresa=t2.CodEmpresa
			and t1.CodCliente=t2.CodCliente
	inner join stgF3Clientes t3
		on  t2.NumeroCliente<>'N/A'
			and t2.CodEmpresa=t3.CodEmpresa
			and ISNUMERIC(t2.NumeroCliente)=1
			and t2.NumeroCliente<>t3.CodCliente
			and t2.NumeroCliente=t3.CodRespPago
	where t2.NumeroCliente<>'N/A'


	insert 	into stgClientesPotencialesHIRep
	select * from
	(
	 select *
			, ROW_NUMBER() OVER(partition by CodEmpresa,CodCliente order by fecReporte desc) RowId
	 from [v_ClientesPotencialesHIRep]
	) tt
	where RowId=1

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
