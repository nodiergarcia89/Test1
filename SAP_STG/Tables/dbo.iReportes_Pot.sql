SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[iReportes_Pot] (
		[IdRegistro]               [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codEmpresa]               [int] NOT NULL,
		[nomIPad]                  [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codReporte]               [int] NOT NULL,
		[fecReporte]               [datetime] NOT NULL,
		[desReporte]               [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codPlantillaReportes]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codPedido]                [int] NOT NULL,
		[codCliente]               [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codAgente]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codArticulo]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[flaExpReporte]            [tinyint] NOT NULL,
		[codTipoPlantilla]         [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[flaPedirFoto]             [tinyint] NOT NULL,
		[FechaAlta]                [datetime] NOT NULL,
		[Estado]                   [tinyint] NULL,
		CONSTRAINT [PK_iReportes_Pot]
		PRIMARY KEY
		CLUSTERED
		([IdRegistro])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_iReportes_Pot_7_704721563__K1_K2_K3_K8_K6_K4]
	ON [dbo].[iReportes_Pot] ([codEmpresa], [nomIPad], [codReporte], [codCliente], [codPlantillaReportes], [fecReporte])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170217-085840]
	ON [dbo].[iReportes_Pot] ([codEmpresa], [nomIPad], [codReporte])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[iReportes_Pot] SET (LOCK_ESCALATION = TABLE)
GO
