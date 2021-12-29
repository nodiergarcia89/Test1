SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_ReportesVisita_CT] (
		[codEmpresa]               [int] NOT NULL,
		[nomIPad]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codReporte]               [int] NOT NULL,
		[CodCliente]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[fecReporte]               [datetime] NOT NULL,
		[codPlantillaReportes]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[linReportesLin]           [int] NOT NULL,
		[datRespuesta]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codReporte_CT]            [int] NOT NULL,
		[Procesado]                [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tmp_ReportesVisita_CT] SET (LOCK_ESCALATION = TABLE)
GO
