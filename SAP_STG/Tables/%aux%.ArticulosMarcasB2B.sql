SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [aux].[ArticulosMarcasB2B] (
		[codEmpresa]      [int] NOT NULL,
		[codArticulo]     [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datMarcas]       [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [aux].[ArticulosMarcasB2B] SET (LOCK_ESCALATION = TABLE)
GO
