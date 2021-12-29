SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF3Clientes] (
		[CodEmpresa]                 [tinyint] NOT NULL,
		[CodCliente]                 [int] NOT NULL,
		[NombreCliente]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Direccion]                  [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Poblacion]                  [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CP]                         [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodPais]                    [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Pais]                       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodProvincia]               [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Provincia]                  [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Telefono]                   [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Fax]                        [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DireccionEmail]             [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaCreacionRegistro]      [date] NOT NULL,
		[CodGrupoClientes]           [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GrupoClientes]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Baja]                       [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodOrgVentas]               [int] NOT NULL,
		[OrgVentas]                  [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCanal]                   [int] NOT NULL,
		[Canal]                      [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodSector]                  [int] NOT NULL,
		[Sector]                     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodRespPago]                [int] NOT NULL,
		[RazonSocial]                [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DNI_CIF]                    [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodFormaPago]               [char](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FormaPago]                  [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodVendedor]                [int] NOT NULL,
		[Vendedor]                   [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodFondoComercio]           [int] NOT NULL,
		[FondoComercio]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodRespAlta]                [int] NOT NULL,
		[RespAlta]                   [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodRespAltaAd]              [int] NOT NULL,
		[RespAltaAd]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodRespCuenta]              [int] NOT NULL,
		[RespCuenta]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCadena]                  [int] NOT NULL,
		[Cadena]                     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodComisionista]            [int] NOT NULL,
		[Comisionista]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodComisionistaAd]          [int] NOT NULL,
		[ComisionistaAd]             [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDistribuidor]            [int] NOT NULL,
		[Distribuidor]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodRepartidor]              [int] NOT NULL,
		[Repartidor]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTipoHoreca]              [smallint] NOT NULL,
		[TipoHoreca]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTipoCliente]             [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoCliente]                [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodZonaVentas]              [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZonaVentas]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTarifa]                  [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Tarifa]                     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDelegacion]              [int] NOT NULL,
		[Delegacion]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDelegacionOrigen]        [int] NOT NULL,
		[DelegacionOrigen]           [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCentroSuministro]        [int] NOT NULL,
		[TipoFacturacion]            [char](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ConsumoAnualPrevisto]       [numeric](13, 3) NOT NULL,
		[CodGamaConsumo]             [char](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GamaConsumo]                [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PrecioGamaConsumo]          [numeric](15, 2) NOT NULL,
		[FechaAltaComercial_key]     [int] NOT NULL,
		[FechaBajaComercial_key]     [int] NOT NULL,
		[NoControlDeuda]             [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ClienteEstacional]          [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodProveedorActual]         [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ProveedorActual]            [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ContratoVigente]            [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaFinContrato]           [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Maquina]                    [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodModeloMaquina]           [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ModeloMaquina]              [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTipoContrato]            [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoContrato]               [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OtroTipoInversion]          [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RitmoEntregaActual]         [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HorarioEntrega]             [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FacturacionTotal]           [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KgSemana]                   [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Precio]                     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodGamaProductoActual]      [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GamaProductoActual]         [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MarketingPLV]               [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumeroCliente]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KGAño]                      [decimal](8, 2) NOT NULL,
		[CodActividadPrincipal]      [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ActividadPrincipal]         [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumeroEstablecimientos]     [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MarcaPropia]                [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NombreMarcaPropia]          [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodPropiedadCliente]        [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PropiedadCliente]           [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Personal]                   [char](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ContratoAct]                [bit] NOT NULL,
		[create_timestamp]           [datetime] NOT NULL,
		CONSTRAINT [PK_stgF3Clientes]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente], [CodCanal])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3Clientes]
	ADD
	CONSTRAINT [DF_stgF3Clientes_CodDelegacionOrigen]
	DEFAULT ((0)) FOR [CodDelegacionOrigen]
GO
ALTER TABLE [dbo].[stgF3Clientes]
	ADD
	CONSTRAINT [DF_stgF3Clientes_DelegacionOrigen]
	DEFAULT ('N/A') FOR [DelegacionOrigen]
GO
ALTER TABLE [dbo].[stgF3Clientes]
	ADD
	CONSTRAINT [DF_stgF3Clientes_CodCentroSuministro]
	DEFAULT ((0)) FOR [CodCentroSuministro]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_120387498__K2_20_51]
	ON [dbo].[stgF3Clientes] ([CodCliente])
	INCLUDE ([CodCanal], [CodTipoCliente])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_120387498__K2_K55_3]
	ON [dbo].[stgF3Clientes] ([CodCliente], [CodTarifa])
	INCLUDE ([NombreCliente])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_1552724584__K1_K2_5_10]
	ON [dbo].[stgF3Clientes] ([CodEmpresa], [CodCliente])
	INCLUDE ([Poblacion], [Provincia])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_1552724584__K20_K1_K2]
	ON [dbo].[stgF3Clientes] ([CodCanal], [CodEmpresa], [CodCliente])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_1552724584__K20_K1_K2_4_5_6_8_10_11_13_16]
	ON [dbo].[stgF3Clientes] ([CodCanal], [CodEmpresa], [CodCliente])
	INCLUDE ([Direccion], [Poblacion], [CP], [Pais], [Provincia], [Telefono], [DireccionEmail], [GrupoClientes])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_1552724584__K57_K2_K1_K20_K15_K64_3_4_5_6_7_8_9_10_11_12_13_14_16_17_18_19_21_22_23_24_25_26_27_28_]
	ON [dbo].[stgF3Clientes] ([CodDelegacion], [CodCliente], [CodEmpresa], [CodCanal], [CodGrupoClientes], [FechaAltaComercial_key])
	INCLUDE ([Pais], [FechaCreacionRegistro], [NombreCliente], [Direccion], [Poblacion], [CP], [CodPais], [CodSector], [CodProvincia], [Provincia], [Telefono], [Fax], [DireccionEmail], [FormaPago], [GrupoClientes], [Baja], [CodOrgVentas], [OrgVentas], [Canal], [RespAlta], [Sector], [CodRespPago], [RazonSocial], [DNI_CIF], [CodFormaPago], [Cadena], [CodVendedor], [Vendedor], [CodFondoComercio], [FondoComercio], [CodRespAlta], [Distribuidor], [CodRespAltaAd], [RespAltaAd], [CodRespCuenta], [RespCuenta], [CodCadena], [TipoCliente], [CodComisionista], [Comisionista], [CodComisionistaAd], [ComisionistaAd], [CodDistribuidor], [TipoFacturacion], [CodRepartidor], [Repartidor], [CodTipoHoreca], [TipoHoreca], [CodTipoCliente], [NoControlDeuda], [CodZonaVentas], [ZonaVentas], [CodTarifa], [Tarifa], [Delegacion], [Maquina], [ConsumoAnualPrevisto], [CodGamaConsumo], [GamaConsumo], [PrecioGamaConsumo], [FechaBajaComercial_key], [RitmoEntregaActual], [ClienteEstacional], [CodProveedorActual], [ProveedorActual], [ContratoVigente], [FechaFinContrato], [GamaProductoActual], [CodModeloMaquina], [ModeloMaquina], [CodTipoContrato], [TipoContrato], [OtroTipoInversion], [NumeroEstablecimientos], [HorarioEntrega], [FacturacionTotal], [KgSemana], [Precio], [CodGamaProductoActual], [ContratoAct], [MarketingPLV], [NumeroCliente], [KGAño], [CodActividadPrincipal], [ActividadPrincipal], [create_timestamp], [MarcaPropia], [NombreMarcaPropia], [CodPropiedadCliente], [PropiedadCliente], [Personal])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K1_K2_K55]
	ON [dbo].[stgF3Clientes] ([CodEmpresa], [CodCliente], [CodDelegacion])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K1_K37_K2_K15_K55_K20_9]
	ON [dbo].[stgF3Clientes] ([CodEmpresa], [CodRespCuenta], [CodCliente], [CodGrupoClientes], [CodDelegacion], [CodCanal])
	INCLUDE ([CodProvincia])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K15_K20_K1]
	ON [dbo].[stgF3Clientes] ([CodGrupoClientes], [CodCanal], [CodEmpresa])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K2_3_55_56]
	ON [dbo].[stgF3Clientes] ([CodCliente])
	INCLUDE ([NombreCliente], [CodDelegacion], [Delegacion])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K20_K1_K2_4_5_6_8_10_11_12_13]
	ON [dbo].[stgF3Clientes] ([CodCanal], [CodEmpresa], [CodCliente])
	INCLUDE ([Direccion], [Poblacion], [CP], [Pais], [Provincia], [Telefono], [Fax], [DireccionEmail])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K20_K2_K1_4_5_6_8_10_11_12_13]
	ON [dbo].[stgF3Clientes] ([CodCanal], [CodCliente], [CodEmpresa])
	INCLUDE ([Direccion], [Poblacion], [CP], [Pais], [Provincia], [Telefono], [Fax], [DireccionEmail])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K55_K20_K1]
	ON [dbo].[stgF3Clientes] ([CodDelegacion], [CodCanal], [CodEmpresa])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K55_K20_K1_K15_33_37]
	ON [dbo].[stgF3Clientes] ([CodDelegacion], [CodCanal], [CodEmpresa], [CodGrupoClientes])
	INCLUDE ([CodRespAlta], [CodRespCuenta])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K55_K20_K1_K2_K15_K62_3_14_17_22_25_26_27_33_37_49_51_53]
	ON [dbo].[stgF3Clientes] ([CodDelegacion], [CodCanal], [CodEmpresa], [CodCliente], [CodGrupoClientes], [FechaAltaComercial_key])
	INCLUDE ([NombreCliente], [FechaCreacionRegistro], [Baja], [CodSector], [RazonSocial], [DNI_CIF], [CodFormaPago], [CodRespAlta], [CodRespCuenta], [CodTipoCliente], [CodZonaVentas], [CodTarifa])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K55_K20_K1_K53_K15]
	ON [dbo].[stgF3Clientes] ([CodDelegacion], [CodCanal], [CodEmpresa], [CodTarifa], [CodGrupoClientes])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_7_2110630562__K55_K20_K2_K1_K62_K15_3_14_16_17_22_25_26_27_33_37_49_51_53]
	ON [dbo].[stgF3Clientes] ([CodDelegacion], [CodCanal], [CodCliente], [CodEmpresa], [FechaAltaComercial_key], [CodGrupoClientes])
	INCLUDE ([FechaCreacionRegistro], [CodFormaPago], [Baja], [CodRespCuenta], [RazonSocial], [CodZonaVentas], [NombreCliente], [CodRespAlta], [GrupoClientes], [CodTipoCliente], [CodSector], [CodTarifa], [DNI_CIF])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF3Clientes_8_120387498__K1_K2_3_39_40]
	ON [dbo].[stgF3Clientes] ([CodEmpresa], [CodCliente])
	INCLUDE ([NombreCliente], [CodCadena], [Cadena])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3Clientes] SET (LOCK_ESCALATION = TABLE)
GO
