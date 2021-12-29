SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaCatalogos] (
		[CodEmpresa]      [int] NOT NULL,
		[CodCatalogo]     [char](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desCatalogo]     [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[obsCatalogo]     [char](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Ina]             [bit] NOT NULL,
		CONSTRAINT [PK_inaCatalogos]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCatalogo])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaCatalogos]
	ADD
	CONSTRAINT [DF_inaCatalogos_Ina]
	DEFAULT ((0)) FOR [Ina]
GO
ALTER TABLE [dbo].[inaCatalogos] SET (LOCK_ESCALATION = TABLE)
GO
