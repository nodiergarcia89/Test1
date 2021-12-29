SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaCatalogosDelegacion] (
		[CodEmpresa]        [int] NOT NULL,
		[CodCatalogo]       [char](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDelegacion]     [int] NOT NULL,
		CONSTRAINT [PK_inaCatalogosDelegacion]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCatalogo], [CodDelegacion])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaCatalogosDelegacion] SET (LOCK_ESCALATION = TABLE)
GO
