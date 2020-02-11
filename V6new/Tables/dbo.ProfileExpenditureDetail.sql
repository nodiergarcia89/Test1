SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProfileExpenditureDetail] (
		[PEL_Key]           [int] NOT NULL,
		[PP_StartDate]      [float] NOT NULL,
		[PP_EndDate]        [float] NOT NULL,
		[PED_Cost]          [float] NOT NULL,
		[PED_LocalCost]     [float] NULL,
		CONSTRAINT [PK__ProfileE__44E8CC8C7E22B05D]
		PRIMARY KEY
		CLUSTERED
		([PEL_Key], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileExpenditureDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileEx__PEL_K__371114F6]
	FOREIGN KEY ([PEL_Key]) REFERENCES [dbo].[ProfileExpenditureLine] ([PEL_Key])
ALTER TABLE [dbo].[ProfileExpenditureDetail]
	CHECK CONSTRAINT [FK__ProfileEx__PEL_K__371114F6]

GO
ALTER TABLE [dbo].[ProfileExpenditureDetail]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileEx__PP_St__3805392F]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[ProfileExpenditureDetail]
	CHECK CONSTRAINT [FK__ProfileEx__PP_St__3805392F]

GO
ALTER TABLE [dbo].[ProfileExpenditureDetail] SET (LOCK_ESCALATION = TABLE)
GO
