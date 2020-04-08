SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WorkflowUpdates] (
		[WU_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[WF_Key]              [int] NOT NULL,
		[PT_Key]              [int] NOT NULL,
		[WU_Name]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WFSM_Key]            [int] NOT NULL,
		[WU_FieldName]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WU_FieldValue]       [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WU_LastEdit]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WU_LastEditDate]     [float] NOT NULL,
		[WU_LastEditUser]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Workflow__93C7CF307207DC84]
		PRIMARY KEY
		CLUSTERED
		([WU_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[WorkflowUpdates]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowU__WF_Ke__106C4921]
	FOREIGN KEY ([WF_Key]) REFERENCES [dbo].[Workflow] ([WF_Key])
ALTER TABLE [dbo].[WorkflowUpdates]
	CHECK CONSTRAINT [FK__WorkflowU__WF_Ke__106C4921]

GO
ALTER TABLE [dbo].[WorkflowUpdates]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowU__PT_Ke__11606D5A]
	FOREIGN KEY ([PT_Key]) REFERENCES [dbo].[ProjectType] ([PT_Key])
ALTER TABLE [dbo].[WorkflowUpdates]
	CHECK CONSTRAINT [FK__WorkflowU__PT_Ke__11606D5A]

GO
ALTER TABLE [dbo].[WorkflowUpdates]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowU__WFSM___12549193]
	FOREIGN KEY ([WFSM_Key]) REFERENCES [dbo].[WorkflowStatusMovement] ([WFSM_Key])
ALTER TABLE [dbo].[WorkflowUpdates]
	CHECK CONSTRAINT [FK__WorkflowU__WFSM___12549193]

GO
ALTER TABLE [dbo].[WorkflowUpdates] SET (LOCK_ESCALATION = TABLE)
GO
