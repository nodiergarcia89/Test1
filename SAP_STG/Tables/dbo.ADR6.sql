SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ADR6] (
		[CodEmpresa]           [int] NOT NULL,
		[CLIENT]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ADDRNUMBER]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PERSNUMBER]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DATE_FROM]            [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CONSNUMBER]           [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLGDEFAULT]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLG_NOUSE]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HOME_FLAG]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SMTP_ADDR]            [nvarchar](241) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SMTP_SRCH]            [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DFT_RECEIV]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[R3_USER]              [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ENCODE]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TNEF]                 [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VALID_FROM]           [nvarchar](14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VALID_TO]             [nvarchar](14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [_dta_index_ADR6_c_7_946102411__K2_K3]
	ON [dbo].[ADR6] ([CLIENT], [ADDRNUMBER])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_ADR6_7_946102411__K4]
	ON [dbo].[ADR6] ([PERSNUMBER])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_ADR6_7_946102411__K6_K2_K3_K4_10]
	ON [dbo].[ADR6] ([CONSNUMBER], [CLIENT], [ADDRNUMBER], [PERSNUMBER])
	INCLUDE ([SMTP_ADDR])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ADR6] SET (LOCK_ESCALATION = TABLE)
GO
