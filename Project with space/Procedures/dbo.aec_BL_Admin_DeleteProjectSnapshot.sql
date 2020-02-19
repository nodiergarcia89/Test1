SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO

/******************************************************************************************************
	aec_BL_Admin_DeleteProjectSnapshot

Purpose
    Delete the specified Project Snapshot
    
Behaviour
	
Parameters
	@pPSSKey		- The Key of the Snapshot

Prerequisites
	
Return
    Nothing

*******************************************************************************************************
                                             Version History
*******************************************************************************************************

NF1 04/08/2016
	New, Created

NF2 15/08/2016
	Mod, Support multiple Custom Field Tables
	Mod, Include Custom Field Free Text

*******************************************************************************************************/
CREATE PROCEDURE [dbo].[aec_BL_Admin_DeleteProjectSnapshot](
	@pPSSKey AS INTEGER
)
AS
BEGIN
	DECLARE @intNumTables AS INTEGER;
	DECLARE @intSTxtTables AS INTEGER;
	DECLARE @intTxtTables AS INTEGER;
	DECLARE @intTable AS INTEGER;
	DECLARE @strSQL AS NVARCHAR(MAX);
	DECLARE @strParamDefinition AS NVARCHAR(500);

	-- Get numbers of each type of Custom Field Table
	SELECT
		@intNumTables = CustomTables.CT_Num,
		@intSTxtTables = CustomTables.CT_STxt,
		@intTxtTables = CustomTables.CT_Txt
	FROM CustomTables
	WHERE CustomTables.CT_Table = 1001;

	-------------------------
	-- Custom Field Free Text
	-------------------------
	DELETE FROM CustomFieldFreeTextAudit WHERE CFFAU_AuditId = @pPSSKey AND CFFAU_AuditEntityType = 1074;
	
	-------------------------------
	-- Project Custom Field Archive
	-------------------------------
	
	-- Num
	SET @intTable = 1;
	WHILE (@intTable <= @intNumTables)
	BEGIN
		SET @strSQL = 'DELETE FROM ProjectCustomNum' + CAST(@intTable AS NVARCHAR) + 'Archive WHERE PSS_Key = @pPSSKey;';

		-- Execute the SQL
		SET @strParamDefinition = '@pPSSKey INTEGER';

		EXECUTE sp_executesql
						@strSQL,
						@strParamDefinition,
						@pPSSKey = @pPSSKey;

		SET @intTable = @intTable + 1;
	END

	-- STxt
	SET @intTable = 1;
	WHILE (@intTable <= @intSTxtTables)
	BEGIN
		SET @strSQL = 'DELETE FROM ProjectCustomSTxt' + CAST(@intTable AS NVARCHAR) + 'Archive WHERE PSS_Key = @pPSSKey;';

		-- Execute the SQL
		SET @strParamDefinition = '@pPSSKey INTEGER';

		EXECUTE sp_executesql
						@strSQL,
						@strParamDefinition,
						@pPSSKey = @pPSSKey;

		SET @intTable = @intTable + 1;
	END

	-- Txt
	SET @intTable = 1;
	WHILE (@intTable <= @intTxtTables)
	BEGIN
		SET @strSQL = 'DELETE FROM ProjectCustomTxt' + CAST(@intTable AS NVARCHAR) + 'Archive WHERE PSS_Key = @pPSSKey;';

		-- Execute the SQL
		SET @strParamDefinition = '@pPSSKey INTEGER';

		EXECUTE sp_executesql
						@strSQL,
						@strParamDefinition,
						@pPSSKey = @pPSSKey;

		SET @intTable = @intTable + 1;
	END

	------------------------
	-- Snapshot Deliverables
	-------------------------
	DELETE FROM ProjectSnapshotDeliverables WHERE PSS_Key = @pPSSKey;

	---------------------
	-- Snapshot Forecasts
	---------------------
	DELETE FROM ProjectSnapshotForecasts WHERE PSS_Key = @pPSSKey;

	--------------------
	-- Snapshot Projects
	--------------------
	DELETE FROM ProjectSnapshotProjects WHERE PSS_Key = @pPSSKey;
	
	----------------
	-- Header record
	----------------
	DELETE FROM ProjectSnapshots WHERE PSS_Key = @pPSSKey;

END 

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Admin_DeleteProjectSnapshot]
	TO [V6N14816rwZf]
GO
