SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgClientesCustom] (
		[CodEmpresa]                 [tinyint] NOT NULL,
		[CodCliente]                 [int] NOT NULL,
		[nomCliente]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[rsocliente]                 [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[cifCliente]                 [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodRespPago]                [int] NULL,
		[codZona]                    [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodAgente]                  [int] NULL,
		[CodRespCuenta]              [int] NULL,
		[CodRespAlta]                [int] NULL,
		[CodTipoCliente]             [int] NOT NULL,
		[CodFormaPago]               [char](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTarifa]                  [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[impPendienteRiesgo]         [money] NULL,
		[impVencidoRiesgo]           [money] NULL,
		[impImpagadoRiesgo]          [money] NULL,
		[impCoberturaRiesgo]         [money] NULL,
		[KilosAM]                    [numeric](38, 3) NULL,
		[KilosMA]                    [numeric](38, 3) NULL,
		[KilosAA]                    [numeric](38, 3) NULL,
		[KilosAAA]                   [numeric](38, 3) NULL,
		[RatioCAño]                  [money] NULL,
		[RatioCMes]                  [money] NULL,
		[VentaNetaCompAA]            [money] NULL,
		[VentaNetaCompAAA]           [money] NULL,
		[PrecioMedioVNAM]            [money] NULL,
		[PrecioMedioVEAM]            [money] NULL,
		[PrecioMedioVNMA]            [money] NULL,
		[PrecioMedioVEMA]            [money] NULL,
		[PrecioMedioVNAA]            [money] NULL,
		[PrecioMedioVEAA]            [money] NULL,
		[RatioCAñoA]                 [money] NULL,
		[PorcCump]                   [numeric](13, 2) NULL,
		[Cumple]                     [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FactObjMes]                 [money] NULL,
		[PrecioPropuestoSAP]         [numeric](13, 2) NULL,
		[CodTipoHoreca]              [smallint] NOT NULL,
		[TipoHoreca]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AcuerdoFirmado]             [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Inversion]                  [numeric](13, 2) NULL,
		[VentaNetaPLVAM]             [money] NULL,
		[EurKgPLV]                   [money] NULL,
		[GastoMaqAA]                 [money] NULL,
		[VentaNetaMaqAA]             [money] NULL,
		[GastoPLVAA]                 [money] NULL,
		[VentaNetaPLVAA]             [money] NULL,
		[EurSATAño]                  [money] NULL,
		[OrdenesSATAño]              [int] NULL,
		[EurSAT]                     [money] NULL,
		[RatioSAT]                   [money] NULL,
		[GastoSAT]                   [money] NULL,
		[RSAT]                       [money] NULL,
		[CodSector]                  [int] NOT NULL,
		[CodGrupoClientes]           [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GrupoClientes]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaCreacionRegistro]      [date] NOT NULL,
		[FechaAltaComercial_key]     [int] NOT NULL,
		[impFacturacion]             [money] NULL,
		[impFacturacionAAA]          [money] NULL,
		[ClienteConDatos]            [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Baja]                       [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom1]                    [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Custom2]                    [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Custom3]                    [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Custom4]                    [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Custom5]                    [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[fecAltaCliente]             [date] NULL,
		CONSTRAINT [PK_stgClientesCustom]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgClientesCustom_7_50815243__K1_2_3_4_5_6_7_8_9_10_11_12_13_14_48_50_53_56_57_58_59_60_61]
	ON [dbo].[stgClientesCustom] ([CodEmpresa])
	INCLUDE ([CodCliente], [nomCliente], [rsocliente], [cifCliente], [codZona], [CodFormaPago], [CodTarifa], [impPendienteRiesgo], [impVencidoRiesgo], [impCoberturaRiesgo], [GrupoClientes], [impFacturacion], [Custom1], [CodAgente], [Custom2], [CodTipoCliente], [Custom3], [Custom4], [Custom5], [fecAltaCliente], [impImpagadoRiesgo], [CodSector])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgClientesCustom_7_50815243__K54_K34_K1_K7_K8_2_3_10_15_16_19_20_23_24_25_26_30_31_32_33_37_38_39_44_45_46_47_53_]
	ON [dbo].[stgClientesCustom] ([ClienteConDatos], [CodTipoHoreca], [CodEmpresa], [CodAgente], [CodTipoCliente])
	INCLUDE ([CodCliente], [nomCliente], [CodTarifa], [KilosAM], [KilosMA], [RatioCAño], [RatioCMes], [PrecioMedioVNAM], [PrecioMedioVEAM], [PrecioMedioVNMA], [PrecioMedioVEMA], [PorcCump], [Cumple], [FactObjMes], [PrecioPropuestoSAP], [Inversion], [VentaNetaPLVAM], [EurKgPLV], [EurSATAño], [OrdenesSATAño], [EurSAT], [RatioSAT], [impFacturacion], [Baja], [fecAltaCliente])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgClientesCustom] SET (LOCK_ESCALATION = TABLE)
GO
