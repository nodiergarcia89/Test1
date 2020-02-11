SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResActionType] (
		[RE_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AT_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ResActio__22FFAE891F4E99FE]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [AT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAction__AT_Co__072CF7AA]
	FOREIGN KEY ([AT_Code]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[ResActionType]
	CHECK CONSTRAINT [FK__ResAction__AT_Co__072CF7AA]

GO
ALTER TABLE [dbo].[ResActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__ResAction__RE_Co__08211BE3]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResActionType]
	CHECK CONSTRAINT [FK__ResAction__RE_Co__08211BE3]

GO
CREATE NONCLUSTERED INDEX [RA_ActTypeResIndex]
	ON [dbo].[ResActionType] ([AT_Code], [RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ResActionType] SET (LOCK_ESCALATION = TABLE)
GO
