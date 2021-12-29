SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SourceFases] (
		[idFase]      [tinyint] NOT NULL,
		[DesFase]     [char](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_SourceFases]
		PRIMARY KEY
		CLUSTERED
		([idFase])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SourceFases] SET (LOCK_ESCALATION = TABLE)
GO
