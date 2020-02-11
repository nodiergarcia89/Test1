SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProfileDemandSkill] (
		[PDS_Key]     [int] IDENTITY(1, 1) NOT NULL,
		[PDL_Key]     [int] NOT NULL,
		[SK_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ProfileD__44C14A777A521F79]
		PRIMARY KEY
		CLUSTERED
		([PDS_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ProfileDemandSkill]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__PDL_K__3528CC84]
	FOREIGN KEY ([PDL_Key]) REFERENCES [dbo].[ProfileDemandLine] ([PDL_Key])
ALTER TABLE [dbo].[ProfileDemandSkill]
	CHECK CONSTRAINT [FK__ProfileDe__PDL_K__3528CC84]

GO
ALTER TABLE [dbo].[ProfileDemandSkill]
	WITH CHECK
	ADD CONSTRAINT [FK__ProfileDe__SK_Co__361CF0BD]
	FOREIGN KEY ([SK_Code]) REFERENCES [dbo].[Skill] ([SK_Code])
ALTER TABLE [dbo].[ProfileDemandSkill]
	CHECK CONSTRAINT [FK__ProfileDe__SK_Co__361CF0BD]

GO
ALTER TABLE [dbo].[ProfileDemandSkill] SET (LOCK_ESCALATION = TABLE)
GO
