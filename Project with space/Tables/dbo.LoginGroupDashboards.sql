SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginGroupDashboards] (
		[LG_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DSH_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__LoginGro__3015C99A75C27486]
		PRIMARY KEY
		CLUSTERED
		([LG_Code], [DSH_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginGroupDashboards]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__DSH_C__7913E27D]
	FOREIGN KEY ([DSH_Code]) REFERENCES [dbo].[Dashboards] ([DSH_Code])
ALTER TABLE [dbo].[LoginGroupDashboards]
	CHECK CONSTRAINT [FK__LoginGrou__DSH_C__7913E27D]

GO
ALTER TABLE [dbo].[LoginGroupDashboards]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__LG_Co__7A0806B6]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[LoginGroupDashboards]
	CHECK CONSTRAINT [FK__LoginGrou__LG_Co__7A0806B6]

GO
ALTER TABLE [dbo].[LoginGroupDashboards] SET (LOCK_ESCALATION = TABLE)
GO
