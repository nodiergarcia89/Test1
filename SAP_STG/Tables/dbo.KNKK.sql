SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KNKK] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KKBER]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KLIMK]                [numeric](15, 2) NOT NULL,
		[KNKLI]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SAUFT]                [numeric](15, 2) NOT NULL,
		[SKFOR]                [numeric](15, 2) NOT NULL,
		[SSOBL]                [numeric](15, 2) NOT NULL,
		[UEDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XCHNG]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERNAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CTLPC]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DTREV]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CRBLB]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SBGRP]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NXTRV]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KRAUS]                [nvarchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PAYDB]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DBRAT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[REVDB]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AEDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AETXT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GRUPP]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AENAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SBDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KDGRP]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CASHD]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CASHA]                [numeric](13, 2) NOT NULL,
		[CASHC]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DBPAY]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DBRTG]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DBEKR]                [numeric](15, 2) NOT NULL,
		[DBWAE]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DBMON]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ABSBT]                [numeric](15, 2) NOT NULL,
		[create_timestamp]     [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_KNKK_7_1518628453__K3_K1_K4]
	ON [dbo].[KNKK] ([KUNNR], [CodEmpresa], [KKBER])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[KNKK] SET (LOCK_ESCALATION = TABLE)
GO
