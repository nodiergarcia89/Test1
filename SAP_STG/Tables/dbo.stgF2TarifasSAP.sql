SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2TarifasSAP] (
		[CodEmpresa]            [int] NOT NULL,
		[CodTarifa]             [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCanal]              [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArticulo_SAP]       [int] NOT NULL,
		[FechaTDesde]           [datetime] NOT NULL,
		[FechaTHasta]           [datetime] NOT NULL,
		[PrecioTarifa]          [numeric](11, 2) NOT NULL,
		[ImporteDto]            [numeric](11, 2) NOT NULL,
		[PorDto1]               [numeric](15, 6) NOT NULL,
		[PorDto2]               [numeric](15, 6) NOT NULL,
		[PorDto3]               [numeric](15, 6) NOT NULL,
		[PrecioTarifaFinal]     [numeric](38, 6) NOT NULL,
		[create_timestamp]      [datetime] NOT NULL,
		CONSTRAINT [PK_stgF2TarifasSAP]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodTarifa], [CodCanal], [CodArticulo_SAP], [FechaTDesde], [FechaTHasta])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2TarifasSAP_7_1630628852__K3_K1_K4_K2_12]
	ON [dbo].[stgF2TarifasSAP] ([CodCanal], [CodEmpresa], [CodArticulo_SAP], [CodTarifa])
	INCLUDE ([PrecioTarifaFinal])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2TarifasSAP_7_1630628852__K4_K2_K3_5_6_12]
	ON [dbo].[stgF2TarifasSAP] ([CodArticulo_SAP], [CodTarifa], [CodCanal])
	INCLUDE ([FechaTDesde], [FechaTHasta], [PrecioTarifaFinal])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2TarifasSAP_7_1630628852__K4_K2_K3_K5_K6_K1_7_12]
	ON [dbo].[stgF2TarifasSAP] ([CodArticulo_SAP], [CodTarifa], [CodCanal], [FechaTDesde], [FechaTHasta], [CodEmpresa])
	INCLUDE ([PrecioTarifa], [PrecioTarifaFinal])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2TarifasSAP] SET (LOCK_ESCALATION = TABLE)
GO
