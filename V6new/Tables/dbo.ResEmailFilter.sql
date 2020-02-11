SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResEmailFilter] (
		[RE_Code]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RE_EmailFilter]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK__ResEmail__7D513B8254B68676]
		PRIMARY KEY
		CLUSTERED
		([RE_Code], [RE_EmailFilter])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ResEmailFilter]
	WITH CHECK
	ADD CONSTRAINT [FK__ResEmailF__RE_Co__1FF8A574]
	FOREIGN KEY ([RE_Code]) REFERENCES [dbo].[Res] ([RE_Code])
ALTER TABLE [dbo].[ResEmailFilter]
	CHECK CONSTRAINT [FK__ResEmailF__RE_Co__1FF8A574]

GO
ALTER TABLE [dbo].[ResEmailFilter] SET (LOCK_ESCALATION = TABLE)
GO
