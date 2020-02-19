SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecurityGroupRes] (
		[SG_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Security__63E388F76C5905DD]
		PRIMARY KEY
		CLUSTERED
		([SG_Code], [RE_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SecurityGroupRes]
	WITH CHECK
	ADD CONSTRAINT [FK__SecurityG__RE_Co__5DF5D7ED]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[SecurityGroupRes]
	CHECK CONSTRAINT [FK__SecurityG__RE_Co__5DF5D7ED]

GO
ALTER TABLE [dbo].[SecurityGroupRes]
	WITH CHECK
	ADD CONSTRAINT [FK__SecurityG__SG_Co__5EE9FC26]
	FOREIGN KEY ([SG_Code]) REFERENCES [dbo].[SecurityGroup] ([SG_Code])
ALTER TABLE [dbo].[SecurityGroupRes]
	CHECK CONSTRAINT [FK__SecurityG__SG_Co__5EE9FC26]

GO
ALTER TABLE [dbo].[SecurityGroupRes] SET (LOCK_ESCALATION = TABLE)
GO
