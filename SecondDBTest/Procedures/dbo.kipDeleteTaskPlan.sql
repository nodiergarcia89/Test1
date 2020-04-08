SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
--SC1/TL2/SC6e

---------------------- [kipDeleteTaskPlan] ---------------------------------------------
--
-- Deletes the current Plan Version
--
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[kipDeleteTaskPlan]
	@Project	nvarchar(20),
	@Version	int
AS	
BEGIN
		DECLARE @DeletionTaskKeys TABLE (TAKey int PRIMARY KEY);
		DECLARE @DeletionAssignmentKeys TABLE (ASKey int PRIMARY KEY);
		DECLARE @sql nvarchar(max);
		DECLARE @Current int;

		--Generate list of task keys to delete
		INSERT INTO @DeletionTaskKeys (TAKey)
		SELECT DISTINCT TA_Key
		FROM	Task
		WHERE	PR_Code = @Project		
				AND PPC_Version = @Version;

		--Generate list of assignment keys to delete
		INSERT INTO @DeletionAssignmentKeys(ASKey)
		SELECT DISTINCT AS_Key
		FROM	@DeletionTaskKeys DT
				JOIN dbo.Assignment ASS
					on DT.TAKey = ASS.TA_Key;
		
		-- Task Custom Fields
		set @sql = '';		  
		select @sql = @sql + N'delete ' + CT_TableName + ' from	' + CT_TableName + ' join Task on ' + CT_TableName + '.TA_Key = Task.TA_Key where Task.PR_Code = @Project and Task.PPC_Version = @Version; ' from kipCustomFieldTables('Task',1040) ;
		exec sp_executesql @sql, N'@Project nvarchar(20), @Version int', @Project, @Version;    

		-- Assignment Custom Fields
		set @sql = '';
		select @sql = @sql + N'delete ' + CT_TableName + N' from ' + CT_TableName + N' join Assignment on Assignment.AS_Key = ' + CT_TableName + N'.AS_Key join Task on Assignment.TA_Key = Task.TA_Key where Task.PR_Code = @Project and Task.PPC_Version = @Version; ' from kipCustomFieldTables('Assignment',1041);
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
					and CustomFieldFreeText.CF_Key = @Current;';

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
					and CustomFieldFreeText.CF_Key = @Current;';

			  EXEC sp_executesql @sql, N'@Project NVARCHAR(20), @Version INT, @Current INT', @Project, @Version, @Current;

			  SELECT @Current = MAX(ISNULL(CF_Key,0)) FROM CustomFields WHERE (CF_DataType = 24 OR CF_DataType = 23) AND CF_CustomTableName = N'AssignmentCustomTxt' AND CF_Key < @Current
		   END;

		---- Delete AsignmentPlan
		DELETE	dbo.AssignmentPlan
		FROM	@DeletionAssignmentKeys DA
				JOIN dbo.AssignmentPlan 
					on AssignmentPlan.AS_Key =DA.ASKey;
		
		---- Update assignment published keys to null 
		UPDATE	Assignment 
		SET	Assignment.AS_KeyPublished = NULL 
		FROM	@DeletionAssignmentKeys DA
				JOIN Assignment
					on Assignment.AS_Key = DA.ASKey;	
					
		----Delete all assignments which do not map to a timesheet record 
		DELETE	Assignment 
		FROM	@DeletionAssignmentKeys DA
				JOIN Assignment ASS
					on ASS.AS_Key = DA.ASKey
		WHERE	NOT EXISTS (
								SELECT	1
								FROM	Timesht TS
								WHERE	TS.AS_Key = ASS.AS_Key
							);		
							
		---- Update remaining assignment published keys to null 
		UPDATE	Assignment 
		SET	Assignment.AS_KeyPublished = NULL 
		FROM	@DeletionAssignmentKeys DA
				JOIN Assignment
					on Assignment.AS_Key = DA.ASKey;	
			

		--Delete any assignments flagged as deleted that no longer have timesheets against them
		DELETE	Assignment
		FROM	@DeletionAssignmentKeys DA
				JOIN  Assignment 
					on DA.ASKey = Assignment.AS_Key
		WHERE	AS_Active = 1 
				AND	NOT EXISTS (
									SELECT 1 
									FROM	Timesht 
									WHERE	Timesht.AS_Key = Assignment.AS_Key
								)

		--Update all assignments that map to a timesheet record by setting AS_Active flag to 1 (deleted)
		UPDATE	ASS 
		SET	ASS.AS_Active = 1 
		FROM	@DeletionAssignmentKeys DA
				JOIN Assignment ASS
					ON DA.ASKey = ASS.AS_Key
				JOIN Timesht TS
					on DA.ASKey = TS.AS_Key

		----Update task allocated effort from assignments -- TODO: IS THIS NEEDED?
		UPDATE	dbo.Task 
		SET	TA_AllocatedWork = ISNULL(SumWork,0)  
		FROM	@DeletionTaskKeys DTK
				JOIN dbo.Task 
					on DTK.TAKey = Task.TA_Key
				LEFT JOIN ( 
								SELECT	TA_Key,  
									Sum(AS_Work) as SumWork  
								FROM	@DeletionAssignmentKeys DA
									JOIN Assignment  
										on DA.ASKey = Assignment.AS_Key
								WHERE	AS_Active = -1  
							GROUP BY TA_Key 
						) SumAssign 
			ON Task.TA_Key = SumAssign.TA_Key  			

		--Delete TaskSkill records
		DELETE	dbo.TaskSkill
		FROM	@DeletionTaskKeys dt
				JOIN dbo.TaskSkill
					on dt.TAKey = TaskSkill.TA_Key;

		--Delete TaskDependency records
		DELETE dbo.TaskDependencies
		FROM	@DeletionTaskKeys dt
				JOIN  dbo.TaskDependencies
					ON dt.TAKey = TaskDependencies.TA_KeyParent;
					
		--Delete TaskDependency records
		DELETE dbo.TaskDependencies
		FROM	@DeletionTaskKeys dt
				JOIN  dbo.TaskDependencies			
					ON dt.TAKey = TaskDependencies.TA_KeyChild;

		--Delete any attachments attached to these tasks
		DELETE	dbo.TaskDocuments
		FROM	@DeletionTaskKeys dt
				JOIN dbo.TaskDocuments
					on dt.TAKey = TaskDocuments.TA_Key;

		--Delete any contract line references attached to these tasks
		DELETE	dbo.BillingContractLineTask
		FROM	@DeletionTaskKeys DT
				JOIN dbo.BillingContractLineTask 
					on DT.TAKey = BillingContractLineTask.TA_Key;

		--Delete Post Resources
		DELETE	dbo.PostResources 
		FROM	@DeletionTaskKeys DT
				JOIN dbo.Posts 
					on Posts.TA_Key = DT.TAKey
				JOIN dbo.PostResources 
					ON Posts.PST_Key = PostResources.PST_Key;

		--Delete Post Comments
		DELETE	dbo.PostComments 
		FROM	@DeletionTaskKeys DT
				JOIN dbo.Posts 
					on DT.TAKey = Posts.TA_Key
				JOIN dbo.PostComments 
					on Posts.PST_Key = PostComments.PST_Key;

		--Delete Posts
		DELETE	dbo.Posts
		FROM	@DeletionTaskKeys DT
				JOIN dbo.Posts
					ON DT.TAKey = Posts.TA_Key;
		
		--Flag relevant Tasks as 'Deleted' (cannot actually delete Tasks that have time associated with them)
		UPDATE	Task 
		SET	Task.TA_Active = 1 
		FROM	@DeletionTaskKeys DTK
				JOIN Task
					on DTK.TAKey = Task.TA_Key
		WHERE EXISTS	( 
							SELECT	1
							FROM	@DeletionTaskKeys
							WHERE	TAKey = Task.TA_Key
						);

		--Clear Published Keys
		UPDATE	Task 
		SET		Task.TA_KeyPublished = NULL 
		FROM	@DeletionTaskKeys DTK
				JOIN Task 
					on DTK.TAKey = Task.TA_KeyPublished;

		--Delete Task records that do not have any time/assignments associated with them
		DELETE	Task
		FROM	Task	
				JOIN @DeletionTaskKeys DT
					on DT.TAKey = Task.TA_Key
		WHERE	NOT EXISTS (
								SELECT	1 
								FROM	Timesht
								WHERE	Timesht.TA_Key = DT.TAKey
								UNION 
								SELECT	1
								FROM	Assignment
								WHERE	Assignment.TA_Key = DT.TAKey
							);

		--Remove the Ordinal and Outline Numbers from deleted Tasks that have Timesheets associated with them
		UPDATE	dbo.Task 
		SET		TA_ID = NULL, 
				TA_OutlineNumber = '' 
		WHERE	TA_Active = 1
				AND PR_Code = @Project;		

		--Delete any User Expanded Task Items
		DELETE	dbo.UserProjectPlan
		WHERE	PR_Code = @Project
				AND PPC_Version = @Version;	

		--Delete Project Plan Control
		DELETE	dbo.ProjectPlanControl
		WHERE	PR_Code = @Project
				AND PPC_Version = @Version;		
END;
GO
GRANT EXECUTE
	ON [dbo].[kipDeleteTaskPlan]
	TO [V6N14816rwZf]
GO
