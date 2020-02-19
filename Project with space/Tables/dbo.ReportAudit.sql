SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportAudit] (
		[RAU_Key]                   [int] IDENTITY(1, 1) NOT NULL,
		[RH_Key]                    [int] NOT NULL,
		[RH_Name]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RAU_ServerName]            [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RAU_SourceIPAddress]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RAU_SourceIPAddressV4]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RAU_StartTime]             [float] NULL,
		[RAU_EndTime]               [float] NULL,
		[RAU_RowCount]              [int] NULL,
		[RAU_Comments]              [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ReportAu__B4E445657187CF4E]
		PRIMARY KEY
		CLUSTERED
		([RAU_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportAudit] SET (LOCK_ESCALATION = TABLE)
GO
