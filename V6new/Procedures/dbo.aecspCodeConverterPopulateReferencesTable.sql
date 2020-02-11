SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

--Create the Stored Procedure
CREATE PROCEDURE [aecspCodeConverterPopulateReferencesTable](@primaryTable AS NVARCHAR(30), @outputPrintStatements as BIT = 1) AS

--Determine whether the specified table exists
IF NOT EXISTS (SELECT name FROM sysobjects WHERE name = @primaryTable)
BEGIN
	DECLARE @strError AS NVARCHAR(50);
	SET @strError = '''' + @primaryTable + ''' table does not exist.';

	RAISERROR (@strError, 16, 1)
    RETURN 
END

--Declare Variables
DECLARE @intDataType AS INT

--Initialise Variables
SELECT @intDataType = CASE @primaryTable WHEN 'Activity' THEN 1000 WHEN 'Projects' THEN 1001 WHEN 'Res' THEN 1002 WHEN 'Departments' THEN 1006 WHEN 'Client' THEN 1012 ELSE 0 END 

--Display Status Message
IF (@outputPrintStatements=1)
	PRINT 'Populating Temporary Table...'

--Populate the temporary table with recognised Foreign Key Constraints
INSERT INTO #CodeConverterTableReferences
SELECT FK_Table = FK.TABLE_NAME, FK_Column = CU.COLUMN_NAME, UP_Code = NULL 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS RC 
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS FK ON RC.CONSTRAINT_NAME = FK.CONSTRAINT_NAME 
INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS PK ON RC.UNIQUE_CONSTRAINT_NAME = PK.CONSTRAINT_NAME 
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON RC.CONSTRAINT_NAME = CU.CONSTRAINT_NAME 
INNER JOIN ( 
    SELECT TC.TABLE_NAME, CU.COLUMN_NAME 
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC 
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE CU ON TC.CONSTRAINT_NAME = CU.CONSTRAINT_NAME 
    WHERE TC.CONSTRAINT_TYPE = 'PRIMARY KEY' 
) PT ON PT.TABLE_NAME = PK.TABLE_NAME 

WHERE PT.TABLE_NAME = @primaryTable


--Determine whether we need to append Custom Fields of type Entity
IF @intDataType > 0
BEGIN
	--Append Custom Fields of type entity for the specified table
	INSERT INTO #CodeConverterTableReferences
	SELECT CF_CustomTableName + CAST(CF_CustomTableIndex AS NVARCHAR), 'CU_Value' + CAST(CF_CustomFieldIndex AS NVARCHAR), NULL
	FROM CustomFields
	WHERE CF_DataType = @intDataType

	--If the table is 'Res' then ensure we pick up the Role entity as well as no way to distinguish
	IF @primaryTable = 'Res'
	BEGIN
		INSERT INTO #CodeConverterTableReferences
		SELECT CF_CustomTableName + CAST(CF_CustomTableIndex AS NVARCHAR), 'CU_Value' + CAST(CF_CustomFieldIndex AS NVARCHAR), NULL
		FROM CustomFields
		WHERE CF_DataType = 1006
	END
END


GO
GRANT EXECUTE
	ON [dbo].[aecspCodeConverterPopulateReferencesTable]
	TO [V6N14816rwZf]
GO
