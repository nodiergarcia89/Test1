SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- Stored procedure to return scheduled jobs for this database
CREATE PROCEDURE [aec_DAL_Core_GetScheduledJobs]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DBName sysname;
	SET @DBName = DB_NAME();

	EXEC msdb.dbo.sp_help_job @category_name = N'Atlantic Global OnDemand', @description = @DBName;
END

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_Core_GetScheduledJobs]
	TO [V6N14816rwZf]
GO
