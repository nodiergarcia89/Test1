SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoginGroupReports] (
		[LG_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RH_Key]      [int] NOT NULL,
		CONSTRAINT [PK_LoginGroupReports]
		PRIMARY KEY
		CLUSTERED
		([LG_Code], [RH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LoginGroupReports]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__LG_Co__00B50445]
	FOREIGN KEY ([LG_Code]) REFERENCES [dbo].[LoginGroup] ([LG_Code])
ALTER TABLE [dbo].[LoginGroupReports]
	CHECK CONSTRAINT [FK__LoginGrou__LG_Co__00B50445]

GO
ALTER TABLE [dbo].[LoginGroupReports]
	WITH CHECK
	ADD CONSTRAINT [FK__LoginGrou__RH_Ke__01A9287E]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[LoginGroupReports]
	CHECK CONSTRAINT [FK__LoginGrou__RH_Ke__01A9287E]

GO
ALTER TABLE [dbo].[LoginGroupReports] SET (LOCK_ESCALATION = TABLE)
GO
