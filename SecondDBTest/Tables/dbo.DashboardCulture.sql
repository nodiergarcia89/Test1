SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DashboardCulture] (
		[DSH_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CLC_Code]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DSC_Name]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Dashboar__3AE6B8D01A69E950]
		PRIMARY KEY
		CLUSTERED
		([DSH_Code], [CLC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DashboardCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__Dashboard__DSH_C__2803DB90]
	FOREIGN KEY ([DSH_Code]) REFERENCES [dbo].[Dashboards] ([DSH_Code])
ALTER TABLE [dbo].[DashboardCulture]
	CHECK CONSTRAINT [FK__Dashboard__DSH_C__2803DB90]

GO
ALTER TABLE [dbo].[DashboardCulture] SET (LOCK_ESCALATION = TABLE)
GO
