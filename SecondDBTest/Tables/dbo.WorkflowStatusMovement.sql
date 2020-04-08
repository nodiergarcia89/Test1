SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WorkflowStatusMovement] (
		[WFSM_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[WFSM_To]               [int] NULL,
		[WFS_Key]               [int] NULL,
		[WFSM_Command]          [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WFSM_WebHookKey1]      [int] NULL,
		[WFSM_WebHookKey2]      [int] NULL,
		[WFSM_WebHookKey3]      [int] NULL,
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WFSM_LastEdit]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WFSM_LastEditDate]     [float] NOT NULL,
		CONSTRAINT [PK__Workflow__E8EAB903F8951437]
		PRIMARY KEY
		CLUSTERED
		([WFSM_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[WorkflowStatusMovement]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowS__WFSM___7894BF90]
	FOREIGN KEY ([WFSM_To]) REFERENCES [dbo].[WorkflowStatus] ([WFS_Key])
ALTER TABLE [dbo].[WorkflowStatusMovement]
	CHECK CONSTRAINT [FK__WorkflowS__WFSM___7894BF90]

GO
ALTER TABLE [dbo].[WorkflowStatusMovement]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowS__WFS_K__7988E3C9]
	FOREIGN KEY ([WFS_Key]) REFERENCES [dbo].[WorkflowStatus] ([WFS_Key])
	ON DELETE CASCADE
ALTER TABLE [dbo].[WorkflowStatusMovement]
	CHECK CONSTRAINT [FK__WorkflowS__WFS_K__7988E3C9]

GO
ALTER TABLE [dbo].[WorkflowStatusMovement] SET (LOCK_ESCALATION = TABLE)
GO
