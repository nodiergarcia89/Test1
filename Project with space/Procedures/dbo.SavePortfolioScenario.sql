SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

Create Procedure SavePortfolioScenario
	@PFLKey		int,	
	@PSCName	varchar(70),
	@UserCode	varchar(70),
	@Version	int OUTPUT,
	@ScenarioKey	int OUTPUT
AS
	--Check if work in progress
	IF EXISTS(SELECT 1 FROM PortfolioScenario WHERE PFL_Key = @PFLKey and PSC_Version = -1)
		BEGIN
			DECLARE @LastEditDate float;

			SET @LastEditDate = Cast(GETDATE() +2 as float);

			--Get the Scenario Version Key updateing. 
			SELECT @ScenarioKey = PSC_Key FROM PortfolioScenario WHERE PFL_Key = @PFLKey and PSC_Version = -1

			--Generate new version number
			SELECT	@Version = MAX(PSC_Version) + 1
			FROM	PortfolioScenario
			WHERE	PFL_Key = @PFLKey

			--Only attempt update if temp portfolio scenario exists
			UPDATE	PortfolioScenario
			Set		PSC_Name = @PSCName,
					US_Code = @UserCode,
					PSC_Version = @Version,
					PSC_LastEditOn = @LastEditDate
			WHERE	PFL_Key = @PFLKey
					AND PSC_Version = -1;
		END
	ELSE
		BEGIN
			--If there is no WIP version just return a -999 version to indicate that there was no WIP version to save
			SET @Version = -999;
		END
GO
GRANT EXECUTE
	ON [dbo].[SavePortfolioScenario]
	TO [V6N14816rwZf]
GO
