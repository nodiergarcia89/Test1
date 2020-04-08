SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_BL_Core_UpdateCustomMeasuresForProject
Purpose
    Updates the Measures for the specified Project.
Behaviour
	Updates the Measures for the specified Entity.
Parameters
	@pCode			- The Code of the Project to be updated.
	@pLevel			- The Level of the Project to be updated.
	@pTriggerType	- A Trigger Type identifying the Custom Fields to be updated.
					  An AtlanticGlobal.AGS.BL.Core.CustomField.TriggerTypeValues enumerated value.
Prerequisites
	#CustomFields temporary table
	aec_BL_Core_ClearCustomMeasureByCode
	aec_BL_Core_UpdateCustomMeasureByCode
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Core_UpdateCustomMeasuresForProject](@pCode AS NVARCHAR(20), 
															@pLevel AS INTEGER,
															@pTriggerType AS BIGINT) 
AS
BEGIN

	DECLARE @intOptions AS INTEGER;
	DECLARE @intHasApplicableFields AS INTEGER;
	DECLARE @intDataType AS INTEGER;
	DECLARE @strTableName AS NVARCHAR(100);
	DECLARE @strFieldName AS NVARCHAR(20);
	DECLARE @strMeasureSQL AS NVARCHAR(MAX);
	DECLARE @lngTriggerTypes AS BIGINT;

	-- See if any of the Measure Custom Fields is applicable to this Project
	SET @intHasApplicableFields = 0;

	DECLARE curCustomFields CURSOR LOCAL FAST_FORWARD FOR
		SELECT CF_Options, CF_TriggerTypes
		FROM #CustomFields;

	OPEN curCustomFields;

	FETCH NEXT FROM curCustomFields INTO @intOptions, @lngTriggerTypes;

	WHILE (@@FETCH_STATUS = 0 AND @intHasApplicableFields = 0)
	BEGIN
		IF ((@lngTriggerTypes & @pTriggerType) > 0)
		BEGIN
			IF ((@intOptions & POWER(2, @pLevel - 1)) = POWER(2, @pLevel - 1))
			BEGIN
				SET @intHasApplicableFields = -1;
			END
		END

		FETCH NEXT FROM curCustomFields INTO @intOptions, @lngTriggerTypes;
	END

	CLOSE curCustomFields;
	DEALLOCATE curCustomFields;

	IF (@intHasApplicableFields = -1)
	BEGIN
		-- Begin transaction for this Project
		BEGIN TRANSACTION

		------------------
		-- Update Measures
		------------------
		DECLARE curCustomFields CURSOR LOCAL FAST_FORWARD FOR
			SELECT CF_DataType, CF_Options, CF_TableName, CF_FieldName, CF_MeasureSQL, CF_TriggerTypes
			FROM #CustomFields;

		OPEN curCustomFields;

		FETCH NEXT FROM curCustomFields INTO @intDataType, @intOptions, @strTableName, @strFieldName, @strMeasureSQL, @lngTriggerTypes;

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			IF ((@lngTriggerTypes & @pTriggerType) > 0)
			BEGIN
				IF ((@intOptions & POWER(2, @pLevel - 1)) = POWER(2, @pLevel - 1))
				BEGIN
					-- Set new value
					EXECUTE aec_BL_Core_UpdateCustomMeasureByCode
										@intDataType, 
										@strTableName, 
										@strFieldName, 
										@strMeasureSQL, 
										'PR_Code', 
										@pCode;
				END
				ELSE
				BEGIN
					-- Clear any existing value in case the Custom Field is no longer applicable to this Project
					EXECUTE aec_BL_Core_ClearCustomMeasureByCode
										@intDataType, 
										@strTableName, 
										@strFieldName, 
										'PR_Code', 
										@pCode;
				END
			END

			FETCH NEXT FROM curCustomFields INTO @intDataType, @intOptions, @strTableName, @strFieldName, @strMeasureSQL, @lngTriggerTypes;
		END

		CLOSE curCustomFields;
		DEALLOCATE curCustomFields;

		-- Commit the Transaction
		COMMIT;
	END
END	

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_UpdateCustomMeasuresForProject]
	TO [V6N14816rwZf]
GO
