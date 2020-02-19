SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionAttachments] (
		[AN_Key]          [int] NOT NULL,
		[AA_PathName]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[ActionAttachments]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionAtt__AN_Ke__1BD30ED5]
	FOREIGN KEY ([AN_Key]) REFERENCES [dbo].[Action] ([AN_Key])
ALTER TABLE [dbo].[ActionAttachments]
	CHECK CONSTRAINT [FK__ActionAtt__AN_Ke__1BD30ED5]

GO
CREATE NONCLUSTERED INDEX [IDX_ActionAttachments_ANKey]
	ON [dbo].[ActionAttachments] ([AN_Key])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ActionAttachments] SET (LOCK_ESCALATION = TABLE)
GO
