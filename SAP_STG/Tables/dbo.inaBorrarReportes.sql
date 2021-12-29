SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaBorrarReportes] (
		[codEmpresa]               [int] NOT NULL,
		[nomIPad]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codPlantillaReportes]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Observaciones]            [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_inaBorrarReportes]
		PRIMARY KEY
		CLUSTERED
		([codEmpresa], [nomIPad], [codPlantillaReportes])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaBorrarReportes] SET (LOCK_ESCALATION = TABLE)
GO
