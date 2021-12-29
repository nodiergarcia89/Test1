SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[inaDatosMaquinaria] (
		[CodEmpresa]           [int] NOT NULL,
		[CodArticulo]          [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Fabricante]           [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Modelo]               [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PrecioIIBTB]          [money] NOT NULL,
		[PrecioSIBTB]          [money] NOT NULL,
		[PrecioIIDist]         [money] NOT NULL,
		[PrecioSIDist]         [money] NOT NULL,
		[PVP]                  [money] NOT NULL,
		[NGrupos]              [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NSalidasVapor]        [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NSalidasAgua]         [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CapacidadCaldera]     [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Resistencia]          [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Voltaje]              [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Peso]                 [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Anchura]              [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Altura]               [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Profundidad]          [char](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_inaDatosMaquinaria]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CodArticulo])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inaDatosMaquinaria] SET (LOCK_ESCALATION = TABLE)
GO
