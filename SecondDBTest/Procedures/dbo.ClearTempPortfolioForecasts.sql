SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

			
Create Procedure ClearTempPortfolioForecasts
	@UsCode	nvarchar(20)
AS
	if EXISTS(select 1 from Portfolio where US_Code = @UsCode and PFL_IsTemp = -1)
	BEGIN
		DECLARE @PFL_Key int;

		select @PFL_Key = PFL_Key
		FROM	Portfolio
		WHERE US_Code = @UsCode and PFL_IsTemp = -1;
		
		DELETE PortfolioForecasts
		WHERE PFL_Key = @PFL_Key;
		
		DELETE PortfolioProjects
		WHERE PFL_Key = @PFL_Key;

		DELETE Portfolio
		WHERE PFL_Key = @PFL_Key;

	END;
GO
GRANT EXECUTE
	ON [dbo].[ClearTempPortfolioForecasts]
	TO [V6N14816rwZf]
GO
