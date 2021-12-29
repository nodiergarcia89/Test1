SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgFactDeudaDiaria] (
		[FechaProceso_key]      [int] NOT NULL,
		[CodEmpresa]            [tinyint] NOT NULL,
		[CodCliente]            [int] NOT NULL,
		[CodPagador]            [int] NOT NULL,
		[NumFactura]            [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Visita]                [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaFactura]          [date] NOT NULL,
		[FechaVto]              [date] NOT NULL,
		[DeudaAsegurada]        [money] NOT NULL,
		[TotalDeuda]            [money] NOT NULL,
		[DeudaComprometida]     [money] NOT NULL,
		[ImpTotFactura]         [money] NOT NULL,
		[Impagado]              [money] NOT NULL,
		[ImpPenFactura]         [money] NOT NULL,
		[create_timestamp]      [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgFactDeudaDiaria] SET (LOCK_ESCALATION = TABLE)
GO
