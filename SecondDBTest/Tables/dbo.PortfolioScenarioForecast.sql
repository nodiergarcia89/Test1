SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PortfolioScenarioForecast] (
		[PSF_Key]           [int] IDENTITY(1, 1) NOT NULL,
		[PSC_Key]           [int] NOT NULL,
		[PSF_Included]      [smallint] NOT NULL,
		[PSF_StartDate]     [float] NULL,
		[PSF_Score]         [float] NOT NULL,
		[PFO_Key]           [int] NOT NULL,
		CONSTRAINT [PK__Portfoli__7BF99597C5419D24]
		PRIMARY KEY
		CLUSTERED
		([PSF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PortfolioScenarioForecast]
	ADD
	CONSTRAINT [DF__Portfolio__PSF_I__5C2D8B0C]
	DEFAULT ((-1)) FOR [PSF_Included]
GO
ALTER TABLE [dbo].[PortfolioScenarioForecast]
	ADD
	CONSTRAINT [DF__Portfolio__PSF_S__5D21AF45]
	DEFAULT (NULL) FOR [PSF_StartDate]
GO
ALTER TABLE [dbo].[PortfolioScenarioForecast]
	ADD
	CONSTRAINT [DF__Portfolio__PSF_S__5E15D37E]
	DEFAULT ((0)) FOR [PSF_Score]
GO
ALTER TABLE [dbo].[PortfolioScenarioForecast]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PSC_K__5B3966D3]
	FOREIGN KEY ([PSC_Key]) REFERENCES [dbo].[PortfolioScenario] ([PSC_Key])
ALTER TABLE [dbo].[PortfolioScenarioForecast]
	CHECK CONSTRAINT [FK__Portfolio__PSC_K__5B3966D3]

GO
ALTER TABLE [dbo].[PortfolioScenarioForecast]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PFO_K__5F09F7B7]
	FOREIGN KEY ([PFO_Key]) REFERENCES [dbo].[PortfolioForecasts] ([PFO_Key])
ALTER TABLE [dbo].[PortfolioScenarioForecast]
	CHECK CONSTRAINT [FK__Portfolio__PFO_K__5F09F7B7]

GO
ALTER TABLE [dbo].[PortfolioScenarioForecast] SET (LOCK_ESCALATION = TABLE)
GO
