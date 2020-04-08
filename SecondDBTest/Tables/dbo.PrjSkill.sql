SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrjSkill] (
		[PR_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SK_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PS_Level]            [int] NULL,
		[PS_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[PS_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__PrjSkill__48E2739E4119A21D]
		PRIMARY KEY
		CLUSTERED
		([PR_Code], [SK_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[PrjSkill]
	WITH CHECK
	ADD CONSTRAINT [FK__PrjSkill__PR_Cod__188C8DD6]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[PrjSkill]
	CHECK CONSTRAINT [FK__PrjSkill__PR_Cod__188C8DD6]

GO
ALTER TABLE [dbo].[PrjSkill]
	WITH CHECK
	ADD CONSTRAINT [FK__PrjSkill__SK_Cod__1980B20F]
	FOREIGN KEY ([SK_Code]) REFERENCES [dbo].[Skill] ([SK_Code])
ALTER TABLE [dbo].[PrjSkill]
	CHECK CONSTRAINT [FK__PrjSkill__SK_Cod__1980B20F]

GO
CREATE NONCLUSTERED INDEX [PS_SkillPrjIndex]
	ON [dbo].[PrjSkill] ([SK_Code], [PR_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[PrjSkill] SET (LOCK_ESCALATION = TABLE)
GO
