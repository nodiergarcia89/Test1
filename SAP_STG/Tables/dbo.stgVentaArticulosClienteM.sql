SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgVentaArticulosClienteM] (
		[CodEmpresa]              [int] NOT NULL,
		[CodCliente]              [int] NOT NULL,
		[CodNivel1]               [int] NOT NULL,
		[Nivel1]                  [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodArticulo]             [int] NOT NULL,
		[Articulo]                [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Cantidad]                [numeric](12, 3) NOT NULL,
		[KilosCafe]               [numeric](12, 3) NOT NULL,
		[Importe]                 [money] NOT NULL,
		[ImporteCafe]             [money] NOT NULL,
		[ImportePLV]              [money] NOT NULL,
		[ImporteComplementos]     [money] NOT NULL,
		[PrecioMedioCafe]         [money] NOT NULL,
		[create_timestamp]        [datetime] NOT NULL,
		CONSTRAINT [PK_stgVentaArticulosClienteM]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente], [CodNivel1], [CodArticulo])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgVentaArticulosClienteM]
	ADD
	CONSTRAINT [DF_stgVentaArticulosClienteM_ImportePLV]
	DEFAULT ((0)) FOR [ImportePLV]
GO
ALTER TABLE [dbo].[stgVentaArticulosClienteM] SET (LOCK_ESCALATION = TABLE)
GO
