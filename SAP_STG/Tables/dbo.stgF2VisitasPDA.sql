SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF2VisitasPDA] (
		[CodEmpresa]           [int] NOT NULL,
		[CodVendedor]          [int] NOT NULL,
		[CodTipoVisita]        [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumVisita]            [int] NOT NULL,
		[LinVisita]            [smallint] NOT NULL,
		[FechaVisita_Key]      [int] NOT NULL,
		[FechaHoraVisita]      [datetime] NOT NULL,
		[CodTipoLinea]         [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumPedido]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumAlbaran]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumFactura]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodSociedad]          [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumDocContable]       [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NumLiquidacion]       [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CodTipoCobro]         [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumImpresiones]       [smallint] NOT NULL,
		[CodCliente]           [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArticulo]          [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Cantidad]             [numeric](8, 2) NOT NULL,
		[ImporteVenta]         [money] NOT NULL,
		[FechaAlta]            [int] NOT NULL,
		[FechaHoraAlta]        [datetime] NOT NULL,
		[Origen]               [smallint] NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_stgF2VisitasPDA]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [NumVisita], [CodTipoVisita], [LinVisita], [CodVendedor])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2VisitasPDA]
	ADD
	CONSTRAINT [DF_stgF2VisitasPDA_Origen]
	DEFAULT ((0)) FOR [Origen]
GO
CREATE NONCLUSTERED INDEX [_dta_index_stgF2VisitasPDA_7_292196091__K10_K5_K2_1_3_4_6_7_8_9_11_12_13_14_15_16_17_18_19_20_21_22_23_24]
	ON [dbo].[stgF2VisitasPDA] ([NumFactura], [CodTipoVisita], [FechaVisita_Key])
	INCLUDE ([CodEmpresa], [FechaHoraVisita], [NumVisita], [Cantidad], [ImporteVenta], [FechaAlta], [FechaHoraAlta], [Origen], [create_timestamp], [NumLiquidacion], [CodTipoCobro], [NumImpresiones], [CodVendedor], [CodCliente], [CodArticulo], [LinVisita], [CodTipoLinea], [NumPedido], [NumAlbaran], [CodSociedad], [NumDocContable])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF2VisitasPDA] SET (LOCK_ESCALATION = TABLE)
GO
