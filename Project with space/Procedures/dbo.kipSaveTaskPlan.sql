SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO

/* MTA1s */
CREATE procedure [dbo].[kipSaveTaskPlan]
    @Project	nvarchar(20),
    @Version	int
as
    declare @systemFlag as int;
    declare @sql as nvarchar(max) = '';
begin

    -- Create a tempory table to hold the keys of Tasks we are updating
	CREATE TABLE #taskKeys
	(
		TA_Key int not null primary key, 
		TA_WIPKey int null,
		TA_WIPHasChanged int null		
	)

	CREATE TABLE #timesheetTaskKeys
	(
		TA_Key int not null,		
		TS_Key int Not null,
		TA_WIPKey int not null,
		PRIMARY KEY (TA_Key,TS_Key)
	)

	CREATE TABLE #timesheetAssignmentKeys
	(
		AS_Key int not null,		
		TS_Key int Not null,
		TA_WIPKey int Not null,
		AS_WIPKey int not null,
		PRIMARY KEY (AS_Key,TS_Key)
	)

	declare @Current int;

    -- Get the SystemFlag the tasks should be 
    -- PPC_Status = 1 -> Published Plan so make the flag 0
    -- PPC_Status = 2 -> Draft Plan so make the flag 7
    select @systemFlag = case when PPC_Status = 1 then 0 else 7 end
    from ProjectPlanControl 
    where PR_Code = @Project and PPC_Version = @Version;
	      
    -- Insert Keys of orginal Keys that have corresponding changed WIP versions
    insert into #taskKeys 
    select Task.TA_Key, WIP.TA_Key, WIP.TA_HasChanged
    from Task
    inner join Task WIP on WIP.PR_Code = @Project and WIP.PPC_Version = @Version and WIP.TA_SystemFlag = 15 and WIP.TA_LinkKey = Task.TA_Key 
    where Task.PR_Code = @Project and Task.PPC_Version = @Version and Task.TA_SystemFlag = @systemFlag;

    -- Insert Keys of any original Tasks that have been deleted or moved by a Jira synch
    insert into #taskKeys
    select Task.TA_Key, null, null
    from Task
    where Task.PR_Code = @Project and Task.PPC_Version = @Version and Task.TA_HasChanged IN (4, 10) AND Task.TA_Key NOT IN (SELECT #taskKeys.TA_Key FROM #taskKeys WHERE #taskKeys.TA_Key = Task.TA_Key);

	---------------------------------------
	-- DEACTIVATE Deleted Tasks
	----------------------------------------

    -- Update tasks to be "deleted" when linked to timesheet. 
	--(These are original Tasks that have been deleted from the Plan (no wip)
	-- OR WIP tasks that have been deleted from the plan)
    update Task
    set TA_Active = 1
    from Task
    inner join #taskKeys taskKeys on taskKeys.TA_Key = Task.TA_Key
    inner join Timesht on Timesht.TA_Key = Task.TA_Key
	Where (Task.TA_HasChanged = 4 or taskKeys.TA_WIPHasChanged = 4);    

	-- Update Assignments to be "deleted" when linked to a timesheet. (These are original Assignments that have been deleted from the Plan (no wip is created for these))
    update Assignment
    set AS_Active = 1
    from Assignment
	inner join #taskKeys taskKeys on taskKeys.TA_Key = Assignment.TA_Key
    inner join Timesht on Timesht.AS_Key = Assignment.AS_Key
	Where Assignment.AS_HasChanged = 4;  

	---------------------------------------
	-- UPDATE TIMESHEETS
	----------------------------------------

	-- Remove the Task Keys that have been deleted from the original plan but are linked to Timesheets. (These are made inactive above - we don't want to delete these Tasks from db).
	delete #taskKeys 	
	From #taskKeys taskKeys 
	inner join Timesht on Timesht.TA_Key = taskKeys.TA_Key 
	inner join Task on taskKeys.TA_Key = Task.TA_Key
	Where (Task.TA_HasChanged = 4 or taskKeys.TA_WIPHasChanged = 4);

	-- Get the Keys of original Tasks that have been saved against a Timesheet. (The timesheets need updating to point to the new Tasks).
	insert into #timesheetTaskKeys 
	select Task.TA_Key, Timesht.TS_Key, taskKeys.TA_WIPKey
	from Task 
	inner join #taskKeys taskKeys on taskKeys.TA_Key = Task.TA_Key
	inner join Timesht on Timesht.TA_Key = Task.TA_Key;	

	-- Get the Keys of original Assignments that have been saved against a Timesheet. (The timesheets need updating to point to the new Assignments).
	insert into #timesheetAssignmentKeys 
	select Assignment.AS_Key, Timesht.TS_Key, taskKeys.TA_WIPKey, WipAssignment.AS_Key
	from Assignment 
	inner join #taskKeys taskKeys on taskKeys.TA_Key = Assignment.TA_Key
	inner join Timesht on Timesht.AS_Key = Assignment.AS_Key
	inner Join Assignment WipAssignment on WipAssignment.AS_LinkKey = Assignment.AS_Key  	
	where WipAssignment.AS_HasChanged <> 4 ;

	-- Update the Timesheets to link to the new changed Tasks
	Update Timesht 
	set TA_Key = TA_WIPKey
	from #timesheetTaskKeys TTK
	where TTK.TS_Key = Timesht.TS_Key;
    
	-- Update the TimeRows to link to the new changed Tasks
	UPDATE TimeRows
	SET TimeRows.TA_Key = TA_WIPKey
	FROM #timesheetTaskKeys TTK
	WHERE TimeRows.TA_Key= TTK.TA_Key;

	-- Update the Timesheets to link to the new changed Assignments
	Update Timesht 
	set AS_Key = AS_WIPKey,
	TA_Key = TA_WIPKey
	from #timesheetAssignmentKeys TAK
	where TAK.AS_Key = Timesht.AS_Key;
	
	-- Update the TimeRows to link to the new changed Assignments
	UPDATE TimeRows 
	SET TimeRows.AS_Key = AS_WIPKey,
	TA_Key = TA_WIPKey
	FROM #timesheetAssignmentKeys TAK
	WHERE TAK.AS_Key = TimeRows.AS_Key;

	----------------------------------------
	-- UPDATE NOTIFICATIONS
	----------------------------------------

	-- update the Task Keys in existing notifications to the new key
	update Notifications
	set NTF_ContextKey = TA_Key
	from Notifications
	inner join Task On Task.TA_LinkKey = NTF_ContextKey 
	where PR_Code = @Project
	and PPC_Version = @Version
	and TA_SystemFlag = 15
	and ND_Key in (21,16)

	-- update the Assignment Keys in existing notifications to the new key
	update Notifications
	set NTF_ContextKey = AS_Key
	from Notifications
	inner join Assignment On Assignment.AS_LinkKey = NTF_ContextKey 
	inner join Task On Task.TA_Key = Assignment.TA_Key
	where PR_Code = @Project
	and PPC_Version = @Version
	and TA_SystemFlag = 15
	and ND_Key in (4)

	----------------------------------------
	-- UPDATE POSTS
	----------------------------------------

	-- update the Post Keys in existing Posts to the new key
	update Posts
	set TA_Key = Task.TA_Key	
	from Posts	
	inner join Task On Task.TA_LinkKey = Posts.TA_Key
	where Task.PR_Code = @Project
	and PPC_Version = @Version
	and TA_SystemFlag = 15	

	----------------------------------------
	-- UPDATE CONTRACTS AND INVOICES
	----------------------------------------

	update BillingContractLineTask
	set TA_Key = Task.TA_Key	
	from BillingContractLineTask
	inner join Task On Task.TA_LinkKey = BillingContractLineTask.TA_Key
	where Task.PR_Code = @Project
	and PPC_Version = @Version
	and TA_SystemFlag = 15	

	update BillingInvoiceLineTSDetail	
	set TA_Key = Task.TA_Key	
	from BillingInvoiceLineTSDetail
	inner join Task On Task.TA_LinkKey = BillingInvoiceLineTSDetail.TA_Key
	where Task.PR_Code = @Project
	and PPC_Version = @Version
	and TA_SystemFlag = 15	


	----------------------------------------
	-- UPDATE PUBLISH KEYS
	----------------------------------------
	    
	-- If this is the published plan tasks then update any other Tasks so that they reference the new wip key.
	update Task		
	set TA_KeyPublished = taskKeys.TA_WIPKey
	from Task
	inner join #taskKeys taskKeys on taskKeys.TA_Key = Task.TA_KeyPublished	
	where taskKeys.TA_WIPHasChanged <> 4;

	--Update the new WIP records to have the correct Key
	-- If this is the published plan assignments then update any other assignments so that they reference the new wip key.
	UPDATE Assignment
	SET  Assignment.AS_KeyPublished = WIPAssignment.AS_Key
	FROM Assignment 
	INNER JOIN Assignment PublishedAssignment ON PublishedAssignment.AS_Key = Assignment.AS_KeyPublished
	INNER JOIN Assignment WIPAssignment ON WIPAssignment.AS_LinkKey = PublishedAssignment.AS_Key
	INNER JOIN Task WIPTask ON WIPTask.TA_Key = WIPAssignment.TA_Key
	WHERE WIPTask.PR_Code = @Project
	AND WIPTask.PPC_Version = @Version
	and WIPTask.TA_SystemFlag = 15
	and WIPAssignment.AS_HasChanged <> 4; 

	-- Deleted assignments dont't have a WIP version. 
	-- So we need to clear the publish keys for any assignments about to be deleted from the published version
	Update Assignment
	set AS_KeyPublished = null
	from Assignment
	where AS_KeyPublished in (
	Select Assignment.AS_Key 
	from Assignment  
	inner join #taskKeys taskKeys on taskKeys.TA_Key = Assignment.TA_Key
	left join Timesht on Timesht.AS_Key = Assignment.AS_Key
	where TS_Key is null
	and AS_HasChanged = 4)

	----------------------------------------
	-- UPDATE INACTIVE ASSIGNMENTS
	----------------------------------------

	-- Update any inactive Assignment's Task Key to point to the new wip Task

	-- Update any Assignments that are inactive (previously logged to Time but since deleted) with the new Task ID.
	-- (A WIP version is NOT created for inactive Assignments - but the Task WIP is created).
	update Assignment
	set Assignment.TA_Key = taskKeys.TA_WIPKey
	from Assignment 
	inner join #taskKeys taskKeys on taskKeys.TA_Key = Assignment.TA_Key
	inner join Timesht on Timesht.AS_Key = Assignment.AS_Key
	where Assignment.AS_Active = 1;

	--Update any Assignments that has a corresponding WIP Assignment that is flagged as deleted (haschanged=4) and is linked to timesheets
	-- (Note: opening the task modal and deleting the task DOES create a wip assignment. This is different when done on the grid, where it does not).
	update Assignment 
	set Assignment.TA_Key = taskKeys.TA_WIPKey,
	AS_Active = 1
	From Assignment
	inner join #taskKeys taskKeys on taskKeys.TA_Key = Assignment.TA_Key
	inner join Assignment  WipAssignment on WipAssignment.AS_LinkKey = Assignment.AS_Key
	inner join Timesht on Timesht.AS_Key = Assignment.AS_Key
	where WipAssignment.AS_HasChanged = 4

	-- update assignments from Tasks that are being made inactive (deleted with Time. These assignments are de-activated too).	
	update Assignment 	
	set AS_Active = 1
	from Assignment
	inner join Task on Task.TA_Key = Assignment.TA_Key
    left join #taskKeys taskKeys on taskKeys.TA_Key = Task.TA_Key
    inner join Timesht on Timesht.TA_Key = Task.TA_Key
	Where (Task.TA_HasChanged = 4 or taskKeys.TA_WIPHasChanged = 4)

	----------------------------------------
	-- DELELTE THE OLD TASK AND ASSIGNMENTS
	----------------------------------------

	CREATE TABLE #originalAssignmentKeys
	(
		AS_Key int not null primary key	
	);

	-- Get the original Assignments (linked to the original Tasks that have changed but don't include those linked to timesheets
	insert into #originalAssignmentKeys 
	select Assignment.AS_Key from Assignment  
	inner join #taskKeys keys on keys.TA_Key = Assignment.TA_Key
	left join Timesht on Timesht.AS_Key = Assignment.AS_Key
	where TS_Key is null;

	--Clear any Publish keys that link to these Assignments that we are about to delete
	Update Assignment
	set AS_KeyPublished = null
	where AS_KeyPublished in (select AS_Key from #originalAssignmentKeys);

    -- Assignment Custom Fields    
	set @sql = '';
    select @sql = @sql + N'delete from ' + CT_TableName + N' where AS_Key IN (select AS_Key from #originalAssignmentKeys); ' from kipCustomFieldTables('Assignment',1041);	
    exec (@sql);
    
	-- Assignment Custom Long Text Fields
	SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'AssignmentCustomTxt';		
	WHILE @Current > 0
		BEGIN		  
			SET @sql = N'
				delete CustomFieldFreeText 
				from CustomFieldFreeText 
				inner join Assignment on Assignment.AS_Key = CustomFieldFreeText.CFF_RecordKey
				where AS_Key IN (select AS_Key from #originalAssignmentKeys)
				and CustomFieldFreeText.CF_Key = @Current;';

			EXEC sp_executesql @sql, N'@Current INT', @Current;

			SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'AssignmentCustomTxt' AND CF_Key < @Current
		END;

    delete AssignmentPlan from AssignmentPlan 
	inner join Assignment on Assignment.AS_Key = AssignmentPlan.AS_Key 
	inner join #originalAssignmentKeys keys on keys.AS_Key = Assignment.AS_Key;    

    delete Assignment from Assignment 
	inner join #originalAssignmentKeys keys on keys.AS_Key = Assignment.AS_Key;
      
	  
	-- Clear any Publish keys that link to these Tasks that we are about to delete
	Update Task
	set TA_KeyPublished = null
	where TA_KeyPublished in (select TA_Key from #taskKeys);
	  	   
    -- Task Custom Fields  	
	set @sql = '';
    select @sql = @sql + N'delete from ' + CT_TableName + N' where TA_Key IN (select TA_Key from #taskKeys); ' from kipCustomFieldTables('Task',1040);	
    exec (@sql);
    
	Set @Current = 0;

	-- Task Custom Long Text Fields
	SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'TaskCustomTxt';		
	WHILE @Current > 0
		BEGIN		  
			SET @sql = N'
				delete CustomFieldFreeText 
				from CustomFieldFreeText 
				inner join Task on Task.TA_Key = CustomFieldFreeText.CFF_RecordKey
				where TA_Key IN (select TA_Key from #taskKeys) 
				and CustomFieldFreeText.CF_Key = @Current;';

			EXEC sp_executesql @sql, N'@Current INT', @Current;

			SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'TaskCustomTxt' AND CF_Key < @Current
		END;

	-- Task Skills
	delete TaskSkill
	where TA_Key IN (select TA_Key from #taskKeys);

	-- Task Documents
	delete TaskDocuments
	where TA_Key IN (select TA_Key from #taskKeys);

	-- Delete Predeseccors and Successors
    delete TaskDependencies 
	where TA_KeyChild IN (select TA_Key from #taskKeys);	

    delete TaskDependencies 
	where TA_KeyParent IN (select TA_Key from #taskKeys);	
	
	--Delete Post Comments
	delete	PostComments 
	from PostComments
	inner join Posts on Posts.PST_Key = PostComments.PST_Key
	where Posts.TA_Key IN (select TA_Key from #taskKeys);	

	--Delete Posts
	delete Posts where Posts.TA_Key IN (select TA_Key from #taskKeys);	

	-- Delete the Task
    delete Task from Task WHERE TA_Key IN (select TA_Key from #taskKeys);
    
	-----------------------------------------
	-- UPDATE THE NEW TASK AND ASSIGNMENTS
	-----------------------------------------

	-- set the System Flag to normal task Plan Task - not WIP.
	-- set the linkKey to null
	-- set the Task as not changed	

	-- First Delete Any WIP Assignments flagged for Deletion. (A Wip Task may exist with Wip Assignments - one of which may have been deleted. 
	--															We need to remove the WIP Deleted Assignment from the database.)
	
	-- Assignment Custom Fields    
	set @sql = '';
    select @sql = @sql + N'delete from ' + CT_TableName + N' where AS_Key IN (select AS_Key from Assignment inner join Task on Task.TA_Key = Assignment.TA_Key where Task.PR_Code = @Project and PPC_Version = @Version and TA_SystemFlag = 15 and AS_HasChanged = 4 and AS_Active <> 1); ' from kipCustomFieldTables('Assignment',1041);	
    EXEC sp_executesql @sql, N'@Project NVARCHAR(20), @Version INT', @Project, @Version;


	set @Current = 0;

	-- Assignment Custom Long Text Fields
	SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'AssignmentCustomTxt';		
	WHILE @Current > 0
		BEGIN		  
			SET @sql = N'
				delete CustomFieldFreeText 
				from CustomFieldFreeText 
				inner join Assignment on Assignment.AS_Key = CustomFieldFreeText.CFF_RecordKey
				inner join Task on Task.TA_Key = Assignment.TA_Key
				where Task.PR_Code = @Project 
				and PPC_Version = @Version 
				and TA_SystemFlag = 15 
				and AS_HasChanged = 4
				and AS_Active <> 1
				and CustomFieldFreeText.CF_Key = @Current;';

			EXEC sp_executesql @sql, N'@Project NVARCHAR(20), @Version INT, @Current INT', @Project, @Version, @Current;

			SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'AssignmentCustomTxt' AND CF_Key < @Current
		END;

	delete AssignmentPlan from AssignmentPlan 
	inner join Assignment on Assignment.AS_Key = AssignmentPlan.AS_Key 
	inner join Task on Task.TA_Key = Assignment.TA_Key
	where Task.PR_Code = @Project 
	and PPC_Version = @Version 
	and TA_SystemFlag = 15
	and AS_HasChanged = 4
	and AS_Active <> 1; 

    delete Assignment from Assignment 
	inner join Task on Task.TA_Key = Assignment.TA_Key
	where Task.PR_Code = @Project 
	and PPC_Version = @Version 
	and TA_SystemFlag = 15
	and AS_HasChanged = 4
	and AS_Active <> 1; 

    -- Now Update the changed Tasks to a normal Task type
    update Task 
    set 
	TA_SystemFlag = @systemFlag, 
	TA_LinkKey = null,
	TA_HasChanged = 0 
    where PR_Code = @Project and PPC_Version = @Version and TA_SystemFlag = 15; 

	--Clear the link key for new Assignments		
    update Assignment 
    set AS_LinkKey = null,
	AS_HasChanged = 0 
    from Assignment 
    inner join Task on Task.TA_Key = Assignment.TA_Key 
    where PR_Code = @Project 
	and PPC_Version = @Version 
	and AS_LinkKey is not null
	and AS_HasChanged <> 4;

end;
GO
GRANT EXECUTE
	ON [dbo].[kipSaveTaskPlan]
	TO [V6N14816rwZf]
GO
