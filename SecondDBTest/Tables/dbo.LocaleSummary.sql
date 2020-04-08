SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LocaleSummary] (
		[LH_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PP_StartDate]     [float] NOT NULL,
		[PP_EndDate]       [float] NOT NULL,
		[LS_Days]          [float] NOT NULL,
		CONSTRAINT [PK__LocaleSu__1F90CAD15090EFD7]
		PRIMARY KEY
		CLUSTERED
		([LH_Code], [PP_StartDate])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LocaleSummary]
	WITH CHECK
	ADD CONSTRAINT [FK__LocaleSum__LH_Co__6CAE0B98]
	FOREIGN KEY ([LH_Code]) REFERENCES [dbo].[LocaleHeader] ([LH_Code])
ALTER TABLE [dbo].[LocaleSummary]
	CHECK CONSTRAINT [FK__LocaleSum__LH_Co__6CAE0B98]

GO
ALTER TABLE [dbo].[LocaleSummary]
	WITH CHECK
	ADD CONSTRAINT [FK__LocaleSum__PP_St__6DA22FD1]
	FOREIGN KEY ([PP_StartDate]) REFERENCES [dbo].[PlanningPeriod] ([PP_StartDate])
ALTER TABLE [dbo].[LocaleSummary]
	CHECK CONSTRAINT [FK__LocaleSum__PP_St__6DA22FD1]

GO
ALTER TABLE [dbo].[LocaleSummary] SET (LOCK_ESCALATION = TABLE)
GO
