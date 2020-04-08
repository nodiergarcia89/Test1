SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectTypeCondition] (
		[PTC_Key]              [int] IDENTITY(1, 1) NOT NULL,
		[PT_Key]               [int] NOT NULL,
		[WFSM_Key]             [int] NOT NULL,
		[PTC_Name]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PTC_FilterType]       [smallint] NOT NULL,
		[PTC_Result]           [smallint] NOT NULL,
		[AF_Key]               [int] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PTC_LastEdit]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PTC_LastEditDate]     [float] NOT NULL
)
GO
ALTER TABLE [dbo].[ProjectTypeCondition]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__PT_Ke__143CDA05]
	FOREIGN KEY ([PT_Key]) REFERENCES [dbo].[ProjectType] ([PT_Key])
ALTER TABLE [dbo].[ProjectTypeCondition]
	CHECK CONSTRAINT [FK__ProjectTy__PT_Ke__143CDA05]

GO
ALTER TABLE [dbo].[ProjectTypeCondition]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__WFSM___1530FE3E]
	FOREIGN KEY ([WFSM_Key]) REFERENCES [dbo].[WorkflowStatusMovement] ([WFSM_Key])
ALTER TABLE [dbo].[ProjectTypeCondition]
	CHECK CONSTRAINT [FK__ProjectTy__WFSM___1530FE3E]

GO
ALTER TABLE [dbo].[ProjectTypeCondition]
	WITH CHECK
	ADD CONSTRAINT [FK__ProjectTy__AF_Ke__16252277]
	FOREIGN KEY ([AF_Key]) REFERENCES [dbo].[ABSFilters] ([AF_Key])
ALTER TABLE [dbo].[ProjectTypeCondition]
	CHECK CONSTRAINT [FK__ProjectTy__AF_Ke__16252277]

GO
ALTER TABLE [dbo].[ProjectTypeCondition] SET (LOCK_ESCALATION = TABLE)
GO
