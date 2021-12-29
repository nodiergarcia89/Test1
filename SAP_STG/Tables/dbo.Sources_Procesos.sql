SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sources_Procesos] (
		[GUIDProceso]                [uniqueidentifier] NULL,
		[idFase]                     [tinyint] NOT NULL,
		[SourceName]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Orden]                      [smallint] NOT NULL,
		[SourceIsIncremental]        [bit] NOT NULL,
		[DiasRetencion]              [int] NOT NULL,
		[IncrementalDate]            [datetime] NULL,
		[DiasExtras]                 [int] NOT NULL,
		[FechaExtraccion]            [datetime] NULL,
		[FilasBorradas]              [int] NOT NULL,
		[FilasAfectadas]             [int] NOT NULL,
		[FilasAnteriores]            [int] NOT NULL,
		[TotalRegistros]             [int] NOT NULL,
		[TiempoProceso]              [int] NOT NULL,
		[SourceTableDescription]     [char](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DestinationTableName]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TipoProceso]                [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IdSourceSystem]             [tinyint] NULL,
		[FechaProceso]               [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sources_Procesos] SET (LOCK_ESCALATION = TABLE)
GO
