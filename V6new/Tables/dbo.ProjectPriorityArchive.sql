SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectPriorityArchive] (
		[PR_ArchiveNo]                [int] NOT NULL,
		[PR_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Priority]                 [int] NULL,
		[PR_PriorityLastEditDate]     [float] NULL,
		[US_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_PriorityLastEdit]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectP__C714C5A759B045BD]
		PRIMARY KEY
		CLUSTERED
		([PR_ArchiveNo], [PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectPriorityArchive]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectPr__PR_Ar__577DE488]
	FOREIGN KEY ([PR_ArchiveNo]) REFERENCES [dbo].[ProjectPriorityArchiveHeader] ([PR_ArchiveNo])
ALTER TABLE [dbo].[ProjectPriorityArchive]
	CHECK CONSTRAINT [FK__ProjectPr__PR_Ar__577DE488]

GO
ALTER TABLE [dbo].[ProjectPriorityArchive]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectPr__PR_Co__587208C1]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectPriorityArchive]
	CHECK CONSTRAINT [FK__ProjectPr__PR_Co__587208C1]

GO
ALTER TABLE [dbo].[ProjectPriorityArchive] SET (LOCK_ESCALATION = TABLE)
GO
