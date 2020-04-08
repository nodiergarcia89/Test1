SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileStatus] (
		[PS_Key]               [int] NOT NULL,
		[PS_Desc]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PS_Default]           [smallint] NULL,
		[PS_AllowMultiple]     [smallint] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PS_LastEditDate]      [float] NULL,
		[PS_Active]            [smallint] NULL,
		CONSTRAINT [PK__ProfileS__E8042BDB09946309]
		PRIMARY KEY
		CLUSTERED
		([PS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileStatus] SET (LOCK_ESCALATION = TABLE)
GO
