SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WorkflowMovementApproval] (
		[WMA_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[WFSM_Key]             [int] NOT NULL,
		[PR_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WMA_Comments]         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WMA_ApprovalDate]     [float] NULL,
		[WMA_Active]           [smallint] NULL,
		CONSTRAINT [PK__Workflow__DDB0E36FC44A7581]
		PRIMARY KEY
		CLUSTERED
		([WMA_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[WorkflowMovementApproval]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowM__WFSM___08CB2759]
	FOREIGN KEY ([WFSM_Key]) REFERENCES [dbo].[WorkflowStatusMovement] ([WFSM_Key])
ALTER TABLE [dbo].[WorkflowMovementApproval]
	CHECK CONSTRAINT [FK__WorkflowM__WFSM___08CB2759]

GO
ALTER TABLE [dbo].[WorkflowMovementApproval]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowM__PR_Co__09BF4B92]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[WorkflowMovementApproval]
	CHECK CONSTRAINT [FK__WorkflowM__PR_Co__09BF4B92]

GO
ALTER TABLE [dbo].[WorkflowMovementApproval]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowM__RE_Co__0AB36FCB]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[WorkflowMovementApproval]
	CHECK CONSTRAINT [FK__WorkflowM__RE_Co__0AB36FCB]

GO
ALTER TABLE [dbo].[WorkflowMovementApproval] SET (LOCK_ESCALATION = TABLE)
GO
