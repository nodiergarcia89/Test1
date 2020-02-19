SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactNoteAttachments] (
		[NH_Key]          [int] NOT NULL,
		[NA_PathName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[ContactNoteAttachments]
	WITH CHECK
	ADD CONSTRAINT [FK__ContactNo__NH_Ke__102C51FF]
	FOREIGN KEY ([NH_Key]) REFERENCES [dbo].[ContactNoteHeader] ([NH_Key])
ALTER TABLE [dbo].[ContactNoteAttachments]
	CHECK CONSTRAINT [FK__ContactNo__NH_Ke__102C51FF]

GO
CREATE NONCLUSTERED INDEX [ContactNoteAttachments_Index]
	ON [dbo].[ContactNoteAttachments] ([NH_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ContactNoteAttachments] SET (LOCK_ESCALATION = TABLE)
GO
