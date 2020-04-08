SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskPlanExport] (
		[TPE_Key]                     [int] IDENTITY(1, 1) NOT NULL,
		[PR_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PPC_Version]                 [int] NOT NULL,
		[TPE_IsComplete]              [bit] NOT NULL,
		[TPE_IsProcessing]            [bit] NOT NULL,
		[TPE_Failed]                  [bit] NOT NULL,
		[TPE_Recipients]              [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TPE_DateExported]            [float] NULL,
		[TPE_ExportedBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TPE_ExportTasks]             [bit] NOT NULL,
		[TPE_ExportAssignments]       [bit] NOT NULL,
		[TPE_ExportResourceRoles]     [bit] NOT NULL,
		[TPE_FileName]                [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DH_Key]                      [int] NULL,
		CONSTRAINT [PK__TaskPlan__F2374E17C2C4F9BD]
		PRIMARY KEY
		CLUSTERED
		([TPE_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TaskPlanExport]
	ADD
	CONSTRAINT [DF__TaskPlanE__TPE_I__59DB2E46]
	DEFAULT ((0)) FOR [TPE_IsComplete]
GO
ALTER TABLE [dbo].[TaskPlanExport]
	ADD
	CONSTRAINT [DF__TaskPlanE__TPE_I__5ACF527F]
	DEFAULT ((0)) FOR [TPE_IsProcessing]
GO
ALTER TABLE [dbo].[TaskPlanExport]
	ADD
	CONSTRAINT [DF__TaskPlanE__TPE_F__5BC376B8]
	DEFAULT ((0)) FOR [TPE_Failed]
GO
ALTER TABLE [dbo].[TaskPlanExport]
	ADD
	CONSTRAINT [DF__TaskPlanE__TPE_E__5CB79AF1]
	DEFAULT ((0)) FOR [TPE_ExportTasks]
GO
ALTER TABLE [dbo].[TaskPlanExport]
	ADD
	CONSTRAINT [DF__TaskPlanE__TPE_E__5DABBF2A]
	DEFAULT ((0)) FOR [TPE_ExportAssignments]
GO
ALTER TABLE [dbo].[TaskPlanExport]
	ADD
	CONSTRAINT [DF__TaskPlanE__TPE_E__5E9FE363]
	DEFAULT ((0)) FOR [TPE_ExportResourceRoles]
GO
ALTER TABLE [dbo].[TaskPlanExport]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskPlanE__PR_Co__58E70A0D]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[TaskPlanExport]
	CHECK CONSTRAINT [FK__TaskPlanE__PR_Co__58E70A0D]

GO
ALTER TABLE [dbo].[TaskPlanExport]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskPlanE__DH_Ke__5F94079C]
	FOREIGN KEY ([DH_Key]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[TaskPlanExport]
	CHECK CONSTRAINT [FK__TaskPlanE__DH_Ke__5F94079C]

GO
ALTER TABLE [dbo].[TaskPlanExport] SET (LOCK_ESCALATION = TABLE)
GO
