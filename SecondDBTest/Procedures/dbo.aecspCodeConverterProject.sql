SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
/**************************************************************************************************************************************
											  KeyedIn Projects Database Upgrade Script 
														v6.4.0 to v6.4.0.43643
***************************************************************************************************************************************

CT1 - 08/04/2019
	Mod - Update Stored Procedure for Project Code Converter to include favourite references

TL1 - 24/06/2019
	Mod - Correct WidgetConfig with int.maxvalue with default pagesize	
**************************************************************************************************************************************/	

/* CT1s */

/***********************************************************************************************
	aecspCodeConverterProject
	-- Mod, Filter out the new ProjectPlanTasks View 
	-- Mod, Adjust the current selected Dashboard Project userparam
	-- Mod, Use Information_Schema.Views instead of Manual View Names
	-- Mod, Update UserFavourites Table if any refrences to this ProjectCode exist
***********************************************************************************************/
CREATE PROCEDURE aecspCodeConverterProject(@oldCode AS NVARCHAR(100), @newCode AS NVARCHAR(100), 
											  @outputPrintStatements as BIT = 1,
											  @raiseErrorToClient as BIT = 0) AS

--Turn off the rows affected messages
SET NOCOUNT ON 

--Display Status Message
IF (@outputPrintStatements=1)
	PRINT 'Creating Temporary Table...'

--Populate the temporary table
CREATE TABLE #CodeConverterTableReferences
(
FK_Table		NVARCHAR(30) COLLATE database_default,
FK_Column		NVARCHAR(30) COLLATE database_default,
UP_Code			NVARCHAR(250) COLLATE database_default
)

--Create the Table References table for the 'Projects' table
EXEC aecspCodeConverterPopulateReferencesTable 'Projects', @outputPrintStatements;

--Now we need to add any other table references that do not have a Foreign Key constraint to the 'Projects' table
INSERT INTO #CodeConverterTableReferences 
SELECT TABLE_NAME, COLUMN_NAME, NULL 
FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'PR_Code' 
AND TABLE_NAME NOT IN (SELECT FK_Table FROM #CodeConverterTableReferences) 
AND TABLE_NAME <> 'Projects' 
AND TABLE_NAME NOT IN (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS)
AND NOT (TABLE_NAME LIKE 'syncobj_%')

--Manually append anything else here
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level1Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level2Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level3Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level4Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level5Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level6Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level7Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level8Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level9Code')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column) VALUES ('ProjectOrder', 'PO_Level10Code')

--Append UserParams
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-PROJECT-PROJECTCODE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-PS-PROJCODE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-RESOURCE-CAPABILITY-PROJECT')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-SCHD-PROJECT-CODE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-USER-DEL-SELECTEDPROJ')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-USER-MYDEP-PROJECT-CODE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-USER-MYISSUES-PROJ-CODE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'DSH-USER-MYRISKS-PROJ-CODE')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'PLN-ACTIVITYPLAN-PROJECT')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'PLN-ACTIVITYREVIEW-PROJECT')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'PRJSUPPLY-DEFAULTPROJ')
INSERT INTO #CodeConverterTableReferences (FK_Table, FK_Column, UP_Code) VALUES ('UserParams', 'UP_Value', 'VIEW-PROJECTCODE')


--Start the Transaction
BEGIN TRANSACTION

BEGIN TRY
	--Now we can perform the code conversion
	EXEC aecspCodeConverter 'Projects', 'PR_Code', @oldCode, @newCode, @outputPrintStatements;

	-- Change any Project Code references in the CustomFieldFreeText.CFF_RecordCode column (this is not a proper FK reference)
	IF EXISTS(
				SELECT cfft.* 
				FROM CustomFieldFreeText cfft 
				INNER JOIN CustomFields cf ON (cfft.CF_Key = cf.CF_Key)
				WHERE (cf.CF_Table = 1001)	-- project entity type
				AND (cfft.CFF_RecordCode = @oldCode)
			)
		BEGIN
			UPDATE CustomFieldFreeText
			SET CFF_RecordCode = @newCode
			FROM CustomFieldFreeText cfft
			INNER JOIN CustomFields cf ON (cfft.CF_Key = cf.CF_Key)
			WHERE (cf.CF_Table = 1001)	-- project entity type
			AND (cfft.CFF_RecordCode = @oldCode)
		END

	--Perform any other Project specific updates here
	IF EXISTS(
				SELECT NTF_Key
				FROM Notifications
				WHERE ND_Key = 7
				AND (Notifications.NTF_ContextCode = @oldCode)
			)
		BEGIN
			UPDATE Notifications
			SET NTF_ContextCode = @newCode
			WHERE ND_Key = 7
			AND (Notifications.NTF_ContextCode = @oldCode)
		END
	
	--Update the userFavourites Table if any refrences exist
	IF EXISTS(
				SELECT UF_Key
				FROM UserFavourites
				WHERE UF_Type = 1
				AND (UserFavourites.UF_CodeIdentity = @oldCode)
			)
		BEGIN
			UPDATE UserFavourites
			SET UF_CodeIdentity = @newCode
			WHERE UF_Type = 1
			AND(UserFavourites.UF_CodeIdentity = @oldCode)
		END
	--Commit the Transaction
	COMMIT

	--Display Success
	IF (@outputPrintStatements=1)
		PRINT 'Project Code has successfully been converted from ' + @oldCode + ' to ' + @newCode + '.'
		
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
	DECLARE @ErrText NVARCHAR(MAX); SET @ErrText = 'Project Code conversion has faild. Error Number: ' + CONVERT(VARCHAR(10), @ErrorValue) + ' (' + @ErrorMessage + '). The operation has been aborted.'
	
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
	ON [dbo].[aecspCodeConverterProject]
	TO [V6N14816rwZf]
GO
