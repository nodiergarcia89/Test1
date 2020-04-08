SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************************************
	aec_BL_Core_ArchiveCustomMeasures
Purpose
    Archive the Measures for an Entity.
Behaviour
	Archives the Measures for the specified Entity.
	Updates for an individual Entity are performed within a Transaction to ensure data integrity.
	Note that we do not Archive Measures against Template entities.
Parameters
	@pEntity	- The Entity whose Measures are to be Archived.
				  Identified by an AtlanticGlobal.AGS.BL.Common.GlobalConstants.EntityTypes enumerated value.
Prerequisites
	aec_BL_Core_CreateCustomMeasureArchiveRecordByCode
	aec_BL_Core_CreateCustomMeasureArchiveRecordByKey
Return
    Nothing
*******************************************************************************************************/
CREATE PROCEDURE [aec_BL_Core_ArchiveCustomMeasures](@pEntity AS INTEGER = 0)
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

	----------------------
	-- Measure Field Types
	----------------------
	DECLARE @INT_FieldType_Measure AS INTEGER;
	SET @INT_FieldType_Measure = 5;

	-- CustomField.ResourceOptions:
	--	1 = Employees
	--	2 = Contractors
	DECLARE @INT_Options_Employees AS INTEGER;
	SET @INT_Options_Employees = 1;

	DECLARE @INT_Options_Contractors AS INTEGER;
	SET @INT_Options_Contractors = 2;

	DECLARE @intNumTables AS INTEGER;
	DECLARE @intSTxtTables AS INTEGER;
	DECLARE @intTxtTables AS INTEGER;
	DECLARE @intTable AS INTEGER;
	DECLARE @strEntityTableNamePrefix AS NVARCHAR(20);
	DECLARE @strRecordKeyField AS NVARCHAR(20);

	DECLARE @intOptions AS INTEGER;
	DECLARE @strCode AS NVARCHAR(20);
	DECLARE @intKey AS INTEGER;
	DECLARE @intLevel AS INTEGER;
	DECLARE @intContractor AS INTEGER;

	DECLARE @intHasApplicableFields AS INTEGER;
	DECLARE @strCTTableName AS NVARCHAR(100);
	DECLARE @strCTArchiveTableName AS NVARCHAR(100);
	DECLARE @strArchiveFields AS NVARCHAR(MAX);

	DECLARE @strTableName AS NVARCHAR(100);
	DECLARE @strFieldName AS NVARCHAR(20);
	DECLARE @dblTimestamp AS FLOAT;

	SET NOCOUNT ON

	-- Create temporary Custom Fields table
	CREATE TABLE #CustomFields
	(
		CF_Key				INTEGER,
		CF_DataType			INTEGER,
		CF_Options			INTEGER,
		CF_TableName		NVARCHAR(100),	-- e.g. ProjectCustomNum1
		CF_FieldName		NVARCHAR(20),	-- e.g. CU_Value4
	);

	-- Populate it
	INSERT INTO #CustomFields
	SELECT
		CustomFields.CF_Key, 
		CustomFields.CF_DataType, 
		CustomFields.CF_Options, 
		CustomFields.CF_CustomTableName + CAST(CustomFields.CF_CustomTableIndex AS NVARCHAR),
		'CU_Value' + CAST(CustomFields.CF_CustomFieldIndex AS NVARCHAR)
		FROM CustomFields
		WHERE CustomFields.CF_Table = @pEntity
		AND CustomFields.CF_ReadOnly = @INT_FieldType_Measure
		AND ISNULL(CustomFields.CF_EnableArchiving, 0) = -1;

	IF (EXISTS (SELECT CF_Key FROM #CustomFields))
	BEGIN
		-- We have some Measure Custom Fields for this Entity

		-- Get the current Date / Time
		SET @dblTimestamp = CONVERT(FLOAT, GETDATE()) + 2;

		-- Initialise entity-specific values
		IF (@pEntity = @INT_EntityType_Project)
		BEGIN
			-- Project
			SET @strEntityTableNamePrefix = 'Project';
			SET @strRecordKeyField = 'PR_Code';
		END

		IF (@pEntity = @INT_EntityType_Resource)
		BEGIN
			-- Resource
			SET @strEntityTableNamePrefix = 'Res';
			SET @strRecordKeyField = 'RE_Code';
		END

		IF (@pEntity = @INT_EntityType_Profile)
		BEGIN
			-- Project
			SET @strEntityTableNamePrefix = 'Profile';
			SET @strRecordKeyField = 'PRF_Key';
		END

		-- Create temporary Custom Tables table
		CREATE TABLE #CustomTables
		(
			CT_TableName		NVARCHAR(100),	-- e.g. ProjectCustomNum1
			CT_ArchiveTableName	NVARCHAR(100)	-- e.g. ProjectCustomNum1Archive
		);

		-- Populate it
		SELECT
			@intNumTables = CustomTables.CT_Num,
			@intSTxtTables = CustomTables.CT_STxt,
			@intTxtTables = CustomTables.CT_Txt
		FROM CustomTables
		WHERE CustomTables.CT_Table = @pEntity;

		SET @intTable = 1;
		WHILE (@intTable <= @intNumTables)
		BEGIN
			INSERT INTO #CustomTables (CT_TableName, CT_ArchiveTableName) VALUES (
				@strEntityTableNamePrefix + 'CustomNum' + CAST(@intTable AS NVARCHAR),
				@strEntityTableNamePrefix + 'CustomNum' + CAST(@intTable AS NVARCHAR) + 'Archive');
			SET @intTable = @intTable + 1;
		END

		SET @intTable = 1;
		WHILE (@intTable <= @intSTxtTables)
		BEGIN
			INSERT INTO #CustomTables (CT_TableName, CT_ArchiveTableName) VALUES (
				@strEntityTableNamePrefix + 'CustomSTxt' + CAST(@intTable AS NVARCHAR),
				@strEntityTableNamePrefix + 'CustomSTxt' + CAST(@intTable AS NVARCHAR) + 'Archive');
			SET @intTable = @intTable + 1;
		END

		SET @intTable = 1;
		WHILE (@intTable <= @intTxtTables)
		BEGIN
			INSERT INTO #CustomTables (CT_TableName, CT_ArchiveTableName) VALUES (
				@strEntityTableNamePrefix + 'CustomTxt' + CAST(@intTable AS NVARCHAR),
				@strEntityTableNamePrefix + 'CustomTxt' + CAST(@intTable AS NVARCHAR) + 'Archive');
			SET @intTable = @intTable + 1;
		END

		IF (@pEntity = @INT_EntityType_Project)
		BEGIN
			----------
			-- Project
			----------
			DECLARE curProjects CURSOR LOCAL FAST_FORWARD FOR
				SELECT PR_Code, PLV_Level
				FROM Projects
				WHERE PR_IsTemplate <> -1;

			OPEN curProjects;

			FETCH NEXT FROM curProjects INTO @strCode, @intLevel;

			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				-- See if any of the Measure Custom Fields is applicable to this Project
				SET @intHasApplicableFields = 0;

				DECLARE curCustomFields CURSOR LOCAL FAST_FORWARD FOR
					SELECT CF_Options
					FROM #CustomFields;

				OPEN curCustomFields;

				FETCH NEXT FROM curCustomFields INTO @intOptions;

				WHILE (@@FETCH_STATUS = 0 AND @intHasApplicableFields = 0)
				BEGIN
					IF ((@intOptions & POWER(2, @intLevel - 1)) = POWER(2, @intLevel - 1))
					BEGIN
						SET @intHasApplicableFields = -1;
					END

					FETCH NEXT FROM curCustomFields INTO @intOptions;
				END

				CLOSE curCustomFields;
				DEALLOCATE curCustomFields;

				IF (@intHasApplicableFields = -1)
				BEGIN
					-- Begin transaction for this Project
					BEGIN TRANSACTION

					----------------------------
					-- Archive existing Measures
					----------------------------
					DECLARE curCustomTables CURSOR LOCAL FAST_FORWARD FOR
						SELECT CT_TableName, CT_ArchiveTableName
						FROM #CustomTables;

					OPEN curCustomTables;

					FETCH NEXT FROM curCustomTables INTO @strCTTableName, @strCTArchiveTableName;

					WHILE (@@FETCH_STATUS = 0)
					BEGIN
						-- Initialise list of fields that are in the current Custom Field Table
						SET @strArchiveFields = '';

						DECLARE curCustomFields CURSOR LOCAL FAST_FORWARD FOR
							SELECT CF_TableName, CF_FieldName
							FROM #CustomFields;

						OPEN curCustomFields;

						FETCH NEXT FROM curCustomFields INTO @strTableName, @strFieldName;

						WHILE (@@FETCH_STATUS = 0)
						BEGIN
							IF (@strTableName = @strCTTableName)
							BEGIN
								-- This Custom Field is in the current Custom Field Table.
								-- Note that we always include it as it may no longer
								-- be applicable to this Project but may contain a value.
								SET @strArchiveFields = @strArchiveFields + @strFieldName + ',';
							END

							FETCH NEXT FROM curCustomFields INTO @strTableName, @strFieldName;
						END

						CLOSE curCustomFields;
						DEALLOCATE curCustomFields;

						IF (LEN(@strArchiveFields) > 0)
						BEGIN
							-- Trim trailing comma
							SET @strArchiveFields = SUBSTRING(@strArchiveFields, 1, LEN(@strArchiveFields) - 1);
						END

						EXECUTE aec_BL_Core_CreateCustomMeasureArchiveRecordByCode
											@strCTArchiveTableName, 
											@strArchiveFields, 
											@strCTTableName, 
											@dblTimestamp,
											@strRecordKeyField, 
											@strCode;

						FETCH NEXT FROM curCustomTables INTO @strCTTableName, @strCTArchiveTableName;
					END

					CLOSE curCustomTables;
					DEALLOCATE curCustomTables;

					-- Commit the Transaction
					COMMIT;
				END

				FETCH NEXT FROM curProjects INTO @strCode, @intLevel;

			END	-- curProjects

			CLOSE curProjects;
			DEALLOCATE curProjects;
		END

		IF (@pEntity = @INT_EntityType_Resource)
		BEGIN
			-----------
			-- Resource
			-----------
			DECLARE curResources CURSOR LOCAL FAST_FORWARD FOR
				SELECT RE_Code, RE_Contractor
				FROM Res
				WHERE RE_Virtual <> -1
				AND RE_IsTemplate <> -1;

			OPEN curResources;

			FETCH NEXT FROM curResources INTO @strCode, @intContractor;

			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				-- See if any of the Measure Custom Fields is applicable to this Resource
				SET @intHasApplicableFields = 0;

				DECLARE curCustomFields CURSOR LOCAL FAST_FORWARD FOR
					SELECT CF_Options
					FROM #CustomFields;

				OPEN curCustomFields;

				FETCH NEXT FROM curCustomFields INTO @intOptions;

				WHILE (@@FETCH_STATUS = 0 AND @intHasApplicableFields = 0)
				BEGIN
					IF (@intContractor = -1)
					BEGIN
						IF ((@intOptions & @INT_Options_Contractors) = @INT_Options_Contractors)
						BEGIN
							SET @intHasApplicableFields = -1;
						END
					END
					ELSE
					BEGIN
						IF ((@intOptions & @INT_Options_Employees) = @INT_Options_Employees)
						BEGIN
							SET @intHasApplicableFields = -1;
						END
					END

					FETCH NEXT FROM curCustomFields INTO @intContractor;
				END

				CLOSE curCustomFields;
				DEALLOCATE curCustomFields;

				IF (@intHasApplicableFields = -1)
				BEGIN
					-- Begin transaction for this Resource
					BEGIN TRANSACTION

					----------------------------
					-- Archive existing Measures
					----------------------------
					DECLARE curCustomTables CURSOR LOCAL FAST_FORWARD FOR
						SELECT CT_TableName, CT_ArchiveTableName
						FROM #CustomTables;

					OPEN curCustomTables;

					FETCH NEXT FROM curCustomTables INTO @strCTTableName, @strCTArchiveTableName;

					WHILE (@@FETCH_STATUS = 0)
					BEGIN
						-- Initialise list of fields that are in the current Custom Field Table
						SET @strArchiveFields = '';

						DECLARE curCustomFields CURSOR LOCAL FAST_FORWARD FOR
							SELECT CF_TableName, CF_FieldName
							FROM #CustomFields;

						OPEN curCustomFields;

						FETCH NEXT FROM curCustomFields INTO @strTableName, @strFieldName;

						WHILE (@@FETCH_STATUS = 0)
						BEGIN
							IF (@strTableName = @strCTTableName)
							BEGIN
								-- This Custom Field is in the current Custom Field Table.
								-- Note that we always include it as it may no longer
								-- be applicable to this entity but may contain a value.
								SET @strArchiveFields = @strArchiveFields + @strFieldName + ',';
							END

							FETCH NEXT FROM curCustomFields INTO @strTableName, @strFieldName;
						END

						CLOSE curCustomFields;
						DEALLOCATE curCustomFields;

						IF (LEN(@strArchiveFields) > 0)
						BEGIN
							-- Trim trailing comma
							SET @strArchiveFields = SUBSTRING(@strArchiveFields, 1, LEN(@strArchiveFields) - 1);
						END

						EXECUTE aec_BL_Core_CreateCustomMeasureArchiveRecordByCode
											@strCTArchiveTableName, 
											@strArchiveFields, 
											@strCTTableName, 
											@dblTimestamp,
											@strRecordKeyField, 
											@strCode;

						FETCH NEXT FROM curCustomTables INTO @strCTTableName, @strCTArchiveTableName;
					END

					CLOSE curCustomTables;
					DEALLOCATE curCustomTables;

					-- Commit the Transaction
					COMMIT;
				END

				FETCH NEXT FROM curResources INTO @strCode, @intContractor;

			END	-- curResources

			CLOSE curResources;
			DEALLOCATE curResources;
		END

		IF (@pEntity = @INT_EntityType_Profile)
		BEGIN
			----------
			-- Profile
			----------
			DECLARE curProfiles CURSOR LOCAL FAST_FORWARD FOR
				SELECT Profile.PRF_Key, Projects.PLV_Level
				FROM Profile
				INNER JOIN Projects ON Projects.PR_Code = Profile.PR_Code
				WHERE Projects.PR_IsTemplate <> -1;

			OPEN curProfiles;

			FETCH NEXT FROM curProfiles INTO @intKey, @intLevel;

			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				-- See if any of the Measure Custom Fields is applicable to this Project
				SET @intHasApplicableFields = 0;

				DECLARE curCustomFields CURSOR LOCAL FAST_FORWARD FOR
					SELECT CF_Options
					FROM #CustomFields;

				OPEN curCustomFields;

				FETCH NEXT FROM curCustomFields INTO @intOptions;

				WHILE (@@FETCH_STATUS = 0 AND @intHasApplicableFields = 0)
				BEGIN
					IF ((@intOptions & POWER(2, @intLevel - 1)) = POWER(2, @intLevel - 1))
					BEGIN
						SET @intHasApplicableFields = -1;
					END

					FETCH NEXT FROM curCustomFields INTO @intOptions;
				END

				CLOSE curCustomFields;
				DEALLOCATE curCustomFields;

				IF (@intHasApplicableFields = -1)
				BEGIN
					-- Begin transaction for this Profile
					BEGIN TRANSACTION

					----------------------------
					-- Archive existing Measures
					----------------------------
					DECLARE curCustomTables CURSOR LOCAL FAST_FORWARD FOR
						SELECT CT_TableName, CT_ArchiveTableName
						FROM #CustomTables;

					OPEN curCustomTables;

					FETCH NEXT FROM curCustomTables INTO @strCTTableName, @strCTArchiveTableName;

					WHILE (@@FETCH_STATUS = 0)
					BEGIN
						-- Initialise list of fields that are in the current Custom Field Table
						SET @strArchiveFields = '';

						DECLARE curCustomFields CURSOR LOCAL FAST_FORWARD FOR
							SELECT CF_TableName, CF_FieldName
							FROM #CustomFields;

						OPEN curCustomFields;

						FETCH NEXT FROM curCustomFields INTO @strTableName, @strFieldName;

						WHILE (@@FETCH_STATUS = 0)
						BEGIN
							IF (@strTableName = @strCTTableName)
							BEGIN
								-- This Custom Field is in the current Custom Field Table.
								-- Note that we always include it as it may no longer
								-- be applicable to this Project but may contain a value.
								SET @strArchiveFields = @strArchiveFields + @strFieldName + ',';
							END

							FETCH NEXT FROM curCustomFields INTO @strTableName, @strFieldName;
						END

						CLOSE curCustomFields;
						DEALLOCATE curCustomFields;

						IF (LEN(@strArchiveFields) > 0)
						BEGIN
							-- Trim trailing comma
							SET @strArchiveFields = SUBSTRING(@strArchiveFields, 1, LEN(@strArchiveFields) - 1);
						END

						EXECUTE aec_BL_Core_CreateCustomMeasureArchiveRecordByKey
											@strCTArchiveTableName, 
											@strArchiveFields, 
											@strCTTableName, 
											@dblTimestamp,
											@strRecordKeyField, 
											@intKey;

						FETCH NEXT FROM curCustomTables INTO @strCTTableName, @strCTArchiveTableName;
					END

					CLOSE curCustomTables;
					DEALLOCATE curCustomTables;

					-- Commit the Transaction
					COMMIT;
				END

				FETCH NEXT FROM curProfiles INTO @intKey, @intLevel;

			END	-- curProfiles

			CLOSE curProfiles;
			DEALLOCATE curProfiles;
		END

	END

	-- Drop temporary tables
	DROP TABLE #CustomFields;

	IF OBJECT_ID('tempdb..#CustomTables') IS NOT NULL
	BEGIN
	   DROP TABLE #CustomTables
	END
END	

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Core_ArchiveCustomMeasures]
	TO [V6N14816rwZf]
GO
