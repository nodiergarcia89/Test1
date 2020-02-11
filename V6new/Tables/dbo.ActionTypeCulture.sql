SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionTypeCulture] (
		[AT_Code]                      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CLC_Code]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ATC_Desc]                     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_AttachmentsLabel]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_ClientLabel]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_ContactLabel]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_DetailsLabel]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_EndDateLabel]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_FinishActionLabel]        [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_GeneralLabel]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_ProcessNextLabel]         [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_ProjectLabel]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_ReferenceLabel]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_ResourceLabel]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_StartDateLabel]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_StatusCompletedLabel]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ATC_ToDoDateLabel]            [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ActionTy__926C57094222D4EF]
		PRIMARY KEY
		CLUSTERED
		([AT_Code], [CLC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionTypeCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__AT_Co__2B155265]
	FOREIGN KEY ([AT_Code]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[ActionTypeCulture]
	CHECK CONSTRAINT [FK__ActionTyp__AT_Co__2B155265]

GO
ALTER TABLE [dbo].[ActionTypeCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionTyp__CLC_C__2C09769E]
	FOREIGN KEY ([CLC_Code]) REFERENCES [dbo].[CultureCodes] ([CLC_Code])
ALTER TABLE [dbo].[ActionTypeCulture]
	CHECK CONSTRAINT [FK__ActionTyp__CLC_C__2C09769E]

GO
ALTER TABLE [dbo].[ActionTypeCulture] SET (LOCK_ESCALATION = TABLE)
GO
