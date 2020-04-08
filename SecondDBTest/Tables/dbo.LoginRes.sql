SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginRes] (
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LR_ViewTs]              [smallint] NULL,
		[LR_MainTs]              [smallint] NULL,
		[LR_ApprTs]              [smallint] NULL,
		[LR_ViewExp]             [smallint] NULL,
		[LR_MainExp]             [smallint] NULL,
		[LR_ApprExp]             [smallint] NULL,
		[LR_PayExp]              [smallint] NULL,
		[LR_ViewSch]             [smallint] NULL,
		[LR_MainSch]             [smallint] NULL,
		[LR_ViewSet]             [smallint] NULL,
		[LR_MainSet]             [smallint] NULL,
		[LR_ViewAct]             [smallint] NULL,
		[LR_MainAct]             [smallint] NULL,
		[LR_ViewRisk]            [smallint] NULL,
		[LR_MainRisk]            [smallint] NULL,
		[LR_ViewCtr]             [smallint] NULL,
		[LR_PropSkill]           [smallint] NULL,
		[LR_ApprSkill]           [smallint] NULL,
		[LR_DirectMaintain]      [smallint] NULL,
		[LR_ViewDeliverable]     [smallint] NULL,
		[LR_MainDeliverable]     [smallint] NULL,
		[LR_ViewSupply]          [smallint] NULL,
		[LR_ViewDeployment]      [smallint] NULL,
		[LR_MainDeployment]      [smallint] NULL,
		CONSTRAINT [PK__LoginRes__F0FCF9E20E8E2250]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [RE_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginRes]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginRes__RE_Cod__066DDD9B]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[LoginRes]
	CHECK CONSTRAINT [FK__LoginRes__RE_Cod__066DDD9B]

GO
ALTER TABLE [dbo].[LoginRes]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginRes__US_Cod__076201D4]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginRes]
	CHECK CONSTRAINT [FK__LoginRes__US_Cod__076201D4]

GO
CREATE NONCLUSTERED INDEX [LR_ResIndex]
	ON [dbo].[LoginRes] ([RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoginRes] SET (LOCK_ESCALATION = TABLE)
GO
