SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Skill] (
		[SK_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SK_Desc]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SK_MinLevel]            [int] NULL,
		[SK_MaxLevel]            [int] NULL,
		[SK_Null]                [smallint] NULL,
		[SK_Status1]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SK_Status2]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SK_Status3]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SK_Active]              [smallint] NOT NULL,
		[SK_LastEdit]            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SK_EditBy]              [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SK_EditOn]              [float] NULL,
		[SK_EditOverwriteBy]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SK_LastEditDate]        [float] NULL,
		CONSTRAINT [PK__Skill__21013E1D702996C1]
		PRIMARY KEY
		CLUSTERED
		([SK_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Skill] SET (LOCK_ESCALATION = TABLE)
GO
