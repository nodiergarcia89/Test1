SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProfileDemandDetail] (
		[PDL_Key]                 [int] NOT NULL,
		[PP_StartDate]            [float] NOT NULL,
		[PP_EndDate]              [float] NOT NULL,
		[PDD_Days]                [float] NULL,
		[PDD_FTE]                 [float] NULL,
		[PDD_DailyCostRate]       [float] NULL,
		[PDD_LocalCost]           [float] NULL,
		[PDD_SystemCost]          [float] NULL,
		[PDD_Status]              [int] NULL,
		[PDD_DailyChargeRate]     [float] NULL,
		[PDD_LocalCharge]         [float] NULL,
		[PDD_SystemCharge]        [float] NULL,
		[PDD_DailyUpliftRate]     [float] NULL,
		CONSTRAINT [PK__ProfileD__4A6E90E56EE06CCD]
		PRIMARY KEY
		CLUSTERED
		([PDL_Key], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileDemandDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__PDL_K__2C938683]
	FOREIGN KEY ([PDL_Key]) REFERENCES [dbo].[ProfileDemandLine] ([PDL_Key])
ALTER TABLE [dbo].[ProfileDemandDetail]
	CHECK CONSTRAINT [FK__ProfileDe__PDL_K__2C938683]

GO
ALTER TABLE [dbo].[ProfileDemandDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__PP_St__2D87AABC]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[ProfileDemandDetail]
	CHECK CONSTRAINT [FK__ProfileDe__PP_St__2D87AABC]

GO
ALTER TABLE [dbo].[ProfileDemandDetail] SET (LOCK_ESCALATION = TABLE)
GO
