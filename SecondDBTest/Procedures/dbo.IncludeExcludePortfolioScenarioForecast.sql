SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure IncludeExcludePortfolioScenarioForecast
	@IsIncluded smallint,
	@UsCode nvarchar(20),
	@PFLKey int,
	@PSCKeyToCopy int,
	@PSCKey int output,
	@PSFKey int output
AS

	DECLARE @NewPSCKey int;
	DECLARE @PFOKey int;
	DECLARE @BaseStartDate float;
	DECLARE @LastEdit float;
	DECLARE @BaseScore float;	

	select	@PFOKey = PFO_Key
	FROM	PortfolioScenarioForecastView
	WHERE	PSC_Key = @PSCKeyToCopy
			AND PSF_Key = @PSFKey
			
	set @LastEdit = cast(GetDate() +2 as float);

	--Check if work in progress exists for the Portfolio. If not create it from specified scenario key
	IF NOT EXISTS( 
					SELECT	1
					FROM	PortfolioScenario PSC
					WHERE	PFL_Key = @PFLKey
							AND PSC_Version = -1
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
					-- updating the current WIP
					-- Delete any report cache items
					Delete From ReportCache Where PSC_Key = @CurrentWIPKey;
					
					-- update the Last edit date on the wip 
					UPDATE PortfolioScenario SET PSC_LastEditOn = Cast(GETDATE() +2 as float)
					WHERE PSC_Key = @CurrentWIPKey;
					
				END;
		END;
	
	----Check for current record for specified forecast
	IF EXISTS (SELECT 1 FROM PortfolioScenarioForecast WHERE PFO_Key = @PFOKey AND PSC_Key = @PSCKey)
		BEGIN
			UPDATE PortfolioScenarioForecast
			SET PSF_Included = @IsIncluded
			WHERE	PSC_Key = @PSCKey
					AND PFO_Key = @PFOKey;

			SELECT	@PSFKey = PSF_Key
			FROM	PortfolioScenarioForecast
			WHERE	PSC_Key = @PSCKey
					AND PFO_Key = @PFOKey;
		END;
	ELSE
		BEGIN
			SELECT	@BaseStartDate = PSF_StartDate,
					@BaseScore = PSF_Score
			FROM	PortfolioScenarioForecastView PSFV
			WHERE	PSFV.PSC_Key = @PSCKeyToCopy
					AND PSFV.PFO_Key = @PFOKey;
								
			INSERT INTO PortfolioScenarioForecast (PFO_Key, PSC_Key, PSF_Included, PSF_Score, PSF_StartDate)
			SELECT	@PFOKey, @PSCKey, @IsIncluded, @BaseScore, @BaseStartDate;

			DECLARE @OldPSFKey int
			Set @OldPSFKey = @PSFKey;

			set @PSFKey = SCOPE_IDENTITY();
			
			-- insert the custom field data. So that it can be included again. 
			EXEC InsertPortfolioCustomFieldData @OldPSFKey,@PSFKey;

			EXEC InsertPortfolioDemand @OldPSFKey, @PSFKey;
			
		END;
GO
GRANT EXECUTE
	ON [dbo].[IncludeExcludePortfolioScenarioForecast]
	TO [V6N14816rwZf]
GO
