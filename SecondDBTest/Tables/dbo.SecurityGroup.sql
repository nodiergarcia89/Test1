SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecurityGroup] (
		[SG_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SG_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SG_Status1]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SG_Status2]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SG_Status3]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SG_Active]           [smallint] NULL,
		[SG_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SG_LastEditDate]     [float] NULL,
		CONSTRAINT [PK__Security__F37578755D16C24D]
		PRIMARY KEY
		CLUSTERED
		([SG_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[SecurityGroup] SET (LOCK_ESCALATION = TABLE)
GO
