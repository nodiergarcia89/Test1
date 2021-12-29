SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [aux].[ArticulosSinImagen$Changes] (
		[desFamilia]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desSubFamilia]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codArticulo]       [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desArticulo]       [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [aux].[ArticulosSinImagen$Changes] SET (LOCK_ESCALATION = TABLE)
GO
