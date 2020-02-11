SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecurityGroupPrj] (
		[SG_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PR_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Security__1BDA5E72688874F9]
		PRIMARY KEY
		CLUSTERED
		([SG_Code], [PR_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SecurityGroupPrj]
	WITH CHECK
	ADD CONSTRAINT [FK__SecurityG__PR_Co__5C0D8F7B]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[SecurityGroupPrj]
	CHECK CONSTRAINT [FK__SecurityG__PR_Co__5C0D8F7B]

GO
ALTER TABLE [dbo].[SecurityGroupPrj]
	WITH CHECK
	ADD CONSTRAINT [FK__SecurityG__SG_Co__5D01B3B4]
	FOREIGN KEY ([SG_Code]) REFERENCES [dbo].[SecurityGroup] ([SG_Code])
ALTER TABLE [dbo].[SecurityGroupPrj]
	CHECK CONSTRAINT [FK__SecurityG__SG_Co__5D01B3B4]

GO
ALTER TABLE [dbo].[SecurityGroupPrj] SET (LOCK_ESCALATION = TABLE)
GO
