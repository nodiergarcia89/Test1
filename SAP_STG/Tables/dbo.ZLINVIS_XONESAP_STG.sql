SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZLINVIS_XONESAP_STG] (
		[CodEmpresa]           [int] NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PERNR]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TIPVI]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VISIT]                [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POSNR]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MATNR]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CANTI]                [numeric](15, 3) NOT NULL,
		[PREUN]                [numeric](11, 3) NOT NULL,
		[TIPOP]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LOTES]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POSAP]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ACCION]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERNAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERSDA]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERZET]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		[update_timestamp]     [datetime] NULL,
		[audit_key]            [int] NULL,
		CONSTRAINT [PK_ZLINVIS_XONESAP_STG]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [PERNR], [TIPVI], [VISIT], [POSNR])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZLINVIS_XONESAP_STG] SET (LOCK_ESCALATION = TABLE)
GO
