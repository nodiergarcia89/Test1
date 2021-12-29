SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 10/01/2015
-- Description:	Traspaso tablas inaCatalog
-- =============================================
CREATE PROCEDURE [dbo].[uspGetInaTablas] as
BEGIN
	SET DATEFORMAT mdy;
	
	-- Poner la BD en BULK para optimizar la carga
	--ALTER DATABASE SAP_STG SET RECOVERY BULK_LOGGED
	
	-- Declarar variables
	declare @IdSystem tinyint
	declare @SourceName varchar(50)
	declare @Tratar bit
	declare @SourceTableName varchar(50)
	declare @DestinationTableName varchar(50)
	declare @TSQL varchar (8000)

	-- Variables de proceso
	declare @SourceSystemName char(50)
	declare @TipoProceso char(10)
	declare @FechaProceso datetime
	declare @GUIDProceso uniqueidentifier
	declare @FilasAfectadas int
	declare @FilasBorradas int 
	declare @TipoBorrado int
	declare @TotalRegistros int
	declare @TiempoProceso int
	declare @HoraIni datetime
	declare @HoraFin datetime
	declare @FechaExtraccion datetime
	declare @AuditCreate datetime

	-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()

	-- Guardar datos de proceso
	select @GUIDProceso=newid()

	INSERT INTO InaSources_Procesos
	SELECT  @GUIDProceso GUIDProceso, idFase
			, SourceName, FechaExtraccion
			, FilasBorradas, FilasAfectadas, FilasAnteriores
			, TotalRegistros, TiempoBorrado, TiempoLlenado, TiempoProceso
			, TipoProceso
			, FechaExtraccion as FechaProceso
	FROM    InaSources

	-- ************************** DELETE *******************************************
	-- Con un cursor recorro los registros a tratar de la tabla InaSources
	-- para borrar las tablas destino
	declare c cursor local fast_forward for
		select    SourceName, IdSystem, TipoBorrado
				, DestinationTableName, FechaExtraccion  
		from InaSources 
		where Tratar in(1, 2) -- 1=borrado/llenado, 2=solo borrado, 3=solo llenado
		order by idFase, OrdenBorrado
	
	-- Bucle para cada registro
	open c
	fetch next from c into  @SourceName, @IdSystem, @TipoBorrado
				, @DestinationTableName, @FechaExtraccion
	while (@@FETCH_STATUS=0)
	begin
		-- Incializar variables
		select @TotalRegistros=0
		select @FilasBorradas=0
		select @Tratar=0

		-- Obtener datos del sistema 
		select @SourceSystemName=SourceSystemName
			from SourceSystems
			where IdSourceSystem=@IdSystem

		-- Proceso de borrado
		-- Inicio de proceso
		select @HoraIni=GETDATE()
	
		-- Auditoria
		select @AuditCreate=GETDATE()

		-- Componer nombre tabla borrar
		-- Si @IdSystem=1 es el local
		select @DestinationTableName=rtrim(@DestinationTableName)
		if @IdSystem<>1
				select @DestinationTableName=rtrim(@SourceSystemName) + '.' + @DestinationTableName

		-- Borrar o truncar
		if @TipoBorrado=0 -- Delete porque tiene FK
			begin
				select @TSQL='delete from ' + @DestinationTableName 
				-- TipoProceso='Delete'
				select @TipoProceso='Delete'			
			end
		else 
			begin
				select @TSQL='truncate table ' + @DestinationTableName 
				-- TipoProceso='Truncate'
				select @TipoProceso='Truncate'			
			end 
		exec (@TSQL)
		select @FilasBorradas=@@ROWCOUNT

		PRINT CONCAT('Borrado: ',@TSQL,'  Registros:',@FilasBorradas)

		-- Tiempo de proceso
		select @HoraFin=GETDATE()
		select @TiempoProceso=DATEDIFF(ms,@HoraIni,@HoraFin)

		-- Actualizar Tabla con resultados del proceso
		UPDATE InaSources
			SET  FechaExtraccion=@AuditCreate
				, FilasBorradas=@FilasBorradas
				, FilasAfectadas=@FilasBorradas
				, FilasAnteriores=TotalRegistros
				, TotalRegistros=0
				, TiempoBorrado=@TiempoProceso
				, TiempoLlenado=0
				, TiempoProceso=@TiempoProceso
				, TipoProceso=@TipoProceso
		WHERE SourceName=@SourceName

		-- Siguiente registro
		fetch next from c into  @SourceName, @IdSystem, @TipoBorrado
					, @DestinationTableName, @FechaExtraccion
	end
	-- Cierre del cursor
	CLOSE c
	-- Liberar los recursos
	DEALLOCATE c

	-- ************************** INSERT *******************************************
	-- Con un cursor recorro los registros a tratar de la tabla InaSources
	-- para insertar las tablas destino
	declare c cursor local fast_forward for
		select    SourceName, IdSystem, SourceTableName
				, DestinationTableName, FechaExtraccion  
		from InaSources 
		where Tratar in(1, 3) -- 1=borrado/llenado, 2=solo borrado, 3=solo llenado
		order by idFase, OrdenCarga
	
	-- Bucle para cada registro
	open c
	fetch next from c into  @SourceName, @IdSystem, @SourceTableName
				, @DestinationTableName, @FechaExtraccion
	while (@@FETCH_STATUS=0)
	begin
		-- Incializar variables
		select @TotalRegistros=0
		select @FilasBorradas=0
		select @Tratar=0

		-- Obtener datos del sistema 
		select @SourceSystemName=SourceSystemName
			from SourceSystems
			where IdSourceSystem=@IdSystem

		-- Proceso de borrado
		-- Inicio de proceso
		select @HoraIni=GETDATE()
	
		-- Auditoria
		select @AuditCreate=GETDATE()

		print @DestinationTableName

		-- Componer nombre tabla borrar
		-- Si @IdSystem=1 es el local
		select @DestinationTableName=rtrim(@DestinationTableName)
		if @IdSystem<>1
				select @DestinationTableName=rtrim(@SourceSystemName) + '.' + @DestinationTableName

		-- Insertar	
		-- La cargo en memoria y de ahí a la tabla
		--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'##tmp_Tabla') AND type in (N'U'))
		--	DROP TABLE ##tmp_Tabla
		IF OBJECT_ID('tempdb.dbo.##tmp_Tabla', 'U') IS NOT NULL
			DROP TABLE ##tmp_Tabla 

		select @TSQL='select * into ##tmp_Tabla from ' + @SourceTableName
		exec (@TSQL)
		select @FilasAfectadas=@@ROWCOUNT
		
		PRINT CONCAT('Inserccion en ##tmp_Tabla: ',@TSQL,'  Registros:',@FilasAfectadas)

		select @TSQL='insert into ' + @DestinationTableName + ' WITH (TABLOCK)'
		--select @TSQL=@TSQL + ' select * from ' + @SourceTableName
		select @TSQL=@TSQL + ' select * from ##tmp_Tabla'

		exec (@TSQL)
		select @FilasAfectadas=@@ROWCOUNT
		-- TipoProceso='Borrado'
		select @TipoProceso='Insert'

		PRINT CONCAT('Inserccion: ',@TSQL,'  Registros:',@FilasAfectadas)

		-- Tiempo de proceso
		select @HoraFin=GETDATE()
		select @TiempoProceso=DATEDIFF(ms,@HoraIni,@HoraFin)

		-- Actualizar Tabla con resultados del proceso
		UPDATE InaSources
			SET  FechaExtraccion=@AuditCreate
				, FilasBorradas=FilasBorradas
				, FilasAfectadas=@FilasAfectadas
				, FilasAnteriores=TotalRegistros
				, TotalRegistros=@FilasAfectadas
				, TiempoBorrado=TiempoBorrado
				, TiempoLlenado=@TiempoProceso
				, TiempoProceso=TiempoProceso + @TiempoProceso
				, TipoProceso=@TipoProceso
		WHERE SourceName=@SourceName

		-- Siguiente registro
		fetch next from c into  @SourceName, @IdSystem, @SourceTableName
					, @DestinationTableName, @FechaExtraccion
	end
	-- Cierre del cursor
	CLOSE c
	-- Liberar los recursos
	DEALLOCATE c

	-- Devolver la BD a modo Simple
	--ALTER DATABASE SAP_STG SET RECOVERY SIMPLE

	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************

END
GO
