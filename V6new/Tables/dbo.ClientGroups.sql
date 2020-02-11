SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientGroups] (
		[CG_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CG_Desc]                [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CG_CodeParent]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CG_TopLevel]            [int] NULL,
		[Active]                 [smallint] NULL,
		[CG_EditBy]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CG_EditOn]              [float] NULL,
		[CG_EditOverwriteBy]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CG_LastEditDate]        [float] NULL,
		[CG_LastEdit]            [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ClientGr__4B8DB42616CE6296]
		PRIMARY KEY
		CLUSTERED
		([CG_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ClientGroups]
	WITH CHECK
	ADD CONSTRAINT [FK__ClientGro__CG_Co__00EA0E6F]
	FOREIGN KEY ([CG_CodeParent]) REFERENCES [dbo].[ClientGroups] ([CG_Code])
ALTER TABLE [dbo].[ClientGroups]
	CHECK CONSTRAINT [FK__ClientGro__CG_Co__00EA0E6F]

GO
CREATE NONCLUSTERED INDEX [CG_DescIndex]
	ON [dbo].[ClientGroups] ([CG_Desc])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClientGroups] SET (LOCK_ESCALATION = TABLE)
GO
