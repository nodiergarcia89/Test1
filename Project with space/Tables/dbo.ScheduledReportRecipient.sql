SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScheduledReportRecipient] (
		[SRR_Key]                     [int] IDENTITY(1, 1) NOT NULL,
		[SRD_Key]                     [int] NULL,
		[SRR_OverridePermissions]     [smallint] NULL,
		[AF_Key]                      [int] NULL,
		[US_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Schedule__77258E2151A50FA1]
		PRIMARY KEY
		CLUSTERED
		([SRR_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ScheduledReportRecipient]
	WITH CHECK
	ADD CONSTRAINT [FK__Scheduled__AF_Ke__546C6DB3]
	FOREIGN KEY ([AF_Key]) REFERENCES [dbo].[ABSFilters] ([AF_Key])
ALTER TABLE [dbo].[ScheduledReportRecipient]
	CHECK CONSTRAINT [FK__Scheduled__AF_Ke__546C6DB3]

GO
ALTER TABLE [dbo].[ScheduledReportRecipient]
	WITH CHECK
	ADD CONSTRAINT [FK__Scheduled__SRD_K__556091EC]
	FOREIGN KEY ([SRD_Key]) REFERENCES [dbo].[ScheduledReportDefinition] ([SRD_Key])
ALTER TABLE [dbo].[ScheduledReportRecipient]
	CHECK CONSTRAINT [FK__Scheduled__SRD_K__556091EC]

GO
ALTER TABLE [dbo].[ScheduledReportRecipient]
	WITH CHECK
	ADD CONSTRAINT [FK__Scheduled__US_Co__5654B625]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[ScheduledReportRecipient]
	CHECK CONSTRAINT [FK__Scheduled__US_Co__5654B625]

GO
ALTER TABLE [dbo].[ScheduledReportRecipient] SET (LOCK_ESCALATION = TABLE)
GO
