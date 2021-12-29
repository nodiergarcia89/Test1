SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VBPA] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBELN]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PARVW]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [int] NOT NULL,
		[LIFNR]                [int] NOT NULL,
		[PERNR]                [int] NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_VBPA_1]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [VBELN], [PARVW])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_VBPA_7_1771869379__K1_K3_4_5]
	ON [dbo].[VBPA] ([CodEmpresa], [VBELN])
	INCLUDE ([PARVW], [KUNNR])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_VBPA_7_1771869379__K1_K3_K4_5]
	ON [dbo].[VBPA] ([CodEmpresa], [VBELN], [PARVW])
	INCLUDE ([KUNNR])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_VBPA_7_1771869379__K1_K3_K4_7]
	ON [dbo].[VBPA] ([CodEmpresa], [VBELN], [PARVW])
	INCLUDE ([PERNR])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_VBPA_7_1771869379__K4_K1_K3_6]
	ON [dbo].[VBPA] ([PARVW], [CodEmpresa], [VBELN])
	INCLUDE ([LIFNR])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ZRVG01-VBPA]
	ON [dbo].[VBPA] ([PARVW])
	INCLUDE ([VBELN], [KUNNR])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[VBPA] SET (LOCK_ESCALATION = TABLE)
GO
