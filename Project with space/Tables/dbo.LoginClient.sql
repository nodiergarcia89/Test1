SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginClient] (
		[US_Code]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CL_Code]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LC_ViewSet]     [smallint] NULL,
		[LC_MainSet]     [smallint] NULL,
		CONSTRAINT [PK__LoginCli__2B0DF83563A3C44B]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [CL_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginClient]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginClie__CL_Co__7172C0B5]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[LoginClient]
	CHECK CONSTRAINT [FK__LoginClie__CL_Co__7172C0B5]

GO
ALTER TABLE [dbo].[LoginClient]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginClie__US_Co__7266E4EE]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginClient]
	CHECK CONSTRAINT [FK__LoginClie__US_Co__7266E4EE]

GO
ALTER TABLE [dbo].[LoginClient] SET (LOCK_ESCALATION = TABLE)
GO
