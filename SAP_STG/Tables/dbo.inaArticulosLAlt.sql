SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaArticulosLAlt] (
		[codEmpresa]           [int] NOT NULL,
		[codArticulo]          [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[linArticulosLAlt]     [int] NOT NULL,
		[codAlternativo]       [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[flaVtaCruzada]        [tinyint] NOT NULL,
		CONSTRAINT [PK_inaArticulosLAlt]
		PRIMARY KEY
		CLUSTERED
		([codEmpresa], [codArticulo], [linArticulosLAlt])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaArticulosLAlt] SET (LOCK_ESCALATION = TABLE)
GO
