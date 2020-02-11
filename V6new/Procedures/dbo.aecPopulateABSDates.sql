SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [aecPopulateABSDates] (@nStartDate INTEGER, @nEndDate  INTEGER) AS
--Purpose
--    Adds all dates between the start and end days to ABSDates if the date is not already present
--Behaviour
--    Checks that the date doesn;t exist before adding it to the table
--Parameters
--    nStartDate, First date to be added to the ABSDates table
--    nEndDate, Last date to be added to the ABSDates table

DECLARE @nNewDate INTEGER

SELECT @nNewDate = @nStartDate
WHILE @nNewDate <= @nEndDate
	BEGIN
		IF (SELECT Count(AD_Date) FROM ABSDates WHERE AD_Date = @nNewDate ) = 0
			BEGIN
				INSERT INTO ABSDates(AD_Date)
				VALUES (@nNewDate)
			END
		SELECT @nNewDate = @nNewDate + 1
	END

GO
GRANT EXECUTE
	ON [dbo].[aecPopulateABSDates]
	TO [V6N14816rwZf]
GO
