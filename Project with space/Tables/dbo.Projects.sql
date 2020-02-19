SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Projects] (
		[PR_Code]                                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Desc]                                         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Chrg]                                         [smallint] NULL,
		[CL_Code]                                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_UsePRChrg]                                    [smallint] NULL,
		[CH_Code]                                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Master]                                       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLV_Level]                                       [int] NULL,
		[LO_Code]                                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LH_Code]                                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_DirectProfile]                                [smallint] NULL,
		[PR_FixedPrice]                                   [smallint] NULL,
		[PR_TotalCharge]                                  [float] NULL,
		[PR_InvoicedSoFar]                                [float] NULL,
		[PR_AmountToInvoice]                              [float] NULL,
		[PR_LastImport]                                   [float] NULL,
		[PR_ImportSource]                                 [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_ImportedBy]                                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Start]                                        [float] NULL,
		[PR_End]                                          [float] NULL,
		[PR_RestrictDates]                                [smallint] NULL,
		[PR_PComplete]                                    [int] NULL,
		[PR_Status1]                                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Status2]                                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Status3]                                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_AllRes]                                       [smallint] NULL,
		[PR_AllAct]                                       [smallint] NULL,
		[PR_AllType]                                      [smallint] NULL,
		[PR_AllSecurityGroups]                            [smallint] NULL,
		[PR_Linked]                                       [smallint] NULL,
		[PR_UseTasks]                                     [smallint] NULL,
		[PR_TrackTaskType]                                [smallint] NULL,
		[PR_RollingWindow]                                [smallint] NULL,
		[PR_RollingWindowWeeks]                           [int] NULL,
		[PR_RequireTask]                                  [smallint] NULL,
		[Active]                                          [smallint] NULL,
		[PR_Notes]                                        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Confidence]                                   [float] NULL,
		[PR_DailyCharge]                                  [float] NULL,
		[PR_DailyCost]                                    [float] NULL,
		[PR_Info]                                         [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_PlanningOnly]                                 [smallint] NULL,
		[PR_OpenPlanForScheduling]                        [smallint] NULL,
		[PR_StartYear]                                    [int] NULL,
		[PR_EndYear]                                      [int] NULL,
		[PR_UseMstones]                                   [smallint] NULL,
		[PR_RollingWindowMstones]                         [smallint] NULL,
		[PR_RollingWindowMonthsMstones]                   [int] NULL,
		[PR_RequireMstone]                                [int] NULL,
		[PR_UseAssignments]                               [smallint] NULL,
		[PR_RequireAssignment]                            [smallint] NULL,
		[PR_RollingWindowAssignment]                      [smallint] NULL,
		[PR_RollingWindowAssignWeeks]                     [int] NULL,
		[PR_UseAssignmentPercentage]                      [smallint] NULL,
		[PR_DirectScheduling]                             [smallint] NULL,
		[PR_EditBy]                                       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_EditOn]                                       [float] NULL,
		[PR_EditOverwriteBy]                              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_AllowCPA]                                     [int] NULL,
		[PR_LastEdit]                                     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_LastEditDate]                                 [float] NULL,
		[RE_CodeProjectManager]                           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_CodeProjectSponsor]                           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_IsTemplate]                                   [smallint] NULL,
		[PR_AssignmentPeriodRestriction]                  [smallint] NULL,
		[PR_DirectSchedulingTaskDesc]                     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_AutoNum]                                      [int] NULL,
		[US_Code]                                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_TemplateCreateContract]                       [smallint] NULL,
		[PR_TemplateCreateTeam]                           [smallint] NULL,
		[PR_TemplateScheduleRes]                          [smallint] NULL,
		[PR_TemplateCopyForecast]                         [smallint] NULL,
		[PR_TemplateCopyDeliverables]                     [smallint] NULL,
		[PR_TemplateCopyRisks]                            [smallint] NULL,
		[PR_TemplateCopyTasks]                            [smallint] NULL,
		[PR_PlanningMode]                                 [smallint] NULL,
		[PR_AllowPostComments]                            [smallint] NULL,
		[DE_Code]                                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_BusinessAsUsual]                              [smallint] NULL,
		[PR_AssignmentsAffectStrategicPlanningDemand]     [smallint] NULL,
		[CC_Code]                                         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLF_Code]                                        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFS_Key]                                        [int] NULL,
		[PR_AutoCompleteTask]                             [smallint] NULL,
		[PR_RecordTimeAgainstCompleteTasks]               [smallint] NULL,
		[PR_RecordTimeAgainstCompleteAssignments]         [smallint] NULL,
		[PR_IsProductive]                                 [smallint] NULL,
		[PR_ApprovedStartDate]                            [float] NULL,
		[WF_Key]                                          [int] NULL,
		[WFS_Key]                                         [int] NULL,
		[WFS_SubStatusKey]                                [int] NULL,
		[PT_Key]                                          [int] NULL,
		[RE_CodeProjectOwner]                             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_VstsEpic]                                     [int] NULL,
		[PR_WorkflowPriority]                             [int] NULL,
		CONSTRAINT [PK__Projects__8AF2607F6521F869]
		PRIMARY KEY
		CLUSTERED
		([PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__WF_Key__1FAE8CB1]
	FOREIGN KEY ([WF_Key]) REFERENCES [dbo].[Workflow] ([WF_Key])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__WF_Key__1FAE8CB1]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__WFS_Ke__20A2B0EA]
	FOREIGN KEY ([WFS_Key]) REFERENCES [dbo].[WorkflowStatus] ([WFS_Key])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__WFS_Ke__20A2B0EA]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__WFS_Su__2196D523]
	FOREIGN KEY ([WFS_SubStatusKey]) REFERENCES [dbo].[WorkflowStatus] ([WFS_Key])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__WFS_Su__2196D523]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__PT_Key__228AF95C]
	FOREIGN KEY ([PT_Key]) REFERENCES [dbo].[ProjectType] ([PT_Key])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__PT_Key__228AF95C]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__RE_Cod__237F1D95]
	FOREIGN KEY ([RE_CodeProjectOwner]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__RE_Cod__237F1D95]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__CC_Cod__5B4E756C]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__CC_Cod__5B4E756C]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__CH_Cod__5C4299A5]
	FOREIGN KEY ([CH_Code]) REFERENCES [dbo].[Charge] ([CH_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__CH_Cod__5C4299A5]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__CL_Cod__5D36BDDE]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__CL_Cod__5D36BDDE]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__DE_Cod__5E2AE217]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__DE_Cod__5E2AE217]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__LH_Cod__5F1F0650]
	FOREIGN KEY ([LH_Code]) REFERENCES [dbo].[LocaleHeader] ([LH_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__LH_Cod__5F1F0650]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__LO_Cod__60132A89]
	FOREIGN KEY ([LO_Code]) REFERENCES [dbo].[Location] ([LO_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__LO_Cod__60132A89]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__PLF_Co__61074EC2]
	FOREIGN KEY ([PLF_Code]) REFERENCES [dbo].[ProjectLifecycle] ([PLF_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__PLF_Co__61074EC2]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__PLFS_K__61FB72FB]
	FOREIGN KEY ([PLFS_Key]) REFERENCES [dbo].[ProjectLifecycleStage] ([PLFS_Key])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__PLFS_K__61FB72FB]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__PLV_Le__62EF9734]
	FOREIGN KEY ([PLV_Level]) REFERENCES [dbo].[ProjectLevel] ([PLV_Level])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__PLV_Le__62EF9734]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__PR_Mas__63E3BB6D]
	FOREIGN KEY ([PR_Master]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__PR_Mas__63E3BB6D]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__RE_Cod__64D7DFA6]
	FOREIGN KEY ([RE_CodeProjectManager]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__RE_Cod__64D7DFA6]

GO
ALTER TABLE [dbo].[Projects]
	WITH CHECK
	ADD CONSTRAINT [FK__Projects__RE_Cod__65CC03DF]
	FOREIGN KEY ([RE_CodeProjectSponsor]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Projects]
	CHECK CONSTRAINT [FK__Projects__RE_Cod__65CC03DF]

GO
CREATE NONCLUSTERED INDEX [IDX_PR_DescIndex]
	ON [dbo].[Projects] ([PR_Desc])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [PR_Client]
	ON [dbo].[Projects] ([CL_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Projects] SET (LOCK_ESCALATION = TABLE)
GO
