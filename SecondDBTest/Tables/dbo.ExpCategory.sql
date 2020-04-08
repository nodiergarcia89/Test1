SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExpCategory] (
		[EC_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EC_Desc]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EC_Status1]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EC_Status2]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EC_Status3]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EC_Active]            [smallint] NULL,
		[EC_SystemDefault]     [smallint] NULL,
		[EC_LastEdit]          [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EC_LastEditDate]      [float] NULL,
		CONSTRAINT [PK__ExpCateg__C7016FF807220AB2]
		PRIMARY KEY
		CLUSTERED
		([EC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ExpCategory] SET (LOCK_ESCALATION = TABLE)
GO
