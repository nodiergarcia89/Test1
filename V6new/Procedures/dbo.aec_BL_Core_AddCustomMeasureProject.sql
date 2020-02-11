SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



/******************************************************************************************************
	aec_BL_Core_AddCustomMeasureProject
Purpose
    Ensures that the specified Project exists in the temporary Projects table.
Behaviour
	If the Project already exists then its Trigger Types are updated.
	Otherwise it is added to the table.
Parameters
	@pTriggerTypes	- A bitmap of Trigger Types identifying the Custom Fields to be updated.
					  A combination of AtlanticGlobal.AGS.BL.Core.CustomField.TriggerTypeValues enumerated values.
	@pTriggerType	- A Trigger Type to be set against the specified Project.
					  An AtlanticGlobal.AGS.BL.Core.CustomField.TriggerTypeValues enumerated value.
	@pCode			- The code of the Project to be added/updated.
Prerequisites
	#Projects temporary table
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Core_AddCustomMeasureProject](
												  @pTriggerTypes AS BIGINT,
												  @pTriggerType AS BIGINT,
												  @pCode AS NVARCHAR(20))
AS
BEGIN
	IF ((@pTriggerTypes & @pTriggerType) > 0)
	BEGIN
		IF (EXISTS (SELECT PR_Code FROM #Projects WHERE PR_Code = @pCode))
		BEGIN
			UPDATE #Projects
				SET PR_TriggerTypes = PR_TriggerTypes | @pTriggerType
				WHERE PR_Code = @pCode;
		END
		ELSE
		BEGIN
			INSERT INTO #Projects (PR_Code, PR_Level, PR_TriggerTypes)
				SELECT PR_Code, PLV_Level, @pTriggerType
				FROM Projects
				WHERE PR_Code = @pCode;
		END
	END
END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_AddCustomMeasureProject]
	TO [V6N14816rwZf]
GO
