SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProfileBudget] (
		[PRF_Key]                      [int] NOT NULL,
		[PP_StartDate]                 [float] NOT NULL,
		[PP_EndDate]                   [float] NOT NULL,
		[PRB_EffortDays]               [float] NULL,
		[PRB_EffortCost]               [float] NULL,
		[PRB_ExpenditureCost]          [float] NULL,
		[PRB_LocalEffortCost]          [float] NULL,
		[PRB_LocalExpenditureCost]     [float] NULL,
		CONSTRAINT [PK__ProfileB__DCBD5A98542C7691]
		PRIMARY KEY
		CLUSTERED
		([PRF_Key], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileBudget]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileBu__PP_St__24F264BB]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[ProfileBudget]
	CHECK CONSTRAINT [FK__ProfileBu__PP_St__24F264BB]

GO
ALTER TABLE [dbo].[ProfileBudget]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileBu__PRF_K__25E688F4]
	FOREIGN KEY ([PRF_Key]) REFERENCES [dbo].[Profile] ([PRF_Key])
ALTER TABLE [dbo].[ProfileBudget]
	CHECK CONSTRAINT [FK__ProfileBu__PRF_K__25E688F4]

GO
ALTER TABLE [dbo].[ProfileBudget] SET (LOCK_ESCALATION = TABLE)
GO
