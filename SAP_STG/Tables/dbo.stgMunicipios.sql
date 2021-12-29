SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgMunicipios] (
		[CodProvincia]     [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Nombre]           [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EsCalle]          [bit] NULL,
		[CP]               [char](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Descripcion]      [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgMunicipios] SET (LOCK_ESCALATION = TABLE)
GO
