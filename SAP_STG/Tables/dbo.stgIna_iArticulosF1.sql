SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgIna_iArticulosF1] (
		[codEmpresa]                  [int] NOT NULL,
		[codArticulo]                 [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desArticulo]                 [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codEAN13]                    [char](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datMedidas]                  [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datPeso]                     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datVolumen]                  [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[obsArticulo]                 [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[hipArticulo]                 [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[valMinVenta]                 [numeric](12, 3) NOT NULL,
		[valUniXCaja]                 [numeric](12, 3) NOT NULL,
		[valUniXPalet]                [numeric](12, 3) NOT NULL,
		[valUniIncSencillo]           [numeric](12, 3) NOT NULL,
		[codTipoArticulo]             [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codCatalogo]                 [char](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codFamilia]                  [int] NOT NULL,
		[codSubFamilia]               [int] NOT NULL,
		[codGrupoPreciosArticulo]     [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[tpcIva]                      [int] NOT NULL,
		[tpcRe]                       [int] NOT NULL,
		[tpcIGIC]                     [int] NOT NULL,
		[codModeloTyC]                [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desModeloTyC]                [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[stoDisponible]               [int] NOT NULL,
		[stoPteRecibir]               [int] NOT NULL,
		[datFechaEntradaPrevista]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ordArticulo]                 [int] NOT NULL,
		[preArticuloGen]              [int] NOT NULL,
		[datNivel1]                   [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datNivel2]                   [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codEmpSuministradora]        [int] NOT NULL,
		[flaNoAplicarDtoPP]           [int] NOT NULL,
		[datMarcas]                   [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[prePuntos]                   [numeric](18, 3) NOT NULL,
		[flaMuestra]                  [tinyint] NOT NULL,
		[CodMarca]                    [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ExcluirInacatalog]           [bit] NULL,
		CONSTRAINT [PK_stgIna_iArticulosF1]
		PRIMARY KEY
		CLUSTERED
		([codEmpresa], [codArticulo])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgIna_iArticulosF1_7_1867153697__K14_K16_K17_1_2_3_4_5_6_7_8_9_10_11_12_13_15_18_19_20_21_22_23_24_25_26_27_28_29_]
	ON [dbo].[stgIna_iArticulosF1] ([codTipoArticulo], [codFamilia], [codSubFamilia])
	INCLUDE ([codEmpresa], [codArticulo], [desArticulo], [datVolumen], [obsArticulo], [hipArticulo], [valUniXCaja], [valUniIncSencillo], [codGrupoPreciosArticulo], [codEAN13], [tpcRe], [datMedidas], [codModeloTyC], [datPeso], [stoDisponible], [valMinVenta], [datFechaEntradaPrevista], [valUniXPalet], [preArticuloGen], [codCatalogo], [datNivel2], [tpcIva], [codEmpSuministradora], [tpcIGIC], [flaNoAplicarDtoPP], [desModeloTyC], [datMarcas], [prePuntos], [flaMuestra], [stoPteRecibir], [ordArticulo], [datNivel1])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgIna_iArticulosF1_7_1947153982__K16_K17_K1_K14_2_27]
	ON [dbo].[stgIna_iArticulosF1] ([codFamilia], [codSubFamilia], [codEmpresa], [codTipoArticulo])
	INCLUDE ([codArticulo], [ordArticulo])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgIna_iArticulosF1] SET (LOCK_ESCALATION = TABLE)
GO
