SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- PR7e

--NF8s
--Stored Procedure to calculate Task-based Planning Actuals
CREATE PROCEDURE [aec_BL_Planning_CalculateTaskActuals]
	@pProjectCode nvarchar(20) = NULL	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	EXEC aec_DAL_Planning_CalculateTaskActuals @pProjectCode

	-- Recalculate Project Custom Measures
	DECLARE @lngTriggerTypes AS BIGINT
	SET @lngTriggerTypes = POWER(2, 29)
	EXEC aec_BL_Core_UpdateCustomMeasures @pEntity=1001, @pTriggerTypes=@lngTriggerTypes

END
--NF8e
GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Planning_CalculateTaskActuals]
	TO [V6N14816rwZf]
GO
