SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LocaleHeader] (
		[LH_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LH_Desc]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LH_Active]            [smallint] NOT NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LH_LastEditDate]      [float] NOT NULL,
		[LH_LastEdit]          [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LH_SystemDefault]     [smallint] NOT NULL,
		[LH_DayLength]         [float] NULL,
		[LH_FTE]               [float] NULL,
		CONSTRAINT [PK__LocaleHe__164CF4E14CC05EF3]
		PRIMARY KEY
		CLUSTERED
		([LH_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[LocaleHeader] SET (LOCK_ESCALATION = TABLE)
GO
