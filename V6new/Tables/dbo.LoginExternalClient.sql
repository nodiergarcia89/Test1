SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginExternalClient] (
		[US_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CL_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__LoginExt__2B0DF835E05FA4DB]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [CL_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginExternalClient]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginExte__US_Co__7953D99F]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginExternalClient]
	CHECK CONSTRAINT [FK__LoginExte__US_Co__7953D99F]

GO
ALTER TABLE [dbo].[LoginExternalClient]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginExte__CL_Co__7A47FDD8]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[LoginExternalClient]
	CHECK CONSTRAINT [FK__LoginExte__CL_Co__7A47FDD8]

GO
ALTER TABLE [dbo].[LoginExternalClient] SET (LOCK_ESCALATION = TABLE)
GO
