SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 18/12/2015
-- Description:	Reporte semanal Visitas usuario
-- =============================================
CREATE PROCEDURE [dbo].[uspReporteSemanalVisitasUsuario]
	@Usuario int=483
	,@Semana int=37
	,@Año int=2020
AS
BEGIN
	
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************
		
	-- Por defecto el año actual
	if @Año=0
		select @Año=datepart(year,getdate())
	
	-- Variables de actividad
	declare @FechaUltActividad datetime
	declare @DiasDif int

	-- Recuperar valores de actividad
	select top 1
		  @FechaUltActividad=fecActividad
		, @DiasDif=DATEDIFF(d,FecActividad,getdate()) 
	from vActividad
	where codEmpresa=2 
		and nomIPad='ipad' + convert(char,@Usuario)
	order by fecActividad desc

	-- Devolver datos
	SELECT t1.Clave
		,t1.codAgente
      ,t1.UserName
      ,'file://SVVM04/ImgIna$/' + rtrim(convert(char,t1.CodAgente)) + '.jpg' as FotoUsuario
      ,t1.NombreCompleto
	  ,t1.Delegacion
      ,t1.Reporte
      ,t1.FechaVisita
      ,t1.Fecha
      ,t1.Fecha_key
      ,t1.Hora
      ,t1.HoraDia
      ,t1.Año
      ,t1.EsMesActual
      ,t1.Semana
      ,t1.DiaSemana
      ,t1.DiaSemanaTxt
      ,t1.Dia
      ,t1.Fotos
      ,t1.CodCliente
      ,t1.Cliente
	  ,ROW_NUMBER() OVER(PARTITION BY t1.CodCliente ORDER BY t1.CodCliente, t1.FechaVisita) NumVisitasClte
      ,t1.Provincia
      ,t1.Poblacion
	  ,coalesce(t2.KilosSemana,coalesce(t3.KilosSemana,'N/A') ,'N/A') KilosSemana
	  ,coalesce(t2.KilosAño,coalesce(t3.KilosAño,'N/A') ,'N/A') KilosAño
	  ,coalesce(t2.ProveedorActual,coalesce(t3.ProveedorActual,'N/A') ,'N/A') ProveedorActual
	  ,coalesce(t2.ContratoVigente,coalesce(t3.ContratoVigente,'N/A') ,'N/A') ContratoVigente
	  ,t1.Planificada
      ,t1.PlanSigVisita
      ,t1.FecSigVisita
      ,t1.CodTipoVisita
      ,t1.TipoVisita
      ,t1.Accion
      ,t1.Observaciones
	  ,@FechaUltActividad FechaUltActividad
	  ,@DiasDif DiasDif
      ,t1.DatosActualizados
  FROM stgF3AnalisisVisitas t1
  LEFT OUTER JOIN stgClientesPotencialesRep t2
	on convert(varchar,t1.CodCliente)=convert(varchar,t2.codCliente)
  LEFT OUTER JOIN stgClientesPotencialesHIRep t3
	on convert(varchar,t1.CodCliente)=convert(varchar,t3.codCliente)
where t1.codAgente=@Usuario
	and t1.Año=@Año
	and t1.Semana=@Semana
	
	
	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************


END
GO
