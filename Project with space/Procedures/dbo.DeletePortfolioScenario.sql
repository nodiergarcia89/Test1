SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


Create Procedure DeletePortfolioScenario
	@PSCKey int,
	@AllowBaseDelete int = 0
AS
	DECLARE @IsBase smallint;
	DECLARE @MaxVersion int;

	SELECT	@IsBase = count(DISTINCT 1) 
	FROM	PortfolioScenario PSC
	WHERE	PSC.PSC_Key = @PSCKey
			AND PSC.PSC_Version = 0;

	SELECT	@MaxVersion = Max(PSC.PSC_Version)
	FROM	PortfolioScenario PSC
	WHERE	PSC.PSC_Key = @PSCKey;



	if (@IsBase = 1 AND (@AllowBaseDelete = 0  OR @MaxVersion != 0))
		BEGIN
			--Do not delete if it is base data and either the allow base delete flag is not set, 
			--or if there are other scenarios
			return;		
		END;


	--Delete demand details
	DELETE PortfolioForecastDemandDetail
	WHERE EXISTS (SELECT 1
				  from PortfolioForecastDemandLine PDL
				  join PortfolioScenarioForecast PSF
					on PSF.PSF_Key = PDL.PSF_Key
				  WHERE	PSF.PSC_Key = @PSCKey
						and PDL.PFDL_Key = PortfolioForecastDemandDetail.PFDL_Key
				  );

	--Delete demand lines
	DELETE PortfolioForecastDemandLine
	WHERE EXISTS (SELECT 1
				  from PortfolioScenarioForecast PSF
				  WHERE	PSF.PSC_Key = @PSCKey
						AND PSF.PSF_Key = PortfolioForecastDemandLine.PSF_Key
				  );

	--Delete custom field data
	EXEC DeletePortfolioCustomFieldData @PSCKey;

	--delete scenario forecast
	DELETE PortfolioScenarioForecast WHERE PSC_Key = @PSCKey;

	--delete scenario
	DELETE PortfolioScenario WHERE PSC_Key = @PSCKey;
GO
GRANT EXECUTE
	ON [dbo].[DeletePortfolioScenario]
	TO [V6N14816rwZf]
GO
