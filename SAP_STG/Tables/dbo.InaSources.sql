SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InaSources] (
		[idFase]                     [tinyint] NOT NULL,
		[SourceName]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IdSystem]                   [tinyint] NOT NULL,
		[SourceTableName]            [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OrdenBorrado]               [smallint] NOT NULL,
		[OrdenCarga]                 [smallint] NOT NULL,
		[Tratar]                     [int] NOT NULL,
		[TipoBorrado]                [int] NOT NULL,
		[FechaExtraccion]            [datetime] NULL,
		[FilasBorradas]              [int] NOT NULL,
		[FilasAfectadas]             [int] NOT NULL,
		[FilasAnteriores]            [int] NOT NULL,
		[TotalRegistros]             [int] NOT NULL,
		[TiempoBorrado]              [int] NOT NULL,
		[TiempoLlenado]              [int] NOT NULL,
		[TiempoProceso]              [int] NOT NULL,
		[DestinationTableName]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SourceTableDescription]     [char](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoProceso]                [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_Sources_2]
		PRIMARY KEY
		CLUSTERED
		([SourceName])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InaSources]
	ADD
	CONSTRAINT [DF__InaSource__Trata__2F650636]
	DEFAULT ((0)) FOR [Tratar]
GO
ALTER TABLE [dbo].[InaSources]
	ADD
	CONSTRAINT [DF_InaSources_TipoBorrado]
	DEFAULT ((0)) FOR [TipoBorrado]
GO
ALTER TABLE [dbo].[InaSources]
	ADD
	CONSTRAINT [DF__InaSource__Filas__3335971A]
	DEFAULT ((0)) FOR [FilasBorradas]
GO
ALTER TABLE [dbo].[InaSources]
	ADD
	CONSTRAINT [DF__InaSource__Filas__3429BB53]
	DEFAULT ((0)) FOR [FilasAfectadas]
GO
ALTER TABLE [dbo].[InaSources]
	ADD
	CONSTRAINT [DF__InaSource__Filas__351DDF8C]
	DEFAULT ((0)) FOR [FilasAnteriores]
GO
ALTER TABLE [dbo].[InaSources]
	ADD
	CONSTRAINT [DF__InaSource__Total__361203C5]
	DEFAULT ((0)) FOR [TotalRegistros]
GO
ALTER TABLE [dbo].[InaSources]
	ADD
	CONSTRAINT [DF__InaSource__Tiemp__370627FE]
	DEFAULT ((0)) FOR [TiempoProceso]
GO
ALTER TABLE [dbo].[InaSources] SET (LOCK_ESCALATION = TABLE)
GO
