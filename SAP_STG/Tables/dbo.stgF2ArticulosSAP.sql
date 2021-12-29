SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2ArticulosSAP] (
		[CodEmpresa]                [int] NOT NULL,
		[CodArticulo]               [int] NOT NULL,
		[Articulo]                  [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTipoMaterial]           [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoMaterial]              [char](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodGrupoArticulos]         [char](9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GrupoArticulos]            [char](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArticulo_UT]            [char](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Unidad_Medida]             [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ConversionKG]              [numeric](11, 6) NOT NULL,
		[CodigoEAN]                 [char](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodigoDUN14]               [varchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[valUniXCaja]               [numeric](11, 6) NOT NULL,
		[valUniXPalet]              [numeric](11, 6) NOT NULL,
		[CodNivel1]                 [int] NOT NULL,
		[Nivel1]                    [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodNivel2]                 [int] NOT NULL,
		[Nivel2]                    [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodNivel3]                 [int] NOT NULL,
		[Nivel3]                    [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodNivel4]                 [int] NOT NULL,
		[Nivel4]                    [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[JerarquiaSAP]              [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodMarca]                  [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Marca]                     [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodFormato]                [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Formato]                   [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCalidad]                [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Calidad]                   [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTueste]                 [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Tueste]                    [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodPlanNecesidades]        [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PlanNecesidades]           [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CantidadMinima]            [numeric](13, 3) NOT NULL,
		[PropiedadUT]               [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Descaf]                    [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Hostel]                    [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Vending]                   [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Baja]                      [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaAltaArticulo_key]     [int] NOT NULL,
		[ExcluirInacatalog]         [bit] NULL,
		[create_timestamp]          [datetime] NOT NULL,
		CONSTRAINT [PK_stgF2ArticulosSAP]
		PRIMARY KEY
		CLUSTERED
		([CodArticulo])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_CodigoDUN14]
	DEFAULT ('N/A') FOR [CodigoDUN14]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_valUniXCaja]
	DEFAULT ((0)) FOR [valUniXCaja]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_valUniXPalet]
	DEFAULT ((0)) FOR [valUniXPalet]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_CodNivel1]
	DEFAULT ((0)) FOR [CodNivel1]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_CodNivel2]
	DEFAULT ((0)) FOR [CodNivel2]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_CodNivel3]
	DEFAULT ((0)) FOR [CodNivel3]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_CodNivel4]
	DEFAULT ((0)) FOR [CodNivel4]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_CodPlanNecesidades]
	DEFAULT ('N/A') FOR [CodPlanNecesidades]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_PlanNecesidades]
	DEFAULT ('NO DISPONIBLE') FOR [PlanNecesidades]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_CantidadMinima]
	DEFAULT ((0)) FOR [CantidadMinima]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP]
	ADD
	CONSTRAINT [DF_stgF2ArticulosSAP_FechaAltaArticulo_key]
	DEFAULT ((0)) FOR [FechaAltaArticulo_key]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2ArticulosSAP_7_1218819404__K1_K2_4_10_15]
	ON [dbo].[stgF2ArticulosSAP] ([CodEmpresa], [CodArticulo])
	INCLUDE ([CodTipoMaterial], [ConversionKG], [CodNivel1])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2ArticulosSAP_7_1598628738__K25_K1_K2_3_4_11_20]
	ON [dbo].[stgF2ArticulosSAP] ([Baja], [CodEmpresa], [CodArticulo])
	INCLUDE ([Articulo], [CodTipoMaterial], [CodigoEAN], [JerarquiaSAP])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2ArticulosSAP_7_1598628738__K4_K20_K25_K1_K2]
	ON [dbo].[stgF2ArticulosSAP] ([CodTipoMaterial], [JerarquiaSAP], [Baja], [CodEmpresa], [CodArticulo])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2ArticulosSAP_7_1598628738__K4_K25_K1_K2_K20_3_11]
	ON [dbo].[stgF2ArticulosSAP] ([CodTipoMaterial], [Baja], [CodEmpresa], [CodArticulo], [JerarquiaSAP])
	INCLUDE ([Articulo], [CodigoEAN])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2ArticulosSAP_7_1767677345__K12_1_2]
	ON [dbo].[stgF2ArticulosSAP] ([CodNivel1])
	INCLUDE ([CodEmpresa], [CodArticulo])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2ArticulosSAP_7_584389151__K2_K15_3_9_16]
	ON [dbo].[stgF2ArticulosSAP] ([CodArticulo], [CodNivel1])
	INCLUDE ([Articulo], [Unidad_Medida], [Nivel1])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2ArticulosSAP] SET (LOCK_ESCALATION = TABLE)
GO
