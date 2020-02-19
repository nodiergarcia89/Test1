SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

Create Procedure CreateWIPPortfolioScenario
	@PFLKey int,
	@UsCode nvarchar(20),
	@OldPSCKey int,
	@NewPSCKey int OUTPUT
AS
	DECLARE @Version int;
	DECLARE @RowCount int;
	DECLARE @CurrentRow int;
	DECLARE @TempPSFKey int;
	DECLARE @TempNewPSFKey int;

	DECLARE @TempPFDLKey int;
	DECLARE @TempNewPFDLKey int;

	DECLARE @DemandMaxRow int;
	DECLARE @DemandCurrRow int;
	DECLARE @PFDLKey int;

	DECLARE @LastEdit float;

	DECLARE @PortfolioScenarioData TABLE
	(
		ID int IDENTITY(1,1),
		PSF_Key int
	);

	DECLARE @PortfolioScenarioDemandLineData TABLE
	(
		ID int IDENTITY(1,1),
		PSF_Key int,
		PFDL_Key int
	);

	set @LastEdit = cast(GetDate() +2 as float);

	----Set version number 
	SELECT	@Version = PSC_Version
	FROM	PortfolioScenario
	WHERE	PSC_Key = @OldPSCKey;

	--Copy over values from previous 
	INSERT INTO PortfolioScenario(PFL_Key, PSC_Name, PSC_Version, 	US_Code, PSC_LastEditOn)
	SELECT @PFLKey, 'Work In Progress', -1, @UsCode, @LastEdit;

	set @NewPSCKey = SCOPE_IDENTITY();

	IF @Version <> 0
		BEGIN
			INSERT INTO @PortfolioScenarioData (PSF_Key)
			SELECT PSF_Key 
			FROM	PortfolioScenarioForecast PSF
					JOIN PortfolioScenario PSC
						on PSF.PSC_Key = PSC.PSC_Key
			WHERE	PSC.PSC_Key = @OldPSCKey
					AND PSC.PSC_Version <> 0;
		END;

	--If there are any existing rows for the original scenario record then process them
	if EXISTS (Select 1 FROM @PortfolioScenarioData)
		BEGIN
			set @CurrentRow = 1;
			SELECT @RowCount = Max(ID) FROM @PortfolioScenarioData;

			INSERT INTO @PortfolioScenarioDemandLineData (PSF_Key, PFDL_Key)
			SELECT	PFDL.PSF_Key, PFDL.PFDL_Key
			FROM	PortfolioForecastDemandLine PFDL
					JOIN PortfolioScenarioForecast PSF
						ON PSF.PSF_Key = PFDL.PSF_Key
			WHERE	PSF.PSC_Key = @OldPSCKey;

			WHILE @CurrentRow <= @RowCount
				BEGIN
					--Get current rows PSF Key
					Select @TempPSFKey = PSF_Key from @PortfolioScenarioData WHERE ID = @CurrentRow;				

					--Insert scenario forecast record
					INSERT INTO PortfolioScenarioForecast (PFO_Key, PSC_Key, PSF_Included, PSF_Score, PSF_StartDate)
					SELECT	PSF.PFO_Key, @NewPSCKey, PSF.PSF_Included, PSF.PSF_Score, PSF_StartDate
					FROM	PortfolioScenarioForecast PSF
					WHERE	PSF.PSF_Key = @TempPSFKey;

					set @TempNewPSFKey = SCOPE_IDENTITY();
					
					--Insert custom field values
					EXEC InsertPortfolioCustomFieldData @TempPSFKey, @TempNewPSFKey;

					--If forecast data exists then insert forecast demand line and demand detail records
					IF EXISTS (SELECT 1 FROM @PortfolioScenarioDemandLineData WHERE PSF_Key = @TempPSFKey)
						BEGIN
							SELECT	@DemandCurrRow = Min(ID),
									@DemandMaxRow = Max(ID)
							FROM	@PortfolioScenarioDemandLineData
							WHERE	PSF_Key = @TempPSFKey;

							WHILE @DemandCurrRow <= @DemandMaxRow
								BEGIN
									SELECT	@TempPFDLKey = PFDL_Key
									FROM	@PortfolioScenarioDemandLineData
									WHERE	ID = @DemandCurrRow;

									--Insert demand line records
									INSERT INTO PortfolioForecastDemandLine (PSF_Key, DE_Code,  RE_CodeRole,  RE_Code)
									SELECT  @TempNewPSFKey, PFDL.DE_Code, PFDL.RE_CodeRole, PFDL. RE_Code
									FROM	PortfolioForecastDemandLine PFDL
									WHERE	PFDL.PFDL_Key = @TempPFDLKey

									--populate table for demand details
									set @TempNewPFDLKey = SCOPE_IDENTITY();

									INSERT INTO PortfolioForecastDemandDetail (PFDL_Key, PP_StartDate, PFDD_Days, PFDD_FTE, PFDD_LocalCost, PFDD_SystemCost, PFDD_LocalCharge, PFDD_SystemCharge, PFDD_Status)
									SELECT	@TempNewPFDLKey, PFDD.PP_StartDate, PFDD.PFDD_Days, PFDD.PFDD_FTE, PFDD.PFDD_LocalCost, PFDD.PFDD_SystemCost, PFDD.PFDD_LocalCharge, PFDD.PFDD_SystemCharge, PFDD.PFDD_Status
									FROM	PortfolioForecastDemandDetail PFDD
									WHERE	PFDD.PFDL_Key = @TempPFDLKey;

									SET @DemandCurrRow = @DemandCurrRow +1;
								END;

						END;

					set @CurrentRow = @CurrentRow + 1;
				END
		END;
GO
