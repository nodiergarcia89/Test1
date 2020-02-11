SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [aecSaveAssignmentPlan] (
			@nKey INTEGER,
			@nStartDate INTEGER,
			@nEndDate INTEGER,
			@dHours FLOAT,
			@tLastEdit NVARCHAR (30),
			@nExcludeNonWorking SMALLINT = -1) 

AS
--Purpose
--    Populates the AssignmentPlan Table with averaged daily planned time (based on the resources Locale Calendar)
--    for the passed Assignment, skipping days flagged as none working in the locale calendar
--    The assignmentPlan table allows assignments planned time to be divided into smaller time periods easily
--Behaviour
--    If no working days exist in the period then all days in the period are included in the averaged daily planned time
--Parameters
--    nKey, AS_Key for which AssignmentPlan is to be populated
--    nStartDate, First date of the Assignment
--    nEndDate, Last Date of the Assignment
--    dHours, Total Effort for the Assignment
--    tLastEdit, Lastedit Stamp to be saved for each day
--    nExcludeNonWorking, True if Nonworking days are to be skipped
--		       False if nonworking / working day status of days is to be ignored
DECLARE @nNonWorking INTEGER
DECLARE @nWorking FLOAT
DECLARE @nAverageDays INTEGER
DECLARE @dAverageHours FLOAT

DECLARE @resLocaleCode NVARCHAR(20)
DECLARE @periodFTE FLOAT

-- Delete existing entries first
DELETE FROM AssignmentPlan WHERE AS_Key = @nKey


-- Get the locale used by the resource of the assignment
SELECT @resLocaleCode = Res.LH_Code 
FROM Res
INNER JOIN Assignment ON (Res.RE_Code = Assignment.RE_Code)
WHERE Assignment.AS_Key = @nKey


-- get count of non-working days in period
SELECT @nNonWorking = COUNT(*) 
FROM LocaleCalendar
WHERE LH_Code = @resLocaleCode
	AND LC_Date >= @nStartDate 
	AND LC_Date <= @nEndDate
	AND LC_FTE = 0

-- SUM the working days FTE in period
SELECT @nWorking = SUM(LC_FTE)
FROM LocaleCalendar
WHERE LH_Code = @resLocaleCode
	AND LC_Date >= @nStartDate 
	AND LC_Date <= @nEndDate

-- if we are including non-working days then we need to add each non-working day
-- as a full working day into the SUM of the FTE
IF (@nExcludeNonWorking = 0)
	BEGIN
		SET @nWorking = @nWorking + @nNonWorking
	END

-- Perform Inserts
IF (@nWorking = 0)
	
	BEGIN
		-- If there are no working days in the period, distribute hours across each non-working day
		SELECT 
			@nAverageDays = (@nEndDate - @nStartDate) + 1

		SELECT
			@dAverageHours = (@dHours / @nAverageDays)
	
		INSERT INTO AssignmentPlan (AS_Key, AP_Date, AP_Work, AP_LastEdit)
			SELECT
				@nKey,
				LC_Date,
				@dAverageHours,
				@tLastEdit
			FROM
				LocaleCalendar
			WHERE
				LH_Code = @resLocaleCode
				AND LC_Date >= @nStartDate 
				AND LC_Date <= @nEndDate

	END

ELSE
	BEGIN

		SELECT @periodFTE = SUM(LC_FTE)
		FROM LocaleCalendar 
		WHERE LH_Code = @resLocaleCode 
			AND LC_Date >= @nStartDate 
			AND LC_Date <= @nEndDate
			AND LC_FTE > 0

		-- Calculate the avarage hours from the number of hours in the period from the Locale Calendar FTE values
		SELECT
			@dAverageHours = (@dHours / @periodFTE)

		-- Do not include non-working days
		INSERT INTO AssignmentPlan (AS_Key, AP_Date, AP_Work, AP_LastEdit)
			SELECT
				@nKey,
				LC_Date,
				CASE @nExcludeNonWorking
					WHEN 0 THEN (@dAverageHours * (CASE LC_FTE WHEN 0 THEN 1 ELSE LC_FTE END))
					ELSE (@dAverageHours * LC_FTE)
				END,
				@tLastEdit
			FROM
				LocaleCalendar
			WHERE
				LH_Code = @resLocaleCode
				AND LC_Date >= @nStartDate 
				AND LC_Date <= @nEndDate
				AND LC_FTE > 0

	END

GO
GRANT EXECUTE
	ON [dbo].[aecSaveAssignmentPlan]
	TO [V6N14816rwZf]
GO
