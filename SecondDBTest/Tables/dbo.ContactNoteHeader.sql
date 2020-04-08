SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactNoteHeader] (
		[NH_Key]              [int] NOT NULL,
		[CN_Key]              [int] NULL,
		[NH_Title]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NH_Controlled]       [int] NULL,
		[NH_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NH_LastEditDate]     [float] NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ContactN__3B4E86733B0BC30C]
		PRIMARY KEY
		CLUSTERED
		([NH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ContactNoteHeader]
	WITH CHECK
	ADD CONSTRAINT [FK__ContactNo__CN_Ke__11207638]
	FOREIGN KEY ([CN_Key]) REFERENCES [dbo].[Contacts] ([CN_Key])
ALTER TABLE [dbo].[ContactNoteHeader]
	CHECK CONSTRAINT [FK__ContactNo__CN_Ke__11207638]

GO
ALTER TABLE [dbo].[ContactNoteHeader] SET (LOCK_ESCALATION = TABLE)
GO
