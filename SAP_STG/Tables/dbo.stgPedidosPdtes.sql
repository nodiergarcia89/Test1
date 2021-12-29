SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgPedidosPdtes] (
		[NumPedido]               [int] NOT NULL,
		[NumLinea]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDelegacion]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTipoPedido]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaPedido_Key]         [int] NOT NULL,
		[FechaPrefEnt_Key]        [int] NOT NULL,
		[CodCliente]              [int] NOT NULL,
		[NumPedidoClte]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCentro]               [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodAlmacen]              [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DocCompras]              [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArticulo]             [int] NOT NULL,
		[CantidadPedidaTotal]     [numeric](15, 3) NOT NULL,
		[UMA]                     [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumAlbaranUT]            [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaAlbaranUT_key]      [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CantidadServida]         [numeric](38, 3) NOT NULL,
		[CantPendiente]           [numeric](38, 3) NOT NULL,
		[NuevaFechaEnt]           [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MotivoNFEnt]             [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Importe]                 [money] NOT NULL,
		[ImporteCoste]            [money] NOT NULL,
		[create_timestamp]        [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgPedidosPdtes] SET (LOCK_ESCALATION = TABLE)
GO
