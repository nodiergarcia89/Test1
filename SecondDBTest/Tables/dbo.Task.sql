SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Task] (
		[TA_Key]                   [int] IDENTITY(1, 1) NOT NULL,
		[PR_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TA_Desc]                  [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AC_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[MS_Key]                   [int] NULL,
		[TA_StartDate]             [float] NULL,
		[TA_StartTime]             [float] NULL,
		[TA_EndDate]               [float] NULL,
		[TA_EndTime]               [float] NULL,
		[TA_AnchoredStart]         [smallint] NULL,
		[TA_AnchoredEnd]           [smallint] NULL,
		[TA_Work]                  [float] NULL,
		[TA_PercentComplete]       [float] NULL,
		[TA_ActualWork]            [float] NULL,
		[TA_ActualWorkRollup]      [float] NULL,
		[TA_MinimumResources]      [float] NULL,
		[TA_Status]                [smallint] NULL,
		[TA_Milestone]             [smallint] NULL,
		[TA_EstimateWork]          [float] NULL,
		[TA_EstimateEndDate]       [float] NULL,
		[TA_EstimateChangedOn]     [float] NULL,
		[TA_EstimateChangedBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_Imported]              [smallint] NULL,
		[TA_PlanUniqueID]          [int] NULL,
		[TA_Active]                [smallint] NULL,
		[TA_SystemFlag]            [smallint] NULL,
		[TA_ID]                    [int] NULL,
		[TA_Empty]                 [int] NULL,
		[TA_Summary]               [int] NULL,
		[TA_OutlineLevel]          [int] NULL,
		[TA_OutlineNumber]         [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_WBS]                   [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_ConstraintType]        [smallint] NULL,
		[TA_ConstraintDate]        [float] NULL,
		[US_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TA_LastEditDate]          [float] NULL,
		[TA_LastEdit]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_Null]                  [smallint] NULL,
		[TA_KeyPublished]          [int] NULL,
		[PPC_Version]              [int] NULL,
		[TA_DeadlineDate]          [float] NULL,
		[TA_AllocatedWork]         [float] NULL,
		[RE_CodeRole]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TA_CompleteDate]          [float] NULL,
		[TA_SynchWithJIRA]         [smallint] NOT NULL,
		[TA_LinkKey]               [int] NULL,
		[TA_HasChanged]            [smallint] NULL,
		[TA_PreviousID]            [int] NULL,
		[TA_Index]                 [int] NULL,
		[TA_Duration]              [float] NULL,
		[TA_Protected]             [smallint] NOT NULL,
		CONSTRAINT [PK__Task__CBEBD6010BD1B136]
		PRIMARY KEY
		CLUSTERED
		([TA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Task]
	ADD
	CONSTRAINT [DF__Task__TA_SynchWi__0DB9F9A8]
	DEFAULT ((0)) FOR [TA_SynchWithJIRA]
GO
ALTER TABLE [dbo].[Task]
	ADD
	CONSTRAINT [DF__Task__TA_HasChan__4BC21919]
	DEFAULT ((0)) FOR [TA_HasChanged]
GO
ALTER TABLE [dbo].[Task]
	ADD
	CONSTRAINT [DF__Task__TA_Protect__617C500E]
	DEFAULT ((0)) FOR [TA_Protected]
GO
ALTER TABLE [dbo].[Task]
	WITH CHECK
	ADD CONSTRAINT [FK__Task__AC_Code__63AEB143]
	FOREIGN KEY ([AC_Code]) REFERENCES [dbo].[Activity] ([AC_Code])
ALTER TABLE [dbo].[Task]
	CHECK CONSTRAINT [FK__Task__AC_Code__63AEB143]

GO
ALTER TABLE [dbo].[Task]
	WITH CHECK
	ADD CONSTRAINT [FK__Task__MS_Key__64A2D57C]
	FOREIGN KEY ([MS_Key]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[Task]
	CHECK CONSTRAINT [FK__Task__MS_Key__64A2D57C]

GO
ALTER TABLE [dbo].[Task]
	WITH CHECK
	ADD CONSTRAINT [FK__Task__PR_Code__6596F9B5]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Task]
	CHECK CONSTRAINT [FK__Task__PR_Code__6596F9B5]

GO
ALTER TABLE [dbo].[Task]
	WITH CHECK
	ADD CONSTRAINT [FK__Task__RE_CodeRol__668B1DEE]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Task]
	CHECK CONSTRAINT [FK__Task__RE_CodeRol__668B1DEE]

GO
ALTER TABLE [dbo].[Task]
	WITH CHECK
	ADD CONSTRAINT [FK__Task__TA_KeyPubl__677F4227]
	FOREIGN KEY ([TA_KeyPublished]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[Task]
	CHECK CONSTRAINT [FK__Task__TA_KeyPubl__677F4227]

GO
CREATE NONCLUSTERED INDEX [TA_MilestoneIndex]
	ON [dbo].[Task] ([MS_Key])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TA_ProjectStartDateIndex]
	ON [dbo].[Task] ([PR_Code], [TA_StartDate])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TA_StartDateProjectIndex]
	ON [dbo].[Task] ([TA_StartDate], [PR_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TA_ProjectSystemFlagIndex]
	ON [dbo].[Task] ([PR_Code], [TA_SystemFlag])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TA_ProjectVersionIndex]
	ON [dbo].[Task] ([PR_Code], [PPC_Version])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TA_TAPublishIndex]
	ON [dbo].[Task] ([TA_KeyPublished])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TA_SystemFlagLinkKey]
	ON [dbo].[Task] ([TA_SystemFlag], [TA_LinkKey])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Task] SET (LOCK_ESCALATION = TABLE)
GO
