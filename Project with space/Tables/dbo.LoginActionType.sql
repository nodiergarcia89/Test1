SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginActionType] (
		[US_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AT_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LAT_ViewAct]     [smallint] NULL,
		[LAT_MainAct]     [smallint] NULL,
		CONSTRAINT [PK__LoginAct__4BFAAFC15FD33367]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [AT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginActi__AT_Co__6F8A7843]
	FOREIGN KEY ([AT_Code]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[LoginActionType]
	CHECK CONSTRAINT [FK__LoginActi__AT_Co__6F8A7843]

GO
ALTER TABLE [dbo].[LoginActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginActi__US_Co__707E9C7C]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginActionType]
	CHECK CONSTRAINT [FK__LoginActi__US_Co__707E9C7C]

GO
ALTER TABLE [dbo].[LoginActionType] SET (LOCK_ESCALATION = TABLE)
GO
