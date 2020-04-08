SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/**************************************************************************************************************************************
											  KeyedIn Projects Database Upgrade Script 
														v6.2 to v6.2_hotfix1
***************************************************************************************************************************************

TL1 - 04/04/2017
	Mod - Adjust will recreate a WIP version if one exists
	
TL2 - 04/04/2017
	Mod - Delete from PortfolioProjects and Portfolio Forecasts when removing projects	

TL3 - 05/04/2015 
	Mod - Adjust Date and Exclude/Include will update the last edit date of the WIP

TL4, - 09/06/2017
	Fix, Placing Actuals in the month they were incurred with a start date that doesn't match a planninng period start
		(the dashboards pass in a min and max dates instead of null values - this meant the @firstOpenPeriodEndDate was not being set correctly)
	
**************************************************************************************************************************************/	

CREATE PROCEDURE AdjustPortfolioDemandByMonth
	@Month  float,
	@UsCode	nvarchar(20),
	@PSCKey int OUTPUT,
	@PSFKey int OUTPUT,
	@Error smallint OUTPUT,
	@ErrorText nvarchar(4000) OUTPUT
AS
	--Delcare tables
	DECLARE @tempDemandDetail TABLE (
		ID int IDENTITY (1, 1),
		PFDLKey int,
		PPMonth int,
		PFDDDays float,
		PFDDFTE float,
		PFDDLocalCost float,
		PFDDSystemCost float,
		PFDDLocalCharge float,
		PFDDSystemCharge float,
		PFDDStatus int,
		PPIncludedDays float
	);

	DECLARE @PFLKey int;
	DECLARE @PFOKey int;
	DECLARE @OldPSFKey int;
	DECLARE @NewPSCKey int;
	DECLARE @CurrentIndex as int;
	DECLARE @MaxIndex as int;

	SELECT @CurrentIndex = COALESCE(MIN(ID), -1) FROM @tempDemandDetail;
	SELECT @MaxIndex = COALESCE(MAX(ID), -1) from @tempDemandDetail;

	DECLARE @MonthDays float;
	DECLARE @MonthLocalCost float;
	DECLARE @MonthLocalCharge float;
	DECLARE @MonthSystemCost float;
	DECLARE @MonthSystemCharge float;
	DECLARE @MonthStatus float;

	DECLARE @CurrentMonth float;
	DECLARE @PeriodStartDate float;
	DECLARE @CurrentPFDLKey float;
	DECLARE @LHCode nvarchar(40);

	DECLARE @DailyDays float;
	DECLARE @DailyLocalCost float;
	DECLARE @DailyLocalCharge float;
	DECLARE @DailySystemCost float;
	DECLARE @DailySystemCharge float;

	DECLARE @PeriodDays float;
	DECLARE @PeriodLocalCost float;
	DECLARE @PeriodLocalCharge float;
	DECLARE @PeriodSystemCost float;
	DECLARE @PeriodSystemCharge float;
	DECLARe @PeriodFte float;

	DECLARE @IncludedDays float;
	DECLARE @MonthIncludedDays float;
	DECLARE @Fte float;

	SET @CurrentMonth = @Month;
	SET @PeriodStartDate = 0;
	
	DECLARE @MonthDiff int;

	select	@PFLKey = PSFV.PFL_Key,
			@PFOKey = PSFV.PFO_Key
	FROM PortfolioScenarioForecastView PSFV
	WHERE	PSFV.PSC_Key = @PSCKey
			AND PSFV.PSF_Key = @PSFKey;

	SET @OldPSFKey = @PSFKey;
	SET @Error = 0;
	SET @ErrorText = ' ';

	BEGIN TRY
		BEGIN TRANSACTION;

		--Check if work in progress exists. If not create it from specified scenario key
		IF NOT EXISTS( 
						SELECT	1
						FROM	PortfolioScenario PSC
						WHERE	PFL_Key = @PFLKey
						AND		PSC_Version = -1
					  )
			BEGIN
				EXEC CreateWIPPortfolioScenario @PFLKey, @UsCode, @PSCKey, @NewPSCKey OUTPUT;
				SET @PSCKey = @NewPSCKey;
				
			END;
		ELSE
			--WIP already exists. Delete and recreate from the current version
			BEGIN
				DECLARE @CurrentWIPKey int;
				-- Get the PortfolioScenarion WIP Key
				SELECT	@CurrentWIPKey = PSC_Key
						FROM	PortfolioScenario PSC
						WHERE	PFL_Key = @PFLKey
								AND PSC_Version = -1
				
				IF @CurrentWIPKey <> @PSCKey
					BEGIN
						-- We are not amending the current WIP
						-- Delete the current WIP and re-create. (User should be aware this happening).
						EXEC DeletePortfolioScenario @CurrentWIPKey, 0;
						
						-- Create the WIP
						EXEC CreateWIPPortfolioScenario @PFLKey, @UsCode, @PSCKey, @NewPSCKey OUTPUT;
						SET @PSCKey = @NewPSCKey;	
										
					END; 						
				ELSE
					BEGIN
						-- updateing the current WIP
						-- Delete any report cache items
						Delete From ReportCache Where PSC_Key = @CurrentWIPKey;
						
						-- update the Last edit date on the wip 
						UPDATE PortfolioScenario SET PSC_LastEditOn = Cast(GETDATE() +2 as float)
						WHERE PSC_Key = @CurrentWIPKey;
						
					END;
			END;
			

		--Check if a record already exists for current scenario forecast. If not create it
		IF NOT EXISTS( SELECT 1 FROM PortfolioScenarioForecast WHERE PSC_Key = @PSCKey AND PFO_Key = @PFOKey)
			BEGIN
			
				INSERT INTO PortfolioScenarioForecast (PFO_Key, PSC_Key, PSF_Included, PSF_Score, PSF_StartDate)
				SELECT @PFOKey, @PSCKey, PSFV.PSF_Included, PSFV.PSF_Score, @Month
				FROM	PortfolioScenarioForecastView PSFV
				WHERE	PFO_Key = @PFOKey
						AND PSC_Key = @PSCKey;

				set @PSFKey = SCOPE_IDENTITY();
		
				DECLARE @tempPSFKey int;
				set @tempPSFKey = @OldPSFKey;

				--Check if we have any data in previous version of forecast for this scenario. If it does, copy this data, otherwise use the base data
				if NOT EXISTS (	Select	1
							FROM	PortfolioForecastDemandLine
							WHERE	PSF_Key = @OldPSFKey)
					BEGIN
						SELECT	@tempPSFKey = PSFVBase.PSF_Key
						FROM	PortfolioScenarioForecastView PSFV
								JOIN PortfolioScenarioForecastView PSFVBase
									on PSFVBase.PFL_Key = PSFV.PFL_Key
									AND PSFVBase.PFO_Key = PSFV.PFO_Key
						WHERE	PSFV.PSF_Key = @OldPSFKey;
					END;			

				--Copy over any custom field data
				EXEC InsertPortfolioCustomFieldData @tempPSFKey, @PSFKey;

				--Copy over any demand data
				EXEC InsertPortfolioDemand @tempPSFKey, @PSFKey;
			END;
		ELSE
			BEGIN
				--If scenario exists then  update the record for the scenario forecast
				UPDATE	PortfolioScenarioForecast
				SET		PSF_StartDate = @Month
				WHERE	PFO_Key = @PFOKey
						AND PSC_Key = @PSCKey;

				SELECT	@PSFKey = PSF_Key
				FROM	PortfolioScenarioForecast
				WHERE	PFO_Key = @PFOKey
						AND PSC_Key = @PSCKey;
			END;

			
		--Insert current data grouped by month into table variable
		INSERT INTO @tempDemandDetail (PFDLKey, PPMonth, PFDDDays, PFDDFTE, PFDDLocalCost, PFDDLocalCharge, PFDDSystemCost, PFDDSystemCharge, PFDDStatus, PPIncludedDays)
		SELECT	PFDL.PFDL_Key,
				PP.PP_Month,
				SUM(PFDD.PFDD_Days),
				(SUM(PFDD.PFDD_Days) / SUM(LS.LS_Days)) * MAX(LH.LH_FTE),
				SUM(PFDD.PFDD_LocalCharge),
				SUM(PFDD.PFDD_LocalCost),
				SUM(PFDD.PFDD_SystemCost),
				SUM(PFDD.PFDD_SystemCharge),
				FLOOR(SUM(PFDD.PFDD_Status) / COUNT(1)),
				SUM(LS_Days)
		FROM	PortfolioForecastDemandLine PFDL
				JOIN PortfolioForecastDemandDetail PFDD
					on PFDD.PFDL_Key = PFDL.PFDL_Key
					AND PFDL.PSF_Key = @PSFKey
				JOIN PlanningPeriod PP
					on PP.PP_StartDate = PFDD.PP_StartDate
				JOIN LocaleSummary LS
					on LS.LH_Code = PFDL.LH_Code
					AND LS.PP_StartDate = PP.PP_StartDate
					AND LS.PP_EndDate = PP.PP_EndDate
				JOIN LocaleHeader LH
					on LH.LH_Code = LS.LH_Code
				JOIN PortfolioScenarioForecastView PSFV
					on PSFV.PSF_Key = PFDL.PSF_Key
					AND PSFV.PSC_Key = @PSCKey
		GROUP BY PP.PP_Month, PFDL.PFDL_Key
		ORDER BY PP.PP_Month;

		--Get month adjustmnent value
		SELECT  @MonthDiff = DATEDIFF(Month,Cast(Min(PP_Month) -2 as Datetime), Cast(@Month -2 as dateTime))
		FROM	PortfolioForecastDemandDetail PFDD
				JOIN PlanningPeriod PP
					ON PP.PP_StartDate = PFDD.PP_StartDate
				JOIN PortfolioForecastDemandLine PFDL
					on PFDL.PFDL_Key = PFDD.PFDL_Key
				join PortfolioScenarioForecastView PSFV
					on PSFV.PSF_Key = PFDL.PSF_Key
			WHERE	PSFV.PSF_Key =  @PSFKey
					AND PSFV.PSC_Key = @PSCKey;

		SELECT	@CurrentIndex = COALESCE(MIN(ID), -1),
				@MaxIndex = COALESCE(MAX(ID), -1)
		FROM   @tempDemandDetail;

		--Delete old entries from the demand detail table
		DELETE PortfolioForecastDemandDetail
		WHERE PFDL_KEY IN (
								SELECT	tdd.PFDLKey								
								FROM	@tempDemandDetail tdd
								WHERE	PFDLKey  = PFDL_Key
							);

		WHILE @CurrentIndex <= @MaxIndex AND @CurrentIndex <> -1
			BEGIN
				-- Get all demand details from old month
				SELECT	@LHCode = PFDL.LH_Code,
						@CurrentPFDLKey = TDD.PFDLKey,
						@MonthStatus = TDD.PFDDStatus,
						@MonthDays = TDD.PFDDDays,
						@MonthLocalCost = TDD.PFDDLocalCost,
						@MonthLocalCharge = TDD.PFDDLocalCharge,
						@MonthSystemCost = TDD.PFDDSystemCost,
						@MonthSystemCharge = TDD.PFDDSystemCharge,
						@CurrentMonth = Cast(DATEADD(month, @MonthDiff, Cast(TDD.PPMonth -2 as datetime)) + 2 as float)
				FROM	PlanningPeriod PP
						join @tempDemandDetail TDD
							on TDD.PPMonth = PP.PP_Month
						join PortfolioForecastDemandLine PFDL
							on PFDL.PFDL_Key = TDD.PFDLKey
						JOIN LocaleSummary LS	
							on LS.LH_Code = PFDL.LH_Code
							AND LS.PP_StartDate = PP.PP_StartDate
							AND LS.PP_EndDate = PP.PP_EndDate
				WHERE	TDD.ID = @CurrentIndex;

				--Get included days for the new month
				SELECT	@MonthIncludedDays = SUM(LS.LS_Days)
				FROM	PlanningPeriod PP
						JOIN LocaleSummary LS
							ON PP.PP_StartDate = LS.PP_StartDate
							AND PP.PP_EndDate = LS.PP_EndDate
							AND LS.LH_Code = @LHCode
				WHERE	PP.PP_Month = @CurrentMonth;

				--Calculate daily values based on how many working days there are in the new month
				--by dividing the total by the new number of dasy (pro-rataing)
				SELECT	@DailyDays = @MonthDays / @MonthIncludedDays,
						@DailyLocalCost = @MonthLocalCost / @MonthIncludedDays,
						@DailyLocalCharge = @MonthLocalCharge / @MonthIncludedDays,
						@DailySystemCost = @MonthSystemCost / @MonthIncludedDays,
						@DailySystemCharge = @MonthSystemCharge / @MonthIncludedDays;

				--Get first period in current month
				SELECT  @PeriodStartDate = COALESCE(MIN(PP_StartDate), -1)
				FROM	PlanningPeriod
				WHERE	PlanningPeriod.PP_Month = @CurrentMonth
						AND PlanningPeriod.PP_StartDate > @PeriodStartDate;
				
				--Loop through each period in the new month
				while @PeriodStartDate <> -1
					BEGIN
						--Get FTE and included days for new period
						SELECT	@Fte = LHFte,
								@IncludedDays = SUM(LSDays)
						FROM	(
									SELECT  DISTINCT	LH.LH_Code LHCode,
														LH.LH_FTE LHFte,
														LS.LS_Days LSDays
									FROM	LocaleSummary LS
											JOIN LocaleHeader LH
												on LH.LH_Code = LS.LH_Code
									WHERE	LS.PP_StartDate = @PeriodStartDate
											AND LH.LH_COde = @LHCode
								) Q1
						GROUP BY Q1.LHFte
					
						--Calculate period values by multiplying the number of days by the daily value
						select	@PeriodDays = @DailyDays * @IncludedDays,
								@PeriodLocalCost = @DailyLocalCost * @IncludedDays,
								@PeriodLocalCharge = @DailyLocalCharge * @IncludedDays,
								@PeriodSystemCost = @DailySystemCost * @IncludedDays,
								@PeriodSystemCharge = @DailySystemCharge * @IncludedDays,
								@PeriodFte  = @DailyDays * @Fte;

						--Insert new entries into the demand detail table
						INSERT INTO PortfolioForecastDemandDetail (PFDL_Key, PP_StartDate, PFDD_Days, PFDD_FTE, PFDD_LocalCost, PFDD_LocalCharge, PFDD_SystemCost, PFDD_SystemCharge, PFDD_Status)
						SELECT @CurrentPFDLKey, @PeriodStartDate, @PeriodDays, @PeriodFte, @PeriodLocalCost, @PeriodLocalCharge, @PeriodSystemCost, @PeriodSystemCharge, @MonthStatus;

						--Get next period in current month
						SELECT  @PeriodStartDate = COALESCE(MIN(PP_StartDate), -1)
						FROM	PlanningPeriod
						WHERE	PlanningPeriod.PP_Month = @CurrentMonth
								AND PlanningPeriod.PP_StartDate > @PeriodStartDate;
					END
		
				--Get next index to process
				SELECT @CurrentIndex = COALESCE(MIN(ID), -1) FROM @tempDemandDetail WHERE ID > @CurrentIndex;

				--GetNextMonth
				SELECT @CurrentMonth =  Cast(DATEADD(month,1, CAST(@CurrentMonth -2 as datetime)) + 2 as float);
			END;

		COMMIT TRAN;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		SELECT  @ErrorText = ERROR_MESSAGE(),
				@Error = -1;
	END CATCH
GO
GRANT EXECUTE
	ON [dbo].[AdjustPortfolioDemandByMonth]
	TO [V6N14816rwZf]
GO
