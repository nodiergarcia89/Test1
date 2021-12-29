SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SRGBTBREL] (
		[CodEmpresa]           [int] NOT NULL,
		[CLIENT]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BRELGUID]             [varbinary](16) NOT NULL,
		[RELTYPE]              [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[INSTID_A]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TYPEID_A]             [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CATID_A]              [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[INSTID_B]             [nvarchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TYPEID_B]             [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CATID_B]              [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LOGSYS_A]             [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ARCH_A]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LOGSYS_B]             [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ARCH_B]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UTCTIME]              [numeric](15, 0) NOT NULL,
		[HOMESYS]              [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NOT NULL,
		CONSTRAINT [PK_SRGBTBREL]
		PRIMARY KEY
		CLUSTERED
		([CodEmpresa], [CLIENT], [BRELGUID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_SRGBTBREL_7_477960779__K5_15]
	ON [dbo].[SRGBTBREL] ([INSTID_A])
	INCLUDE ([UTCTIME])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[SRGBTBREL] SET (LOCK_ESCALATION = TABLE)
GO
