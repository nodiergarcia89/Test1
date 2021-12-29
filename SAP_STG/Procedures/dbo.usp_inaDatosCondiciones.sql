SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ========================================================================
-- Author:		Ramon Villanueva
-- Create date: 30/03/2015
-- Description:	Datos de condiciones a Report InaCatalog
-- En la tabla de iReportes aparecen tambien los que se hacen desde los
-- dispositivos, por lo que al usarlos aqui hay que tener cuidado con no
-- borrar los registros que no correspondan.
-- Modificacion 15/10/2015
--   Controlo que haya registros de condicion
-- Modificacion 15/12/2015
--   Hasta que Seidor no tenga lo de las condiciones no sale para HI
-- Modificacion 08/03/2016
--   Incluyo las condiciones de HI
-- Modificacion 31/10/2017
--    Para los clientes de tipo '26' y '31' no
-- Modificacion 18/12/2017
--	   Como fecha de reporte pongo la de alta del cliente
-- ========================================================================
CREATE PROCEDURE [dbo].[usp_inaDatosCondiciones] AS
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
	declare @codPlantillaReportes int=108 -- Es la plantilla para datos de condiciones

	declare
		@CodEmpresa int=2 ,
		@CodCliente nvarchar(20),
		@NomCliente nvarchar(100),
		@Poblacion nvarchar(100),
		@CondCafe   nvarchar(max),
		@CondComplementos nvarchar(max),
		@CondPLV   nvarchar(max)
		,@FecAltaCliente datetime -- 18/12/2017

	-- Creo una tabla temporal para recorrer con el cursor porque da problemas el campo
	-- numerico del codigo cliente.
	select	t1.CodEmpresa,
			Convert(int, t1.CodCliente) CodCliente,
			t1.nomCliente,
			t2.datPoblacionDirCli Poblacion
			, t1.fecAltaCliente -- 18/12/2017
		into #tmp_Tabla1
		from sym_iClientes t1
			inner join sym_iClientesLDir t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codCliente=t2.codCliente
			inner join stgF3Clientes t3
				on t1.codEmpresa=t3.CodEmpresa
					and t1.codCliente=t3.CodCliente
		where isnumeric(t1.codCliente)=1
			 and t3.CodTipoCliente not in ('26','31') -- 31/10/2017
				--and t3.CodTipoHoreca=2 -- Sólo de los de Horeca Directa 08/03/2016

	-- Con un cursor recorro los registros a tratar de la vista stgF3ResumenCondicionesCliente
	-- de los clientes que se traspasan
	declare c cursor for
		SELECT	t1.CodEmpresa,
				t1.CodCliente,
				t1.nomCliente,
				t1.Poblacion,
				coalesce(t2.Condicion,'N/A') CondCafe,
				coalesce(t3.Condicion, 'N/A') CondComplementos,
				coalesce(t4.Condicion, 'N/A') CondPLV
				, t1.fecAltaCliente -- 18/12/2017
		from	#tmp_Tabla1 t1 
				left outer join stgF3ResumenCondicionesCliente t2
					on	t1.codEmpresa=t2.CodEmpresa
						and t1.CodCliente=t2.CodCliente
						and t2.CodNivel1=1 -- CAFE
				left outer join stgF3ResumenCondicionesCliente t3
					on	t1.codEmpresa=t3.CodEmpresa
						and t1.CodCliente=t3.CodCliente
						and t3.CodNivel1=2 -- COMPLEMENTOS
				left outer join stgF3ResumenCondicionesCliente t4
					on	t1.codEmpresa=t4.CodEmpresa
						and t1.CodCliente=t4.CodCliente
						and t4.CodNivel1=6 -- PLV
		-- Excluyo los que no tienen ningun registro de condicion
		where	coalesce(t2.Condicion,'N/A')    <>'N/A' -- CondCafe
				or coalesce(t3.Condicion, 'N/A')<>'N/A' -- CondComplementos
				or coalesce(t4.Condicion, 'N/A')<>'N/A' -- CondPLV

	-- Bucle para cada Cliente
	open c
	fetch c into	@CodEmpresa,
					@CodCliente,
					@NomCliente,
					@Poblacion,
					@CondCafe,
					@CondComplementos,
					@CondPLV
					,@FecAltaCliente -- 18/12/2017
	while (@@FETCH_STATUS=0)
	begin
		-- Borrar Reporte de Datos de condiciones
		delete from sym_iReportesLin
		where	codEmpresa=@CodEmpresa
				and nomIPad='Central'
				and codReporte=@CodCliente * 100 + @codPlantillaReportes -100
				and codPlantillaReportes=@codPlantillaReportes

		delete from sym_iReportes
		where	codEmpresa=@CodEmpresa
				and nomIPad='Central'
				and codReporte=@CodCliente * 100 + @codPlantillaReportes -100
				and codPlantillaReportes=@codPlantillaReportes

		-- Insertar datos de condiciones en el Reporte
		-- Cabecera
		insert into sym_iReportes
		select	CodEmpresa
				, 'Central'				as nomIPad
				, @CodCliente * 100 + @codPlantillaReportes -100 as CodReporte
				--, getdate()				as fecReporte -- 18/12/2017
				, @FecAltaCliente -- 18/12/2017
				, desPlantillaReportes + ' - ' + @NomCliente as desReporte
				, @codPlantillaReportes	as codPlantillaReportes
				, 0						as codPedido
				, @CodCliente			as codCliente
				, 0						as codAgente
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
				, @CodCliente * 100 + @codPlantillaReportes -100 as CodReporte
				, @codPlantillaReportes		as codPlantillaReportes
				, linPlantillaReportesLin	as linReportesLin
				, desCampo
				, codTipoCampo
				, desLista
				, 0							as flaObligado
				, ordReportesLin
				, coalesce(convert(nvarchar(max),choose(linPlantillaReportesLin
					,@CodCliente
					,rtrim(@NomCliente) + ' (' + rtrim(@Poblacion) + ')'
					,@CondCafe
					,@CondComplementos
					,@CondPLV
					)), 'N/A')	as datRespuesta  -- Valor SAP
		from sym_iPlantillaReportesLin
		where	CodEmpresa=@CodEmpresa
				and codPlantillaReportes=@codPlantillaReportes

		-- Siguiente registro
		fetch c into	@CodEmpresa,
						@CodCliente,
						@NomCliente,
						@Poblacion,
						@CondCafe,
						@CondComplementos,
						@CondPLV
	   					,@FecAltaCliente -- 18/12/2017
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
