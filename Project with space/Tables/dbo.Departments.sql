SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Departments] (
		[DE_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DE_Desc]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Status1]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Status2]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Status3]          [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_Active]           [smallint] NOT NULL,
		[DE_LastEdit]         [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_CodeParent]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RE_CodeManager]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DE_LastEditDate]     [float] NULL,
		[DE_CanDemand]        [smallint] NULL,
		CONSTRAINT [PK__Departme__801CC08277DFC722]
		PRIMARY KEY
		CLUSTERED
		([DE_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[Departments]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__DE_Co__52EE3995]
	FOREIGN KEY ([DE_CodeParent]) REFERENCES [dbo].[Departments] ([DE_Code])
ALTER TABLE [dbo].[Departments]
	CHECK CONSTRAINT [FK__Departmen__DE_Co__52EE3995]

GO
ALTER TABLE [dbo].[Departments]
	WITH CHECK
	ADD CONSTRAINT [FK__Departmen__RE_Co__53E25DCE]
	FOREIGN KEY ([RE_CodeManager]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[Departments]
	CHECK CONSTRAINT [FK__Departmen__RE_Co__53E25DCE]

GO
CREATE NONCLUSTERED INDEX [DE_CodeParentIndex]
	ON [dbo].[Departments] ([DE_CodeParent], [DE_Code])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DE_RECodeManagerIndex]
	ON [dbo].[Departments] ([RE_CodeManager], [DE_Code])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Departments] SET (LOCK_ESCALATION = TABLE)
GO
