SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportCache] (
		[RH_Key]                   [int] NOT NULL,
		[US_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RCA_Data]                 [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RCA_ExpiryDate]           [float] NULL,
		[RCA_LastRunDate]          [float] NULL,
		[RCA_AllowRefresh]         [smallint] NOT NULL,
		[RCA_ScheduledRefresh]     [smallint] NOT NULL,
		[AF_Key]                   [int] NULL,
		[PSC_Key]                  [int] NULL,
		[PSC_Keys]                 [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RCA_Hash]                 [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ReportCa__841CEF4575586032]
		PRIMARY KEY
		CLUSTERED
		([RH_Key], [US_Code], [PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportCache] SET (LOCK_ESCALATION = TABLE)
GO
