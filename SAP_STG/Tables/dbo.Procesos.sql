SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Procesos] (
		[IdProceso]     [int] NOT NULL,
		[Proceso]       [char](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_Procesos]
		PRIMARY KEY
		CLUSTERED
		([IdProceso])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Procesos] SET (LOCK_ESCALATION = TABLE)
GO
