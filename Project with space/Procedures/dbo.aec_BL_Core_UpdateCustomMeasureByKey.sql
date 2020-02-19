SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [aec_BL_Core_UpdateCustomMeasureByKey](@pDataType AS INTEGER,
													  @pTableName AS NVARCHAR(100),
													  @pFieldName AS NVARCHAR(20), 
													  @pMeasureSQL AS NVARCHAR(MAX), 
													  @pKeyField AS NVARCHAR(20), 
													  @pKey AS INTEGER)
AS
BEGIN
	--------------------------
	-- Custom Field Data Types
	--------------------------
	DECLARE @INT_DataType_Integer AS INTEGER;
	SET @INT_DataType_Integer = 1;

	DECLARE @INT_DataType_Float AS INTEGER;
	SET @INT_DataType_Float = 2;

	DECLARE @INT_DataType_Boolean AS INTEGER;
	SET @INT_DataType_Boolean = 3;

	DECLARE @INT_DataType_Date AS INTEGER;
	SET @INT_DataType_Date = 10;

	DECLARE @INT_DataType_NumberList AS INTEGER;
	SET @INT_DataType_NumberList = 22;

	DECLARE @strSQL AS NVARCHAR(MAX);
	DECLARE @strParamDefinition AS NVARCHAR(500);
	DECLARE @strNewValue AS NVARCHAR(250);
	DECLARE @dblNewValue AS FLOAT;

	IF ((@pDataType = @INT_DataType_Integer) OR
		(@pDataType = @INT_DataType_Float) OR
		(@pDataType = @INT_DataType_Boolean) OR
		(@pDataType = @INT_DataType_Date) OR
		(@pDataType = @INT_DataType_NumberList))
	BEGIN
		----------------
		-- Numeric field
		----------------
		SET @strParamDefinition = '@recordKey INTEGER, @outputValue FLOAT OUTPUT';

		-- Calculate new value
		EXECUTE sp_executesql
						@pMeasureSQL,
						@strParamDefinition,
						@recordKey = @pKey,
						@outputValue = @dblNewValue OUTPUT;

		-- Set new value
		SET @strSQL =
			'UPDATE ' + @pTableName + ' ' +
			'SET ' + @pFieldName + ' = @newValue ' +
			'WHERE ' + @pKeyField + ' = @key';

		SET @strParamDefinition = '@key INTEGER, @newValue FLOAT';

		EXECUTE sp_executesql
						@strSQL,
						@strParamDefinition,
						@key = @pKey,
						@newValue = @dblNewValue;
	END
	ELSE
	BEGIN
		-------------
		-- Text field
		-------------
		SET @strParamDefinition = '@recordKey INTEGER, @outputValue NVARCHAR(250) OUTPUT';

		-- Calculate new value
		EXECUTE sp_executesql
						@pMeasureSQL,
						@strParamDefinition,
						@recordKey = @pKey,
						@outputValue = @strNewValue OUTPUT;

		-- Set new value
		SET @strSQL =
			'UPDATE ' + @pTableName + ' ' +
			'SET ' + @pFieldName + ' = @newValue ' +
			'WHERE ' + @pKeyField + ' = @key';

		SET @strParamDefinition = '@key INTEGER, @newValue NVARCHAR(250)';

		EXECUTE sp_executesql
						@strSQL,
						@strParamDefinition,
						@key = @pKey,
						@newValue = @strNewValue;
	END
END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_UpdateCustomMeasureByKey]
	TO [V6N14816rwZf]
GO
