SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
--TL7e

--TL8s
CREATE procedure [dbo].[kipRollbackTaskPlan]
    @Project	nvarchar(20),
    @Version	int
as
begin    

	--Check if there are any WIPs to rollback
	declare @TaskWIPCount int;
	select @TaskWIPCount = count(TA_Key)
	from Task 
	where PR_Code = @Project 
	and Task.PPC_Version = @Version 
	and Task.TA_SystemFlag = 15;

	IF (@TaskWIPCount > 0)
		BEGIN
			declare @sql nvarchar(max);
			declare @Current int;

			-- Assignment Custom Fields
			set @sql = '';
			select @sql = @sql + N'delete ' + CT_TableName + N' from ' + CT_TableName + N' join Assignment on Assignment.AS_Key = ' + CT_TableName + N'.AS_Key join Task on Assignment.TA_Key = Task.TA_Key where Task.PR_Code = @Project and Task.PPC_Version = @Version and Task.TA_SystemFlag = 15; ' from kipCustomFieldTables('Assignment',1041);
			exec sp_executesql @sql, N'@Project nvarchar(20), @Version int', @Project, @Version;
    
			delete AssignmentPlan from AssignmentPlan inner join Assignment on Assignment.AS_Key = AssignmentPlan.AS_Key inner join Task on Task.PR_Code = @Project and Task.PPC_Version = @Version and Task.TA_Key = Assignment.TA_Key where Task.TA_SystemFlag = 15
			delete Assignment from Assignment inner join Task on Task.PR_Code = @Project and Task.PPC_Version = @Version and Task.TA_Key = Assignment.TA_Key where Task.TA_SystemFlag = 15
			-- Delete and WIP Tasks, this should allow the Original Task to be visible again    
			-- Task Custom Fields
			set @sql = '';		  
			select @sql = @sql + N'delete ' + CT_TableName + ' from	' + CT_TableName + ' join Task on ' + CT_TableName + '.TA_Key = Task.TA_Key where Task.PR_Code = @Project and Task.PPC_Version = @Version and Task.TA_SystemFlag = 15; ' from kipCustomFieldTables('Task',1040);
			exec sp_executesql @sql, N'@Project nvarchar(20), @Version int', @Project, @Version;    
    
			Set @Current = 0;

			-- Task Custom Long Text Fields
			SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'TaskCustomTxt';		
			WHILE @Current > 0
			   BEGIN		  
				  SET @sql = N'
					 delete CustomFieldFreeText 
					 from CustomFieldFreeText 
						inner join Task on Task.TA_Key = CustomFieldFreeText.CFF_RecordKey
					 where Task.PR_Code = @Project 
						and Task.PPC_Version = @Version 
						and CustomFieldFreeText.CF_Key = @Current
						and Task.TA_SystemFlag = 15;';

				  EXEC sp_executesql @sql, N'@Project NVARCHAR(20), @Version INT, @Current INT', @Project, @Version, @Current;

				  SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'TaskCustomTxt' AND CF_Key < @Current
			   END;

			Set @Current = 0;

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
						and Task.PPC_Version = @Version 
						and CustomFieldFreeText.CF_Key = @Current
						and Task.TA_SystemFlag = 15;';

				  EXEC sp_executesql @sql, N'@Project NVARCHAR(20), @Version INT, @Current INT', @Project, @Version, @Current;

				  SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'AssignmentCustomTxt' AND CF_Key < @Current
			   END;

			--Delete the Task Dependencies
			delete TaskDependencies 
			from TaskDependencies 
			inner join Task on Task.TA_Key = TaskDependencies.TA_KeyChild
			where Task.PR_Code = @Project 
			and Task.PPC_Version = @Version 
			and Task.TA_SystemFlag = 15;	
			
			delete TaskDependencies 
			from TaskDependencies 
			inner join Task on Task.TA_Key = TaskDependencies.TA_KeyParent 
			where Task.PR_Code = @Project 
			and Task.PPC_Version = @Version 
			and Task.TA_SystemFlag = 15;	

			-- delete Task Skills
			delete TaskSkill
			from TaskSkill TS
			inner join Task on TS.TA_Key = Task.TA_Key
			where  Task.PR_Code = @Project 
			and Task.PPC_Version = @Version 
			and Task.TA_SystemFlag = 15; 

			--delete Task Documents
			delete TaskDocuments
			from TaskDocuments TD
			inner join Task on TD.TA_Key = Task.TA_Key
			where  Task.PR_Code = @Project 
			and Task.PPC_Version = @Version 
			and Task.TA_SystemFlag = 15; 

			--Delete the Task
			delete Task 
			where PR_Code = @Project 
			and Task.PPC_Version = @Version 
			and Task.TA_SystemFlag = 15			
			

		END

		--Check if there are any Deleted / changed rows to reset to normal/0
		-- (When a Task is deleted there is no wip for it - it has a haschanged of 4:deleted)
		-- (when a Task's Assignment is deleted, there is no WIP - it has a haschanged of 2: changed)

		-- Unflag any Tasks as being deleted
		-- (Reset any original Tasks that may have been flagged for deletion - ie. haschanged = 4. This way they will then reappear)
		update Task 
		set TA_HasChanged = 0, 
			TA_LinkKey = null				
		where PR_Code = @Project and Task.PPC_Version = @Version
		and TA_HasChanged <> 0;			

		-- Unflag any Assignments as being deleted
		update Assignment 
		set AS_HasChanged = 0, 			
		AS_LinkKey = null 
		from Assignment 
		inner join Task on Task.PR_Code = @Project 
		and Task.PPC_Version = @Version and Task.TA_Key = Assignment.TA_Key		
		
    
end
GO
GRANT EXECUTE
	ON [dbo].[kipRollbackTaskPlan]
	TO [V6N14816rwZf]
GO
