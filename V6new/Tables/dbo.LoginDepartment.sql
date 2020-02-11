SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginDepartment] (
		[US_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_Code]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LD_ViewDepProfile]     [smallint] NULL,
		[LD_MainDepProfile]     [smallint] NULL,
		CONSTRAINT [PK__LoginDep__586BC5686B44E613]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [DE_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginDepartment]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginDepa__DE_Co__75435199]
	FOREIGN KEY ([DE_Code]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[LoginDepartment]
	CHECK CONSTRAINT [FK__LoginDepa__DE_Co__75435199]

GO
ALTER TABLE [dbo].[LoginDepartment]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginDepa__US_Co__763775D2]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginDepartment]
	CHECK CONSTRAINT [FK__LoginDepa__US_Co__763775D2]

GO
ALTER TABLE [dbo].[LoginDepartment] SET (LOCK_ESCALATION = TABLE)
GO
