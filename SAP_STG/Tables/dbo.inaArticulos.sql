SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaArticulos] (
		[codEmpresa]                  [int] NOT NULL,
		[codArticulo]                 [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desArticulo]                 [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codEAN13]                    [char](13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datMedidas]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datPeso]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datVolumen]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[obsArticulo]                 [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[hipArticulo]                 [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[valMinVenta]                 [numeric](12, 3) NOT NULL,
		[valUniXCaja]                 [numeric](12, 3) NOT NULL,
		[valUniXPalet]                [numeric](12, 3) NOT NULL,
		[valUniIncSencillo]           [numeric](12, 3) NOT NULL,
		[codTipoArticulo]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codCatalogo]                 [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codFamilia]                  [int] NOT NULL,
		[codSubFamilia]               [int] NOT NULL,
		[codGrupoPreciosArticulo]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[tpcIva]                      [numeric](4, 2) NOT NULL,
		[tpcRe]                       [numeric](4, 2) NOT NULL,
		[tpcIGIC]                     [numeric](4, 2) NOT NULL,
		[codModeloTyC]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desModeloTyC]                [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[stoDisponible]               [numeric](18, 3) NOT NULL,
		[stoPteRecibir]               [numeric](18, 3) NOT NULL,
		[datFechaEntradaPrevista]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ordArticulo]                 [int] NOT NULL,
		[preArticuloGen]              [numeric](18, 6) NOT NULL,
		[datNivel1]                   [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datNivel2]                   [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codEmpSuministradora]        [int] NOT NULL,
		[flaNoAplicarDtoPP]           [tinyint] NOT NULL,
		[datMarcas]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[prePuntos]                   [numeric](18, 3) NOT NULL,
		[flaMuestra]                  [tinyint] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaArticulos] SET (LOCK_ESCALATION = TABLE)
GO
