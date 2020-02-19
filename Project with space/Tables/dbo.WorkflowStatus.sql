SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WorkflowStatus] (
		[WFS_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[WFS_Name]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WFS_Sequence]         [int] NULL,
		[WF_Key]               [int] NOT NULL,
		[WFS_ParentStatus]     [int] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WFS_LastEdit]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WFS_LastEditDate]     [float] NOT NULL,
		CONSTRAINT [PK__Workflow__D534550BBD0DDEBB]
		PRIMARY KEY
		CLUSTERED
		([WFS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[WorkflowStatus]
	WITH CHECK
	ADD CONSTRAINT [FK__WorkflowS__WF_Ke__75B852E5]
	FOREIGN KEY ([WF_Key]) REFERENCES [dbo].[Workflow] ([WF_Key])
	ON DELETE CASCADE
ALTER TABLE [dbo].[WorkflowStatus]
	CHECK CONSTRAINT [FK__WorkflowS__WF_Ke__75B852E5]

GO
ALTER TABLE [dbo].[WorkflowStatus] SET (LOCK_ESCALATION = TABLE)
GO
