SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectRelations] (
		[MasterPR]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SubPR]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ProjectR__126EF50D61516785]
		PRIMARY KEY
		CLUSTERED
		([MasterPR], [SubPR])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectRelations]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectRe__Maste__59662CFA]
	FOREIGN KEY ([MasterPR]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectRelations]
	CHECK CONSTRAINT [FK__ProjectRe__Maste__59662CFA]

GO
ALTER TABLE [dbo].[ProjectRelations]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectRe__SubPR__5A5A5133]
	FOREIGN KEY ([SubPR]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectRelations]
	CHECK CONSTRAINT [FK__ProjectRe__SubPR__5A5A5133]

GO
ALTER TABLE [dbo].[ProjectRelations] SET (LOCK_ESCALATION = TABLE)
GO
