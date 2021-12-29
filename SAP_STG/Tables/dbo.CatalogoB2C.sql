SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CatalogoB2C] (
		[PRODUCTO]                      [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IMAGEN]                        [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[tarifa bar]                    [money] NULL,
		[PRECIO WEB]                    [float] NULL,
		[NOMBRE]                        [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DESCRIPCIÓN (LARGA)]           [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[INGREDIENTES]                  [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CATEGORÍA]                     [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SKU]                           [float] NULL,
		[IMAGEN1]                       [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DIMENSIONES (PESO/TAMAÑO)]     [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CatalogoB2C] SET (LOCK_ESCALATION = TABLE)
GO
