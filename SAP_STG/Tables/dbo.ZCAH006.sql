SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZCAH006] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBELN]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POSNR]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MATNR]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[N_SERIE]              [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CANTIDAD]             [numeric](13, 3) NOT NULL,
		[UM]                   [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IMPORTE]              [numeric](13, 2) NOT NULL,
		[MONEDA]               [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WERKS]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ENTR_MOD]             [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COSTE_MAQ]            [numeric](13, 2) NOT NULL,
		[MATNR_PROP]           [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PARCIAL]              [numeric](13, 2) NOT NULL,
		[GASTO]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SERGE]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CHARG]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MODIF]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UPDKZ]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[APROB]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RECHAZADO]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BORRADO]              [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FECHA_MOD]            [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POSNR_MOD]            [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COSTE]                [numeric](13, 2) NOT NULL,
		[Starting]             [datetime2](7) NOT NULL,
		[Ending]               [datetime2](7) NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_ZCAH006]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [VBELN], [POSNR])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZCAH006] SET (LOCK_ESCALATION = TABLE)
GO
