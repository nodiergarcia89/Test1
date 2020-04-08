SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_BL_Core_AddCustomMeasureProfile
Purpose
    Ensures that the specified Profile exists in the temporary Profiles table.
Behaviour
	If the Profile already exists then its Trigger Types are updated.
	Otherwise it is added to the table.
Parameters
	@pTriggerTypes	- A bitmap of Trigger Types identifying the Custom Fields to be updated.
					  A combination of AtlanticGlobal.AGS.BL.Core.CustomField.TriggerTypeValues enumerated values.
	@pTriggerType	- A Trigger Type to be set against the specified Profile.
					  An AtlanticGlobal.AGS.BL.Core.CustomField.TriggerTypeValues enumerated value.
	@pKey			- The key of the Profile to be added/updated.
Prerequisites
	#Profiles temporary table
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Core_AddCustomMeasureProfile](@pTriggerTypes AS BIGINT,
												     @pTriggerType AS BIGINT,
												     @pKey AS INTEGER)
AS
BEGIN
	IF ((@pTriggerTypes & @pTriggerType) > 0)
	BEGIN
		IF (EXISTS (SELECT PRF_Key FROM #Profiles WHERE PRF_Key = @pKey))
		BEGIN
			UPDATE #Profiles
				SET PRF_TriggerTypes = PRF_TriggerTypes | @pTriggerType
				WHERE PRF_Key = @pKey;
		END
		ELSE
		BEGIN
			INSERT INTO #Profiles (PRF_Key, PRF_Level, PRF_TriggerTypes)
				SELECT Profile.PRF_Key, Projects.PLV_Level, @pTriggerType
				FROM Profile
				INNER JOIN Projects ON Projects.PR_Code = Profile.PR_Code
				WHERE Profile.PRF_Key = @pKey;
		END
	END
END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_AddCustomMeasureProfile]
	TO [V6N14816rwZf]
GO
