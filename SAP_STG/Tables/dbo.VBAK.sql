SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VBAK] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBELN]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERZET]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ERNAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ANGDT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BNDDT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBTYP]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TRVOG]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUART]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUGRU]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GWLDT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SUBMI]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LIFSK]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FAKSK]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NETWR]                [numeric](15, 2) NOT NULL,
		[WAERK]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VKORG]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VTWEG]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPART]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VKGRP]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VKBUR]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GSBER]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GSKST]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GUEBG]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GUEEN]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KNUMV]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VDATU]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VPRGR]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUTLF]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBKLA]                [nvarchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBKLT]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KALSM]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VSBED]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FKARA]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AWAHR]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KTEXT]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BSTNK]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BSARK]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BSTDK]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BSTZD]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IHREZ]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BNAME]                [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TELF1]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MAHZA]                [numeric](3, 0) NOT NULL,
		[MAHDT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KOSTL]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STAFO]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STWAE]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AEDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KVGR1]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KVGR2]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KVGR3]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KVGR4]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KVGR5]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KNUMA]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KOKRS]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PS_PSP_PNR]           [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KURST]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KKBER]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KNKLI]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GRUPP]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SBGRP]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CTLPC]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CMWAE]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CMFRE]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CMNUP]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CMNGV]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AMTBL]                [numeric](15, 2) NOT NULL,
		[HITYP_PR]             [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ABRVW]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ABDIS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VGBEL]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OBJNR]                [nvarchar](22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BUKRS_VF]             [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK1]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK2]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK3]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK4]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK5]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK6]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK7]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK8]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXK9]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XBLNR]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZUONR]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VGTYP]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KALSM_CH]             [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AGRZR]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUFNR]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[QMNUM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBELN_GRP]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SCHEME_GRP]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ABRUF_PART]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ABHOD]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ABHOV]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ABHOB]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RPLNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VZEIT]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STCEG_L]              [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LANDTX]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XEGDR]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ENQUEUE_GRP]          [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DAT_FZAU]             [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FMBDAT]               [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VSNMR_V]              [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HANDLE]               [nvarchar](22) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROLI]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CONT_DG]              [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CRM_GUID]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UPD_TMSTMP]           [numeric](21, 7) NOT NULL,
		[MSR_ID]               [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SWENR]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SMENR]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PHASE]                [nvarchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MTLAUR]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STAGE]                [int] NOT NULL,
		[HB_CONT_REASON]       [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HB_EXPDATE]           [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HB_RESDATE]           [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MILL_APPL_ID]         [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LOGSYSB]              [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KALCD]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MULTI]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WTYSC_CLM_HDR]        [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZZFINPAG]             [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZZINDPAG]             [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZZCLASE]              [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		[update_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_VBAK]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [VBELN])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VBAK]
	ADD
	CONSTRAINT [DF_VBAK_CodEmpresa]
	DEFAULT ((2)) FOR [CodEmpresa]
GO
CREATE NONCLUSTERED INDEX [_dta_index_VBAK_7_603865218__K2_K3_4_5_10_12_21_24_30_40_41_42_49_53]
	ON [dbo].[VBAK] ([MANDT], [VBELN])
	INCLUDE ([ERDAT], [ERZET], [VBTYP], [AUART], [BSARK], [BSTDK], [KUNNR], [AEDAT], [VTWEG], [VKBUR], [VDATU], [BSTNK])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[VBAK] SET (LOCK_ESCALATION = TABLE)
GO
