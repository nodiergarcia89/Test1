SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- ========================================================================
-- Author:		Ramon Villanueva
-- Create date: 25/10/2015
-- Description:	Datos de consumos A a Report InaCatalog
-- Modificacion 18/12/2017
--	   La fecha del reporte es el 1/1 del año actual
-- ========================================================================
CREATE PROCEDURE [dbo].[usp_inaDatosConsumosA] AS
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
	declare @codPlantillaReportes int=122 -- Es la plantilla para datos de consumos A

	declare
		@CodEmpresa int=2 ,
		@CodCliente nvarchar(20),
		@NomCliente nvarchar(100),
		@Poblacion nvarchar(100),
		@CondCafe   nvarchar(max),
		@CondComplementos nvarchar(max),
		@CondPLV   nvarchar(max),
		@TotalClte nvarchar(max),
		@Periodo varchar(max)
	
	-- Periodo de datos
	select @Periodo=(case datepart(month,getdate())
						when 1 then ' (Enero ' + rtrim(convert(char,datepart(year,getdate()))) + ')'
						else
							' (Ene-' + left(datename(month,DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), -1)),3)
								 + ' ' + rtrim(convert(char,datepart(year,getdate()))) + ')'
						end)


	-- Creo una tabla temporal para recorrer con el cursor porque da problemas el campo
	-- numerico del codigo cliente.
	select	t1.CodEmpresa,
			Convert(int, t1.CodCliente) CodCliente,
			t1.nomCliente,
			t2.datPoblacionDirCli Poblacion
		into #tmp_Tabla1
		from sym_iClientes t1
			inner join sym_iClientesLDir t2
				on t1.codEmpresa=t2.codEmpresa
					and t1.codCliente=t2.codCliente
					and t2.linDirCli=1
			inner join stgF3Clientes t3
				on t1.codEmpresa=t3.CodEmpresa
					and t1.codCliente=t3.CodCliente
		where isnumeric(t1.codCliente)=1

	-- Con un cursor recorro los registros a tratar de la vista [stgF3ConsumosClienteA]
	-- de los clientes que se traspasan
	declare c cursor for
		SELECT	t1.CodEmpresa,
				t1.CodCliente,
				t1.nomCliente,
				t1.Poblacion,
				coalesce(t2.Consumo,'N/A') CondCafe,
				coalesce(t3.Consumo, 'N/A') CondComplementos,
				coalesce(t4.Consumo, 'N/A') CondPLV,
				coalesce(t5.Consumo, 'N/A') TotalClte
		from	#tmp_Tabla1 t1 
				left outer join [stgF3ConsumosClienteA] t2
					on	t1.codEmpresa=t2.CodEmpresa
						and t1.CodCliente=t2.CodCliente
						and t2.CodNivel1=1 -- CAFE
				left outer join [stgF3ConsumosClienteA] t3
					on	t1.codEmpresa=t3.CodEmpresa
						and t1.CodCliente=t3.CodCliente
						and t3.CodNivel1=2 -- COMPLEMENTOS
				left outer join [stgF3ConsumosClienteA] t4
					on	t1.codEmpresa=t4.CodEmpresa
						and t1.CodCliente=t4.CodCliente
						and t4.CodNivel1=6 -- PLV
				left outer join [stgF3ConsumosClienteA] t5
					on	t1.codEmpresa=t5.CodEmpresa
						and t1.CodCliente=t5.CodCliente
						and t5.CodNivel1=0 -- Total Cliente
		-- Excluyo los que no tienen ningun registro de consumo
		where	coalesce(t2.Consumo,'N/A')    <>'N/A' -- Cafe
				or coalesce(t3.Consumo, 'N/A')<>'N/A' -- Complementos
				or coalesce(t4.Consumo, 'N/A')<>'N/A' -- PLV

	-- Bucle para cada Cliente
	open c
	fetch c into	@CodEmpresa,
					@CodCliente,
					@NomCliente,
					@Poblacion,
					@CondCafe,
					@CondComplementos,
					@CondPLV,
					@TotalClte
	while (@@FETCH_STATUS=0)
	begin
		-- Borrar Reporte de Datos de consumo
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

		-- Insertar datos de consumo en el Reporte
		-- Cabecera
		insert into sym_iReportes
		select	CodEmpresa
				, 'Central'				as nomIPad
				, @CodCliente * 100 + @codPlantillaReportes -100 as CodReporte
				--, getdate()				as fecReporte --18/12/2017
				, convert(date,'01/01/'+ rtrim(convert(char,datepart(year,getdate())))) -- 18/12/2017 
				, rtrim(desPlantillaReportes) 
					+ ' ' + rtrim(convert(char,datepart(year,getdate()))) 
					+ ' (a fin de ' + datename(month,DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), -1)) + ')'
					+ ' - ' + @NomCliente desReporte
--					+ ' - ' + rtrim(format(getdate(),'dd/MM/yy HH:MM:ss','es-ES')) as desReporte -- 18/12/2017
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
				, left(convert(nvarchar(max),choose(linPlantillaReportesLin
					, rtrim(desCampo)
					, rtrim(desCampo)
					, rtrim(desCampo) + rtrim(@Periodo)
					, rtrim(desCampo) + rtrim(@Periodo)
					, rtrim(desCampo) + rtrim(@Periodo)
					, rtrim(desCampo) + rtrim(@Periodo)
				 )),50) desCampo
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
					,@TotalClte
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
						@CondPLV,
						@TotalClte
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
