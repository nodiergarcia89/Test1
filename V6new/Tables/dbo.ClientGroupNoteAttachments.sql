SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientGroupNoteAttachments] (
		[GH_Key]          [int] NOT NULL,
		[GA_PathName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[ClientGroupNoteAttachments]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientGro__GH_Ke__7E0DA1C4]
	FOREIGN KEY ([GH_Key]) REFERENCES [dbo].[ClientGroupNoteHeader] ([GH_Key])
ALTER TABLE [dbo].[ClientGroupNoteAttachments]
	CHECK CONSTRAINT [FK__ClientGro__GH_Ke__7E0DA1C4]

GO
CREATE NONCLUSTERED INDEX [ClientGroupNoteAttachments_Index]
	ON [dbo].[ClientGroupNoteAttachments] ([GH_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientGroupNoteAttachments] SET (LOCK_ESCALATION = TABLE)
GO
