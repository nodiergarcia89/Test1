SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgF3ComplementosCliente] (
		[CodEmpresa]           [tinyint] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[VentaNetaCompAM]      [money] NULL,
		[VentaNetaCompAA]      [money] NULL,
		[VentaNetaCompAAA]     [money] NULL,
		[VentaNetaCompMA]      [money] NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_stgF3ComplementosCliente]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3ComplementosCliente] SET (LOCK_ESCALATION = TABLE)
GO
