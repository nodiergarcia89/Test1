SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectSnapshotProjects] (
		[PSSP_Key]                  [int] IDENTITY(1, 1) NOT NULL,
		[PSS_Key]                   [int] NOT NULL,
		[PR_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Desc]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Active]                 [smallint] NULL,
		[PR_Chrg]                   [smallint] NULL,
		[PR_Start]                  [float] NULL,
		[PR_End]                    [float] NULL,
		[RE_CodeProjectManager]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_DescProjectManager]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_CodeProjectSponsor]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_DescProjectSponsor]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLF_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLF_Desc]                  [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFS_Key]                  [int] NULL,
		[PLFS_Desc]                 [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_CodeMaster]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_DescMaster]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CL_Desc]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Desc]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PT_Key]                    [int] NULL,
		[PR_VstsEpic]               [int] NULL,
		[PR_WorkflowPriority]       [int] NULL,
		[WFS_Key]                   [int] NULL,
		[WFS_Name]                  [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WF_Key]                    [int] NULL,
		[WF_Name]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WFS_SubStatusKey]          [int] NULL,
		[WFS_SubStatusDesc]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_CodeProjectOwner]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_DescProjectOwner]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CC_Desc]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LO_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LO_Desc]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectS__2E3FE254D1D4DC5A]
		PRIMARY KEY
		CLUSTERED
		([PSSP_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PSS_K__42F7C8EE]
	FOREIGN KEY ([PSS_Key]) REFERENCES [dbo].[ProjectSnapshots] ([PSS_Key])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__PSS_K__42F7C8EE]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PR_Co__43EBED27]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__PR_Co__43EBED27]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__RE_Co__44E01160]
	FOREIGN KEY ([RE_CodeProjectManager]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__RE_Co__44E01160]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__RE_Co__45D43599]
	FOREIGN KEY ([RE_CodeProjectSponsor]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__RE_Co__45D43599]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PLF_C__46C859D2]
	FOREIGN KEY ([PLF_Code]) REFERENCES [dbo].[ProjectLifecycle] ([PLF_Code])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__PLF_C__46C859D2]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PLFS___47BC7E0B]
	FOREIGN KEY ([PLFS_Key]) REFERENCES [dbo].[ProjectLifecycleStage] ([PLFS_Key])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__PLFS___47BC7E0B]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PR_Co__48B0A244]
	FOREIGN KEY ([PR_CodeMaster]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__PR_Co__48B0A244]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__CL_Co__49A4C67D]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__CL_Co__49A4C67D]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__DE_Co__4A98EAB6]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[ProjectSnapshotProjects]
	CHECK CONSTRAINT [FK__ProjectSn__DE_Co__4A98EAB6]

GO
ALTER TABLE [dbo].[ProjectSnapshotProjects] SET (LOCK_ESCALATION = TABLE)
GO
