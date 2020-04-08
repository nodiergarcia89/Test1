SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginNetwork] (
		[US_ManagerCode]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_SubCode]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__LoginNet__68A83B6506ED0088]
		PRIMARY KEY
		CLUSTERED
		([US_ManagerCode], [US_SubCode])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginNetwork]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginNetw__US_Ma__029D4CB7]
	FOREIGN KEY ([US_ManagerCode]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginNetwork]
	CHECK CONSTRAINT [FK__LoginNetw__US_Ma__029D4CB7]

GO
ALTER TABLE [dbo].[LoginNetwork]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginNetw__US_Su__039170F0]
	FOREIGN KEY ([US_SubCode]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginNetwork]
	CHECK CONSTRAINT [FK__LoginNetw__US_Su__039170F0]

GO
ALTER TABLE [dbo].[LoginNetwork] SET (LOCK_ESCALATION = TABLE)
GO
