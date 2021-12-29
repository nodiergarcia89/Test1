SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[iReportesLin_Modificados] (
		[codEmpresa]               [int] NOT NULL,
		[nomIPad]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codReporte]               [int] NOT NULL,
		[codPlantillaReportes]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[linReportesLin]           [int] NOT NULL,
		[desCampo]                 [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codTipoCampo]             [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[desLista]                 [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[flaObligado]              [tinyint] NOT NULL,
		[ordReportesLin]           [int] NOT NULL,
		[datRespuesta]             [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Procesado]                [int] NOT NULL,
		[FecProceso]               [datetime] NOT NULL,
		CONSTRAINT [PK_iReportesLin_Modificados]
		PRIMARY KEY
		CLUSTERED
		([codEmpresa], [nomIPad], [codReporte], [linReportesLin])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[iReportesLin_Modificados] SET (LOCK_ESCALATION = TABLE)
GO
