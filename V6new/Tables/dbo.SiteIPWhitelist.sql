SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SiteIPWhitelist] (
		[SIP_Key]       [int] IDENTITY(1, 1) NOT NULL,
		[ST_SiteID]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SIP_From]      [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SIP_To]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__SiteIPWh__6A9DF90DFFDCFBAC]
		PRIMARY KEY
		CLUSTERED
		([SIP_Key])
	ON [PRIMARY]
)
GO
CREATE NONCLUSTERED INDEX [idx_SiteIPWhitelist_SiteID]
	ON [dbo].[SiteIPWhitelist] ([ST_SiteID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SiteIPWhitelist] SET (LOCK_ESCALATION = TABLE)
GO
