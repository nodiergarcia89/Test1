SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientGroupStructure] (
		[CG_CodeParent]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CG_CodeChild]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ClientGr__BB8E72541A9EF37A]
		PRIMARY KEY
		CLUSTERED
		([CG_CodeParent], [CG_CodeChild])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ClientGroupStructure]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientGro__CG_Co__01DE32A8]
	FOREIGN KEY ([CG_CodeParent]) REFERENCES [dbo].[ClientGroups] ([CG_Code])
ALTER TABLE [dbo].[ClientGroupStructure]
	CHECK CONSTRAINT [FK__ClientGro__CG_Co__01DE32A8]

GO
ALTER TABLE [dbo].[ClientGroupStructure]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientGro__CG_Co__02D256E1]
	FOREIGN KEY ([CG_CodeChild]) REFERENCES [dbo].[ClientGroups] ([CG_Code])
ALTER TABLE [dbo].[ClientGroupStructure]
	CHECK CONSTRAINT [FK__ClientGro__CG_Co__02D256E1]

GO
ALTER TABLE [dbo].[ClientGroupStructure] SET (LOCK_ESCALATION = TABLE)
GO
