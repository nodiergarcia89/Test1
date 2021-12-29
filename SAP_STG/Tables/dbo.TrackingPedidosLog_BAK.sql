SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrackingPedidosLog_BAK] (
		[codEmpresa]               [int] NOT NULL,
		[nomIPad]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codPedido]                [int] NOT NULL,
		[codCliente]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[estadoTracking]           [tinyint] NOT NULL,
		[FechaRegistro]            [datetime] NOT NULL,
		[NumPedidoSAP]             [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaEntregaPrevista]     [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumAlbaran]               [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumFactura]               [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Email]                    [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaNotificado]          [datetime] NULL,
		[Notificado]               [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TrackingPedidosLog_BAK] SET (LOCK_ESCALATION = TABLE)
GO
