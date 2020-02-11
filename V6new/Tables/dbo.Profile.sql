SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile] (
		[PRF_Key]                          [int] IDENTITY(1, 1) NOT NULL,
		[PR_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LH_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRF_Desc]                         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRF_Status]                       [int] NOT NULL,
		[PS_Key]                           [int] NOT NULL,
		[PRF_EditBy]                       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRF_EditOn]                       [float] NULL,
		[PRF_EditOverwriteBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRF_LastEditDate]                 [float] NULL,
		[PRF_Baseline]                     [smallint] NULL,
		[CU_Code]                          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_CodeOwner]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PRF_DemandConfirmedUntilDate]     [float] NULL,
		[PRF_DemandStatus]                 [int] NULL,
		[PRF_PeriodType]                   [int] NULL,
		CONSTRAINT [PK__Profile__D56164A848BAC3E5]
		PRIMARY KEY
		CLUSTERED
		([PRF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Profile]
	WITH CHECK
	ADD CONSTRAINT [FK__Profile__CU_Code__1C5D1EBA]
	FOREIGN KEY ([CU_Code]) REFERENCES [dbo].[ABSCurrency] ([CU_Code])
ALTER TABLE [dbo].[Profile]
	CHECK CONSTRAINT [FK__Profile__CU_Code__1C5D1EBA]

GO
ALTER TABLE [dbo].[Profile]
	WITH CHECK
	ADD CONSTRAINT [FK__Profile__LH_Code__1D5142F3]
	FOREIGN KEY ([LH_Code]) REFERENCES [dbo].[LocaleHeader] ([LH_Code])
ALTER TABLE [dbo].[Profile]
	CHECK CONSTRAINT [FK__Profile__LH_Code__1D5142F3]

GO
ALTER TABLE [dbo].[Profile]
	WITH CHECK
	ADD CONSTRAINT [FK__Profile__PR_Code__1E45672C]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Profile]
	CHECK CONSTRAINT [FK__Profile__PR_Code__1E45672C]

GO
ALTER TABLE [dbo].[Profile]
	WITH CHECK
	ADD CONSTRAINT [FK__Profile__PS_Key__1F398B65]
	FOREIGN KEY ([PS_Key]) REFERENCES [dbo].[ProfileStatus] ([PS_Key])
ALTER TABLE [dbo].[Profile]
	CHECK CONSTRAINT [FK__Profile__PS_Key__1F398B65]

GO
ALTER TABLE [dbo].[Profile]
	WITH CHECK
	ADD CONSTRAINT [FK__Profile__US_Code__202DAF9E]
	FOREIGN KEY ([US_CodeOwner]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[Profile]
	CHECK CONSTRAINT [FK__Profile__US_Code__202DAF9E]

GO
CREATE NONCLUSTERED INDEX [PRF_ProjectStatusIndex]
	ON [dbo].[Profile] ([PR_Code], [PRF_Status])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Profile] SET (LOCK_ESCALATION = TABLE)
GO
