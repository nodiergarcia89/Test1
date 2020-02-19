SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemCalendar] (
		[SC_Date]             [float] NOT NULL,
		[SC_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SC_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SC_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__SystemCa__907DF06D005FFE8A]
		PRIMARY KEY
		CLUSTERED
		([SC_Date])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SystemCalendar] SET (LOCK_ESCALATION = TABLE)
GO
