SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionType] (
		[AT_Code]                                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AT_Desc]                                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_Significant]                         [smallint] NULL,
		[AT_UseAutoRef]                          [smallint] NULL,
		[AT_RefPrefix]                           [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_RefStartNo]                          [int] NULL,
		[AT_AllRes]                              [smallint] NULL,
		[AT_ProjectRequirement]                  [smallint] NULL,
		[AT_ContactRequirement]                  [smallint] NULL,
		[AT_ReferenceVisible]                    [smallint] NULL,
		[AT_StatusVisible]                       [smallint] NULL,
		[AT_PriorityVisible]                     [smallint] NULL,
		[AT_StartTimeVisible]                    [smallint] NULL,
		[AT_EndDateVisible]                      [smallint] NULL,
		[AT_EndTimeVisible]                      [smallint] NULL,
		[AT_ClientVisible]                       [smallint] NULL,
		[AT_ContactVisible]                      [smallint] NULL,
		[AT_DetailsVisible]                      [smallint] NULL,
		[AT_AttachmentsVisible]                  [smallint] NULL,
		[AT_StatusDefault]                       [int] NULL,
		[AT_PriorityDefault]                     [int] NULL,
		[CL_Code]                                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CN_Key]                                 [int] NULL,
		[PR_Code]                                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ResourceLabel]                       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ReferenceLabel]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_StartDateLabel]                      [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_EndDateLabel]                        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ClientLabel]                         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ContactLabel]                        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ProjectLabel]                        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_DetailsLabel]                        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_GeneralLabel]                        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_AttachmentsLabel]                    [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ToDoDateLabel]                       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ReportURL]                           [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ValidAction]                         [int] NULL,
		[AT_DefaultCustomFields]                 [int] NULL,
		[AT_ActionCustom1]                       [int] NULL,
		[AT_ActionCustom2]                       [int] NULL,
		[AT_ActionCustom3]                       [int] NULL,
		[AT_ActionCustom4]                       [int] NULL,
		[AT_ActionCustom5]                       [int] NULL,
		[Active]                                 [smallint] NULL,
		[AT_LastEdit]                            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_EditBy]                              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_EditOn]                              [float] NULL,
		[AT_EditOverwriteBy]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ProcessSupport]                      [smallint] NULL,
		[AT_DefaultSLADays]                      [int] NULL,
		[AT_MasterATCode]                        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_MasterATMandatory]                   [smallint] NULL,
		[AT_IsMasterAType]                       [smallint] NULL,
		[AT_ResourceReadOnly]                    [smallint] NULL,
		[AT_StartDateReadOnly]                   [smallint] NULL,
		[AT_ReferenceReadOnly]                   [smallint] NULL,
		[AT_ForwardToOption]                     [smallint] NULL,
		[AT_ForwardToRECode]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_ForwardToReadOnly]                   [smallint] NULL,
		[AT_ProcessNextLabel]                    [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_IsReadonlyOnCompletion]              [smallint] NULL,
		[RH_Key]                                 [int] NULL,
		[AT_FinishActionLabel]                   [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_StatusReadOnly]                      [smallint] NULL,
		[AT_StatusCompletedLabel]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_CreateArchiveReportOnCompletion]     [smallint] NULL,
		[AT_AllowAddMultiple]                    [smallint] NULL,
		[US_Code]                                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_LastEditDate]                        [float] NULL,
		[AT_EventURL]                            [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_PublishToVisible]                    [smallint] NULL,
		[AT_CreateProjectOnCompletion]           [smallint] NULL,
		CONSTRAINT [PK__ActionTy__B90A6A1336B12243]
		PRIMARY KEY
		CLUSTERED
		([AT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__AT_Fo__22800C64]
	FOREIGN KEY ([AT_ForwardToRECode]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ActionType]
	CHECK CONSTRAINT [FK__ActionTyp__AT_Fo__22800C64]

GO
ALTER TABLE [dbo].[ActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__AT_Ma__2374309D]
	FOREIGN KEY ([AT_MasterATCode]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[ActionType]
	CHECK CONSTRAINT [FK__ActionTyp__AT_Ma__2374309D]

GO
ALTER TABLE [dbo].[ActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__CL_Co__246854D6]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[ActionType]
	CHECK CONSTRAINT [FK__ActionTyp__CL_Co__246854D6]

GO
ALTER TABLE [dbo].[ActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__CN_Ke__255C790F]
	FOREIGN KEY ([CN_Key]) REFERENCES [dbo].[Contacts] ([CN_Key])
ALTER TABLE [dbo].[ActionType]
	CHECK CONSTRAINT [FK__ActionTyp__CN_Ke__255C790F]

GO
ALTER TABLE [dbo].[ActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__PR_Co__26509D48]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[ActionType]
	CHECK CONSTRAINT [FK__ActionTyp__PR_Co__26509D48]

GO
ALTER TABLE [dbo].[ActionType]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__RH_Ke__2744C181]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[ActionType]
	CHECK CONSTRAINT [FK__ActionTyp__RH_Ke__2744C181]

GO
ALTER TABLE [dbo].[ActionType] SET (LOCK_ESCALATION = TABLE)
GO
