SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [aec_BL_Core_CreateCustomMeasureArchiveRecordByKey](@pArchiveTableName AS NVARCHAR(100),
																   @pArchiveFields AS NVARCHAR(MAX), 
																   @pTableName AS NVARCHAR(100),
																   @pTimestamp AS FLOAT,
																   @pKeyField AS NVARCHAR(20), 
																   @pKey AS INTEGER)
AS
BEGIN
	DECLARE @strSQL AS NVARCHAR(MAX);
	DECLARE @strParamDefinition AS NVARCHAR(500);

	---------------------------------------------------------------------
	-- Build an appropriate INSERT statement for the Custom Field Table.
	-- If we don't have any fields to Archive just insert a blank record.
	---------------------------------------------------------------------
	IF (LEN(@pArchiveFields) > 0)
	BEGIN
		--------------------
		-- Fields to archive
		--------------------
		SET @strSQL = 
				'INSERT INTO ' + @pArchiveTableName + ' ' +
				'(' + @pKeyField + ', CU_Date, ' + @pArchiveFields + ') ' +
				'SELECT ' + @pKeyField + ', @updateDateTime, ' + @pArchiveFields + ' ' +
				'FROM ' + @pTableName + ' ' +
				'WHERE ' + @pKeyField + ' = @key';
	END
	ELSE
	BEGIN
		-----------------------
		-- No fields to archive
		-----------------------
		SET @strSQL = 
				'INSERT INTO ' + @pArchiveTableName + ' ' +
				'(' + @pKeyField + ', CU_Date) ' +
				'SELECT ' + @pKeyField + ', @updateDateTime ' +
				'FROM ' + @pTableName + ' ' +
				'WHERE ' + @pKeyField + ' = @key';
	END

	-- Exceute the SQL
	SET @strParamDefinition = '@key INTEGER, @updateDateTime FLOAT';

	EXECUTE sp_executesql
					@strSQL,
					@strParamDefinition,
					@key = @pKey,
					@updateDateTime = @pTimestamp;
END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_CreateCustomMeasureArchiveRecordByKey]
	TO [V6N14816rwZf]
GO
