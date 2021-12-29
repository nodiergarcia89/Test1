SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =================================================================
-- Author:		Ramon Villanueva
-- Create date: 19/01/2015
-- Description:	Traspaso tablas inaCatalog. iClientesLMultimedia
-- =================================================================
CREATE PROCEDURE [dbo].[usp_inaClientesLMultimedia] AS
BEGIN
	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************
		-- Declarar variables
		declare @CodEmpresa int
		declare @ID int
		declare @CodAreaManager int
		declare @CodDelegacion int
		declare @CodAgente int
		declare @CodGrupoClientes char(10)
		declare @CodProvincia char(2)
		declare @CodCliente nvarchar(20)
		declare @SQL char(2000)
		
		-- Tabla de salida
		create table #tmp_Tabla2
			(CodEmpresa int
			 ,ID  int 
			 ,CodCliente nvarchar(20)
			 ,CodProvincia char(2)
			 ,CodGrupoClientes char(10)
			 ,CodDelegacion int
			 ,CodAgente int
			 ,NumContrato int
			 )

		-- La tabla de destino ha de estar vacia.
		-- La borro aqui pero se borra en el proceso de InaSources
		delete from sym_iClientesLMultimedia
		
		-- Todos los clientes se envian a los iPads
		SELECT distinct t1.CodEmpresa
				, 0 ID
				, t1.CodCliente
				, t1.CodProvincia
				, t1.CodGrupoClientes
				, t1.CodDelegacion
				, t1.CodRespCuenta
				, coalesce(t3.NumContrato,0) NumContrato
		INTO #tmp_Tabla1
		FROM    stgF3Clientes AS t1 
				INNER JOIN sym_iClientes AS t2 
					ON	convert(varchar,t1.CodCliente) = t2.CodCliente 
						AND t1.CodEmpresa = t2.CodEmpresa
				left outer join vstgF3ClientesContratoAct as t3
					on convert(varchar,t1.CodCliente)=t3.CodCliente 
	

		-- Recorrer tabla de parametros
		declare c cursor for
			SELECT CodEmpresa, ID, CodAreaManager
					,CodDelegacion, CodAgente, CodGrupoClientes
					,CodProvincia, CodCliente
		  FROM inaClientesLMultimedia

		-- Bucle para cada registro
		open c
			fetch c into  @CodEmpresa, @ID, @CodAreaManager
					,@CodDelegacion, @CodAgente, @CodGrupoClientes
					,@CodProvincia, @CodCliente

		while (@@FETCH_STATUS=0)
		begin
			-- Determinar la seleccion de registros
			SELECT @SQL='WHERE '

			select @SQL=rtrim(@SQL) + ' CodEmpresa=' + rtrim(convert(char,@CodEmpresa)) -- La empresa es obligatoria
			--if @CodAreaManager<>0
			--	delete from #tmp_Tabla1 where CodAreaManager<>@CodAreaManager
			if @CodDelegacion <> 0
				select @SQL=rtrim(@SQL) + ' and CodDelegacion=' + rtrim(convert(char,@CodDelegacion))
			if @CodAgente<>0
				select @SQL=rtrim(@SQL) + ' and CodRespCuenta=' + rtrim(convert(char,@CodAgente))
			if @CodGrupoClientes<>''
				select @SQL=rtrim(@SQL) + ' and CodGrupoClientes=' + '''' + rtrim(@CodGrupoClientes) + ''''
			if @CodProvincia<>''
				select @SQL=rtrim(@SQL) + ' and CodProvincia=' + '''' + rtrim(@CodProvincia) + ''''
			if @CodCliente<>''
				select @SQL=rtrim(@SQL) + ' and CodCliente=' + '''' + rtrim(@CodCliente) + ''''
			
			-- Insertar registros en tabla
			select @SQL='INSERT INTO #tmp_Tabla2 SELECT CodEmpresa,' +  convert(char,@ID) 
							+ ', CodCliente, CodProvincia, CodGrupoClientes, CodDelegacion, CodRespCuenta, NumContrato FROM #tmp_Tabla1 ' 
							+ rtrim(@SQL)
	
			exec (@SQL)
			
			-- Siguiente registro
			fetch c into  @CodEmpresa, @ID, @CodAreaManager
					,@CodDelegacion, @CodAgente, @CodGrupoClientes
					,@CodProvincia, @CodCliente
		end

		-- Cierre del cursor
		CLOSE c
		-- Liberar los recursos
		DEALLOCATE c

		-- Recuperar datos y aplicar las sustituciones
		INSERT INTO sym_iClientesLMultimedia
			(codEmpresa, codCliente, linMultimedia, hipMultimedia, desMultimedia, flaModificado)
		SELECT  t1.CodEmpresa
				, t1.CodCliente
				, ROW_NUMBER() OVER(PARTITION BY t1.CodEmpresa, t1.CodCliente ORDER BY t2.ID)
				, replace(
					replace(
						replace(
							replace(
								replace(t2.hipMultimedia, '%Cliente%', t1.CodCliente)
								, '%Provincia%', t1.CodProvincia)
							, '%GrupoClientes%', t1.CodGrupoClientes)
						,'%Delegacion%',t1.CodDelegacion)
					,'%Contrato%',t1.NumContrato) hipMultimedia
				, rtrim(t2.desMultimedia) desMultimedia
				, 0 flaModificado -- A 1 me aseguro que el elemento multimedia NO se suba siempre
		FROM    #tmp_Tabla2 AS t1 
				INNER JOIN inaClientesLMultimedia AS t2
					ON	t1.ID = t2.ID

		-- Si el cliente no tiene contrato se genera registro. A continuacion lo borro
		DELETE sym_iClientesLMultimedia
			where hipMultimedia='C0.pdf'

    -- Insertar registros de prueba PowerBi
    --INSERT INTO sym_iClientesLMultimedia
	   --SELECT	  2
			 --,1230861
			 --,1
			 --,'mspbi://app/OpenReport?ReportObjectId=a47526af-5672-443b-b45b-9c1177a7eaa3&reportPage=ReportSection2&filter=PBI_ClientesActual/CodCliente eq ''0001230861'''
			 --, 'Estadistica'
			 --, 1
    --INSERT INTO sym_iClientesLMultimedia
	   --SELECT	  2
			 --,3234798
			 --,2
			 --,'mspbi://app/OpenReport?ReportObjectId=a47526af-5672-443b-b45b-9c1177a7eaa3&reportPage=ReportSection2&filter=PBI_ClientesActual/CodCliente eq ''0003234798'''
			 --, 'Estadistica'
			 --, 1

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END



GO
