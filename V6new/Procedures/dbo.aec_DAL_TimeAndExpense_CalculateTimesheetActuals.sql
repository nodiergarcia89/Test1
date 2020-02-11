SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

--TL4s
CREATE PROCEDURE [dbo].[aec_DAL_TimeAndExpense_CalculateTimesheetActuals]
	-- Add the parameters for the stored procedure here
	@pActualsMode int = 1,
	@pAllProjects bit = 0,
	@pMasterProjectCode nvarchar(20) = NULL, 
	@pStartDate float = 0,
	@pEndDate float = 2958465 -- Dec 31 9999
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--Declare copies of parameters as local variables to avoid performance issues caused by parameter sniffing
	DECLARE @ActualsMode int;
	DECLARE @AllProjects bit;
	DECLARE @MasterProjectCode nvarchar(20);
	DECLARE @StartDate float;
	DECLARE @EndDate float;

	SET @ActualsMode = @pActualsMode;
	SET @AllProjects = @pAllProjects;
	SET @MasterProjectCode = @pMasterProjectCode;
	SET @StartDate = @pStartDate;
	SET @EndDate = @pEndDate;

	--Delete existing values;
	DELETE FROM 
		ProjectTSActuals 
	WHERE
		PP_StartDate >= @StartDate AND
		PP_EndDate <= @EndDate AND
		(PR_Code IN (Select SubPR FROM ProjectRelations WHERE MasterPR = @MasterProjectCode)
		 OR @AllProjects = 1);
	
	IF (@pActualsMode = 1)
		BEGIN
			-- Place actuals into the month in which they were incurred

			-----------------------------------------------------------------------------------------------
			--	
			--	deal with Actuals in open periods.
			--	Sweep up Unlocked Actuals for periods that have been Locked into the first open
			--	period, so we will modify this code accordingly.
			--	In order to avoid a combination of INSERT and UPDATE statements we do an INSERT for future 
			--	timesheets AFTER the first open week and then do a separate INSERT to get timesheets IN the
			--	first open week PLUS unlocked timesheets in locked weeks.
			-----------------------------------------------------------------------------------------------

			-- Get the end date of the first planning period for the first open date.
			-- This is becasue the first open period may not be a full week but a second half of a split.
			DECLARE @firstOpenPeriodEndDate float;
			SELECT @firstOpenPeriodEndDate = PP_EndDate from PlanningPeriod where PP_StartDate =  @StartDate

			IF (@firstOpenPeriodEndDate is null)
				--if a date has not been provided then all timesheets are included
				BEGIN
					SET @firstOpenPeriodEndDate = 0
				END

			-- Timesheets AFTER the first open week
			INSERT INTO ProjectTSActuals (
				PR_Code,				
				RE_Code,
				RE_CodeRole,
				DE_Code,
				PP_StartDate,
				PP_EndDate,
				PA_Hours,
				PA_Cost,
				PA_Charge
			)
			SELECT
				TS.PR_Code, 
				TS.RE_Code, 
				TS.RE_CodeRole, 
				TS.DE_Code, 
				PP.PP_StartDate, 
				PP.PP_EndDate,
				SUM(TS.TS_Hours), 
				SUM(TS.TS_Hours * TS.TS_CostRateAmt),
				SUM(
						CASE TS.TS_Chargeable 
							WHEN -1 THEN TS.TS_Hours * TS.TS_ChargeRateAmt
							ELSE 0
						END
					)
			FROM
				Timesht TS
				INNER JOIN PlanningPeriod PP ON TS.TS_Date >= PP.PP_StartDate AND TS.TS_Date <= PP.PP_EndDate 
				INNER JOIN ProjectRelations ON TS.PR_Code = ProjectRelations.SubPR
			WHERE
				(ProjectRelations.MasterPR = @MasterProjectCode OR (@AllProjects = 1 AND ProjectRelations.MasterPR = ProjectRelations.SubPR))
				AND PP_StartDate >= @firstOpenPeriodEndDate + 1 --@StartDate + 7
				AND PP_EndDate <= @EndDate
				AND TS.TS_Approved = -1
			GROUP BY
				TS.PR_Code, 
				TS.RE_Code, 
				TS.RE_CodeRole, 
				TS.DE_Code, 
				PP.PP_StartDate, 
				PP.PP_EndDate;				

			-- Timesheets IN the first open week PLUS unlocked timesheets in locked weeks.
			INSERT INTO ProjectTSActuals (
				PR_Code,				
				RE_Code,
				RE_CodeRole,
				DE_Code,
				PP_StartDate,
				PP_EndDate,
				PA_Hours,
				PA_Cost,
				PA_Charge
			)
			SELECT
				TS.PR_Code, 
				TS.RE_Code, 
				TS.RE_CodeRole, 
				TS.DE_Code, 
				@StartDate, 
				@firstOpenPeriodEndDate, --@StartDate + 6,
				SUM(TS.TS_Hours), 
				SUM(TS.TS_Hours * TS.TS_CostRateAmt),
				SUM(
						CASE TS.TS_Chargeable 
							WHEN -1 THEN TS.TS_Hours * TS.TS_ChargeRateAmt
							ELSE 0
						END
					)
			FROM
				Timesht TS
				INNER JOIN PlanningPeriod PP ON TS.TS_Date >= PP.PP_StartDate AND TS.TS_Date <= PP.PP_EndDate 
				INNER JOIN ProjectRelations ON TS.PR_Code = ProjectRelations.SubPR
			WHERE
				(ProjectRelations.MasterPR = @MasterProjectCode OR (@AllProjects = 1 AND ProjectRelations.MasterPR = ProjectRelations.SubPR))
				AND PP_EndDate <= @firstOpenPeriodEndDate --@StartDate + 6
				AND TS.TS_Approved = -1
				AND TS.CP_Key IS NULL
			GROUP BY
				TS.PR_Code, 
				TS.RE_Code, 
				TS.RE_CodeRole, 
				TS.DE_Code;

		END
	ELSE
		BEGIN
			-- Use close periods for actuals
			INSERT INTO ProjectTSActuals (
				PR_Code,
				RE_Code,
				RE_CodeRole,
				DE_Code,
				PP_StartDate,
				PP_EndDate,
				PA_Hours,
				PA_Cost,
				PA_Charge
			)
			SELECT
				TS.PR_Code, 
				TS.RE_Code, 
				TS.RE_CodeRole, 
				TS.DE_Code, 
				PP.PP_StartDate, 
				PP.PP_EndDate,
				SUM(TS.TS_Hours) / MAX(PPPeriodCount), 
				SUM(TS.TS_Hours * TS.TS_CostRateAmt)  / MAX(PPPeriodCount),
				SUM(
						CASE TS.TS_Chargeable 
							WHEN -1 THEN TS.TS_Hours * TS.TS_ChargeRateAmt
							ELSE 0
						END
					)  / MAX(PPPeriodCount)
			FROM
				Timesht TS
				INNER JOIN ProjectRelations ON TS.PR_Code = ProjectRelations.SubPR
				INNER JOIN ClosePeriod CP ON TS.CP_Key = CP.CP_Key
				INNER JOIN PlanningPeriod PP ON CP.PP_Month = PP.PP_Month
				INNER JOIN 
					(
						SELECT 
							PP_Month, COUNT(PP_StartDate) As PPPeriodCount 
						FROM 
							PlanningPeriod
						GROUP BY
							PP_Month
					) PPCount ON PP.PP_Month = PPCount.PP_Month								
			WHERE
				(ProjectRelations.MasterPR = @MasterProjectCode OR (@AllProjects = 1 AND ProjectRelations.MasterPR = ProjectRelations.SubPR)) AND
				PP_StartDate >= @StartDate AND
				PP_EndDate <= @EndDate AND
				TS.TS_Approved = -1
			GROUP BY
				TS.PR_Code, 
				TS.RE_Code, 
				TS.RE_CodeRole, 
				TS.DE_Code, 
				PP.PP_StartDate, 
				PP.PP_EndDate;

		END
	--END IF (@ActualsMode = 1)
END
GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_TimeAndExpense_CalculateTimesheetActuals]
	TO [V6N14816rwZf]
GO
