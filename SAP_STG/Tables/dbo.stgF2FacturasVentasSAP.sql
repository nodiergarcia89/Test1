SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2FacturasVentasSAP] (
		[CodEmpresa]                   [tinyint] NOT NULL,
		[IdRegistro]                   [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Num_Factura]                  [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Linea_Factura]                [int] NOT NULL,
		[FechaFactura]                 [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCanal]                     [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCliente]                   [int] NOT NULL,
		[CodPagador]                   [int] NOT NULL,
		[CodArticulo]                  [int] NOT NULL,
		[CodDelegacion]                [smallint] NOT NULL,
		[CodCentro]                    [smallint] NOT NULL,
		[CodAlmacen]                   [smallint] NOT NULL,
		[Empresa]                      [tinyint] NOT NULL,
		[Signo]                        [int] NOT NULL,
		[Cantidad]                     [decimal](24, 3) NOT NULL,
		[Cantidad_Standard]            [decimal](36, 9) NOT NULL,
		[KilosCafe]                    [decimal](36, 9) NOT NULL,
		[Afecta_Stock]                 [int] NOT NULL,
		[ImporteCoste]                 [money] NOT NULL,
		[ImporteCosteCafe]             [money] NOT NULL,
		[ImporteCostePLV]              [money] NOT NULL,
		[ImporteCosteComplementos]     [money] NOT NULL,
		[ImporteCosteMaquinaria]       [money] NOT NULL,
		[ImporteCosteSAT]              [money] NOT NULL,
		[PrecioCoste]                  [money] NOT NULL,
		[Precio]                       [money] NOT NULL,
		[Importe]                      [decimal](26, 2) NOT NULL,
		[ImporteCafe]                  [decimal](26, 2) NOT NULL,
		[ImportePLV]                   [decimal](26, 2) NOT NULL,
		[ImporteComplementos]          [decimal](26, 2) NOT NULL,
		[ImporteMaquinaria]            [decimal](26, 2) NOT NULL,
		[ImporteSAT]                   [decimal](26, 2) NOT NULL,
		[ImporteCafeNeto]              [decimal](24, 2) NOT NULL,
		[ImportePLVNeto]               [decimal](24, 2) NOT NULL,
		[ImporteComplementosNeto]      [decimal](24, 2) NOT NULL,
		[ImporteMaquinariaNeto]        [decimal](24, 2) NOT NULL,
		[ImporteSATNeto]               [decimal](24, 2) NOT NULL,
		[VentaNeta]                    [decimal](24, 2) NOT NULL,
		[VentaEst]                     [decimal](24, 2) NOT NULL,
		[CodTarifa]                    [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PrecioTarifa]                 [numeric](11, 2) NOT NULL,
		[PrecioTarifaFinal]            [numeric](38, 6) NOT NULL,
		[ImporteTarifa]                [numeric](36, 5) NOT NULL,
		[ImporteTarifaFinal]           [numeric](38, 6) NOT NULL,
		[ImporteIVA]                   [decimal](24, 2) NOT NULL,
		[ImporteTotalConIVA]           [decimal](27, 2) NOT NULL,
		[Factura_timestamp]            [datetime] NOT NULL,
		[audit_key]                    [int] NOT NULL,
		[source_system_code]           [int] NOT NULL,
		[create_timestamp]             [datetime] NULL,
		CONSTRAINT [PK_stgF2FacturasVentasSAP_1]
		PRIMARY KEY
		CLUSTERED
		([IdRegistro])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_123147484__K1_K3_K7_K2_16_20_21]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodEmpresa], [CodCliente], [Num_Factura], [FechaFactura])
	INCLUDE ([Importe], [ImporteIVA], [ImporteTotalConIVA])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_123147484__K4_K1_K7_8_10_15_16]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodArticulo], [CodEmpresa], [Num_Factura])
	INCLUDE ([Linea_Factura], [Cantidad], [Precio], [Importe])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_1721773191__K1_K15_K6_K5_29]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodEmpresa], [CodArticulo], [CodCliente], [FechaFactura])
	INCLUDE ([VentaNeta])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_1721773191__K5_K1_K6_K15_19_21_26_27_28]
	ON [dbo].[stgF2FacturasVentasSAP] ([FechaFactura], [CodEmpresa], [CodCliente], [CodArticulo])
	INCLUDE ([Cantidad], [KilosCafe], [Importe], [ImporteCafe], [ImporteComplementos])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_1721773191__K5_K6_K1_29]
	ON [dbo].[stgF2FacturasVentasSAP] ([FechaFactura], [CodCliente], [CodEmpresa])
	INCLUDE ([VentaNeta])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_1721773191__K5_K6_K1_K15_29]
	ON [dbo].[stgF2FacturasVentasSAP] ([FechaFactura], [CodCliente], [CodEmpresa], [CodArticulo])
	INCLUDE ([VentaNeta])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_253243957__K1_K14_K4_K5_19_25_26]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodEmpresa], [CodArticulo], [FechaFactura], [CodCliente])
	INCLUDE ([Cantidad_Standard], [VentaNeta], [VentaEst])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_253243957__K1_K4_K5_K14_18_24]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodEmpresa], [FechaFactura], [CodCliente], [CodArticulo])
	INCLUDE ([Cantidad], [Importe])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_253243957__K1_K5_K4]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodEmpresa], [CodCliente], [FechaFactura])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_253243957__K4_K1_K14_K5_19_25_26]
	ON [dbo].[stgF2FacturasVentasSAP] ([FechaFactura], [CodEmpresa], [CodArticulo], [CodCliente])
	INCLUDE ([Cantidad_Standard], [VentaNeta], [VentaEst])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_253243957__K5_K4]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodCliente], [FechaFactura])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_408388524__K48_K6_K16_K2_K7_5_22_50]
	ON [dbo].[stgF2FacturasVentasSAP] ([PrecioTarifa], [CodCanal], [CodArticulo], [IdRegistro], [CodCliente])
	INCLUDE ([FechaFactura], [Cantidad], [ImporteTarifa])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_408388524__K5_K1_K16_K7_22]
	ON [dbo].[stgF2FacturasVentasSAP] ([FechaFactura], [CodEmpresa], [CodArticulo], [CodCliente])
	INCLUDE ([Cantidad])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_54291253__K1_K15_K6_K5_30_33]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodEmpresa], [CodArticulo], [CodCliente], [FechaFactura])
	INCLUDE ([VentaNeta], [ImporteTarifa])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_54291253__K1_K5_K6_19_21_26_27_28_29]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodEmpresa], [FechaFactura], [CodCliente])
	INCLUDE ([Cantidad], [KilosCafe], [Importe], [ImporteCafe], [ImportePLV], [ImporteComplementos])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_54291253__K1_K6]
	ON [dbo].[stgF2FacturasVentasSAP] ([CodEmpresa], [CodCliente])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_54291253__K5_K1_K6_21_26_27_28_29]
	ON [dbo].[stgF2FacturasVentasSAP] ([FechaFactura], [CodEmpresa], [CodCliente])
	INCLUDE ([KilosCafe], [Importe], [ImporteCafe], [ImportePLV], [ImporteComplementos])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2FacturasVentasSAP_7_754817751__K34_K33_K6_K16_K2_K5_20_36]
	ON [dbo].[stgF2FacturasVentasSAP] ([PrecioTarifa], [CodTarifa], [CodCanal], [CodArticulo], [IdRegistro], [FechaFactura])
	INCLUDE ([Cantidad], [ImporteTarifa])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2FacturasVentasSAP] SET (LOCK_ESCALATION = TABLE)
GO
