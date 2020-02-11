SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_BL_Core_ClearCustomMeasureByKey
Purpose
    Clears the value of a Measure Custom Field for an Entity identified by a Key.
Behaviour
	Updates the appropriate storage slot with a NULL value or an empty string as appropriate.
Parameters
    @pDataType		- The Date type of the Custom Field
    @pTableName		- The name of the Table containing the Custom Field e.g. DeliverableCustomNum1
    @pFieldName		- The name of the Field in the Custom Field Table e.g. CU_Value1
    @pKeyField		- The name of the Entity Key Field e.g. DV_Key
	@pKey			- The Key of the Entity
Prerequisites
	None
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Core_ClearCustomMeasureByKey](@pDataType AS INTEGER,
													 @pTableName AS NVARCHAR(100),
													 @pFieldName AS NVARCHAR(20), 
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

	IF ((@pDataType = @INT_DataType_Integer) OR
		(@pDataType = @INT_DataType_Float) OR
		(@pDataType = @INT_DataType_Boolean) OR
		(@pDataType = @INT_DataType_Date) OR
		(@pDataType = @INT_DataType_NumberList))
	BEGIN
		----------------
		-- Numeric field
		----------------
		SET @strSQL =
			'UPDATE ' + @pTableName + ' ' +
			'SET ' + @pFieldName + ' = NULL ' +
			'WHERE ' + @pKeyField + ' = @key';
	END
	ELSE
	BEGIN
		-------------
		-- Text field
		-------------
		SET @strSQL =
			'UPDATE ' + @pTableName + ' ' +
			'SET ' + @pFieldName + ' = '''' ' +
			'WHERE ' + @pKeyField + ' = @key';
	END

	SET @strParamDefinition = '@key INTEGER';

	EXECUTE sp_executesql 
					@strSQL,
					@strParamDefinition,
					@key = @pKey;
END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_ClearCustomMeasureByKey]
	TO [V6N14816rwZf]
GO
