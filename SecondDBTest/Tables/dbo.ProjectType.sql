SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectType] (
		[PT_Key]                                         [int] IDENTITY(1, 1) NOT NULL,
		[PT_Name]                                        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PT_Description]                                 [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Active]                                         [smallint] NOT NULL,
		[WF_Key]                                         [int] NULL,
		[PT_EntityFieldsDefinition]                      [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PT_WorkflowDefinition]                          [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PT_UseAutoCode]                                 [smallint] NOT NULL,
		[PT_AutoCode]                                    [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PT_Colour]                                      [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                                        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PT_LastEdit]                                    [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PT_LastEditDate]                                [float] NOT NULL,
		[PT_OnlyEnforceRequiredFieldsOnStatusChange]     [smallint] NULL,
		CONSTRAINT [PK__ProjectT__BA536915F188BA58]
		PRIMARY KEY
		CLUSTERED
		([PT_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProjectType]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__WF_Ke__7C655074]
	FOREIGN KEY ([WF_Key]) REFERENCES [dbo].[Workflow] ([WF_Key])
ALTER TABLE [dbo].[ProjectType]
	CHECK CONSTRAINT [FK__ProjectTy__WF_Ke__7C655074]

GO
ALTER TABLE [dbo].[ProjectType] SET (LOCK_ESCALATION = TABLE)
GO
