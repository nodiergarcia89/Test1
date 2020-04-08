SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TimesheetSubmissions] (
		[TSS_Key]                 [int] IDENTITY(1, 1) NOT NULL,
		[TSS_ReferencePrefix]     [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TSS_ReferenceNumber]     [int] NOT NULL,
		[TSS_Reference]           [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TSS_WeekCommencing]      [float] NOT NULL,
		[TSS_Status]              [smallint] NOT NULL,
		[TSS_TotalHours]          [float] NULL,
		[RE_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TSS_Notes]               [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_CodeSubmittedBy]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TSS_SubmissionDate]      [float] NULL,
		[US_CodeAcceptedBy]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TSS_AcceptanceDate]      [float] NULL,
		[US_CodeRejectedBy]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TSS_RejectionDate]       [float] NULL,
		[US_CodeUnlockedBy]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TSS_UnlockDate]          [float] NULL,
		[US_CodeLastEdit]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TSS_LastEditDate]        [float] NULL,
		[TSS_Exported]            [smallint] NULL,
		[TSS_ExportedOn]          [float] NULL,
		[US_CodeExportedBy]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Timeshee__3CB2FA332F1AED73]
		PRIMARY KEY
		CLUSTERED
		([TSS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TimesheetSubmissions]
	WITH CHECK
	ADD CONSTRAINT [FK__Timesheet__RE_Co__73E5190C]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[TimesheetSubmissions]
	CHECK CONSTRAINT [FK__Timesheet__RE_Co__73E5190C]

GO
CREATE NONCLUSTERED INDEX [TSS_ReferencePrefixIndex]
	ON [dbo].[TimesheetSubmissions] ([TSS_ReferencePrefix])
	INCLUDE ([TSS_ReferenceNumber])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TSS_WeekCommencingIndex]
	ON [dbo].[TimesheetSubmissions] ([TSS_WeekCommencing])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[TimesheetSubmissions] SET (LOCK_ESCALATION = TABLE)
GO
