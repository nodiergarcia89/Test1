SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DD07T] (
		[CodEmpresa]           [int] NOT NULL,
		[DOMNAME]              [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DDLANGUAGE]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AS4LOCAL]             [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VALPOS]               [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AS4VERS]              [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DDTEXT]               [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DOMVAL_LD]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DOMVAL_HD]            [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DOMVALUE_L]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_DD07T]
		PRIMARY KEY
		CLUSTERED
		([DOMNAME], [DDLANGUAGE], [AS4LOCAL], [VALPOS], [AS4VERS])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_DD07T_7_2014630220__K4_K2_K10_7]
	ON [dbo].[DD07T] ([AS4LOCAL], [DOMNAME], [DOMVALUE_L])
	INCLUDE ([DDTEXT])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DD07T] SET (LOCK_ESCALATION = TABLE)
GO
