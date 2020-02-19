SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PostResources] (
		[PST_Key]     [int] NOT NULL,
		[RE_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__PostReso__DA3722EF31D75E8D]
		PRIMARY KEY
		CLUSTERED
		([PST_Key], [RE_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PostResources]
	WITH CHECK
	ADD CONSTRAINT [FK__PostResou__PST_K__0D1ADB2A]
	FOREIGN KEY ([PST_Key]) REFERENCES [dbo].[Posts] ([PST_Key])
ALTER TABLE [dbo].[PostResources]
	CHECK CONSTRAINT [FK__PostResou__PST_K__0D1ADB2A]

GO
ALTER TABLE [dbo].[PostResources]
	WITH CHECK
	ADD CONSTRAINT [FK__PostResou__RE_Co__0E0EFF63]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[PostResources]
	CHECK CONSTRAINT [FK__PostResou__RE_Co__0E0EFF63]

GO
ALTER TABLE [dbo].[PostResources] SET (LOCK_ESCALATION = TABLE)
GO
