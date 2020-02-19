SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

Create Procedure DeletePortfolio
	@PFLKey int,
	@USCode nvarchar(20) OUTPUT
AS
	DECLARE @CurrentScenarioKey int;

	select  @CurrentScenarioKey = COALESCE(Max(PSC_Key), -1)
	FROM	PortfolioScenario PSC
	WHERE	PSC.PFL_Key = @PFLKey;

	--get the usercode
	SELECT @USCode = US_Code
	FROM Portfolio
	WHERE PFL_Key = @PFLKey

	--Note the scenario key loop goes from max to min so that the base scenario is the last one deleted
	WHILE @CurrentScenarioKey != -1
		BEGIN
			--Call delete scenario statement with allow base delete set to true
			EXEC DeletePortfolioScenario @CurrentScenarioKey, 1; 

			--Get next scenario to delete
			SELECT @CurrentScenarioKey = COALESCE(Max(PSC_Key), -1)
			FROM	PortfolioScenario PSC
			WHERE	PSC.PSC_Key < @CurrentScenarioKey
					AND PSC.PFL_Key = @PFLKey;
		END;

	DELETE ScoreWeights
	WHERE	PFL_Key = @PFLKey;

	DELETE	PortfolioSharedUsers
	WHERE	PFL_Key = @PFLKey;

	DELETE	PortfolioForecasts
	WHERE	PFL_Key = @PFLKey;

	DELETE PortfolioProjects
	WHERE	PFL_Key = @PFLKey;

	DELETE Portfolio
	WHERE	PFL_Key = @PFLKey;
GO
GRANT EXECUTE
	ON [dbo].[DeletePortfolio]
	TO [V6N14816rwZf]
GO
