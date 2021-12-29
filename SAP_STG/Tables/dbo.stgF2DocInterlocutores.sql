SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2DocInterlocutores] (
		[CodEmpresa]            [int] NOT NULL,
		[TipoDocumento]         [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumDocumento]          [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCanal]              [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodSolicitante]        [int] NOT NULL,
		[CodDestFactura]        [int] NOT NULL,
		[CodRespPago]           [int] NOT NULL,
		[CodDestMercancia]      [int] NOT NULL,
		[CodFondoComercio]      [int] NOT NULL,
		[CodCadena]             [int] NOT NULL,
		[CodTransportista]      [int] NOT NULL,
		[CodComisionista]       [int] NOT NULL,
		[CodComisionistaAd]     [int] NOT NULL,
		[CodATC]                [int] NOT NULL,
		[CodRespCuenta]         [int] NOT NULL,
		[CodRespAlta]           [int] NOT NULL,
		[CodRespAltaAd]         [int] NOT NULL,
		[CodVendedor]           [int] NOT NULL,
		[create_timestamp]      [datetime] NOT NULL,
		CONSTRAINT [PK_stgF2DocInterlocutores]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [TipoDocumento], [NumDocumento])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2DocInterlocutores_7_1931869949__K2_K1_10_11_13_14_15_16]
	ON [dbo].[stgF2DocInterlocutores] ([NumDocumento], [CodEmpresa])
	INCLUDE ([CodComisionista], [CodComisionistaAd], [CodRespCuenta], [CodRespAlta], [CodRespAltaAd], [CodVendedor])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160607-100308]
	ON [dbo].[stgF2DocInterlocutores] ([create_timestamp])
	INCLUDE ([CodEmpresa], [TipoDocumento], [NumDocumento])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2DocInterlocutores] SET (LOCK_ESCALATION = TABLE)
GO
