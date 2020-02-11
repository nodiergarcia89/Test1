SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_DAL_CustomScheduledJob
Purpose
    Runs custom SQL
Behaviour
	Runs custom SQL from the Jobs table based on a Job Code. Allows custom SQL to be scheduled via the app.
Parameters
	@pJobCode - The Code of the Job SQL to execute	
Prerequisites
	n/a	
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [aec_DAL_CustomScheduledJob](@pJobCode AS NVARCHAR(20)) 
AS
BEGIN
    -- Insert statements for procedure here
	DECLARE @SQLText NVARCHAR(MAX);
	SELECT @SQLText = JO_CommandText FROM Jobs WHERE JO_Code = @pJobCode;

	IF (LEN(@SQLText) > 0) 
	BEGIN 
		EXECUTE (@SQLText);
	END 
END

GO
GRANT EXECUTE
	ON [dbo].[aec_DAL_CustomScheduledJob]
	TO [V6N14816rwZf]
GO
