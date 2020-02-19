SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactNoteText] (
		[NH_Key]                [int] NOT NULL,
		[CNN_Text]              [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CNN_FormattedText]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ContactN__3B4E86733EDC53F0]
		PRIMARY KEY
		CLUSTERED
		([NH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ContactNoteText]
	WITH CHECK
	ADD CONSTRAINT [FK__ContactNo__NH_Ke__12149A71]
	FOREIGN KEY ([NH_Key]) REFERENCES [dbo].[ContactNoteHeader] ([NH_Key])
ALTER TABLE [dbo].[ContactNoteText]
	CHECK CONSTRAINT [FK__ContactNo__NH_Ke__12149A71]

GO
CREATE FULLTEXT INDEX ON [dbo].[ContactNoteText]
	([CNN_Text] LANGUAGE 1033)
	KEY INDEX [PK__ContactN__3B4E86733EDC53F0]
	ON (FILEGROUP [PRIMARY], [CAT_Client])
	WITH CHANGE_TRACKING AUTO, STOPLIST SYSTEM
GO
ALTER TABLE [dbo].[ContactNoteText] SET (LOCK_ESCALATION = TABLE)
GO
