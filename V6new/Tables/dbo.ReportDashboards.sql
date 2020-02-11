SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportDashboards] (
		[RH_Key]       [int] NOT NULL,
		[DSH_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ReportDa__5D88B5EF00CA12DE]
		PRIMARY KEY
		CLUSTERED
		([RH_Key], [DSH_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportDashboards]
	WITH CHECK
	ADD CONSTRAINT [FK__ReportDas__DSH_C__6F556E19]
	FOREIGN KEY ([DSH_Code]) REFERENCES [dbo].[Dashboards] ([DSH_Code])
ALTER TABLE [dbo].[ReportDashboards]
	CHECK CONSTRAINT [FK__ReportDas__DSH_C__6F556E19]

GO
ALTER TABLE [dbo].[ReportDashboards]
	WITH CHECK
	ADD CONSTRAINT [FK__ReportDas__RH_Ke__70499252]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[ReportDashboards]
	CHECK CONSTRAINT [FK__ReportDas__RH_Ke__70499252]

GO
ALTER TABLE [dbo].[ReportDashboards] SET (LOCK_ESCALATION = TABLE)
GO
