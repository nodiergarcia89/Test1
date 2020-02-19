SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [aec_BL_Core_CreateCustomMeasureArchiveRecordByCode](@pArchiveTableName AS NVARCHAR(100),
																    @pArchiveFields AS NVARCHAR(MAX), 
																    @pTableName AS NVARCHAR(100),
																    @pTimestamp AS FLOAT,
																    @pCodeField AS NVARCHAR(20), 
																    @pCode AS NVARCHAR(20))
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
				'(' + @pCodeField + ', CU_Date, ' + @pArchiveFields + ') ' +
				'SELECT ' + @pCodeField + ', @updateDateTime, ' + @pArchiveFields + ' ' +
				'FROM ' + @pTableName + ' ' +
				'WHERE ' + @pCodeField + ' = @code';
	END
	ELSE
	BEGIN
		-----------------------
		-- No fields to archive
		-----------------------
		SET @strSQL = 
				'INSERT INTO ' + @pArchiveTableName + ' ' +
				'(' + @pCodeField + ', CU_Date) ' +
				'SELECT ' + @pCodeField + ', @updateDateTime ' +
				'FROM ' + @pTableName + ' ' +
				'WHERE ' + @pCodeField + ' = @code';
	END

	-- Exceute the SQL
	SET @strParamDefinition = '@code NVARCHAR(20), @updateDateTime FLOAT';

	EXECUTE sp_executesql
					@strSQL,
					@strParamDefinition,
					@code = @pCode,
					@updateDateTime = @pTimestamp;
END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_CreateCustomMeasureArchiveRecordByCode]
	TO [V6N14816rwZf]
GO
