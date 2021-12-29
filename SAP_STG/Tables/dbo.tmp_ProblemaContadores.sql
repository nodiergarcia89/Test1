SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_ProblemaContadores] (
		[CodAgente]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Nombre]              [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UltimoReportado]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaReporte]        [datetime] NOT NULL,
		[UltimoAlta]          [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FechaAlta]           [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tmp_ProblemaContadores] SET (LOCK_ESCALATION = TABLE)
GO
