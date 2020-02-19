SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
/**************************************************************************************************************************************
											  KeyedIn Projects Database Upgrade Script 
														v6.3.0.43286 to v6.3.0.43293
***************************************************************************************************************************************

JN1 -  09/07/2018
	Mod, Insert values into lastedit column
**************************************************************************************************************************************/	


CREATE Procedure [dbo].[CreatePortfolioBase]
	@PortfolioName nvarchar(70),
	@PortfolioDesc nvarchar(250),
	@BaseScenarioName nvarchar(70),
	@DepartmentCode	nvarchar(20),
	@ExistingOwner	nvarchar(20),
	@CurrentUser	nvarchar(20),
	@LastEditOn float,
	@StartDate float,
	@EndDate float,
	@LastEdit nvarchar(60), 
	@PFLKey int OUTPUT,
	@PSCKey int OUTPUT 
AS
	DECLARE @SCOKey int;

	if EXISTS (	select	1 
				from	Portfolio 
				where	US_Code = @CurrentUser 
						and PFL_IsTemp = -1)
		BEGIN
			--Get portfolio key from temp record for current user
			select @PFLKey = PFL_Key from Portfolio where US_Code = @CurrentUser and PFL_IsTemp = -1;
		END;
	ELSE
		BEGIN
			Return;
		END;

	--Update portfolio record to be active (i.e. no temp)
	update Portfolio 
	set PFL_Name = @PortfolioName, PFL_Description = @PortfolioDesc, DE_Code = @DepartmentCode,  PFL_LastEditOn = @LastEditOn, PFL_IsTemp = 0, PFL_StartDate = @StartDate, PFL_EndDate = @EndDate, US_Code = @ExistingOwner, PFL_LastEdit = @LastEdit
	WHERE Portfolio.PFL_Key = @PFLKey;	
	
	--Create Base Scenario
	INSERT INTO PortfolioScenario (PFL_Key, PSC_Name, US_Code, PSC_Version, PSC_LastEditOn)
	select @PFLKey, @BaseScenarioName, @ExistingOwner, 0, @LastEditOn;

	set @PSCKey = SCOPE_IDENTITY();

	--Generate scenaro forescast Base Scenario Included List based on the portfolio projects/forecasts
	INSERT INTO PortfolioScenarioForecast (PSC_Key, PSF_Included, PSF_StartDate, PSF_Score, PFO_Key)
	SELECT @PSCKey, -1, PPR.PPR_ProjectProposedStartDate, 0, PFO.PFO_Key
	FROM	PortfolioForecasts PFO
			JOIN	PortfolioProjects PPR
				on PFO.PPR_Key = PPR.PPR_Key
	WHERE	PFO.PFL_Key = @PFLKey;
	
	--Generate Custom fields for the portfolio projects/forecast
	EXEC PopulatePortfolioCustomFieldData @PFLKey;

	--Generate the Forecast demand data
	EXEC PopulatePortfolioDemand @PSCKey;
	
GO
GRANT EXECUTE
	ON [dbo].[CreatePortfolioBase]
	TO [V6N14816rwZf]
GO
