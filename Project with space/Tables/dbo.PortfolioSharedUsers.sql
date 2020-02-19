SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PortfolioSharedUsers] (
		[PSU_Key]     [int] IDENTITY(1, 1) NOT NULL,
		[PFL_Key]     [int] NOT NULL,
		[US_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[PortfolioSharedUsers]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__PFL_K__491AB698]
	FOREIGN KEY ([PFL_Key]) REFERENCES [dbo].[Portfolio] ([PFL_Key])
ALTER TABLE [dbo].[PortfolioSharedUsers]
	CHECK CONSTRAINT [FK__Portfolio__PFL_K__491AB698]

GO
ALTER TABLE [dbo].[PortfolioSharedUsers]
	WITH CHECK
	ADD CONSTRAINT [FK__Portfolio__US_Co__4A0EDAD1]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[PortfolioSharedUsers]
	CHECK CONSTRAINT [FK__Portfolio__US_Co__4A0EDAD1]

GO
CREATE UNIQUE NONCLUSTERED INDEX [PSU_PortfolioKeyUser]
	ON [dbo].[PortfolioSharedUsers] ([PFL_Key], [US_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[PortfolioSharedUsers] SET (LOCK_ESCALATION = TABLE)
GO
