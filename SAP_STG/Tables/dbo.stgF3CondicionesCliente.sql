SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stgF3CondicionesCliente] (
		[CodEmpresa]            [int] NOT NULL,
		[CodCliente]            [int] NOT NULL,
		[NombreCliente]         [char](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodNivel1]             [smallint] NOT NULL,
		[Nivel1]                [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NumReg]                [int] NOT NULL,
		[CodArticulo]           [int] NOT NULL,
		[Articulo]              [char](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Unidad_Medida]         [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PrecioTarifaFinal]     [money] NOT NULL,
		[PrecioCliente]         [money] NOT NULL,
		[CondEsp]               [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Base]                  [numeric](13, 3) NOT NULL,
		[Regalo]                [numeric](13, 3) NOT NULL,
		[Importe]               [money] NOT NULL,
		[CantMes1]              [numeric](13, 3) NOT NULL,
		[CantMes2]              [numeric](13, 3) NOT NULL,
		[CantMes3]              [numeric](13, 3) NOT NULL,
		[CantMes4]              [numeric](13, 3) NOT NULL,
		[create_timestamp]      [datetime] NOT NULL,
		CONSTRAINT [PK_stgF3CondicionesCliente]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodCliente], [CodNivel1], [NumReg])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[stgF3CondicionesCliente] SET (LOCK_ESCALATION = TABLE)
GO
