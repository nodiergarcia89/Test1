SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Risk] (
		[RK_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RK_Title]                  [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PR_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_Status]                 [smallint] NULL,
		[RK_IdentifiedDate]         [float] NULL,
		[RK_ImpactDate]             [float] NULL,
		[RK_Attachments]            [smallint] NULL,
		[RK_Prefix]                 [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_AutoNum]                [int] NULL,
		[RK_EditBy]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_EditOn]                 [float] NULL,
		[RK_EditOverwriteBy]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_LastEditDate]           [float] NULL,
		[RK_Type]                   [smallint] NULL,
		[RK_PublishTo]              [int] NULL,
		[RK_CodeIssueRisk]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_DetailPreview]          [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RK_ContingencyPreview]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Risk__419E2A3F7ADC2F5E]
		PRIMARY KEY
		CLUSTERED
		([RK_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Risk]
	WITH CHECK
	ADD CONSTRAINT [FK__Risk__PR_Code__321755AF]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Risk]
	CHECK CONSTRAINT [FK__Risk__PR_Code__321755AF]

GO
ALTER TABLE [dbo].[Risk]
	WITH CHECK
	ADD CONSTRAINT [FK__Risk__RE_Code__330B79E8]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Risk]
	CHECK CONSTRAINT [FK__Risk__RE_Code__330B79E8]

GO
ALTER TABLE [dbo].[Risk]
	WITH CHECK
	ADD CONSTRAINT [FK__Risk__RK_CodeIss__33FF9E21]
	FOREIGN KEY ([RK_CodeIssueRisk]) REFERENCES [dbo].[Risk] ([RK_Code])
ALTER TABLE [dbo].[Risk]
	CHECK CONSTRAINT [FK__Risk__RK_CodeIss__33FF9E21]

GO
CREATE NONCLUSTERED INDEX [RK_ProjectResIndex]
	ON [dbo].[Risk] ([PR_Code], [RE_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [RK_ResIndex]
	ON [dbo].[Risk] ([RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Risk] SET (LOCK_ESCALATION = TABLE)
GO
