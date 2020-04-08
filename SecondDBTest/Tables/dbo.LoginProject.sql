SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginProject] (
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LP_ViewTs]              [smallint] NULL,
		[LP_MainTs]              [smallint] NULL,
		[LP_ApprTs]              [smallint] NULL,
		[LP_ViewExp]             [smallint] NULL,
		[LP_MainExp]             [smallint] NULL,
		[LP_ApprExp]             [smallint] NULL,
		[LP_ViewSch]             [smallint] NULL,
		[LP_MainSch]             [smallint] NULL,
		[LP_ViewBud]             [smallint] NULL,
		[LP_MainBud]             [smallint] NULL,
		[LP_ViewSet]             [smallint] NULL,
		[LP_MainSet]             [smallint] NULL,
		[LP_ViewRisk]            [smallint] NULL,
		[LP_MainRisk]            [smallint] NULL,
		[LP_ViewPrjBudPln]       [smallint] NULL,
		[LP_MainPrjBudPln]       [smallint] NULL,
		[LP_DirectMaintain]      [smallint] NULL,
		[LP_ViewDeliverable]     [smallint] NULL,
		[LP_MainDeliverable]     [smallint] NULL,
		[LP_ViewSupply]          [smallint] NULL,
		[LP_AccessCB]            [smallint] NULL,
		[LP_ViewAct]             [smallint] NULL,
		[LP_MainAct]             [smallint] NULL,
		CONSTRAINT [PK__LoginPro__88C52F670ABD916C]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginProject]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginProj__PR_Co__04859529]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[LoginProject]
	CHECK CONSTRAINT [FK__LoginProj__PR_Co__04859529]

GO
ALTER TABLE [dbo].[LoginProject]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginProj__US_Co__0579B962]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginProject]
	CHECK CONSTRAINT [FK__LoginProj__US_Co__0579B962]

GO
CREATE NONCLUSTERED INDEX [LP_ProjIndex]
	ON [dbo].[LoginProject] ([PR_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoginProject] SET (LOCK_ESCALATION = TABLE)
GO
