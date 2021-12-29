SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgAlbaranesPdtes] (
		[NumAlbaran]               [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaAlbaran]             [int] NOT NULL,
		[FechaSalidaMercancia]     [int] NOT NULL,
		[FechaPlanificada]         [int] NOT NULL,
		[CodCliente]               [int] NOT NULL,
		[CodDestMercancias]        [int] NOT NULL,
		[CodArticulo]              [int] NOT NULL,
		[CodCentro]                [int] NOT NULL,
		[CodAlmacen]               [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodAutoventa]             [int] NOT NULL,
		[CantEntrega]              [numeric](13, 3) NOT NULL,
		[Importe]                  [money] NOT NULL,
		[ImporteCoste]             [money] NOT NULL,
		[EstConta]                 [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]         [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgAlbaranesPdtes]
	ADD
	CONSTRAINT [DF_stgAlbaranesPdtes_CodAutoventa]
	DEFAULT ((0)) FOR [CodAutoventa]
GO
ALTER TABLE [dbo].[stgAlbaranesPdtes]
	ADD
	CONSTRAINT [DF_stgAlbaranesPdtes_ImporteCoste]
	DEFAULT ((0)) FOR [ImporteCoste]
GO
ALTER TABLE [dbo].[stgAlbaranesPdtes]
	ADD
	CONSTRAINT [DF_stgAlbaranesPdtes_create_timestamp]
	DEFAULT ((0)) FOR [create_timestamp]
GO
ALTER TABLE [dbo].[stgAlbaranesPdtes] SET (LOCK_ESCALATION = TABLE)
GO
