SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InaSources_Procesos] (
		[GUIDProceso]         [uniqueidentifier] NULL,
		[idFase]              [tinyint] NOT NULL,
		[SourceTableName]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FechaExtraccion]     [datetime] NULL,
		[FilasBorradas]       [int] NOT NULL,
		[FilasAfectadas]      [int] NOT NULL,
		[FilasAnteriores]     [int] NOT NULL,
		[TotalRegistros]      [int] NOT NULL,
		[TiempoBorrado]       [int] NOT NULL,
		[TiempoLlenado]       [int] NOT NULL,
		[TiempoProceso]       [int] NOT NULL,
		[TipoProceso]         [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaProceso]        [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[InaSources_Procesos] SET (LOCK_ESCALATION = TABLE)
GO
