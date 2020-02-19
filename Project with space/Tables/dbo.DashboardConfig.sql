SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DashboardConfig] (
		[DSH_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DC_Type]             [smallint] NOT NULL,
		[DC_TypeCode]         [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DC_ConfigXML]        [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DC_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DC_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__Dashboar__3C899F641699586C]
		PRIMARY KEY
		CLUSTERED
		([DSH_Code], [DC_Type], [DC_TypeCode])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[DashboardConfig]
	WITH CHECK
	ADD CONSTRAINT [FK__Dashboard__DSH_C__270FB757]
	FOREIGN KEY ([DSH_Code]) REFERENCES [dbo].[Dashboards] ([DSH_Code])
ALTER TABLE [dbo].[DashboardConfig]
	CHECK CONSTRAINT [FK__Dashboard__DSH_C__270FB757]

GO
ALTER TABLE [dbo].[DashboardConfig] SET (LOCK_ESCALATION = TABLE)
GO
