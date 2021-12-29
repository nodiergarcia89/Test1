SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ZCAH003] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VBELN]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NAME1]                [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STRAS]                [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STRS2]                [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ORT01]                [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PSTLZ]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PROVINCIA]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LAND1]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XFELD]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STCD1]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RESP_ALTA]            [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RESP_ALTA_AD]         [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ADMIN_ESTAB]          [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_VORNA_ESTAB]       [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_NACHN_ESTAB]       [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_NACH2_ESTAB]       [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_STRAS_ESTAB]       [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_ORT01_ESTAB]       [nvarchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_LAND1_ESTAB]       [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AD_STCDA_ESTAB]       [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Starting]             [datetime2](7) NOT NULL,
		[Ending]               [datetime2](7) NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_ZCAH003]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [VBELN], [KUNNR])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ZCAH003] SET (LOCK_ESCALATION = TABLE)
GO
