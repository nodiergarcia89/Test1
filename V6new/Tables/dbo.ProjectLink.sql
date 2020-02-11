SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectLink] (
		[PR_Code]                            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PL_ProjectPlan]                     [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PL_ProjectPlanCreated]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PL_AppName]                         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PL_Version]                         [int] NOT NULL,
		[PL_LinkCreated]                     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PL_MapRes]                          [smallint] NOT NULL,
		[PL_ManMapRes]                       [smallint] NOT NULL,
		[PL_ResLastValidated]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PL_TransferTasks]                   [smallint] NOT NULL,
		[PL_IncMilestoneTasks]               [smallint] NOT NULL,
		[PL_TasksLastTransfered]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PL_DownloadActuals]                 [smallint] NOT NULL,
		[PL_AdjustPlan]                      [smallint] NOT NULL,
		[PL_CreateABSTask]                   [smallint] NOT NULL,
		[PL_ActualsLastDownloaded]           [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PL_DownloadApprovedActualsOnly]     [smallint] NULL,
		[PL_TempProjectPlan]                 [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PL_TransferIntoCV]                  [smallint] NULL,
		[PL_TransferDemand]                  [smallint] NULL,
		[PL_TransferSupply]                  [smallint] NULL,
		[PL_ProfileVersion]                  [smallint] NULL,
		[PL_TransferMilestones]              [smallint] NULL,
		[PL_ConfirmMilestones]               [smallint] NULL,
		[PL_ManualMilestoneReason]           [smallint] NULL,
		[PL_OpenPlanForScheduling]           [smallint] NULL,
		[PL_Template]                        [smallint] NULL,
		CONSTRAINT [PK__ProjectL__8AF2607F4A6E022D]
		PRIMARY KEY
		CLUSTERED
		([PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectLink]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectLi__PR_Co__53AD53A4]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectLink]
	CHECK CONSTRAINT [FK__ProjectLi__PR_Co__53AD53A4]

GO
ALTER TABLE [dbo].[ProjectLink] SET (LOCK_ESCALATION = TABLE)
GO
