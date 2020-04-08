SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


Create Procedure PopulatePortfolioDemand
	@PSCKey int
AS
	
	--Generate the Forecast demand lines for base scenario
	INSERT INTO PortfolioForecastDemandLine (PSF_Key, DE_Code,  RE_CodeRole,  RE_Code, CU_Code, LH_Code)
	select  PSF.PSF_Key, 
			PDL.DE_Code,  
			PDL.RE_CodeRole,
			PDL.RE_Code,
			COALESCE(PDL.CU_Code, PRF.CU_Code),
			PDL.LH_Code
	from	PortfolioScenarioForecast PSF
			join PortfolioForecasts PFO
				on PSF.PFO_Key = PFO.PFO_Key
			join Profile PRF
				on PRF.PRF_Key = PFO.PFO_ProfileKey
			join ProfileDemandLine PDL
				on PDL.PRF_Key = PFO.PFO_ProfileKey
			join Departments DE
				on DE.DE_Code = PDL.DE_Code
			join Res RO
				on RO.RE_Code = PDL.RE_CodeRole
				AND RO.RE_Virtual = -1
			LEFT OUTER Join Res
				on Res.RE_Code = PDL.RE_Code
	WHERE PSF.PSC_Key = @PSCKey;

  --Generate forecast demand details for base scenario
  INSERT INTO PortfolioForecastDemandDetail (PFDL_Key, PP_StartDate, PFDD_Days, PFDD_FTE, PFDD_LocalCost, PFDD_LocalCharge, PFDD_SystemCost, PFDD_SystemCharge, PFDD_Status)
  SELECT	PFDL.PFDL_Key,
			PlanningPeriod.PP_StartDate, 
			SUM(PDD.PDD_Days), 
			CASE WHEN COALESCE(Q1.LS_Days, 0) = 0
							THEN 0
							ELSE ((SUM(COALESCE(PDD.PDD_Days, 0)) / Q1.LS_Days) * MAX(LocaleHeader.LH_FTE))
						END,
			SUM(COALESCE(PDD.PDD_LocalCost, 0)) LocalCost,
			SUM(COALESCE(PDD.PDD_SystemCost, 0)) SystemCost,
			SUM(COALESCE(PDD.PDD_LocalCharge, 0)) LocalCharge,
			SUM(COALESCE(PDD.PDD_SystemCharge, 0)) SystemCharge,
			MIN(PDD.PDD_Status)
	FROM	PortfolioScenarioForecastView PSFV
			JOIN PortfolioForecasts PFO
				on PFO.PFO_Key = PSFV.PFO_Key
			JOIN PortfolioProjects PPR
				on PPR.PPR_Key = PSFV.PPR_Key
			JOIN PortfolioForecastDemandLine PFDL
				on PFDL.PSF_Key = PSFV.PSF_Key
			JOIN ProfileDemandLine PDL
				on PDL.PRF_Key = PFO.PFO_ProfileKey
			JOIN ProfileDemandDetail PDD
				on PDL.PDL_Key = PDD.PDL_Key
				AND PDL.DE_Code = PFDL.DE_Code
				AND PDL.RE_CodeRole = PFDL.RE_CodeRole
				AND COALESCE(PDL.RE_Code, ' ') = COALESCE(PFDL.RE_Code, ' ')
            INNER JOIN PlanningPeriod    
				ON PlanningPeriod.PP_StartDate = PDD.PP_StartDate 
				AND PlanningPeriod.PP_EndDate = PDD.PP_EndDate      
			INNER JOIN LocaleHeader 
				ON LocaleHeader.LH_Code = PDL.LH_Code 
			INNER JOIN (
							SELECT	LH.LH_Code, 
									PP.PP_StartDate, 
									SUM(LS.LS_Days) LS_Days
				            FROM	LocaleHeader LH
						            JOIN LocaleSummary LS
										on LH.LH_Code = LS.LH_Code
						            JOIN PlanningPeriod PP
										on LS.PP_StartDate = PP.PP_StartDate
							            AND LS.PP_EndDate = PP.PP_EndDate			
							GROUP BY	LH.LH_Code, 
										PP.PP_StartDate 
						) as Q1
				on Q1.LH_Code = PDL.LH_Code 
                AND Q1.PP_StartDate = PlanningPeriod.PP_StartDate
				AND PlanningPeriod.PP_StartDate >= PSFV.PFL_StartDate 
				AND PlanningPeriod.PP_EndDate <= PSFV.PFL_EndDate
	WHERE		PSFV.PSC_Key = @PSCKey 
	GROUP BY 	PFDL.PFDL_Key,
				PFDL.DE_Code,
				PFDL.RE_CodeRole,
				PFDL.RE_Code,
				PFO.PFO_ProfileName,
				PlanningPeriod.PP_StartDate, 
				Q1.LS_Days; 
	
	

GO
