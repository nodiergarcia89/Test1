SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectPriority] (
		[PR_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Priority]                 [int] NULL,
		[PR_PriorityLastEditDate]     [float] NULL,
		[US_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_PriorityLastEdit]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProjectP__8AF2607F55DFB4D9]
		PRIMARY KEY
		CLUSTERED
		([PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectPriority]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectPr__PR_Co__5689C04F]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectPriority]
	CHECK CONSTRAINT [FK__ProjectPr__PR_Co__5689C04F]

GO
ALTER TABLE [dbo].[ProjectPriority] SET (LOCK_ESCALATION = TABLE)
GO
