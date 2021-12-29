SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[iReportesLin_Pot] (
		[IdRegistro]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
		[FechaAlta]                [datetime] NOT NULL,
		[Estado]                   [tinyint] NULL,
		CONSTRAINT [PK_iReportesLin_Pot]
		PRIMARY KEY
		CLUSTERED
		([IdRegistro])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_iReportesLin_Pot_7_720721620__K10_K1_K2_K3_11]
	ON [dbo].[iReportesLin_Pot] ([ordReportesLin], [codEmpresa], [nomIPad], [codReporte])
	INCLUDE ([datRespuesta])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170217-092635]
	ON [dbo].[iReportesLin_Pot] ([codEmpresa], [nomIPad], [codReporte], [linReportesLin])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[iReportesLin_Pot] SET (LOCK_ESCALATION = TABLE)
GO
