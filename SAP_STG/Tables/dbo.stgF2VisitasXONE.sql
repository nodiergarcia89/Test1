SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2VisitasXONE] (
		[IdRegistro]           [nvarchar](33) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodEmpresa]           [int] NOT NULL,
		[CodTerminal]          [int] NOT NULL,
		[CodTipoVisita]        [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumVisita]            [int] NOT NULL,
		[NumLinVisita]         [int] NOT NULL,
		[FacEnCentral]         [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FacturaSN]            [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumDoc]               [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumLinDoc]            [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTipoDoc]           [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodCanal]             [smallint] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[FechaVisita_key]      [int] NOT NULL,
		[HoraVisita_key]       [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodDelegacion]        [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodAlmacen]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TotalFactura]         [money] NOT NULL,
		[TotalCobrado]         [money] NOT NULL,
		[ImporteCobrado]       [money] NOT NULL,
		[EstCobro]             [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodTipoCobro]         [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumImpresiones]       [smallint] NOT NULL,
		[Observaciones]        [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumLiquidacion]       [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodVendedor]          [int] NOT NULL,
		[Visita_timestamp]     [datetime] NOT NULL,
		[VisitaManual]         [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumPedido]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumAlbaran]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumMovto]             [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumFactura]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IdRegistroFac]        [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumDocCtble]          [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumVisitaManual]      [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArticulo]          [int] NOT NULL,
		[Cantidad]             [numeric](15, 3) NOT NULL,
		[Precio]               [money] NOT NULL,
		[Importe]              [money] NOT NULL,
		[CodTipoLinea]         [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Lotes]                [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		[update_timestamp]     [datetime] NOT NULL,
		[audit_key]            [int] NOT NULL,
		CONSTRAINT [PK_stgF2VisitasXONE]
		PRIMARY KEY
		CLUSTERED
		([IdRegistro])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2VisitasXONE]
	ADD
	CONSTRAINT [DF_stgF2VisitasXONE_IdRegistro]
	DEFAULT ((0)) FOR [IdRegistro]
GO
ALTER TABLE [dbo].[stgF2VisitasXONE]
	ADD
	CONSTRAINT [DF_stgF2VisitasXONE_CodCanal]
	DEFAULT ((0)) FOR [CodCanal]
GO
ALTER TABLE [dbo].[stgF2VisitasXONE]
	ADD
	CONSTRAINT [DF_stgF2VisitasXONE_ImporteCobrado]
	DEFAULT ((0)) FOR [ImporteCobrado]
GO
ALTER TABLE [dbo].[stgF2VisitasXONE]
	ADD
	CONSTRAINT [DF_stgF2VisitasXONE_IdRegistroFac]
	DEFAULT ('') FOR [IdRegistroFac]
GO
ALTER TABLE [dbo].[stgF2VisitasXONE] SET (LOCK_ESCALATION = TABLE)
GO
