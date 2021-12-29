SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgF3MaquinariaCliente] (
		[CodEmpresa]           [tinyint] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[VentaNetaMaqAM]       [money] NULL,
		[VentaNetaMaqMA]       [money] NULL,
		[VentaNetaMaqAA]       [money] NULL,
		[GastoMaqAA]           [money] NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_stgF3MaquinariaCliente]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3MaquinariaCliente] SET (LOCK_ESCALATION = TABLE)
GO
