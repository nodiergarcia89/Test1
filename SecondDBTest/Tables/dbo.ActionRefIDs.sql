SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionRefIDs] (
		[AN_RefPrefix]     [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AR_ID]            [int] NULL,
		[AR_LastEdit]      [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ActionRe__52417E512F10007B]
		PRIMARY KEY
		CLUSTERED
		([AN_RefPrefix])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionRefIDs] SET (LOCK_ESCALATION = TABLE)
GO
