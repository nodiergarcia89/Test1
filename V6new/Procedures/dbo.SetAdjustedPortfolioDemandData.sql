SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE SetAdjustedPortfolioDemandData 
	@PFDL_Key int,
	@StartDate float,
	@Days float,
	@FTE float,
	@LocalCost float,
	@LocalCharge float,
	@SystemCost float,
	@SystemCharge float,
	@Status int
AS
	INSERT INTO PortfolioForecastDemandDetail (PFDL_Key, PP_StartDate, PFDD_Days, PFDD_FTE, PFDD_LocalCost, PFDD_SystemCost, PFDD_LocalCharge, PFDD_SystemCharge, PFDD_Status)
	select @PFDL_Key, @StartDate, @Days, @FTE, @LocalCost, @LocalCharge, @SystemCost, @SystemCharge, @Status;
GO
