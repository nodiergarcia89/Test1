SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResSkill] (
		[RE_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SK_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RS_Level]             [int] NULL,
		[RS_ProposedLevel]     [int] NULL,
		[RS_Preference]        [int] NULL,
		[RS_Status]            [int] NULL,
		[RS_ProposedOn]        [float] NULL,
		[RS_ProposedBy]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RS_ReviewedOn]        [float] NULL,
		[RS_ReviewedBy]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RS_ApprovedOn]        [float] NULL,
		[RS_ApprovedBy]        [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RS_DateAcquired]      [float] NULL,
		[RS_LastUsed]          [float] NULL,
		[RS_LastEdit]          [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RS_LastEditDate]      [float] NULL,
		CONSTRAINT [PK__ResSkill__CB7F1BC9733B0D96]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [SK_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResSkill]
	WITH CHECK
	ADD CONSTRAINT [FK__ResSkill__RE_Cod__2E46C4CB]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResSkill]
	CHECK CONSTRAINT [FK__ResSkill__RE_Cod__2E46C4CB]

GO
ALTER TABLE [dbo].[ResSkill]
	WITH CHECK
	ADD CONSTRAINT [FK__ResSkill__SK_Cod__2F3AE904]
	FOREIGN KEY ([SK_Code]) REFERENCES [dbo].[Skill] ([SK_Code])
ALTER TABLE [dbo].[ResSkill]
	CHECK CONSTRAINT [FK__ResSkill__SK_Cod__2F3AE904]

GO
CREATE NONCLUSTERED INDEX [RS_SkillResIndex]
	ON [dbo].[ResSkill] ([SK_Code], [RE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ResSkill] SET (LOCK_ESCALATION = TABLE)
GO
