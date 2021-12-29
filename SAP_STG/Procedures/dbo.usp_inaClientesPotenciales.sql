SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================================
-- Author:		Ramon Villanueva
-- Create date: 07/012/2015
-- Description:	Clientes Potenciales a Report InaCatalog
-- En la tabla de iReportes aparecen tambien los que se hacen desde los
-- dispositivos, por lo que al usarlos aqui hay que tener cuidado con no
-- borrar los registros que no correspondan.
-- ========================================================================
CREATE PROCEDURE [dbo].[usp_inaClientesPotenciales] AS
BEGIN
	SET NOCOUNT ON;

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************
	-- Declarar variables
	declare @codPlantillaReportes int=100 -- Es la plantilla para potenciales

	declare
		@CodEmpresa tinyint ,
		@CodCliente int ,
		@CodAgente char(20),
		@ProveedorActual char(50) ,
		@ContratoVigente char(1) ,
		@FechaFinContrato char(8) ,
		@Maquina char(1) ,
		@ModeloMaquina char(60) ,
		@TipoContrato char(60) ,
		@OtroTipoInversion char(60) ,
		@KgSemana char(30) ,
		@Precio char(30) ,
		@GamaProductoActual char(18) ,
		@MarketingPLV char(60) ,
		@KGAño char(50) ,
		@ActividadPrincipal char(50) ,
		@NumeroEstablecimientos char(3) ,
		@MarcaPropia char(1) ,
		@NombreMarcaPropia char(15) ,
		@PropiedadCliente char(10) ,
		@Personal char(4) ,
		@FecReporte char(30),
		@Distribuidor nvarchar(50)

	-- La consulta del cursor la meto en una tabla en memoria ya que es una vista y penaliza 
	select * 
	into #Tabla
	from dbo.vIna_ClientesPotenciales
	-- Con un cursor recorro los registros a tratar de la vista vIna_ClientesPotenciales
	declare c cursor for
		SELECT CodEmpresa
			  ,CodCliente
			  ,CodAgente
			  ,FecReporte
			  ,ProveedorActual
			  ,ContratoVigente
			  ,FechaFinContrato
			  ,Maquina
			  ,ModeloMaquina
			  ,TipoContrato
			  ,OtroTipoInversion
			  ,KgSemana
			  ,Precio
			  ,GamaProductoActual
			  ,MarketingPLV
			  ,KGAño
			  ,ActividadPrincipal
			  ,NumeroEstablecimientos
			  ,MarcaPropia
			  ,NombreMarcaPropia
			  ,PropiedadCliente
			  ,Personal
			  ,Distribuidor
		  FROM #Tabla
	
	-- Bucle para cada Cliente
	open c
	fetch c into	@CodEmpresa
					,@CodCliente
					,@CodAgente
					,@FecReporte
					,@ProveedorActual
					,@ContratoVigente
					,@FechaFinContrato
					,@Maquina
					,@ModeloMaquina
					,@TipoContrato
					,@OtroTipoInversion
					,@KgSemana
					,@Precio
					,@GamaProductoActual
					,@MarketingPLV
					,@KGAño
					,@ActividadPrincipal
					,@NumeroEstablecimientos
					,@MarcaPropia
					,@NombreMarcaPropia
					,@PropiedadCliente
					,@Personal
					,@Distribuidor
	while (@@FETCH_STATUS=0)
	begin
		-- Borrar Reporte de Clientes Potenciales
		delete from sym_iReportesLin
		where	codEmpresa=@CodEmpresa
				and nomIPad='Central'
				and codReporte=@CodCliente * 100 + @codPlantillaReportes - 100
				and codPlantillaReportes=@codPlantillaReportes

		delete from sym_iReportes
		where	codEmpresa=@CodEmpresa
				and nomIPad='Central'
				and codReporte=@CodCliente * 100 + @codPlantillaReportes - 100
				and codPlantillaReportes=@codPlantillaReportes

		-- Insertar datos de Clientes potenciales en el Reporte
		-- Cabecera
		insert into sym_iReportes
		select	CodEmpresa
				, 'Central'				as nomIPad
				, @CodCliente * 100 + @codPlantillaReportes - 100 as CodReporte
				, @FecReporte			as fecReporte
				, desPlantillaReportes	as desReporte
				, @codPlantillaReportes	as codPlantillaReportes
				, 0						as codPedido
				, @CodCliente			as codCliente
				, @CodAgente			as codAgente
				, ''					as codArticulo
				, 1						as flaExpReporte
				, codTipoPlantilla
				, flaPedirFoto
		from sym_iPlantillaReportes
		where	CodEmpresa=@CodEmpresa
				and codPlantillaReportes=@codPlantillaReportes

		-- Lineas
		insert into sym_iReportesLin
		select	CodEmpresa
				, 'Central'					as nomIPad
				, @CodCliente * 100 + @codPlantillaReportes - 100 as CodReporte
				, @codPlantillaReportes		as codPlantillaReportes
				, linPlantillaReportesLin	as linReportesLin
				, desCampo
				, 'T'						as codTipoCampo -- Para asegurar valores no existentes
				, desLista
				, 0							as flaObligado
				, ordReportesLin
				, coalesce(convert(nvarchar(500),choose(linPlantillaReportesLin
					,@ProveedorActual
					,@ContratoVigente
					,@FechaFinContrato
					,@Maquina
					,@ModeloMaquina
					,@TipoContrato
					,@OtroTipoInversion
					,@KgSemana
					,@Precio
					,@GamaProductoActual
					,@MarketingPLV
					,@KGAño
					,@ActividadPrincipal
					,@NumeroEstablecimientos
					,@MarcaPropia
					,@NombreMarcaPropia
					,@PropiedadCliente
					,@Personal
					,''
					,@Distribuidor
				)), 'N/A')	as datRespuesta  -- Valor SAP
		from sym_iPlantillaReportesLin
		where	CodEmpresa=@CodEmpresa
				and codPlantillaReportes=@codPlantillaReportes

		-- Siguiente registro
		fetch c into	@CodEmpresa
							,@CodCliente
							,@CodAgente
							,@FecReporte
							,@ProveedorActual
							,@ContratoVigente
							,@FechaFinContrato
							,@Maquina
							,@ModeloMaquina
							,@TipoContrato
							,@OtroTipoInversion
							,@KgSemana
							,@Precio
							,@GamaProductoActual
							,@MarketingPLV
							,@KGAño
							,@ActividadPrincipal
							,@NumeroEstablecimientos
							,@MarcaPropia
							,@NombreMarcaPropia
							,@PropiedadCliente
							,@Personal
							,@Distribuidor
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
