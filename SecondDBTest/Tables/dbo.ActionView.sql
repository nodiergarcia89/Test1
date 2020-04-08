SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionView] (
		[AV_Key]                                 [int] NOT NULL,
		[AV_Name]                                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AV_Desc]                                [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AT_Default]                             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AV_DashboardSiteMapTab]                 [smallint] NULL,
		[AV_AllActionTypes]                      [smallint] NOT NULL,
		[AV_ViewType]                            [smallint] NULL,
		[AV_Active]                              [smallint] NOT NULL,
		[AV_LastEdit]                            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AV_LastEditDate]                        [float] NOT NULL,
		[US_Code]                                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RH_Key]                                 [int] NULL,
		[AV_CreateArchiveReportOnCompletion]     [smallint] NULL,
		[AV_VisibleOnSearch]                     [smallint] NULL,
		[AV_ProjectDashboardTab]                 [int] NULL,
		[AV_VisibleOnAddMenu]                    [smallint] NULL,
		[test]                                   [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ActionVi__6A86C5705165187F]
		PRIMARY KEY
		CLUSTERED
		([AV_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ActionView]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionVie__AT_De__2FDA0782]
	FOREIGN KEY ([AT_Default]) REFERENCES [dbo].[ActionType] ([AT_Code])
ALTER TABLE [dbo].[ActionView]
	CHECK CONSTRAINT [FK__ActionVie__AT_De__2FDA0782]

GO
ALTER TABLE [dbo].[ActionView]
	WITH CHECK
	ADD CONSTRAINT [FK__ActionVie__RH_Ke__30CE2BBB]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[ActionView]
	CHECK CONSTRAINT [FK__ActionVie__RH_Ke__30CE2BBB]

GO
ALTER TABLE [dbo].[ActionView] SET (LOCK_ESCALATION = TABLE)
GO
