SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ========================================================================
-- Author:		Ramon Villanueva
-- Create date: 01/04/2015
-- Description:	Datos de maquinaria a Report InaCatalog
-- En la tabla de iReportes aparecen tambien los que se hacen desde los
-- dispositivos, por lo que al usarlos aqui hay que tener cuidado con no
-- borrar los registros que no correspondan.
-- ========================================================================
CREATE PROCEDURE [dbo].[usp_inaDatosMaquinaria] AS
BEGIN
	SET NOCOUNT ON;

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	SET LANGUAGE spanish

	-- Declarar variables
	declare @codPlantillaReportes int=109 -- Es la plantilla para datos de maquinaria

	declare
		@CodEmpresa int=2 ,
		@CodArticulo nvarchar(20),
		@Articulo nvarchar(100),
		@Fabricante nvarchar(100),
		@Modelo   nvarchar(100),
		@PrecioII nvarchar(100),
		@PrecioSI  nvarchar(100),
		@PVP		nvarchar(100),
		@NGrupos nvarchar(100),
		@NSalidasVapor nvarchar(100),
		@NSalidasAgua nvarchar(100),
		@CapacidadCaldera nvarchar(100),
		@Resistencia nvarchar(100),
		@Voltaje nvarchar(100),
		@Peso nvarchar(100),
		@Anchura nvarchar(100),
		@Altura nvarchar(100),
		@Profundidad nvarchar(100)

	-- Con un cursor recorro los registros a tratar de la tabla inaDatosMaquinaria
	-- de los articulos que se traspasan
	declare c cursor for
		SELECT	t1.CodEmpresa
		, t1.CodArticulo
		, t2.desArticulo
		, t1.Fabricante
		, t1.Modelo
		, t1.PrecioIIBTB
		, t1.PrecioSIBTB
		--, t1.PrecioIIDist
		--, t1.PrecioSIDist
		, t1.PVP
		, t1.NGrupos
		, t1.NSalidasVapor
		, t1.NSalidasAgua
		, t1.CapacidadCaldera
		, t1.Resistencia
		, t1.Voltaje
		, t1.Peso
		, t1.Anchura
		, t1.Altura
		, t1.Profundidad
FROM    inaDatosMaquinaria AS t1 
		INNER JOIN sym_iArticulos AS t2 
			ON	t1.CodEmpresa = t2.codEmpresa 
				AND t1.CodArticulo = t2.codArticulo

	-- Bucle para cada Articulo
	open c
	fetch c into	@CodEmpresa,
					@CodArticulo,
					@Articulo,
					@Fabricante,
					@Modelo,
					@PrecioII,
					@PrecioSI,
					@PVP,
					@NGrupos,
					@NSalidasVapor,
					@NSalidasAgua,
					@CapacidadCaldera,
					@Resistencia,
					@Voltaje,
					@Peso,
					@Anchura,
					@Altura,
					@Profundidad
	while (@@FETCH_STATUS=0)
	begin
		-- Borrar Reporte de Datos de Maquinaria
		delete from sym_iReportesLin
		where	codEmpresa=@CodEmpresa
				and nomIPad='ipad#'
				and codReporte=@CodArticulo * 100 + @codPlantillaReportes - 100
				and codPlantillaReportes=@codPlantillaReportes

		delete from sym_iReportes
		where	codEmpresa=@CodEmpresa
				and nomIPad='ipad#'
				and codReporte=@CodArticulo * 100 + @codPlantillaReportes - 100
				and codPlantillaReportes=@codPlantillaReportes

		-- Insertar datos de contrato en el Reporte
		-- Cabecera
		insert into sym_iReportes
		select	CodEmpresa
				, 'ipad#'				as nomIPad
				, @CodArticulo * 100 + @codPlantillaReportes - 100	as CodReporte
				, getdate()				as fecReporte
				, desPlantillaReportes	as desReporte
				, @codPlantillaReportes	as codPlantillaReportes
				, 0						as codPedido
				, ''					as codCliente
				, 0						as codAgente
				, @CodArticulo			as codArticulo
				, 1						as flaExpReporte
				, codTipoPlantilla
				, flaPedirFoto
		from sym_iPlantillaReportes
		where	CodEmpresa=@CodEmpresa
				and codPlantillaReportes=@codPlantillaReportes

		-- Lineas
		insert into sym_iReportesLin
		select	CodEmpresa
				, 'ipad#'					as nomIPad
				, @CodArticulo * 100 + @codPlantillaReportes - 100 as CodReporte
				, @codPlantillaReportes		as codPlantillaReportes
				, linPlantillaReportesLin	as linReportesLin
				, desCampo
				, codTipoCampo
				, desLista
				, 0							as flaObligado
				, ordReportesLin
				, coalesce(convert(nvarchar(500),choose(linPlantillaReportesLin
					,@CodArticulo
					,@Articulo
					,@Fabricante
					,@Modelo
					,'N/D' --@PrecioII
					,'N/D' --@PrecioSI
					,'N/D' --@PVP
					,@NGrupos
					,@NSalidasVapor
					,@NSalidasAgua
					,@CapacidadCaldera
					,@Resistencia
					,@Voltaje
					,@Peso
					,@Anchura
					,@Altura
					,@Profundidad
					)), 'N/A')	as datRespuesta  -- Valor SAP
		from sym_iPlantillaReportesLin
		where	CodEmpresa=@CodEmpresa
				and codPlantillaReportes=@codPlantillaReportes

		-- Siguiente registro
		fetch c into	@CodEmpresa,
						@CodArticulo,
						@Articulo,
						@Fabricante,
						@Modelo,
						@PrecioII,
						@PrecioSI,
						@PVP,
						@NGrupos,
						@NSalidasVapor,
						@NSalidasAgua,
						@CapacidadCaldera,
						@Resistencia,
						@Voltaje,
						@Peso,
						@Anchura,
						@Altura,
						@Profundidad	
	end

	-- Cierre del cursor
	CLOSE c
	-- Liberar los recursos
	DEALLOCATE c

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
