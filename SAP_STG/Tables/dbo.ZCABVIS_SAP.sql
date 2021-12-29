SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZCABVIS_SAP] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VLCNDO]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCTIDE]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCNNOR]               [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCFAEN]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCFASN]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCNNDE]               [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCTIDO]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCCOCL]               [nvarchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCFEVI]               [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCHOVI]               [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCCNAL]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCSUBA]               [numeric](9, 2) NOT NULL,
		[VCSUIV]               [numeric](9, 2) NOT NULL,
		[VCSURE]               [numeric](9, 2) NOT NULL,
		[VCSUB0]               [numeric](9, 2) NOT NULL,
		[VCSUI0]               [numeric](9, 2) NOT NULL,
		[VCSUR0]               [numeric](9, 2) NOT NULL,
		[VCSUB1]               [numeric](9, 2) NOT NULL,
		[VCSUI1]               [numeric](9, 2) NOT NULL,
		[VCSUR1]               [numeric](9, 2) NOT NULL,
		[VCTOIV]               [numeric](9, 2) NOT NULL,
		[VCTOI0]               [numeric](9, 2) NOT NULL,
		[VCTOI1]               [numeric](9, 2) NOT NULL,
		[VCOBSE]               [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCTCOB]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCNRIM]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCCLAV]               [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCFESE]               [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VCTERO]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ACCION]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBELN_P]              [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MBLNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MJAHR]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBELN_F]              [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BUKRS]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BELNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[GJAHR]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VBELN_E]              [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ERNAM]                [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ERSDA]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[UZBER]                [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NUMLIQ]               [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VBELN_REC]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VBELN_FREC]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VBELN_CAM]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[VBELN_FCAM]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NUMVISAUX]            [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_ZCABVIS_SAP]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [MANDT], [VLCNDO], [VCTIDE], [VCNNOR])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZCABVIS_SAP] SET (LOCK_ESCALATION = TABLE)
GO
