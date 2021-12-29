SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sources] (
		[IdRegistro]                 [int] IDENTITY(1, 1) NOT NULL,
		[idFase]                     [tinyint] NOT NULL,
		[SourceName]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IdSourceSystem]             [tinyint] NOT NULL,
		[Mandante]                   [int] NOT NULL,
		[SourceTableName]            [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CodEmpresa]                 [int] NOT NULL,
		[Orden]                      [smallint] NOT NULL,
		[Tratar]                     [bit] NOT NULL,
		[SourceIsIncremental]        [bit] NOT NULL,
		[DiasRetencion]              [int] NOT NULL,
		[IncrSrcColumnName]          [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IncrDestColumnName]         [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IncrementalDate]            [datetime] NULL,
		[DiasExtras]                 [int] NOT NULL,
		[FiltroAdicional]            [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaExtraccion]            [datetime] NULL,
		[FilasBorradas]              [int] NOT NULL,
		[FilasAfectadas]             [int] NOT NULL,
		[FilasAnteriores]            [int] NOT NULL,
		[TotalRegistros]             [int] NOT NULL,
		[TiempoProceso]              [int] NOT NULL,
		[DestinationTableName]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SourceTableDescription]     [char](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoProceso]                [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_Sources_1]
		PRIMARY KEY
		CLUSTERED
		([SourceName])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_TotalRegistros]
	DEFAULT ((0)) FOR [TotalRegistros]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_TiempoProceso]
	DEFAULT ((0)) FOR [TiempoProceso]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_Mandante]
	DEFAULT ((0)) FOR [Mandante]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_Tratar]
	DEFAULT ((0)) FOR [Tratar]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_SourceIsIncremental]
	DEFAULT ((0)) FOR [SourceIsIncremental]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_DiasRetencion]
	DEFAULT ((0)) FOR [DiasRetencion]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_DiasExtras]
	DEFAULT ((0)) FOR [DiasExtras]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_FilasBorradas]
	DEFAULT ((0)) FOR [FilasBorradas]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_FilasAfectadas]
	DEFAULT ((0)) FOR [FilasAfectadas]
GO
ALTER TABLE [dbo].[Sources]
	ADD
	CONSTRAINT [DF_Sources_FilasAnteriores]
	DEFAULT ((0)) FOR [FilasAnteriores]
GO
ALTER TABLE [dbo].[Sources]
	WITH CHECK
	ADD CONSTRAINT [FK_Sources_SourceFases]
	FOREIGN KEY ([idFase]) REFERENCES [dbo].[SourceFases] ([idFase])
ALTER TABLE [dbo].[Sources]
	CHECK CONSTRAINT [FK_Sources_SourceFases]

GO
ALTER TABLE [dbo].[Sources]
	WITH CHECK
	ADD CONSTRAINT [FK_Sources_SourceSystems]
	FOREIGN KEY ([IdSourceSystem]) REFERENCES [dbo].[SourceSystems] ([IdSourceSystem])
ALTER TABLE [dbo].[Sources]
	CHECK CONSTRAINT [FK_Sources_SourceSystems]

GO
ALTER TABLE [dbo].[Sources] SET (LOCK_ESCALATION = TABLE)
GO
