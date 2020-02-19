SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientNoteAttachments] (
		[CH_Key]          [int] NOT NULL,
		[CA_PathName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[ClientNoteAttachments]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientNot__CH_Ke__03C67B1A]
	FOREIGN KEY ([CH_Key]) REFERENCES [dbo].[ClientNoteHeader] ([CH_Key])
ALTER TABLE [dbo].[ClientNoteAttachments]
	CHECK CONSTRAINT [FK__ClientNot__CH_Ke__03C67B1A]

GO
CREATE NONCLUSTERED INDEX [ClientNoteAttachments_Index]
	ON [dbo].[ClientNoteAttachments] ([CH_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientNoteAttachments] SET (LOCK_ESCALATION = TABLE)
GO
