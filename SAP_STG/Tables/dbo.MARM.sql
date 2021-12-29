SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MARM] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MATNR]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MEINH]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UMREZ]                [numeric](5, 0) NOT NULL,
		[UMREN]                [numeric](5, 0) NOT NULL,
		[EANNR]                [nvarchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EAN11]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NUMTP]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LAENG]                [numeric](13, 3) NOT NULL,
		[BREIT]                [numeric](13, 3) NOT NULL,
		[HOEHE]                [numeric](13, 3) NOT NULL,
		[MEABM]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VOLUM]                [numeric](13, 3) NOT NULL,
		[VOLEH]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BRGEW]                [numeric](13, 3) NOT NULL,
		[GEWEI]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MESUB]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ATINN]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MESRT]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XFHDW]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XBEWW]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KZWSO]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MSEHI]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BFLME_MARM]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GTIN_VARIANT]         [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NEST_FTR]             [numeric](3, 0) NOT NULL,
		[MAX_STACK]            [tinyint] NOT NULL,
		[CAPAUSE]              [numeric](15, 3) NOT NULL,
		[TY2TQ]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_MARM]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [MATNR], [MEINH])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_MARM_7_1845581613__K4_K2_K3_5_6]
	ON [dbo].[MARM] ([MEINH], [MANDT], [MATNR])
	INCLUDE ([UMREZ], [UMREN])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_MARM_7_1845581613__K4_K3_K1_K2]
	ON [dbo].[MARM] ([MEINH], [MATNR], [CodEmpresa], [MANDT])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_MARM_7_1845581613__K4_K3_K1_K2_5_6]
	ON [dbo].[MARM] ([MEINH], [MATNR], [CodEmpresa], [MANDT])
	INCLUDE ([UMREZ], [UMREN])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MARM] SET (LOCK_ESCALATION = TABLE)
GO
