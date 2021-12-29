SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[stgVentaClienteMA] (
		[CodEmpresa]              [int] NOT NULL,
		[CodCliente]              [int] NOT NULL,
		[Cantidad]                [numeric](12, 3) NOT NULL,
		[KilosCafe]               [numeric](12, 3) NOT NULL,
		[Importe]                 [money] NOT NULL,
		[ImporteCafe]             [money] NOT NULL,
		[ImportePLV]              [money] NOT NULL,
		[ImporteComplementos]     [money] NOT NULL,
		[PrecioMedioCafe]         [money] NOT NULL,
		[RatioComplementos]       [money] NOT NULL,
		[create_timestamp]        [datetime] NOT NULL,
		CONSTRAINT [PK_stgVentaClienteMA]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgVentaClienteMA] SET (LOCK_ESCALATION = TABLE)
GO
