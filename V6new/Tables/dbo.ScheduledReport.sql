SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScheduledReport] (
		[SR_Key]                 [bigint] IDENTITY(1, 1) NOT NULL,
		[SR_NextRunDateTime]     [float] NULL,
		[ST_SiteID]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SRD_Key]                [int] NULL,
		[SR_InProgress]          [smallint] NULL,
		CONSTRAINT [PK__Schedule__3CADCE634A03EDD9]
		PRIMARY KEY
		CLUSTERED
		([SR_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ScheduledReport] SET (LOCK_ESCALATION = TABLE)
GO
