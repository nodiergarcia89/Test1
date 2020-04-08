SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectDocuments] (
		[PR_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DH_Key]      [int] NOT NULL,
		CONSTRAINT [PK__ProjectD__24649FB42818EA29]
		PRIMARY KEY
		CLUSTERED
		([DH_Key], [PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectDo__DH_Ke__446B1014]
	FOREIGN KEY ([DH_Key]) REFERENCES [dbo].[DocumentHeader] ([DH_Key])
ALTER TABLE [dbo].[ProjectDocuments]
	CHECK CONSTRAINT [FK__ProjectDo__DH_Ke__446B1014]

GO
ALTER TABLE [dbo].[ProjectDocuments]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectDo__PR_Co__455F344D]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectDocuments]
	CHECK CONSTRAINT [FK__ProjectDo__PR_Co__455F344D]

GO
ALTER TABLE [dbo].[ProjectDocuments] SET (LOCK_ESCALATION = TABLE)
GO
