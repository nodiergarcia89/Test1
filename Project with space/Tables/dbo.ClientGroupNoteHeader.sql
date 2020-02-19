SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientGroupNoteHeader] (
		[GH_Key]              [int] NOT NULL,
		[CG_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GH_Title]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GH_Controlled]       [int] NULL,
		[GH_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GH_LastEditDate]     [float] NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ClientGr__6E92F5250F2D40CE]
		PRIMARY KEY
		CLUSTERED
		([GH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ClientGroupNoteHeader]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientGro__CG_Co__7F01C5FD]
	FOREIGN KEY ([CG_Code]) REFERENCES [dbo].[ClientGroups] ([CG_Code])
ALTER TABLE [dbo].[ClientGroupNoteHeader]
	CHECK CONSTRAINT [FK__ClientGro__CG_Co__7F01C5FD]

GO
ALTER TABLE [dbo].[ClientGroupNoteHeader] SET (LOCK_ESCALATION = TABLE)
GO
