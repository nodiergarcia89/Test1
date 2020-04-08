SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportCulture] (
		[RH_Key]             [int] NOT NULL,
		[CLC_Code]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RC_ReportGroup]     [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RC_Title]           [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RC_Description]     [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__ReportCu__C7F680A97CF981FA]
		PRIMARY KEY
		CLUSTERED
		([RH_Key], [CLC_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__ReportCul__CLC_C__6D6D25A7]
	FOREIGN KEY ([CLC_Code]) REFERENCES [dbo].[CultureCodes] ([CLC_Code])
ALTER TABLE [dbo].[ReportCulture]
	CHECK CONSTRAINT [FK__ReportCul__CLC_C__6D6D25A7]

GO
ALTER TABLE [dbo].[ReportCulture]
	WITH CHECK
	ADD CONSTRAINT [FK__ReportCul__RH_Ke__6E6149E0]
	FOREIGN KEY ([RH_Key]) REFERENCES [dbo].[ReportHeader] ([RH_Key])
ALTER TABLE [dbo].[ReportCulture]
	CHECK CONSTRAINT [FK__ReportCul__RH_Ke__6E6149E0]

GO
ALTER TABLE [dbo].[ReportCulture] SET (LOCK_ESCALATION = TABLE)
GO
