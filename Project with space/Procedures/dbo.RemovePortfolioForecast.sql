SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure RemovePortfolioForecast
	@ForecastKey	int,
	@UsCode	nvarchar(20)
AS
	DECLARE @PortfolioKey int;
	DECLARE @PPRKey int;

	IF EXISTS (select 1 from Portfolio where PFL_IsTemp = -1 and US_Code = @UsCode)
		BEGIN
			select @PortfolioKey = PFL_Key from Portfolio where PFL_IsTemp = -1 and US_Code = @UsCode;					
			
			-- get the key of the Portfolio Project record to delete
			select @PPRKey = PP.PPR_Key
			from PortfolioProjects PP
			inner join PortfolioForecasts PF on PP.PPR_Key = PF.PPR_Key			
			inner join Portfolio on Portfolio.PFL_Key = PF.PFL_Key
			where PFO_ProfileKey = @ForecastKey
			and Portfolio.PFL_IsTemp = -1
			and Portfolio.PFL_Key = @PortfolioKey;			
			
			-- delete from Portfolio Forecast table
			delete PF 
			from PortfolioForecasts PF
			inner join Portfolio on Portfolio.PFL_Key = PF.PFL_Key
			where PFO_ProfileKey = @ForecastKey
			and Portfolio.PFL_IsTemp = -1
			and Portfolio.PFL_Key = @PortfolioKey;
			
			-- delete from the portfolio projects
			delete from PortfolioProjects where PPR_Key = @PPRKey;
			
		END	
	
GO
GRANT EXECUTE
	ON [dbo].[RemovePortfolioForecast]
	TO [V6N14816rwZf]
GO
