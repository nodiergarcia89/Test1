SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Location] (
		[LO_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LO_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LO_Status1]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LO_Status2]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LO_Status3]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LO_Active]           [smallint] NOT NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LO_LastEditDate]     [float] NOT NULL,
		[LO_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Location__16A3E985546180BB]
		PRIMARY KEY
		CLUSTERED
		([LO_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Location] SET (LOCK_ESCALATION = TABLE)
GO
