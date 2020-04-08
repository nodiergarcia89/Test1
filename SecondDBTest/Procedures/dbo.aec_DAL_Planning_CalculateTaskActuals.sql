SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--PR2e

--PR3s
CREATE PROCEDURE [aec_DAL_Planning_CalculateTaskActuals]
	@pProjectCode nvarchar(20) = NULL	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Set the all Projects flag (apply to all projects if @pProjectCode is null)
	DECLARE @allProjects bit;

	IF (@pProjectCode IS NULL)
		BEGIN
			SET @allProjects = 1;
		END
	ELSE
		SET @allProjects = 0;

	-- Set the Task Actual work figures based on Timesheet values
	IF (@allProjects = 1)
	BEGIN
		UPDATE Task 
		SET Task.TA_ActualWork = 
			(SELECT SUM(Timesht.TS_Hours / Res.RE_DayLength) 
			FROM Timesht 
			INNER JOIN Res ON Timesht.RE_Code = Res.RE_Code WHERE Timesht.TA_Key = Task.TA_Key) 		
	END
	ELSE
	BEGIN
		UPDATE Task 
		SET Task.TA_ActualWork = 
			(SELECT SUM(Timesht.TS_Hours / Res.RE_DayLength) 
			FROM Timesht 
			INNER JOIN Res ON Timesht.RE_Code = Res.RE_Code WHERE Timesht.TA_Key = Task.TA_Key) 
		WHERE Task.PR_Code = @pProjectCode
	END

	--    'Determine whether time should be tracked against Assignments	
	IF (@allProjects = 1)
	BEGIN
		UPDATE Assignment 
		SET Assignment.AS_ActualWork = 
			(SELECT SUM(Timesht.TS_Hours / Res.RE_DayLength) 
			FROM Timesht 
			INNER JOIN Res ON Timesht.RE_Code = Res.RE_Code WHERE Timesht.AS_Key = Assignment.AS_Key) 
		FROM Assignment
		INNER JOIN Task ON Task.TA_Key = Assignment.TA_Key
		INNER JOIN Projects ON Projects.PR_Code = Task.PR_Code		
		WHERE Projects.PR_UseAssignments = -1
	END
	ELSE
	BEGIN
		UPDATE Assignment 
		SET Assignment.AS_ActualWork = 
			(SELECT SUM(Timesht.TS_Hours / Res.RE_DayLength) 
			FROM Timesht 
			INNER JOIN Res ON Timesht.RE_Code = Res.RE_Code WHERE Timesht.AS_Key = Assignment.AS_Key) 
		FROM Assignment
		INNER JOIN Task ON Task.TA_Key = Assignment.TA_Key
		INNER JOIN Projects ON Projects.PR_Code = Task.PR_Code		
		WHERE Projects.PR_UseAssignments = -1
		AND Task.PR_Code = @pProjectCode		
	END	

	--    'Ensure values are rolled up through the Task network
	IF (@allProjects = 1)
	BEGIN

		UPDATE Task SET
		TA_StartDate = T2.TA_StartDate,
		TA_EndDate = T2.TA_EndDate, 
		TA_Work = T2.TA_Work 
		FROM Task T1 INNER JOIN 
		(
			SELECT TP.TA_Key, 
			MIN(TC.TA_StartDate) AS TA_StartDate, 
			MAX(TC.TA_EndDate) AS TA_EndDate, 
			SUM(ISNULL(TC.TA_Work, 0)) AS TA_Work 
			FROM Task TP 
			INNER JOIN Task TC ON TP.PR_Code = TC.PR_Code AND TP.PPC_Version = TC.PPC_Version AND TC.TA_OutlineNumber LIKE TP.TA_OutlineNumber + '.%' 
			WHERE TP.TA_Summary = -1 
			AND TC.TA_Summary = 0 
			AND TC.TA_Empty = 0 
			AND (TC.TA_SystemFlag IS NULL  OR TC.TA_SystemFlag = 0)   --   0 is TaskBasedScheduling
			AND TC.TA_Active = -1 			
			GROUP BY TP.TA_Key 
		) T2 ON T1.TA_Key = T2.TA_Key


		UPDATE Task SET 
		TA_ActualWorkRollup = T2.TA_ActualWork 
		FROM Task T1 INNER JOIN 
		(
			SELECT TP.TA_Key, 
			SUM(ISNULL(TC.TA_ActualWork, 0)) AS TA_ActualWork 
			FROM Task TP INNER JOIN Task TC ON TP.PR_Code = TC.PR_Code AND TP.PPC_Version = TC.PPC_Version AND TC.TA_OutlineNumber LIKE TP.TA_OutlineNumber + '.%' 
			WHERE TP.TA_Summary = -1 
			AND TC.TA_Empty = 0 
			AND (TC.TA_SystemFlag IS NULL  OR TC.TA_SystemFlag = 0)   --   0 is TaskBasedScheduling
			AND TC.TA_Active = -1 			
			GROUP BY TP.TA_Key 
		) T2 ON T1.TA_Key = T2.TA_Key 

	END
	ELSE
	BEGIN

		UPDATE Task SET
		TA_StartDate = T2.TA_StartDate,
		TA_EndDate = T2.TA_EndDate, 
		TA_Work = T2.TA_Work 
		FROM Task T1 INNER JOIN 
		(
			SELECT TP.TA_Key, 
			MIN(TC.TA_StartDate) AS TA_StartDate, 
			MAX(TC.TA_EndDate) AS TA_EndDate, 
			SUM(ISNULL(TC.TA_Work, 0)) AS TA_Work 
			FROM Task TP 
			INNER JOIN Task TC ON TP.PR_Code = TC.PR_Code AND TP.PPC_Version = TC.PPC_Version AND TC.TA_OutlineNumber LIKE TP.TA_OutlineNumber + '.%' 
			WHERE TP.PR_Code = @pProjectCode			
			AND TP.TA_Summary = -1 
			AND TC.TA_Summary = 0 
			AND TC.TA_Empty = 0 
			AND (TC.TA_SystemFlag IS NULL  OR TC.TA_SystemFlag = 0)   --   0 is TaskBasedScheduling
			AND TC.TA_Active = -1 			
			GROUP BY TP.TA_Key 
		) T2 ON T1.TA_Key = T2.TA_Key 


		UPDATE Task SET 
		TA_ActualWorkRollup = T2.TA_ActualWork 
		FROM Task T1 INNER JOIN 
		(
			SELECT TP.TA_Key, 
			SUM(ISNULL(TC.TA_ActualWork, 0)) AS TA_ActualWork 
			FROM Task TP INNER JOIN Task TC ON TP.PR_Code = TC.PR_Code AND TP.PPC_Version = TC.PPC_Version AND TC.TA_OutlineNumber LIKE TP.TA_OutlineNumber + '.%' 
			WHERE TP.PR_Code = @pProjectCode
			AND	TP.TA_Summary = -1 
			AND TC.TA_Empty = 0 
			AND (TC.TA_SystemFlag IS NULL  OR TC.TA_SystemFlag = 0)   --   0 is TaskBasedScheduling
			AND TC.TA_Active = -1 			
			GROUP BY TP.TA_Key 
		) T2 ON T1.TA_Key = T2.TA_Key 

	END

END

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_Planning_CalculateTaskActuals]
	TO [V6N14816rwZf]
GO
