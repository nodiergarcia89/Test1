SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[iClientesLDir_Pot] (
		[IdRegistro]             [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codEmpresa]             [int] NOT NULL,
		[codCliente]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[linDirCli]              [int] NOT NULL,
		[nomDirCli]              [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[rsoDirCli]              [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datCalleDirCli]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codPostalDirCli]        [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datPoblacionDirCli]     [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datProvinciaDirCli]     [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datPaisDirCli]          [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datContactoDirCli]      [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datTelefonoDirCli]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datFaxDirCli]           [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[datEmailDirCli]         [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[hipWebDirCli]           [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codSuDirCli]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[valLatitud]             [float] NOT NULL,
		[valLongitud]            [float] NOT NULL,
		[datTelMovilDirCli]      [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[codAgente]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[flaNvoDirCli]           [int] NOT NULL,
		[FechaAlta]              [datetime] NOT NULL,
		[Estado]                 [tinyint] NULL,
		CONSTRAINT [PK_iClientesLDir_Pot]
		PRIMARY KEY
		CLUSTERED
		([IdRegistro])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170217-084029]
	ON [dbo].[iClientesLDir_Pot] ([codEmpresa], [codCliente], [linDirCli])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[iClientesLDir_Pot] SET (LOCK_ESCALATION = TABLE)
GO
