SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PortfolioForecastDemandDetail] (
		[PFDD_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[PFDL_Key]              [int] NOT NULL,
		[PP_StartDate]          [float] NOT NULL,
		[PFDD_Days]             [float] NULL,
		[PFDD_FTE]              [float] NULL,
		[PFDD_LocalCost]        [float] NULL,
		[PFDD_SystemCost]       [float] NULL,
		[PFDD_Status]           [int] NULL,
		[PFDD_LocalCharge]      [float] NULL,
		[PFDD_SystemCharge]     [float] NULL,
		CONSTRAINT [PK__Portfoli__F4D90717FFEF8E9A]
		PRIMARY KEY
		CLUSTERED
		([PFDD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PortfolioForecastDemandDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PFDL___679F3DB8]
	FOREIGN KEY ([PFDL_Key]) REFERENCES [dbo].[PortfolioForecastDemandLine] ([PFDL_Key])
ALTER TABLE [dbo].[PortfolioForecastDemandDetail]
	CHECK CONSTRAINT [FK__Portfolio__PFDL___679F3DB8]

GO
ALTER TABLE [dbo].[PortfolioForecastDemandDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PP_St__689361F1]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[PortfolioForecastDemandDetail]
	CHECK CONSTRAINT [FK__Portfolio__PP_St__689361F1]

GO
CREATE UNIQUE NONCLUSTERED INDEX [PRD_PortfolioForecastDemandLineStartDate]
	ON [dbo].[PortfolioForecastDemandDetail] ([PFDL_Key], [PP_StartDate])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[PortfolioForecastDemandDetail] SET (LOCK_ESCALATION = TABLE)
GO
