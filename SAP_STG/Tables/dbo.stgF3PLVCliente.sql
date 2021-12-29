SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgF3PLVCliente] (
		[CodEmpresa]           [tinyint] NOT NULL,
		[CodCliente]           [int] NOT NULL,
		[VentaNetaPLVAM]       [money] NULL,
		[VentaNetaPLVMA]       [money] NULL,
		[VentaNetaPLVAA]       [money] NULL,
		[GastoPLVAA]           [money] NULL,
		[GastoPLVAM]           [money] NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_stgF3PLVCliente]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3PLVCliente] SET (LOCK_ESCALATION = TABLE)
GO
