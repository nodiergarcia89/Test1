SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeliverableType] (
		[DVT_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DVT_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DVT_Options]          [int] NOT NULL,
		[DVT_Active]           [smallint] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DVT_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__Delivera__314DA8174A18FC72]
		PRIMARY KEY
		CLUSTERED
		([DVT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DeliverableType] SET (LOCK_ESCALATION = TABLE)
GO
