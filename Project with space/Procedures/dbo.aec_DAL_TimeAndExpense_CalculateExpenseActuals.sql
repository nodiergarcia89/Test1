SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [aec_DAL_TimeAndExpense_CalculateExpenseActuals]
	-- Add the parameters for the stored procedure here
	@pActualsMode int = 1,
	@pAllProjects bit = 0,
	@pMasterProjectCode nvarchar(20) = NULL, 
	@pStartDate float = 0, -- Dec 30 1899
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
		ProjectExpActuals 
	WHERE
		PP_StartDate >= @StartDate AND
		PP_EndDate <= @EndDate AND
		(PR_Code IN (Select SubPR FROM ProjectRelations WHERE MasterPR = @MasterProjectCode)
		 OR @AllProjects = 1);

	IF (@ActualsMode = 1)
		BEGIN
			-- Insert Acuals into period incurred

			-----------------------------------------------------------------------------------------------
			--	
			--	deal with Actuals in open periods.
			--	sweep up Unlocked Actuals for periods that have been Locked into the first open
			--	period, so we will modify this code accordingly.
			--	In order to avoid a combination of INSERT and UPDATE statements we do an INSERT for future 
			--	expenses AFTER the first open week and then do a separate INSERT to get expenses IN the
			--	first open week PLUS unlocked expenses in locked weeks.
			-----------------------------------------------------------------------------------------------

			-- Expenses AFTER the first open week
			INSERT INTO ProjectExpActuals (
				PR_Code,
				RE_Code,
				DE_Code,
				TY_Code,
				CC_Code,
				PP_StartDate,
				PP_EndDate,
				PEA_Cost
			)
			SELECT
				EX.PR_Code, 
				EX.RE_Code, 
				EX.DE_Code, 
				EX.TY_Code, 
				EX.CC_Code, 
				PP.PP_StartDate, 
				PP.PP_EndDate, 
				SUM(EX.EX_Net)
			FROM
				Expense EX 
				INNER JOIN ProjectRelations ON EX.PR_Code = ProjectRelations.SubPR
				INNER JOIN PlanningPeriod PP ON EX.EX_Date >= PP.PP_StartDate AND EX.EX_Date <= PP.PP_EndDate
			WHERE 
				(ProjectRelations.MasterPR = @MasterProjectCode OR (@AllProjects = 1 AND ProjectRelations.MasterPR = ProjectRelations.SubPR))
				AND PP_StartDate >= @StartDate + 7
				AND PP_EndDate <= @EndDate
				AND EX.EX_Approved = -1
			GROUP BY
				EX.PR_Code, 
				EX.RE_Code, 
				EX.DE_Code, 
				EX.TY_Code, 
				EX.CC_Code, 
				PP.PP_StartDate, 
				PP.PP_EndDate;

			-- Expenses IN the first open week PLUS unlocked expenses in locked weeks.
			INSERT INTO ProjectExpActuals (
				PR_Code,
				RE_Code,
				DE_Code,
				TY_Code,
				CC_Code,
				PP_StartDate,
				PP_EndDate,
				PEA_Cost
			)
			SELECT
				EX.PR_Code, 
				EX.RE_Code, 
				EX.DE_Code, 
				EX.TY_Code, 
				EX.CC_Code, 
				@StartDate, 
				@StartDate + 6,
				SUM(EX.EX_Net)
			FROM
				Expense EX 
				INNER JOIN ProjectRelations ON EX.PR_Code = ProjectRelations.SubPR
				INNER JOIN PlanningPeriod PP ON EX.EX_Date >= PP.PP_StartDate AND EX.EX_Date <= PP.PP_EndDate
			WHERE 
				(ProjectRelations.MasterPR = @MasterProjectCode OR (@AllProjects = 1 AND ProjectRelations.MasterPR = ProjectRelations.SubPR))
				AND PP_EndDate <= @StartDate + 6
				AND EX.EX_Approved = -1
				AND EX.CP_Key IS NULL
			GROUP BY
				EX.PR_Code, 
				EX.RE_Code, 
				EX.DE_Code, 
				EX.TY_Code, 
				EX.CC_Code;
		END
	ELSE
		BEGIN
			--Use close periods
			INSERT INTO ProjectExpActuals (
				PR_Code,
				RE_Code,
				DE_Code,
				TY_Code,
				CC_Code,
				PP_StartDate,
				PP_EndDate,
				PEA_Cost
			)
			SELECT
				EX.PR_Code, 
				EX.RE_Code, 
				EX.DE_Code, 
				EX.TY_Code, 
				EX.CC_Code, 
				PP.PP_StartDate, 
				PP.PP_EndDate, 
				SUM(EX.EX_Net) / MAX(PPPeriodCount)
			FROM
				Expense EX 
				INNER JOIN ProjectRelations ON EX.PR_Code = ProjectRelations.SubPR
				INNER JOIN ClosePeriod CP ON EX.CP_Key = CP.CP_Key
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
				EX.EX_Approved = -1
			GROUP BY
				EX.PR_Code, 
				EX.RE_Code, 
				EX.DE_Code, 
				EX.TY_Code, 
				EX.CC_Code, 
				PP.PP_StartDate, 
				PP.PP_EndDate;

		END
	--END IF (@pActualsMode - 1)

END

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_TimeAndExpense_CalculateExpenseActuals]
	TO [V6N14816rwZf]
GO
