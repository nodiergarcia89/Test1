SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectSnapshotForecasts] (
		[PSSF_Key]     [int] IDENTITY(1, 1) NOT NULL,
		[PSS_Key]      [int] NOT NULL,
		[PRF_Key]      [int] NOT NULL,
		[PR_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectS__8EB8FCAB254E13D1]
		PRIMARY KEY
		CLUSTERED
		([PSSF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectSnapshotForecasts]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PSS_K__4D755761]
	FOREIGN KEY ([PSS_Key]) REFERENCES [dbo].[ProjectSnapshots] ([PSS_Key])
ALTER TABLE [dbo].[ProjectSnapshotForecasts]
	CHECK CONSTRAINT [FK__ProjectSn__PSS_K__4D755761]

GO
ALTER TABLE [dbo].[ProjectSnapshotForecasts]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PRF_K__4E697B9A]
	FOREIGN KEY ([PRF_Key]) REFERENCES [dbo].[Profile] ([PRF_Key])
ALTER TABLE [dbo].[ProjectSnapshotForecasts]
	CHECK CONSTRAINT [FK__ProjectSn__PRF_K__4E697B9A]

GO
ALTER TABLE [dbo].[ProjectSnapshotForecasts]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PR_Co__4F5D9FD3]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectSnapshotForecasts]
	CHECK CONSTRAINT [FK__ProjectSn__PR_Co__4F5D9FD3]

GO
ALTER TABLE [dbo].[ProjectSnapshotForecasts] SET (LOCK_ESCALATION = TABLE)
GO
