SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResEmail] (
		[RE_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Email]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ResEmail__46C9D90950E5F592]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [RE_Email])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResEmail]
	WITH CHECK
	ADD CONSTRAINT [FK__ResEmail__RE_Cod__1F04813B]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResEmail]
	CHECK CONSTRAINT [FK__ResEmail__RE_Cod__1F04813B]

GO
ALTER TABLE [dbo].[ResEmail] SET (LOCK_ESCALATION = TABLE)
GO
