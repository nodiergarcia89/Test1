SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Activity] (
		[AC_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AC_Desc]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AC_Nonchargeable]     [smallint] NULL,
		[AC_AllRes]            [smallint] NULL,
		[AC_AllPrj]            [smallint] NULL,
		[AC_Status1]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AC_Status2]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AC_Status3]           [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Active]               [smallint] NULL,
		[AC_LastEdit]          [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AC_Prefix]            [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AC_AutoNum]           [int] NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AC_LastEditDate]      [float] NULL,
		[AC_Absence]           [smallint] NULL,
		[PR_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__Activity__266032935EBF139D]
		PRIMARY KEY
		CLUSTERED
		([AC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Activity]
	WITH CHECK
	ADD CONSTRAINT [FK__Activity__PR_Cod__377B294A]
	FOREIGN KEY ([PR_Code]) REFERENCES [dbo].[Projects] ([PR_Code])
ALTER TABLE [dbo].[Activity]
	CHECK CONSTRAINT [FK__Activity__PR_Cod__377B294A]

GO
ALTER TABLE [dbo].[Activity] SET (LOCK_ESCALATION = TABLE)
GO
