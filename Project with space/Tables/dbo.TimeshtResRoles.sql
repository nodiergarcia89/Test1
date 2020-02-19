SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TimeshtResRoles] (
		[RE_Code]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_CodeRole]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__TimeshtR__E43425BF51700577]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [RE_CodeRole])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[TimeshtResRoles]
	WITH CHECK
	ADD CONSTRAINT [FK__TimeshtRe__RE_Co__0AC87E64]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[TimeshtResRoles]
	CHECK CONSTRAINT [FK__TimeshtRe__RE_Co__0AC87E64]

GO
ALTER TABLE [dbo].[TimeshtResRoles]
	WITH CHECK
	ADD CONSTRAINT [FK__TimeshtRe__RE_Co__0BBCA29D]
	FOREIGN KEY ([RE_CodeRole]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[TimeshtResRoles]
	CHECK CONSTRAINT [FK__TimeshtRe__RE_Co__0BBCA29D]

GO
ALTER TABLE [dbo].[TimeshtResRoles] SET (LOCK_ESCALATION = TABLE)
GO
