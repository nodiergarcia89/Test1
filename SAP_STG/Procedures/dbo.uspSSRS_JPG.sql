SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Villanueva
-- Create date: 22/07/2015
-- Description:	Ejecutar informes a imagen
-- Con esto se sabe el id de la subscripcion
--
--use ReportServer
--SELECT
--     S .ScheduleID AS SQLAgent_Job_Name
--     ,SUB. Description AS Sub_Desc
--     ,SUB. DeliveryExtension AS Sub_Del_Extension
--     ,C. Name AS ReportName
--     ,C. Path AS ReportPath
--FROM ReportSchedule RS
--     INNER JOIN Schedule S ON ( RS.ScheduleID = S. ScheduleID)
--     INNER JOIN Subscriptions SUB ON ( RS.SubscriptionID = SUB. SubscriptionID)
--     INNER JOIN [Catalog] C ON ( RS.ReportID = C. ItemID AND SUB .Report_OID = C.ItemID)
--ORDER BY SUB.ModifiedDate DESC
-- =============================================
CREATE PROCEDURE [dbo].[uspSSRS_JPG]
AS
    BEGIN
	   SET NOCOUNT ON;

	   --**************** Log_ProcedureCall ****************
	   -- Variables de proceso
	   DECLARE 
			@FechaProceso  DATETIME
		   , @TiempoProceso INT
	   -- Fecha-hora inicio del proceso
	   SELECT 
			@FechaProceso=GETDATE()
	   --***************************************************
	   DECLARE 
			@Multimedia CHAR(50)='\\SVVM04\MultIna$'
			,@Borrado NVARCHAR(200)

	   -- IMAGENES
	   -- Resumen de visitas reportadas
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='2B35E5D6-9E6A-4058-8EEE-C2BC3B4EE202'
	   -- Resumen de clientes por usuario
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='568089B8-593E-41A1-AB5E-E530EFF126C6'
	   -- Feliz Navidad
	   --EXEC SVW2K12VM01.msdb.dbo.sp_start_job @job_name='D0998A45-0D66-4E10-BEB5-0F3701BC7671'
	   -- MULTIMEDIA
	   -- Ficha usuario
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='0DA0158D-CBE6-4409-987A-763F638C4CC8'
	   -- Pedidos Pendientes distribuidores 05/10/2020 Los comento porque da errores la suscripcion
	   --EXEC SVW2K12VM01.msdb.dbo.sp_start_job @job_name='6A0C4450-B66D-4A54-9ADE-0A4026796E64'
	   --EXEC SVW2K12VM01.msdb.dbo.sp_start_job @job_name='ABA5E9C9-5815-4282-8BCD-1DC45A4A5889' -- SOTI
	   -- Resumen de clientes HD
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='ECE93FFC-553D-4DCE-9B70-6C071567F67F'
	   -- Resumen de clientes HI
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='609E6CE3-8F3D-4896-BF6A-91DF120C96A0'
	   -- Resumen Deuda de clientes HD
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='9247760A-C378-4F8D-B1E4-6012292ECEFC'
	   -- Resumen Deuda de clientes HI
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='3849B081-F349-4BF4-984F-5A1BABF3CD09'
	   -- Resumen Deuda de clientes B2B
	   --	 Borrar ficheros previos
	   SELECT @Borrado=CONCAT('del ',TRIM(@Multimedia),'\Deuda_*.pdf')
	   EXEC xp_cmdshell @Borrado
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='7199B255-36F3-4577-AF2F-467F90C1FA7F'
	   -- Resumen de Facturacion de clientes B2B
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='F493AE0B-A26D-45CF-8A60-B0E74F600FB1'
	   -- Declaracion Facturacion de clientes B2B - Año Anterior (por si se quiere forzar)   
	   --EXEC SVW2K12VM01.msdb.dbo.sp_start_job @job_name='C6A1AE09-1010-44DD-AC35-FB78684937CB'
	   -- Folletos de tarifa HD
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='BEF2BAB9-EA85-4870-82A7-4E11E4B0E2DF'
	   -- Ventas por Cliente Articulo
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='C762AC95-BB33-4B8A-ACC2-2D405492AFDF'
	   -- Folletos Maquinaria
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='C60F1C25-1C36-473E-9269-AE3B83D15948'

	   -- ADJUNTOS
	   -- Folletos de tarifa HI
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='37BEF5F2-D009-43D2-97DE-21A1BBC35458'
	   -- Reporte semanal de visitas
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='C74AF740-6334-4203-ACCC-61936F8577E8'
	   -- Folleto Tarifa de costes HD
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='83165BD8-A514-4352-BB30-75789D16D3D3'
	   -- Folleto Tarifa de costes HI Sin Instalacion
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='F34DB3FE-BB45-4EBF-9BBE-C28B6E44592A'
	   -- Folleto Tarifa de costes HI Con Instalacion
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='C75D25E9-3FB6-4C8B-B044-0E5D984B4429'
	   -- Agenda Coffee Tester
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='544BBAAB-C46A-477F-BDE0-AA2C22DAB384'
	   -- Clientes Potenciales Reportados HI
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='2716D9A4-6246-47F7-97B5-CF6815CDB226'

	   -- CARPETAS DE USUARIO
	   -- Folletos de tarifa Usuarios
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='A6CAD4FC-DF27-449D-9F28-5770C5B8C628' 
	   -- Folletos Maquinaria
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='7D719B1A-9F26-48C3-A45F-224330DCFF13'
	   -- Folleto Tarifa de costes HD
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='9B33AF5C-0D9D-4D22-AE29-04F18B4153CC'
	   -- Folleto Tarifa de costes HI
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='8336D15B-F4FB-4F24-ABCF-66D0563B8EAE' -- Sin instalacion
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='C7B7F8AC-1E52-4632-89B0-BAE09EC319CE' -- Con instalacion
	   -- NOTIFICACIONES
	   -- Clientes Delegado/ATC
	   --EXEC SVW2K12VM01.msdb.dbo.sp_start_job @job_name='63FCE322-1875-4BB8-A361-C4BB6A5BAC5F'
	   -- Clientes Delegado/ATC AM
	   --EXEC SVW2K12VM01.msdb.dbo.sp_start_job @job_name='BB8C7912-8B3B-45A1-983D-D098B1A62EA5'
	   -- Control de actualizacion
	   EXEC SVW2K12VM01.msdb.dbo.sp_start_job 
		   @job_name='ABC4A368-4A7B-4D44-8AEC-EE40ADBEF06B'

	   --**************** Log_ProcedureCall ****************
	   SELECT 
			@TiempoProceso=DATEDIFF(s, @FechaProceso, GETDATE())
	   EXEC utility.Log_ProcedureCall 
		   @ObjectID=@@PROCID, 
		   @Duracion=@TiempoProceso
	   --****************************************************
    END
GO
