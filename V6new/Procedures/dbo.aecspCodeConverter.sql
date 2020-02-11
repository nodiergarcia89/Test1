SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

--Create the Stored Procedure
CREATE PROCEDURE [aecspCodeConverter](@primaryTable AS NVARCHAR(30), @primaryField AS NVARCHAR(30), 
									@oldCode AS NVARCHAR(100), @newCode AS NVARCHAR(100),
									@outputPrintStatements as BIT = 1) AS

--Ensure the Codes are in upper case
SET @oldCode = UPPER(LTRIM(RTRIM(@oldCode)))
SET @newCode = UPPER(LTRIM(RTRIM(@newCode)))

--Determine whether an Old Code has been specified
IF LEN(@oldCode) = 0
BEGIN
	RAISERROR ('Old Code has not been specified.', 16, 1)
    RETURN 
END
ELSE
BEGIN
	--Determine whether a New Code has been specified
	IF LEN(@newCode) = 0
	BEGIN
		RAISERROR ('New Code has not been specified.', 16, 1)
		RETURN 
	END
	ELSE
	BEGIN
		--Determine whether the length of the New Code exceeds 20 Chars (count doubled up single quotes as 1 character)
		IF LEN(@newCode) > 20
		BEGIN
			RAISERROR ('New Code cannot be longer than 20 characters.', 16, 1)
			RETURN 
		END
	END
END

--Escape single quotes
SET @oldCode = REPLACE(@oldCode, '''', '''''');
SET @newCode = REPLACE(@newCode, '''', '''''');

--XML Encode Old and New Codes for Timecard and UserList
DECLARE @oldCodeXMLEncode NVARCHAR(100)
DECLARE @newCodeXMLEncode NVARCHAR(100)

SET @oldCodeXMLEncode = REPLACE(REPLACE(REPLACE(@oldCode,'&', '&amp;'),'>','&gt;'),'<','&lt;')
SET @newCodeXMLEncode = REPLACE(REPLACE(REPLACE(@newCode,'&', '&amp;'),'>','&gt;'),'<','&lt;')


--Now we need to ensure that the old code exists and that the new code does not
DECLARE @strSQL AS NVARCHAR(4000)
DECLARE @intCount AS INT

--Build the SQL statement used to check for the existance of the old record
SELECT @strSQL = N'SELECT @Count = COUNT(*) FROM ' + @primaryTable + ' WHERE ' + @primaryField + ' = ''' + @oldCode + ''''
 
--Execute the SQL statement
EXEC sp_executesql @strSQL, N'@Count INT OUTPUT', @intCount OUTPUT
 
--Determine whether record with the old code exists
IF @intCount = 0
BEGIN
	RAISERROR ('A record with the old code cannot be found.', 16, 1)
    RETURN 
END
ELSE
BEGIN
	--Build the SQL statement used to check for the existance of the new record
	SELECT @strSQL = N'SELECT @Count = COUNT(*) FROM ' + @primaryTable + ' WHERE ' + @primaryField + ' = ''' + @newCode + ''''
	 
	--Execute the SQL statement
	EXEC sp_executesql @strSQL, N'@Count INT OUTPUT', @intCount OUTPUT

	--Determine whether record with the new code exists
	IF @intCount > 0
	BEGIN
		RAISERROR ('A record with the new code already exists.', 16, 1)
		RETURN 
	END
END

--Declare Variables
DECLARE @strTable AS NVARCHAR(50)
DECLARE @strColumn AS NVARCHAR(50)
DECLARE @strParamCode AS NVARCHAR(250)
DECLARE @strMessage AS NVARCHAR(500)

--Initialise Variables
SET @strSQL = N'INSERT INTO ' + @primaryTable + ' SELECT '

DECLARE crsColumns CURSOR FOR
	SELECT COLUMN_NAME
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @primaryTable
	ORDER BY ORDINAL_POSITION ASC

OPEN crsColumns

	FETCH NEXT FROM crsColumns INTO @strColumn
	WHILE (@@FETCH_STATUS = 0)
	BEGIN	
		--Build the SQL statement used to create the new record		
		IF @strColumn = @primaryField 
		BEGIN			
			SET @strSQL = @strSQL + '''' + @newCode + ''', '
		END
		ELSE
		BEGIN
			SET @strSQL = @strSQL + @strColumn + ', '
		END		

		--Return the next record from the record set
		FETCH NEXT FROM crsColumns INTO @strColumn
	END

CLOSE crsColumns
DEALLOCATE crsColumns

SET @strSQL = LEFT(@strSQL, LEN(@strSQL) - 1) + ' FROM ' + @primaryTable + ' WHERE ' + @primaryField + ' = ''' + @oldCode + ''''

--Display status message
IF (@outputPrintStatements=1)
	PRINT 'Creating New Record...';

--Execute the INSERT statement
EXEC (@strSQL);

--Now we need to run through the temporary table and update all relevant tables/columns there in
DECLARE crsTables CURSOR FOR
	SELECT FK_Table, FK_Column, UP_Code
	FROM #CodeConverterTableReferences

OPEN crsTables

	FETCH NEXT FROM crsTables INTO @strTable, @strColumn, @strParamCode
	WHILE (@@FETCH_STATUS = 0)
	BEGIN	
		--Build the UPDATE statement for the current Table/Column
		SET @strSQL = N'UPDATE ' + @strTable + ' SET ' + @strColumn + ' = ''' + @newCode + ''' WHERE ' + @strColumn + ' = ''' + @oldCode + ''''; 

		IF @strParamCode IS NOT NULL
		BEGIN
			SET @strSQL = @strSQL + ' AND UP_Code = ''' + @strParamCode + '''';
		END

		
		IF (@outputPrintStatements=1)
			BEGIN
				--Display status message
				SET @strMessage = 'Updating table ''' + @strTable + ''', Column ''' + @strColumn + '''';

				IF @strParamCode IS NOT NULL
				BEGIN
					SET @strMessage = @strMessage + ', Param Code = ''' + @strParamCode + '''';
				END

				SET @strMessage = @strMessage + '...';
				
				
				PRINT @strMessage;
			END 
			
		--Execute the UPDATE statement
		EXEC (@strSQL);

		--Return the next record from the record set
		FETCH NEXT FROM crsTables INTO @strTable, @strColumn, @strParamCode
	END

CLOSE crsTables
DEALLOCATE crsTables

--Determine whether we need to cater for Timecard entries
IF LOWER(@primaryTable) = 'projects' OR LOWER(@primaryTable) = 'activity'
BEGIN
	--Display status message
	IF (@outputPrintStatements=1)
		PRINT 'Updating Timecard Entries...'

	--Now we need to update any Timecard records
	DECLARE @RE_Code AS NVARCHAR(20)
	DECLARE @TC_Date AS FLOAT
	DECLARE @TC_Fields AS NVARCHAR(MAX)	
	DECLARE @strNode AS NVARCHAR(20)
	
	IF LOWER(@primaryTable) = 'projects'
	BEGIN 
		SET @strNode = 'project'
	END
	ELSE
	BEGIN
		SET @strNode = 'activity'
	END

	DECLARE crsTimecard CURSOR FOR 
		SELECT RE_Code, TC_Date, TC_Fields
		FROM Timecard
		WHERE TC_Fields LIKE '%<' + @strNode + '>' + @oldCodeXMLEncode + '</' + @strNode + '>%'
		FOR UPDATE OF TC_Fields

	OPEN crsTimecard

		FETCH NEXT FROM crsTimecard INTO @RE_Code, @TC_Date, @TC_Fields
		WHILE (@@FETCH_STATUS = 0)
		BEGIN	
			--Update the current record with the new Project Code
			UPDATE Timecard
			SET TC_Fields = REPLACE(@TC_Fields, '<' + @strNode + '>' + @oldCodeXMLEncode + '</' + @strNode + '>', '<' + @strNode + '>' + @newCodeXMLEncode + '</' + @strNode + '>')
			WHERE CURRENT OF crsTimecard

			--Return the next record from the record set
			FETCH NEXT FROM crsTimecard INTO @RE_Code, @TC_Date, @TC_Fields
		END

	CLOSE crsTimecard
	DEALLOCATE crsTimecard
END

--Determine whether we need to cater for UserList entries
IF LOWER(@primaryTable) = 'projects' OR LOWER(@primaryTable) = 'res'
BEGIN
	--Display status message
	IF (@outputPrintStatements=1)
		PRINT 'Updating UserList Entries...'

	--Now we need to update any UserList records
	DECLARE @UL_ItemsXML AS NVARCHAR(MAX)
	DECLARE @UL_Type AS NVARCHAR(30)
	
	IF LOWER(@primaryTable) = 'projects'
	BEGIN 
		SET @UL_Type = 'Dashboard_Projects'
	END
	ELSE
	BEGIN
		SET @UL_Type = 'Dashboard_Resources'
	END

	DECLARE crsUserList CURSOR FOR 
		SELECT UL_ItemsXML
		FROM UserLists
		WHERE UL_ItemsXML LIKE '%<Code>' + @oldCodeXMLEncode + '</Code>%'
		AND UL_Type = @UL_Type
		FOR UPDATE OF UL_ItemsXML


	OPEN crsUserList

		FETCH NEXT FROM crsUserList INTO @UL_ItemsXML
		WHILE (@@FETCH_STATUS = 0)
		BEGIN	
			--Update the current record with the new Resource Code
			UPDATE UserLists
			SET UL_ItemsXML = REPLACE(@UL_ItemsXML, '<Code>' + @oldCodeXMLEncode + '</Code>', '<Code>' + @newCodeXMLEncode + '</Code>')
			WHERE CURRENT OF crsUserList

			--Return the next record from the record set
			FETCH NEXT FROM crsUserList INTO @UL_ItemsXML
		END

	CLOSE crsUserList
	DEALLOCATE crsUserList	
END

--Display status message
IF (@outputPrintStatements=1)
	PRINT 'Deleting Old Record...'

--Now we can drop the record with the old code
EXEC (N'DELETE FROM ' + @primaryTable + ' WHERE ' + @primaryField + ' = ''' + @oldCode + '''');

GO
GRANT EXECUTE
	ON [dbo].[aecspCodeConverter]
	TO [V6N14816rwZf]
GO
