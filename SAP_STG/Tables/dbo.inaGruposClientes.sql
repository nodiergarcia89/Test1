SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaGruposClientes] (
		[CodGrupoClientes]     [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GrupoClientes]        [char](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Ina]                  [bit] NULL,
		CONSTRAINT [PK_inaGruposClientes]
		PRIMARY KEY
		CLUSTERED
		([CodGrupoClientes])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaGruposClientes] SET (LOCK_ESCALATION = TABLE)
GO
