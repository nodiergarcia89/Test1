SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************************************************
	aecspCodeConverterLoginGroup
***********************************************************************************************/
--Modify the Stored Procedure
CREATE PROCEDURE [aecspCodeConverterLoginGroup](@oldCode AS NVARCHAR(100), @newCode AS NVARCHAR(100), 
											  @outputPrintStatements as BIT = 1,
											  @raiseErrorToClient as BIT = 0) AS

--Turn off the rows affected messages
SET NOCOUNT ON 

--Display Status Message
IF (@outputPrintStatements=1)
	PRINT 'Creating Temporary Table...'

--Create the temporary table
CREATE TABLE #CodeConverterTableReferences
(
FK_Table		NVARCHAR(30) COLLATE database_default,
FK_Column		NVARCHAR(30) COLLATE database_default,
UP_Code			NVARCHAR(250) COLLATE database_default
)

--Populate the Table References table for the 'LoginGroup' table
EXEC aecspCodeConverterPopulateReferencesTable 'LoginGroup', @outputPrintStatements;

--Now we need to add any other table references that do not have a Foreign Key constraint to the 'LoginGroup' table
INSERT INTO #CodeConverterTableReferences SELECT TABLE_NAME, COLUMN_NAME, NULL FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'LG_Code' AND TABLE_NAME NOT IN (SELECT FK_Table FROM #CodeConverterTableReferences) AND TABLE_NAME <> 'LoginGroup' AND NOT (TABLE_NAME LIKE 'syncobj_%')

--Manually append anything else here

-- Currently, DC_TypeCode is only ever a LoginGroup Code
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('DashboardConfig', 'DC_TypeCode')

--Append UserParams here


--Start the Transaction
BEGIN TRANSACTION

BEGIN TRY
	--Now we can perform the code conversion
	EXEC aecspCodeConverter 'LoginGroup', 'LG_Code', @oldCode, @newCode, @outputPrintStatements;

	--Perform any other Login Group specific updates here
	DELETE FROM AECLogin WHERE US_Code IN (SELECT US_Code FROM Users WHERE LG_Code = @newCode)

	--Commit the Transaction
	COMMIT

	--Display Success
	IF (@outputPrintStatements=1)
		PRINT 'Login Group Code has successfully been converted from ' + @oldCode + ' to ' + @newCode + '.'
		
END TRY
BEGIN CATCH
	DECLARE @ErrorValue AS INT
	DECLARE @ErrorMessage AS NVARCHAR(MAX)

	--Return the Error Number and Error Message
	SET @ErrorValue = @@ERROR
	SET @ErrorMessage = ERROR_MESSAGE()

	--Rollback the Transaction
	ROLLBACK

	--Display Failure
	DECLARE @ErrText NVARCHAR(MAX); SET @ErrText = 'Login Group Code conversion has faild. Error Number: ' + CONVERT(VARCHAR(10), @ErrorValue) + ' (' + @ErrorMessage + '). The operation has been aborted.'
	
	IF (@outputPrintStatements=1)
		PRINT @ErrText
	
	IF (@raiseErrorToClient = 1)
		BEGIN
			RAISERROR (@ErrText, 16, 1)
		END
		
	
END CATCH	

--Drop the temporary table
DROP TABLE #CodeConverterTableReferences

--Turn on the rows affected messages
SET NOCOUNT OFF 

GO
GRANT EXECUTE
	ON [dbo].[aecspCodeConverterLoginGroup]
	TO [V6N14816rwZf]
GO
