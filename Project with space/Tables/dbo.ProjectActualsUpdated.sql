SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectActualsUpdated] (
		[PR_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PAU_LastUpdated]       [float] NOT NULL,
		[PAU_LastUpdatedBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ProjectA__8AF2607F0D64F3ED]
		PRIMARY KEY
		CLUSTERED
		([PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectActualsUpdated]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectAc__PR_Co__3DBE1285]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectActualsUpdated]
	CHECK CONSTRAINT [FK__ProjectAc__PR_Co__3DBE1285]

GO
ALTER TABLE [dbo].[ProjectActualsUpdated] SET (LOCK_ESCALATION = TABLE)
GO
