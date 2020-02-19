SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



--Stored Procedure to calculate Time and Expense Actuals based on System Configuration settings
CREATE PROCEDURE [aec_BL_TimeAndExpense_CalculateActuals]
	@pUserCode nvarchar(20) = '',
	@pMasterProjectCode nvarchar(20) = NULL, 
	@pStartDate float = 0,
	@pEndDate float = 2958465
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	DECLARE @intActualsOptions int;
	SET @intActualsOptions = ISNULL((SELECT SP_Number FROM SystemParams WHERE SP_Code = 'CV-ACTUALSOPTIONS'),0);

	DECLARE @intActualsMode int;
	--JS22s
	SET @intActualsMode = ISNULL((SELECT SP_Number FROM SystemParams WHERE SP_Code = 'CV-ACTUALSMODE'),1);
	--SET @intActualsOptions = ISNULL((SELECT SP_Number FROM SystemParams WHERE SP_Code = 'CV-ACTUALSMODE'),1);
	--J22e
	
	DECLARE @dblFirstOpenMonth float;
	SET @dblFirstOpenMonth = ISNULL((SELECT SP_Number FROM SystemParams WHERE SP_Code = 'CV-LOCKDATE'),0);

	-- Set the all Projects flag (apply to all projects if @pMasterProjectCode is null)
	DECLARE @allProjects bit;
	IF (@pMasterProjectCode IS NULL)
		BEGIN
			SET @allProjects = 1;
		END
	ELSE
		SET @allProjects = 0;


	DECLARE @dblLastLockedDate float;

	IF (@intActualsMode = 2)
		BEGIN
			SET @dblLastLockedDate = ISNULL((SELECT MAX(PP_EndDate) FROM PlanningPeriod WHERE PP_Month < @dblFirstOpenMonth), -1);
		END
	ELSE
		BEGIN
			SET @dblLastLockedDate = -1;
		END

	DECLARE @dblFirstOpenDate float;
	SET @dblFirstOpenDate = @dblLastLockedDate + 1;
	
	IF (@intActualsOptions & 1) > 0
	BEGIN
		--Calculate Timesheet Actuals
		IF (@intActualsMode = 1)
			BEGIN
				--Use Month incurred
				EXEC aec_DAL_TimeAndExpense_CalculateTimesheetActuals 1, @allProjects, @pMasterProjectCode, @pStartDate, @pEndDate;
			END
		ELSE
			BEGIN			
				--Use Close Periods for locked months
				IF @pEndDate > @dblLastLockedDate
					BEGIN
						--Use Close Periods for locked months
						EXEC aec_DAL_TimeAndExpense_CalculateTimesheetActuals 2, @allProjects, @pMasterProjectCode, @pStartDate, @dblLastLockedDate;

						--Use Period incurred for unlocked months
						EXEC aec_DAL_TimeAndExpense_CalculateTimesheetActuals 1, @allProjects, @pMasterProjectCode, @dblFirstOpenDate, @pEndDate;
					END
				ELSE
					BEGIN
						--Use Close Periods for passed date range
						EXEC aec_DAL_TimeAndExpense_CalculateTimesheetActuals 2, @allProjects, @pMasterProjectCode, @pStartDate, @pEndDate;
					END				
			END
	END


	IF (@intActualsOptions & 2) > 0
	BEGIN
		--Calculate Expense Actuals
		IF (@intActualsMode = 1)
			BEGIN
				--Use Month incurred
				EXEC aec_DAL_TimeAndExpense_CalculateExpenseActuals 1, @allProjects, @pMasterProjectCode, @pStartDate, @pEndDate;
			END
		ELSE
			BEGIN			
				--Use Close Periods for locked months
				IF @pEndDate > @dblLastLockedDate
					BEGIN
						--Use Close Periods for locked months
						EXEC aec_DAL_TimeAndExpense_CalculateExpenseActuals 2, @allProjects, @pMasterProjectCode, @pStartDate, @dblLastLockedDate;

						--Use Period incurred for unlocked months
						EXEC aec_DAL_TimeAndExpense_CalculateExpenseActuals 1, @allProjects, @pMasterProjectCode, @dblFirstOpenDate, @pEndDate;
					END
				ELSE
					BEGIN
						--Use Close Periods for passed date range
						EXEC aec_DAL_TimeAndExpense_CalculateExpenseActuals 2, @allProjects, @pMasterProjectCode, @pStartDate, @pEndDate;
					END				
			END
	END

	--Update Project Timestamps
	DELETE FROM 
		ProjectActualsUpdated
	WHERE
		PR_Code IN (Select SubPR FROM ProjectRelations WHERE MasterPR = @pMasterProjectCode)
		 OR @allProjects = 1;

	
	DECLARE @dblNow float;
	SET @dblNow = CONVERT(float, GETDATE()) + 2;

	--Update Project Actuals Timestamps
	INSERT INTO ProjectActualsUpdated (
		PR_Code, 
		PAU_LastUpdatedBy, 
		PAU_LastUpdated
	)
	SELECT
		SubPR,
		@pUserCode,
		@dblNow
	FROM		
		ProjectRelations 
	WHERE 
		(MasterPR = @pMasterProjectCode OR (@allProjects = 1 AND MasterPR = SubPR));

	-- Recalculate Project Custom Measures
	DECLARE @lngTriggerTypes AS BIGINT
	SET @lngTriggerTypes = POWER(2, 20)
	EXEC aec_BL_Core_UpdateCustomMeasures @pEntity=1001, @pTriggerTypes=@lngTriggerTypes, @pCode=@pMasterProjectCode

END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_TimeAndExpense_CalculateActuals]
	TO [V6N14816rwZf]
GO
