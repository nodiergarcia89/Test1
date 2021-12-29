SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [aux].[ReportOrden] (
		[IdReport]        [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ClaveOrden]      [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Descripcion]     [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Orden]           [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [aux].[ReportOrden] SET (LOCK_ESCALATION = TABLE)
GO
