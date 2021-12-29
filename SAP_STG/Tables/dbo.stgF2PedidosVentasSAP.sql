SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2PedidosVentasSAP] (
		[CodEmpresa]                  [int] NOT NULL,
		[IdRegistro]                  [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumPedido]                   [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Linea_Pedido]                [int] NULL,
		[CodTipoPosicion]             [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TipoPosicion]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodClasePedido]              [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ClasePedido]                 [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[OrigenPedido]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaPedido]                 [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaPrevEntrega]            [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RefCliente]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodCanal]                    [int] NULL,
		[CodCliente]                  [int] NULL,
		[CodVendedor]                 [int] NULL,
		[CodRespAlta]                 [int] NULL,
		[CodRespAltaAd]               [int] NULL,
		[CodRespCuenta]               [int] NULL,
		[CodComisionista]             [int] NULL,
		[CodComisionistaAd]           [int] NULL,
		[CodSolicitante]              [int] NULL,
		[CodDestMercancia]            [int] NULL,
		[CodDestFactura]              [int] NULL,
		[CodRespPago]                 [int] NULL,
		[CodTransportista]            [int] NULL,
		[CodATC]                      [int] NULL,
		[CodFondoComercio]            [int] NULL,
		[CodCadena]                   [int] NULL,
		[CodArticulo]                 [int] NULL,
		[CodDelegacion]               [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCentro]                   [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodAlmacen]                  [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Empresa]                     [int] NOT NULL,
		[Signo]                       [int] NOT NULL,
		[CantidadPedida]              [numeric](26, 3) NULL,
		[Cantidad_StandardPedida]     [numeric](38, 9) NULL,
		[KilosCafePedido]             [numeric](38, 9) NULL,
		[Afecta_Stock]                [int] NOT NULL,
		[PrecioPedido]                [money] NULL,
		[ImportePedido]               [numeric](26, 2) NULL,
		[Pedido_timestamp]            [datetime] NULL,
		[FechaCreacion]               [int] NULL,
		[FechaModificacion]           [int] NULL,
		[create_timestamp]            [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2PedidosVentasSAP] SET (LOCK_ESCALATION = TABLE)
GO
