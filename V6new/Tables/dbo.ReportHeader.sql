SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportHeader] (
		[RH_Key]               [int] IDENTITY(1, 1) NOT NULL,
		[RH_Name]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RH_ReportGroup]       [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RH_Title]             [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RH_Description]       [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RT_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RH_Type]              [int] NOT NULL,
		[RH_XmlDefinition]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RH_Active]            [smallint] NOT NULL,
		[RH_LastEdit]          [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[US_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RH_LastEditDate]      [float] NULL,
		[RH_UsageType]         [int] NULL,
		CONSTRAINT [PK__ReportHe__EC90BDB3049AA3C2]
		PRIMARY KEY
		CLUSTERED
		([RH_Key])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportHeader]
	WITH CHECK
	ADD CONSTRAINT [FK__ReportHea__RT_Co__713DB68B]
	FOREIGN KEY ([RT_Code]) REFERENCES [dbo].[ReportTemplate] ([RT_Code])
ALTER TABLE [dbo].[ReportHeader]
	CHECK CONSTRAINT [FK__ReportHea__RT_Co__713DB68B]

GO
ALTER TABLE [dbo].[ReportHeader] SET (LOCK_ESCALATION = TABLE)
GO
