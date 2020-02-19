SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


Create Procedure ApproveScenario
	@PortfolioKey float,	
	@ScenarioKey float,	
	@UserCode nvarchar(20)	
AS
	DECLARE @approvedOn float;
	set @approvedOn = cast(GetDate() +2 as float);	

	-- *TL: Removed: excluded projects will keep the approval date from when they were first approved.
    -- Clear the approval status for any Projects excluded from the Scenario we are approving.
	--UPDATE P
	--SET P.PR_ApprovedStartDate = null				
	--FROM Projects P
	--INNER JOIN	
	--(SELECT PP.PR_Code, PSF_StartDate 
	--FROM PortfolioScenarioForecastView PSFV	
	--INNER JOIN PortfolioProjects PP ON PP.PPR_Key = PSFV.PPR_Key
	--WHERE PSC_Key = @ScenarioKey
	--AND PSF_Included = 0) SCN ON SCN.PR_Code = P.PR_Code;

	-- Update Projects in the Scenario with the ApprovedStartDate from the Scenario version	
	UPDATE P
	SET P.PR_ApprovedStartDate = PSF_StartDate				
	FROM Projects P
	INNER JOIN	
	(SELECT PP.PR_Code, PSF_StartDate 
	FROM PortfolioScenarioForecastView PSFV	
	INNER JOIN PortfolioProjects PP ON PP.PPR_Key = PSFV.PPR_Key
	WHERE PSC_Key = @ScenarioKey
	AND PSF_Included = -1) SCN ON SCN.PR_Code = P.PR_Code;
	
	-- Clear any previously Approved Scenario
	UPDATE PortfolioScenario
	SET PSC_Approved = 0,
		PSC_ApprovedOn = null,
		PSC_ApprovedBy = null
	WHERE PFL_Key = @PortfolioKey;
	
	-- Update the Scenario as Approved
	UPDATE PortfolioScenario
	SET PSC_Approved = -1,
		PSC_ApprovedOn = @approvedOn,
		PSC_ApprovedBy = @UserCode
	WHERE PSC_Key = @ScenarioKey;
	
GO
GRANT EXECUTE
	ON [dbo].[ApproveScenario]
	TO [V6N14816rwZf]
GO
