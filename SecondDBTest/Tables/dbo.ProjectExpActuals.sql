SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectExpActuals] (
		[PR_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TY_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CC_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PP_StartDate]     [float] NOT NULL,
		[PP_EndDate]       [float] NULL,
		[PEA_Cost]         [float] NULL,
		CONSTRAINT [PK__ProjectE__B7B3CC552BE97B0D]
		PRIMARY KEY
		CLUSTERED
		([PR_Code], [RE_Code], [TY_Code], [DE_Code], [CC_Code], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectExpActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectEx__CC_Co__46535886]
	FOREIGN KEY ([CC_Code]) REFERENCES [dbo].[CostCentre] ([CC_Code])
ALTER TABLE [dbo].[ProjectExpActuals]
	CHECK CONSTRAINT [FK__ProjectEx__CC_Co__46535886]

GO
ALTER TABLE [dbo].[ProjectExpActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectEx__DE_Co__47477CBF]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[ProjectExpActuals]
	CHECK CONSTRAINT [FK__ProjectEx__DE_Co__47477CBF]

GO
ALTER TABLE [dbo].[ProjectExpActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectEx__PP_St__483BA0F8]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[ProjectExpActuals]
	CHECK CONSTRAINT [FK__ProjectEx__PP_St__483BA0F8]

GO
ALTER TABLE [dbo].[ProjectExpActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectEx__PR_Co__492FC531]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectExpActuals]
	CHECK CONSTRAINT [FK__ProjectEx__PR_Co__492FC531]

GO
ALTER TABLE [dbo].[ProjectExpActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectEx__RE_Co__4A23E96A]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ProjectExpActuals]
	CHECK CONSTRAINT [FK__ProjectEx__RE_Co__4A23E96A]

GO
ALTER TABLE [dbo].[ProjectExpActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectEx__TY_Co__4B180DA3]
	FOREIGN KEY ([TY_Code]) REFERENCES [dbo].[Type] ([TY_Code])
ALTER TABLE [dbo].[ProjectExpActuals]
	CHECK CONSTRAINT [FK__ProjectEx__TY_Co__4B180DA3]

GO
ALTER TABLE [dbo].[ProjectExpActuals] SET (LOCK_ESCALATION = TABLE)
GO
