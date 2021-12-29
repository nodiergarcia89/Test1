SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KNBK] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BANKS]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BANKL]                [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BANKN]                [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BKONT]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BVTYP]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XEZER]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BKREF]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KOINH]                [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EBPP_ACCNAME]         [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EBPP_BVSTATUS]        [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KOVON]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KOBIS]                [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_KNBK]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [KUNNR], [BANKS], [BANKL], [BANKN])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KNBK] SET (LOCK_ESCALATION = TABLE)
GO
