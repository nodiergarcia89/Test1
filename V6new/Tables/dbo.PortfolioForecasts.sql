SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortfolioForecasts] (
		[PFO_Key]                 [int] IDENTITY(1, 1) NOT NULL,
		[PFL_Key]                 [int] NULL,
		[PPR_Key]                 [int] NOT NULL,
		[PFO_ProfileKey]          [int] NOT NULL,
		[PFO_ProfileName]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PFO_ProfileStatus]       [int] NOT NULL,
		[PFO_ProfileBaseline]     [smallint] NOT NULL,
		CONSTRAINT [PK__Portfoli__40995F22E3C1B829]
		PRIMARY KEY
		CLUSTERED
		([PFO_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PortfolioForecasts]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PFL_K__52A420D2]
	FOREIGN KEY ([PFL_Key]) REFERENCES [dbo].[Portfolio] ([PFL_Key])
ALTER TABLE [dbo].[PortfolioForecasts]
	CHECK CONSTRAINT [FK__Portfolio__PFL_K__52A420D2]

GO
ALTER TABLE [dbo].[PortfolioForecasts]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PPR_K__5398450B]
	FOREIGN KEY ([PPR_Key]) REFERENCES [dbo].[PortfolioProjects] ([PPR_Key])
ALTER TABLE [dbo].[PortfolioForecasts]
	CHECK CONSTRAINT [FK__Portfolio__PPR_K__5398450B]

GO
CREATE UNIQUE NONCLUSTERED INDEX [PPO_ProfileScenarioForecast]
	ON [dbo].[PortfolioForecasts] ([PFL_Key], [PFO_ProfileKey])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[PortfolioForecasts] SET (LOCK_ESCALATION = TABLE)
GO
