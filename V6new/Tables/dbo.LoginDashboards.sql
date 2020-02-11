SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginDashboards] (
		[RD_Key]       [bigint] IDENTITY(1, 1) NOT NULL,
		[US_Code]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DSH_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__LoginDas__96F4E0FB6774552F]
		PRIMARY KEY
		CLUSTERED
		([RD_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginDashboards]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginDash__DSH_C__735B0927]
	FOREIGN KEY ([DSH_Code]) REFERENCES [dbo].[Dashboards] ([DSH_Code])
ALTER TABLE [dbo].[LoginDashboards]
	CHECK CONSTRAINT [FK__LoginDash__DSH_C__735B0927]

GO
ALTER TABLE [dbo].[LoginDashboards]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginDash__US_Co__744F2D60]
	FOREIGN KEY ([US_Code]) REFERENCES [dbo].[Users] ([US_Code])
ALTER TABLE [dbo].[LoginDashboards]
	CHECK CONSTRAINT [FK__LoginDash__US_Co__744F2D60]

GO
ALTER TABLE [dbo].[LoginDashboards] SET (LOCK_ESCALATION = TABLE)
GO
