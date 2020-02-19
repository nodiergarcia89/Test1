SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScheduledReportDefinition] (
		[SRD_Key]                      [int] IDENTITY(1, 1) NOT NULL,
		[SRD_Name]                     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SRD_Description]              [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SRD_Active]                   [smallint] NULL,
		[RH_Key]                       [int] NULL,
		[SRD_NextRunDateTime]          [float] NULL,
		[SRD_LastRunDateTime]          [float] NULL,
		[US_CodeRunAs]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SRD_Frequency]                [smallint] NULL,
		[SRD_OccursTime]               [float] NULL,
		[SRD_WeeklyRecurs]             [smallint] NULL,
		[SRD_WeeklyDaysOfWeek]         [smallint] NULL,
		[SRD_MonthlyFrequencyType]     [smallint] NULL,
		[SRD_DayNumber]                [smallint] NULL,
		[SRD_MonthlyTheType]           [smallint] NULL,
		[SRD_MonthlyDay]               [smallint] NULL,
		[SRD_LastEditDate]             [float] NULL,
		[US_Code]                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Schedule__B992E97E4DD47EBD]
		PRIMARY KEY
		CLUSTERED
		([SRD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ScheduledReportDefinition]
	WITH CHECK
	ADD CONSTRAINT [FK__Scheduled__RH_Ke__52842541]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[ScheduledReportDefinition]
	CHECK CONSTRAINT [FK__Scheduled__RH_Ke__52842541]

GO
ALTER TABLE [dbo].[ScheduledReportDefinition]
	WITH CHECK
	ADD CONSTRAINT [FK__Scheduled__US_Co__5378497A]
	FOREIGN KEY ([US_CodeRunAs]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[ScheduledReportDefinition]
	CHECK CONSTRAINT [FK__Scheduled__US_Co__5378497A]

GO
ALTER TABLE [dbo].[ScheduledReportDefinition] SET (LOCK_ESCALATION = TABLE)
GO
