SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaTiposCliente] (
		[CodTipoCliente]     [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoCliente]        [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Descripcion]        [char](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_inaTiposCliente]
		PRIMARY KEY
		CLUSTERED
		([CodTipoCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaTiposCliente] SET (LOCK_ESCALATION = TABLE)
GO
