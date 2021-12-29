SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgF3FacturacionCliente] (
		[CodEmpresa]           [tinyint] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[VentaNetaAM]          [money] NULL,
		[VentaNetaMA]          [money] NULL,
		[VentaNetaAAA]         [money] NULL,
		[FechaDatos]           [date] NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_stgF3FacturacionCliente]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3FacturacionCliente]
	ADD
	CONSTRAINT [DF_stgF3FacturacionCliente_CodEmpresa]
	DEFAULT ((2)) FOR [CodEmpresa]
GO
ALTER TABLE [dbo].[stgF3FacturacionCliente] SET (LOCK_ESCALATION = TABLE)
GO
