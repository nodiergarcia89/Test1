SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- ================================================================
-- Author:		Ramon Villanueva
-- Create date: 13/11/2015
-- Description: Archivos en Directorios
-- ================================================================
CREATE procedure [dbo].[usp_ArchivosDirectorios] AS
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

	-- Copiar tablas de usuario al directorio de trabajo del BI
     --EXEC XP_CMDSHELL 'COPY \\FS01\BI$\Forecast.xlsx D:\BI-Folder\' -- Forecast

	-- Borrar tabla
	truncate table stgIna_Archivos

	-- Recoger archivos
	select	path
			,iif(right(rtrim(path),4)= '.jpg',rtrim(name)+'.jpg', name) name
			,ModifyDate
			,IsFileSystem
			,IsFolder
			,case 
				when lower(name)='forecast.xlsx' then 'Forecast'
				when lower(name)='BudgetV.xlsx' then 'BudgetV'
				when path like '%\AC[0-9][0-9][0-9][0-9][0-9][0-9][0-9].pdf'   then 'AcuerdoComercial'
				when path like '%\C[0-9][0-9][0-9][0-9][0-9][0-9].pdf'  then 'Contrato'
				when path like '%\[0-9]%[_]1.PDF' then 'ResumenVisitas'
				when path like '%\[0-9]%[_]2.PDF' then 'PedidosPtesDist'
				when path like '%\[0-9]%[_]3.PDF' then 'ResumenClientesHD'
				when path like '%\[0-9]%[_]4.PDF' then 'ResumenClientesHI'
				when path like '%\[0-9]%[_]5.PDF' then 'ResumenDeudaClientesHI'
				when path like '%\[0-9]%[_]6.PDF' then 'ResumenDeudaClientesHD'
				when path like '%\[0-9]%[_]7.PDF' then 'ReporteSemanalVisitas'
				when path like '%\[0-9]%[_]8.PDF' then 'VentasClienteArticulo'
				when name like 'FT____.%' then 'FichaTecnica'
				when name like 'FT____' then 'FichaTecnica'
				when name like 'TA____.%' then 'Tarifa'
				when name like 'CT____.%' then 'Catalogo'
				when name like 'NOV______' then 'Novedad'
				when right(rtrim(path),4)= '.jpg' and isnumeric(name)=1 then 'ImagenArticulo'
				when right(rtrim(path),4)= '.jpg' and isnumeric(name)=0 then 'Imagen'
				when right(rtrim(path),4)= '.jpg' then 'Imagen'
				else 'Otro'
			 end Tipo
			 ,case 
				when path like '%\AC[0-9][0-9][0-9][0-9][0-9][0-9][0-9].pdf'  then substring(name,3,7) 
				when path like '%\C[0-9][0-9][0-9][0-9][0-9][0-9].pdf' 		then substring(name,2, 6)
				--when path like '%\[0-9]%[_]1.PDF'			then left(name, len(rtrim(name))-6) 
				when right(rtrim(path),4)= '.jpg' and isnumeric(name)=1	then rtrim(name)
				else 0
			 end NumDoc
	into #tmp_Tabla1
	from 
	(select * from dbo.[Dir]('D:\Catalogo\Multimedia')
		UNION ALL
		select * from dbo.[Dir]('D:\Catalogo\Adjuntos')
		UNION ALL
		select * from dbo.[Dir]('D:\Catalogo\Imagenes')
		UNION ALL
		select * from dbo.[Dir]('D:\BI-Folder')) T

	-- Recoger archivos
	insert 	into stgIna_Archivos
	select *
		from #tmp_Tabla1
	where isnumeric(NumDoc)=1


	--**************** Log_ProcedureCall ****************
	select @TiempoProceso=DATEDIFF(s, @FechaProceso ,getdate())
	EXEC utility.Log_ProcedureCall 
		@ObjectID = @@PROCID
		, @Duracion= @TiempoProceso
	--****************************************************
END
GO
