SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--SV3e

--SV4s

--Stored Procedure to Add a scheduled job for this database to SQL Server
CREATE PROCEDURE [aec_DAL_Core_AddScheduledJob] 
	-- Add the parameters for the stored procedure here
	@pJobName nvarchar(90), 
	@pCommand nvarchar(max),
	@pFrequencyType int = 0,
	@pFrequencyInterval int = 1,
	@pStartTime int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ReturnCode INT;
	SET @ReturnCode = 0;

	DECLARE @DBName sysname;
	SET @DBName = DB_NAME();

	DECLARE @JobCategory sysname;
	SET @JobCategory = N'Atlantic Global OnDemand';

	DECLARE @UniqueJobName nvarchar(128);
	SET @UniqueJobName = @DBName + '-' + @pJobName;
	
	--Date Field for time of immediate jobs
	DECLARE @Now DATETIME;

	BEGIN TRANSACTION

	-- Create the Job
	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job 
			@job_name= @UniqueJobName, 
			@enabled=1, 
			@notify_level_eventlog=0, 
			@notify_level_email=0, 
			@notify_level_netsend=0, 
			@notify_level_page=0, 
			@delete_level=0, 
			@description= @DBName,
			@category_name=@JobCategory,
			@job_id = @jobId OUTPUT
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	--Create the Job Step	
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, 
			@step_name=N'STEP1', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, 
			@subsystem=N'TSQL', 
			@command=@pCommand, 
			@database_name=@DBName, 
			@flags=0
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	
	--Create the Job Schedule
	--If the job time = 999900 then replace with a time 10 seconds from now
	--and Frequency Type to 1 (Once)
	IF (@pStartTime > 900000)
	BEGIN
		SET @Now = GETDATE();
		SET @Now = DATEADD(second, 10, @Now);
		SET @pStartTime = (DATEPART(hour,@Now) * 10000) + (DATEPART(minute, @Now) * 100) + DATEPART(second, @Now);
		SET @pFrequencyType = 1;
	END
	
	EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, 
			@name=@UniqueJobName, 
			@enabled=1, 
			@freq_type=@pFrequencyType, 
			@freq_interval=@pFrequencyInterval, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=1, 
			@freq_recurrence_factor=1, 
			@active_start_time= @pStartTime, 
			@active_end_time=235959
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		
	COMMIT TRANSACTION

	GOTO EndSave

QuitWithRollback:
	IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION

EndSave:

END


GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_Core_AddScheduledJob]
	TO [V6N14816rwZf]
GO
