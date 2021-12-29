SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Author:		Ramon Villanueva
-- Create date: 06/11/2015
-- Description: Acuerdos comerciales
-- Incluir los acuerdos comerciales que se incorporan con Limagito
-- Se integran como elementos multimedia de cliente
-- ================================================================
CREATE procedure [dbo].[usp_inaAcuerdosComerciales] AS
BEGIN

	SET NOCOUNT ON;	

	--**************** Log_ProcedureCall ****************
	-- Variables de proceso
	declare @FechaProceso datetime
			,@TiempoProceso int
		-- Fecha-hora inicio del proceso
	select @FechaProceso=GETDATE()
	--***************************************************

	set LANGUAGE SPANISH

	-- Lista de acuerdos comerciales
	declare @Tabla1 table (CodCliente int, ModifyDate datetime)
	insert into @Tabla1
	select NumDoc CodCliente
			,ModifyDate
	from stgIna_Archivos
	where Tipo='AcuerdoComercial'
	
	
	-- Borrar los registros existentes de acuerdos comerciales
	delete from sym_iClientesLMultimedia
		where desMultimedia='Acuerdo comercial'

	-- Insertar los registros para los acuerdos comerciales existentes
	insert into sym_iClientesLMultimedia
	select  t1.codEmpresa
			,t1.codCliente
			,1 linMultimedia-- IMPORTANTE: El adjunto 1 es el Acuerdo comercial
			,'AC' + ltrim(convert(char(7),t2.CodCliente)) + '.pdf' hipMultimedia
			,'Acuerdo comercial' desMultimedia
			,0 flaModificado -- A cero para que se descargue bajo demanda
	from sym_iClientes t1
		inner join @Tabla1 t2
			on t1.codEmpresa=2
				and t1.codCliente=t2.CodCliente
	where isnumeric(t1.codCliente)=1
	
	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************

END
GO
