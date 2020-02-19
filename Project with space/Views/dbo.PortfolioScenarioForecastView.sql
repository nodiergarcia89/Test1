SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW PortfolioScenarioForecastView as 
SELECT	PFL.PFL_Key,
		PFL.PFL_StartDate,
		PFL.PFL_EndDate,
		PFL.DE_Code,
		PSCVersion.PSC_Key,
		PSCVersion.PSC_Name,
		PSCVersion.US_Code,
		PSCVersion.PSC_Version,
		PSCVersion.PSC_LastEditOn,
		PSCVersion.PSC_Approved,
		PFO.PPR_Key PPR_Key,
		PFO.PFO_Key PFO_Key,
		COALESCE(PSFVersion.PSF_Key, PSFBase.PSF_Key) PSF_Key,
		COALESCE(PSFVersion.PSF_Included, PSFBase.PSF_Included) PSF_Included,
		COALESCE(PSFVersion.PSF_StartDate, PSFBase.PSF_StartDate) PSF_StartDate,
		COALESCE(PSFVersion.PSF_Score, PSFBase.PSF_Score) PSF_Score
FROM	Portfolio PFL
		join PortfolioForecasts PFO
			on PFO.PFL_Key = PFL.PFL_Key
		join PortfolioScenario PSCBase
			on PFL.PFL_Key = PSCBase.PFL_Key
			AND PSCBase.PSC_Version = 0
			AND PFL.PFL_IsTemp = 0
		join PortfolioScenario PSCVersion
			on PSCVersion.PFL_Key = PFL.PFL_Key
		join PortfolioScenarioForecast PSFBase
			on PSFBase.PSC_Key = PSCBase.PSC_Key
			AND PSFBase.PFO_Key = PFO.PFO_Key
		Left Outer Join PortfolioScenarioForecast PSFVersion
			on PSFVersion.PSC_Key = PSCVersion.PSC_Key
			AND PSFBase.PFO_Key = PSFVersion.PFO_Key
		
GO
