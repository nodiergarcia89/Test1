SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgF3PrecioMedioCliente] (
		[CodEmpresa]           [tinyint] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[KilosAM]              [numeric](38, 3) NULL,
		[KilosAA]              [numeric](38, 3) NULL,
		[KilosAAA]             [numeric](38, 3) NULL,
		[VentaNetaAM]          [money] NULL,
		[VentaNetaAA]          [money] NULL,
		[VentaNetaAAA]         [money] NULL,
		[VentaEstAM]           [money] NULL,
		[VentaEstAA]           [money] NULL,
		[VentaEstAAA]          [money] NULL,
		[PrecioMedioVNAM]      [money] NULL,
		[PrecioMedioVNAA]      [money] NULL,
		[PrecioMedioVNAAA]     [money] NULL,
		[PrecioMedioVEAM]      [money] NULL,
		[PrecioMedioVEAA]      [money] NULL,
		[PrecioMedioVEAAA]     [money] NULL,
		[KilosMA]              [numeric](38, 3) NULL,
		[VentaNetaMA]          [money] NULL,
		[VentaEstMA]           [money] NULL,
		[PrecioMedioVNMA]      [money] NULL,
		[PrecioMedioVEMA]      [money] NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_stgF3PrecioMedioCliente]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3PrecioMedioCliente] SET (LOCK_ESCALATION = TABLE)
GO
