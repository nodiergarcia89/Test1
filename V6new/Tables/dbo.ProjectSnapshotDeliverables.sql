SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectSnapshotDeliverables] (
		[PSSD_Key]     [int] IDENTITY(1, 1) NOT NULL,
		[PSS_Key]      [int] NOT NULL,
		[DV_Key]       [int] NOT NULL,
		[PR_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectS__C61590D808172E6D]
		PRIMARY KEY
		CLUSTERED
		([PSSD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectSnapshotDeliverables]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PSS_K__523A0C7E]
	FOREIGN KEY ([PSS_Key]) REFERENCES [dbo].[ProjectSnapshots] ([PSS_Key])
ALTER TABLE [dbo].[ProjectSnapshotDeliverables]
	CHECK CONSTRAINT [FK__ProjectSn__PSS_K__523A0C7E]

GO
ALTER TABLE [dbo].[ProjectSnapshotDeliverables]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__DV_Ke__532E30B7]
	FOREIGN KEY ([DV_Key]) REFERENCES [dbo].[Deliverable] ([DV_Key])
ALTER TABLE [dbo].[ProjectSnapshotDeliverables]
	CHECK CONSTRAINT [FK__ProjectSn__DV_Ke__532E30B7]

GO
ALTER TABLE [dbo].[ProjectSnapshotDeliverables]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectSn__PR_Co__542254F0]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectSnapshotDeliverables]
	CHECK CONSTRAINT [FK__ProjectSn__PR_Co__542254F0]

GO
ALTER TABLE [dbo].[ProjectSnapshotDeliverables] SET (LOCK_ESCALATION = TABLE)
GO
