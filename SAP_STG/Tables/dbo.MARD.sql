SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MARD] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MATNR]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WERKS]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LGORT]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PSTAT]                [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LVORM]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LFGJA]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LFMON]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPERR]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LABST]                [numeric](13, 3) NOT NULL,
		[UMLME]                [numeric](13, 3) NOT NULL,
		[INSME]                [numeric](13, 3) NOT NULL,
		[EINME]                [numeric](13, 3) NOT NULL,
		[SPEME]                [numeric](13, 3) NOT NULL,
		[RETME]                [numeric](13, 3) NOT NULL,
		[VMLAB]                [numeric](13, 3) NOT NULL,
		[VMUML]                [numeric](13, 3) NOT NULL,
		[VMINS]                [numeric](13, 3) NOT NULL,
		[VMEIN]                [numeric](13, 3) NOT NULL,
		[VMSPE]                [numeric](13, 3) NOT NULL,
		[VMRET]                [numeric](13, 3) NOT NULL,
		[KZILL]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZILQ]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZILE]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZILS]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZVLL]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZVLQ]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZVLE]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZVLS]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DISKZ]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LSOBS]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LMINB]                [numeric](13, 3) NOT NULL,
		[LBSTF]                [numeric](13, 3) NOT NULL,
		[HERKL]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EXPPG]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EXVER]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LGPBE]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KLABS]                [numeric](13, 3) NOT NULL,
		[KINSM]                [numeric](13, 3) NOT NULL,
		[KEINM]                [numeric](13, 3) NOT NULL,
		[KSPEM]                [numeric](13, 3) NOT NULL,
		[DLINL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRCTL]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERSDA]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VKLAB]                [numeric](13, 2) NOT NULL,
		[VKUML]                [numeric](13, 2) NOT NULL,
		[LWMKB]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BSKRF]                [float] NOT NULL,
		[MDRUE]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MDJIN]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_MARD]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [MATNR], [WERKS], [LGORT])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_MARD_7_1899153811__K4_K2_K3_K1_11]
	ON [dbo].[MARD] ([WERKS], [MANDT], [MATNR], [CodEmpresa])
	INCLUDE ([LABST])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MARD] SET (LOCK_ESCALATION = TABLE)
GO
