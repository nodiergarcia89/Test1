SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgIna_iClientesF1] (
		[CodEmpresa]        [tinyint] NOT NULL,
		[CodCliente]        [int] NOT NULL,
		[NumContacto]       [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NombrePila]        [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NombreCliente]     [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Telefono]          [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Observaciones]     [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Titulo]            [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_stgIna_iClientesF1]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgIna_iClientesF1] SET (LOCK_ESCALATION = TABLE)
GO
