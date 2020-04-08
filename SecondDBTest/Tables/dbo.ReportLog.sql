SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportLog] (
		[RL_Key]           [int] NOT NULL,
		[RH_Key]           [int] NOT NULL,
		[RH_Title]         [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RL_StartTime]     [float] NULL,
		[RL_EndTime]       [float] NULL,
		CONSTRAINT [PK__ReportLo__CE341B5E0C3BC58A]
		PRIMARY KEY
		CLUSTERED
		([RL_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportLog] SET (LOCK_ESCALATION = TABLE)
GO
