SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [aux].[ArticulosSinImagen] (
		[FechaProceso]      [int] NOT NULL,
		[codFamilia]        [int] NOT NULL,
		[desFamilia]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codSubFamilia]     [int] NOT NULL,
		[desSubFamilia]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codArticulo]       [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desArticulo]       [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_ArticulosSinImagen]
		PRIMARY KEY
		CLUSTERED
		([FechaProceso], [codArticulo])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [aux].[ArticulosSinImagen] SET (LOCK_ESCALATION = TABLE)
GO
