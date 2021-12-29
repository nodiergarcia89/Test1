SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[iClientes_BORRAR] (
		[codEmpresa]                  [int] NOT NULL,
		[codCliente]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[nomCliente]                  [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[rsoCliente]                  [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[cifCliente]                  [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codZona]                     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codAgente]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codTipoCliente]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[tipIVA]                      [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[tpcDto01]                    [numeric](5, 2) NOT NULL,
		[tpcDto02]                    [numeric](5, 2) NOT NULL,
		[tpcDtoPp]                    [numeric](5, 2) NOT NULL,
		[codFormaPago]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[flaNvoCliente]               [tinyint] NOT NULL,
		[flaExpCliente]               [tinyint] NOT NULL,
		[codTarifa]                   [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codGrupoPreciosCliente]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[flaObsoleto]                 [tinyint] NOT NULL,
		[impPendienteRiesgo]          [numeric](18, 6) NOT NULL,
		[impVencidoRiesgo]            [numeric](18, 6) NOT NULL,
		[impImpagadoRiesgo]           [numeric](18, 6) NOT NULL,
		[impCoberturaRiesgo]          [numeric](18, 6) NOT NULL,
		[flaBloqueaClienteRiesgo]     [tinyint] NOT NULL,
		[codMonedaRiesgo]             [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codIdioma]                   [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datIBAN]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codSector]                   [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datBlog]                     [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[impFacturacion]              [numeric](18, 6) NOT NULL,
		[obsClienteNoEdi]             [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[obsClienteEdi]               [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom1]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom2]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom3]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom4]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Custom5]                     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[fecAltaCliente]              [datetime] NOT NULL,
		CONSTRAINT [PK_iClientes]
		PRIMARY KEY
		CLUSTERED
		([codEmpresa], [codCliente])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[iClientes_BORRAR] SET (LOCK_ESCALATION = TABLE)
GO
