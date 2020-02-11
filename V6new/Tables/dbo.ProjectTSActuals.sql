SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectTSActuals] (
		[PR_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_CodeRole]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PP_StartDate]     [float] NOT NULL,
		[PP_EndDate]       [float] NULL,
		[PA_Hours]         [float] NULL,
		[PA_Cost]          [float] NULL,
		[PA_Charge]        [float] NULL,
		CONSTRAINT [PK__ProjectT__8F89BE2B68F2894D]
		PRIMARY KEY
		CLUSTERED
		([PR_Code], [RE_Code], [RE_CodeRole], [DE_Code], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectTSActuals]
	ADD
	CONSTRAINT [DF__ProjectTS__PA_Ch__6ADAD1BF]
	DEFAULT ((0)) FOR [PA_Charge]
GO
ALTER TABLE [dbo].[ProjectTSActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTS__DE_Co__66C02818]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[ProjectTSActuals]
	CHECK CONSTRAINT [FK__ProjectTS__DE_Co__66C02818]

GO
ALTER TABLE [dbo].[ProjectTSActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTS__PP_St__67B44C51]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[ProjectTSActuals]
	CHECK CONSTRAINT [FK__ProjectTS__PP_St__67B44C51]

GO
ALTER TABLE [dbo].[ProjectTSActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTS__PR_Co__68A8708A]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectTSActuals]
	CHECK CONSTRAINT [FK__ProjectTS__PR_Co__68A8708A]

GO
ALTER TABLE [dbo].[ProjectTSActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTS__RE_Co__699C94C3]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ProjectTSActuals]
	CHECK CONSTRAINT [FK__ProjectTS__RE_Co__699C94C3]

GO
ALTER TABLE [dbo].[ProjectTSActuals]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTS__RE_Co__6A90B8FC]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ProjectTSActuals]
	CHECK CONSTRAINT [FK__ProjectTS__RE_Co__6A90B8FC]

GO
CREATE NONCLUSTERED INDEX [PA_RoleResDeptIndex]
	ON [dbo].[ProjectTSActuals] ([RE_CodeRole], [RE_Code], [DE_Code], [PP_StartDate])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProjectTSActuals] SET (LOCK_ESCALATION = TABLE)
GO
