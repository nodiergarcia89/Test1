SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO

/******************************************************************************************************
	aec_BL_Admin_CreateProjectSnapshot

Purpose
    Create a Snapshot of the specified Project and all its child Projects.
    
Behaviour
	
Parameters
	@pPRCode			- The Code of the Project
	@pPSSDesc			- The Description of the Snapshot
	@pPSSType			- Snapshot Type (Interim / Baseline)
	@pUSCodeLastEdit	- Code of the User creating the Snapshot
	@pPSSLastEditDate	- Date / Time that the Snapshot was created
	@pPSSKey			- The Key of the Snapshot (Output)

Prerequisites
	
Return
    Nothing

*******************************************************************************************************
                                             Version History
*******************************************************************************************************

NF1 19/07/2016
	New, Created

NF2 02/08/2016
	Mod, Project Snapshots - Include Custom Fields

NF3 12/08/2016
	Mod, Project Snapshots - Include Additional Project Fields

NF4 15/08/2016
	Mod, Support multiple Custom Field Tables
	Mod, Include Custom Field Free Text

*******************************************************************************************************/
CREATE PROCEDURE [dbo].[aec_BL_Admin_CreateProjectSnapshot](
	@pPRCode AS NVARCHAR(20),
	@pPSSDesc AS NVARCHAR(70),
	@pPSSType SMALLINT,
	@pUSCodeLastEdit AS NVARCHAR(20),
	@pPSSLastEditDate FLOAT,
	@pPSSKey AS INTEGER OUTPUT
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

	--------------------------------------------
	-- Create header record and retrieve its Key	
	--------------------------------------------
	INSERT INTO ProjectSnapshots (PR_Code, PSS_Desc, PSS_Type, US_CodeLastEdit, PSS_LastEditDate) 
	VALUES (@pPRCode, @pPSSDesc, @pPSSType, @pUSCodeLastEdit, @pPSSLastEditDate);

	SELECT @pPSSKey = SCOPE_IDENTITY();									

	-----------------------------
	-- Populate Snapshot Projects
	-----------------------------
	INSERT INTO ProjectSnapshotProjects (PSS_Key, PR_Code, PR_Desc, PR_Active, PR_Chrg, PR_Start, PR_End, 
	RE_CodeProjectManager, RE_DescProjectManager, 
	RE_CodeProjectSponsor, RE_DescProjectSponsor, 
	PLF_Code, PLF_Desc, 
	PLFS_Key, PLFS_Desc,
	PR_CodeMaster, PR_DescMaster,
	CL_Code, CL_Desc,
	DE_Code, DE_Desc,
	PT_Key, PR_VstsEpic,
	PR_WorkflowPriority,
	WF_Key, WF_Name,
	WFS_Key, WFS_Name,
	WFS_SubStatusKey, WFS_SubStatusDesc,
	RE_CodeProjectOwner, RE_DescProjectOwner,
	CC_Code, CC_Desc,
	LO_Code, LO_Desc)
	
	SELECT @pPSSKey, Projects.PR_Code, Projects.PR_Desc, Projects.Active, Projects.PR_Chrg, Projects.PR_Start, Projects.PR_End, 
	ProjectManager.RE_Code, ProjectManager.RE_Desc,
	ProjectSponsor.RE_Code, ProjectSponsor.RE_Desc,
	ProjectLifecycle.PLF_Code, ProjectLifecycle.PLF_Desc,
	ProjectLifecycleStage.PLFS_Key, ProjectLifecycleStage.PLFS_Desc,
	MasterProject.PR_Code, MasterProject.PR_Desc,
	Clients.CL_Code, Clients.CL_Desc,
	Departments.DE_Code, Departments.DE_Desc,
	Projects.PT_Key, Projects.PR_VstsEpic,
	Projects.PR_WorkflowPriority,
	Workflow.WF_Key, Workflow.WF_Name,
	WorkflowStatus.WFS_Key, WorkflowStatus.WFS_Name,
	WorkflowSubStatus.WFS_Key, WorkflowSubStatus.WFS_Name,
	Res.RE_Code, Res.RE_Desc,
	CostCentre.CC_Code, CostCentre.CC_Desc,
	Location.LO_Code, Location.LO_Desc
	
	FROM Projects
	LEFT OUTER JOIN Res ProjectManager ON ProjectManager.RE_Code = Projects.RE_CodeProjectManager
	LEFT OUTER JOIN Res ProjectSponsor ON ProjectSponsor.RE_Code = Projects.RE_CodeProjectSponsor
	LEFT OUTER JOIN ProjectLifecycle ON ProjectLifecycle.PLF_Code = Projects.PLF_Code
	LEFT OUTER JOIN ProjectLifecycleStage ON ProjectLifecycleStage.PLFS_Key = Projects.PLFS_Key
	LEFT OUTER JOIN Projects MasterProject ON MasterProject.PR_Code = Projects.PR_Master
	LEFT OUTER JOIN Clients ON Clients.CL_Code = Projects.CL_Code
	LEFT OUTER JOIN CostCentre ON CostCentre.CC_Code = Projects.CC_Code
	LEFT OUTER JOIN Departments ON Departments.DE_Code = Projects.DE_Code
	LEFT OUTER JOIN Location ON Location.LO_Code = Projects.LO_Code
	LEFT OUTER JOIN Workflow ON Workflow.WF_Key = Projects.WF_Key
	LEFT OUTER JOIN WorkflowStatus ON WorkflowStatus.WFS_Key = Projects.WFS_Key
	LEFT OUTER JOIN WorkflowStatus WorkflowSubStatus ON WorkflowSubStatus.WFS_Key = Projects.WFS_SubStatusKey
	LEFT OUTER JOIN Res ON Res.RE_Code = Projects.RE_CodeProjectOwner

	WHERE Projects.PR_Code IN (SELECT SubPR FROM ProjectRelations WHERE MasterPR = @pPRCode);

	------------------------------
	-- Populate Snapshot Forecasts
	------------------------------
	INSERT INTO ProjectSnapshotForecasts (PSS_Key, PRF_Key, PR_Code)
	
	SELECT @pPSSKey, Profile.PRF_Key, Profile.PR_Code
	FROM Profile
	
	WHERE Profile.PRF_Status = 2 
	AND Profile.PR_Code IN (SELECT SubPR FROM ProjectRelations WHERE MasterPR = @pPRCode);
	
	---------------------------------
	-- Populate Snapshot Deliverables
	---------------------------------
	INSERT INTO ProjectSnapshotDeliverables (PSS_Key, DV_Key, PR_Code)
	
	SELECT @pPSSKey, MaxAuditKeys.DV_KeyAudit, Deliverable.PR_Code
	
	FROM Deliverable
	INNER JOIN
	(
		SELECT DV_KeyPrimary, MAX(DV_KeyAudit) AS DV_KeyAudit
		FROM DeliverableAudit
		GROUP BY DV_KeyPrimary
	) MaxAuditKeys ON MaxAuditKeys.DV_KeyPrimary = Deliverable.DV_Key
	
	WHERE Deliverable.PR_Code IN (SELECT SubPR FROM ProjectRelations WHERE MasterPR = @pPRCode)

	----------------------------------------
	-- Populate Project Custom Field Archive
	----------------------------------------

	-- Num
	SET @intTable = 1;
	WHILE (@intTable <= @intNumTables)
	BEGIN
		SET @strSQL = '
		INSERT INTO ProjectCustomNum' + CAST(@intTable AS NVARCHAR) + 'Archive (PSS_Key, PR_Code, CU_Date, 
		CU_Value1,  CU_Value2,  CU_Value3,  CU_Value4,  CU_Value5,  CU_Value6,  CU_Value7,  CU_Value8,  CU_Value9,  CU_Value10,
		CU_Value11, CU_Value12,	CU_Value13,	CU_Value14,	CU_Value15,	CU_Value16,	CU_Value17,	CU_Value18,	CU_Value19,	CU_Value20,
		CU_Value21,	CU_Value22,	CU_Value23,	CU_Value24,	CU_Value25,	CU_Value26,	CU_Value27,	CU_Value28,	CU_Value29,	CU_Value30,
		CU_Value31,	CU_Value32,	CU_Value33,	CU_Value34,	CU_Value35,	CU_Value36,	CU_Value37,	CU_Value38,	CU_Value39,	CU_Value40,
		CU_Value41,	CU_Value42,	CU_Value43,	CU_Value44,	CU_Value45,	CU_Value46,	CU_Value47,	CU_Value48,	CU_Value49,	CU_Value50)

		SELECT @pPSSKey, PR_Code, @pPSSLastEditDate,
		CU_Value1,  CU_Value2,  CU_Value3,  CU_Value4,  CU_Value5,  CU_Value6,  CU_Value7,  CU_Value8,  CU_Value9,  CU_Value10,
		CU_Value11, CU_Value12,	CU_Value13,	CU_Value14,	CU_Value15,	CU_Value16,	CU_Value17,	CU_Value18,	CU_Value19,	CU_Value20,
		CU_Value21,	CU_Value22,	CU_Value23,	CU_Value24,	CU_Value25,	CU_Value26,	CU_Value27,	CU_Value28,	CU_Value29,	CU_Value30,
		CU_Value31,	CU_Value32,	CU_Value33,	CU_Value34,	CU_Value35,	CU_Value36,	CU_Value37,	CU_Value38,	CU_Value39,	CU_Value40,
		CU_Value41,	CU_Value42,	CU_Value43,	CU_Value44,	CU_Value45,	CU_Value46,	CU_Value47,	CU_Value48,	CU_Value49,	CU_Value50

		FROM ProjectCustomNum' + CAST(@intTable AS NVARCHAR) + '
		WHERE ProjectCustomNum' + CAST(@intTable AS NVARCHAR) + '.PR_Code IN (SELECT SubPR FROM ProjectRelations WHERE MasterPR = @pPRCode);';

		-- Execute the SQL
		SET @strParamDefinition = '@pPSSKey INTEGER, @pPSSLastEditDate FLOAT, @pPRCode NVARCHAR(20)';

		EXECUTE sp_executesql
						@strSQL,
						@strParamDefinition,
						@pPSSKey = @pPSSKey,
						@pPSSLastEditDate = @pPSSLastEditDate, 
						@pPRCode = @pPRCode;

		SET @intTable = @intTable + 1;
	END

	-- STxt
	SET @intTable = 1;
	WHILE (@intTable <= @intSTxtTables)
	BEGIN
		SET @strSQL = '
		INSERT INTO ProjectCustomSTxt' + CAST(@intTable AS NVARCHAR) + 'Archive (PSS_Key, PR_Code, CU_Date, 
		CU_Value1,  CU_Value2,  CU_Value3,  CU_Value4,  CU_Value5,  CU_Value6,  CU_Value7,  CU_Value8,  CU_Value9,  CU_Value10,
		CU_Value11, CU_Value12,	CU_Value13,	CU_Value14,	CU_Value15,	CU_Value16,	CU_Value17,	CU_Value18,	CU_Value19,	CU_Value20,
		CU_Value21,	CU_Value22,	CU_Value23,	CU_Value24,	CU_Value25,	CU_Value26,	CU_Value27,	CU_Value28,	CU_Value29,	CU_Value30,
		CU_Value31,	CU_Value32,	CU_Value33,	CU_Value34,	CU_Value35,	CU_Value36,	CU_Value37,	CU_Value38,	CU_Value39,	CU_Value40,
		CU_Value41,	CU_Value42,	CU_Value43,	CU_Value44,	CU_Value45,	CU_Value46,	CU_Value47,	CU_Value48,	CU_Value49,	CU_Value50)

		SELECT @pPSSKey, PR_Code, @pPSSLastEditDate,
		CU_Value1,  CU_Value2,  CU_Value3,  CU_Value4,  CU_Value5,  CU_Value6,  CU_Value7,  CU_Value8,  CU_Value9,  CU_Value10,
		CU_Value11, CU_Value12,	CU_Value13,	CU_Value14,	CU_Value15,	CU_Value16,	CU_Value17,	CU_Value18,	CU_Value19,	CU_Value20,
		CU_Value21,	CU_Value22,	CU_Value23,	CU_Value24,	CU_Value25,	CU_Value26,	CU_Value27,	CU_Value28,	CU_Value29,	CU_Value30,
		CU_Value31,	CU_Value32,	CU_Value33,	CU_Value34,	CU_Value35,	CU_Value36,	CU_Value37,	CU_Value38,	CU_Value39,	CU_Value40,
		CU_Value41,	CU_Value42,	CU_Value43,	CU_Value44,	CU_Value45,	CU_Value46,	CU_Value47,	CU_Value48,	CU_Value49,	CU_Value50

		FROM ProjectCustomSTxt' + CAST(@intTable AS NVARCHAR) + '
		WHERE ProjectCustomSTxt' + CAST(@intTable AS NVARCHAR) + '.PR_Code IN (SELECT SubPR FROM ProjectRelations WHERE MasterPR = @pPRCode);';

		-- Execute the SQL
		SET @strParamDefinition = '@pPSSKey INTEGER, @pPSSLastEditDate FLOAT, @pPRCode NVARCHAR(20)';

		EXECUTE sp_executesql
						@strSQL,
						@strParamDefinition,
						@pPSSKey = @pPSSKey,
						@pPSSLastEditDate = @pPSSLastEditDate, 
						@pPRCode = @pPRCode;

		SET @intTable = @intTable + 1;
	END

	-- Txt
	SET @intTable = 1;
	WHILE (@intTable <= @intTxtTables)
	BEGIN
		SET @strSQL = '
		INSERT INTO ProjectCustomTxt' + CAST(@intTable AS NVARCHAR) + 'Archive (PSS_Key, PR_Code, CU_Date, 
		CU_Value1,  CU_Value2,  CU_Value3,  CU_Value4,  CU_Value5,  CU_Value6,  CU_Value7,  CU_Value8,  CU_Value9,  CU_Value10, 
		CU_Value11, CU_Value12, CU_Value13, CU_Value14, CU_Value15)
		
		SELECT @pPSSKey, PR_Code, @pPSSLastEditDate,
		CU_Value1,  CU_Value2,  CU_Value3,  CU_Value4,  CU_Value5,  CU_Value6,  CU_Value7,  CU_Value8,  CU_Value9,  CU_Value10, 
		CU_Value11, CU_Value12, CU_Value13, CU_Value14, CU_Value15
		
		FROM ProjectCustomTxt' + CAST(@intTable AS NVARCHAR) + '
		WHERE ProjectCustomTxt' + CAST(@intTable AS NVARCHAR) + '.PR_Code IN (SELECT SubPR FROM ProjectRelations WHERE MasterPR = @pPRCode);';

		-- Execute the SQL
		SET @strParamDefinition = '@pPSSKey INTEGER, @pPSSLastEditDate FLOAT, @pPRCode NVARCHAR(20)';

		EXECUTE sp_executesql
						@strSQL,
						@strParamDefinition,
						@pPSSKey = @pPSSKey,
						@pPSSLastEditDate = @pPSSLastEditDate, 
						@pPRCode = @pPRCode;

		SET @intTable = @intTable + 1;
	END

	-------------------------
	-- Custom Field Free Text
	-------------------------
	INSERT INTO CustomFieldFreeTextAudit (CFFAU_AuditId, CFFAU_AuditEntityType, CFF_Id, CF_Key, CFF_RecordCode, CFF_RecordKey, CFF_PlainText, CFF_FormattedText)

	SELECT @pPSSKey, 1074, CFF_Id, CF_Key, CFF_RecordCode, CFF_RecordKey, CFF_PlainText, CFF_FormattedText
	
	FROM CustomFieldFreeText
	
	WHERE CF_Key IN (SELECT CF_Key FROM CustomFields WHERE CF_Table = 1001)		-- Projects
	AND CustomFieldFreeText.CFF_RecordCode IN (SELECT SubPR FROM ProjectRelations WHERE MasterPR = @pPRCode);

END 

GO
GRANT EXECUTE
	ON [dbo].[aec_BL_Admin_CreateProjectSnapshot]
	TO [V6N14816rwZf]
GO
