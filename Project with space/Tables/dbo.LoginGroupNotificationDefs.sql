SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginGroupNotificationDefs] (
		[LG_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ND_Key]      [int] NOT NULL,
		CONSTRAINT [PK__LoginGro__B5F093BA7D63964E]
		PRIMARY KEY
		CLUSTERED
		([LG_Code], [ND_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginGroupNotificationDefs]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__LG_Co__7CE47361]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[LoginGroupNotificationDefs]
	CHECK CONSTRAINT [FK__LoginGrou__LG_Co__7CE47361]

GO
ALTER TABLE [dbo].[LoginGroupNotificationDefs]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__ND_Ke__7DD8979A]
	FOREIGN KEY ([ND_Key]) REFERENCES [dbo].[NotificationDefinition] ([ND_Key])
ALTER TABLE [dbo].[LoginGroupNotificationDefs]
	CHECK CONSTRAINT [FK__LoginGrou__ND_Ke__7DD8979A]

GO
ALTER TABLE [dbo].[LoginGroupNotificationDefs] SET (LOCK_ESCALATION = TABLE)
GO
