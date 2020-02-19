SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebHooks] (
		[WH_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[WH_Name]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WH_URL]              [nvarchar](1999) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WH_Username]         [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WH_Password]         [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WH_Headers]          [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WH_LastEdit]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WH_LastEditDate]     [float] NOT NULL,
		[WH_Active]           [smallint] NOT NULL,
		CONSTRAINT [PK__WebHooks__23564C42C94D1442]
		PRIMARY KEY
		CLUSTERED
		([WH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[WebHooks] SET (LOCK_ESCALATION = TABLE)
GO
