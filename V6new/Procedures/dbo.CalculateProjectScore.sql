SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- Calculates the Score for each Project Forecast.
-- Score is calculated as:
--			Each 'weighting' Custom Field Value * Weighting %age.
--			Sum up all of these weightings as a total for the Project Forecast.
--			Divide this total by the Total for all Project Forecasts as a percentage. 
Create Procedure CalculateProjectScore
	@portfolioKey int	
AS

	DECLARE @sql as nvarchar(2000);
	DECLARE @fieldValue as int;
	DECLARE @table as nvarchar(100);
	DECLARE @cfKey as int;
	DECLARE @weighting as float;


	CREATE TABLE #TempTable 
	(
		PSF_Key int,
		CF_Key int,
		[Weight] float,
		CustomValue float,
		Weighting float
	)

	DECLARE @maxSW as int;
	DECLARE @currentSW as int;

	SELECT	@maxSW = max(ScoreWeights.SCW_Key)
	FROM ScoreWeights
	WHERE ScoreWeights.PFL_Key = @portfolioKey

	SELECT @currentSW  = coalesce(MIN(ScoreWeights.SCW_Key), -1) 
	FROM ScoreWeights
	WHERE ScoreWeights.PFL_Key = @portfolioKey;

	-- loop through from Custom field weightings for this Portfolio
	WHILE @currentSW <> -1
	BEGIN

		
		SELECT	@cfKey = CF_Key,
				@weighting = ScoreWeights.SCW_Weight
		FROM	ScoreWeights
		WHERE	ScoreWeights.SCW_Key = @currentSW;
		
		select @fieldValue = CF_CustomFieldIndex,
				@table = CF_CustomTableName + RTRIM(CAST(CF_CustomTableIndex as nvarchar))
		From	CustomFields		
		where	CF_Key = @cfKey;
		
		-- insert a row for each ProjectForecast and each custon field weighting with the custom field value * the weight value (weighting)				
		SET @sql = ' INSERT INTO #TempTable (PSF_Key, CF_Key, Weight, CustomValue, Weighting)  
				SELECT PPC.PSF_Key,' + rtrim(CAST( @cfKey as nvarchar))+ ' , ( ' + rtrim(cast(@weighting as nvarchar)) + '), CU_Value' + rtrim(cast(@fieldValue as nvarchar))  + ' ,CU_Value' + rtrim(cast(@fieldValue as nvarchar))  + ' * (' + RTRIM(cast(@weighting as nvarchar)) + ')  
				FROM Portfolio' + @table + ' as PPC 
				inner join PortfolioScenarioForecast PSF On PSF.PSF_Key = PPC.PSF_Key
				inner join PortfolioScenario PS ON PS.PSC_Key = PSF.PSC_Key
				Where PFL_Key = ' + cast(@portfolioKey as nvarchar) ;	
		
		--select @sql;
		
		exec(@sql);
		
		SELECT @currentSW  = coalesce(MIN(ScoreWeights.SCW_Key), -1)
		FROM ScoreWeights
		WHERE	ScoreWeights.SCW_Key > @currentSW;

	END

	-- Create a temp table to hold the totals
	DECLARE @TempTotals TABLE 
	(
		PSF_Key int,
		WeightingTotal float,
		AllProjectsTotal float,
		Score float	
	)

	-- Sum the Weightings into 1 row per ProjectForecast
	INSERT INTO @TempTotals (PSF_Key,WeightingTotal)
	SELECT PSF_Key, SUM(ISNULL(Weighting,0))
	FROM #TempTable
	GROUP BY #TempTable.PSF_Key

	IF ((SELECT SUM(WeightingTotal) FROM @TempTotals) > 0)
		BEGIN
			-- Update the Totals with the Totals across all projects
			UPDATE @TempTotals
			SET AllProjectsTotal = (SELECT SUM(WeightingTotal) FROM @TempTotals);

			-- Calculate the score 
			UPDATE @TempTotals
			SET Score = ((WeightingTotal / AllProjectsTotal) * 100) FROM @TempTotals;
		END;
	ELSE
		BEGIN
			UPDATE @TempTotals
			SET Score = 0;
		END;		
		
		
	--Update the ProjectForecast record with the new Score Value
	UPDATE PSF
	SET PSF.PSF_Score = TOT.Score 
	FROM PortfolioScenarioForecast PSF
	INNER JOIN @TempTotals TOT On PSF.PSF_Key = TOT.PSF_Key;

	--select * from #TempTable;
	--select * from @TempTotals;

	drop table #TempTable;
	--drop table @TempTotals;

GO
GRANT EXECUTE
	ON [dbo].[CalculateProjectScore]
	TO [V6N14816rwZf]
GO
