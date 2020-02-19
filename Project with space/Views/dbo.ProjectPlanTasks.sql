SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO
--SC4e

--SC5s
CREATE VIEW [dbo].[ProjectPlanTasks]
AS
select 
TA_Key AS TA_Key, 
PR_Code AS PR_Code, 
TA_Desc AS TA_Desc,
AC_Code AS AC_Code,
MS_Key AS MS_Key,
TA_StartDate AS TA_StartDate,
TA_StartTime AS TA_StartTime,
TA_EndDate AS TA_EndDate,
TA_EndTime AS TA_EndTime,
TA_AnchoredStart AS TA_AnchoredStart,
TA_AnchoredEnd AS TA_AnchoredEnd,
TA_Work AS TA_Work,
TA_PercentComplete AS TA_PercentComplete,
TA_ActualWork AS TA_ActualWork,
TA_ActualWorkRollup AS TA_ActualWorkRollup,
TA_MinimumResources AS TA_MinimumResources,
TA_Status AS TA_Status,
TA_Milestone AS TA_Milestone,
TA_EstimateWork AS TA_EstimateWork,
TA_EstimateEndDate AS TA_EstimateEndDate,
TA_EstimateChangedOn AS TA_EstimateChangedOn,
TA_EstimateChangedBy AS TA_EstimateChangedBy,
TA_Imported AS TA_Imported,
TA_PlanUniqueID AS TA_PlanUniqueID,
TA_Active AS TA_Active,
TA_SystemFlag AS TA_SystemFlag,
TA_ID AS TA_ID,
TA_Empty AS TA_Empty,
TA_Summary AS TA_Summary,
TA_OutlineLevel AS TA_OutlineLevel,
TA_OutlineNumber AS TA_OutlineNumber,
TA_WBS AS TA_WBS,
TA_ConstraintType AS TA_ConstraintType,
TA_ConstraintDate AS TA_ConstraintDate,
US_Code AS US_Code,
TA_LastEditDate AS TA_LastEditDate,
TA_LastEdit AS TA_LastEdit,
TA_Null AS TA_Null,
TA_KeyPublished AS TA_KeyPublished,
PPC_Version AS PPC_Version,
TA_DeadlineDate AS TA_DeadlineDate,
TA_AllocatedWork AS TA_AllocatedWork,
RE_CodeRole AS RE_CodeRole,
TA_CompleteDate AS TA_CompleteDate,
TA_SynchWithJIRA AS TA_SynchWithJIRA,
TA_LinkKey AS TA_LinkKey,
TA_HasChanged AS TA_HasChanged,
TA_PreviousID AS TA_PreviousID,
TA_Protected AS TA_Protected 
from dbo.Task 
where TA_HasChanged <> 4 
AND TA_LinkKey IS NULL -- Not a WIP
AND TA_SystemFlag in (0,7) -- Draft / Published (Not a WIP)
AND TA_Key NOT IN (SELECT TA_LinkKey From dbo.Task where TA_LinkKey IS NOT NULL AND TA_SystemFlag = 15 ) -- The Task does not have an associated WIP Task

UNION ALL

select 
TA_Key AS TA_Key, 
PR_Code AS PR_Code, 
TA_Desc AS TA_Desc,
AC_Code AS AC_Code,
MS_Key AS MS_Key,
TA_StartDate AS TA_StartDate,
TA_StartTime AS TA_StartTime,
TA_EndDate AS TA_EndDate,
TA_EndTime AS TA_EndTime,
TA_AnchoredStart AS TA_AnchoredStart,
TA_AnchoredEnd AS TA_AnchoredEnd,
TA_Work AS TA_Work,
TA_PercentComplete AS TA_PercentComplete,
TA_ActualWork AS TA_ActualWork,
TA_ActualWorkRollup AS TA_ActualWorkRollup,
TA_MinimumResources AS TA_MinimumResources,
TA_Status AS TA_Status,
TA_Milestone AS TA_Milestone,
TA_EstimateWork AS TA_EstimateWork,
TA_EstimateEndDate AS TA_EstimateEndDate,
TA_EstimateChangedOn AS TA_EstimateChangedOn,
TA_EstimateChangedBy AS TA_EstimateChangedBy,
TA_Imported AS TA_Imported,
TA_PlanUniqueID AS TA_PlanUniqueID,
TA_Active AS TA_Active,
TA_SystemFlag AS TA_SystemFlag,
TA_ID AS TA_ID,
TA_Empty AS TA_Empty,
TA_Summary AS TA_Summary,
TA_OutlineLevel AS TA_OutlineLevel,
TA_OutlineNumber AS TA_OutlineNumber,
TA_WBS AS TA_WBS,
TA_ConstraintType AS TA_ConstraintType,
TA_ConstraintDate AS TA_ConstraintDate,
US_Code AS US_Code,
TA_LastEditDate AS TA_LastEditDate,
TA_LastEdit AS TA_LastEdit,
TA_Null AS TA_Null,
TA_KeyPublished AS TA_KeyPublished,
PPC_Version AS PPC_Version,
TA_DeadlineDate AS TA_DeadlineDate,
TA_AllocatedWork AS TA_AllocatedWork,
RE_CodeRole AS RE_CodeRole,
TA_CompleteDate AS TA_CompleteDate,
TA_SynchWithJIRA AS TA_SynchWithJIRA,
TA_LinkKey AS TA_LinkKey,
TA_HasChanged AS TA_HasChanged,
TA_PreviousID AS TA_PreviousID,
TA_Protected AS TA_Protected 
from dbo.Task 
where TA_SystemFlag = 15

GO
