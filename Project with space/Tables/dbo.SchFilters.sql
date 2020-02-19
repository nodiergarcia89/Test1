SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SchFilters] (
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SF_Name]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SF_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SF_IncludeDates]     [smallint] NULL,
		[SF_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__SchFilte__5A87D5FF59463169]
		PRIMARY KEY
		CLUSTERED
		([US_Code], [SF_Name])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SchFilters] SET (LOCK_ESCALATION = TABLE)
GO
