SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Nominal] (
		[NC_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NC_Desc]                 [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NC_TimesheetNominal]     [smallint] NULL,
		[NC_ExpenseNominal]       [smallint] NULL,
		[Active]                  [smallint] NULL,
		[NC_LastEdit]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NC_LastEditDate]         [float] NULL,
		CONSTRAINT [PK__Nominal__C8D2D6BE162F4418]
		PRIMARY KEY
		CLUSTERED
		([NC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Nominal] SET (LOCK_ESCALATION = TABLE)
GO
