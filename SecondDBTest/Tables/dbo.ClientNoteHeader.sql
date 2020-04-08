SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientNoteHeader] (
		[CH_Key]              [int] NOT NULL,
		[CL_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_Title]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_LastEditDate]     [float] NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CH_Controlled]       [int] NULL,
		[CH_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ClientNo__DC0DA6DB1F63A897]
		PRIMARY KEY
		CLUSTERED
		([CH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ClientNoteHeader]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientNot__CL_Co__04BA9F53]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[ClientNoteHeader]
	CHECK CONSTRAINT [FK__ClientNot__CL_Co__04BA9F53]

GO
ALTER TABLE [dbo].[ClientNoteHeader] SET (LOCK_ESCALATION = TABLE)
GO
