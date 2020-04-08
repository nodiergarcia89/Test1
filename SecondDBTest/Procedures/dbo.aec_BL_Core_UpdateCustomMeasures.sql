SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
/**************************************************************************************************************************************
											  KeyedIn Projects Database Upgrade Script 
														v6.3.0.43349 to v6.3.0.43377
***************************************************************************************************************************************

JN1 -  20/09/2018
	Mod, aec_BL_Core_UpdateCustomMeasures now only updates measure for active projects
**************************************************************************************************************************************/	

--JN1s

/******************************************************************************************************
	aec_BL_Core_UpdateCustomMeasures
Purpose
    Updates the Measures for an Entity.
Behaviour
	Updates the Measures for the specified Entity.
Parameters
	@pEntity		- The Entity whose Measures are to be updated.
					  An AtlanticGlobal.AGS.BL.Common.GlobalConstants.EntityTypes enumerated value.
	@pTriggerTypes	- A bitmap of Trigger Types identifying the Custom Fields to be updated.
					  A combination of AtlanticGlobal.AGS.BL.Core.CustomField.TriggerTypeValues enumerated values.
	@pCode			- The Code of the Entity to be updated.
	@pKey			- The Key of the Entity to be updated.
Prerequisites
	aec_BL_Core_AddCustomMeasureProfile
	aec_BL_Core_AddCustomMeasureProject
	aec_BL_Core_AddCustomMeasureProjectHierarchy
	aec_BL_Core_UpdateCustomMeasuresForProfile
	aec_BL_Core_UpdateCustomMeasuresForProject
	aec_BL_Core_UpdateCustomMeasuresForResource
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [dbo].[aec_BL_Core_UpdateCustomMeasures](@pEntity AS INTEGER = 0, 
												 @pTriggerTypes AS BIGINT = 0,
												 @pCode AS NVARCHAR(20) = NULL,
												 @pKey AS INTEGER = NULL)
AS
BEGIN
	---------------
	-- Entity Types
	---------------
	DECLARE @INT_EntityType_Project AS INTEGER;
	SET @INT_EntityType_Project = 1001;

	DECLARE @INT_EntityType_Resource AS INTEGER;
	SET @INT_EntityType_Resource = 1002;

	DECLARE @INT_EntityType_Profile AS INTEGER;
	SET @INT_EntityType_Profile = 1019;

	----------------
	-- Trigger Types
	----------------

	-- We must force POWER() to return a BIGINT
	DECLARE @LNG2 AS BIGINT;
	SET @LNG2 = 2;
	
	DECLARE @LNG_TriggerType_NotSpecified AS BIGINT;
	SET @LNG_TriggerType_NotSpecified = 0;

	DECLARE @LNG_TriggerType_ScheduledJob AS BIGINT;
	SET @LNG_TriggerType_ScheduledJob = POWER(@LNG2, 0);

	-- Project-specific
	DECLARE @LNG_TriggerType_ApproveForecastAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_ApproveForecastAtCurrentLevel = POWER(@LNG2, 1);

	DECLARE @LNG_TriggerType_ApproveForecastAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_ApproveForecastAtLowestLevel = POWER(@LNG2, 2);

	DECLARE @LNG_TriggerType_DemoteForecastAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_DemoteForecastAtCurrentLevel = POWER(@LNG2, 3);

	DECLARE @LNG_TriggerType_DemoteForecastAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_DemoteForecastAtLowestLevel = POWER(@LNG2, 4);

	DECLARE @LNG_TriggerType_BaselineForecastAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_BaselineForecastAtCurrentLevel = POWER(@LNG2, 5);

	DECLARE @LNG_TriggerType_SaveRiskAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_SaveRiskAtCurrentLevel = POWER(@LNG2, 6);

	DECLARE @LNG_TriggerType_SaveRiskAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_SaveRiskAtLowestLevel = POWER(@LNG2, 7);

	DECLARE @LNG_TriggerType_DeleteRiskAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_DeleteRiskAtCurrentLevel = POWER(@LNG2, 8);

	DECLARE @LNG_TriggerType_DeleteRiskAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_DeleteRiskAtLowestLevel = POWER(@LNG2, 9);

	DECLARE @LNG_TriggerType_SaveDeliverableAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_SaveDeliverableAtCurrentLevel = POWER(@LNG2, 10);

	DECLARE @LNG_TriggerType_SaveDeliverableAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_SaveDeliverableAtLowestLevel = POWER(@LNG2, 11);

	DECLARE @LNG_TriggerType_SaveActionAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_SaveActionAtCurrentLevel = POWER(@LNG2, 12);

	DECLARE @LNG_TriggerType_DeleteActionAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_DeleteActionAtCurrentLevel = POWER(@LNG2, 13);

	DECLARE @LNG_TriggerType_SaveActionAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_SaveActionAtLowestLevel = POWER(@LNG2, 14);

	DECLARE @LNG_TriggerType_DeleteActionAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_DeleteActionAtLowestLevel = POWER(@LNG2, 15);

	DECLARE @LNG_TriggerType_SaveProjectAtCurrentLevel AS BIGINT;
	SET @LNG_TriggerType_SaveProjectAtCurrentLevel = POWER(@LNG2, 16);

	DECLARE @LNG_TriggerType_SaveProjectAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_SaveProjectAtLowestLevel = POWER(@LNG2, 17);

	DECLARE @LNG_TriggerType_DeleteProjectAtLowestLevel AS BIGINT;
	SET @LNG_TriggerType_DeleteProjectAtLowestLevel = POWER(@LNG2, 18);

	DECLARE @LNG_TriggerType_ProjectHierarchyChange AS BIGINT;
	SET @LNG_TriggerType_ProjectHierarchyChange = POWER(@LNG2, 19);

	DECLARE @LNG_TriggerType_UpdateStrategicPlanningActuals AS BIGINT;
	SET @LNG_TriggerType_UpdateStrategicPlanningActuals = POWER(@LNG2, 20);

	DECLARE @LNG_TriggerType_SaveBillingContract AS BIGINT;
	SET @LNG_TriggerType_SaveBillingContract = POWER(@LNG2, 21);

	DECLARE @LNG_TriggerType_DeleteBillingContract AS BIGINT;
	SET @LNG_TriggerType_DeleteBillingContract = POWER(@LNG2, 22);

	DECLARE @LNG_TriggerType_SaveBillingInvoice AS BIGINT;
	SET @LNG_TriggerType_SaveBillingInvoice = POWER(@LNG2, 23);

	DECLARE @LNG_TriggerType_DeleteBillingInvoice AS BIGINT;
	SET @LNG_TriggerType_DeleteBillingInvoice = POWER(@LNG2, 24);

	-- Forecast-specific
	DECLARE @LNG_TriggerType_SaveForecast AS BIGINT;
	SET @LNG_TriggerType_SaveForecast = POWER(@LNG2, 25);

	DECLARE @LNG_TriggerType_ApproveForecast AS BIGINT;
	SET @LNG_TriggerType_ApproveForecast = POWER(@LNG2, 26);

	DECLARE @LNG_TriggerType_BaselineForecast AS BIGINT;
	SET @LNG_TriggerType_BaselineForecast = POWER(@LNG2, 27);

	DECLARE @LNG_TriggerType_DemoteForecast AS BIGINT;
	SET @LNG_TriggerType_DemoteForecast = POWER(@LNG2, 28);

	-- Project-specific
	DECLARE @LNG_TriggerType_UpdateTaskPlanningActuals AS BIGINT;
	SET @LNG_TriggerType_UpdateTaskPlanningActuals = POWER(@LNG2, 29);

	DECLARE @LNG_TriggerType_SaveProjectPlan AS BIGINT;
	SET @LNG_TriggerType_SaveProjectPlan = POWER(@LNG2, 30);

	DECLARE @LNG_TriggerType_ChangeProjectLifecycle AS BIGINT;
	SET @LNG_TriggerType_ChangeProjectLifecycle = POWER(@LNG2, 31);

	--------------
	-- Field Types
	--------------
	DECLARE @INT_FieldType_SQLMeasure AS INTEGER;
	SET @INT_FieldType_SQLMeasure = 5;

	-------------
	-- Local data
	-------------
	DECLARE @strCode AS NVARCHAR(20);
	DECLARE @intKey AS INTEGER;
	DECLARE @intLevel AS INTEGER;
	DECLARE @lngTriggerTypes AS BIGINT;
	DECLARE @intContractor AS INTEGER;
	DECLARE @lngTriggerType AS BIGINT;

	SET NOCOUNT ON

	-- Create temporary Custom Fields table
	CREATE TABLE #CustomFields
	(
		CF_Key				INTEGER,
		CF_DataType			INTEGER,
		CF_Options			INTEGER,
		CF_MeasureSQL		NVARCHAR(MAX),
		CF_TableName		NVARCHAR(100),	-- e.g. ProjectCustomNum1
		CF_FieldName		NVARCHAR(20),	-- e.g. CU_Value4
		CF_TriggerTypes		BIGINT,
	);

	-- Populate it
	INSERT INTO #CustomFields
	SELECT
		CustomFields.CF_Key, 
		CustomFields.CF_DataType, 
		CustomFields.CF_Options, 
		CustomFieldSQL.CF_SQL,
		CustomFields.CF_CustomTableName + CAST(CustomFields.CF_CustomTableIndex AS NVARCHAR),
		'CU_Value' + CAST(CustomFields.CF_CustomFieldIndex AS NVARCHAR),
		CustomFields.CF_TriggerTypes
		FROM CustomFields
		INNER JOIN CustomFieldSQL ON CustomFieldSQL.CF_Key = CustomFields.CF_Key
		WHERE CustomFields.CF_Table = @pEntity
		AND CustomFields.CF_ReadOnly = @INT_FieldType_SQLMeasure
		AND (CustomFields.CF_TriggerTypes & @pTriggerTypes) > 0;

  

	IF (EXISTS (SELECT CF_Key FROM #CustomFields))
	BEGIN
		-- We have some Measure Custom Fields for this Entity

		IF (@pEntity = @INT_EntityType_Project)
		BEGIN
			----------
			-- Project
			----------
			IF (((@pTriggerTypes & @LNG_TriggerType_ScheduledJob) > 0) OR
				((@pTriggerTypes & @LNG_TriggerType_UpdateStrategicPlanningActuals) > 0) OR
				((@pTriggerTypes & @LNG_TriggerType_UpdateTaskPlanningActuals) > 0))
			BEGIN
				IF ((@pTriggerTypes & @LNG_TriggerType_ScheduledJob) > 0)
				BEGIN
					----------------
					-- Scheduled Job
					----------------

					-- Process all Projects
					DECLARE curProjects CURSOR LOCAL FAST_FORWARD FOR
						SELECT PR_Code, PLV_Level
						FROM Projects
						ORDER BY PLV_Level ASC, PR_Code ASC;

					OPEN curProjects;

					FETCH NEXT FROM curProjects INTO @strCode, @intLevel;

					WHILE (@@FETCH_STATUS = 0)
					BEGIN
						EXECUTE aec_BL_Core_UpdateCustomMeasuresForProject @strCode, @intLevel, @LNG_TriggerType_ScheduledJob;

						FETCH NEXT FROM curProjects INTO @strCode, @intLevel;
					END

					CLOSE curProjects;
					DEALLOCATE curProjects;
				END
	
				ELSE
				BEGIN
					-----------------
					-- Update Actuals
					-----------------
					IF ((@pTriggerTypes & @LNG_TriggerType_UpdateStrategicPlanningActuals) > 0)
					BEGIN
						SET @lngTriggerType = @LNG_TriggerType_UpdateStrategicPlanningActuals;
					END

					IF ((@pTriggerTypes & @LNG_TriggerType_UpdateTaskPlanningActuals) > 0)
					BEGIN
						SET @lngTriggerType = @LNG_TriggerType_UpdateTaskPlanningActuals;
					END

					IF (@pCode IS NULL)
					BEGIN
						-- Process all Projects
						DECLARE curProjects CURSOR LOCAL FAST_FORWARD FOR
							SELECT PR_Code, PLV_Level
							FROM Projects
							WHERE Active = -1
						
							ORDER BY PLV_Level ASC, PR_Code ASC;

						OPEN curProjects;

						FETCH NEXT FROM curProjects INTO @strCode, @intLevel;

						WHILE (@@FETCH_STATUS = 0)
						BEGIN
							EXECUTE aec_BL_Core_UpdateCustomMeasuresForProject @strCode, @intLevel, @lngTriggerType;

							FETCH NEXT FROM curProjects INTO @strCode, @intLevel;
						END

						CLOSE curProjects;
						DEALLOCATE curProjects;

					END
					ELSE
					BEGIN
						DECLARE curProjects CURSOR LOCAL FAST_FORWARD FOR
							SELECT PR_Code, PLV_Level
							FROM
							(
							-- All Projects including and below the specified one
							SELECT Projects.PR_Code, Projects.PLV_Level
							FROM Projects
							INNER JOIN ProjectRelations ON ProjectRelations.SubPR = Projects.PR_Code
							AND ProjectRelations.MasterPR = @pCode
							UNION 
							-- The specified Project and its parents
							SELECT Projects.PR_Code, Projects.PLV_Level
							FROM Projects 
							INNER JOIN ProjectRelations ON ProjectRelations.MasterPR = Projects.PR_Code
							WHERE ProjectRelations.SubPR = @pCode
							) aecProjects
							ORDER BY PLV_Level ASC, PR_Code ASC;

						OPEN curProjects;

						FETCH NEXT FROM curProjects INTO @strCode, @intLevel;

						WHILE (@@FETCH_STATUS = 0)
						BEGIN
							EXECUTE aec_BL_Core_UpdateCustomMeasuresForProject @strCode, @intLevel, @lngTriggerType;

							FETCH NEXT FROM curProjects INTO @strCode, @intLevel;
						END

						CLOSE curProjects;
						DEALLOCATE curProjects;
					END
				END
			END
			ELSE
			BEGIN
				-- Create temporary Projects table
				CREATE TABLE #Projects
				(
					PR_Code				NVARCHAR(20),
					PR_Level			INTEGER,
					PR_TriggerTypes		BIGINT,
				);

				-- Populate it
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_ApproveForecastAtLowestLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_DemoteForecastAtLowestLevel, @pCode

				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_DeleteActionAtLowestLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_DeleteBillingContract, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_DeleteBillingInvoice, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_DeleteProjectAtLowestLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_DeleteRiskAtLowestLevel, @pCode

				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_SaveActionAtLowestLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_SaveBillingContract, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_SaveBillingInvoice, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_SaveDeliverableAtLowestLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_SaveProjectAtLowestLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_SaveProjectPlan, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_SaveRiskAtLowestLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_ChangeProjectLifecycle, @pCode

				EXEC aec_BL_Core_AddCustomMeasureProjectHierarchy @pTriggerTypes, @LNG_TriggerType_ProjectHierarchyChange, @pCode

				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_ApproveForecastAtCurrentLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_BaselineForecastAtCurrentLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_DemoteForecastAtCurrentLevel, @pCode

				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_DeleteActionAtCurrentLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_DeleteRiskAtCurrentLevel, @pCode

				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_SaveActionAtCurrentLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_SaveDeliverableAtCurrentLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_SaveProjectAtCurrentLevel, @pCode
				EXEC aec_BL_Core_AddCustomMeasureProject @pTriggerTypes, @LNG_TriggerType_SaveRiskAtCurrentLevel, @pCode

				-- Process it
				DECLARE curProjects CURSOR LOCAL FAST_FORWARD FOR
					SELECT PR_Code, PR_Level, PR_TriggerTypes
					FROM #Projects
					ORDER BY PR_Level ASC, PR_Code ASC;
				OPEN curProjects;

				FETCH NEXT FROM curProjects INTO @strCode, @intLevel, @lngTriggerTypes;

				WHILE (@@FETCH_STATUS = 0)
				BEGIN
					EXECUTE aec_BL_Core_UpdateCustomMeasuresForProject @strCode, @intLevel, @lngTriggerTypes;

					FETCH NEXT FROM curProjects INTO @strCode, @intLevel, @lngTriggerTypes;
				END

				CLOSE curProjects;
				DEALLOCATE curProjects;

				-- Drop temporary tables
				DROP TABLE #Projects;
			END
		END

		IF (@pEntity = @INT_EntityType_Resource)
		BEGIN
			-----------
			-- Resource
			-----------
			IF ((@pTriggerTypes & @LNG_TriggerType_ScheduledJob) > 0)
			BEGIN
				----------------
				-- Scheduled Job
				----------------

				-- Process all Resources
				DECLARE curResources CURSOR LOCAL FAST_FORWARD FOR
					SELECT RE_Code, RE_Contractor
					FROM Res
					WHERE RE_Virtual <> -1
					ORDER BY RE_Code ASC;

				OPEN curResources;

				FETCH NEXT FROM curResources INTO @strCode, @intContractor;

				WHILE (@@FETCH_STATUS = 0)
				BEGIN
					EXECUTE aec_BL_Core_UpdateCustomMeasuresForResource @strCode, @intContractor, @LNG_TriggerType_ScheduledJob;

					FETCH NEXT FROM curResources INTO @strCode, @intContractor;
				END

				CLOSE curResources;
				DEALLOCATE curResources;
			END
		END

		IF (@pEntity = @INT_EntityType_Profile)
		BEGIN
			----------
			-- Profile
			----------
			IF ((@pTriggerTypes & @LNG_TriggerType_ScheduledJob) > 0)
			BEGIN
				----------------
				-- Scheduled Job
				----------------

				-- Process all Profiles
				DECLARE curProfiles CURSOR LOCAL FAST_FORWARD FOR
					SELECT Profile.PRF_Key, Projects.PLV_Level
					FROM Profile
					INNER JOIN Projects ON Projects.PR_Code = Profile.PR_Code
					ORDER BY Projects.PLV_Level ASC, Profile.PRF_Key ASC;

				OPEN curProfiles;

				FETCH NEXT FROM curProfiles INTO @intKey, @intLevel;

				WHILE (@@FETCH_STATUS = 0)
				BEGIN
					EXECUTE aec_BL_Core_UpdateCustomMeasuresForProfile @intKey, @intLevel, @LNG_TriggerType_ScheduledJob;

					FETCH NEXT FROM curProfiles INTO @intKey, @intLevel;
				END

				CLOSE curProfiles;
				DEALLOCATE curProfiles;
			END
			ELSE
			BEGIN
				-- Create temporary Profiles table
				CREATE TABLE #Profiles
				(
					PRF_Key				INTEGER,
					PRF_Level			INTEGER,
					PRF_TriggerTypes	BIGINT,
				);

				-- Populate it
				EXEC aec_BL_Core_AddCustomMeasureProfile @pTriggerTypes, @LNG_TriggerType_SaveForecast, @pKey
				EXEC aec_BL_Core_AddCustomMeasureProfile @pTriggerTypes, @LNG_TriggerType_ApproveForecast, @pKey
				EXEC aec_BL_Core_AddCustomMeasureProfile @pTriggerTypes, @LNG_TriggerType_BaselineForecast, @pKey
				EXEC aec_BL_Core_AddCustomMeasureProfile @pTriggerTypes, @LNG_TriggerType_DemoteForecast, @pKey

				-- Process it
				DECLARE curProfiles CURSOR LOCAL FAST_FORWARD FOR
					SELECT PRF_Key, PRF_Level, PRF_TriggerTypes
					FROM #Profiles
					ORDER BY PRF_Level ASC, PRF_Key ASC;
				OPEN curProfiles;

				FETCH NEXT FROM curProfiles INTO @intKey, @intLevel, @lngTriggerTypes;

				WHILE (@@FETCH_STATUS = 0)
				BEGIN
					EXECUTE aec_BL_Core_UpdateCustomMeasuresForProfile @intKey, @intLevel, @lngTriggerTypes;

					FETCH NEXT FROM curProfiles INTO @intKey, @intLevel, @lngTriggerTypes;
				END

				CLOSE curProfiles;
				DEALLOCATE curProfiles;

				-- Drop temporary tables
				DROP TABLE #Profiles;
			END
		END

	END

	-- Drop temporary tables
	DROP TABLE #CustomFields;

	IF ((@pTriggerTypes & @LNG_TriggerType_ScheduledJob) > 0)
	BEGIN
		-- Record timestamp
		DECLARE @dblNow AS FLOAT;
		SET @dblNow = CONVERT(FLOAT, GETDATE()) + 2;
		
		DECLARE @strNow AS NVARCHAR(20);
		SET @strNow = LTRIM(STR(@dblNow, 30, 10))

		DECLARE @strSystemParamCode AS NVARCHAR(30);
		SET @strSystemParamCode = 'SJOB-UCM-LASTRECALC-' + CAST(@pEntity AS NVARCHAR)

		UPDATE SystemParams
			SET SP_Number = @dblNow, SP_Value = @strNow
			WHERE SP_Code = @strSystemParamCode;
	END
END

--JN1e


GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_UpdateCustomMeasures]
	TO [V6N14816rwZf]
GO
