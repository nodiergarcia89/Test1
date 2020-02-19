SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectTypePermissions] (
		[PTP_Key]                     [int] IDENTITY(1, 1) NOT NULL,
		[WF_Key]                      [int] NOT NULL,
		[WFSM_Key]                    [int] NOT NULL,
		[PT_Key]                      [int] NOT NULL,
		[PTP_Name]                    [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PTP_Description]             [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PTP_Active]                  [smallint] NOT NULL,
		[PTP_ApproveByAll]            [smallint] NOT NULL,
		[PTP_NotifyApprovers]         [smallint] NULL,
		[RE_Code1]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code2]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code3]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code4]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code5]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code6]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code7]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code8]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code9]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code10]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PTP_CanComment]              [smallint] NULL,
		[PTP_CommentRequired]         [smallint] NULL,
		[PTP_PartialApprovalText]     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PTP_LastEdit]                [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PTP_LastEditDate]            [float] NOT NULL,
		[PTP_EntityType]              [smallint] NULL,
		[PTP_LastEditUser]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectT__92A2AF140251D783]
		PRIMARY KEY
		CLUSTERED
		([PTP_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectTypePermissions]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__WF_Ke__1CD22006]
	FOREIGN KEY ([WF_Key]) REFERENCES [dbo].[Workflow] ([WF_Key])
ALTER TABLE [dbo].[ProjectTypePermissions]
	CHECK CONSTRAINT [FK__ProjectTy__WF_Ke__1CD22006]

GO
ALTER TABLE [dbo].[ProjectTypePermissions]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__WFSM___1DC6443F]
	FOREIGN KEY ([WFSM_Key]) REFERENCES [dbo].[WorkflowStatusMovement] ([WFSM_Key])
ALTER TABLE [dbo].[ProjectTypePermissions]
	CHECK CONSTRAINT [FK__ProjectTy__WFSM___1DC6443F]

GO
ALTER TABLE [dbo].[ProjectTypePermissions]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__PT_Ke__1EBA6878]
	FOREIGN KEY ([PT_Key]) REFERENCES [dbo].[ProjectType] ([PT_Key])
ALTER TABLE [dbo].[ProjectTypePermissions]
	CHECK CONSTRAINT [FK__ProjectTy__PT_Ke__1EBA6878]

GO
ALTER TABLE [dbo].[ProjectTypePermissions] SET (LOCK_ESCALATION = TABLE)
GO
