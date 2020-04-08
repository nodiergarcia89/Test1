SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
GO

create view WorkflowPermissionsProject
as
select        dbo.ProjectTypePermissions.PTP_Key, dbo.ProjectTypePermissions.WFSM_Key, dbo.ProjectTypePermissions.PTP_ApproveByAll, 
            CASE ProjectTypePermissions.RE_Code1 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code1 END AS RE_Code1, 
		  CASE ProjectTypePermissions.RE_Code2 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code2 END AS RE_Code2, 
		  CASE ProjectTypePermissions.RE_Code3 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code3 END AS RE_Code3, 
		  CASE ProjectTypePermissions.RE_Code4 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code4 END AS RE_Code4, 
		  CASE ProjectTypePermissions.RE_Code5 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code5 END AS RE_Code5, 
		  CASE ProjectTypePermissions.RE_Code6 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code6 END AS RE_Code6, 
		  CASE ProjectTypePermissions.RE_Code7 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code7 END AS RE_Code7, 
		  CASE ProjectTypePermissions.RE_Code8 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code8 END AS RE_Code8, 
		  CASE ProjectTypePermissions.RE_Code9 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code9 END AS RE_Code9, 
		  CASE ProjectTypePermissions.RE_Code10 WHEN '#MANAGER#' THEN Projects.RE_CodeProjectManager WHEN '#SPONSOR#' THEN Projects.RE_CodeProjectSponsor WHEN '#DEPARTMENTMANAGER#' THEN Departments.RE_CodeManager WHEN '#OWNER#' THEN Projects.RE_CodeProjectOwner ELSE ProjectTypePermissions.RE_Code10 END AS RE_Code10, 
		  dbo.Projects.PR_Code
from            dbo.ProjectTypePermissions INNER JOIN
                         dbo.Projects ON dbo.Projects.PT_Key = dbo.ProjectTypePermissions.PT_Key LEFT OUTER JOIN
                         dbo.Departments ON dbo.Departments.DE_Code = dbo.Projects.DE_Code;

GO
GRANT SELECT
	ON [dbo].[WorkflowPermissionsProject]
	TO [V6N14816rwZf]
GO
