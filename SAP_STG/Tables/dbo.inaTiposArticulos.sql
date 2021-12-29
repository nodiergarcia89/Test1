SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaTiposArticulos] (
		[CodTipoMaterial]     [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoMaterial]        [char](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Ina]                 [bit] NOT NULL,
		CONSTRAINT [PK_inaTiposArticulos]
		PRIMARY KEY
		CLUSTERED
		([CodTipoMaterial])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaTiposArticulos]
	ADD
	CONSTRAINT [DF_inaTiposArticulos_Ina]
	DEFAULT ((0)) FOR [Ina]
GO
ALTER TABLE [dbo].[inaTiposArticulos] SET (LOCK_ESCALATION = TABLE)
GO
