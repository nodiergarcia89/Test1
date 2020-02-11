SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



--Stored Procedure to delete a scheduled job for this database from SQL Server
CREATE PROCEDURE [aec_DAL_Core_DeleteScheduledJob]
	@pJobName nvarchar(90) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	DECLARE @DBName sysname;
	SET @DBName = DB_NAME();

	DECLARE @JobName nvarchar(128);
	SET @JobName = @DBName + '-' + @pJobName;

	BEGIN TRANSACTION

	--Ensure job exists
	EXEC @ReturnCode = msdb.dbo.sp_help_job @job_name = @JobName, @job_aspect = 'JOB';
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

	--Delete the job
	EXEC @ReturnCode = msdb.dbo.sp_delete_job 
			@job_name = @JobName,
			@delete_unused_schedule = 1;
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
					
	COMMIT TRANSACTION

	GOTO EndSave

	QuitWithRollback:
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION

	EndSave:

	RETURN @ReturnCode

END

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_Core_DeleteScheduledJob]
	TO [V6N14816rwZf]
GO
