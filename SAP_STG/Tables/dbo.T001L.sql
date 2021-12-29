SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T001L] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[WERKS]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LGORT]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LGOBE]                [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPART]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XLONG]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XBUFX]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DISKZ]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XBLGO]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XRESS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[XHUPF]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PARLG]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VKORG]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VTWEG]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VSTEL]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LIFNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KUNNR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OIH_LICNO]            [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OIG_ITRFL]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OIB_TNKASSIGN]        [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_T001L]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [MANDT], [WERKS], [LGORT])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T001L] SET (LOCK_ESCALATION = TABLE)
GO
