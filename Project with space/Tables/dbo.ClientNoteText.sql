SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientNoteText] (
		[CH_Key]                [int] NOT NULL,
		[CLN_Text]              [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CLN_FormattedText]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ClientNo__DC0DA6DB2334397B]
		PRIMARY KEY
		CLUSTERED
		([CH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ClientNoteText]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientNot__CH_Ke__05AEC38C]
	FOREIGN KEY ([CH_Key]) REFERENCES [dbo].[ClientNoteHeader] ([CH_Key])
ALTER TABLE [dbo].[ClientNoteText]
	CHECK CONSTRAINT [FK__ClientNot__CH_Ke__05AEC38C]

GO
CREATE FULLTEXT INDEX ON [dbo].[ClientNoteText]
	([CLN_Text] LANGUAGE 1033)
	KEY INDEX [PK__ClientNo__DC0DA6DB2334397B]
	ON (FILEGROUP [PRIMARY], [CAT_Client])
	WITH CHANGE_TRACKING AUTO, STOPLIST SYSTEM
GO
ALTER TABLE [dbo].[ClientNoteText] SET (LOCK_ESCALATION = TABLE)
GO
