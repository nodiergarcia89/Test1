SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecentProjects] (
		[RP_Key]          [bigint] IDENTITY(1, 1) NOT NULL,
		[US_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RP_DateTime]     [float] NOT NULL,
		CONSTRAINT [PK__RecentPr__A2009D9B6DB73E6A]
		PRIMARY KEY
		CLUSTERED
		([RP_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[RecentProjects]
	WITH CHECK
	ADD CONSTRAINT [FK__RecentPro__US_Co__6B84DD35]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[RecentProjects]
	CHECK CONSTRAINT [FK__RecentPro__US_Co__6B84DD35]

GO
ALTER TABLE [dbo].[RecentProjects] SET (LOCK_ESCALATION = TABLE)
GO
