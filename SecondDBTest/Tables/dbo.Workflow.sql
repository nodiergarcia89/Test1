SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Workflow] (
		[WF_Key]                 [int] IDENTITY(1, 1) NOT NULL,
		[WF_Name]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WF_Description]         [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[WF_Entity]              [int] NOT NULL,
		[WF_InitialMovement]     [int] NULL,
		[WF_KanbanConfig]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WF_LastEdit]            [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WF_LastEditDate]        [float] NOT NULL,
		CONSTRAINT [PK__Workflow__71200A853A5EF0F6]
		PRIMARY KEY
		CLUSTERED
		([WF_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Workflow] SET (LOCK_ESCALATION = TABLE)
GO
