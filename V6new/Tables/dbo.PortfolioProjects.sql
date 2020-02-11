SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortfolioProjects] (
		[PPR_Key]                          [int] IDENTITY(1, 1) NOT NULL,
		[PFL_Key]                          [int] NOT NULL,
		[PR_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PPR_ProjectLifeCycleCode]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PPR_ProjectLifeCycleName]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PPR_ProjectLifeCycleStageKey]     [int] NULL,
		[PPR_ProjectLifeCycleStage]        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PPR_ProjectManagerCode]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PPR_ProjectSponsorCode]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PPR_ProjectStartDate]             [float] NULL,
		[PPR_ProjectProposedStartDate]     [float] NULL,
		[PPR_ProjectEndDate]               [float] NULL,
		[PPR_Active]                       [smallint] NOT NULL,
		CONSTRAINT [PK__Portfoli__C7B16540A8D284C1]
		PRIMARY KEY
		CLUSTERED
		([PPR_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PortfolioProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PFL_K__4CEB477C]
	FOREIGN KEY ([PFL_Key]) REFERENCES [dbo].[Portfolio] ([PFL_Key])
ALTER TABLE [dbo].[PortfolioProjects]
	CHECK CONSTRAINT [FK__Portfolio__PFL_K__4CEB477C]

GO
ALTER TABLE [dbo].[PortfolioProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PR_Co__4DDF6BB5]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[PortfolioProjects]
	CHECK CONSTRAINT [FK__Portfolio__PR_Co__4DDF6BB5]

GO
ALTER TABLE [dbo].[PortfolioProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PPR_P__4ED38FEE]
	FOREIGN KEY ([PPR_ProjectManagerCode]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[PortfolioProjects]
	CHECK CONSTRAINT [FK__Portfolio__PPR_P__4ED38FEE]

GO
ALTER TABLE [dbo].[PortfolioProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PPR_P__4FC7B427]
	FOREIGN KEY ([PPR_ProjectSponsorCode]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[PortfolioProjects]
	CHECK CONSTRAINT [FK__Portfolio__PPR_P__4FC7B427]

GO
CREATE UNIQUE NONCLUSTERED INDEX [PPO_PortfolioProjects]
	ON [dbo].[PortfolioProjects] ([PFL_Key], [PR_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[PortfolioProjects] SET (LOCK_ESCALATION = TABLE)
GO
