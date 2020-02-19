SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

	
/***********************************************************************************************
	aecspCodeConverterActionType
***********************************************************************************************/
CREATE PROCEDURE [aecspCodeConverterActionType](@oldCode AS NVARCHAR(100), @newCode AS NVARCHAR(100), 
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

--Populate the Table References table for the 'ActionType' table
EXEC aecspCodeConverterPopulateReferencesTable 'ActionType', @outputPrintStatements;

--Now we need to add any other table references that do not have a Foreign Key constraint to the 'ActionType' table
INSERT INTO #CodeConverterTableReferences SELECT TABLE_NAME, COLUMN_NAME, NULL FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'AT_Code' AND TABLE_NAME NOT IN (SELECT FK_Table FROM #CodeConverterTableReferences) AND TABLE_NAME <> 'ActionType' AND NOT (TABLE_NAME LIKE 'syncobj_%')

--Manually append anything else here


--Append UserParams
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-USER-MYACTIONS-ACTION-TYPE-CODE')

--Start the Transaction
BEGIN TRANSACTION

BEGIN TRY
	--Now we can perform the code conversion
	EXEC aecspCodeConverter 'ActionType', 'AT_Code', @oldCode, @newCode, @outputPrintStatements


	-- Change any Action Type Code references in the CustomFieldFreeText.CFF_RecordCode column (this is not a proper FK reference)
	IF EXISTS(
				SELECT cfft.* 
				FROM CustomFieldFreeText cfft 
				INNER JOIN CustomFields cf ON (cfft.CF_Key = cf.CF_Key)
				WHERE (cf.CF_Table = 1016)	-- action type entity type
				AND (cfft.CFF_RecordCode = @oldCode)
			)
		BEGIN
			UPDATE CustomFieldFreeText
			SET CFF_RecordCode = @newCode
			FROM CustomFieldFreeText cfft
			INNER JOIN CustomFields cf ON (cfft.CF_Key = cf.CF_Key)
			WHERE (cf.CF_Table = 1016)	-- action type entity type
			AND (cfft.CFF_RecordCode = @oldCode)
		END


	--Perform any other Action Type specific updates here



	
	-- Update any saved Action Grid configurations for the Action Type
	UPDATE UserLists
	SET UL_Name = @newCode
	WHERE UL_Type LIKE 'ACTIONGRDCFG-%'
	AND UL_Name = @oldCode
	


	--Commit the Transaction
	COMMIT

	--Display Success
	IF (@outputPrintStatements=1)
		PRINT 'Action Type Code has successfully been converted from ' + @oldCode + ' to ' + @newCode + '.'
	
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
	DECLARE @ErrText NVARCHAR(MAX); SET @ErrText = 'Action Type Code conversion has faild. Error Number: ' + CONVERT(VARCHAR(10), @ErrorValue) + ' (' + @ErrorMessage + '). The operation has been aborted.';

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
	ON [dbo].[aecspCodeConverterActionType]
	TO [V6N14816rwZf]
GO
