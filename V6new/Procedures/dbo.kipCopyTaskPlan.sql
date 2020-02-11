SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
/**************************************************************************************************************************************
											  KeyedIn Projects Database Upgrade Script 
														v6.5.0.43743 to v6.5.0.43776
***************************************************************************************************************************************
	
TL1	- 11/11/2019
	Update kipCopyTaskPlan so that it does not copy inactive Tasks and Assignments

**************************************************************************************************************************************/	

--TL1s

---------------------- [kipCopyTaskPlan] -----------------------------------------------
--
-- A straight copy of all Task, Assignment and related tables into a new DRAFT version
--
----------------------------------------------------------------------------------------
CREATE Procedure [dbo].[kipCopyTaskPlan]
	@ProjectFrom	nvarchar(20),
	@ProjectTo	nvarchar(20),
	@VersionFrom	int,	
	@NewVersion	int,
	@Description	nvarchar(70)
AS	
begin	    
    declare @systemFlag int;
    declare @sql nvarchar(max);
    declare @PostKeys as table(new int, orig int);
	declare @copyPublishKey int;

    set @systemFlag = 7;
	SET @copyPublishKey = -1;

	--Find out if we need to copy the published Key. Are we copying the pubished version?
	SELECT @copyPublishKey = CASE WHEN ProjectPlanControl.PPC_Status = 1 THEN 0 ELSE -1 END 
	FROM ProjectPlanControl
	WHERE PR_Code = @ProjectFrom AND PPC_Version = @VersionFrom AND @ProjectFrom = @ProjectTo;


    -- add new Project Plan Control record
    insert into ProjectPlanControl (PR_Code, PPC_Version, PPC_Status, PPC_Desc, PPC_PlanStartDate, PPC_CheckedOutBy, PPC_CheckedOutOn, PPC_OverwritenBy, PPC_HasChanged, PPC_OriginalVersion)
    select	@ProjectTo, @NewVersion, 2, @Description, isnull(PPC_PlanStartDate,cast(getdate() + 2 as float)), '', null, '', 0, 0
    from	ProjectPlanControl
    where	PR_Code = @ProjectFrom and PPC_Version = @VersionFrom;

    -- insert task --> Set TA_LinkKey to be the original task, we will null it later
    insert into Task 
	   (PR_Code,TA_Desc,AC_Code,MS_Key,TA_StartDate,TA_StartTime,TA_EndDate,TA_EndTime,TA_AnchoredStart,TA_AnchoredEnd,
		  TA_Work,TA_PercentComplete,TA_ActualWork,TA_ActualWorkRollup,TA_MinimumResources,TA_Status,TA_Milestone,
		  TA_EstimateWork,TA_EstimateEndDate,TA_EstimateChangedOn,TA_EstimateChangedBy,TA_Imported,TA_PlanUniqueID,TA_Active,
		  TA_SystemFlag,TA_ID,TA_Empty,TA_Summary,TA_OutlineLevel,TA_OutlineNumber,TA_WBS,TA_ConstraintType,TA_ConstraintDate,
		  US_Code,TA_LastEditDate,TA_LastEdit,TA_Null,TA_KeyPublished,PPC_Version,TA_DeadlineDate,TA_AllocatedWork,RE_CodeRole,
		  TA_CompleteDate,TA_SynchWithJIRA,TA_LinkKey,TA_HasChanged,TA_PreviousID, TA_Index, TA_Protected)
    select  @ProjectTo,TA_Desc,AC_Code,MS_Key,TA_StartDate,TA_StartTime,TA_EndDate,TA_EndTime,TA_AnchoredStart,TA_AnchoredEnd,
		  TA_Work,TA_PercentComplete,TA_ActualWork,TA_ActualWorkRollup,TA_MinimumResources,TA_Status,TA_Milestone,
		  TA_EstimateWork,TA_EstimateEndDate,TA_EstimateChangedOn,TA_EstimateChangedBy,TA_Imported,TA_PlanUniqueID,TA_Active,
		  @systemFlag,TA_ID,TA_Empty,TA_Summary,TA_OutlineLevel,TA_OutlineNumber,TA_WBS,TA_ConstraintType,TA_ConstraintDate,
		  US_Code,TA_LastEditDate,TA_LastEdit,TA_Null,CASE WHEN @copyPublishKey = -1 THEN TA_KeyPublished ELSE TA_Key END,@NewVersion,TA_DeadlineDate,TA_AllocatedWork,RE_CodeRole,
		  TA_CompleteDate,TA_SynchWithJIRA,TA_Key,TA_HasChanged,TA_PreviousID, TA_Index, TA_Protected 
    from Task 
    where PR_Code = @ProjectFrom and PPC_Version = @VersionFrom
	and TA_SystemFlag <> 15
    and TA_Active <> 1; -- Do not copy already inactive Tasks

    -- insert task related records                
    insert into TaskSkill (TA_Key, SK_Code, TS_Level, TS_LastEdit)
    select Task.TA_Key, TaskSkill.SK_Code, TaskSkill.TS_Level, TaskSkill.TS_LastEdit
    from Task
    inner join TaskSkill on TaskSkill.TA_Key = Task.TA_LinkKey
    where Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion;

    insert into TaskDependencies (TA_KeyChild, TA_KeyParent, TD_Type, TD_Lag)
    select Child.TA_Key, Parent.TA_Key, TaskDependencies.TD_Type, TaskDependencies.TD_Lag
    from TaskDependencies
    inner join Task Child on Child.PR_Code = @ProjectTo and Child.PPC_Version = @NewVersion and Child.TA_LinkKey = TaskDependencies.TA_KeyChild
    inner join Task Parent on Parent.PR_Code = @ProjectTo and Parent.PPC_Version = @NewVersion and Parent.TA_LinkKey = TaskDependencies.TA_KeyParent;
    
	---***********************
	-- COPY TASK DOCUMENTS
	---***********************

    --insert into TaskDocuments (TA_Key, DH_Key)
    --select Task.TA_Key, TaskDocuments.DH_Key
    --from Task
    --inner join TaskDocuments on TaskDocuments.TA_Key = Task.TA_LinkKey
    --where Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion;
    
	DECLARE @CurrentDocKey int;
	DECLARE @TaskKey int;

	--Loop backwards through Original Task Documents to Copy
    SELECT @CurrentDocKey = MAX(ISNULL(DH.DH_Key,0)) FROM Task
	INNER JOIN TaskDocuments on TaskDocuments.TA_Key = Task.TA_LinkKey
	INNER JOIN DocumentHeader DH on TaskDocuments.DH_Key = DH.DH_Key
	where Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion			

	WHILE @CurrentDocKey > 0
	BEGIN

		-- Get the next available Document Key
		Declare @NewDocKey int;
		SELECT @NewDocKey = Max(DH_Key) + 1 FROM DocumentHeader;			

		-- Insert Document Header a copy of the task Document with the new doc key 
		INSERT INTO DocumentHeader (DH_Key,DH_Id,DH_Version,DH_VersionMinor,DH_Filename,DH_Desc,DH_ContentType,DH_ActualSize,DH_ReferenceCount,DH_CheckedOutBy,DH_CheckedOutDate, DH_CheckedInBy, DH_CheckedInDate, DH_LastEditUser, DH_LastEditDate)
		SELECT @NewDocKey, @NewDocKey ,DH_Version,DH_VersionMinor,DH_Filename,DH_Desc,DH_ContentType,DH_ActualSize,DH_ReferenceCount,DH_CheckedOutBy,DH_CheckedOutDate, DH_CheckedInBy, DH_CheckedInDate, DH_LastEditUser, DH_LastEditDate
		FROM DocumentHeader DH
		WHERE DH.DH_Key = @CurrentDocKey; 		 				  	  		  		 				

		--Document Data
		INSERT INTO DocumentData (DH_Key,DD_BinaryData)
		SELECT @NewDocKey, DD_BinaryData
		FROM DocumentData DD
		WHERE DD.DH_Key = @CurrentDocKey; 		

		--Get the new Task Key that relates to the current document we are copying
		SELECT @TaskKey = Task.TA_Key
		FROM Task
		INNER JOIN TaskDocuments on TaskDocuments.TA_Key = Task.TA_LinkKey
		WHERE Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion
		AND TaskDocuments.DH_Key = @CurrentDocKey;		

		-- Insert in the Task Documents with the new task key and new doc key
		INSERT INTO TaskDocuments(TA_Key, DH_Key)
		VALUES (@TaskKey,@NewDocKey);

		-- Get the next document key to copy
		SELECT @CurrentDocKey = MAX(ISNULL(DH.DH_Key,0)) FROM Task
		inner join TaskDocuments on TaskDocuments.TA_Key = Task.TA_LinkKey
		inner join DocumentHeader DH on TaskDocuments.DH_Key = DH.DH_Key
		where Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion	AND DH.DH_Key < @CurrentDocKey;

	END;

	---***************************
	-- END OF COPY TASK DOCUMENTS
	---***************************
             
    merge
    Posts Po
    using
    (
	   select P.PST_Status,P.PST_Type,P.PST_Text,P.PR_Code,P.RK_Code,TA.TA_Key,P.DV_Key,P.PDL_Key,P.RE_Code,P.US_CodePostedBy,
				P.PST_PostedDate,P.PST_PostedTime,P.US_CodeLastEdit,P.PST_LastEditDate,P.PST_LastEditTime, PST_Key
	   from Posts P inner join Task TA ON TA.PR_Code = @ProjectTo AND TA.PPC_Version = @NewVersion and TA.TA_LinkKey = P.TA_Key
    ) as P
    on (1=0)
    when not matched
    then insert(PST_Status,PST_Type,PST_Text,PR_Code,RK_Code,TA_Key,DV_Key,PDL_Key,RE_Code,US_CodePostedBy,
				    PST_PostedDate,PST_PostedTime,US_CodeLastEdit,PST_LastEditDate,PST_LastEditTime)
	   values (P.PST_Status,P.PST_Type,P.PST_Text,P.PR_Code,P.RK_Code,P.TA_Key,P.DV_Key,P.PDL_Key,P.RE_Code,P.US_CodePostedBy,
				    P.PST_PostedDate,P.PST_PostedTime,P.US_CodeLastEdit,P.PST_LastEditDate,P.PST_LastEditTime)
    output inserted.PST_Key, P.PST_Key into @PostKeys(new, orig);			    

    insert into PostResources
    select PK.new, PR.RE_Code
    from PostResources PR
    inner join Posts P ON P.PST_Key = PR.PST_Key
    inner join @PostKeys PK ON PK.orig = P.PST_Key;

    insert into PostComments
    select PK.new,PC.PCO_Text,PC.RE_Code,PC.US_CodePostedBy,PC.PCO_PostedDate,PC.PCO_PostedTime,PC.US_CodeLastEdit,PC.PCO_LastEditDate
    from PostComments PC
    inner join Posts P on P.PST_Key = PC.PST_Key
    inner join @PostKeys PK on PK.orig = P.PST_Key;

    -- assignment related records
    insert into Assignment
    (TA_Key,RE_Code,RE_CodeRole,DE_Code,AS_Desc,AS_Work,AS_PercentComplete,AS_ActualWork,AS_StartDate,AS_StartTime,AS_EndDate,AS_EndTime,
    AS_AnchoredStart,AS_AnchoredEnd,AS_AssignmentCount,AS_Status,AS_Active,US_Code,AS_LastEditDate,AS_LastEdit,AS_Null,AS_KeyPublished,
    AS_CreatedDateTime,AS_WorkContour,AS_CompleteDate,AS_CreatedFromForecast,AS_LinkKey,AS_HasChanged,AS_ID)
    select 
    Task.TA_Key,A.RE_Code,A.RE_CodeRole,A.DE_Code,A.AS_Desc,A.AS_Work,A.AS_PercentComplete,A.AS_ActualWork,A.AS_StartDate,A.AS_StartTime,A.AS_EndDate,A.AS_EndTime,
    A.AS_AnchoredStart,A.AS_AnchoredEnd,A.AS_AssignmentCount,A.AS_Status,A.AS_Active,A.US_Code,A.AS_LastEditDate,A.AS_LastEdit,A.AS_Null,
	CASE WHEN @copyPublishKey = -1 THEN A.AS_KeyPublished ELSE A.AS_Key END,
    A.AS_CreatedDateTime,A.AS_WorkContour,A.AS_CompleteDate,A.AS_CreatedFromForecast,A.AS_Key,A.AS_HasChanged,A.AS_ID
    from Assignment A
    inner join Task on Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion and Task.TA_LinkKey = A.TA_Key
	WHERE A.AS_Active <> 1; -- Do not copy already inactive Assignments

    insert into AssignmentPlan (AS_Key,AP_Date,AP_Work,AP_LastEdit)
    select Assignment.AS_Key, AssignmentPlan.AP_Date, AssignmentPlan.AP_Work, AssignmentPlan.AP_LastEdit
    from Assignment
    inner join Task on Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion and Task.TA_Key = Assignment.TA_Key
    inner join AssignmentPlan on AssignmentPlan.AS_Key = Assignment.AS_LinkKey;    		

    set @sql = ''
    select @sql = @sql +  N'insert into '+CT_TableName+
    N' select Task.TA_Key, 
	   CU_Value1,CU_Value2,CU_Value3,CU_Value4,CU_Value5,CU_Value6,CU_Value7,CU_Value8,CU_Value9,CU_Value10,
	   CU_Value11,CU_Value12,CU_Value13,CU_Value14,CU_Value15,CU_Value16,CU_Value17,CU_Value18,CU_Value19,CU_Value20,
	   CU_Value21,CU_Value22,CU_Value23,CU_Value24,CU_Value25,CU_Value26,CU_Value27,CU_Value28,CU_Value29,CU_Value30,
	   CU_Value31,CU_Value32,CU_Value33,CU_Value34,CU_Value35,CU_Value36,CU_Value37,CU_Value38,CU_Value39,CU_Value40,
	   CU_Value41,CU_Value42,CU_Value43,CU_Value44,CU_Value45,CU_Value46,CU_Value47,CU_Value48,CU_Value49,CU_Value50
    from '+CT_TableName+
    N' inner join Task on Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion and '+CT_TableName+N'.TA_Key = Task.TA_LinkKey;' from kipCustomFieldTables('Task',1040) where CT_TableName like N'%CustomNum%' OR CT_TableName like N'%CustomSTxt%'
    exec sp_executesql @sql, N'@ProjectTo nvarchar(20), @NewVersion int', @ProjectTo, @NewVersion   
    
    set @sql = ''
    select @sql = @sql +  N'insert into '+CT_TableName+
    N' select Task.TA_Key, 
	   CU_Value1,CU_Value2,CU_Value3,CU_Value4,CU_Value5,
	   CU_Value6,CU_Value7,CU_Value8,CU_Value9,CU_Value10,
	   CU_Value11,CU_Value12,CU_Value13,CU_Value14,CU_Value15
    from '+CT_TableName+
    N' inner join Task on Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion and '+CT_TableName+N'.TA_Key = Task.TA_LinkKey;' from kipCustomFieldTables('Task',1040) where CT_TableName like N'%CustomTxt%'
    exec sp_executesql @sql, N'@ProjectTo nvarchar(20), @NewVersion int', @ProjectTo, @NewVersion       
       
    set @sql = ''
    select @sql = @sql +  N'insert into '+CT_TableName+
    N' select Assignment.AS_Key, 
	   CU_Value1,CU_Value2,CU_Value3,CU_Value4,CU_Value5,CU_Value6,CU_Value7,CU_Value8,CU_Value9,CU_Value10,
	   CU_Value11,CU_Value12,CU_Value13,CU_Value14,CU_Value15,CU_Value16,CU_Value17,CU_Value18,CU_Value19,CU_Value20,
	   CU_Value21,CU_Value22,CU_Value23,CU_Value24,CU_Value25,CU_Value26,CU_Value27,CU_Value28,CU_Value29,CU_Value30,
	   CU_Value31,CU_Value32,CU_Value33,CU_Value34,CU_Value35,CU_Value36,CU_Value37,CU_Value38,CU_Value39,CU_Value40,
	   CU_Value41,CU_Value42,CU_Value43,CU_Value44,CU_Value45,CU_Value46,CU_Value47,CU_Value48,CU_Value49,CU_Value50
    from '+CT_TableName+
    N' inner join Assignment on Assignment.AS_LinkKey = '+CT_TableName+N'.AS_Key
    inner join Task on Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion and Task.TA_Key = Assignment.TA_Key;' from kipCustomFieldTables('Assignment',1041) where CT_TableName like N'%CustomNum%' OR CT_TableName like N'%CustomSTxt%'
    exec sp_executesql @sql, N'@ProjectTo nvarchar(20), @NewVersion int', @ProjectTo, @NewVersion             

    set @sql = ''
    select @sql = @sql +  N'insert into '+CT_TableName+
    N' select Assignment.AS_Key, 
	   CU_Value1,CU_Value2,CU_Value3,CU_Value4,CU_Value5,
	   CU_Value6,CU_Value7,CU_Value8,CU_Value9,CU_Value10,
	   CU_Value11,CU_Value12,CU_Value13,CU_Value14,CU_Value15
    from '+CT_TableName+
    N' inner join Assignment on Assignment.AS_LinkKey = '+CT_TableName+N'.AS_Key
    inner join Task on Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion and Task.TA_Key = Assignment.TA_Key;' from kipCustomFieldTables('Assignment',1041) where CT_TableName like N'%CustomTxt%'
    exec sp_executesql @sql, N'@ProjectTo nvarchar(20), @NewVersion int', @ProjectTo, @NewVersion                       

	-------------------------------
	-- Copy Task Long Text FreeText
	-------------------------------
	Declare @Current int;
	SET @Current  = 1;

	--Loop backwards through all the Long Text and fomatted text custom fields  
    SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 23 OR CF_DataType = 24) AND CF_CustomTableName = N'TaskCustomTxt';			

	WHILE @Current > 0
	BEGIN
		SET @sql = N'INSERT INTO CustomFieldFreeText
		(CF_Key,CFF_RecordKey,CFF_PlainText,CFF_FormattedText)		  
		SELECT @Current, TA.TA_Key, CFFT.CFF_PlainText, CFFT.CFF_FormattedText
		FROM CustomFieldFreeText CFFT		  
		INNER JOIN Task TA ON TA.TA_LinkKey = CFFT.CFF_RecordKey
		WHERE TA.PR_Code = @Project AND TA.PPC_Version = @Version AND CFFT.CF_Key = @Current; ';		  	  	  		  		  

		EXEC sp_executesql @sql, N'@Project NVARCHAR(20), @Version INT, @Current INT', @ProjectTo, @NewVersion, @Current;

		--get the next Custom field Ky
		SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 23 OR CF_DataType = 24) AND CF_CustomTableName = N'TaskCustomTxt' AND CF_Key < @Current
	END;

	SET @Current  = 1;

	--------------------------------------
	-- Copy Assignment Long Text FreeText
	--------------------------------------

    SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 23 OR CF_DataType = 24) AND CF_CustomTableName = N'AssignmentCustomTxt'		
	WHILE @Current > 0
	BEGIN
		SET @sql = 'INSERT INTO CustomFieldFreeText
		(CF_Key,CFF_RecordKey,CFF_PlainText,CFF_FormattedText)		  		  
		SELECT @Current, A.AS_Key, CFFT.CFF_PlainText, CFFT.CFF_FormattedText
		FROM CustomFieldFreeText CFFT		  
		INNER JOIN Assignment A ON A.AS_LinkKey = CFFT.CFF_RecordKey
		INNER JOIN Task TA ON TA.TA_Key = A.TA_Key
		WHERE TA.PR_Code = @Project AND TA.PPC_Version = @Version AND CFFT.CF_Key = @Current; ';

		EXEC sp_executesql @sql, N'@Project NVARCHAR(20), @Version INT, @Current INT', @ProjectTo, @NewVersion, @Current

		SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 23 OR CF_DataType = 24) AND CF_CustomTableName = N'AssignmentCustomTxt' AND CF_Key < @Current
	END;

    -- reset the link key to null
    update Task
    set TA_LinkKey = null
    where Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion;
				
    update Assignment
    set AS_LinkKey = null
    from Assignment
    inner join Task on Task.TA_Key = Assignment.TA_Key
    where Task.PR_Code = @ProjectTo and Task.PPC_Version = @NewVersion;
end

GO
GRANT EXECUTE
	ON [dbo].[kipCopyTaskPlan]
	TO [V6N14816rwZf]
GO
