SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectLifecycleAudit] (
		[PLFA_Key]                   [int] IDENTITY(1, 1) NOT NULL,
		[PR_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFA_DateTime]              [float] NULL,
		[US_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFA_NewLifecycle]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFA_NewStage]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFA_PreviousLifecycle]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFA_PreviousStage]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PLFA_StartDate]             [float] NULL,
		CONSTRAINT [PK__ProjectL__DF4F3E7E3EFC4F81]
		PRIMARY KEY
		CLUSTERED
		([PLFA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectLifecycleAudit]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectLi__PR_Co__4EE89E87]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ProjectLifecycleAudit]
	CHECK CONSTRAINT [FK__ProjectLi__PR_Co__4EE89E87]

GO
ALTER TABLE [dbo].[ProjectLifecycleAudit] SET (LOCK_ESCALATION = TABLE)
GO
