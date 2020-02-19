SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecurityGroupCli] (
		[SG_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CL_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__Security__B812892060E75331]
		PRIMARY KEY
		CLUSTERED
		([SG_Code], [CL_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SecurityGroupCli]
	WITH CHECK
	ADD CONSTRAINT [FK__SecurityG__CL_Co__583CFE97]
	FOREIGN KEY ([CL_Code]) REFERENCES [dbo].[Clients] ([CL_Code])
ALTER TABLE [dbo].[SecurityGroupCli]
	CHECK CONSTRAINT [FK__SecurityG__CL_Co__583CFE97]

GO
ALTER TABLE [dbo].[SecurityGroupCli]
	WITH CHECK
	ADD CONSTRAINT [FK__SecurityG__SG_Co__593122D0]
	FOREIGN KEY ([SG_Code]) REFERENCES [dbo].[SecurityGroup] ([SG_Code])
ALTER TABLE [dbo].[SecurityGroupCli]
	CHECK CONSTRAINT [FK__SecurityG__SG_Co__593122D0]

GO
ALTER TABLE [dbo].[SecurityGroupCli] SET (LOCK_ESCALATION = TABLE)
GO
