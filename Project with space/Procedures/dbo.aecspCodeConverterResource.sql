SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO

/***********************************************************************************************
	aecspCodeConverterResource	
	-- Mod, Use Information_Schema.Views instead of Manual View Names
***********************************************************************************************/
CREATE PROCEDURE aecspCodeConverterResource(@oldCode AS NVARCHAR(100), @newCode AS NVARCHAR(100), 
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

--Populate the Table References table for the 'Res' table
EXEC aecspCodeConverterPopulateReferencesTable 'Res', @outputPrintStatements;

--Now we need to add any other table references that do not have a Foreign Key constraint to the 'Res' table
INSERT INTO #CodeConverterTableReferences SELECT TABLE_NAME, COLUMN_NAME, NULL FROM INFORMATION_SCHEMA.COLUMNS WHERE (COLUMN_NAME = 'RE_Code' OR COLUMN_NAME = 'RE_CodeRole') AND TABLE_NAME NOT IN (SELECT FK_Table FROM #CodeConverterTableReferences) 
AND TABLE_NAME <> 'Res'  
AND TABLE_NAME NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS)
AND NOT (TABLE_NAME LIKE 'syncobj_%')

--Manually append anything else here


--Append UserParams
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-PROJECT-FINANCE-ROLE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-PS-RESCODE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-RESOURCE-CAPABILITY-ROLE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-SCENARIO-RESOURCE-ROLE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-SCHD-REQ-ROLE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'PROJECT-DSH-PROJECT-RESCODE1')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'PROJECT-DSH-PROJECT-RESCODE2')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'PROJECT-DSH-PROJECT-RESCODE3')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'RESOURCE-CAPABILITY-DSH-RESCAP-RESCODE1')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'RESOURCE-CAPABILITY-DSH-RESCAP-RESCODE2')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'RESOURCE-CAPABILITY-DSH-RESCAP-RESCODE3')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'SCENARIO-DSH-SCENARIO-RESCODE1')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'SCENARIO-DSH-SCENARIO-RESCODE2')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'SCENARIO-DSH-SCENARIO-RESCODE3')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'USER-DSH-USER-RESCODE1')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'USER-DSH-USER-RESCODE2')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'USER-DSH-USER-RESCODE3')

--Start the Transaction
BEGIN TRANSACTION

BEGIN TRY
	--Now we can perform the code conversion
	EXEC aecspCodeConverter 'Res', 'RE_Code', @oldCode, @newCode, @outputPrintStatements;

	-- Change any Resource Code references in the CustomFieldFreeText.CFF_RecordCode column (this is not a proper FK reference)
	IF EXISTS(
				SELECT cfft.* 
				FROM CustomFieldFreeText cfft 
				INNER JOIN CustomFields cf ON (cfft.CF_Key = cf.CF_Key)
				WHERE (cf.CF_Table = 1002)	-- resource entity type
				AND (cfft.CFF_RecordCode = @oldCode)
			)
		BEGIN
			UPDATE CustomFieldFreeText
			SET CFF_RecordCode = @newCode
			FROM CustomFieldFreeText cfft
			INNER JOIN CustomFields cf ON (cfft.CF_Key = cf.CF_Key)
			WHERE (cf.CF_Table = 1002)	-- resource entity type
			AND (cfft.CFF_RecordCode = @oldCode)
		END

	--Perform any other Resource specific updates here
	DELETE FROM AECLogin WHERE US_Code IN (SELECT US_Code FROM Users WHERE RE_Code = @newCode)	

	IF EXISTS(
				SELECT NTF_Key
				FROM Notifications
				WHERE ND_Key IN (1, 3, 4, 5, 6)
				AND (Notifications.NTF_ContextCode = @oldCode)
			)
		BEGIN
			UPDATE Notifications
			SET NTF_ContextCode = @newCode
			WHERE ND_Key IN (1, 3, 4, 5, 6)
			AND (Notifications.NTF_ContextCode = @oldCode)
		END

	--Commit the Transaction
	COMMIT

	--Display Success
	IF (@outputPrintStatements=1)
		PRINT 'Resource Code has successfully been converted from ' + @oldCode + ' to ' + @newCode + '.'
		
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
	DECLARE @ErrText NVARCHAR(MAX); SET @ErrText = 'Resource Code conversion has faild. Error Number: ' + CONVERT(VARCHAR(10), @ErrorValue) + ' (' + @ErrorMessage + '). The operation has been aborted.'
	
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
	ON [dbo].[aecspCodeConverterResource]
	TO [V6N14816rwZf]
GO
