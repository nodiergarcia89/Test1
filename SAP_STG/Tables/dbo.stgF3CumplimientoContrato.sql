SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF3CumplimientoContrato] (
		[CodEmpresa]             [tinyint] NOT NULL,
		[CodEstablecimiento]     [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumContrato]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[StatusContrato]         [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaInicio]            [date] NULL,
		[FechaFin]               [date] NULL,
		[MesesDuracion]          [int] NULL,
		[AñosDuracion]           [int] NULL,
		[KilosMes]               [numeric](13, 3) NOT NULL,
		[KilosAño]               [numeric](27, 3) NULL,
		[KilosPeriodo]           [numeric](13, 3) NOT NULL,
		[KgsPteAmort]            [numeric](28, 3) NULL,
		[EurosAmort]             [money] NULL,
		[EurosPteAmort]          [numeric](38, 6) NULL,
		[PorcCump]               [numeric](13, 2) NOT NULL,
		[FactObjMes]             [numeric](29, 16) NULL,
		[PrecioPropuestoSAP]     [numeric](13, 2) NOT NULL,
		[Inversion]              [numeric](13, 2) NOT NULL,
		[Establecimientos]       [varchar](47) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Indemnizacion]          [numeric](38, 4) NULL,
		[IndemKgRap]             [numeric](13, 2) NOT NULL,
		[IndemKgMat]             [numeric](13, 2) NOT NULL,
		[SinAval]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AvalImporte]            [numeric](13, 2) NOT NULL,
		[FechaVtoAval]           [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DuracionAñosAval]       [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MaterialCedido]         [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ValorMaquinaria]        [numeric](38, 2) NULL,
		[RappelAnticipado]       [numeric](13, 2) NOT NULL,
		[create_timestamp]       [datetime] NOT NULL,
		CONSTRAINT [PK_stgF3CumplimientoContrato]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodEstablecimiento], [NumContrato])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3CumplimientoContrato]
	ADD
	CONSTRAINT [DF_stgF3CumplimientoContrato_CodEmpresa]
	DEFAULT ((2)) FOR [CodEmpresa]
GO
ALTER TABLE [dbo].[stgF3CumplimientoContrato] SET (LOCK_ESCALATION = TABLE)
GO
