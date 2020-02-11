SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_BL_Core_AddCustomMeasureProjectHierarchy
Purpose
    Ensures that the hierarchy for the specified Project, exists in the temporary Projects table.
Behaviour
	Retrieves the hierarchy, including and above the specified Project, and ensures that each
	exists in the temporary Projects table.
Parameters
	@pTriggerTypes	- A bitmap of Trigger Types identifying the Custom Fields to be updated.
					  A combination of AtlanticGlobal.AGS.BL.Core.CustomField.TriggerTypeValues enumerated values.
	@pTriggerType	- A Trigger Type to be set against each Project.
					  An AtlanticGlobal.AGS.BL.Core.CustomField.TriggerTypeValues enumerated value.
	@pCode			- The code of the Project whose hierarchy is to be added/updated.
Prerequisites
	aec_BL_Core_AddCustomMeasureProject
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Core_AddCustomMeasureProjectHierarchy](
												  @pTriggerTypes AS BIGINT,
												  @pTriggerType AS BIGINT,
												  @pCode AS NVARCHAR(20))
AS
BEGIN
	DECLARE @strCode AS NVARCHAR(20);

	IF ((@pTriggerTypes & @pTriggerType) > 0)
	BEGIN
		DECLARE curProjects CURSOR LOCAL FAST_FORWARD FOR
			SELECT Projects.PR_Code
			FROM ProjectRelations 
			INNER JOIN Projects ON Projects.PR_Code = ProjectRelations.MasterPR
			WHERE ProjectRelations.SubPR = @pCode
			ORDER BY Projects.PLV_Level ASC, Projects.PR_Code ASC;

		OPEN curProjects;

		FETCH NEXT FROM curProjects INTO @strCode;

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			EXECUTE aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @pTriggerType, @strCode;

			FETCH NEXT FROM curProjects INTO @strCode;
		END

		CLOSE curProjects;
		DEALLOCATE curProjects;
	END
END

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_AddCustomMeasureProjectHierarchy]
	TO [V6N14816rwZf]
GO
