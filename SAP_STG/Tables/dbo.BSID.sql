SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BSID] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BUKRS]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UMSKS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UMSKZ]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUGDT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUGBL]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZUONR]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GJAHR]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BELNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BUZEI]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BUDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BLDAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CPUDT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WAERS]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XBLNR]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BLART]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MONAT]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BSCHL]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZUMSK]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SHKZG]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GSBER]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MWSKZ]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DMBTR]                [numeric](13, 2) NOT NULL,
		[WRBTR]                [numeric](13, 2) NOT NULL,
		[MWSTS]                [numeric](13, 2) NOT NULL,
		[WMWST]                [numeric](13, 2) NOT NULL,
		[BDIFF]                [numeric](13, 2) NOT NULL,
		[BDIF2]                [numeric](13, 2) NOT NULL,
		[SGTXT]                [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROJN]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUFNR]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ANLN1]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ANLN2]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SAKNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HKONT]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FKONT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FILKD]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZFBDT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZTERM]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZBD1T]                [numeric](3, 0) NOT NULL,
		[ZBD2T]                [numeric](3, 0) NOT NULL,
		[ZBD3T]                [numeric](3, 0) NOT NULL,
		[ZBD1P]                [numeric](5, 3) NOT NULL,
		[ZBD2P]                [numeric](5, 3) NOT NULL,
		[SKFBT]                [numeric](13, 2) NOT NULL,
		[SKNTO]                [numeric](13, 2) NOT NULL,
		[WSKTO]                [numeric](13, 2) NOT NULL,
		[ZLSCH]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZLSPR]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZBFIX]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HBKID]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BVTYP]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[REBZG]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[REBZJ]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[REBZZ]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SAMNR]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ANFBN]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ANFBJ]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ANFBU]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ANFAE]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MANSP]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MSCHL]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MADAT]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MANST]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MABER]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XNETB]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XANET]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XCPDD]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XINVE]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XZAHL]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MWSK1]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DMBT1]                [numeric](13, 2) NOT NULL,
		[WRBT1]                [numeric](13, 2) NOT NULL,
		[MWSK2]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DMBT2]                [numeric](13, 2) NOT NULL,
		[WRBT2]                [numeric](13, 2) NOT NULL,
		[MWSK3]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DMBT3]                [numeric](13, 2) NOT NULL,
		[WRBT3]                [numeric](13, 2) NOT NULL,
		[BSTAT]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBUND]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBELN]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[REBZT]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[INFAE]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STCEG]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EGBLD]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EGLLD]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RSTGR]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XNOZA]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERTT]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VERTN]                [nvarchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBEWA]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WVERW]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROJK]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FIPOS]                [nvarchar](14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NPLNR]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUFPL]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[APLZL]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XEGDR]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DMBE2]                [numeric](13, 2) NOT NULL,
		[DMBE3]                [numeric](13, 2) NOT NULL,
		[DMB21]                [numeric](13, 2) NOT NULL,
		[DMB22]                [numeric](13, 2) NOT NULL,
		[DMB23]                [numeric](13, 2) NOT NULL,
		[DMB31]                [numeric](13, 2) NOT NULL,
		[DMB32]                [numeric](13, 2) NOT NULL,
		[DMB33]                [numeric](13, 2) NOT NULL,
		[BDIF3]                [numeric](13, 2) NOT NULL,
		[XRAGL]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UZAWE]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XSTOV]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MWST2]                [numeric](13, 2) NOT NULL,
		[MWST3]                [numeric](13, 2) NOT NULL,
		[SKNT2]                [numeric](13, 2) NOT NULL,
		[SKNT3]                [numeric](13, 2) NOT NULL,
		[XREF1]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XREF2]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XARCH]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PSWSL]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PSWBT]                [numeric](13, 2) NOT NULL,
		[LZBKZ]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LANDL]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[IMKEY]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBEL2]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VPOS2]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POSN2]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ETEN2]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FISTL]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GEBER]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DABRZ]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XNEGP]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KOSTL]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RFZEI]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KKBER]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EMPFB]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PRCTR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XREF3]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[QSSKZ]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ZINKZ]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DTWS1]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DTWS2]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DTWS3]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DTWS4]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XPYPR]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KIDNO]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ABSBT]                [numeric](13, 2) NOT NULL,
		[CCBTC]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PYCUR]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PYAMT]                [numeric](13, 2) NOT NULL,
		[BUPLA]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SECCO]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CESSION_KZ]           [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PPDIFF]               [numeric](13, 2) NOT NULL,
		[PPDIF2]               [numeric](13, 2) NOT NULL,
		[PPDIF3]               [numeric](13, 2) NOT NULL,
		[KBLNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KBLPOS]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GRANT_NBR]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[GMVKZ]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SRTYPE]               [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LOTKZ]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FKBER]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[INTRENO]              [nvarchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PPRCT]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BUZID]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AUGGJ]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HKTID]                [nvarchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BUDGET_PD]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MNDID]                [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KONTT]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KONTL]                [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UEBGDAT]              [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VNAME]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EGRUP]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BTYPE]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROPMANO]             [nvarchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_BSID]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [BUKRS], [KUNNR], [UMSKS], [UMSKZ], [AUGDT], [AUGBL], [ZUONR], [GJAHR], [BELNR], [BUZEI])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BSID] SET (LOCK_ESCALATION = TABLE)
GO