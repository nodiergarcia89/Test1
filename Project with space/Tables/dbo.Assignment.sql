SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Assignment] (
		[AS_Key]                     [int] IDENTITY(1, 1) NOT NULL,
		[TA_Key]                     [int] NOT NULL,
		[RE_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_CodeRole]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AS_Desc]                    [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AS_Work]                    [float] NULL,
		[AS_PercentComplete]         [float] NULL,
		[AS_ActualWork]              [float] NULL,
		[AS_StartDate]               [float] NULL,
		[AS_StartTime]               [float] NULL,
		[AS_EndDate]                 [float] NULL,
		[AS_EndTime]                 [float] NULL,
		[AS_AnchoredStart]           [smallint] NULL,
		[AS_AnchoredEnd]             [smallint] NULL,
		[AS_AssignmentCount]         [int] NULL,
		[AS_Status]                  [smallint] NULL,
		[AS_Active]                  [smallint] NULL,
		[US_Code]                    [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AS_LastEditDate]            [float] NULL,
		[AS_LastEdit]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AS_Null]                    [smallint] NULL,
		[AS_KeyPublished]            [int] NULL,
		[AS_CreatedDateTime]         [float] NULL,
		[AS_WorkContour]             [smallint] NULL,
		[AS_CompleteDate]            [float] NULL,
		[AS_CreatedFromForecast]     [smallint] NOT NULL,
		[AS_LinkKey]                 [int] NULL,
		[AS_HasChanged]              [int] NULL,
		[AS_ID]                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AS_Duration]                [float] NULL,
		CONSTRAINT [PK__Assignme__3BC06B12787EE5A0]
		PRIMARY KEY
		CLUSTERED
		([AS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Assignment]
	ADD
	CONSTRAINT [DF__Assignmen__AS_Cr__7A672E12]
	DEFAULT ((0)) FOR [AS_CreatedFromForecast]
GO
ALTER TABLE [dbo].[Assignment]
	WITH CHECK
	ADD CONSTRAINT [FK__Assignmen__AS_Ke__3A5795F5]
	FOREIGN KEY ([AS_KeyPublished]) REFERENCES [dbo].[Assignment] ([AS_Key])
ALTER TABLE [dbo].[Assignment]
	CHECK CONSTRAINT [FK__Assignmen__AS_Ke__3A5795F5]

GO
ALTER TABLE [dbo].[Assignment]
	WITH CHECK
	ADD CONSTRAINT [FK__Assignmen__DE_Co__3B4BBA2E]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[Assignment]
	CHECK CONSTRAINT [FK__Assignmen__DE_Co__3B4BBA2E]

GO
ALTER TABLE [dbo].[Assignment]
	WITH CHECK
	ADD CONSTRAINT [FK__Assignmen__RE_Co__3C3FDE67]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Assignment]
	CHECK CONSTRAINT [FK__Assignmen__RE_Co__3C3FDE67]

GO
ALTER TABLE [dbo].[Assignment]
	WITH CHECK
	ADD CONSTRAINT [FK__Assignmen__RE_Co__3D3402A0]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Assignment]
	CHECK CONSTRAINT [FK__Assignmen__RE_Co__3D3402A0]

GO
ALTER TABLE [dbo].[Assignment]
	WITH CHECK
	ADD CONSTRAINT [FK__Assignmen__TA_Ke__3E2826D9]
	FOREIGN KEY ([TA_Key]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[Assignment]
	CHECK CONSTRAINT [FK__Assignmen__TA_Ke__3E2826D9]

GO
CREATE NONCLUSTERED INDEX [AS_ASKeyPublishedIndex]
	ON [dbo].[Assignment] ([AS_KeyPublished])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AS_ResourceStartDate]
	ON [dbo].[Assignment] ([RE_Code], [AS_StartDate])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AS_StartDateResource]
	ON [dbo].[Assignment] ([AS_StartDate], [RE_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AS_TaskResource]
	ON [dbo].[Assignment] ([TA_Key], [RE_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [AS_ResourceStartFinish]
	ON [dbo].[Assignment] ([RE_Code], [AS_StartDate], [AS_EndDate])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Assignment] SET (LOCK_ESCALATION = TABLE)
GO
