SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


Create Procedure InsertPortfolioDemand
	@OldPSFKey int,
	@NewPSFKey int
AS
	DECLARE @PFDLKey int;

	--Check if portfolio data exists or not. If it doesn't create it. If it does, do nothing
	IF NOT EXISTS (select 1 FROM PortfolioForecastDemandLine where PSF_Key = @NewPSFKey)
		BEGIN
			INSERT INTO PortfolioForecastDemandLine (PSF_Key, DE_Code,  RE_CodeRole,  RE_Code, CU_Code, LH_Code)
			SELECT	@NewPSFKey, DE_Code,  RE_CodeRole,  RE_Code, CU_Code, LH_Code
			FROM	PortfolioForecastDemandLine PFDL
			WHERE	PFDL.PSF_Key = @OldPSFKey;


			INSERT INTO PortfolioForecastDemandDetail (PFDL_Key, PP_StartDate, PFDD_Days, PFDD_FTE, PFDD_LocalCost, PFDD_SystemCost, PFDD_LocalCharge, PFDD_SystemCharge, PFDD_Status)
			SELECT	PFDLNew.PFDL_Key, 
					PP_StartDate, 
					PFDD_Days, 
					PFDD_FTE, 
					PFDD_LocalCost, 
					PFDD_SystemCost, 
					PFDD_LocalCharge, 
					PFDD_SystemCharge, 
					PFDD_Status
			FROM	PortfolioForecastDemandDetail PFDD
					JOIN PortfolioForecastDemandLine PFDL
						on PFDD.PFDL_Key = PFDL.PFDL_Key
						AND PFDL.PSF_Key = @OldPSFKey
					JOIN PortfolioScenarioForecast PSF
						on PSF.PSF_Key = PFDL.PSF_Key
					JOIN PortfolioScenarioForecast PSFNew
						on PSF.PFO_Key = PSFNew.PFO_Key
						AND PSFNew.PSF_Key = @NewPSFKey
					Join PortfolioForecastDemandLine PFDLNew
						on PFDLNew.PSF_Key = PSFNew.PSF_Key
						AND PFDL.DE_Code = PFDLNew.DE_Code
						AND PFDL.RE_CodeRole = PFDLNew.RE_CodeRole
						AND COALESCE(PFDL.RE_Code, ' ') = COALESCE(PFDLNew.RE_Code, ' ');
		END

GO
