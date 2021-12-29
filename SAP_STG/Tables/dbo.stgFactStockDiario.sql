SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgFactStockDiario] (
		[FechaProceso_key]          [int] NOT NULL,
		[CodCentro]                 [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodAlmacen]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArticulo]               [int] NOT NULL,
		[CantLibreUtilizacion]      [numeric](15, 3) NOT NULL,
		[StockEncurso]              [numeric](15, 3) NOT NULL,
		[PedidosCliente]            [numeric](15, 3) NOT NULL,
		[EntregaCliente]            [numeric](15, 3) NOT NULL,
		[OrdEntrPedido]             [numeric](15, 3) NOT NULL,
		[StockDisponible]           [numeric](15, 3) NOT NULL,
		[StockDispCafeBueno]        [numeric](15, 3) NOT NULL,
		[StockDispCafeCaducado]     [numeric](15, 3) NOT NULL,
		[ValorLibreUtilizacion]     [money] NOT NULL,
		[create_timestamp]          [datetime] NOT NULL,
		CONSTRAINT [PK_stgFactStockDiario]
		PRIMARY KEY
		CLUSTERED
		([FechaProceso_key], [CodCentro], [CodAlmacen], [CodArticulo])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgFactStockDiario]
	ADD
	CONSTRAINT [DF_stgFactStockDiario_StockDispCafeBueno]
	DEFAULT ((0)) FOR [StockDispCafeBueno]
GO
ALTER TABLE [dbo].[stgFactStockDiario]
	ADD
	CONSTRAINT [DF_stgFactStockDiario_StockDispCafeCaducado]
	DEFAULT ((0)) FOR [StockDispCafeCaducado]
GO
ALTER TABLE [dbo].[stgFactStockDiario] SET (LOCK_ESCALATION = TABLE)
GO
