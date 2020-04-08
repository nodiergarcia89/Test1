SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaskSkill] (
		[TA_Key]          [int] NOT NULL,
		[SK_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TS_Level]        [int] NULL,
		[TS_LastEdit]     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__TaskSkil__09FBC5E023A93AC7]
		PRIMARY KEY
		CLUSTERED
		([TA_Key], [SK_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TaskSkill]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskSkill__SK_Co__6F2063EF]
	FOREIGN KEY ([SK_Code]) REFERENCES [dbo].[Skill] ([SK_Code])
ALTER TABLE [dbo].[TaskSkill]
	CHECK CONSTRAINT [FK__TaskSkill__SK_Co__6F2063EF]

GO
ALTER TABLE [dbo].[TaskSkill]
	WITH CHECK
	ADD CONSTRAINT [FK__TaskSkill__TA_Ke__70148828]
	FOREIGN KEY ([TA_Key]) REFERENCES [dbo].[Task] ([TA_Key])
ALTER TABLE [dbo].[TaskSkill]
	CHECK CONSTRAINT [FK__TaskSkill__TA_Ke__70148828]

GO
ALTER TABLE [dbo].[TaskSkill] SET (LOCK_ESCALATION = TABLE)
GO
