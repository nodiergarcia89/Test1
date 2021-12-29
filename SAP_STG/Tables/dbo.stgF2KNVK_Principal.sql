SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2KNVK_Principal] (
		[CodEmpresa]           [int] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[NumContacto]          [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NombrePila]           [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NombreCliente]        [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Telefono]             [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Observaciones]        [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Titulo]               [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[RowN]                 [bigint] NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_stgF2KNVK_Principal]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2KNVK_Principal] SET (LOCK_ESCALATION = TABLE)
GO
