SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/***********************************************************************************************
	aecspCodeConverterClientGroup
***********************************************************************************************/
CREATE PROCEDURE [aecspCodeConverterClientGroup] (@oldCode AS NVARCHAR(100), @newCode AS NVARCHAR(100), 
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

--Populate the Table References table for the 'ClientGroup' table
EXEC aecspCodeConverterPopulateReferencesTable 'ClientGroups', @outputPrintStatements;

--Now we need to add any other table references that do not have a Foreign Key constraint to the 'ClientGroups' table
INSERT INTO #CodeConverterTableReferences SELECT TABLE_NAME, COLUMN_NAME, NULL FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'CG_Code' AND TABLE_NAME NOT IN (SELECT FK_Table FROM #CodeConverterTableReferences) AND TABLE_NAME <> 'ClientGroups' AND NOT (TABLE_NAME LIKE 'syncobj_%')

--Manually append anything else here


--Append UserParams here


--Start the Transaction
BEGIN TRANSACTION

BEGIN TRY
	--Now we can perform the code conversion
	EXEC aecspCodeConverter 'ClientGroups', 'CG_Code', @oldCode, @newCode, @outputPrintStatements;

	-- Change any Client Group Code references in the CustomFieldFreeText.CFF_RecordCode column (this is not a proper FK reference)
	IF EXISTS(
				SELECT cfft.* 
				FROM CustomFieldFreeText cfft 
				INNER JOIN CustomFields cf ON (cfft.CF_Key = cf.CF_Key)
				WHERE (cf.CF_Table = 1013)	-- client group entity type
				AND (cfft.CFF_RecordCode = @oldCode)
			)
		BEGIN
			UPDATE CustomFieldFreeText
			SET CFF_RecordCode = @newCode
			FROM CustomFieldFreeText cfft
			INNER JOIN CustomFields cf ON (cfft.CF_Key = cf.CF_Key)
			WHERE (cf.CF_Table = 1013)	-- client group entity type
			AND (cfft.CFF_RecordCode = @oldCode)
		END


	--Perform any other Client Group specific updates here






	--Commit the Transaction
	COMMIT

	--Display Success
	IF (@outputPrintStatements=1)
		PRINT 'Client Group Code has successfully been converted from ' + @oldCode + ' to ' + @newCode + '.'
		
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
	DECLARE @ErrText NVARCHAR(MAX); SET @ErrText = 'Client Group Code conversion has faild. Error Number: ' + CONVERT(VARCHAR(10), @ErrorValue) + ' (' + @ErrorMessage + '). The operation has been aborted.'
	
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
	ON [dbo].[aecspCodeConverterClientGroup]
	TO [V6N14816rwZf]
GO
