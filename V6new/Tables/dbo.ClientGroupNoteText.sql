SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientGroupNoteText] (
		[GH_Key]                [int] NOT NULL,
		[CGN_Text]              [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CGN_FormattedText]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ClientGr__6E92F52512FDD1B2]
		PRIMARY KEY
		CLUSTERED
		([GH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ClientGroupNoteText]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientGro__GH_Ke__7FF5EA36]
	FOREIGN KEY ([GH_Key]) REFERENCES [dbo].[ClientGroupNoteHeader] ([GH_Key])
ALTER TABLE [dbo].[ClientGroupNoteText]
	CHECK CONSTRAINT [FK__ClientGro__GH_Ke__7FF5EA36]

GO
CREATE FULLTEXT INDEX ON [dbo].[ClientGroupNoteText]
	([CGN_Text] LANGUAGE 1033)
	KEY INDEX [PK__ClientGr__6E92F52512FDD1B2]
	ON (FILEGROUP [PRIMARY], [CAT_Client])
	WITH CHANGE_TRACKING AUTO, STOPLIST SYSTEM
GO
ALTER TABLE [dbo].[ClientGroupNoteText] SET (LOCK_ESCALATION = TABLE)
GO
