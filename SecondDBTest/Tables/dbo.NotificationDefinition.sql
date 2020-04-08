SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NotificationDefinition] (
		[ND_Key]              [int] NOT NULL,
		[ND_Desc]             [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ND_Subject]          [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ND_Text]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ND_Name]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ND_Recipients]       [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WF_Key]              [int] NULL,
		[WFSM_Key]            [int] NULL,
		[ND_LastEdit]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ND_LastEditDate]     [float] NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ND_EmailText]        [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ND_CanSelect]        [smallint] NULL,
		CONSTRAINT [PK__Notifica__4FD527C219FFD4FC]
		PRIMARY KEY
		CLUSTERED
		([ND_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[NotificationDefinition]
	ADD
	CONSTRAINT [DF__Notificat__ND_Ca__60882BD5]
	DEFAULT ((-1)) FOR [ND_CanSelect]
GO
ALTER TABLE [dbo].[NotificationDefinition]
	WITH CHECK
	ADD CONSTRAINT [FK__Notificat__WF_Ke__247341CE]
	FOREIGN KEY ([WF_Key]) REFERENCES [dbo].[Workflow] ([WF_Key])
ALTER TABLE [dbo].[NotificationDefinition]
	CHECK CONSTRAINT [FK__Notificat__WF_Ke__247341CE]

GO
ALTER TABLE [dbo].[NotificationDefinition]
	WITH CHECK
	ADD CONSTRAINT [FK__Notificat__WFSM___25676607]
	FOREIGN KEY ([WFSM_Key]) REFERENCES [dbo].[WorkflowStatusMovement] ([WFSM_Key])
ALTER TABLE [dbo].[NotificationDefinition]
	CHECK CONSTRAINT [FK__Notificat__WFSM___25676607]

GO
ALTER TABLE [dbo].[NotificationDefinition] SET (LOCK_ESCALATION = TABLE)
GO
