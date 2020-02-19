SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserProxy] (
		[US_Code]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[US_CodeProxy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__UserProx__72261D307889D298]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [US_CodeProxy])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[UserProxy]
	WITH CHECK
	ADD CONSTRAINT [FK__UserProxy__US_Co__172E5549]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[UserProxy]
	CHECK CONSTRAINT [FK__UserProxy__US_Co__172E5549]

GO
ALTER TABLE [dbo].[UserProxy]
	WITH CHECK
	ADD CONSTRAINT [FK__UserProxy__US_Co__18227982]
	FOREIGN KEY ([US_CodeProxy]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[UserProxy]
	CHECK CONSTRAINT [FK__UserProxy__US_Co__18227982]

GO
ALTER TABLE [dbo].[UserProxy] SET (LOCK_ESCALATION = TABLE)
GO
