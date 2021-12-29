SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaAgentesSuperv] (
		[CodEmpresa]        [int] NOT NULL,
		[CodAgenteS]        [int] NOT NULL,
		[CodAgente]         [int] NOT NULL,
		[Observaciones]     [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_inaAgentesSuperv]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodAgenteS], [CodAgente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaAgentesSuperv] SET (LOCK_ESCALATION = TABLE)
GO
