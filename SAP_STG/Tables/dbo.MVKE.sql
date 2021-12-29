SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MVKE] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MATNR]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VKORG]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VTWEG]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LVORM]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERSG]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BONUS]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROVG]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SKTOF]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VMSTA]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VMSTD]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUMNG]                [numeric](13, 3) NOT NULL,
		[LFMNG]                [numeric](13, 3) NOT NULL,
		[EFMNG]                [numeric](13, 3) NOT NULL,
		[SCMNG]                [numeric](13, 3) NOT NULL,
		[SCHME]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VRKME]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MTPOS]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DWERK]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRODH]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PMATN]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KONDM]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KTGRM]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MVGR1]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MVGR2]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MVGR3]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MVGR4]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MVGR5]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SSTUF]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PFLKS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LSTFL]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LSTVZ]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LSTAK]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LDVFL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LDBFL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LDVZL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LDBZL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VDVFL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VDBFL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VDVZL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VDBZL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT1]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT2]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT3]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT4]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT5]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT6]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT7]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT8]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRAT9]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRATA]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RDPRF]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MEGRU]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LFMAX]                [numeric](13, 3) NOT NULL,
		[RJART]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PBIND]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VAVME]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MATKC]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PVMSO]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/EMLGRP]         [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/EMDRCKSPL]      [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/RPBEZME]        [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/RPSNS]          [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/RPSFA]          [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/RPSKI]          [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/RPSCO]          [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[/BEV1/RPSSO]          [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PLGTP]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRATB]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[create_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_MVKE]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [MANDT], [MATNR], [VKORG], [VTWEG])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_MVKE_7_1813581499__K5_K2_K3_19_25_26_27_28_29]
	ON [dbo].[MVKE] ([VTWEG], [MANDT], [MATNR])
	INCLUDE ([MTPOS], [MVGR1], [MVGR2], [MVGR3], [MVGR4], [MVGR5])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[MVKE] SET (LOCK_ESCALATION = TABLE)
GO
