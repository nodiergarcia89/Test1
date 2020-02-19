SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectPriorityArchiveHeader] (
		[PR_ArchiveNo]               [int] NOT NULL,
		[PR_ArchiveDesc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_ArchiveDate]             [float] NULL,
		[PR_ArchiveNotes]            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_ArchiveLastEdit]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_ArchiveLastEditDate]     [float] NULL,
		CONSTRAINT [PK__ProjectP__2FBBE3A05D80D6A1]
		PRIMARY KEY
		CLUSTERED
		([PR_ArchiveNo])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectPriorityArchiveHeader] SET (LOCK_ESCALATION = TABLE)
GO
