SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
/**************************************************************************************************************************************
											  KeyedIn Projects Database Upgrade Script 
														v6.3.0.43279 to v6.3.0.43286
***************************************************************************************************************************************

JN1 -  06/07/2018
	Mod, remove references to portfolio last edit by in procedures
**************************************************************************************************************************************/	

--JN1s
CREATE Procedure [dbo].[AddPortfolioForecast]
	@ForecastKey	int,
	@UsCode	nvarchar(20),
	@TempPortfolioKey	int OUTPUT
AS
	DECLARE @PortfolioKey int;
	DECLARE @PPRKey int;

	IF EXISTS (select 1 from Portfolio where PFL_IsTemp = -1 and US_Code = @UsCode)
		BEGIN
			select @PortfolioKey = PFL_Key from Portfolio where PFL_IsTemp = -1 and US_Code = @UsCode;
		END	
	ELSE
		BEGIN
			Insert Into Portfolio (PFL_Name,PFL_Description, US_Code, PFL_LastEditOn, PFL_IsTemp)
			SELECT 'Temp','Temp', @UsCode,0,-1 ;

			set @PortfolioKey = SCOPE_IDENTITY();
		END;

		
	--Check if project exists. If not then insert it
	if NOT EXISTS(	SELECT	1 
					FROM	Profile pro 
							join	PortfolioProjects pp 
								on pro.PR_Code = pp.PR_Code 
					where	pro.PRF_Key = @ForecastKey
							and pp.PFL_Key = @PortfolioKey)
		BEGIN
		
		
		
			INSERT INTO PortfolioProjects (PFL_Key, PR_Code, PPR_ProjectLifeCycleCode, PPR_ProjectLifeCycleName,PPR_ProjectLifeCycleStageKey,PPR_ProjectLifeCycleStage, PPR_ProjectManagerCode, PPR_ProjectSponsorCode, PPR_ProjectStartDate,PPR_ProjectProposedStartDate, PPR_ProjectEndDate, PPR_Active)
			SELECT @PortfolioKey, prj.PR_Code, prj.PLF_Code, plc.PLF_Desc,plcs.PLFS_Key,plcs.PLFS_Desc, Manager.RE_Code, Sponsor.RE_Code,  prj.PR_Start, MIN(CAST(DATEADD(month, DATEDIFF(month, 0, PDD.PP_StartDate), 0) AS FLOAT)+2 ), prj.PR_End, prj.Active
			FROM	Profile pro					
					INNER JOIN Projects prj
						on pro.PR_Code = prj.PR_Code
						AND pro.PRF_Key = @ForecastKey
					LEFT OUTER JOIN ProfileDemandLine PDL on PDL.PRF_Key = pro.PRF_Key
					LEFT OUTER JOIN ProfileDemandDetail PDD on PDD.PDL_Key = PDL.PDL_Key
					LEFT OUTER join ProjectLifecycle plc
						on plc.PLF_Code = prj.PLF_Code
					LEFT OUTER join ProjectLifecycleStage plcs
						on prj.PLFS_Key = plcs.PLFS_Key
					LEFT OUTER JOIN res Manager
						on Manager.RE_Code = prj.RE_CodeProjectManager
					LEFT OUTER JOIN res Sponsor
						on Sponsor.RE_Code = prj.RE_CodeProjectSponsor
					GROUP BY
					prj.PR_Code, prj.PLF_Code, plc.PLF_Desc,
					plcs.PLFS_Key,plcs.PLFS_Desc, Manager.RE_Code, 
					Sponsor.RE_Code, 
					prj.PR_Start,					
					prj.PR_End, prj.Active

			set @PPRKey = SCOPE_IDENTITY();
		END
	ELSE
		BEGIN
			SELECT	@PPRKey = pp.PPR_Key
			FROM	Profile pro 
					join	PortfolioProjects pp 
						on pro.PR_Code = pp.PR_Code 
			where pro.PRF_Key = @ForecastKey
					and pp.PFL_Key = @PortfolioKey;
				
			--Delete any existing ProfileForecast record for this Project and Portfolio
			--It might exist if the user had previously selected one. Re-add it below.
			DELETE FROM PortfolioForecasts 
			WHERE PFL_Key = @PortfolioKey
			AND PPR_Key = @PPRKey;	
														
		END;
			
			
			
		-- Check if project forecast exists. If not then insert it
		IF NOT EXISTS (	SELECT	1
						FROM	Profile pro
								JOIN PortfolioForecasts PFO
									on PFO.PFO_ProfileKey = pro.PRF_Key
									AND PFO.PFL_Key = @PortfolioKey
									AND pro.PRF_Key = @ForecastKey)									
		BEGIN																													
			-- Insert forecast
			INSERT INTO PortfolioForecasts (PFL_Key, PFO_ProfileKey, PFO_ProfileName, PFO_ProfileStatus, PFO_ProfileBaseline, PPR_Key)
			SELECT @PortfolioKey, PRF_Key, PRF_Desc, PRF_Status, PRF_Baseline, @PPRKey
			from	Profile PRF
			where PRF_Key = @ForecastKey;
		END
		
	-- return the temporary portfolio key
	SET @TempPortfolioKey = @PortfolioKey;
	
GO
GRANT EXECUTE
	ON [dbo].[AddPortfolioForecast]
	TO [V6N14816rwZf]
GO
