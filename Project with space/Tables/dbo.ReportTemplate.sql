SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReportTemplate] (
		[RT_Code]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RT_Desc]              [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RT_XmlDefinition]     [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RT_Active]            [smallint] NOT NULL,
		CONSTRAINT [PK__ReportTe__2E7DCDD413DCE752]
		PRIMARY KEY
		CLUSTERED
		([RT_Code])
	ON [PRIMARY]
)
GO
ALTER TABLE [dbo].[ReportTemplate] SET (LOCK_ESCALATION = TABLE)
GO
