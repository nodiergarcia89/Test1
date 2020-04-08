SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskNoteAttachments] (
		[RH_Key]          [int] NOT NULL,
		[RA_PathName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[RiskNoteAttachments]
	WITH CHECK
	ADD CONSTRAINT [FK__RiskNoteA__RH_Ke__461E4E5C]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[RiskNoteHeader] ([RH_Key])
ALTER TABLE [dbo].[RiskNoteAttachments]
	CHECK CONSTRAINT [FK__RiskNoteA__RH_Ke__461E4E5C]

GO
CREATE NONCLUSTERED INDEX [RiskNoteAttachments_Index]
	ON [dbo].[RiskNoteAttachments] ([RH_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[RiskNoteAttachments] SET (LOCK_ESCALATION = TABLE)
GO
